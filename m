Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D827D4806
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjJXHJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 03:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjJXHJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 03:09:52 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF8311A;
        Tue, 24 Oct 2023 00:09:49 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9C7A65C021E;
        Tue, 24 Oct 2023 03:09:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 24 Oct 2023 03:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698131387; x=1698217787; bh=VA
        PNQYkTt0iwP9E8BmBBBQ+AGuWLrzjahGWfYfAXDTU=; b=Iq4nMqJFt+QLEijmKe
        DhAWakAxAABCKSDqfnaR7YZKp4C6NkJZ7ND4rULfLCcWRIEj58zanM9wGS2zfa9Y
        zigc9N6twVfBtoHb/7q4T963hfjST3MCVZ69hA4FycedX/nr9jIzsex4nucM165b
        8S8lq3MNfxN8fNi8+2PM3PuPa6UGG93xLRMvbARixKI5IKAQRtgmx3clr8nTEZSt
        +g1ZXJDAC6vM+1+xWssNnwtYQ6mtYd/Chgcy92evrvdUNiEnzAkCM50GbexM/Zyf
        X+w5MwhnYlmccfEa/uRh05Yi8KNQhavZRGBkeCTeru9JfgYC3qFr4kJkJzvnsDXD
        BRyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698131387; x=1698217787; bh=VAPNQYkTt0iwP
        9E8BmBBBQ+AGuWLrzjahGWfYfAXDTU=; b=GrXfpeE3r3mgoKD0ZLFpG4MFcGkPs
        64U5UZhK0ca0Gplz9Bo7SHqhv+yZmBg+COuY1I1hzcwBcVJ/jeWSVRTdCHCPzh29
        Kf/ZA6fC4x18y/S770OfsOykJYvIHKs348pkPCngIVeSm+SxUEDlFqXWvmPKzfPr
        19nTjJuvTXn2bftghg3s2Br7hXIAZlt3TGJDuL+Nj+kgVCpLaTtCWjaNDShU+YBP
        SFyHmxcYrpUUGVEcf5ijCNaA2AE2zpUSLSeaiQUURwLVEtCLsUeltQzwAFp3jhBR
        MJQCUQUBSM+v/yfA32pWu79lRI9MEuCNPnLIOA0EbWWMz1KsiIL/sN9uA==
X-ME-Sender: <xms:um03ZWPcUaARydLqvs68I6lWKmGM1lbzSfWN9_Lu9NVM9N2EJ_ZYLQ>
    <xme:um03ZU_kFRyvhhqgqIPu6p9yGytDuavIAk75-G3JSaDMBvupJxjGRMXhgGgr0AFpv
    c3RSw_wD2oszbOt7r4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeejgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:um03ZdSHpZIMBHo6YJ0_yJY7RCmTPHB9QDYVFmh_XfY1vkLCmcXWMQ>
    <xmx:um03ZWu51nw9UtGXRtOtrGUEjeKyLRGpza2YE-MJX8GsFuL-HgwbYg>
    <xmx:um03ZefY6gYyhDw_MtxykWTZxyR5xK8QSZlz4O1_b9SxIPPOQV6z3g>
    <xmx:u203ZYFkf9pGyGvQPIRJAR1V8T0paAznFA4dDWl74L2MPtnR-nhSGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DE6A7B60089; Tue, 24 Oct 2023 03:09:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <b771991b-46fe-4eab-bcad-2325acf90d80@app.fastmail.com>
In-Reply-To: <ZTdDy8ScUPxJOBHs@MiWiFi-R3L-srv>
References: <20231023110308.1202042-1-arnd@kernel.org>
 <20231023110308.1202042-2-arnd@kernel.org> <ZTdALtO2rN4FaneC@MiWiFi-R3L-srv>
 <ZTdDy8ScUPxJOBHs@MiWiFi-R3L-srv>
Date:   Tue, 24 Oct 2023 09:09:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Baoquan He" <bhe@redhat.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Vivek Goyal" <vgoyal@redhat.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Eric DeVolder" <eric.devolder@oracle.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Ard Biesheuvel" <ardb@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        "Hari Bathini" <hbathini@linux.ibm.com>,
        "Costa Shulyupin" <costa.shul@redhat.com>
Subject: Re: [PATCH 2/2] kexec: select CRYPTO from KEXEC_FILE instead of depending on
 it
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

On Tue, Oct 24, 2023, at 06:10, Baoquan He wrote:
> On 10/24/23 at 11:55am, Baoquan He wrote:
>> On 10/23/23 at 01:01pm, Arnd Bergmann wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> > 
>> > All other users of crypto code use 'select' instead of 'depends on',
>> > so do the same thing with KEXEC_FILE for consistency.
>> > 
>> > In practice this makes very little difference as kernels with kexec
>> > support are very likely to also include some other feature that already
>> > selects both crypto and crypto_sha256, but being consistent here helps
>> > for usability as well as to avoid potential circular dependencies.
>> > 
>> > This reverts the dependency back to what it was originally before commit
>> > 74ca317c26a3f ("kexec: create a new config option CONFIG_KEXEC_FILE for
>> > new syscall"), which changed changed it with the comment "This should
>>                        ~~~~~~~~~~~~~~ typo
>> > be safer as "select" is not recursive", but that appears to have been
>> > done in error, as "select" is indeed recursive, and there are no other
>> > dependencies that prevent CRYPTO_SHA256 from being selected here.
>> > 
>> > Fixes: 74ca317c26a3f ("kexec: create a new config option CONFIG_KEXEC_FILE for new syscall")
>> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> > Cc: "David S. Miller" <davem@davemloft.net>
>> > Cc: linux-crypto@vger.kernel.org
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> >  kernel/Kconfig.kexec | 3 ++-
>> >  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> LGTM,
>> 
>> Acked-by: Baoquan He <bhe@redhat.com>
>
> Sorry, the patch 1/2 is not sent to me and kexec mailing list, so I
> didn't get the intention of the entire patchset. I need hold the ack
> until I read the patch 1. I have some concerns about patch 1 if I didn't
> misunderstand it. Will come back later when patch 1 reviewing is
> finished.

Sorry about missing you on Cc. If anyone else is looking for the
patch, it's archived at
https://lore.kernel.org/lkml/20231023110308.1202042-1-arnd@kernel.org/

The idea of patch 1 was only to address the build regression on
x86, so I was hoping that part would be uncontroversial. I split
out patch 2/2 since that is intended to actually change the behavior,
hopefully for the better.

I introduced a new regression on riscv that Conor Dooley found, and
that should already be fixed now. It looks like we may need a similar
change on s390

--- a/arch/s390/Kbuild
+++ b/arch/s390/Kbuild
@@ -7,7 +7,7 @@ obj-$(CONFIG_S390_HYPFS)        += hypfs/
 obj-$(CONFIG_APPLDATA_BASE)    += appldata/
 obj-y                          += net/
 obj-$(CONFIG_PCI)              += pci/
-obj-$(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) += purgatory/
+obj-$(CONFIG_KEXEC_FILE)       += purgatory/
 
 # for cleaning
 subdir- += boot tools

but I haven't tested that, and I'll wait for your reply then.

    Arnd
