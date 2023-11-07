Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF327E3D22
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbjKGM0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjKGMZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:25:54 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD8289E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 04:18:25 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E1AE25C0257;
        Tue,  7 Nov 2023 07:18:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 07 Nov 2023 07:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1699359482; x=
        1699445882; bh=VAEwo8KOUsK6uSerfegtu1pr87C48EnHQkGfQIDgWKU=; b=v
        581JpKJgtzGgMkwQI7oRgC2c6KiqLZ5FU/DRgWP4AV/9TmvlXaSkeAw2Qm3BmnP8
        jUU/XxboNB7jgCPsTGTa+vD9u28/eyNohTQmK3z7eDldhcrvOH+WPuqQ9NU8lWCW
        DWS+hLAdflet1oRXIJlw5pYsguNiXw80vfTLIgdmOqMFdLqY5qU8jaEzEcMFti6+
        aiYL59V1+uMDP5GVBlsG96y9fA3zPjo7imI+eGdx+Z7DCJKY4cwfPNsbFYwKoQIY
        /6wCGBN8e+NTn2UgEQDDqjTvXdmuczrQ5CVdH0fAN6CWtd//THLrEKX8mUL5x8gz
        +EqEwyXzIHryyCGq1y9rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1699359482; x=1699445882; bh=VAEwo8KOUsK6u
        Serfegtu1pr87C48EnHQkGfQIDgWKU=; b=GiurI7MDATJs84n+0RpI/6qor4ivC
        UCkPkivN2t9/YRbvXQrCFdGkebeoTOG9P0uSBviYA5jlg06HqAagiOp47O6jTKIU
        a49f6PYYmZZ8eKwdsSl1XJm6eJgYORePbkApbFg/CmD+Ei89ZXIL17QaAhx5iOJ4
        ETj/TPvDnB7fSU0S0TLdJExsul3Rjd+z9rlcAiclWWbQGgQDS48QPfov12viKBPK
        weeYbTMiBMmhlxEo7t/TZsESN0nXDSX82tph+Pi/Qg16BVLJwRgKMvN0/hG5R5fM
        VzHgHsI8++Van4j+zGY8BHk47nU+aLSuRoUyXZ6Pz3SdO/uUTyWYMjsow==
X-ME-Sender: <xms:-SpKZQpMRutNScnrU3xDyqg8f6cZZGNF9I6RBkax6dZZsc2MHDI3fQ>
    <xme:-SpKZWp4bWITM0FUapsSrfy-WfShS07sAIsbpv3uESEgwchY6s4KiXsnwRj1JDbri
    oVJwUpCki8zRVBd7w4>
X-ME-Received: <xmr:-SpKZVPZ4yd-7k_kKL7sWGFbctBmL1uBoWanpLNiuDBxqGQ6iNzFYh4s8Na-HLkj5805XyzLGJreCuk4_40zFsRP67QtbQWV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepudeufffhjeefjeevieekvdfhjeduhfdtgeefuddt
    leetjeffgeekleffleegfeeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhush
    gvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:-SpKZX6Gq0is_4eO32oNZY2zeKOyz2C1L51NTrj5eDk6lcYMVRkAZw>
    <xmx:-SpKZf47SYj-W77tozLzBzJDPqfLlNNfWcDEx_cdVzIH-etEyh7xsw>
    <xmx:-SpKZXhbI-ZPWr7LV0zUNu89g-9k-fye6xSRf2MS-5PFyALFqYceEA>
    <xmx:-ipKZVSPQjtADUn3ZqKavMHUunMXwGLL9PrWT0XhZgn-InBsMDNA3w>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 07:17:59 -0500 (EST)
Date:   Tue, 7 Nov 2023 21:17:56 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
        LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
        bagasdotme@gmail.com
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Message-ID: <20231107121756.GA168964@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
        LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
        bagasdotme@gmail.com
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thanks for the report.

I apologize for the inconvenience you and your reporter facing, however
I can not avoid to say that the problem appears to be specific to the AMD
Ryzen machines.

I've already received the similar report[1], and have been
investigating it in the last few weeks, then got the insight. Please take
a look at my short report about it in PR to Linus for 6.7-rc1:
https://lore.kernel.org/lkml/20231105144852.GA165906@workstation.local/

I can confirm that I have been abe to reproduce the problem on AMD Ryzen
machine. However, it's important to note that I have not observed the
problem on the following systems:

* Intel machine (Sandy Bridge and Skylake generations)
* AMD machines predating Ryzen (Sempron 145)
* Machines using different 1394 OHCI hardware from other vendors such as
  TI
* VIA VT6307 connected directly to PCI slot (i.e. without the issued
  PCIe/PCI bridge)

Currently, I have not been able to obtain any useful debug output from
the Linux system or any hardware error reports when the system reboots.
It seems that the system reboots spontaneously. My assumption at this
point is that AMD Ryzen machines detect a specific hardware error
triggered by Ryzen machine quirk related to the combination of the Asmedia
ASM1083/1085 and VIA VT6306/6307/6308, leading to power reset.

I genuinely appreciate your assistance in debugging this elusive
hardware issue. If any workaround specific to AMD Ryzen machine quirk is
required in PCI driver for 1394 OHCI hardware, I'm willing to apply it.
However, it is preferable to figure out the reboot mechanism at first,
I think.

On Mon, Nov 06, 2023 at 02:14:39PM -0600, Mario Limonciello wrote:
> Hi,
> 
> I recently came across a kernel bugzilla that bisected a boot problem [1]
> introduced in kernel 6.5 to this change.
> 
> commit dcadfd7f7c74ef9ee415e072a19bdf6c085159eb (HEAD -> dcadfd7f7c7)
> Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date:   Tue May 30 08:12:40 2023 +0900
> 
>     firewire: core: use union for callback of transaction completion
> 
> Removing the firewire card from the system fixes it for both reporters
> (CC'ed)
> 
> As the author of this issue can you please take a look at it?
> 
> Thanks,
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217993


[1] https://bugzilla.suse.com/show_bug.cgi?id=1215436
[2] https://bugzilla.kernel.org/show_bug.cgi?id=217994

Thanks

Takashi Sakamoto
