Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7E97FDE85
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjK2Rhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Rhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:37:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CCBF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:37:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79736C433C8;
        Wed, 29 Nov 2023 17:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701279476;
        bh=lJyy3cA15cbgMVL8KhADRDQs1MK00XO4WULr9ZayULc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=bhfR2UoUKb5fr2G4p6VFK2S1Ppt0/o9rie3j3bZVYpyR2uZ46MOtrpChm5gG/YHeY
         d4e84r9qTNpZf6MFWEQLfje1QtIJNTswysbw6//VOLD7l+9lm24649zNRlptTpLij6
         nDSqQWc7EEPJxL3z6dUS49Kc3apEOlwMi8328GYBhLyjX2DoqmLM6PET9Kv32emYCb
         lj0Syp2wSuClxWEMtnsRaZbZlOaaparuflWmh9lkxNjGMOzpMVf1BkWN+9I8H5SMaC
         yGUOEvtTWKPjdjkXdEO1e9GZcEC8GXaT3XH+S2PXNhJmVOafj6LF1zEgwjSnP3+UyC
         S+ivGMiHIwnJA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5BA0727C0054;
        Wed, 29 Nov 2023 12:37:54 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 Nov 2023 12:37:54 -0500
X-ME-Sender: <xms:8HZnZZElDIQDSLi7Mq1xJtCymGQrfYQfR9wKeMxn576aXU_tb6NLmg>
    <xme:8HZnZeVgjsoLjlGeZyQw93qSys0lXSNDkjUlQK8NwlKYY0somz3rXxPor1fgjUECd
    9VTw3eQLjeImgiEHgo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeihedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdffjeefgeeggfelfefggefhheeffefftefggfelgeduveev
    tefhfeejveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedu
    jedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnug
    gsrdguvg
X-ME-Proxy: <xmx:8HZnZbJXKQprg0QjyS75x0AA7yYiwGz99Z0wzuR6RN9_u88W9gVMQA>
    <xmx:8HZnZfGuX_GtAPjfjkfQuh2kRE0rSCD9Kvu-_04ibDCJqtOCex1usA>
    <xmx:8HZnZfXGWT1nGTDMDYes3r89jPHyPVFrG9owBcGla_gdsDjcgA2qbg>
    <xmx:8nZnZc3HqRhbtNP9wyAqHqeB7JkWLgYZhY4ha-GuJU26ugLMV7JoZrTteO0>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3F299B60089; Wed, 29 Nov 2023 12:37:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1234-gac66594aae-fm-20231122.001-gac66594a
MIME-Version: 1.0
Message-Id: <8c45a36e-60f9-49ee-aa77-aaba8ac5e62f@app.fastmail.com>
In-Reply-To: <b13191e7a5ad63de23adb8ec3f8a3699a0dd236e.camel@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-6-pstanner@redhat.com>
 <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
 <a6ef92ae-0747-435b-822d-d0229da4683c@redhat.com>
 <b13191e7a5ad63de23adb8ec3f8a3699a0dd236e.camel@redhat.com>
Date:   Wed, 29 Nov 2023 18:37:25 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Philipp Stanner" <pstanner@redhat.com>,
        "Danilo Krummrich" <dakr@redhat.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Eric Auger" <eric.auger@redhat.com>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Neil Brown" <neilb@suse.de>, "John Sanpe" <sanpeqf@gmail.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Yury Norov" <yury.norov@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "David Gow" <davidgow@google.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        "Jason Baron" <jbaron@akamai.com>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023, at 11:16, Philipp Stanner wrote:
> On Fri, 2023-11-24 at 20:08 +0100, Danilo Krummrich wrote:
>>
>> lib/pci_iomap.c contains another definition of pci_iounmap() which is
>> guarded by ARCH_WANTS_GENERIC_PCI_IOUNMAP to prevent multiple
>> definitions
>> in case either GENERIC_IOMAP is set or the architecture already
>> defined
>> pci_iounmap().
>
> To clarify that, here's the relevant excerpt from include/asm-
> generic/io.h:
>
> #ifndef CONFIG_GENERIC_IOMAP
> #ifndef pci_iounmap
> #define ARCH_WANTS_GENERIC_PCI_IOUNMAP
> #endif
> #endif

Right, this was added fairly recently in an effort to
unify the architectures that can share a simple implementation
based on the way that modern PCI host bridges on non-x86
work.

>> What's the purpose of not having set ARCH_HAS_GENERIC_IOPORT_MAP
>> producing
>> an empty definition of pci_iounmap() though [1]?
>>=20
>> And more generally, is there any other (subtle) logic behind this?
>
> That's indeed also very hard to understand for me, because you'd expect
> that if pci_iomap() exists (and does something), pci_iounmap() should
> also exist and, of course, unmapp the memory again.

Right, I think that was a leak introduced in 316e8d79a095
("pci_iounmap'2: Electric Boogaloo: try to make sense of
it all") that should be fixed like

--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -170,8 +170,8 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *=
p)
=20
        if (addr >=3D start && addr < start + IO_SPACE_LIMIT)
                return;
-       iounmap(p);
 #endif
+       iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);

i.e. architectures without port I/O just call iounmap() but those
that support the normal ioport_map() have to skip iounmap()
for ports in that special PIO range.

> Regarding the last point, a number of architectures define their own
> ioport_map():
>
> arch/alpha/kernel/io.c, line 684 (as a function)
> arch/arc/include/asm/io.h, line 27 (as a function)
> arch/arm/mm/iomap.c, line 19 (as a function)
> arch/m68k/include/asm/kmap.h, line 60 (as a function)
> arch/parisc/lib/iomap.c, line 504 (as a function)
> arch/powerpc/kernel/iomap.c, line 14 (as a function)
> arch/s390/include/asm/io.h, line 38 (as a function)
> arch/sh/kernel/ioport.c, line 24 (as a function)
> arch/sparc/lib/iomap.c, line 10 (as a function)
>
> I grepped through those archs and as I see it, none of those specify an
> empty pci_iomap() that could be a counterpart to the potentially empty
> pci_iounmap() in lib/pci_iomap.c

I'm trying to unwind what you are saying here, and there are
two separate issues:

- an empty unmap() function still makes sense if the map() function
  just returns a usable pointer like the asm-generic version
  of ioport_map(), it only has to be non-empty if the map function
  allocates a resource that has to be freed later, like the
  page table entries for most ioremap() implementations.

- pci_iounmap() in lib/pci_iomap.c being empty is probably
  just a bug

>> From what I can tell looking at the header, I think we can
>> just remove the "#elif defined(CONFIG_GENERIC_PCI_IOMAP)"
>> bit entirely, as it no longer serves the purpose it originally
>> had.
>
> So it seems that the empty unmap-function in pci_iomap.c is the left-
> over counterpart of those mapping functions always returning NULL.

no

> @Arnd:
> Your code draft
>
> void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
> {
> #ifdef CONFIG_HAS_IOPORT
> if (iomem_is_ioport(addr)) {
> ioport_unmap(addr);
> return;
> }
> #endif
> iounmap(addr)
> }
>
> seems to agree with that: There will never be the need for an empty
> function that does nothing. Correct?

Agreed, while arch/sparc/ currently has an empty pci_iounmap(),
that is just because the normal iounmap() on that architecture
is also empty, given that all MMIO memory is always mapped.

>> > {
>> > #ifdef CONFIG_HAS_IOPORT
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iomem_is_ioport(addr=
)) {
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ioport_unmap(addr);
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return;
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> > #endif
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iounmap(addr)
>> > }
>> >=20
>> > and then define iomem_is_ioport() in lib/iomap.c for x86,
>> > while defining it in asm-generic/io.h for the rest,
>> > with an override in asm/io.h for those architectures
>> > that need a custom inb().
>>=20
>> So, that would be similar to IO_COND(), right? What would we need
>> inb() for in this context?

In general, any architecture that has a custom inb() also
needs a custom ioport_map() and iomem_is_ioport() in this
scheme, while the "normal" architectures like arm/arm64 and
riscv should be able to just use the asm-generic version.

IO_COND() is really specific to those architectures that
rely on the rather misnamed GENERIC_IOMAP for implementing
ioport_map().

     Arnd
