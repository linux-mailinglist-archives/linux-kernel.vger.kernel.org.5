Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE66379A1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 05:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjIKDYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 23:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjIKDY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 23:24:28 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09A21724;
        Sun, 10 Sep 2023 20:23:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AB8615C0055;
        Sun, 10 Sep 2023 23:23:53 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sun, 10 Sep 2023 23:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694402633; x=1694489033; bh=zp
        vxo3GJwex0j26UspefQuRFPKYsD8Stn98KJVqfyzc=; b=VIdmGYrLMN3WRPf0Jo
        1Dd4gp/R3o3LSUrAibupVlELwksJpqfO3u81gHRdrW4hy1WrDg38YGv7lHFWNQ1q
        cxVe+vGlKqPTtZHtuMaomKJxARzWUkqeqWbiC8asjcFklvjf6JvRuxRj2qgj2a77
        PLpITOshGTj4g4Gx9aCHL6nqQ8Qde2GJKhKazlMsHsXDPxdbMXzYgzu0NFITwZv5
        Vlm7b+ikEqFhzPc3qCCWhbliUvylwBbTto2Cx44x5L9hAUSHmsQBQhlZdYxeWxvK
        yqxBe6dnx9jaTW4Q0GVIyTajjULgcHDTKiRGWJIq2IUzECa4f88rHCl0dL/PQUEH
        3flQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694402633; x=1694489033; bh=zpvxo3GJwex0j
        26UspefQuRFPKYsD8Stn98KJVqfyzc=; b=YkDRsX6e1551vocQmwYYdLGLzqH8/
        05AQhUP0pJ85vunzUoL+YzEbqwyh25nbPRxKJYYaK62MDXY/NInCREokNxh0C5l1
        dQU+kYij1GXyCKdzOHcgYJ6Z3pGLRRChn/NMEp0J4tTgC+ZfigAgniVewgKQit+W
        nubfDDtrauZCefZ+HULFVkx4Acay6rxXogvAmIe3BEYMbGR5J5+ninyCslKA0o0A
        lCQ5axRwmFyCWW4T6FJTteWo91HkM9Re7m76QuGRrjl0F047Fedv/ZlzwWgismC0
        HDcxXdNzzMYUOCMvwCeEHsdBi7mgmqp5Eun0s9+/33pggY/1QU4h9zQzw==
X-ME-Sender: <xms:SYj-ZPeb2fd0_mPtNDY2ko9GEihz487EkZxP-goRakBS66-5JgvKDw>
    <xme:SYj-ZFNucUtp3uH4ByJBkky5s9ZOHfuOkrwsz7VbZsRcxLr7Oww21mt25jJOuoA9u
    iHz0RX87gNfIZQGbD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeifedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredt
    reertdenucfhrhhomhepfdflrghnucfjvghnughrihhkucfhrghrrhdfuceokhgvrhhnvg
    hlsehjfhgrrhhrrdgttgeqnecuggftrfgrthhtvghrnhepffffueefhfeivdefheegveff
    ffffuddvudfhfeejkeegveeihfduvdegkedvvdfhnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:SYj-ZIjjTq7HJ1YFixPBSsDC_HESqghduvok1BRy1apofG_R8P275g>
    <xmx:SYj-ZA99Rg5QTuvVG9JxUz2-eU8bup6Kn556nCh8xijM6VSFI8j7BQ>
    <xmx:SYj-ZLt9dvBdt4Ey0sVJTJ0WD_bsNTzX-L2wAHewnm1LnPVq0uYS7g>
    <xmx:SYj-ZJL_wJQxaomig2nR4_6SNKIUGMbBRdrRYBY9bdqAmoOgsfmUYA>
Feedback-ID: i0fc947c4:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B31B15A0091; Sun, 10 Sep 2023 23:23:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-711-g440737448e-fm-20230828.001-g44073744
Mime-Version: 1.0
Message-Id: <a0e1848a-4411-4a1a-82a9-5cb0080a8323@app.fastmail.com>
In-Reply-To: <CAMw=ZnShMzqH_yiXCS0-O+yR0RZs7+sSm0rqSYwpoygcYdg6hA@mail.gmail.com>
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CAMw=ZnT-Ck-Y4i-MZAf99U5nzgDaj-q8UPRH_c00JgGMtUy_QA@mail.gmail.com>
 <5c94f7f4-697f-4388-9243-009c0c2d745f@app.fastmail.com>
 <CAMw=ZnShMzqH_yiXCS0-O+yR0RZs7+sSm0rqSYwpoygcYdg6hA@mail.gmail.com>
Date:   Mon, 11 Sep 2023 05:23:29 +0200
From:   "Jan Hendrik Farr" <kernel@jfarr.cc>
To:     "Luca Boccassi" <bluca@debian.org>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, bhelgaas@google.com,
        lennart@poettering.net
Subject: Re: [PATCH 0/1] x86/kexec: UKI support
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > - the dtb section also is optional but supported, and given kexec
>> > supports loading a new dtb I think this change should support it too
>> > immediately.  Moreover, we are adding support for multiple DTBs in a
>> > single UKI (by simply having multiple .dtb sections, and picking the
>> > one that matches the firmware), as a stretch goal would be nice to
>> > support that too, but it can also come later
>>
>> As far as I know dtb is not supported by kexec_file_load at all at the moment. Maybe someone here knows more about this. I'll look into it.
>
> Not sure about the specific syscalls, but I definitely use kexec
> --load --dtb on arm64 with existing released versions of
> kernel/tooling

Ok, it looks like this is supported and should be doable (on arm64, not for x86). When I was looking around the source code yesterday I forgot that my LSP had indexed the kernel for x86 and not arm64.

>> > - also what would it take to support arm64, which is the other major UEFI arch?
>>
>> I'm not familiar with UEFI on arm64, but I can certainly look into it. I assume it's not gonna be that difficult.

I'll work on a separate patch for UKI support on arm64 (with .dtb section support). I think it's best to keep this x86 patch separate from that. I have a v2 patch for x86 put together with the small fix for the optional .cmdline section + a few other tweaks that I'll submit shortly.
