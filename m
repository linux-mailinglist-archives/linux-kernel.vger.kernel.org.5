Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD85B762252
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjGYTeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGYTeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:34:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FE31FF5;
        Tue, 25 Jul 2023 12:33:57 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PHoDGG009819;
        Tue, 25 Jul 2023 19:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9j+VHchYnzk6UoD4RPYxVil4eIwt8y1eekFEsiJS2ew=;
 b=XVvpPWiJxpc1DCO2/yTQ2xmeYbdpD7SCiNxaHFwiHLFKsrmAez2566zM2SBnfy1x9Gr6
 z2LtF7ms8Y8vDfSZD16CT8TgL6VUpW4OocCaW79CI+RUE3V7Im8guLQOGWfo68iqSAp5
 7w09TtOTi3T+2XXah5JBReMVz+j83309IV8/qhLG7uZp1TJywIBorUJO6W2whyWNMfdM
 dx4qLixrPLamz3GFSb483oMoHZskjobjTN7A7EJFYHQK8kUhpGnpeM6lLb5fhwzS73lC
 qJM2/rRdYD2UFW1xPuVxjuzBUJv4gOIUOxMY2+w557STdvDa6FlyhfFCWCR6izT0VAPM uw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2gp1rjvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:33:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36PJXglB012437
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 19:33:42 GMT
Received: from [10.110.48.89] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 12:33:41 -0700
Message-ID: <bf8bab0c-3081-91e0-5dbc-658aa8bab68a@quicinc.com>
Date:   Tue, 25 Jul 2023 12:33:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/7] Add support for LUT PPG
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
 <CTMFUY0GPRNK.532E4O05LWKW@otso>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <CTMFUY0GPRNK.532E4O05LWKW@otso>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nMag38QmBZyIbEOXDgw7hhKPmH-nvB9u
X-Proofpoint-ORIG-GUID: nMag38QmBZyIbEOXDgw7hhKPmH-nvB9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_10,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=841 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250167
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/2023 1:28 AM, Luca Weiss wrote:
> Hi Anjelique,
> 
> On Wed Jun 21, 2023 at 8:59 PM CEST, Anjelique Melendez wrote:
>> In certain PMICs, LUT pattern and LPG configuration can be stored in SDAM
>> modules instead of LUT peripheral. This feature is called PPG.
>>
>> This change series adds support for PPG. Thanks!
> 
> Thanks for sending this series!
> 
> I've tested this on SDM632 Fairphone 3 and everything appears to work
> fine with setting the pattern. Using fbcli from feedbackd[0] the pattern
> shows up correctly.
> 
> The only thing missing really is the addition of the pbs node and adding
> the nvmem/nvmem-names & qcom,pbs-client to the lpg node in pmi632.dtsi -
> something like the patch below.
> 
> Are you planning to include this in the next revision? Otherwise I can
> also send a patch for the pmi632.dtsi after this series has landed.
> 
> Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3 (pmi632)
> 
> [0] https://source.puri.sm/Librem5/feedbackd
> 
> Regards
> Luca
> 

Hi Luca,

So sorry for the late response, I missed this message! Thank you for testing!

I was not planning to include adding the pbs node or updating lpg node in pmi632.dtsi.
If you are able to send a patch for pmi632.dtsi after that would be great!

Thanks,
Anjelique


