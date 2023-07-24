Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A12575FB76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGXQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjGXQHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 12:07:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862FE10DC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 09:07:05 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OG6B57030078;
        Mon, 24 Jul 2023 16:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sWjvVnoGtsc6YvQbKjssfN7cHL9/6bIGmpY0gjAywMw=;
 b=BFPPaSPhocMIEoN941lBALfHKNZ9SX/I6SXjH8fxYx89JibkhrneT0oDcfbqhLoNO+YS
 9jLXBRqW89L4xapblFF1zeRh9O+P8v4znj2Ztm5Fd7Uz8CgDv7Z1rWEb1S8NxG3KKPeZ
 B8X4rYh6Ba4k1lzq1GHO8OZtvqkLciIJk9yZ8hqOjgWQaKmxY7iXhtlAYlJj2wi2/UfY
 1VYbV5gKsXPFqOmMvXs++P7tm1yeyR8MOlOHz4IJ1ziejV09DJAh3tIHXzrFGQl3hX5/
 6LZK3z0uaXufjurnr4+Y/gpAaUiwA3YmMJ/RfgzXxY8+/6jh5WBbBz3+sz87gfePyPEj 1A== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1vh8g03r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:06:47 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OG6kB3012179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 16:06:46 GMT
Received: from [10.216.25.90] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 09:06:44 -0700
Message-ID: <463761de-c140-8e21-ce71-3064ea690ace@quicinc.com>
Date:   Mon, 24 Jul 2023 21:36:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH=5d_time=3a_hrtimer=3a_Remove_unnecessary_?=
 =?UTF-8?B?4oCYMOKAmSB2YWx1ZXMgZnJvbSByZXQ=?=
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>
References: <20230725195602.3279-1-zeming@nfschina.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20230725195602.3279-1-zeming@nfschina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: YqMsBmW1e2fjcDuKplifU4GH8q0YY40s
X-Proofpoint-GUID: YqMsBmW1e2fjcDuKplifU4GH8q0YY40s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_12,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240143
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 1:26 AM, Li zeming wrote:
> ret is assigned first, so it does not need to initialize the assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

> ---
>   kernel/time/hrtimer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index e8c08292defc..9f90e76c6cd9 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -2085,7 +2085,7 @@ long hrtimer_nanosleep(ktime_t rqtp, const enum hrtimer_mode mode,
>   {
>   	struct restart_block *restart;
>   	struct hrtimer_sleeper t;
> -	int ret = 0;
> +	int ret;
>   	u64 slack;
>   
>   	slack = current->timer_slack_ns;
