Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880C876BEB5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjHAUsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjHAUs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:48:28 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BCA210A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:48:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 34CC55C010E;
        Tue,  1 Aug 2023 16:48:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 01 Aug 2023 16:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1690922905; x=1691009305; bh=lv
        EgkaePU2xXJH+rWEFdSbgQ3ZqWwb5pL5D6ZyaI2j0=; b=iGtkPoVZ6BxzgcOK/f
        rIzRRQ5I48YDf6WrdyHqV44b3ju/6V6CsiPEVJKZw35fMhuozXh4jVtTbgn6cwPp
        rYvveaA0moJ0z6omEg1XPbtcZSbIVe8/THECtcRI0IpCVbD9VHpR6Xy9I3Ycfoax
        2DtU/DdBYvf16oyTQebNm7m1u5zCcvi2Q32k8jMb00DnvqqY0epRjPueqOxr3tki
        WhVdieINb7iF6BNgVxkUczqp4D6QDqoJLERAgyT1d7MjGGNb9867bOd+YyGPzeq5
        8WwFj+TpaXILOrKnN453cf0TuYMoypUUOvvnoxTsbymGFrC/btfzBg3/9FekTytg
        sc3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690922905; x=1691009305; bh=lvEgkaePU2xXJ
        H+rWEFdSbgQ3ZqWwb5pL5D6ZyaI2j0=; b=w0pYD3btqOcBUVNtgWdCi/28rVkG3
        erB5YmAd+ayOhz/X/f0w4nBRjINyTbzoZB9wZuE+NlmJXbCAfFPW2wm4Uf1PnWMn
        AtBb9smtMMc52ZTVf201qsD1ZPbjK/ymv3IPlWFcXnwUo5FKGoeQoCDjr++uXCPn
        GrTK42NNfJYZeapPaVmNOKV/DWB+t5o50VpbjjSVOHll3ngKeU9EC6yn8WziVLMT
        4BVAUA9mPTiRg6TvbeVL/tnyZSvxFXriqmDGTxtxcITOBJqPBrOEmSVJGo/y3Ia0
        FeVhfpnhdpDS7y82KExkvD0rmMho8mC5bapMIywyQ6gVDinO6gryeGpxg==
X-ME-Sender: <xms:mG_JZHdzo1zyk88EUQsMlaRfICkXy1gXz83Wu3AAO8wpLU3LM1V52g>
    <xme:mG_JZNMv_zb3tDXCt5E9ZpxBV-q_f_r-faE4JW02U9OOttJHWcJK-2Q7b3Ucxu6Js
    Gnj-x3TwPIkM6icYQU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mG_JZAhHg7c-loIpbvQnjGY03C4xqaKR8o7Xs6qnptPDD4ChGQA9Zw>
    <xmx:mG_JZI_a-cSsUUQ1o0KWs7F2Ea6haaIMq11O0SkT2DzekkQESS8BlA>
    <xmx:mG_JZDtN1hKoMNCJdWtjjQq84wSR60TQ0vT07HmvjCl8W-oiPnddkA>
    <xmx:mW_JZJV2RsafNDa-zyM6tK4KJeNSUlAs0_zX03wx2c_e7eRj4niAQA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7571CB60089; Tue,  1 Aug 2023 16:48:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Mime-Version: 1.0
Message-Id: <baf750f4-a42c-453a-91dc-7fd457bc1e80@app.fastmail.com>
In-Reply-To: <20230801170315.GGZMk60zojZOeuUwX7@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-3-arnd@kernel.org>
 <20230801170315.GGZMk60zojZOeuUwX7@fat_crate.local>
Date:   Tue, 01 Aug 2023 22:48:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Borislav Petkov" <bp@alien8.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/5] [RESEND] x86: avoid unneeded __div64_32 function definition
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023, at 19:03, Borislav Petkov wrote:
> On Tue, Jul 25, 2023 at 03:48:34PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The __div64_32() function is provided for 32-bit architectures that
>> don't have a custom do_div() implementation. x86_32 has one, and
>> does not use the header file that declares the function prototype,
>> so the definition causes a W=1 warning:
>> 
>> lib/math/div64.c:31:32: error: no previous prototype for '__div64_32' [-Werror=missing-prototypes]
>> 
>> Define an empty macro to prevent the function definition from getting
>> built, which avoids the warning and saves a little .text space.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/x86/include/asm/div64.h | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
>> index b8f1dc0761e4b..9826d5fc12e34 100644
>> --- a/arch/x86/include/asm/div64.h
>> +++ b/arch/x86/include/asm/div64.h
>> @@ -71,6 +71,8 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
>>  }
>>  #define mul_u32_u32 mul_u32_u32
>>  
>> +#define __div64_32 /* not needed */
>
> This comment, *after* having read the commit message makes sense.
>
> When you look at it alone, after having opened the file, makes me
> scratch my head and wonder what is that thing supposed to mean. Please
> extend it.
>
> And put the comment ontop, not sideways.

Right, makes sense. How about this version?

--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -71,6 +71,11 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
 }
 #define mul_u32_u32 mul_u32_u32
 
+/*
+ * __div64_32() is never called on x86, so prevent the
+ * generic definition from getting built.
+ */
+#define __div64_32
 
 #else
 # include <asm-generic/div64.h>


       Arnd
