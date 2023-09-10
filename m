Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2E799C4F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjIJCUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 22:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjIJCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 22:20:14 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9177F1B5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 19:20:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 90AAE5C00F4;
        Sat,  9 Sep 2023 22:20:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 09 Sep 2023 22:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1694312408; x=
        1694398808; bh=xrUrQhu0bKn4V0R/7QZgiQCA2ML5d9qouROX3hkBCJo=; b=t
        ZmU/8ZK10ef7RQsh5BbFhHq3gBSIRMNFClmXdXSHMHbTHt2EmETGJbH5xJ9y36FX
        Nll8R4rt+MLvFZBETxIRdsyuaAY4EQgGrtqtpkSY5C20UFX7JI+3HyJPVH75Xjtr
        H5532wpifrx2zUcXJWI7V0s4ljQi9j+ew0+lwv0bi8eMQZ1A4PELioo7SNHrZ7ks
        wKoES4EE4yvHjC/3wtGbOHEfWNzrFtqW2sq97vou5tkYsqKlSJuPl8GZFjObcvvz
        zM/xesdiFZfrSsyQ9kimDtzis4+BBkJz/ZmFmY+mUI96r7MYpd4GsETD2R/WTB3W
        wF1bBGBHkNLw2Umgr8Ybw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694312408; x=1694398808; bh=xrUrQhu0bKn4V
        0R/7QZgiQCA2ML5d9qouROX3hkBCJo=; b=Q1aR05P2kxJu/pkxX6HD+PD9WiWdT
        rEV2MmSvQsDphpr3/6cWGKSfvivTcTcMMKS1blX7sFkk6sCS+muH8yRk6IFAOm2a
        vZff7lxnuXUJQE4LVScEavHWF8ZWa3MnxIrf8wc430PBnNAIqYXs/0ypULff/a4w
        9qoeVYbf+EcuqbzDRdW6mIRnxJX5NWKoye2BNjZmsZdGC/Q8k5SB6RMjQK4w1z3w
        7P5t3mQDhf0jYlFE++FxWM64QLYUWdz0ITi2GUG4NOyJY8eM6hxyHRJJGlqeHer3
        CG1AhVlutdZTKRjhk+2vnK355BXzp0RBbCrU8knnKtC0B2J4Wrd8lvz0A==
X-ME-Sender: <xms:2Cf9ZHjJp_0rg958Yi7P2-xSWyqiJgD3mMgLxDiojaj6PsdRlFSQBw>
    <xme:2Cf9ZEC0CNJCSsW1le3xIKRu_3hCkKo1eZmhiHP8waJxvwnl807KDFldT4gdCSGTJ
    B-ZAcYfX4uakS6Il4Q>
X-ME-Received: <xmr:2Cf9ZHGXBuLd7K7LtjS4YVjGzcXLjz8Q5nuhy6cPWnXt1wCybbJuGsWf7eQL2NAOA5Ha95W60UI_cP5ws8XbnWrHlkYbqF6wwzih>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeitddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2Cf9ZERt7Qfuy6naXAwTPcF4xBgKNiJniHZ7t6W_nmCEc2w4pChTVw>
    <xmx:2Cf9ZExiNp-jFFFxFvwggewpu8oW2KbVyb-jXMWoIrWgDfS0esIDtQ>
    <xmx:2Cf9ZK6-bq1LB8SRM9edMItb0kpregBIcBM-b3CROcZRSvaynTVKJQ>
    <xmx:2Cf9ZBpdo55ZsJ7aZmUXPUCrGs_S76NohplTleOXkj4bQhV8brjUZg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 22:20:07 -0400 (EDT)
Date:   Sun, 10 Sep 2023 11:20:03 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] firewire updates for 6.6
Message-ID: <20230910022003.GA67045@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Engelhardt <jengelh@inai.de>, linux-kernel@vger.kernel.org
References: <20230909033457.GA59845@workstation.local>
 <CAHk-=wjHYum5R1hbVFxqEYDt6baZGh7zzKNpv_R3sGbtN0=-dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjHYum5R1hbVFxqEYDt6baZGh7zzKNpv_R3sGbtN0=-dQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, Sep 09, 2023 at 11:28:14AM -0700, Linus Torvalds wrote:
> On Fri, 8 Sept 2023 at 20:35, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
> >
> > In the second half of 6.6 merge window, Jan Engelhardt sent the change. It
> > allows any front ends of Kconfig to deactivate FireWire subsystem at a
> > clip.
> 
> I pulled this, but after looking at it, I unpulled it again.
> 
> We *already* had this. Saying 'N' to the existing FIREWIRE option
> would disable all of the firewire stack, since the rest then just has
> 
>         depends on FIREWIRE
> 
> on it.
> 
> The only exception is the firewire sniffing side (FIREWIRE_NOSY),
> which technically doesn't need the firewire stack to exist or to work.
>
> The other thing this adds is a
> 
>         depends on PCI || COMPILE_TEST
> 
> for the firewire subsystem, which makes sense since the controllers
> all depend on PCI even if the code itself doesn't care (thus the
> COMPILE_TEST) part.
> 
> Anyway, both of those changes are fine by me - but adding a new config
> option, and bothering users that want firewire support with TWO
> questions about "do you want firewire" is just annoying and frankly
> just stupid.
> 
> I have said this five hundred times before, but I guess I'll say it
> five hundred times again (the Proclaimers even wrote a song about it):
> we don't make the config options worse, and we don't ask people stupid
> things.
> 
> So no.
> 
> The actual core limitations I'd be ok with: just add that
> 
>         depends on PCI || COMPILE_TEST
> 
> to the *existing* FIREWIRE config, and add a
> 
>         depends on FIREWIRE
> 
> to FIREWIRE_NOSY for all I care. That potentiall y*removes* annoying
> questions, not adds them.
> 
> And if people want to change the existing menu to a menuconfig
> (*keeping* the existing FIREWIRE config option, not adding a new one),
> that's fine too.
> 
> But this "let's add yet another mindless option to ask users" is _not_
> acceptable.
> 
>               Linus

Indeed, the additional option would be annoying to users. I figure out
that It is reasonable to avoid the change and stop 'history repeats'.

Ideally, core functions of FireWire subsystem in firewire-core can be
built without dependency on PCI subsystem, but actually it depends, as
we can see in comment of the menu option. The nosy driver is for Texus
Instruments PCILynx device and should depends on PCI subsystem. We can
see apparent difference between these two cases of dependency on PCI
subsystem. I doubt the loss of direct dependency on PCI subsystem in nosy,
at present.

Anyway, the requester has already sent another patch[1]. I postpone it
and continue discussion with him for next merge window.

[1] https://lore.kernel.org/lkml/20230909221248.2598-1-jengelh@inai.de/


Thanks

Takashi Sakamoto
