Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7487F314C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjKUOly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjKUOlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:41:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DDA113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:41:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789C1C433CB;
        Tue, 21 Nov 2023 14:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700577706;
        bh=C7C7k7MQyKejZFr0pldTQeSMPk6gsd2UxQYtxinu5pw=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=CgL2ucQdy94yOgeIDAUwoCO7aWp99U7UxUB44vIJ3zoQMnIR3udHQhZIN5sXyibxH
         czAz+Vx7RKPr3AxsKhd//nrVd+r4N6i7ApCx4lYT3p9DQ1FAkUO2nrLt1C0OvO9hu0
         GyxDqgbOTvqZ+c7ie+Cpemx6xHP6JTyW3ruN+ht4bp54BYF69fMaDHagP5C+KWqEZR
         2GijwYoxOkrfOh8SuugWFy/NFjq/L/cG2cnPsXdIiJTdRvS4sgOyqNK92uVAfKrcXW
         /1IJfJPYZxTj5HxtbY5vKw7lmpV/AzMLvdDw7rTTx/pSoeXW8MDSz83AYujBr+LtqC
         MPuYqOIGMysAw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 51B9927C0060;
        Tue, 21 Nov 2023 09:41:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 09:41:44 -0500
X-ME-Sender: <xms:pcFcZdsWGDQlhmI6n2v2STwpRur8Ex5jMj-OfonBvkm_qP9u5Vehkw>
    <xme:pcFcZWeZpBbfB55MnYno9359Tfus34ITY1sDhe4hW7V3SABXCwWvG2hyrWlObjFSY
    GxTFDh4hpfPDZC8XQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvtddtffejfeeggefgleefgfeghfehfeefffetgffgleegudevveet
    hfefjeevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:pcFcZQwzPDqKgO1eLy9fMP5k2YNWEMyxrZNGFyRrVEVQYyKof1N0OQ>
    <xmx:pcFcZUPwcZ2E04cngCvFBms1fpBUlzIk4d9BIyGmL2zgsp3AgKymCA>
    <xmx:pcFcZd9CZzsabkHxDxckarU4_obPREarv2t_-o-ecM-cKfM6Kg3-eQ>
    <xmx:qMFcZYdm9j_565d_pkgW7CpQU98cxirDUwH0UjRGVxVLDJqpUCXQGyo-hO4RixM3>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D1C33B60089; Tue, 21 Nov 2023 09:41:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <5bd85a64-5161-4312-831d-cba420e20bfb@app.fastmail.com>
In-Reply-To: <9a5f21b69709121c8b342bb44e0b7f83deacd10d.camel@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-6-pstanner@redhat.com>
 <a9ab9976-c1e0-4f91-b17f-e5bbbf21def3@app.fastmail.com>
 <9a5f21b69709121c8b342bb44e0b7f83deacd10d.camel@redhat.com>
Date:   Tue, 21 Nov 2023 15:41:21 +0100
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023, at 15:38, Philipp Stanner wrote:
> On Tue, 2023-11-21 at 11:03 +0100, Arnd Bergmann wrote:
>> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
=20
>> We should be able to define a generic version like
>>=20
>> void pci_iounmap(struct pci_dev *dev, void __iomem * addr)
>> {
>> #ifdef CONFIG_HAS_IOPORT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iomem_is_ioport(addr)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ioport_unmap(addr);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> #endif
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iounmap(addr)
>> }
>
> And where would you like such a function to reside?
> drivers/pci/iomap.c?

Yes, I think that would be the logical place. It could also
be an inline function but that's not great on architectures
that don't also have iomem_is_ioport() inline.

    Arnd
