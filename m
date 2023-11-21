Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5F7F29DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjKUKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjKUKLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:11:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323FEB9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:11:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7398C433C7;
        Tue, 21 Nov 2023 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561476;
        bh=pwVt1w2LCBRnUv5jOmI2812LEvoFjTvS4hIHofg4Jas=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=ZfZFYfxxS0kEHfQDfWXH7ireMlOgqyx0yaQJpgectuibgt0G+FYx8HopU8/OaKkz5
         gwTPcWEuCRVaCMTRvG2KtNLyFRnPUT1suQ177UA3k4kPlnuDBTJWdemwwyPyuZJcZe
         OChqB/BfYEZOCrB+0gwXyXTx9IeCctN/En00qnrUbSO/pfSK2DaEajRnqsYDORzw/T
         TnlaxAL7RX+th+wCKBklOyVpclKZPe4/JvYWoaX2wCh9iuTQod8xXeHJzIvDWdoWPH
         MfeqPSklfM2dKl47JXR25E9f9KFSIICu2K0ZCHHSP3mduSOyVkdVmVIcgmf2YgxAKd
         INCwXxdSIhk6Q==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id B7F6C27C005B;
        Tue, 21 Nov 2023 05:11:14 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 05:11:14 -0500
X-ME-Sender: <xms:QYJcZZOsH-mUuunCB8jsICA8SXmqvbkSxX1urvM880E4tme3cLuZlA>
    <xme:QYJcZb-oApEEEdyISnFgBNPFhuiLciclgtIj9IVX4c1_eE_Ks-3s54Qr18zMPd1sM
    eL6hCqjRnZwHdrQ7wI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:QYJcZYTLMUsoPYYkz62VgwTBcINyKVI2lw5kKpIfQECglAjBavdKCw>
    <xmx:QYJcZVurnxtwUR2GwTR2ilONbym90xq-UPJ7Bb--HnT48TJc_se0cQ>
    <xmx:QYJcZRd8F1UQEgvCOM7pkVREzFPo_LQM6LrJjsar-2maBiq35vKfIg>
    <xmx:QoJcZX_Dw3364yokzNFcp-_h9mYEYM8RCotQIHlbuZhsgZXupblPGF68Rgz_ttDl>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6C63CB60089; Tue, 21 Nov 2023 05:11:13 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <f4cded7b-c62a-453e-b09f-6fe39b4a9c1a@app.fastmail.com>
In-Reply-To: <d38d1149fdf5eb0cc4da12402ca03604beba1881.camel@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-4-pstanner@redhat.com>
 <45997863-d817-48c7-ad46-8b47f5e0ce61@app.fastmail.com>
 <d38d1149fdf5eb0cc4da12402ca03604beba1881.camel@redhat.com>
Date:   Tue, 21 Nov 2023 11:10:41 +0100
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
Subject: Re: [PATCH 2/4] lib: move pci-specific devres code to drivers/pci/
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

On Tue, Nov 21, 2023, at 09:00, Philipp Stanner wrote:
> On Tue, 2023-11-21 at 08:29 +0100, Arnd Bergmann wrote:
>> On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
>> 
>> Since you are moving the pci_iomap() code into drivers/pci/ already,
>> I'd suggest merging this one into the same file and keep the two
>> halves of this interface together.
>
>
> I'd argue that they are as much together as they were before:
>
> Previously:
>  * PCI-IOMAP-code in folder lib/ in its own file (pci_iomap.c)
>  * PCI-Devres-code in folder lib/ in a distinct file (devres.c)
>
> Now:
>  * PCI-IOMAP-code in folder drivers/pci/ in its own file (iomap.c)
>  * PCI-Devres-code in folder drivers/pci/ in its own file (devres.c)
>
> Or am I misunderstanding something?

They are indeed closer together now, just not in the same file.

Looking across subsystems at the output of

git grep -l EXPORT.*devm

I see that 10 out of 182 files have split the devres functions
into a separate file, while the others just keep the devm_*
function in the same place as the normal one. Since you never
have one of these files without the other, and they do
almost the exact same thing, a single file is the simpler
option.

Note that there are also three pcim_*() functions in
drivers/pci/pci.c. I think that is the correct place for
them, but if you wanted to split out pci devres functions
into a separate file, they would now also have to go
into drivers/pci/devres.c.

     Arnd
