Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71C773B53
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHHPsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjHHPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:47:27 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB2D10C0;
        Tue,  8 Aug 2023 08:41:32 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id F125A3200906;
        Tue,  8 Aug 2023 09:46:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 08 Aug 2023 09:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691502365; x=1691588765; bh=QCX/lpfXwJ5z0pSWhPcBrqLzzwFNbbABXjK
        ojnNk55A=; b=iDzl4ABAxMRM9X/i6koq5ZbUzWXbe9LzbrZAIxzX+cb6szPrCcQ
        THyakH0okjmXwZAL7f9WOa3F6XbffGdSy3qdvZxJplREiPRmpCkj3BLlCeYEHSCP
        Bj/KNmQNLXWcGMLlD0YGuGaaM0rw0bNvfh4G5XBN07rZrD3+xO4rYgaWnvZC93uA
        65tbwHRL9Ef2AsCWWChos13pW9a4OFLZRVYbdtVgspv/2tvlSUaXrucuEDuGWrUR
        gJZckq3LePJdWDZoE+oO3fvqigBxNt9I5E7ID/PjdQ2sJVYm+wyzXwUGFJtcX9SN
        k8WU0LXJnUBacFFywxNOi67mewEHMUBTfyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691502365; x=1691588765; bh=QCX/lpfXwJ5z0pSWhPcBrqLzzwFNbbABXjK
        ojnNk55A=; b=m+0uuOPj8DzZFQauay0myP3ngR+pxV68xX3itgWvbpw0uI7V5fC
        HDeEk7v3dtDZzbKchxhT5j3fFtiw4bl4QVuM6p/p28GaEMy6Yg0KinVVLUn15Tic
        cZ+UBJ2zIxFjVpG3w//acLwNDEQxb/Vv7+PlhjSpQTv9lPcqwKnfPtXDZgaKp71D
        QjlPhp9BrnzlINKuisfQ4R7ORzXRfFH+mpEmsmVqhht3zW/f+wbKAIxh544er92k
        9QUnNdVQu+bEHGkKU01h3j4GYGTblgDnC+VnQf98B0/JuERLqdJf7dr8K1EDZGm2
        aKjsq36wVxB4rOe+PwtSfCB6a4+urkHoK6A==
X-ME-Sender: <xms:G0fSZCdWAFkJZrFe2FTFPv3hpC8M5SlrEYjdTDyqJi2XYgy7-4FXpw>
    <xme:G0fSZMPUdbhRVRKklMvcSS5C8ht5I_wdt40kiw3viLPtin-pRLxvNh2hD9rlSghLn
    sKgXoh4vazVX9upJOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeufeef
    ieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:G0fSZDghd5wQbVZ8EdKhEfd-jHfxsmr1j9wGiZ174Ohs8LAoWDt8VA>
    <xmx:G0fSZP_gFBuSKNoV9BlTrCBqoRTNcC6is7IiyN7CKJnKy8qyO3g8BA>
    <xmx:G0fSZOuqYBPQedoW5Ouh9pVTyYN8FPXXMnxuj_pfeMFgOOfAJ0jqxA>
    <xmx:HUfSZAJLDRrcSoLfW8aqhOdectWfFwB346rzaGubRotAzDaZltuUAw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 430EDB6008D; Tue,  8 Aug 2023 09:46:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <d025d95e-b12e-4502-b3fe-dc03d5ec831d@app.fastmail.com>
In-Reply-To: <CACRpkdYisteBTk9DOeCZiCeH5hJW87O-m+zsWAU7uwg7ud=ZYw@mail.gmail.com>
References: <20230808-virt-to-phys-mips-v1-1-af6fcd45ed31@linaro.org>
 <CACRpkdYisteBTk9DOeCZiCeH5hJW87O-m+zsWAU7uwg7ud=ZYw@mail.gmail.com>
Date:   Tue, 08 Aug 2023 15:45:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Baoquan He" <bhe@redhat.com>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Drop virt_to_phys define to self
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023, at 15:12, Linus Walleij wrote:
> On Tue, Aug 8, 2023 at 11:29=E2=80=AFAM Linus Walleij <linus.walleij@l=
inaro.org> wrote:
>
>> The function virt_to_phys was defined to virt_to_phys and then
>> implemented right below.
>>
>> I can't understand why, just drop it and let the actual function
>> slot in.
>>
>> Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  arch/mips/include/asm/io.h | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
>> index affd21e9c20b..18ed44843541 100644
>> --- a/arch/mips/include/asm/io.h
>> +++ b/arch/mips/include/asm/io.h
>> @@ -111,7 +111,6 @@ extern phys_addr_t __virt_to_phys(volatile const =
void *x);
>>  #define __virt_to_phys(x)      __virt_to_phys_nodebug(x)
>>  #endif
>>
>> -#define virt_to_phys virt_to_phys
>>  static inline phys_addr_t virt_to_phys(const volatile void *x)
>>  {
>>         return __virt_to_phys(x);
>
> Just have to CC Arnd on this because I never feel I understand this
> properly.
>
> Normally you would do this so as to override the default virt_to_phys()
> from include/asm-generic/io.h, but we do not seem to be using it here?

Correct. In linux-next, we have converted arch/sh to use
include/asm-generic/io.h, so arch/mips is now the last one
to not use it.=20

I see that Jiaxun Yang posted a patch for this in May and it looked
like it should finally work [1], but there seems to still be something
missing.

> Further right below we are implementing phys_to_virt() with no
> corresponding define, so in any case this needs to go or that one
> needs a define.
>
> That said they seem like a good candidate to replace with the
> generic variant because the content is the same sans some debug
> hacks that I doubt are still needed.

I think the ARCH_HAS_DEBUG_VIRTUAL option is useful in
general, I'd rather move that into the common code if
we were to unify it.

For the moment, I'd suggest we leave the #define in place
here in order to finish the patch that starts using the
asm-generic header, and then we can look into using more
of the generic code.

       Arnd

[1] https://lore.kernel.org/linux-mips/20230519195135.79600-1-jiaxun.yan=
g@flygoat.com/
