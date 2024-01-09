Return-Path: <linux-kernel+bounces-21194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4098D828B8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585731C23703
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B03BB2D;
	Tue,  9 Jan 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="p0BtbpMm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01773B796;
	Tue,  9 Jan 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409HDTKf015085;
	Tue, 9 Jan 2024 17:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=df2bpcTkA2YoQF8C0twkiKVvQVi/CLaa4ZuoZBl7OY4=; b=p0
	BtbpMmZmc7oGmYTSmn8oltx5rOkXRB7BbmjetyBU2cs6oob0tZ8NiFGUuEc4zST+
	Ex/BLBer1UnszygMmonqVfiefFbHW0ppMlu1rl0E81JtoOXWtDtM/e5hw39WcU3c
	MBaca7r15TVcimw+ylBAHJjRJHUwpEYFMyBwxbrU3LE8comOOAN5T2spikfgcSEg
	8Vc4wOeeHwWyLMoXanmcqGOHffhIjWoRFCi5CEm5uuifKvWsTYXWEQM/razUBYSx
	nsVmBXzHJDKXxxvOk7KYhTQvmaYypiLDngsO8TbJbRpAn/mxgltx0Fsr2h6beuR7
	ncm3ciAw8Zxx922fPw1A==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9vfg5nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 17:55:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Ht1Gk008599
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 17:55:02 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 09:55:00 -0800
Message-ID: <00a337d0-a82a-43cd-a106-dfe1ac5f9a11@quicinc.com>
Date: Tue, 9 Jan 2024 09:55:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: Pass proper arguments to scm call
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        stable
	<stable@kernel.org>
References: <20240108100513.19993-1-quic_ekangupt@quicinc.com>
 <79851641-8b56-4d25-b4c9-2d56a5bf41e9@quicinc.com>
 <04500984-6bc0-4a07-9940-235e4b932172@quicinc.com>
Content-Language: en-US
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <04500984-6bc0-4a07-9940-235e4b932172@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gw3Hmph0ocKtwh3dwBk8R0yPiyREGP8F
X-Proofpoint-ORIG-GUID: Gw3Hmph0ocKtwh3dwBk8R0yPiyREGP8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090145



On 1/8/2024 9:38 PM, Ekansh Gupta wrote:
> 
> On 1/9/2024 6:42 AM, Elliot Berman wrote:
>>
>> On 1/8/2024 2:05 AM, Ekansh Gupta wrote:
>>> For CMA memory allocation, ownership is assigned to DSP to make it
>>> accessible by the PD running on the DSP. With current implementation
>>> HLOS VM is stored in the channel structure during rpmsg_probe and
>>> this VM is passed to qcom_scm call as the source VM.
>>>
>>> The qcom_scm call will overwrite the passed source VM with the next
>>> VM which would cause a problem in case the scm call is again needed.
>>> Adding a local copy of source VM whereever scm call is made to avoid
>>> this problem.
>>>
>> The perms in fastrpc_channel_ctx should always reflect the current
>> permission bits, so I'm surprised you see problem.
>>
>> What is the scenario where that's not the case?
> 
> Thanks for reviewing the changes, Elliot. FastRPC driver is storing
> the bitfield of HLOS VMID in fastrpc_channel_ctx in perms(cctx->perms)
> and remoteproc specific VMID information from device tree in vmperms(cctx->vmperms).
> This information is intended to be passed to qcom_scm call when there is
> a requirement to move the ownership of memory to any remoteproc VM. As
> the srcvm is overwritten with the new VM, cctx->perms cannot be reused if
> the same request comes for any other memory allocation.
> 
> The problem is seen with audioPD daemon. When the daemon is stated, it
> allocates some memory for audioPD and moves the ownership from HLOS to
> ADSP VM using qcom_scm call. After this, audioPD makes a request for some
> more memory which is again allocated in kernel and as per current
> implementation, qcom_scm call is again made with cctx->perms as srcVm
> which is no longer storing HLOS vmid. Hence using a local variable to
> make qcom_scm call where there is a need to move ownership from HLOS
> to remoteproc VM.
> 
> Please let me know if you have any more queries.
> 

Ah, got it. There can be multiple allocations/assignments per fastrpc_channel_ctx.

In that case:

Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>

> --ekansh
> 
>>
>>> Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")> Cc: stable <stable@kernel.org>
>>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>>> ---
>>>   drivers/misc/fastrpc.c | 10 ++++++----
>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 1c6c62a7f7f5..c13efa7727e0 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -263,7 +263,6 @@ struct fastrpc_channel_ctx {
>>>       int domain_id;
>>>       int sesscount;
>>>       int vmcount;
>>> -    u64 perms;
>>>       struct qcom_scm_vmperm vmperms[FASTRPC_MAX_VMIDS];
>>>       struct rpmsg_device *rpdev;
>>>       struct fastrpc_session_ctx session[FASTRPC_MAX_SESSIONS];
>>> @@ -1279,9 +1278,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>>             /* Map if we have any heap VMIDs associated with this ADSP Static Process. */
>>>           if (fl->cctx->vmcount) {
>>> +            u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>> +
>>>               err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>>>                               (u64)fl->cctx->remote_heap->size,
>>> -                            &fl->cctx->perms,
>>> +                            &src_perms,
>>>                               fl->cctx->vmperms, fl->cctx->vmcount);
>>>               if (err) {
>>>                   dev_err(fl->sctx->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d",
>>> @@ -1915,8 +1916,10 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>>>         /* Add memory to static PD pool, protection thru hypervisor */
>>>       if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
>>> +        u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
>>> +
>>>           err = qcom_scm_assign_mem(buf->phys, (u64)buf->size,
>>> -            &fl->cctx->perms, fl->cctx->vmperms, fl->cctx->vmcount);
>>> +            &src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
>>>           if (err) {
>>>               dev_err(fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d",
>>>                       buf->phys, buf->size, err);
>>> @@ -2290,7 +2293,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>>         if (vmcount) {
>>>           data->vmcount = vmcount;
>>> -        data->perms = BIT(QCOM_SCM_VMID_HLOS);
>>>           for (i = 0; i < data->vmcount; i++) {
>>>               data->vmperms[i].vmid = vmids[i];
>>>               data->vmperms[i].perm = QCOM_SCM_PERM_RWX;

