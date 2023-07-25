Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F827760E36
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjGYJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjGYJST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:18:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEAE11B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:18:18 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P89KDW020373;
        Tue, 25 Jul 2023 09:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EtaXHcheHiL150xLPJfR+EAbk5fAJAvdft9o7hOW2yY=;
 b=ciDDADRbWoRWglcC0RkraVtgpHH8DB0HM1NPNAvQ4DZ7/KsdVAUg7q0oyB6aqCXzOECK
 q0KnTwLJ64EMLFOJ+tzBxrwKP2jElNavUOTbo9vt8qO0P72pckxQVRilQWULHU5yLPkG
 CS5AlSC+wR7D7225tQUDqknIym+n/M9XY5QLyRW4dIlXOqCcF/gwAIfBgrNc6LnPnyNq
 MvbL2hW+zLisAJaCwg6IqoXJrFcEUdn+iszWFy+eeX9HNThJWDCP8u/pGiE5zZpHJYCU
 P6LWBfK2WFIo/MeJXrsSOAOmvoP4A/3S+JywsZX7yjPxjGM4FLdGj+e3B1hucVwuvlCx Rw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1y6m1ct4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:17:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36P9Hrtu025701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 09:17:53 GMT
Received: from [10.204.118.225] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 25 Jul
 2023 02:17:16 -0700
Message-ID: <16885654-09f0-c139-cc9b-c6c4d666932e@quicinc.com>
Date:   Tue, 25 Jul 2023 14:47:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Atheros 11K" <ath11k@lists.infradead.org>
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
 <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
Content-Language: en-US
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
In-Reply-To: <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: i5r0EHj-DCqgOd8XKG_jdGWBaU8g-B9U
X-Proofpoint-ORIG-GUID: i5r0EHj-DCqgOd8XKG_jdGWBaU8g-B9U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 mlxlogscore=654 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250080
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/2023 6:19 PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Hmmm, there afaics was no real progress and not even a single reply from
> a developer (neither here or in bugzilla) since the issue was reported
> ~10 days ago. :-/
> 
> Manikanta, did you maybe just miss that this is caused by change of
> yours (and thus is something you should look into)?
> 

Extremely sorry for having this missed due to incorrect mail filters on 
my machine. I have looked the logs attached to the buganizer.

The issue from the logs looks like it is happening during the boot.
Generally, issues like these "ce desc not available for wmi command" 
occur when there is no room in the copy engine pipe for driver to 
enqueue the command to the firmware and in many cases these would have 
happen when firmware is reaping the ring slowly.

It is puzzling to know that thread NAPI is causing this and reverting 
this got the issue fixed. NAPI generally acts on the RX rings and has 
nothing to do with the TX.

Hi Sanjay,

This issue is seen just with the kernel upgrade alone? Or firmware has 
also been upgraded?

Meanwhile, I'll try to repro the issue on my local setup and try to root 
cause the problem. Pls let me know the firmware version that has been 
used for testing.

Although I'm okay reverting the threaded NAPI patch for now, in the long 
run we want that back as threaded NAPI brings significant improvement on 
the throughput front.

Thanks,
Manikanta
