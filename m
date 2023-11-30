Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280E27FE57C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjK3BLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:11:39 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD656122;
        Wed, 29 Nov 2023 17:11:45 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATMe4ZG026170;
        Thu, 30 Nov 2023 01:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Bsz3IXVIrE1FIVFVlafauAQU9rutTsW40vGJ4o+YjeE=;
 b=G3J+8R4n3CIcLnDRdnad+QBDc4UzHsSm6LfeFnVMTY5TIAkQHAVrnyzt2ZaEDDlIeUBj
 tEyqqsedhJwjuYt+/5o7uJRymXELMxZoiRED5WIABRkSoV++mAHj8JhLu6uInaaQsyNy
 2LAb3eke2sFxqYBN6dgbwQFyq4cedMLlQ5S8I14rBhkLWwZpfn2TwkCJpPnLFMjm3iur
 7ClgWVA17VO1y7iiSzhAmh7xGJ8Flo9XEOEMYaf3XkcGHIczv6/tneOvuyabP0A4Bt2Y
 JSo9VS3tRxEL7XDPw9aT8EBanS+MT9aAA/24jt7qhDi8lqdE1tk4Djy2s3HQ6O3u8DdY OQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3unjdtmn85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:11:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU1BdtU025754
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:11:39 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 17:11:35 -0800
Message-ID: <2958722e-94b9-46d1-9f0c-3fc241a3e633@quicinc.com>
Date:   Thu, 30 Nov 2023 09:11:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pinctrl: qcom: Convert to platform remove callback
 returning void
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231129100422.16659-1-quic_tengfan@quicinc.com>
 <20231129100422.16659-2-quic_tengfan@quicinc.com>
 <2d6c7d2e-c8f5-4e7f-901a-8ca208d7b442@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <2d6c7d2e-c8f5-4e7f-901a-8ca208d7b442@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Md7LtClVXWDEH3M5qc1GtzyRnsNI8bGG
X-Proofpoint-ORIG-GUID: Md7LtClVXWDEH3M5qc1GtzyRnsNI8bGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311300007
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 11/29/2023 9:21 PM, Konrad Dybcio 写道:
> On 29.11.2023 11:04, Tengfei Fan wrote:
>> Use .remove_new() instead of .remove() for converting to plarform remove
> s/plarform/platform
> 
>> callback returning void.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> The commit title should include the platform name, i.e.
> pinctrl: qcom: sm4450: xxx
> 
> The change itself looks good
> 
> Konrad
Thanks Konrad review this patch, I will update patch as your comments.

-- 
Thx and BRs,
Tengfei Fan
