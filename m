Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784F77F2A25
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjKUKTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjKUKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:19:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684E3270D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:18:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D425C433CA;
        Tue, 21 Nov 2023 10:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561896;
        bh=x6Eqbz8ebjzAvuYM7IREObhQffM7Tdw0BiU0JcMcJaM=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=i1J8VxszY8stYNc2J6hbxymc8CL0cxA0qmZjcGGdREWyxSoveVywF3enOP7eR2RiH
         K9wZU+618aNk5T0LbO7rRs2/GwSoqSHr4iD6ycHY888m/tc8rTc+MDIlJNPZCLEI4B
         /CmjWa4NYbKQ91Ebv5q4f16zaaIUJEBDREUtNsDwkKYUoBtZMceovdElqn2bDemDCZ
         IDLw8fXAbFSmvUoijoaYfanuQEGZKEmN/o2QpUsfGEM6s5mAySVWWW1iYvLXu6R7I7
         fG5NV5KkP9hj73LD0aSYP48RJg6CK+WCvppADOn9lSDTbs0OembWyTxdWNpRgziKsu
         ugd7H+qNNl0eQ==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3F0F727C0054;
        Tue, 21 Nov 2023 05:18:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 21 Nov 2023 05:18:15 -0500
X-ME-Sender: <xms:5oNcZcSO38KFYbW9qpw93qmsgssYpHs6CGyxg6FkUSPN_ADaNr6BcQ>
    <xme:5oNcZZz9GbApy_U-yAwMI6tfkpI7zsvS7Lq95XIY06BbURzI8g3fV6_GkxXWsMrr2
    j5f21nisDNEQsTlv3M>
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
X-ME-Proxy: <xmx:5oNcZZ17G2DTgqs1fAa9v8wjRdFawzMY7kI8ouLbPqHZiKzfXcKu8w>
    <xmx:5oNcZQAcYvzvL4rXpbUIdjtcsVpnOkO2VVaIlg0ObKXHVUlBSIcB3Q>
    <xmx:5oNcZViwMaeUUdbHcDsRa0gY-9GgD5_R5VN7kKjSVeS0pbgP8uXERg>
    <xmx:54NcZYiM6cVzxTPUA7CF_Mu4aHlt8_TWzVNRhXWYuoUbpM8LM9_8qp6cA4ng-bjs>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 48412B60089; Tue, 21 Nov 2023 05:18:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <3bc69019-7867-4f51-806d-02bf85a3cbf9@app.fastmail.com>
In-Reply-To: <20231120215945.52027-5-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
 <20231120215945.52027-5-pstanner@redhat.com>
Date:   Tue, 21 Nov 2023 11:17:52 +0100
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
Subject: Re: [PATCH 3/4] pci: move devres code from pci.c to devres.c
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
> The file pci.c is very large and contains a number of devres-functions.
> These functions should now reside in devres.c
>
> There are a few callers left in pci.c that do devres operations. These
> should be ported in the future. Corresponding TODOs are added by this
> commit.
>
> The reason they are not moved right now in this commit is that pci's
> devres currently implements a sort of "hybrid-mode":
> pci_request_region(), for instance, does not have a corresponding pcim_
> equivalent, yet. Instead, the function can be made managed by previously
> calling pcim_enable_device() (instead of pci_enable_device()). This
> makes it unreasonable to move pci_request_region() to devres.c
> Moving the functions would require changes to pci's API and is,
> therefore, left for future work.
>
> Move as much devres-specific code from pci.c to devres.c as possible.
>
> Suggested-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/pci/devres.c | 243 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.c    | 249 -------------------------------------------
>  drivers/pci/pci.h    |  24 +++++
>  3 files changed, 267 insertions(+), 249 deletions(-)

I had just commented in the other mail that you'd have to move
these functions to devres.c for the file to make sense, but that
I think the existing state is better.

Just to clarify again here: this patch does not seem to improve
anything to me, I'd much prefer leaving it the way it is, and
moving the pcim_iomap family to corresponding drivers/pci/iomap.c. 

     Arnd
