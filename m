Return-Path: <linux-kernel+bounces-136054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFAC89CF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6049D1F23221
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C824688;
	Tue,  9 Apr 2024 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pd3cV1vU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DCB15D1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712623561; cv=none; b=Px4tfXcHQO6DuuKIezHR2BdxHRWCRMJ7KZ2Z/vk0ZzciIXFpo7Ax4nacvhN7RuJTC0SevsNwZqEjy9ME7V45Qn8p0hKEAZidEWgVCv9dpQ9NfBLREMiNTUIWlc/d/B8ZdUrL+puBEPHY1h0XhGFXf3A+NjyJezx+PJ0GbXBsr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712623561; c=relaxed/simple;
	bh=sD72hFBHonRg2YaMXPgB3a1zKvHJhBgcL8FT21EQkA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T9gR8bdWWg77VBBRwdlxyMLoxHps6dh+zCTwaZ7IopblpeeVkuVYVN0mmQJPRvouV7127mm43CiXZOzRgvmKnIxBHc7YxAkP+nGqQc5QJuDtE4RbartS/lxXY04FQC/DQXa98pu2SVVu8X30gTmTRNp2v0HSrawhYOkFFrm3hvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pd3cV1vU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4390Hnsk017506;
	Tue, 9 Apr 2024 00:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ci/G+DjtccXLqpS0mdh4EggoGuJdJseglyZfUDBAC5s=; b=Pd
	3cV1vUcGAhe6M7LlEdKsdWgGp/7aqTyoYNqq1IT2UgaY8AP6G1K/1rUbexKAz4RC
	zRGGtNtg0mZIahhhQe9AiFfV8JnrKzNun3NQJDHkxXJ52/AtJy0xnfG7mmDs6q5x
	+256vAcWcgCe7+cy0X+sTM9HWVwZiJSmTIROPnwZthSDYVi4plqATlUsyNFbMj+O
	BIqOOmawUIuOC7yH1w7mZOedDbYrhrDCkF/EF4lEKMJRRr1Y5bMAyyrBrzlk31F7
	8YmBmR0Eg0D4FuPR9lYPE7V+BYAwk88fpBmUmtJYXxqZ+UbVbLDqVAGtklhO6LcH
	E0PbUU+vWCIIwWeR5mjw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg02469-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 00:45:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4390jqVS010198
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 00:45:52 GMT
Received: from [10.81.24.74] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 17:45:52 -0700
Message-ID: <a619df03-e0cb-48f7-840a-970b7a6f6037@quicinc.com>
Date: Mon, 8 Apr 2024 17:45:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.5.5: UBSAN: radeon_atombios.c: index 1 is out of range for type
 'UCHAR [1]'
To: Justin Piszcz <jpiszcz@lucidpixels.com>,
        Bagas Sanjaya
	<bagasdotme@gmail.com>
CC: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Kees Cook
	<keescook@chromium.org>
References: <CAO9zADy4b1XkD_ZaEF+XkDCXePJLD4Lev3g7HAEGYsCHgeM+KQ@mail.gmail.com>
 <ZRoIGhMesKtmNkAM@debian.me>
 <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAO9zADyfaLRWB-0rdojnbFD6SUsqX+zb9JZSZUkgTC7VJN=c1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: blc3Mmi9aDJCgomrOI8OBCekisTS5QXk
X-Proofpoint-ORIG-GUID: blc3Mmi9aDJCgomrOI8OBCekisTS5QXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090000

On 10/1/23 17:12, Justin Piszcz wrote:
>>> ================================================================================
>>> [Sun Oct  1 15:59:04 2023] UBSAN: array-index-out-of-bounds in
>>> drivers/gpu/drm/radeon/radeon_atombios.c:2620:43
>>> [Sun Oct  1 15:59:04 2023] index 1 is out of range for type 'UCHAR [1]'
>>> [Sun Oct  1 15:59:04 2023] CPU: 5 PID: 1 Comm: swapper/0 Tainted: G
>>>              T  6.5.5 #13 55df8de52754ef95effc50a55e9206abdea304ac
>>> [Sun Oct  1 15:59:04 2023] Hardware name: Supermicro X9SRL-F/X9SRL-F,
>>> BIOS 3.3 11/13/2018
>>> [Sun Oct  1 15:59:04 2023] Call Trace:
>>> [Sun Oct  1 15:59:04 2023]  <TASK>
>>> [Sun Oct  1 15:59:04 2023]  dump_stack_lvl+0x36/0x50
>>> [Sun Oct  1 15:59:04 2023]  __ubsan_handle_out_of_bounds+0xc7/0x110
>>> [Sun Oct  1 15:59:04 2023]  radeon_atombios_get_power_modes+0x87a/0x8f0
>>> [Sun Oct  1 15:59:04 2023]  radeon_pm_init+0x13a/0x7e0
>>> [Sun Oct  1 15:59:04 2023]  evergreen_init+0x13d/0x3d0
>>> [Sun Oct  1 15:59:04 2023]  radeon_device_init+0x60a/0xbf0
>>> [Sun Oct  1 15:59:04 2023]  radeon_driver_load_kms+0xb1/0x250
>>> [Sun Oct  1 15:59:04 2023]  drm_dev_register+0xfc/0x250
>>> [Sun Oct  1 15:59:04 2023]  radeon_pci_probe+0xd0/0x150
>>> [Sun Oct  1 15:59:04 2023]  pci_device_probe+0x97/0x130
>>> [Sun Oct  1 15:59:04 2023]  really_probe+0xbe/0x2f0
>>> [Sun Oct  1 15:59:04 2023]  ? __pfx___driver_attach+0x10/0x10
>>> [Sun Oct  1 15:59:04 2023]  __driver_probe_device+0x6e/0x120
>>> [Sun Oct  1 15:59:04 2023]  driver_probe_device+0x1a/0x90
>>> [Sun Oct  1 15:59:04 2023]  __driver_attach+0xd4/0x170
>>> [Sun Oct  1 15:59:04 2023]  bus_for_each_dev+0x87/0xe0
>>> [Sun Oct  1 15:59:04 2023]  bus_add_driver+0xf3/0x1f0
>>> [Sun Oct  1 15:59:04 2023]  driver_register+0x58/0x120
>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_radeon_module_init+0x10/0x10
>>> [Sun Oct  1 15:59:04 2023]  do_one_initcall+0x93/0x4a0
>>> [Sun Oct  1 15:59:04 2023]  kernel_init_freeable+0x301/0x580
>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
>>> [Sun Oct  1 15:59:04 2023]  kernel_init+0x15/0x1b0
>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork+0x2f/0x50
>>> [Sun Oct  1 15:59:04 2023]  ? __pfx_kernel_init+0x10/0x10
>>> [Sun Oct  1 15:59:04 2023]  ret_from_fork_asm+0x1b/0x30
>>> [Sun Oct  1 15:59:04 2023]  </TASK>
>>> [Sun Oct  1 15:59:04 2023]
>>> ================================================================================
>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: dpm initialized
>>> [Sun Oct  1 15:59:04 2023] [drm] GART: num cpu pages 262144, num gpu
>>> pages 262144
>>> [Sun Oct  1 15:59:04 2023] [drm] enabling PCIE gen 2 link speeds,
>>> disable with radeon.pcie_gen2=0
>>> [Sun Oct  1 15:59:04 2023] [drm] PCIE GART of 1024M enabled (table at
>>> 0x000000000014C000).
>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: WB enabled
>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 0
>>> use gpu addr 0x0000000040000c00
>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 3
>>> use gpu addr 0x0000000040000c0c
>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: fence driver on ring 5
>>> use gpu addr 0x000000000005c418
>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: MSI limited to 32-bit
>>> [Sun Oct  1 15:59:04 2023] radeon 0000:03:00.0: radeon: using MSI.
>>> [Sun Oct  1 15:59:04 2023] [drm] radeon: irq initialized.
>>>
>>
>> Please also open an issue on freedesktop tracker [1].
>>
>> Thanks.
>>
>> [1]: https://gitlab.freedesktop.org/drm/amd/-/issues
> 
> Issue opened: https://gitlab.freedesktop.org/drm/amd/-/issues/2894
> 
> Regards,
> Justin

+Kees since I've worked with him on several of these flexible array issues.

I just happened to look at kernel logs today for my ath1*k driver 
maintenance and see the subject issue is present on my device, running 
6.9.0-rc1. The freedesktop issue tracker says the issue is closed, but 
any fix has not landed in the upstream kernel. Is there a -next patch 
somewhere?

[   12.105270] UBSAN: array-index-out-of-bounds in 
drivers/gpu/drm/radeon/radeon_atombios.c:2718:34
[   12.105272] index 48 is out of range for type 'UCHAR [1]'
[

If there isn't really an upstream fix, I can probably supply one.

/jeff

