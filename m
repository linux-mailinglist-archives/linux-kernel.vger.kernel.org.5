Return-Path: <linux-kernel+bounces-20248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9EE827C69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 02:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB6D1C23199
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 01:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F415A4;
	Tue,  9 Jan 2024 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EpeXGelN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A34A49;
	Tue,  9 Jan 2024 01:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4090eVOA023723;
	Tue, 9 Jan 2024 01:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=qB7JK/rvHV/oMoLxNfOgyhrs98zc89tbNG9XG8X+Hi0=; b=Ep
	eXGelN/Uh5iU1xIZ90UmahpgUmni4+UPLqTLEaTmxEob6kTHCfJLF3rkua97MwRw
	2iZSKkNwXdwuA+14YenL23iTlcKwnBW97Ij+6y1FPZayXZmKVkB9lZvzfdE2GWwl
	D9LOsqkE65l+hHnxAid4IgpTFp+vEOah6TfuSPhETdr7oTeHTctKmLMauIP8tNlt
	YNGgzeK26DL1WGZA8FCY4ySbyGetEBHTDaCUcSQC4JKAaY0/U5B+n0PO7oOP0m7M
	Vu1V5KkDt3s3PP4lyur+kg6Qfcq/fNSSgo+NUl2d1LufeMzvXfxMarCjEYOKH5oR
	ZMrIElIBNdk3nNJCDHJg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgkkh962x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 01:12:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4091CWWP021026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 01:12:32 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 8 Jan
 2024 17:12:31 -0800
Message-ID: <79851641-8b56-4d25-b4c9-2d56a5bf41e9@quicinc.com>
Date: Mon, 8 Jan 2024 17:12:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: Pass proper arguments to scm call
Content-Language: en-US
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        stable
	<stable@kernel.org>
References: <20240108100513.19993-1-quic_ekangupt@quicinc.com>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20240108100513.19993-1-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OK__ZbRzyjVHWeDIwxlQFIGchDtepcbW
X-Proofpoint-ORIG-GUID: OK__ZbRzyjVHWeDIwxlQFIGchDtepcbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090005



On 1/8/2024 2:05 AM, Ekansh Gupta wrote:
> For CMA memory allocation, ownership is assigned to DSP to make it
> accessible by the PD running on the DSP. With current implementation
> HLOS VM is stored in the channel structure during rpmsg_probe and
> this VM is passed to qcom_scm call as the source VM.
> 
> The qcom_scm call will overwrite the passed source VM with the next
> VM which would cause a problem in case the scm call is again needed.
> Adding a local copy of source VM whereever scm call is made to avoid
> this problem.
> 

The perms in fastrpc_channel_ctx should always reflect the current
permission bits, so I'm surprised you see problem.

What is the scenario where that's not the case?

> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 1c6c62a7f7f5..c13efa7727e0 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -263,7 +263,6 @@ struct fastrpc_channel_ctx {
>  	int domain_id;
>  	int sesscount;
>  	int vmcount;
> -	u64 perms;
>  	struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
>  	struct rpmsg_device *rpdev;
>  	struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
> @@ -1279,9 +1278,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>  
>  		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
>  		if (fl->cctx->vmcount) {
> +			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> +
>  			err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>  							(u64)fl->cctx->remote_heap->size,
> -							&fl->cctx->perms,
> +							&src_perms,
>  							fl->cctx->vmperms, fl->cctx->vmcount);
>  			if (err) {
>  				dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
> @@ -1915,8 +1916,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>  
>  	/* Add memory to static PD pool, protection thru hypervisor */
>  	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
> +		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
> +
>  		err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
> -			&fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
> +			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
>  		if (err) {
>  			dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
>  					buf->phys, buf->size, err);
> @@ -2290,7 +2293,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  
>  	if (vmcount) {
>  		data->vmcount = vmcount;
> -		data->perms = BIT(QCOM_SCM_VMID_HLOS);
>  		for (i = 0; i < data->vmcount; i++) {
>  			data->vmperms[i].vmid = vmids[i];
>  			data->vmperms[i].perm = QCOM_SCM_PERM_RWX;

