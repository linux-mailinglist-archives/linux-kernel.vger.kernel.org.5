Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2307D772363
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjHGMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjHGME7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:04:59 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFD1BF3;
        Mon,  7 Aug 2023 05:04:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 01489320095B;
        Mon,  7 Aug 2023 08:04:27 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 07 Aug 2023 08:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691409867; x=1691496267; bh=4q
        R2S2MtVT1gufffbhUzZeedkipKDGuTgchxc/0LCac=; b=QlwvjflpzuAEvaxUPL
        +xZACfpn+GmIuZBxQGWdiykq/If49cEKM3odstW87to7HaMsjBdJj/n7VaWROGQ7
        TUoPbXbrVHQjWQDlF0oMsDdBg0vGp69LpEU2E5b/PTBRSEA3UDM2BB9jvoQgkPUb
        aG1M234zfAj6O0RII4crLzOysHHC/q4JalH1LARDz5k4fhwPNI+pMSKLN8jQ3vp9
        IimMQPpcCqQAJkjXQhoHBdTSrhSu+jC1372MDfz/Jo5c8BfdibO7jS5zSj4U9ay5
        kli2ojMD7diVeG5rQKj6CVyedZePp32L+4H9dgUgkSM8QmCjqs1IBr4Jn1hButSA
        hSnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691409867; x=1691496267; bh=4qR2S2MtVT1gu
        fffbhUzZeedkipKDGuTgchxc/0LCac=; b=Qk4VLf08hmFsYsFFSdEgCtC7I+HwG
        lshWiDjV7R/mJbnTfX0SQsva2CiqE+cEiFnmQA/KGAyT43veeaCLTxzSgvyA8NIF
        Mj+TnNTKt6YCVhIreek36gUKPWNVp3jb72fr589LKsc8XiAr220AoFaMroc6v3dh
        138JWbOavi65y2guLY9jjx1OO0VRNQu/R+tim0kEHjwjvjLiEjSNJIlhYJ3GiBFe
        4cbEwkSEPLUNMrm19SqARBI2+WyhNAT7mm4kz8+bE3TIcCukylVga4O8FGxn8VLV
        2P1u0BO1PpD6XAdTQiDGrGyslDPhu5yxG4EIKWDAgvIXWgtKIFXeA7H6A==
X-ME-Sender: <xms:yt3QZPbSU21E0WaikpEfNTThLwrot25PH7X8Zdm2-CFE9aBleETSFA>
    <xme:yt3QZOby9_LQfDmnq9s07tSc9vZvsvzfHW8ieJIvsOgB97dAQMfPg-10B41NS-ha-
    5NOnxbJCVBSHud3k9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpefgtedtvedufefgffetgefgheefudehteeggffgheeukeevffdvfeeifeevjeef
    ieenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmpdehqdhrtgdurdhinhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggv
X-ME-Proxy: <xmx:yt3QZB9oNY-80EfHEonmjj-pF7oVazaVp_IB7wIdNiWMWPmkRrw_JQ>
    <xmx:yt3QZFqbwBhBauYc2rr3TgBtyrjoG5FYvT5AQCfiooliZlLcNY6yLA>
    <xmx:yt3QZKrF0BQTZoXLt82IhA1hQ8jObDeiYHBkEk6Q-zLT7-002wV46A>
    <xmx:y93QZHRpo1HxVlPVMDZ8ROUD0G1BtbAIEzRhPivHBWWr2XyzJR6vBw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27325B60089; Mon,  7 Aug 2023 08:04:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <d9184ad7-7d34-45bf-81e3-db053bf7425c@app.fastmail.com>
In-Reply-To: <ZMyz27awrVJ8QHzA@gondor.apana.org.au>
References: <20230724135327.1173309-1-arnd@kernel.org>
 <ZMyz27awrVJ8QHzA@gondor.apana.org.au>
Date:   Mon, 07 Aug 2023 14:04:05 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Ryan Wanner" <Ryan.Wanner@microchip.com>,
        "Yangtao Li" <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        "Sergiu Moga" <sergiu.moga@microchip.com>,
        "Ayush Sawal" <ayush.sawal@chelsio.com>,
        "Gaosheng Cui" <cuigaosheng1@huawei.com>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH 1/2] crypto: drivers - avoid memcpy size warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023, at 10:16, Herbert Xu wrote:
> On Mon, Jul 24, 2023 at 03:53:01PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Some configurations with gcc-12 or gcc-13 produce a warning for the source
>> and destination of a memcpy() in atmel_sha_hmac_compute_ipad_hash() potentially
>> overlapping:
>> 
>> In file included from include/linux/string.h:254,
>>                  from drivers/crypto/atmel-sha.c:15:
>> drivers/crypto/atmel-sha.c: In function 'atmel_sha_hmac_compute_ipad_hash':
>> include/linux/fortify-string.h:57:33: error: '__builtin_memcpy' accessing 129 or more bytes at offsets 408 and 280 overlaps 1 or more bytes at offset 408 [-Werror=restrict]
>>    57 | #define __underlying_memcpy     __builtin_memcpy
>>       |                                 ^
>> include/linux/fortify-string.h:648:9: note: in expansion of macro '__underlying_memcpy'
>>   648 |         __underlying_##op(p, q, __fortify_size);                        \
>>       |         ^~~~~~~~~~~~~
>> include/linux/fortify-string.h:693:26: note: in expansion of macro '__fortify_memcpy_chk'
>>   693 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>>       |                          ^~~~~~~~~~~~~~~~~~~~
>> drivers/crypto/atmel-sha.c:1773:9: note: in expansion of macro 'memcpy'
>>  1773 |         memcpy(hmac->opad, hmac->ipad, bs);
>>       |         ^~~~~~
>> 
>> The same thing happens in two more drivers that have the same logic:
>
> Please send me the configurations which triggers these warnings.
> As these are false positives, I'd like to enable them only on the
> configurations where they actually cause a problem.

See https://pastebin.com/raw/ip3tfpJF for a config that triggers this
on x86 with the chelsio and atmel drivers. The bcm driver is only
available on arm64, so you won't hit that one here. I also
see this with allmodconfig, as well as defconfig after enabling
CONFIG_FORTIFY_SOURCE and the three crypto drivers.

I see that commit df8fc4e934c12 ("kbuild: Enable -fstrict-flex-arrays=3")
turned on the strict flex-array behavior that triggers the
warning, so this did not show up until linux-6.5-rc1.
In linux-next, I see no other code hit this warning after all
my other patches for it got merged, regardless strict flex
arrays.

At the moment, -Wrestrict is completely disabled in all builds,
so you have to add a patch to enable it in the build system,
this is what I use locally to enable it at the W=1 level,
though you can probably just replace the cc-disable-warning
line with a -Wrestrict line.

     Arnd

--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -49,9 +49,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 # globally built with -Wcast-function-type.
 KBUILD_CFLAGS += $(call cc-option, -Wcast-function-type)
 
-# Another good warning that we'll want to enable eventually
-KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
-
 # The allocators already balk at large sizes, so silence the compiler
 # warnings for bounds checks involving those possible values. While
 # -Wno-alloc-size-larger-than would normally be used here, earlier versions
@@ -93,6 +90,7 @@ export KBUILD_EXTRA_WARN
 ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
 KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
+KBUILD_CFLAGS += $(call cc-option, -Wrestrict)
 KBUILD_CFLAGS += -Wmissing-format-attribute
 KBUILD_CFLAGS += -Wold-style-definition
 KBUILD_CFLAGS += -Wmissing-include-dirs
@@ -105,6 +103,7 @@ else
 
 # Some diagnostics enabled by default are noisy.
 # Suppress them by using -Wno... except for W=1.
+KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 
 ifdef CONFIG_CC_IS_CLANG

