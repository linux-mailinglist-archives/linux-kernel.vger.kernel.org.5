Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CAB7628FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjGZDAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGZDAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:00:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604B5DD;
        Tue, 25 Jul 2023 20:00:17 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q1wG3X004351;
        Wed, 26 Jul 2023 03:00:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TRhcpHmfH84VaKerw/NYkGhK9OkFCMUK2vCocw+fTt4=;
 b=dGqf1rD/mNg6+OJ018/3DphGELfN13IjwaKJRUi2pk6KC7PwBH4DO1HUJeNw9jVxbhay
 zusCKy6adMt11iXI+RlaJuS8bNWqpRc0vysBIRm4Os6mafPHaEv5XVBFI0Hk4TmgAKvR
 eapOFoQpF+ekJKoDLtk/h69jePS0Ac5On1+TstpbKD4i8CWjare6zO9egIS2Pr2xx8YS
 Kjbs8dAO/zSnk4OJ0Y1uz2NA1bcbTsUqxzx5WB5dhXlWirfxmkvXpZ+uz3ZGkXSCvTNr
 XKtGadC/rcfDwOiYrNwnQ43Okad832pCIgiC6Ndx/pT3W9e8lV/L4USfeGROJfxQzUQl ig== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1s9rw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 03:00:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q30BZB016985
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 03:00:11 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 20:00:10 -0700
Message-ID: <e457b416-3e63-0bae-0cd7-7788b43f30c1@quicinc.com>
Date:   Tue, 25 Jul 2023 21:00:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH][next] accel/qaic: remove redundant assignment to pointer
 pexec
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>,
        Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230725114037.36806-1-colin.i.king@gmail.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20230725114037.36806-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3MC3o76mhSwtPg4ThrG2kUqC93NvcWlF
X-Proofpoint-ORIG-GUID: 3MC3o76mhSwtPg4ThrG2kUqC93NvcWlF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260024
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/2023 5:40 AM, Colin Ian King wrote:
> Pointer pexec is being assigned a value however it is never read. The
> assignment is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/accel/qaic/qaic_data.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> index e9a1cb779b30..8a6cb14f490e 100644
> --- a/drivers/accel/qaic/qaic_data.c
> +++ b/drivers/accel/qaic/qaic_data.c
> @@ -1320,7 +1320,6 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
>   	user_data = u64_to_user_ptr(args->data);
>   
>   	exec = kcalloc(args->hdr.count, size, GFP_KERNEL);
> -	pexec = (struct qaic_partial_execute_entry *)exec;
>   	if (!exec)
>   		return -ENOMEM;
>   

It does look like pexec is not used in this function after it was 
refactored.  Shouldn't the declaration at the beginning of the function 
also be removed?
