Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C7979E7C7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbjIMMS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:18:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FD019AC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06943C433C7;
        Wed, 13 Sep 2023 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694607500;
        bh=Uxv++mH8jyJnhpSSyjfFLcVM9kp3MVHe1CFOoNDtlsQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=cYOkBw6NuGg4O4JyT0BMP7Ed3T69snqt5xNYuqKDapgHZnaNDyVY1PK7LVFt5E0pH
         5H6UqvSVYYEPfpe/81604hLL+T72z5rAKpPg+11KSLeiKEiOinI18K1mbxA0QUtrVl
         QSoFvZavzqjD8FHlsWaXRi3fzaCS3XgbQtai395D2mP8u6ebUiSlcpnQ9jSPkPjb6p
         Eo3u1Ap01PGw+L2LxTHQGHGJM/RWHD75PTRuNA7SIJsUQgKPf6txB6FAGLd9xw6VeX
         e2BpF6562u7WT/AXsw3Khzcd5z0sC40PC+9hEdayF1r59hM0oBcGrKs3JKnEXAVtQR
         X9irxlteydALg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id E0CEF27C0054;
        Wed, 13 Sep 2023 08:18:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 08:18:18 -0400
X-ME-Sender: <xms:iqgBZTEaiFcXHfUabB4PIUB6z-Q-QNZ_lXUnAn2TxSPs5fDmeJtvJg>
    <xme:iqgBZQVJnXcjSEvFFQcOq-8zUOWIfbIw75vt3NFcN5850Wkwk7QM4-lLhOSdQN8vR
    WPMCSv99V51R2lt1JE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:iqgBZVLtjtvG4FrWLGjd-BIiAYoNJmu9pnp-koH5DGKs7y0chNp0jQ>
    <xmx:iqgBZREkjg0FTBKLIxhRR2or_6bXPRS38Mxc1P2ZKs-o3LOHV4gsGQ>
    <xmx:iqgBZZVl3LPjzgpfBmkCkFi3lo5FZopog_AUVngQQfu-cwpIzUypHA>
    <xmx:iqgBZaei-XUtUpjWN-4xU8-UbLPOc8C65D_hcmVIIdNeeWIe29g2Bg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9D734B60089; Wed, 13 Sep 2023 08:18:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <ca073163-d947-42f4-b45a-3ea75ab2f7fc@app.fastmail.com>
In-Reply-To: <20230913112032.90618-10-abbotti@mev.co.uk>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
 <20230913112032.90618-10-abbotti@mev.co.uk>
Date:   Wed, 13 Sep 2023 14:17:58 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Ian Abbott" <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>
Subject: Re: [PATCH 09/13] comedi: ni_mio_common: Conditionally use I/O port or MMIO
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 13:20, Ian Abbott wrote:
> In a future patch, the port I/O functions (`inb()`, `outb()`, and
> friends will only be declared in the `HAS_IOPORT` configuration option
> is enabled.
>
> The "ni_mio_common.c" file contains calls to both port I/O functions and
> memory-mapped I/O functions.  The file is `#include`d by "ni_atmio.c",
> "ni_mio_cs.c", and "ni_pcimio.c" for the ni_atmio, ni_mio_cs, and
> ni_pcimio modules, respectively.  Only "ni_pcimio.c" defines the
> `PCIDMA` macro before including "ni_mio_common.c" and various bits of
> code in "ni_mio_common.c" is conditionally compiled according to whether
> that macro is defined or not.  Currently, the port I/O function calls
> are compiled in regardless of whether the `PCIDMA` macro is defined or
> not.  However, the fact is that the ni_atmio and ni_mio_cs modules will
> never call the memory-mapped I/O functions, and the ni_pcimio module
> will never call the port I/O functions.
>
> Calls to the port I/O and memory-mapped I/O functions is confined to the
> `ni_writel()`, `ni_writew()`, `ni_writeb()`, `ni_readl()`, `ni_readw()`,
> and `ni_readb()` functions which do a run-time test to decide whether to
> call the port I/O functions or the memory-mapped I/O functions.
> Conditionally compile two variants of the functions so they only call
> the port I/O functions if the `PCIDMA` macro is undefined (for the
> ni_atmio and ni_mio_cs modules), and only call the memory-mapped I/O
> functions if the `PCIDMA` macro is defined (for the ni_pcimio module).
>
> Add a run-time check in the `ni_E_init()` function to return an error if
> the comedi device has been set up to use port I/O if `PCIDMA` is
> defined, or has been set up to use memory-mapped I/O if `PCIDMA` is not
> defined.
>
> The changes make it possible to build the ni_pcimio module even if the
> port I/O functions have not been declared.  (The ni_atmio and ni_mio_cs
> modules do still require the port I/O functions to be declared.)

I think this all works, but there is probably a simpler way to
achieve the same:
 
> +#ifdef PCIDMA
> +
>  static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
>  {
> -	if (dev->mmio)
> -		writel(data, dev->mmio + reg);
> -	else
> -		outl(data, dev->iobase + reg);
> +	writel(data, dev->mmio + reg);
>  }
> 
> 
> +#else /* PCIDMA */
> +
> +static void ni_writel(struct comedi_device *dev, unsigned int data, int reg)
> +{
> +	outl(data, dev->iobase + reg);
> +}

We already have an abstraction for this using iowrite32(),
which turns into either writel() or outl() depending on the
argument, so you could just use pci_iomap() or ioport_map()
to turn port numbers into tokens suitable for the common
helper.

     Arnd
