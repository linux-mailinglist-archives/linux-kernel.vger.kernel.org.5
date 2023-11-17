Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377057EF187
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 12:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343584AbjKQLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 06:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQLTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 06:19:31 -0500
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D781111F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 03:19:26 -0800 (PST)
X-ASG-Debug-ID: 1700219962-086e236ff01f4d0001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id lmhIwENaRer50217 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Fri, 17 Nov 2023 19:19:22 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 17 Nov
 2023 19:19:21 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 17 Nov
 2023 19:19:20 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <88075c49-8118-4c4b-a2ce-e460180fa30c@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Fri, 17 Nov 2023 19:19:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-ASG-Orig-Subj: Re: [PATCH v2] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
CC:     <olivia@selenic.com>, <martin@kaiser.cx>,
        <jiajie.ho@starfivetech.com>, <jenny.zhang@starfivetech.com>,
        <mmyangfl@gmail.com>, <robh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <CobeChen@zhaoxin.com>, <TonyWWang@zhaoxin.com>,
        <YunShen@zhaoxin.com>, <LeoLiu@zhaoxin.com>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
 <20231108073454.521726-1-LeoLiu-oc@zhaoxin.com>
 <ZVdB7ZyjLay61mLp@gondor.apana.org.au>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <ZVdB7ZyjLay61mLp@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1700219962
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1222
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=MAILTO_TO_SPAM_ADDR
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.116869
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.00 MAILTO_TO_SPAM_ADDR    Includes a link to a likely spammer email
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/17 18:35, Herbert Xu 写道:
> On Wed, Nov 08, 2023 at 03:34:54PM +0800, LeoLiu-oc wrote:
>> From: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>>
>> Add support for Zhaoxin hardware random number generator.
>> This driver base on rep_xstore instruction and uses the same
>> X86_FEATURE_XSTORE as via-rng driver. Therefore, modify the x86_cpu_id
>> array in the via-rng driver, so that the corresponding driver can be
>> correctly loader on respective platforms.
>>
>> ---
>>
>> v1 -> v2:
>> 1. Fix assembler code errors
>> 2. Remove redundant CPU model check codes
>>
>> Signed-off-by: LeoLiuoc <LeoLiu-oc@zhaoxin.com>
>> ---
>>   drivers/char/hw_random/Kconfig       | 13 ++++
>>   drivers/char/hw_random/Makefile      |  1 +
>>   drivers/char/hw_random/via-rng.c     | 23 +++----
>>   drivers/char/hw_random/zhaoxin-rng.c | 95 ++++++++++++++++++++++++++++
>>   4 files changed, 119 insertions(+), 13 deletions(-)
>>   create mode 100644 drivers/char/hw_random/zhaoxin-rng.c
> 
> Please cc x86@vger.kernel.org as the same comments to the other
> zhaoxin driver seems to be applicable here.
> 
> Thanks,

Okay, Will re-send v2 add cc x86@vger.kernel.org.


Best Regards
Leoliu-oc

