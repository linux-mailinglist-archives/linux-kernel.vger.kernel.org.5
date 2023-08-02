Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF2776CF24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjHBNrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjHBNrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:47:46 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF661DC;
        Wed,  2 Aug 2023 06:47:44 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3726s2vH013348;
        Wed, 2 Aug 2023 13:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=T5Kn0b8Tk5/QRWDBWF7PBQnW/GYQDwyH0epgodDC+FU=;
 b=ouwS7Sr9tB7vHuBGOX1+f0QPO0uvH2NzbskmVE1gSyZCpxbDYkRaDTe36SyLRsSJSNF3
 iIHbjG14M5jIENn/JCnJ/sefX6bmwZqvIJS57NHdtsvoEZvVDsbO6xjFvjQVuRYhlCEh
 VLSLE4YQDKUFz1FLpXDvKqJCaNPVkG3jnN5yy+2oPXpGCzC7Hq6j0e1pW2CE8SsuK+NX
 0WgdRphS9d54leesCLwtwG2hGiEMpNs47wWm91pfJz12fxx8dKdeeJ2gGByFx+t9nIQq
 Fjrp/+66fDDGJPgvtqMkXPqsG5aeUunzfsVHmT9VQF/eAbIrZXO94tlwi5CPwiL5ONK2 8w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s7fre1env-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 13:47:40 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372DldfW025815
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 13:47:39 GMT
Received: from [10.204.67.150] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 06:47:36 -0700
Message-ID: <c34920cc-1462-b12a-82e7-4b5f8a13f4e8@quicinc.com>
Date:   Wed, 2 Aug 2023 19:17:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] misc: fastrpc: Pass proper scm arguments for static
 process init
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <ekangupt@qti.qualcomm.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <fastrpc.upstream@qti.qualcomm.com>, stable <stable@kernel.org>
References: <1690952549-31819-1-git-send-email-quic_ekangupt@quicinc.com>
 <1dfd407d-2c75-0154-947a-3f1783017444@linaro.org>
From:   Ekansh Gupta <quic_ekangupt@quicinc.com>
In-Reply-To: <1dfd407d-2c75-0154-947a-3f1783017444@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MeeOOA4erBm2M3muBgMRPGh_LE-rv4zR
X-Proofpoint-ORIG-GUID: MeeOOA4erBm2M3muBgMRPGh_LE-rv4zR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308020122
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 7:07 PM, Srinivas Kandagatla wrote:
> 
> 
> On 02/08/2023 06:02, Ekansh Gupta wrote:
>> Memory is allocated for dynamic loading when audio daemon is trying
>> to attach to audioPD on DSP side. This memory is allocated from
>> reserved CMA memory region and needs ownership assignment to
>> new VMID in order to use it from audioPD.
>>
>> In the current implementation, arguments are not correctly passed
>> to the scm call which might result in failure of dynamic loading
>> on audioPD. Added changes to pass correct arguments during daemon
>> attach request.
>>
>> Fixes:     0871561055e6 ("misc: fastrpc: Add support for audiopd")
>> Cc: stable <stable@kernel.org>
>> Tested-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
>> ---
>> Changes in v2:
>>    - Removed redundant code
>> Changes in v3:
>>    - Reuse channel context perms for source perms
>>
>>   drivers/misc/fastrpc.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 30d4d04..5a1268f 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -1280,8 +1280,7 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>           if (fl->cctx->vmcount) {
>>               err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>>                               (u64)fl->cctx->remote_heap->size,
>> -                            &fl->cctx->perms,
>> -                            fl->cctx->vmperms, fl->cctx->vmcount);
>> +                            &fl->cctx->perms, fl->cctx->vmperms, 
>> fl->cctx->vmcount);
> 
> this change does not look correct,  Looks totally like converting 
> multiple lines to a single line.
Thanks for pointing this out, I might have missed keeping the correct 
formatting while reverting the change. I will update this in next patch.
> 
> --srini
> 
>>               if (err) {
>>                   dev_err(fl->sctx->dev, "Failed to assign memory with 
>> phys 0x%llx size 0x%llx err %d",
>>                       fl->cctx->remote_heap->phys, 
>> fl->cctx->remote_heap->size, err);
>> @@ -1322,13 +1321,18 @@ static int 
>> fastrpc_init_create_static_process(struct fastrpc_user *fl,
>>       return 0;
>>   err_invoke:
>>       if (fl->cctx->vmcount) {
>> -        struct qcom_scm_vmperm perm;
>> +        u64 src_perms = 0;
>> +        struct qcom_scm_vmperm dst_perms;
>> +        u32 i;
>> -        perm.vmid = QCOM_SCM_VMID_HLOS;
>> -        perm.perm = QCOM_SCM_PERM_RWX;
>> +        for (i = 0; i < fl->cctx->vmcount; i++)
>> +            src_perms |= BIT(fl->cctx->vmperms[i].vmid);
>> +
>> +        dst_perms.vmid = QCOM_SCM_VMID_HLOS;
>> +        dst_perms.perm = QCOM_SCM_PERM_RWX;
>>           err = qcom_scm_assign_mem(fl->cctx->remote_heap->phys,
>>                           (u64)fl->cctx->remote_heap->size,
>> -                        &fl->cctx->perms, &perm, 1);
>> +                        &src_perms, &dst_perms, 1);
>>           if (err)
>>               dev_err(fl->sctx->dev, "Failed to assign memory phys 
>> 0x%llx size 0x%llx err %d",
>>                   fl->cctx->remote_heap->phys, 
>> fl->cctx->remote_heap->size, err);
