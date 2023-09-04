Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28404791824
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbjIDNbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbjIDNbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF0CCE;
        Mon,  4 Sep 2023 06:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CD82B80DB1;
        Mon,  4 Sep 2023 13:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD44C433C8;
        Mon,  4 Sep 2023 13:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693834256;
        bh=cCoAgy2S822a9R10FnCxs9nNgFlSEwiHpELr4pr/sUY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=X74liku2/U2AgFvL0JYo32KY+jNkAqT2BK8UcIHu/V7Q98GjXpDy6Y1dbbYLgjJPg
         SjO0xSzluPAuEsaMQku/Pb69+nGp70qnbu4szztivKo3+IugRIDhK+DyGRvn/tcxWE
         1GSsG2hH/qbG2g7EePflQwC/nwnIqtLSpzKHkj2PkNPfzC47XQbuKpFPOtkk3CMAIX
         dIax4sAvRPAHmLJatOhJ3N3FL2k87edD7Zr+3I71htyKddPB4vRmmsAxQ1DRR1LxmG
         z5IdAQzu8EMNfzD4qga1kiz5ANgHic3E9uD57vsdHgaz9dFwVosuuIzXVBCHKkO+kF
         xiZ3v2AkGZ4GQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6040627C0064;
        Mon,  4 Sep 2023 09:30:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 04 Sep 2023 09:30:55 -0400
X-ME-Sender: <xms:Dtz1ZIoY6FL3Pak0cAiFHs98feIiFe1yIHDTgiN3t4PmQaWpSFpLnQ>
    <xme:Dtz1ZOqKDGY55Y6Z4J3l-5ykQk2oLlCX3rJIaKiP9bzE4_Uc1te0DSyC1KG-KIl8h
    S0XP-Z8AVy57doJKhM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudegkedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:Dtz1ZNO5PauTqCNapRqLLwTAJf-TNBE_ippYYiz60ln58uZ6hVHPcg>
    <xmx:Dtz1ZP4co-ue03WhbIMSicAQR6QVm39dve0gTNCer8aBxolExqfBiw>
    <xmx:Dtz1ZH5Q6xrry1V48Dknv6-jW8K2WJBcCZX0lQFq6tqTavdX3sMV1g>
    <xmx:D9z1ZJlC2ULu8BApm6Pq3mkm0XG9PEgK608yLVqmwEMudJ3CSURyHg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6AE98B60089; Mon,  4 Sep 2023 09:30:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <3b3ac922-625f-45f6-98d9-e4c3fe883e83@app.fastmail.com>
In-Reply-To: <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk>
References: <20230901192615.89591-1-abbotti@mev.co.uk>
 <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com>
 <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk>
Date:   Mon, 04 Sep 2023 09:30:34 -0400
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Ian Abbott" <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>, stable@vger.kernel.org
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

On Mon, Sep 4, 2023, at 06:10, Ian Abbott wrote:
> On 03/09/2023 16:49, Arnd Bergmann wrote:
>> On Fri, Sep 1, 2023, at 15:26, Ian Abbott wrote:
>>> Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") changed the
>>> "select" directives to "depend on" directives for several config
>>> stanzas, but the options they depended on could not be selected,
>>> breaking previously selected options.
>> 
>> Right, I think that correctly describes the regression, sorry I didn't
>> catch that during the submission.
>> 
>>>   Change them back to "select"
>>> directives and add "depends on HAS_IOPORT" to config entries for modules
>>> that either use inb()/outb() and friends directly, or (recursively)
>>> depend on modules that do so.
>> 
>> This also describes a correct solution to the problem, but from looking
>> at your patch, I think it's not exactly what you do.
>> 
>>>
>>>   config COMEDI_PCL711
>>>   	tristate "Advantech PCL-711/711b and ADlink ACL-8112 ISA card support"
>>> -	depends on HAS_IOPORT
>>> -	depends on COMEDI_8254
>>> +	select COMEDI_8254
>> 
>> If COMEDI_8254 depends on HAS_IOPORT, you must not drop the 'depends on'
>> here, otherwise you get build failures from missing dependencies.
>> 
>> Same thing for a lot of the ones below. You should only change the
>> select, but not remove the 'depends on HAS_IOPORT' in any of these,
>> unless the entire Kconfig file already has this.
>
> I assumed it was OK because it is only selectable if 'ISA' is selected 
> and all the other ISA card drivers that use inb()/outb() and friends do 
> not depend on 'HAS_IOPORT' either.

Ok, that is probably true if there s an implied 'depends on ISA', but
I wouldn't change the logic as part of a bug fix, since the 'depends on
HAS_IOPORT' is not wrong.

>> This change looks unrelated to both your description and
>> the bug, as you are just moving around the dependencies,
>> though I might be missing something.
>
> I'm just moving the 'HAS_IOPORT' dependency down from 
> 'COMEDI_PCI_DRIVERS' to its dependents.  Not all comedi PCI drivers use 
> I/O ports, although some of the drivers that do not use I/O ports do 
> depend on 'COMEDI_8254' and 'COMEDI_8255' which do depend on 'HAS_IOPORT'.
>
>> If this addresses another problem for you, maybe split it out
>> into a separate patch and describe why you move the dependencies.
>
> I'm just correcting one patch with one patch, so don't really want to 
> split it.  I could improve the patch description though.

No, you should always split bugfixes from cleanups, otherwise
it's impossible to review the patch. Please either revert the patch
and do it correctly the way you want, or send one bugfix patch
and a cleanup on top.

>> Are you trying to make sure that it's possible to build PCI
>> IIO drivers that don't depend on HAS_IOPORT on targets that
>> don't provide it?
>
> Yes (well, PCI comedi drivers rather than IIO drivers). 

sorry, my mistake.

>> It might be easier to revert the original patch, and then follow
>> up with a fixed version.
>
> Will any random config builds break in 6.5 stable if the original patch 
> is reverted, or is the 'HAS_IOPORT' stuff still in preparation for 
> future use?

No, the final patches to remove ioport stubs for !HAS_IOPORT configs
got delayed for other reasons and isn't part of 6.6-rc1 either, so
if you do a revert followed by annother patch in 6.6, backporting just
the revert should be fine.

     Arnd
