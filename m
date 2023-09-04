Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4AF79183A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbjIDNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjIDNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:34:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66324CD0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:34:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 102B7B80C9D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 13:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DD4C433C9;
        Mon,  4 Sep 2023 13:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693834464;
        bh=XlE4k0vgthfsdyvbT2GloP3TGTyr0FTxoWOtRyXD1+E=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=XoLeSKXsbzkYNFMTlGbsAh2EBCLnITpizjH/MgGpP18H8gdwzf1KLCLYexD8whhsA
         IH9wfDimDpM+CBREKTGDW3y257C0qG76vHjNrSHz+FwwWI5ccXsjh6PBQGV6wBDBXy
         sqmHJrB7fqMtzobqvziiwcVUVajz0pnkzhvX+GRew/kcNBqYLB0NYBpVgAIoHrKljv
         O26vKdI/+NBq4x9+5gzgE6KwZHXZJWsUhDalEPEeusNwT4EMEn9+oW9suXhna/ynKU
         Q/Lm1fMDWmv/zMERJCz9TG/2E7Z/Nxk0wvvYoQO52QoM8uIbHKdmUC66TkbuUPJheW
         FDKwdmldC1lWg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4E12127C006B;
        Mon,  4 Sep 2023 09:34:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 04 Sep 2023 09:34:23 -0400
X-ME-Sender: <xms:3tz1ZPeCoKIpGVtEiBwhvOu3urZSo2w4D_PEXgVAK9DZAPno0nG1vw>
    <xme:3tz1ZFPJq6l5JTVXE92Uz3ZVM2DUBYxfvL2MmtQJ3d5gf2L4Dz3Cop2aVJbLlcfyu
    mTr4rVxeUBVU9nfHRc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegkedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:3tz1ZIii6R7w8Av4ouO9z_nouBELw47M-asu5pOmNsWAlkCjY9Jakg>
    <xmx:3tz1ZA_QwxvaL2vO79XNX4pCmVrHgLmypRXDwqw-Le6tGkFjoTc3kA>
    <xmx:3tz1ZLvUZMtNb7ixhW-zE_nLqqe6AltCS2BoYKvDFEECuM-2NDXjpA>
    <xmx:39z1ZLKEATaB4MCY8CPiZcGEZElm4-yEJ6upMGAZk2iqfnbcEbHf3g>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C0C96B60089; Mon,  4 Sep 2023 09:34:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <8728313c-997a-46c1-8225-d57369e9292c@app.fastmail.com>
In-Reply-To: <ab5baa69-ae3c-4973-8563-670395a3c976@mev.co.uk>
References: <20230901192615.89591-1-abbotti@mev.co.uk>
 <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com>
 <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk>
 <65d620b2644e2d60b041815fa4bb544a818ae55a.camel@linux.ibm.com>
 <ab5baa69-ae3c-4973-8563-670395a3c976@mev.co.uk>
Date:   Mon, 04 Sep 2023 09:34:01 -0400
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Ian Abbott" <abbotti@mev.co.uk>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT changes
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023, at 08:01, Ian Abbott wrote:
> On 04/09/2023 12:23, Niklas Schnelle wrote:
>> On Mon, 2023-09-04 at 11:10 +0100, Ian Abbott wrote:
>
> Thanks for the confirmation.  Will it be safe to assume that anything 
> that selects ISA will also select HAS_IOPORT?  That is trivially the 
> case for arch/{alpha,arm,x86}; arch/mips explicitly selects HAS_IOPORT 
> if ISA is selected; arch/powerpc explicitly selects HAS_IOPORT if PCI is 
> selected and it is only possible to configure ISA if PPC_CHRP is 
> configured which selects FORCE_PCI and therefore selects PCI and 
> therefore selects HAS_IOPORT; arch/um does not select HAS_IOPORT and 
> although it has a 'config ISA', nothing appears to select it.  None of 
> the remaining arch/* have 'select ISA'.

Yes, I think that will always be a safe assumption, ISA without port I/O
is just not a sensible configuration. A few of the later ISA devices use
PCI style memory mapped I/O, but I can't think of any driver that doesn't
also require port I/O, and you wouldn't find ISA slots in a system that
lacks support for port I/O.

      Arnd
