Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0747F2655
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjKUH3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjKUH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:29:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6839FC8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:29:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208BAC433CA;
        Tue, 21 Nov 2023 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700551780;
        bh=iN2vy0G2QoY8JrojPMvjhZH+VwMN+5+iL06Cyoh3i6Y=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=juPN3fvLFhkMXE7swdscPFUoJTQpjOdIKJ6+jcN7edckVjdj7qX8yZ8OvzeHJUsbI
         TEUZLdyuJokywmmn/YCRBkoqCf+MA2afrLLumDnDpNGGtLiscT7wswjJnvVkDVEeMD
         WD8ncb5+ZgKCpCYBjvID/QLFedjFL+xocD3YcefeoIrol9dznOMD6MdOr3HVmiO1Wa
         lSBnUVRha0DVOdwU7JHWsmM1J9SyIrpgMHnQwsviQjw6dQAATrQLuwTuSa/9i9AMfc
         VofDp/0+Vxexz5tge6DpI77EZJNQ9KRetHgO0KkFP7Z7rvU5mkjWDEKLw5IQPDjpny
         zhFNLsxt7xnFA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1AC3F27C0054;
        Tue, 21 Nov 2023 02:29:38 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 02:29:38 -0500
X-ME-Sender: <xms:YFxcZRKkbcrovPaELtyYV2DX0O8yeUVsy-q4lW8z0WkvLeY2PFn7-w>
    <xme:YFxcZdIjpdZ4bhGRdawrOv8AkBBgpyl7pLIqwQFEBB3vuNa76FsRLhW_0IKuowVeV
    USizgnZw8Bnz0dWhT0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegkedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:YFxcZZtEd9vAXuXRY06BBC1U3upWjOVv9gjszhJAGq-c4WDxWbC8Iw>
    <xmx:YFxcZSbkMoe4h2Bdu_2qu4oZNrreffNRrCO_u8UFEj0gzSeB_byNbg>
    <xmx:YFxcZYYM8cxkcQUlpKELYJyUlDoivNk--c7tPuY4QxfiwXudR_1E7g>
    <xmx:YlxcZabImKBMu6_1zwp5jOQzd47qdkKWhORusT-kB6C-709OVS9agvOPHvwUFTka>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D5AA1B60089; Tue, 21 Nov 2023 02:29:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <45997863-d817-48c7-ad46-8b47f5e0ce61@app.fastmail.com>
In-Reply-To: <20231120215945.52027-4-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-4-pstanner@redhat.com>
Date:   Tue, 21 Nov 2023 08:29:15 +0100
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

On Mon, Nov 20, 2023, at 22:59, Philipp Stanner wrote:
> The pcim_*() functions in lib/devres.c are guarded by an #ifdef
> CONFIG_PCI and, thus, don't belong to this file. They are only ever used
> for pci and not generic infrastructure.
>
> Move all pcim_*() functions in lib/devres.c to drivers/pci/devres.c
>
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/Makefile |   2 +-
>  drivers/pci/devres.c | 207 ++++++++++++++++++++++++++++++++++++++++++
>  lib/devres.c         | 208 +------------------------------------------

Since you are moving the pci_iomap() code into drivers/pci/ already,
I'd suggest merging this one into the same file and keep the two
halves of this interface together.

     Arnd
