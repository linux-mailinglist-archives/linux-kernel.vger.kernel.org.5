Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F2804A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344398AbjLEGfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344386AbjLEGfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:35:00 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA64E130
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:35:05 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B93893200A39;
        Tue,  5 Dec 2023 01:35:01 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 01:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701758101; x=1701844501; bh=Nu
        G/6/Yb8lCUL8zFD4dfH32Me2vLPL01Z8/hfRvZ+5Q=; b=zbNV8n7Fo/M7Fhfb9S
        /Zj0Pybk3s74kElk47wi1vWdwOGJECAbQh/Dw9IkxaX05aBnAURLkDpMRjxZwn76
        eYX++Ae6lxX2p6zghqBIgnBkn8+KcdJ56QtYRcglV2zxKBR+OX/vnDIkaghnz+3A
        MK3rb/kOyKZf1sEav96h0WowCLaOHWfIxIsvWuhFU8l4MOR5rix08RvOQmoqrT/6
        TJbXVTwgpBj5/7h+tctjongW9UTMpjFO/Yfm++6ZDRDY2geWNJKvi60BRFZteQSr
        lN3zHgB6k7yILkROoJ717qoojsFm5T5jjderNZQlmx3A/U7RHWbdVS8hS3zsXKRb
        +jSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701758101; x=1701844501; bh=NuG/6/Yb8lCUL
        8zFD4dfH32Me2vLPL01Z8/hfRvZ+5Q=; b=cu6M4cDDuig0gcodZ84Nr8YBHIk/e
        ZdPv4PBhc3A2hKmkT6JlNd1XTuNDwvf3AzavlzwRd5g3mWsApH/0PBnUkaEp9ESb
        a6FRmjCHqbosnpCh+UXPo5atyselG3EC/BLhaimiHjtcJVP3daCBt5+4HID0gRLc
        tq5i4IckvVx6UPwDZiSCYPu/TSHIX6ptV46ognEnUsC1OWKLk48eUa14iz2yEke9
        BWbuZRrOSxbeSuhlQMk2Xtd2Xv6lo90BtxHh91ojV6WB9HbzVqHWh3wUudkDextN
        HM2cyvKrL20Js8s0HAoE+JofceHmqe1DBe0ijKfMzndaDWZibBw7+AUHA==
X-ME-Sender: <xms:lMRuZaS04D4HdXlWlzRidv31z6FP9WRFopnVwaEh7mxQmYWUrRYzTQ>
    <xme:lMRuZfxdHq9rHdWhxWJGwkMMjHPw-rJbny7dFVI0DSddGvxhi8q2fLvDD5IxKnUzI
    ImxOSKrNnLpNa4cVz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejjedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lcRuZX3EDvy2xkor_CSr5qxEyY9EJj2bIKNtiNqF4oCuoQxupGs1rA>
    <xmx:lcRuZWBj8WQTEBFsRkh5HtYQj1UrNOQ3BmeZ5eoMcj4VJjHuldRXxw>
    <xmx:lcRuZThU0_Kau23rzEF_8RO6UQgEEQ5sTGK_J2nSl6M0JiswegNk0Q>
    <xmx:lcRuZThfC7w52-_wySVbz2KNCDVQ4bH2e4w8Qew0-R90RuhYczk5MQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E03AAB60089; Tue,  5 Dec 2023 01:35:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <36a25113-731c-4b28-a695-f3fbb0996d6e@app.fastmail.com>
In-Reply-To: <20231204223317.GA2053629@dev-arch.thelio-3990X>
References: <CA+G9fYvD72Vpfs2g8R+OJ6L8w9p_uaWbXpWMvnGAx_AOLabatw@mail.gmail.com>
 <20231204181304.GA2043538@dev-arch.thelio-3990X>
 <20231204223317.GA2053629@dev-arch.thelio-3990X>
Date:   Tue, 05 Dec 2023 07:34:40 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nathan Chancellor" <nathan@kernel.org>,
        "Naresh Kamboju" <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "Linux Regressions" <regressions@lists.linux.dev>,
        lkft-triage@lists.linaro.org,
        "Russell King" <linux@armlinux.org.uk>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Sylvestre Ledru" <sylvestre@debian.org>
Subject: Re: clang-nightly: vdso/compat_gettimeofday.h:152:15: error: instruction
 variant requires ARMv6 or later
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023, at 23:33, Nathan Chancellor wrote:
> On Mon, Dec 04, 2023 at 11:13:04AM -0700, Nathan Chancellor wrote:
> 
>> I am still investigating into what (if anything) can be done to resolve
>> this on the kernel side. We could potentially revert commit
>> ddc72c9659b5 ("kbuild: clang: do not use CROSS_COMPILE for target
>> triple") but I am not sure that will save us from that change, as
>> tuxmake's CROSS_COMPILE=arm-linux-gnueabihf will cause us to have an
>> armv7 CPU even though we may not be building for armv7.
>
> Okay, this is a pretty awful situation the more I look into it :(
>
> The arm64 compat vDSO build is easy enough to fix because we require use
> of the integrated assembler, which means we can add '-mcpu=generic' (the
> default in LLVM for those files based on my debugging) to those files
> and be done with it:
>
> diff --git a/arch/arm64/kernel/vdso32/Makefile 
> b/arch/arm64/kernel/vdso32/Makefile
> index 1f911a76c5af..5f5cb722cfc2 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -9,6 +9,10 @@ include $(srctree)/lib/vdso/Makefile
>  ifeq ($(CONFIG_CC_IS_CLANG), y)
>  CC_COMPAT ?= $(CC)
>  CC_COMPAT += --target=arm-linux-gnueabi
> +# Some distributions (such as Debian) change the default CPU for the
> +# arm-linux-gnueabi target triple, which can break the build. 
> Explicitly set
> +# the CPU to generic, which is the default for Linux in LLVM.
> +CC_COMPAT += -mcpu=generic
>  else
>  CC_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
>  endif

I'm still trying to follow what is actually going on. I
see that we pass

VDSO_CAFLAGS += -march=armv8-a

which is meant to tell the compiler that we want it to
use ARMv8 compatible instructions. Is the problem that
clang ignores this flag, or do we not pass it correctly?

I would have expected -march=armv8-a to be better than
-mcpu=generic here, as it allows the compiler to use
a wider set of instructions that is still guaranteed to
be available on everything it will run on.

> Sylvestre, I strongly believe you should consider reverting that change
> or give us some compiler flag that allows us to fallback to upstream
> LLVM's default CPU selection logic. I think that hardcoding Debian's
> architecture defintions based on the target triple into the compiler
> could cause issues for other projects as well. For example,
> '--target=arm-linux-gnueabi -march=armv7-a' won't actually target ARMv7:
>
>   $ echo 'int main(void) { asm("dsb"); return 0; }' | \
>         clang --target=arm-linux-gnueabi -march=armv7-a \
>         -x c -c -o /dev/null -v -
>   ...
>    "/usr/bin/clang-17" -cc1 -triple armv7-unknown-linux-gnueabi ...
>   ...
>
> vs.
>
>   $ echo 'int main(void) { asm("dsb"); return 0; }' | \
>         clang --target=arm-linux-gnueabi -march=armv7-a \
>         -x c -c -o /dev/null -v -
>   ...
>   "<prefix>/bin/clang-18" -cc1 -triple armv5e-unknown-linux-gnueabi ...
>   ...

Right, the kernel definitely relies on -march= taking
precedence over the default CPU, the same way that we
tell the compiler to pick a non-default endianess or ABI.

    Arnd
