Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22347F29B1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234178AbjKUKDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjKUKDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:03:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A3F5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:03:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095ABC433C9;
        Tue, 21 Nov 2023 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561010;
        bh=koXHjXCkUn9fEpUuj0fKfGenlf1DnXywIbJ9kbvHrHE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=fKP5KSwWc0vw/gLa5kt8qk6+lo2wOlm558Kp/3bTafIQKbJKJTWPqEJjKaeUAX7y8
         lI/mLvyNmGQhlLZouOBMCl3g6aAOpSNyDrhoV71M3Z/662sGs+owMgvSOtTNFtDtB8
         Rm+MlDpvL6WVL9hV9ZkUxOHwfJ5DfV7FGmLsYj5tZxOppcBLk5S9PrNzRLuHpIkwxI
         3tl3JWu7fPo9PK9/X+xC7TqrMyl6pQ2+GS+Oq0dJUKOZb9zJ7jrw1pzzk7tHKEXrNm
         sIKaEScK6WaYrclQRJxXbap5Jsz+GLWY6IownzJ4N9OTQw8S+sUAY0s39UN1gj+p9L
         28cgRXamBW+sQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id D370727C005A;
        Tue, 21 Nov 2023 05:03:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 05:03:28 -0500
X-ME-Sender: <xms:boBcZbluc3CT5VEFi0XSJ8laKM9wVQPCM013zcHKAQgfaYEawi69eA>
    <xme:boBcZe12Il_u3xBgm9-DoUYdskGdXTaK64_dCC8LRURzVVf7XT0EHllFne0vGbeI9
    2PFWS0dg6UK92Ji08Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:boBcZRrpYZhc8pwM4X8IiM6z3lr7Vfnm7_htX1pqT2Z1nY8fuJ1KEw>
    <xmx:boBcZTkI-Y0ALQS0KTwyNIpwkrzo-S1MZ9BAs2UVnbK9TLpHjnYPHQ>
    <xmx:boBcZZ16O28a-V6cf8Wh2a_zPX4nGfaK0QT4ziqBR874TT3YZFgydg>
    <xmx:cIBcZbUmQS6lprpe-tdiaKvWohcrEkf9bRpEPRprQaWYH7e0vbPKnlCep0qCawFi>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A9496B60089; Tue, 21 Nov 2023 05:03:26 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
In-Reply-To: <20231120215945.52027-6-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-6-pstanner@redhat.com>
Date:   Tue, 21 Nov 2023 11:03:06 +0100
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Philipp Stanner" <pstanner@redhat.com>,
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
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        "Danilo Krummrich" <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] lib/iomap.c: improve comment about pci anomaly
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> lib/iomap.c contains one of the definitions of pci_iounmap(). The
> current comment above this out-of-place function does not clarify WHY
> the function is defined here.
>
> Linus's detailed comment above pci_iounmap() in drivers/pci/iomap.c
> clarifies that in a far better way.
>
> Extend the existing comment with an excerpt from Linus's and hint at the
> other implementation in drivers/pci/iomap.c
>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

I think instead of explaining why the code is so complicated
here, I'd prefer to make it more logical and not have to
explain it.

We should be able to define a generic version like

void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
{
#ifdef CONFIG_HAS_IOPORT
       if (iomem_is_ioport(addr)) {
              ioport_unmap(addr);
              return;
       }
#endif
      iounmap(addr)
}

and then define iomem_is_ioport() in lib/iomap.c for x86,
while defining it in asm-generic/io.h for the rest,
with an override in asm/io.h for those architectures
that need a custom inb().

Note that with ia64 gone, GENERIC_IOMAP is not at all
generic any more and could just move it to x86 or name
it something else. This is what currently uses it:

arch/hexagon/Kconfig:   select GENERIC_IOMAP
arch/um/Kconfig:        select GENERIC_IOMAP

These have no port I/O at all, so it doesn't do anything.

arch/m68k/Kconfig:      select GENERIC_IOMAP

on m68knommu, the default implementation from asm-generic/io.h
as the same effect as GENERIC_IOMAP but is more efficient.
On classic m68k, GENERIC_IOMAP does not do what it is
meant to because I/O ports on ISA devices have port
numbers above PIO_OFFSET. Also they don't have PCI.

arch/mips/Kconfig:      select GENERIC_IOMAP

This looks completely bogus because it sets PIO_RESERVED
to 0 and always uses the mmio part of lib/iomap.c. 

arch/powerpc/platforms/Kconfig: select GENERIC_IOMAP

This is only used for two platforms: cell and powernv,
though on Cell it no longer does anything after the
commit f4981a00636 ("powerpc: Remove the celleb support");
I think the entire io_workarounds code now be folded
back into spider_pci.c if we wanted to.

The PowerNV LPC support does seem to still rely on it.
This tries to do the exact same thing as lib/logic_pio.c
for Huawei arm64 servers. I suspect that neither of them
does it entirely correctly since the powerpc side appears
to just override any non-LPC PIO support while the arm64
side is missing the ioread/iowrite support.

     Arnd
