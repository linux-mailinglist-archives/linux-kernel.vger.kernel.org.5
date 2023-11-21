Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880E37F2842
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjKUJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjKUJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:00:54 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C09E7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:00:49 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2AB4E5C0A84;
        Tue, 21 Nov 2023 04:00:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 21 Nov 2023 04:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1700557246; x=1700643646; bh=xvvWLKkLzuvSAxa33ZZp5h+Rr
        pmORBUXFhEWLoKeOe8=; b=O3neUZnlnUz/+TmWXnvDoUrjjrRhQ/ehGcZmFab5K
        Rkb8n4z0ODZVRITxgs129eOetINtw2TGzN6RUtbYg0V4aAtrvY+S2FfeMjzZIO9N
        ZgRME4jzziq/7tnh4jn2TdrGRdURUppf/nC+RQzWEfi2wZEg+D9gqXeBm8a8SnSP
        1cobglKWQ7UAScI3hpu941jt1GcyoVljnyReDXYuitmPLLoVcE/SU19fB03D047k
        vPzHqDPL46jHdhMGmka2/ZeUE4uGE54+xmFq852EgosLMf21OnzoVRVPpGAJwsoK
        9NKCCJFNGFtIBIqo3WufIBZiWRNZcP8yF7zpNAeC1KCVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1700557246; x=1700643646; bh=xvvWLKkLzuvSAxa33ZZp5h+RrpmORBUXFhE
        WLoKeOe8=; b=GSil586+acMyTZrpMCTNKm4YwnsC3XpvK557xfeA/g12bOfysys
        EnjyjvIVRUmov3AyLJD2ZQsGcGO9RHjE7ppLg9VdxXrYbhWmee3BbVi5F5E1p9Cn
        AUVBHyZJi1hnXHcc8DPv/LhBovrxR71ASSQSYVSw1hz1jKrbzEGMqiVu0sOX7Q1d
        nxUpfz+pKxDAMI4tHedyZOAVR/YeKshcklOpMOM5Zvn5fLLbcGGzXpULVb0j+sDK
        oEi9ONyEYt2YxJ8mr9QMMGVI2MVJGw5NQQZ83dleY8cyPeh8J4dLXNhkahu1qmkb
        6RAmjfxJ3RNEWtESWbdXNS1NOz0bKeq6jGQ==
X-ME-Sender: <xms:vXFcZdyDW2BGHCg6EqXiwFyEKrGfNykwZ12oEhzuZ8d-U2Vb1h2URg>
    <xme:vXFcZdToNN5L2HpJwGQK9eIs9cdmDmoqNrdI3hU3pObfyuzz5K0WvYt0wPK_weBzQ
    2IdvbybWCIcH9xC9ZY>
X-ME-Received: <xmr:vXFcZXXyhZiU37brhqB9Y946Ah5EKqE7AYz_hY8dH9Iqmk5GyFHBA8kB5b-ctgpWVn_aEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthektddttddtjeenucfhrhhomhepfdfm
    ihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovh
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeekieduleeugfevhedtieevudeftdfhleef
    teeuffeuvdetiefgfedutdeggeekleenucffohhmrghinhepghhouggsohhlthdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhr
    ihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:vXFcZfjFnIcmxy_wQdjnn4Mxmw-0v050BjtqONOmd30K7LXllAH0WQ>
    <xmx:vXFcZfDegGRdEyM2nHYt7_GgSMobotCO0uidoLvZoxq6ryWoMoTrqQ>
    <xmx:vXFcZYIoUbkf23ZWTHuNvZvj6lW3bpJFehhIRI6BF5BbHjRufrx1Eg>
    <xmx:vnFcZbtUz3llHOosD4HRlAnLBo6ggUAfAdSAfdiUi7j68Nbb-h7Wew>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Nov 2023 04:00:45 -0500 (EST)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A5E5910A36E; Tue, 21 Nov 2023 12:00:41 +0300 (+03)
Date:   Tue, 21 Nov 2023 12:00:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/mm/encrypt: Use %a asm operand modifier to obtain
 %rip-relative address
Message-ID: <20231121090041.abqwtkbzzwxq22ke@box.shutemov.name>
References: <20231120153419.3045-1-ubizjak@gmail.com>
 <20231120171507.GGZVuUG9aSLyF52jHd@fat_crate.local>
 <CAFULd4aYe=B_Jiag1S4hO0XRXB-Y4UKh2Lat79JOLOB1h8ev4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4aYe=B_Jiag1S4hO0XRXB-Y4UKh2Lat79JOLOB1h8ev4A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 08:58:29PM +0100, Uros Bizjak wrote:
> On Mon, Nov 20, 2023 at 6:15 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Nov 20, 2023 at 04:33:50PM +0100, Uros Bizjak wrote:
> > > The "a" asm operand modifier substitutes a memory reference, with the
> > > actual operand treated as address.  For x86_64, when a symbol is
> > > provided, the "a" modifier emits "sym(%rip)" instead of "sym".
> > >
> > > Clang allows only "i" and "r" operand constraints with an "a" modifier,
> > > so the patch normalizes the modifier/constraint pair to "a"/"i"
> >
> > s/the patch normalizes/normalize/
> >
> > > which is consistent between both compilers.
> > >
> > > No functional change intended.
> > >
> > > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> > > ---
> > >  arch/x86/mm/mem_encrypt_identity.c | 16 ++++------------
> > >  1 file changed, 4 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> > > index d73aeb16417f..6a351fdd1b39 100644
> > > --- a/arch/x86/mm/mem_encrypt_identity.c
> > > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > > @@ -346,9 +346,7 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
> > >        * We're running identity mapped, so we must obtain the address to the
> > >        * SME encryption workarea using rip-relative addressing.
> > >        */
> > > -     asm ("lea sme_workarea(%%rip), %0"
> > > -          : "=r" (workarea_start)
> > > -          : "p" (sme_workarea));
> > > +     asm ("lea %a1, %0" : "=r" (workarea_start) : "i" (sme_workarea));
> >
> > Yeah, I saw that particular subthread today.
> >
> > Are you sure this "a" modifier DTRT with all gcc version we support?
> >
> > I.e., from 5.1 onwards...
> 
> Yes [1].
> 
> [1] https://godbolt.org/z/aWe7b16rT

But Clang generates RIP-relative load only starting from version 15.
Clange 11 claimed to be supported.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
