Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131F4790BE3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237093AbjICM0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 08:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjICM0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 08:26:54 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1B6126;
        Sun,  3 Sep 2023 05:26:51 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383CLPQ7030893;
        Sun, 3 Sep 2023 12:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9y8lMAiQW6s58jdKBZd7Bg6zCnZHP+lVGgPcrZSjSjY=;
 b=Sfn/87zMwLT0KVHGQULenfbKseXgjDS6oVG7Im89XFb+J1xu36TRUQN18+bvQcejOTOW
 KCf9yLTQ86bIMN9tE4j0YjCy/zGNQDOHvEoIO+JRAo8kGqueQioCFz+6xlTS/zQYfL5l
 Xo3UBQBAmSa8egjY1IE6eDzDWfeRv6tisiXYCb1FF4dMhgl18+FZmPZpPao+u1yK5I3p
 3iXireMdpx9+bN25FO81I+PPeBIV9p2MKxCIsCTXrtDVoEgvjaFfcdkHqfuBWZnqLcqt
 VG1t6iC90leKd22uSBn0Kp9xdYySWnWPSEUWRtAoh3E9bBhwevM//iXItbYvz8Av6KPn ag== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sutdtsuyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 12:26:44 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 383CQhQj013589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Sep 2023 12:26:43 GMT
Received: from [10.216.14.155] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 3 Sep
 2023 05:26:39 -0700
Message-ID: <290c7e5e-ddbb-c754-240f-a3017fed3801@quicinc.com>
Date:   Sun, 3 Sep 2023 17:56:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH net-next 0/2] net: qrtr: Few qrtr fixes
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
CC:     <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <quic_viswanat@quicinc.com>
References: <1693563621-1920-1-git-send-email-quic_srichara@quicinc.com>
 <20230901141905.GJ140739@kernel.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <20230901141905.GJ140739@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uxACoy5d3ZiCl8Nz4S6E3Ie2FlBmUdZv
X-Proofpoint-GUID: uxACoy5d3ZiCl8Nz4S6E3Ie2FlBmUdZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_09,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 mlxscore=0 suspectscore=0 mlxlogscore=574
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309030116
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On 9/1/2023 7:49 PM, Simon Horman wrote:
> On Fri, Sep 01, 2023 at 03:50:19PM +0530, Sricharan Ramabadhran wrote:
>> Patch #1 fixes a race condition between qrtr driver and ns opening and
>> sending data to a control port.
>>
>> Patch #2 address the issue with legacy targets sending the SSR
>> notifications using DEL_PROC control message.
> 
> Hi Sricharan,
> 
> if these are fixes then they should be targeted at 'net' rather than
> 'net-next', and consideration should be given to supplying Fixes tags.
> 
  There is as such no existing feature broken without these 2 patches
  today. Then they might qualify as preparatory patches for adding
  some features.

> If these are not fixes, then please don't describe them as such.
> In this case targeting net-next is correct, but it is currently closed,
> as per the form letter below.
> 
   Sure, then in that case looks like it belongs to 'net-next' and will
   post V2 once the net-next is opened again.

> In either case please consider:
> 
> * Arranging local variables for new Networking code in
>    reverse xmas tree order - longest line to shortest
> 
> * Avoiding introducing new Sparse warnings
> 
>   ok.

> ## Form letter - net-next-closed
> 
> The merge window for v6.6 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations.
> We are currently accepting bug fixes only.
> 
> Please repost when net-next reopens after Sept 11th.
> 

  ok, sure.

Regards,
  Sricharan
