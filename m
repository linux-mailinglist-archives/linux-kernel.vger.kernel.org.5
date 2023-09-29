Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D988C7B3887
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjI2RWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjI2RWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:22:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F34193;
        Fri, 29 Sep 2023 10:22:31 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TAhRvD004977;
        Fri, 29 Sep 2023 17:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mo/Fmgs8ebIBJP4OfmoansQWGKkTUIXMnfyq+5Xah7A=;
 b=b1EXqp5uU4pb5cOHsuEkYb+M5Boy6erCGlQNJITPFNOxJh5N3Lkx0s26Is2xKqCaJAhC
 OaufbyHL3EcYVTU/9nLpiNLC4I//7QacMOws4BxtwXC8zVR6RSKa8D1yeyBCvDOHlRMw
 U5U4lFs+4hx+RUk0vwZYIPTsIJ28/p/JvIRuSQ5Lz3/iqjve5PDfoYFlqEZpVCeXT29m
 ZyTryKQfMO9GogjXdD+OyX+mWhj/P1HMHITUtc7WOThaxOxERRkrFnahO2hn6fuJRKd6
 5IL+gswWKqjfmYXp3SzY5FA8rtPOwTrZt32yX+kcbTCVLkBkC9kBsJg7guCY+EOa64Al Pw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdqmv9u2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 17:22:20 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38THMHEY027482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 17:22:17 GMT
Received: from [10.111.177.152] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 29 Sep
 2023 10:22:17 -0700
Message-ID: <28233946-7b20-4a08-ba0f-253e5ca5ff62@quicinc.com>
Date:   Fri, 29 Sep 2023 10:22:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 wireless-next 2/9] carl9170: remove unnecessary (void*)
 conversions
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Christian Lamparter <chunkeey@gmail.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Wu Yunchuan <yunchuan@nfschina.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kalle Valo <kvalo@kernel.org>
References: <20230919044916.523308-1-yunchuan@nfschina.com>
 <e544d992-cddd-4ade-81ef-2eed4f3681e8@gmail.com> <87zg16iab3.fsf@kernel.org>
 <0b7623f7-561c-4f3b-91c1-aaf1c44f1158@kadam.mountain>
 <d41d0c98-82ef-40f6-8c5c-68a94b5a4655@kadam.mountain>
 <c5611be9-ef4d-4e49-84de-7ce893e3c73c@gmail.com>
 <597c6e87-2d1c-4a8d-ab9f-d0d22566b9ed@quicinc.com>
In-Reply-To: <597c6e87-2d1c-4a8d-ab9f-d0d22566b9ed@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WjXijJQP5TDQRwNntQxUx0Sw9faqvgVY
X-Proofpoint-ORIG-GUID: WjXijJQP5TDQRwNntQxUx0Sw9faqvgVY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=518 spamscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309290150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/2023 9:10 AM, Jeff Johnson wrote:
> On 9/29/2023 12:23 AM, Christian Lamparter wrote:
>> I would like to take the chance to again point to this beauty:
>> <https://lore.kernel.org/linux-wireless/TYAP286MB03154F9AAFD4C35BEEDE4A99BC4CA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/T/#mf1b8919a000fe661803c17073f48b3c410888541>
>> @Dan, @Jeff can you please comment on that too?
> 
> I had not seen that patch since it was posted while I was transitioning 
> roles. It looks like a reasonable patch to me to handle FORTIFY_SOURCE 
> restrictions.

Saw Dan's reply, and further looked at the patch and saw this wasn't 
actually a typical FORTIFY_SOURCE patch, so presumably this change is 
NOT needed.

