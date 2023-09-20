Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9C7A8F19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjITWCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjITWCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:02:41 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEBDC9;
        Wed, 20 Sep 2023 15:02:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6DAC55C0064;
        Wed, 20 Sep 2023 18:02:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 20 Sep 2023 18:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695247351; x=1695333751; bh=I6
        UPNYQdv3Xjc3UL4AIR2FH2hUAbP58GDh15024AvlU=; b=OS0rrYIcBxSE/nnfdt
        CNphdukv2JYmScLPGADJ5PPGKdyKp0qaImx3FRox3XgO79pGrhpc2yWbX34Wr9Np
        88km6TIke7M1uo71MN+VTVlR/k66lmqCD+E7na2KfTbLJ/069+xyYT36cCluNgjk
        qaXtQDjcAT1zGURWqVPczEB3RPI9/h0BuTwI8k876m5SyHpAy2s77ZjzEyi/sNHV
        6wNYXCfSR+ckiE/IHuSCiLFyS2X0j7DJqyNJPTW97P10esRLA1hmY6j/MNQTpGdC
        KFieegB5ahB9gLqvc0QiVitHC1L+HDu6m9553gAcxltAqbAX8BrF4YZyJA9bBEKB
        t6YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695247351; x=1695333751; bh=I6UPNYQdv3Xjc
        3UL4AIR2FH2hUAbP58GDh15024AvlU=; b=kj6pieMgIX1De+3ZpLOXPqXfsxs86
        AXs9rp4cQ6mDKl36y9EpPFoaDIbXOoDnPHf159/XjC/HWSZbKrspr/uaq7f7Wdb5
        REN+v6jhC4EZR8mGDT2wAWc9xct84wFwlEz8rBB71TfqRraXPdjwL4em2f8ie46k
        2485bC0q2KQaVJzTTVBCiDX0rXOMCJIArl4iJh7Gs4IM6WQ7B8+hdE0to3zNsL9m
        4Np0GttmAtdScl8AmH4tMvs9ESgRlJwqz4WelQb4eCtsBgOWk1I0TZy69VwpIpZb
        6UNmEmQ4PSDIJec4fRNQXFLf0+xAYcG8eOzHEi0jGtm5T1E99ZPsZoJdg==
X-ME-Sender: <xms:9msLZW25k2x86_AFSkp4-3uUh5uiaqzlG3ikSlSbFhcTlKyi5B57Yw>
    <xme:9msLZZH977Ffek9HVsV3aHAeyOjUEv3_NcXC-lmhHJvNVnPJrD3U6i520oiHmpExA
    av0haE9unQUyRz_jRc>
X-ME-Received: <xmr:9msLZe6UC9h-9lspx_CD6KGaCrLedclyIdz0sBJkecz08fLJCMUwzd26qCfYQCZ-R--PPBwDzVk8anHqvMDXT9fyyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrhcuoehkvghrnhgvlhesjh
    hfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeeuvdekhfejjeevleeguedvieekudef
    vdetgeefieeuiefhgeeiffehgeetfffggeenucffohhmrghinhepihhnfhhrrgguvggrug
    drohhrghdpkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpuhgrphhiqdhgrhho
    uhhprdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepkhgvrhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:9msLZX2pB1l3kmRhs6cAy3MdtWt11IkOurfkrDWMZiJ2iZDd0EbUfQ>
    <xmx:9msLZZE8CaxEkJvqTRfRorUOEbdn3832DeRNzwt3NCS11ZxNgx0IIw>
    <xmx:9msLZQ-s66D00MLPpgN92I-u38eW7KqCi_e-vwqjdIE1nV_8gKyqnQ>
    <xmx:92sLZWeLCtIXBOwiG89kNjVp5f4puEsygZt_zjylA60e3TG4UFIbnQ>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Sep 2023 18:02:28 -0400 (EDT)
Date:   Thu, 21 Sep 2023 00:02:25 +0200
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Young <dyoung@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>,
        bhelgaas@google.com, Luca Boccassi <bluca@debian.org>,
        lennart@poettering.net, "Liu, Pingfan" <piliu@redhat.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <ZQtr8Y_isZP4nG96@desktop>
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com>
 <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
 <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
 <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFkQ+T9OjK6NkKjfyR8gW4EZKFw5rEk0rgrzkHyK2BNXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard, Greetings from Delft


On 20 10:50:31, Ard Biesheuvel wrote:
> On Wed, 20 Sept 2023 at 08:40, Dave Young <dyoung@redhat.com> wrote:
> >
> > On Wed, 20 Sept 2023 at 15:43, Dave Young <dyoung@redhat.com> wrote:
> > >
> > > > > In the end the only benefit this series brings is to extend the
> > > > > signature checking on the whole UKI except of just the kernel image.
> > > > > Everything else can also be done in user space. Compared to the
> > > > > problems described above this is a very small gain for me.
> > > >
> > > > Correct. That is the benefit of pulling the UKI apart in the
> > > > kernel. However having to sign the kernel inside the UKI defeats
> > > > the whole point.
> > >
> > >
> > > Pingfan added the zboot load support in kexec-tools, I know that he is
> > > trying to sign the zboot image and the inside kernel twice. So
> > > probably there are some common areas which can be discussed.
> > > Added Ard and Pingfan in cc.
> > > http://lists.infradead.org/pipermail/kexec/2023-August/027674.html
> > >
> >
> > Here is another thread of the initial try in kernel with a few more
> > options eg. some fake efi service helpers.
> > https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e
> >
> 
> Currently, UKI's external interface is defined in terms of EFI
> services, i.e., it is an executable PE/COFF binary that encapsulates
> all the logic that performs the unpacking of the individual sections,
> and loads the kernel as a PE/COFF binary as well (i.e., via
> LoadImage/StartImage)
>
> As soon as we add support to Linux to unpack a UKI and boot the
> encapsulated kernel using a boot protocol other than EFI, we are
> painting ourselves into a corner, severely limiting the freedom of the
> UKI effort to make changes to the interfaces that were implementation
> details up to this point.

While this was true at some point, it's not anymore. The intention is
for UKIs to be a stable file format that can be used outside of
systemd-stub. They are no longer just defined by their interface to
UEFI. While the spec will need work it can be found at [1]. This patch
depends on the UKI containing the linux bzimage, initrd, and cmdline in
the sections with those names. We can depend on this in the future.

There is some discussions around supporting more of the UKI features in
the future (TPM PCR signatures, etc). See [2].

> It also means that UKI handling in kexec will need to be taught about
> every individual architecture again, which is something we are trying
> to avoid with EFI support in general. Breaking the abstraction like
> this lets the cat out of the bag, and will add yet another variation
> of kexec that we will need to support and maintain forever.

Yes this would require more work for each architecture that wants to
kexec UKIs (arm64 would be next).

However I think the support required would be way lower than all the
other kexec loaders. I would suggest that this loader is actually really
simple (check the code in the uki_load function in
arch/x86/kernel/kexec-uki.c). All of the heavy lifting is actually done
by the existing bzimage loader. The UKI loader just pulls appart the UKI
and calls the existing bzimage loader, it's really simple. It's like an add-on
to the current loader.

> So the only way to do this properly and portably is to implement the
> minimal set of EFI boot services [0] that Linux actually needs to run
> its EFI stub (which is mostly identical to the set that UKI relies on
> afaict), and expose them to the kexec image as it is being loaded.
> This is not as bad as it sounds - I have some Rust code that could be
> used as an inspiration [1] and which could be reused and shared
> between architectures.

This would be a very cool thing in general though and would open a lot
of possibilities. But how much support will this require? Soon people
will want more than just the minimal set of EFI services for booting
Linux. I do like this idea though and would probably be one of the
people wanting more of the EFI services supported.

> This would also reduce/remove the need for a purgatory: loading a EFI
> binary in this way would run it up to the point were it calls
> ExitBootServices(), and the actual kexec would invoke the image as if
> it was returning from ExitBootServices().
> 
> The only fundamental problem here is the need to allocate large chunks
> of physical memory, which would need some kind of CMA support, I
> imagine?
> 
> Maybe we should do a BoF at LPC to discuss this further?

I definetly won't be at LPC, is it possible to join virtually?

> 
> [0] this is not as bad as it sounds: beyond a protocol database, a
> heap allocator and a memory map, there is actually very little needed
> to boot Linux via the EFI stub (although UKI needs
> LoadImage/StartImage as well)
> 
> [1] https://github.com/ardbiesheuvel/efilite


[1] https://uapi-group.org/specifications/specs/unified_kernel_image/
[2] https://github.com/systemd/systemd/issues/28538
