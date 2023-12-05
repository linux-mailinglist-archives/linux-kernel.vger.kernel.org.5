Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D73B806128
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346340AbjLEV7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjLEV7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:59:10 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5011F;
        Tue,  5 Dec 2023 13:59:16 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1EEBC5C023F;
        Tue,  5 Dec 2023 16:59:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 16:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1701813553; x=1701899953; bh=oEPjPECBKCwcLWLM3gvDTaE0OrE/1laiUsg
        gX/0Z8LQ=; b=BPXyGSs2AfntfRuxop23q56kYzZvm6+Z1M1CefAV8RqMaetVgu+
        RmgYPipsBCVN0Qygo2br2F+rccLicK4L6zHERNJZ4P+dGBPY89x/byk4GzA9uyOE
        vS6sM8ps5a+i5fXe4fADcbdgzMuweK3cYjiRiVbzpDl9tah9yLFLz/O08bmbEaId
        hCnthgGXiBX6mN5AJkww3XccIuViJcO3MI6tHVLI3YOM7Buu/KCyuGAUO+Cu/CEA
        Rnxna3+q1OZXql8BRJLZ5VEY+Qf8ITJHwJ/7pgpEnAARTU4QgSKfn4enCyIzwuNI
        PkB00Cx6J5gZpza/j45TCOsh55YCwGQq89g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1701813553; x=1701899953; bh=oEPjPECBKCwcLWLM3gvDTaE0OrE/1laiUsg
        gX/0Z8LQ=; b=Ngsc/2d74fYMW+HSP88D+5ke7jBDDXg4d65+v0fgLC4M58TgS1I
        41L7UrMNxjwdbQros+k4Ijx4V1VSXudVD8iYBN3TOd8aMDTsA2EcG2H3n8VTJm52
        eLxaFniSYbmVO066sfcTWq+lVGRxjQGNnFo9QKaczhGshqtAmJMxaOmDT0gOviUp
        qDhSmpPqeEdPDXLkbj4JEN3xoXZFqIAzW751jHIb3vUN5u6EUZUG+G1UTb0zGJJs
        lREsrj83MArqrwQgemMLA/fAzqKr+2gOcykwCq57voKxpmNpwC7frAaHYqi9kXjD
        fTZxFo1FKCSoSs7ssLw9nHDVeeKdJ+04r/A==
X-ME-Sender: <xms:MJ1vZUpwq-IUSeArZPehBvLZdLBo0BqfR1yf4Pf8ywWJxhVPH5qIcw>
    <xme:MJ1vZapnD4LTIGBgHplvDAPFEueWGTdBUxh96ppETC23WM_2aUrVfZBZm58yiGqAe
    KZ793lGtmL8ew>
X-ME-Received: <xmr:MJ1vZZM3yisV7hrEtlQbIx3aiGG9XVlwKZh4tLi3Cj5MALc_5Jv-cuGUbMSj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepifhr
    vghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnheple
    ekheejjeeiheejvdetheejveekudegueeigfefudefgfffhfefteeuieekudefnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:MJ1vZb4nb02S891kbL6i3ViwVpk-deFIVklFa7IBwRLdmL13T483Sg>
    <xmx:MJ1vZT5kdHmI2zZKAu4aAGsZsIMJFo0xpE8HBhODbV4OmcaY2VYuVA>
    <xmx:MJ1vZbj-rPY06A01EkRU1udW4SMM1NdIIXkX_fIC3Ztq_oh_9lVF_w>
    <xmx:MZ1vZQwpqxMfz5F4Mc4AYQrCCO7-cG_MeN3ugUsDtcAeD_msTiXh3A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 16:59:11 -0500 (EST)
Date:   Wed, 6 Dec 2023 06:59:07 +0900
From:   Greg KH <greg@kroah.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, tanzirh@google.com,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick DeSaulniers <nnn@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
Message-ID: <2023120608-ivy-snowdrop-890d@gregkh>
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205213807.GE1674809@ZenIV>
 <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOd=2VASkaLvjU+7kkbvhu2CimYn5KUGJBDRePyUhtrNK2Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:51:10PM -0800, Nick Desaulniers wrote:
> On Tue, Dec 5, 2023 at 1:38 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Dec 05, 2023 at 08:58:53PM +0000, tanzirh@google.com wrote:
> > > This diff uses an open source tool include-what-you-use (IWYU) to modify
> > > the include list changing indirect includes to direct includes.
> >
> > How does it account for arch- and config-dependent indirect includes?
> >
> > In particular, on sh this patch breaks, since there word-at-a-time.h does not
> > contain an include of kernel.h, even though it uses REPEAT_BYTE.  This is
> > a very simple case (they really ought to include kernel.h, same as all other
> > instances of word-at-a-time.h), but I would expect arseloads of more subtle
> > breakage in anything less trivial.
> >
> > And I'm not at all sure that there's no config-dependent breakage as well -
> > this had been caught by quick make allmodconfig + make lib/string.o on
> > a bunch of architectures; the graph of indirects includes (as well as the
> > set of symbols needed for given header) is very much config-dependent.
> 
> We're sending these to Kees to stage in branch flowing into linux-next
> in order for the patches to get soak time in linux-next; it's not
> possible to test every possible randconfig, but with enough soak time
> and the bots chewing on linux-next, I think we can get to a certain
> level of confidence.
> 
> We'll ramp up the amount of testing we're doing locally as well. (I
> did quite a few randconfigs locally in a loop; didn't test all
> architectures) We can probably fetch the kernel.org toolchains for
> very extensive testing.
> https://mirrors.edge.kernel.org/pub/tools/crosstool/
> 
> >
> > > IWYU is implemented using the IWYUScripts github repository which is a tool that is
> > > currently undergoing development. These changes seek to improve build times.
> > >
> > > This change to lib/string.c resulted in a preprocessed size of
> > > lib/string.i from 26371 lines to 5232 lines (-80%).
> >
> > It also breeds includes of asm/*.h, by the look of the output, which is
> > not a good thing in general ;-/  E.g. #include <asm/uaccess.h> *anywhere*
> > outside of linux/uaccess.h is a bad idea.
> 
> It's not clear to me when it's ok to #include <asm/*.h>.  Is there a
> convention here that I'm missing?

General rule, NEVER include asm/*.h, there should be a include/*.h
instead that works.  So much so that checkpatch.pl should catch this,
right?

But of course, it doesn't always hold true, there are a few minor
exceptions, but they are rare.

thanks,

greg k-h
