Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5FF8047C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 04:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjLEDl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 22:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjLEDl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 22:41:57 -0500
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321EEFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 19:42:01 -0800 (PST)
X-ASG-Debug-ID: 1701747716-086e236fef30af0001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id ymHGzjALhRkJ3HKG (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 05 Dec 2023 11:41:56 +0800 (CST)
X-Barracuda-Envelope-From: LeoLiu-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Dec
 2023 11:41:56 +0800
Received: from [192.168.1.204] (125.76.214.122) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 5 Dec
 2023 11:41:54 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <d3b65c38-2d10-4098-95fd-04813c4272b2@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 192.168.1.204
Date:   Tue, 5 Dec 2023 11:41:53 +0800
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
        <x86@vger.kernel.org>, <CobeChen@zhaoxin.com>,
        <TonyWWang@zhaoxin.com>, <YunShen@zhaoxin.com>,
        <LeoLiu@zhaoxin.com>
References: <20231107070900.496827-1-LeoLiu-oc@zhaoxin.com>
 <20231121032939.610048-1-LeoLiu-oc@zhaoxin.com>
 <ZWmn2yDENnSjew4t@gondor.apana.org.au>
From:   LeoLiu-oc <leoliu-oc@zhaoxin.com>
In-Reply-To: <ZWmn2yDENnSjew4t@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [125.76.214.122]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1701747716
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1441
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.117665
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/12/1 17:31, Herbert Xu 写道:
> On Tue, Nov 21, 2023 at 11:29:39AM +0800, LeoLiu-oc wrote:
>>
>> +config HW_RANDOM_ZHAOXIN
>> +	tristate "Zhaoxin HW Random Number Generator support"
>> +	depends on X86
>> +	default HW_RANDOM
> 
> Please remove this default.
> 
Okay, it will be deleted in the next version.

>> diff --git a/drivers/char/hw_random/via-rng.c b/drivers/char/hw_random/via-rng.c
>> index a9a0a3b09c8b..6d1312845802 100644
>> --- a/drivers/char/hw_random/via-rng.c
>> +++ b/drivers/char/hw_random/via-rng.c
>> @@ -35,9 +35,6 @@
>>   #include <asm/cpufeature.h>
>>   #include <asm/fpu/api.h>
>>   
>> -
>> -
>> -
> 
> Please don't make unrelated changes in a patch.
> >>   	pr_info("VIA RNG detected\n");
>>   	err = hwrng_register(&via_rng);
>>   	if (err) {
>> -		pr_err(PFX "RNG registering failed (%d)\n",
>> -		       err);
>> +		pr_err(PFX "RNG registering failed (%d)\n", err);
> 
> Ditto.
> 
Okay, these modifications will be restored in the next version.

>> +#include <crypto/padlock.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/hw_random.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/cpufeature.h>
>> +#include <asm/cpu_device_id.h>
>> +#include <asm/fpu/api.h>
> 
> Please sort this alphabetically.
> 
> Thanks,
Okay, it will be modified in the next version.

Sincerely,
Leoliu-oc
