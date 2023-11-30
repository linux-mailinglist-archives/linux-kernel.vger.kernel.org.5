Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33977FE5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343908AbjK3BNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:13:42 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B701010D3;
        Wed, 29 Nov 2023 17:13:48 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ATNrP9J024967;
        Thu, 30 Nov 2023 01:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6yv3opTbdqEOXIiRaS97Y2/3abioYf/e0ETT1lb93OU=;
 b=XjR+/m6Cgdnkk+B5VDF7sk6crf/opjdl7mlih7FRo6M8CPXdFwWQVgRiZGCmKOwJKAGM
 mvuKeAcHsvY+WZav28pQqC6+eiIY1xupVkoshl0A2ecTcUvCnoC+f2BR1RndoGxLpQxv
 25J9fScR2zMCI7BphOjClk577h8uLtQ3lAbrADaDgvJ4FLGhyeNinx97gypepXgrVP/N
 Z1z7DFtJzr8jEOtbt723dbiBN/Sr7rb/QgLiisRBKl/OxRrMVShZvxpgighpX9NvksDG
 DSnN6CrCLW3f2DknDN2Qvy1GewjtJ3ZdmKu77wA5oYhNoTsG5nP6rBwtoKINXUdopuPi DQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3up1gtac49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:13:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AU1Djcp018443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 01:13:45 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 29 Nov
 2023 17:13:41 -0800
Message-ID: <5918c20b-233a-4a2a-bb22-5c153e72c6b1@quicinc.com>
Date:   Thu, 30 Nov 2023 09:13:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: correct incorrect address offset
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <linus.walleij@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231129100422.16659-1-quic_tengfan@quicinc.com>
 <20231129100422.16659-3-quic_tengfan@quicinc.com>
 <09f46b92-edb0-4edd-aaf0-c6e685e2acae@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <09f46b92-edb0-4edd-aaf0-c6e685e2acae@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9jGP1ndHlcZOKyJ_UeKJQ4RPZlXrjA-_
X-Proofpoint-ORIG-GUID: 9jGP1ndHlcZOKyJ_UeKJQ4RPZlXrjA-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-29_21,2023-11-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=386 classifier=spam adjust=0 reason=mlx scancount=1
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



在 11/29/2023 9:32 PM, Konrad Dybcio 写道:
> On 29.11.2023 11:04, Tengfei Fan wrote:
>> The address offset of 0x100000 is already provided in SM4450 DTSI, so
>> subtract 0x100000 from the offset which used by ufs and sdc.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
> The change seems correct.
> 
> Looks like the pinctrl has not been merged, so these patches should
> be merged into the "Add SM4450 pinctrl driver" series and resent
> as another revision
> 
> Konrad
> 
> 
Sure, I will merge these pacthes into the "Add SM4450 pinctrl driver" 
series and resent new version patch series.

-- 
Thx and BRs,
Tengfei Fan
