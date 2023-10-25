Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999B67D705E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 17:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343695AbjJYPFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjJYPFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 11:05:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6AF128;
        Wed, 25 Oct 2023 08:05:32 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEgSdN027452;
        Wed, 25 Oct 2023 15:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=RuCNp/5DNa8NRuatc9bv4W1fRpdB+t14O7QS6VX5tSY=;
 b=Y6yu3aGpsRWTgyMrNetgA8N43vYTNlrC34ieJAo3IWB1Wk1a6kym5nLRTcvBKsxVIfQe
 ntCFWs3qmntNPwJWOLtUyMnlNTA5UZX+/C9s9AWo1X4DiHLYNAX+B0+XuE69Zzmx8x8W
 FCOnGffgrB7tP1n4eMVQp0wI7exTiY8U3jiaxbNxHzfpmQu2WburRHrLcpauKCPutiI2
 WvqyyE6Bo/M3wpvC8WRN2GJkHP98mBWo4d5n8IcYaoQ9Y7glrNAEeVQXqDOUaF/+u+2o
 CDjnWcFwYNoKgRk2K+ZQcZHYu500xYnMcEzvxJ6KhIWrQNKZ9gp0U+9OqTmo8fwLVYpB GQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ty50xrtqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 15:05:19 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39PCVTDA012399;
        Wed, 25 Oct 2023 15:05:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tvup1xw1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 15:05:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39PF5FcU29426120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 15:05:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 585E520040;
        Wed, 25 Oct 2023 15:05:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE1432004D;
        Wed, 25 Oct 2023 15:05:14 +0000 (GMT)
Received: from localhost (unknown [9.171.93.15])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Oct 2023 15:05:14 +0000 (GMT)
Date:   Wed, 25 Oct 2023 17:05:13 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Message-ID: <your-ad-here.call-01698246313-ext-3263@work.hours>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com>
 <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5THSBFWVrkQ8xWtOTm5s3Z9fzf3beVcn
X-Proofpoint-ORIG-GUID: 5THSBFWVrkQ8xWtOTm5s3Z9fzf3beVcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_04,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=926 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 12:53:03PM -1000, Linus Torvalds wrote:
>+/*
>+ * The other cases need to be split by type.
>+ *
>+ * Signed cases seem badly defined, but do exist. We should
>+ * consider removing them from this _Generic(), and fixing any
>+ * result 'not compatible with any association' cases.
>+ */
>+#define __div_round_up(n,d) _Generic((n)+(d),		\
>+	unsigned long long: __div_round_up_ull(n,d),	\
>+	long long: __div_round_up_ll(n,d),		\
>+	unsigned long: __div_round_up_ul(n,d),		\
>+	long: __div_round_up_l(n,d),			\
>+	unsigned int: __div_round_up_u(n,d),		\
>+	int: __div_round_up_i(n,d))

You probably want

 #define __div_round_up(n,d) _Generic((n)+(d),		\
	unsigned long long: __div_round_up_ull,		\
	long long: __div_round_up_ll,			\
	unsigned long: __div_round_up_ul,		\
	long: __div_round_up_l,				\
	unsigned int: __div_round_up_u,			\
	int: __div_round_up_i)(n,d)

to avoid early type-checking for expressions that will be discarded
and prevent errors like:

drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c: In function 'sparx5_tc_flower_parse_act_police':
drivers/net/ethernet/microchip/sparx5/sparx5_main.h:435:34: error: conversion from 'long long unsigned int' to 'long unsigned int' changes value from '25000000000' to '3525163520' [-Werror=overflow]
  435 | #define SPX5_SDLB_GROUP_RATE_MAX 25000000000ULL
      |                                  ^~~~~~~~~~~~~~
./include/linux/div_round_up.h:68:42: note: in definition of macro '__div_round_up'
   68 |         unsigned long: __div_round_up_ul(n,d),          \
      |                                          ^
./include/linux/div_round_up.h:50:9: note: in expansion of macro '__keep_const'
   50 |         __keep_const(n, div_round_up(n,d))
      |         ^~~~~~~~~~~~
./include/linux/math.h:37:22: note: in expansion of macro '__KERNEL_DIV_ROUND_UP'
   37 | #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
      |                      ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c:732:38: note: in expansion of macro 'SPX5_SDLB_GROUP_RATE_MAX'
  732 |         if (pol->rate > DIV_ROUND_UP(SPX5_SDLB_GROUP_RATE_MAX, 1000)) {
      |                                      ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/microchip/sparx5/sparx5_main.h:435:34: error: overflow in conversion from 'long long unsigned int' to 'long int' changes value from '25000000000' to '-769803776' [-Werror=overflow]
...
drivers/net/ethernet/microchip/sparx5/sparx5_main.h:435:34: error: conversion from 'long long unsigned int' to 'unsigned int' changes value from '25000000000' to '3525163520' [-Werror=overflow]
...
drivers/net/ethernet/microchip/sparx5/sparx5_main.h:435:34: error: overflow in conversion from 'long long unsigned int' to 'int' changes value from '25000000000' to '-769803776' [-Werror=overflow]

Plus typos fixes below passes allyesconfig for s390, 32-bit x86 and arm.

 static inline unsigned long long __div_round_up_ull(unsigned long long n, unsigned long d)
 {
 #ifdef CONFIG_32BIT
 	if (!n)
-		return 0
-	do_div(n-1, d);
-	return n+1;
+		return 0;
+	n--;
+	do_div(n, d);
+	return n + 1;
 #else
 	return __const_div_round_up(n,d);
 #endif
