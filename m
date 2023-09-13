Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97279E78D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbjIMMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbjIMMEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:04:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD1419A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 05:04:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1098BC433C8;
        Wed, 13 Sep 2023 12:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694606658;
        bh=UDg0s7wg1AHZ02vnovZRJjJnJM/odDz8x2qPN11Cjt0=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=GBpdFEhnj1S+t8m5Kdtk7+yAUbjGV282+HVn7GHEFcLewWYKIhUVlq6UEBd5R8Gd7
         1Xc1/FA2QxqzIKzcyx7rCFtn7+v+CEUn38lJsDmDMcaDuwXkTf1cpKDZTafUF4RTY3
         rIyaaYWcLTMNvBEuZd/2yiMr1qMJ/g83D1Q2jJ7yk0j/YZxUcJ/v/3XIW9SnnjHJaK
         cPT5FLryZM/KVLy2yCOGGGcKzR8TsRaLlSJDvFHwkbYnJHfyl9zcKzngxJUnM8Etn/
         G+jZGqBoa/9VtKS0VmVrNOviwMQWK/sNRDkpJlnqY0PP1KxRLm8evvecG+K6cOMJ1g
         wTST/wBj5NswA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id EE06D27C005C;
        Wed, 13 Sep 2023 08:04:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 13 Sep 2023 08:04:16 -0400
X-ME-Sender: <xms:QKUBZVaz02byhFggCINCoQCgo52Ksr-X-8t8qdjtKDgwxmewKgJ-pQ>
    <xme:QKUBZca7gCrDgPB3UFu7qnGePGUmNcIYogXAacu-_Wr_VKIXLDUcEL0lvcW5GUQug
    PBPSVUd3_9BoJXZVx4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeikedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:QKUBZX8vbIe4PQqiKrzuY0G-LHFu9x-6AMK6ydgL1dpvUCrmA0ioGg>
    <xmx:QKUBZTq_swv-wly34_DOtTrmk-7Gr5P7SzBnFZ3GRXTFvmhvMBR8Ew>
    <xmx:QKUBZQpMEkufZ1fqr5S3Io1l0BVKFnbFzDczAFVaywCYnuP2yTCK7g>
    <xmx:QKUBZXQdGo26set1UF_m9chpK7DbG0dwrv77yG1SopGHI7sCokc_tQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 79DCEB60089; Wed, 13 Sep 2023 08:04:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <51a9af18-a5e4-4cb1-9f95-491bf73d35f1@app.fastmail.com>
In-Reply-To: <20230913112032.90618-6-abbotti@mev.co.uk>
References: <20230913112032.90618-1-abbotti@mev.co.uk>
 <20230913112032.90618-6-abbotti@mev.co.uk>
Date:   Wed, 13 Sep 2023 14:03:55 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Ian Abbott" <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>
Subject: Re: [PATCH 05/13] comedi: 8255_pci: Conditionally remove devices that use port
 I/O
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023, at 13:20, Ian Abbott wrote:
> In a future patch, the port I/O functions (`inb()`, `outb()`, and
> friends will only be declared in the `HAS_IOPORT` configuration option
> is enabled.
>
> The 8255_pci module supports PCI digital I/O devices from various
> manufacturers that consist of one or more 8255 Programmable Peripheral
> Interface chips (or equivalent hardware) to provide their digital I/O
> ports.  Some of the devices use port I/O and some only use memory-mapped
> I/O.
>
> Conditionally compile in support for the devices that need port I/O if
> and only if the `CONFIG_HAS_PORTIO` macro is defined.  Change
> `pci_8255_auto_attach()` to return an error if the device actually
> requires port I/O (based on the PCI BAR resource flags) but the
> `HAS_IOPORT` configuration is not enabled.
>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>  drivers/comedi/drivers/8255_pci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/comedi/drivers/8255_pci.c 
> b/drivers/comedi/drivers/8255_pci.c
> index 0fec048e3a53..4c4c0ef1db05 100644
> --- a/drivers/comedi/drivers/8255_pci.c
> +++ b/drivers/comedi/drivers/8255_pci.c
> @@ -57,6 +57,7 @@
>  #include <linux/comedi/comedi_8255.h>
> 
>  enum pci_8255_boardid {
> +#ifdef CONFIG_HAS_PORTIO

I think this is a typo: HAS_IOPORT vs HAS_PORTIO?

     Arnd
