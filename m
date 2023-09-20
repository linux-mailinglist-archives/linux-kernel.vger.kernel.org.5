Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998FC7A7017
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 03:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjITBx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 21:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjITBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 21:53:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDF3B3;
        Tue, 19 Sep 2023 18:53:51 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9D6743200961;
        Tue, 19 Sep 2023 21:53:49 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 19 Sep 2023 21:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1695174829; x=1695261229; bh=pf
        3dqBAG8Fi2hvI1Z04qSxkshW+L8GPDkCLrFzofr/4=; b=YuP/CXWXJx3KqVqZDU
        z+D4dcpoF9UKySgMt6mvJCoCTKTMgIu5HL7eL/J76cWAjx6AK7ihSdcHQWjSS/MZ
        9BztnAfDrCk0g1cURcwWWbBMnKyVp23ubbT14pcG2vsNrAef7/gRrCZ4XwWvgZKR
        dHerZP2+J2klR93Hr90Uu32038Z3AAbG7IbZjTSVBrMJLJy8cVPWdCIklWJJDjdd
        rRzCq4ZIHY2OhJjbTMpqjIbqu9w0rH9FxLziIYxWq6fdL3Cm8QrVSRG6IpQn6DG5
        59TNKueTQkYHKnPi/7Q74eAYwN/O0SXSBpjWjLHyDk3aOQS8ZtF2GJ1SocH3OUWN
        C6ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695174829; x=1695261229; bh=pf3dqBAG8Fi2h
        vI1Z04qSxkshW+L8GPDkCLrFzofr/4=; b=Ogc/eRYOXNM8cdNmidqZsCx9WI+Xy
        4NviLeDXrKIu9Gm1VfDnce1U3FUCATBRl05iRo2khLsA8f290D9IG9aB36wl7h7y
        Cp+5dno03ewWm0HXEFH4Lp7dgJZU/oo5ImuX0NDxD71YARU++3BJ6DcutyCMNu0g
        PiFSX1p6l5esKop2Ngo6FAH3HRya0po+AEw+Nsnx648jLeoeFux9N/bgPUPGPxGv
        hUl7/OHrK2VvbnhyEVxdvi9wOQzv/OvUe7/A9hpHJwo5y0Or4D10Qi8XeBgEdSpl
        u3aoSFOJFicZAiE2O48wOXdgB38IiiRcky4Bw/QKXQzxNtr9sywMr0BAg==
X-ME-Sender: <xms:rFAKZQNAzvPx62TD839x4YrK1j_SgHIMZ0Zt8UuQol9u6z6kC8PouQ>
    <xme:rFAKZW8PDgHs87Y3u_bfSo7GshZz4KBlaAkecmpCXCeDGTTUiwnjb70puTA8JESay
    s_4tg6Mt7UFP1PPbRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:rFAKZXSkjojpck9C8LthQfe7GJQ2i1rdbP02JSAdAtDPXD2C_nNwgQ>
    <xmx:rFAKZYupT8Ry-NNtEHhclQyZhz27p-AOMtWOX0kHoH2a4vAxwrisgg>
    <xmx:rFAKZYfWpTqmi4QdePw4PakJMUcsfAfDDbdOvx_jzErU9xRmR1yWew>
    <xmx:rVAKZQSsp1CbE_hb-2YqnL33OUCTEWGgvtY67i1IWK2ZQeVerzuxxQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A12F2C6008B; Tue, 19 Sep 2023 21:53:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <b4ba5401-6604-4790-85cf-f8ae22f73543@app.fastmail.com>
In-Reply-To: <68c6df3f-f83b-48da-9ee2-351995479915@roeck-us.net>
References: <20230915150340.301067-1-dober6023@gmail.com>
 <8a566102-5ea6-4449-9083-8feebe711065@roeck-us.net>
 <TYZPR03MB59949F797738F5B1B8638278BDF6A@TYZPR03MB5994.apcprd03.prod.outlook.com>
 <55f22980-b47a-4a22-8f19-2b0a5b4e6a1a@app.fastmail.com>
 <68c6df3f-f83b-48da-9ee2-351995479915@roeck-us.net>
Date:   Tue, 19 Sep 2023 21:53:23 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Guenter Roeck" <linux@roeck-us.net>
Cc:     "Guenter Roeck" <groeck7@gmail.com>,
        "David Ober" <dober6023@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, corbet@lwn.net, "David Ober" <dober@lenovo.com>
Subject: Re: [PATCH] hwmon:Add MEC172x Micro Chip driver for Lenovo motherboards
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Fri, Sep 15, 2023, at 6:56 PM, Guenter Roeck wrote:
> On Fri, Sep 15, 2023 at 06:43:02PM -0400, Mark Pearson wrote:
>> Hi Guenter,
>> 
>> > From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck 
>> > On Fri, Sep 15, 2023 at 11:03:40AM -0400, David Ober wrote:
>> >> This addition adds in the ability for the system to scan the
>> >> MEC172x EC chip in Lenovo ThinkStation systems to get the
>> >> current fan RPM speeds and the Maximum speed value for each
>> >> fan also provides the current CPU and DIMM thermal status
>> >>
>> >> Signed-off-by: David Ober <dober6023@gmail.com>
>> >>
>> >> Written by David Ober from Lenovo using this gmail address since
>> >> my corporate email address does not comply with git email
>> >
>> > FWIW, this needs to be after '---'
>> >
>> > Anyway, thinking about this submission makes me even more concerned.
>> >
>> > This isn't really a driver for MEC172x; it is simply a driver
>> > accessing an EC on a set of PCs and/or laptops from Lenovo
>> > which uses a vertain API for communication between EC and main
>> > CPU.
>> >
>> > Such ECs are typically accessed through ACPI. Yet, in this driver
>> > there is no mention of ACPI, much less any protection against
>> > parallel use by ACPI code (that access lock in get_ec_reg() doesn't
>> > even protect against parallel access from userspace, much less
>> > against parallel access from other drivers or ACPI, for example
>> > by using request_region() to reserve the used memory ranges).
>> >
>> > There needs to be explanations and clarifications
>> > - Why this driver will only be used for communication with MEC172X
>> >   based chips, and why the exact EC chip is relevant in the first place
>> >   to be mentioned as much as it is.
>> > - How it is guaranteed that the EC is not and will never be accessed
>> >   through ACPI.
>> > - How it is guaranteed that there will never be any other kernel drivers
>> >   accessing the chip.
>> >
>> I assume for this we just need confirmation from the BIOS team that this is how it will be handled and it's intentional by design?
>> 
>> Agreed this is normally done by ACPI, but my understanding is that it's not the case on these particular workstation platforms. FWIW Windows is also doing access by a separate driver. 
>> I'm not sure why the design is done this way but will confirm to make sure.
>> 
>> With regards to guaranteeing that no other kernel drivers access the chip - I'm not sure how we can ensure that. Or do you mean if another vendor is using this chip but with different platform IDs and want to use a similar driver? 
>> For this case we can make the driver generic (rename it mec172x.c) so others could add their platform support in the future (the platform IDs will be unique). Either that or I can confirm with Microchip if this particular chip is Lenovo specific.
>
> This has nothing to do with the microcontroller you use as EC,
> and you can not tell anyone that they must not use the same
> microcontroller in their system.
>
> If the chip is not accessed from another driver, you can use
> request_region() to reserve the memory space used by the chip.
>
Thanks - sounds good and we'll do that.

I confirmed with the FW team that there is no plan for the BIOS to access this chip. On Windows it is done from the OS too.

Mark
