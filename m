Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD2790CD0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbjICPtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:49:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84E3DE;
        Sun,  3 Sep 2023 08:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D40660AE9;
        Sun,  3 Sep 2023 15:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F47BC433C9;
        Sun,  3 Sep 2023 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693756170;
        bh=WsXrA3tLMy413A76asPTUrb5YGRKB9CKxI4KdziubVs=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=rCETWxs5maUpD+IQOvbKxtAVWHyInT7D34kFd+rK2vbVlRL30+M3zr9YmugqOvMTo
         SbZA8V5zbkci3pqIkfGoGwvqDL09jRUzQ8O5+hS6VvNEeL6T3uxVgjW9xQqpAB0Ebi
         a0vB3q30nHFS0Qtfyn6a1X7tT3veOz+xq4V5+9eWsir6j7m2btCftKlsuXtyxkc6yn
         I14bWq1NTdhnPCJud2rIwoRnw5cAVbP7toAvFEZc6NWSBw3vh3KlJf82cz+aYIuDGm
         TZuf2fhKQuwMF+imSaDmVQUFVifilCzYfux59yM/d9miXEi/M7Yytx4bQ+MOx/f0HH
         UONOyYJJrux6w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4BBAD27C0054;
        Sun,  3 Sep 2023 11:49:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 03 Sep 2023 11:49:29 -0400
X-ME-Sender: <xms:CKv0ZAjt9qDPuhs8WuZ4sCFCZjN1JkA_jFVhW722UxzKLESrjPvhBg>
    <xme:CKv0ZJA4bh3CmOk_1hPJjEYSrl3dXoR1si5mhgtwJ8a2CRFOM2FgANxSzkAnLBwpj
    JHepDDcwlfWPqgmexE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegiedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:CKv0ZIHN34rqFL95_5akZqoFo4fGTbSwLDEvqk76EUdDk88BfS8ZDA>
    <xmx:CKv0ZBTSu8k5KVk3B0SH1ZKJipx_hbPaYEeKIFPFRq1xOmcwsbTSew>
    <xmx:CKv0ZNwuauI6crW9BPDXmVCF72Mvgc7f_OkGuow1abUCRG1Pok0p3g>
    <xmx:Cav0ZF9f8gXXERddwMpvOqZ2f-FPY1JIYgKpKkRywhw0gaDuBWlpqQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AB15BB60089; Sun,  3 Sep 2023 11:49:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com>
In-Reply-To: <20230901192615.89591-1-abbotti@mev.co.uk>
References: <20230901192615.89591-1-abbotti@mev.co.uk>
Date:   Sun, 03 Sep 2023 11:49:08 -0400
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Ian Abbott" <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT changes
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 1, 2023, at 15:26, Ian Abbott wrote:
> Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") changed the
> "select" directives to "depend on" directives for several config
> stanzas, but the options they depended on could not be selected,
> breaking previously selected options.

Right, I think that correctly describes the regression, sorry I didn't
catch that during the submission.

>  Change them back to "select"
> directives and add "depends on HAS_IOPORT" to config entries for modules
> that either use inb()/outb() and friends directly, or (recursively)
> depend on modules that do so.

This also describes a correct solution to the problem, but from looking
at your patch, I think it's not exactly what you do.

> 
>  config COMEDI_PCL711
>  	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
> -	depends on HAS_IOPORT
> -	depends on COMEDI_8254
> +	select COMEDI_8254

If COMEDI_8254 depends on HAS_IOPORT, you must not drop the 'depends on'
here, otherwise you get build failures from missing dependencies.

Same thing for a lot of the ones below. You should only change the
select, but not remove the 'depends on HAS_IOPORT' in any of these,
unless the entire Kconfig file already has this.

> @@ -512,7 +500,7 @@ config COMEDI_NI_ATMIO16D
> 
>  config COMEDI_NI_LABPC_ISA
>  	tristate "NI Lab-PC and compatibles ISA support"
> -	depends on COMEDI_NI_LABPC
> +	select COMEDI_NI_LABPC
>  	help
>  	  Enable support for National Instruments Lab-PC and compatibles
>  	  Lab-PC-1200, Lab-PC-1200AI, Lab-PC+.

I was confused a bit by this, as the changelog doesn't mention
COMEDI_NI_LABPC, but I saw that this needs the same change
recursively, same as COMEDI_DAS08.

> @@ -576,7 +564,7 @@ endif # COMEDI_ISA_DRIVERS
> 
>  menuconfig COMEDI_PCI_DRIVERS
>  	tristate "Comedi PCI drivers"
> -	depends on PCI && HAS_IOPORT
> +	depends on PCI
>  	help
>  	  Enable support for comedi PCI drivers.
>
> @@ -587,6 +575,7 @@ if COMEDI_PCI_DRIVERS
> 
>  config COMEDI_8255_PCI
>  	tristate "Generic PCI based 8255 digital i/o board support"
> +	depends on HAS_IOPORT
>  	select COMEDI_8255
>  	help
>  	  Enable support for PCI based 8255 digital i/o boards. This driver

This change looks unrelated to both your description and
the bug, as you are just moving around the dependencies,
though I might be missing something.

If this addresses another problem for you, maybe split it out
into a separate patch and describe why you move the dependencies.

Are you trying to make sure that it's possible to build PCI
IIO drivers that don't depend on HAS_IOPORT on targets that
don't provide it?

> @@ -735,8 +738,8 @@ config COMEDI_ADL_PCI9111
> 
>  config COMEDI_ADL_PCI9118
>  	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
> +	depends on HAS_IOPORT
>  	depends on HAS_DMA
> -	depends on COMEDI_8254
>  	help
>  	  Enable support for ADlink PCI-9118DG, PCI-9118HG, PCI-9118HR cards

I don't see why you'd remove the 'depends on COMEDI_8254' here
rather than turning it back into 'select' as it was originally.

It might be easier to revert the original patch, and then follow
up with a fixed version.

      Arnd
