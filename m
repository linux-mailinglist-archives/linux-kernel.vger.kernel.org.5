Return-Path: <linux-kernel+bounces-28573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAD883002F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD0E1B22576
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA58F59;
	Wed, 17 Jan 2024 06:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zd1ue1dw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A0FB651;
	Wed, 17 Jan 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705473412; cv=none; b=HBsfe/Uct7zhEFQLGH8tPoUrHJIB3SNPzcKI3yU91SIgAfkTWwaVe7NLltUG4r6pZ4QHzGcM68s9lTcJue5AUOzXuPmAUegxc9aczlMA5cC8sSSgk7fKmdfFHHrK1zjfOCX5+2oG9yNqELlDBPmD4+qhSZO8Xp4btN0znxx8lkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705473412; c=relaxed/simple;
	bh=VV4dp+RbyGiT3Z7UAVuryejNmtVzVqCwKtZ0GaYgUVE=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=uyGLLXtM7DgTnfCUxA1teSVJldIPRjI5z/jYAoQuwqsAir9L8+0Ekpd/43i9YdM8JuJuK1VXzuX+cVzgDGWzBw1W4KVVQON7HSO7n9HL8xwiD3WAylvJB1xixbFs+kwyVM54x9IrpAxe+OXNBqdtqhiPz5zt238s6gC34DQYy9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zd1ue1dw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H6AHPj029207;
	Wed, 17 Jan 2024 06:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GJFzbNiHc3BMuYQaiDz6iUr2YnnXUuvPJOLqQjYLW8Q=; b=Zd
	1ue1dwCa5CMc4PBAni2UznEVFa5SYYs1qMiBthTHm5NyJOwgdcbG6upPrMrFDvNg
	LGxD/uOBSu3U3Rc3Z0hw53ZsdFmWhhjD4v+3KZT38owNClNXlUOQ+6JCo4stmL3F
	UrJ0Ap3wtdAWWRv81D9ZMnanK+P8XwG5AEk+kBA/fQJ6ZDC0EBszoLqbVDiFIije
	6UyWGcOSIRXv4cAK1kgR97xGdjA7MNtGrbiTQ8RvrFwJNCIXjd+Yc9iKN45Pi93j
	yLiIwIEKnF7xEOhsQF6QKtGnTH+Ob5IJvFNM87qqJt2J70/Uet8hPsbMeUcWlCyQ
	0I2VqyKUj/0/7xan8L7Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp83fr6hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:36:48 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H6alE1031341
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 06:36:47 GMT
Received: from [10.218.39.189] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 22:36:45 -0800
Message-ID: <34621658-0626-82cc-a641-3c25af3ea9f3@quicinc.com>
Date: Wed, 17 Jan 2024 12:06:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
 <20240117011859.dv5d27cf7qhwxuxf@synopsys.com>
From: UTTKARSH AGGARWAL <quic_uaggarwa@quicinc.com>
In-Reply-To: <20240117011859.dv5d27cf7qhwxuxf@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _4ZAtqTBJcl__0-89j-KzrQJF1Evtg8t
X-Proofpoint-GUID: _4ZAtqTBJcl__0-89j-KzrQJF1Evtg8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_02,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=640 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401170044


On 1/17/2024 6:49 AM, Thinh Nguyen wrote:
> Do you have the dmesg log of this NULL pointer dereference?
> Thanks,
> Thinh

Hi Thinh,

Here is the dmesg log:

[  149.524338][  T843] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000028
…
[  149.525872][  T843] Workqueue: pm pm_runtime_work
[  149.525886][  T843] pstate: 824000c5 (Nzcv daIF +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[  149.525893][  T843] pc : dwc3_gadget_suspend+0x4c/0xb8
[  149.525900][  T843] lr : dwc3_gadget_suspend+0x34/0xb8
…
[  149.526003][  T843] Call trace:
[  149.526008][  T843]  dwc3_gadget_suspend+0x4c/0xb8
[  149.526015][  T843]  dwc3_suspend_common+0x58/0x230
[  149.526021][  T843]  dwc3_runtime_suspend+0x34/0x50
[  149.526027][  T843]  pm_generic_runtime_suspend+0x40/0x58
[  149.526034][  T843]  __rpm_callback+0x94/0x3e0
[  149.526040][  T843]  rpm_suspend+0x2e4/0x720
[  149.526047][  T843]  __pm_runtime_suspend+0x6c/0x100
[  149.526054][  T843]  dwc3_runtime_idle+0x48/0x64
[  149.526060][  T843]  rpm_idle+0x20c/0x310
[  149.526067][  T843]  pm_runtime_work+0x80/0xac
[  149.526075][  T843]  process_one_work+0x1e4/0x43c
[  149.526084][  T843]  worker_thread+0x25c/0x430
[  149.526091][  T843]  kthread+0x104/0x1d4
[  149.526099][  T843]  ret_from_fork+0x10/0x20
  
=======================================================
Process: adbd, [affinity: 0xff] cpu: 6 pid: 4907 start: 0xffffff888079b840
=====================================================
    Task name: adbd [affinity: 0xff] pid: 4907 cpu: 6 prio: 120 start: ffffff888079b840
    state: 0x2[D] exit_state: 0x0 stack base: 0xffffffc02db20000
    Last_enqueued_ts:     149.523808841 Last_sleep_ts:     149.523859362
    Stack:
    [<ffffffc0091cd558>] __switch_to+0x174
    [<ffffffc0091cdd40>] __schedule+0x5ec
    [<ffffffc0091ce19c>] schedule+0x7c
    [<ffffffc0091d7438>] schedule_timeout+0x44
    [<ffffffc0091ce858>] wait_for_common+0xd8
    [<ffffffc0091ce774>] wait_for_completion+0x18
    [<ffffffc0082b23dc>] kthread_stop+0x78
    [<ffffffc0083134a0>] free_irq+0x184
    [<ffffffc008bc7438>] dwc3_gadget_stop+0x40
    [<ffffffc008c12228>] gadget_unbind_driver+0xfc
    [<ffffffc008ab76ac>] device_release_driver_internal[jt]+0x1d4
    [<ffffffc008ab78dc>] driver_detach+0x90
    [<ffffffc008ab519c>] bus_remove_driver+0x78
    [<ffffffc008ab9170>] driver_unregister[jt]+0x44
    [<ffffffc008c11838>] usb_gadget_unregister_driver+0x20
    [<ffffffc008c0c1e0>] unregister_gadget_item+0x30
    [<ffffffc008c256a8>] ffs_data_clear[jt]+0x88

Thanks,

Uttkarsh


