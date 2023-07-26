Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453F57632C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjGZJub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjGZJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:50:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAAC12D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:50:22 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q6gfue019004;
        Wed, 26 Jul 2023 09:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KuVSHgAgRDjuHg8RkqGBB4Ro0r+xAp9VjlcedyeLIEU=;
 b=I/T/isHOpdx/rKdLz5DS693NZZdckuAVwA7ZxXyKWwtpkqEsEdiF4vXKlkSEP7xnYcV6
 wRKvZYRvXRjqATFgqodZOocuL3nwF5rhJwnlF0PDla8c9S5yqqkupTValWyPuNPPwSDx
 D/4JUPGTrUxzr1T0GJGxxEJVfhME1RwVsyaOn8IJmAjeRXK7TZY5g+Se4Aic8LUGFbLt
 1ss/VWQmfNfLO7n+0g6CZfgCAbIEsaxt+l9cEtm3j3mktl8WhgdWD4cSrlXuw+L+BhQs
 xVUKf6JEK4dpCQTDiJFHgw8z6tQrpwF0LyAvTz36xnDFGf74BNgbRL5pG+rHh5UxQxkA iw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s2v4tgjq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:50:03 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36Q9o05j024594
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 09:50:01 GMT
Received: from [10.252.212.151] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 02:49:40 -0700
Message-ID: <1945f748-fb71-f1c1-83a2-ba0470daf817@quicinc.com>
Date:   Wed, 26 Jul 2023 15:19:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Atheros 11K" <ath11k@lists.infradead.org>
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
 <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
 <16885654-09f0-c139-cc9b-c6c4d666932e@quicinc.com>
 <ae1ad814-5613-704e-b0b1-4f1fc4bead44@leemhuis.info>
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <ae1ad814-5613-704e-b0b1-4f1fc4bead44@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VzRycjP2x26XcFyN-zhvaSPiI_Pt9Vqy
X-Proofpoint-GUID: VzRycjP2x26XcFyN-zhvaSPiI_Pt9Vqy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_03,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=856 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307260086
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/26/2023 2:51 PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 25.07.23 11:17, Manikanta Pubbisetty wrote:
>> On 6/26/2023 6:19 PM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>
>>> Hmmm, there afaics was no real progress and not even a single reply from
>>> a developer (neither here or in bugzilla) since the issue was reported
>>> ~10 days ago. :-/
> 
> BTW: Kalle, many thx for picking this up and posting & applying the revert!
> 
>>> Manikanta, did you maybe just miss that this is caused by change of
>>> yours (and thus is something you should look into)?
>>
>> Extremely sorry for having this missed [...]
>>
>> Hi Sanjay, [...]
> 
> FWIW, Bagas Sanjaya just forwarded the report and the reporter is not
> CCed afaics (bugzilla privacy policy does not allow this, which
> complicates things a lot :-/ ). You have to use bugzilla to reach the
> reporter: https://bugzilla.kernel.org/show_bug.cgi?id=217536
> 

Sure, thanks Thorsten.
