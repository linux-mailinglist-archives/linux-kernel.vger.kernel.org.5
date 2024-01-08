Return-Path: <linux-kernel+bounces-20168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A80A8827AF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78786B2184E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED59A54BD7;
	Mon,  8 Jan 2024 22:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BPsxKdTV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D442EB12;
	Mon,  8 Jan 2024 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 408Mt7l4018882;
	Mon, 8 Jan 2024 22:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=su+POoieKLZuHaLd5PDFDvsu4Exogpo+zfB5vy+pigY=; b=BP
	sxKdTVCOe1JhacUgMU2whAewPagzA0ODXHIV20W3H2fMyyF+zaeRoCQhfQjZlS5C
	A53flFN/LMKnLDffdX9SQKMChhT5ctfRLIz5c8Uhe4V64zpPZDeqKXe8PTqp6F0r
	UB5FgbRflKtHECmvIS1SABsPt9yTYzK8PesC5sE9BdvNyR9P7si6uqRVJgF5botb
	Spyk0QK8luzGPMHIa1GNLSND7MbAeMrw34fA5oRy/Wn5UrYOBhn604Whw/gPPgiR
	R1ENks5ePzMmHwT+eKmq79+4CgxrPEip7CVvTC2mC3ZJRDq6/DMmpGRkL2goLihv
	6vxTYbC56nNVhp9mPH1A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgr1sg8ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 22:58:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 408MwIjQ012918
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jan 2024 22:58:18 GMT
Received: from [10.110.115.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 14:58:17 -0800
Message-ID: <454873e5-1b5a-28d3-ffed-c1e502898d17@quicinc.com>
Date: Mon, 8 Jan 2024 14:58:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/ci: Add msm tests
Content-Language: en-US
To: Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC: <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob
 Clark <robdclark@chromium.org>,
        Helen Koike <helen.koike@collabora.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20240108195016.156583-1-robdclark@gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240108195016.156583-1-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2vwmCTwWDLEip4HRwfQMuvtrn_QoK73J
X-Proofpoint-GUID: 2vwmCTwWDLEip4HRwfQMuvtrn_QoK73J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401080187



On 1/8/2024 11:50 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> The msm tests should skip on non-msm hw, so I think it should be safe to
> enable everywhere.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/ci/testlist.txt | 49 +++++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 

I do see that all these tests use igt_msm_dev_open() to make sure it 
opens only the MSM card.

But if igt_msm_dev_open() fails, I dont see a igt_require() on some of 
the tests to skip them. So how will it safely skip on non-msm HW?

Unless i am missing something here ....

> diff --git a/drivers/gpu/drm/ci/testlist.txt b/drivers/gpu/drm/ci/testlist.txt
> index f82cd90372f4..eaeb751bb0ad 100644
> --- a/drivers/gpu/drm/ci/testlist.txt
> +++ b/drivers/gpu/drm/ci/testlist.txt
> @@ -2910,3 +2910,52 @@ kms_writeback@writeback-invalid-parameters
>   kms_writeback@writeback-fb-id
>   kms_writeback@writeback-check-output
>   prime_mmap_kms@buffer-sharing
> +msm_shrink@copy-gpu-sanitycheck-8
> +msm_shrink@copy-gpu-sanitycheck-32
> +msm_shrink@copy-gpu-8
> +msm_shrink@copy-gpu-32
> +msm_shrink@copy-gpu-madvise-8
> +msm_shrink@copy-gpu-madvise-32
> +msm_shrink@copy-gpu-oom-8
> +msm_shrink@copy-gpu-oom-32
> +msm_shrink@copy-mmap-sanitycheck-8
> +msm_shrink@copy-mmap-sanitycheck-32
> +msm_shrink@copy-mmap-8
> +msm_shrink@copy-mmap-32
> +msm_shrink@copy-mmap-madvise-8
> +msm_shrink@copy-mmap-madvise-32
> +msm_shrink@copy-mmap-oom-8
> +msm_shrink@copy-mmap-oom-32
> +msm_shrink@copy-mmap-dmabuf-sanitycheck-8
> +msm_shrink@copy-mmap-dmabuf-sanitycheck-32
> +msm_shrink@copy-mmap-dmabuf-8
> +msm_shrink@copy-mmap-dmabuf-32
> +msm_shrink@copy-mmap-dmabuf-madvise-8
> +msm_shrink@copy-mmap-dmabuf-madvise-32
> +msm_shrink@copy-mmap-dmabuf-oom-8
> +msm_shrink@copy-mmap-dmabuf-oom-32
> +msm_mapping@ring
> +msm_mapping@sqefw
> +msm_mapping@shadow
> +msm_submitoverhead@submitbench-10-bos
> +msm_submitoverhead@submitbench-10-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-100-bos
> +msm_submitoverhead@submitbench-100-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-250-bos
> +msm_submitoverhead@submitbench-250-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-500-bos
> +msm_submitoverhead@submitbench-500-bos-no-implicit-sync
> +msm_submitoverhead@submitbench-1000-bos
> +msm_submitoverhead@submitbench-1000-bos-no-implicit-sync
> +msm_recovery@hangcheck
> +msm_recovery@gpu-fault
> +msm_recovery@gpu-fault-parallel
> +msm_recovery@iova-fault
> +msm_submit@empty-submit
> +msm_submit@invalid-queue-submit
> +msm_submit@invalid-flags-submit
> +msm_submit@invalid-in-fence-submit
> +msm_submit@invalid-duplicate-bo-submit
> +msm_submit@invalid-cmd-idx-submit
> +msm_submit@invalid-cmd-type-submit
> +msm_submit@valid-submit

