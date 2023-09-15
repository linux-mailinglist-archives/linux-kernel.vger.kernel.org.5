Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86657A2A9C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237877AbjIOWnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjIOWnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:43:33 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DCC186;
        Fri, 15 Sep 2023 15:43:25 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C24763200922;
        Fri, 15 Sep 2023 18:43:23 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Fri, 15 Sep 2023 18:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1694817803; x=1694904203; bh=Ku
        i5QVN27wxtbs/ixxjjjs2s5xbRk56ecBUu+WNHfQg=; b=SeN1C1l1ZuMKL89FAv
        Ed5MSg1+B6eZdAENvQGOZRXgJI4JR1SZ0PaBpaJ6UEPTop8/IzQEEqZIXIAe1Kyz
        lHCoSryx2O7QbxZQFFNhcQDmHAef/2kCBqijXq1ayOGJWJgpOOS0OOiHwKCyTxUJ
        PcgOCT5hQfZHtpO0LyHtQpl8ZxLQCnEZo+lLXGuPfXY3UQzkm7fsGIJSnUqm9wky
        TijNyYmKFyRRiv0SAKMmEYcEU2S7UV3zsm1U57/k024+t4bZ2z7/xUecWa+anGXO
        doSfFF2FYWEBFvxz/7h6GG9NhzVmTh9RARW6sRiiYr/vcjU0c4ITBU6HLnA2UImA
        vmvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1694817803; x=1694904203; bh=Kui5QVN27wxtb
        s/ixxjjjs2s5xbRk56ecBUu+WNHfQg=; b=ewcEXmDu9UAI774oJHEjZlYI5Xbq3
        9JoLPxTgQ0iCM2+5PWVFlrIEiH3647O99D5rwIlF+pVsIZb3whOSTZsaRRqPucyj
        BSqqGbHr/0gDm0PBW8l76hDN29EPfTO8p6qUg47t9EXSuxisYwOGwrqg2tItdeZZ
        XZgeVgz3dXol8e5TfdwxO2xBf1NDdDBX2oRTkqwfE+0OAbQrH+Gn2xvvfiAMrJSD
        Qg5cyBp4FV8IkyxSHa9+E0aZlC+d+ldyws/TBtERWObHn2mkQY1IgZjLRk7aOwew
        dI7kcNTI0d9vdPbvHnwcfgBpDXpE3jdAuKnnxw38L3YWjpwdUmPig/hXQ==
X-ME-Sender: <xms:Ct4EZT0q3C8eyKIEPQkpyY-Gr-nMWQUWjfl2wfLmv2eXEirRsMBhsw>
    <xme:Ct4EZSHm4kygmT7MRWYqfByfk0Ygw6J0WRRR_h1YYn_sedOQ-sMETEqUPk4NI2Vjv
    P6D-SY2G_A3MA5L74g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejfedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:C94EZT76KVOce790oX6KaoN3S3kF5BoTu9bFGVGHNIac7884iavlOw>
    <xmx:C94EZY2svtl5hQA0Gv8N7g3O3-Zh7P0AsLHgI_O33O35MxGrPpoVSg>
    <xmx:C94EZWHqdZlON820NcNWUkx9k61sqdAHlPFBrXAHLXZ_PHDTXpioGA>
    <xmx:C94EZTMIISpvv1FkM27yhL_1bX0jc_MKY8y0-0XlE-kJQ1u6vxb7qQ>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DD7B7C6008B; Fri, 15 Sep 2023 18:43:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-745-g95dd7bea33-fm-20230905.001-g95dd7bea
Mime-Version: 1.0
Message-Id: <55f22980-b47a-4a22-8f19-2b0a5b4e6a1a@app.fastmail.com>
In-Reply-To: <TYZPR03MB59949F797738F5B1B8638278BDF6A@TYZPR03MB5994.apcprd03.prod.outlook.com>
References: <20230915150340.301067-1-dober6023@gmail.com>
 <8a566102-5ea6-4449-9083-8feebe711065@roeck-us.net>
 <TYZPR03MB59949F797738F5B1B8638278BDF6A@TYZPR03MB5994.apcprd03.prod.outlook.com>
Date:   Fri, 15 Sep 2023 18:43:02 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Guenter Roeck" <groeck7@gmail.com>
Cc:     "David Ober" <dober6023@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, jdelvare@suse.com, corbet@lwn.net,
        "David Ober" <dober@lenovo.com>
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

> From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck 
> On Fri, Sep 15, 2023 at 11:03:40AM -0400, David Ober wrote:
>> This addition adds in the ability for the system to scan the
>> MEC172x EC chip in Lenovo ThinkStation systems to get the
>> current fan RPM speeds and the Maximum speed value for each
>> fan also provides the current CPU and DIMM thermal status
>>
>> Signed-off-by: David Ober <dober6023@gmail.com>
>>
>> Written by David Ober from Lenovo using this gmail address since
>> my corporate email address does not comply with git email
>
> FWIW, this needs to be after '---'
>
> Anyway, thinking about this submission makes me even more concerned.
>
> This isn't really a driver for MEC172x; it is simply a driver
> accessing an EC on a set of PCs and/or laptops from Lenovo
> which uses a vertain API for communication between EC and main
> CPU.
>
> Such ECs are typically accessed through ACPI. Yet, in this driver
> there is no mention of ACPI, much less any protection against
> parallel use by ACPI code (that access lock in get_ec_reg() doesn't
> even protect against parallel access from userspace, much less
> against parallel access from other drivers or ACPI, for example
> by using request_region() to reserve the used memory ranges).
>
> There needs to be explanations and clarifications
> - Why this driver will only be used for communication with MEC172X
>   based chips, and why the exact EC chip is relevant in the first place
>   to be mentioned as much as it is.
> - How it is guaranteed that the EC is not and will never be accessed
>   through ACPI.
> - How it is guaranteed that there will never be any other kernel drivers
>   accessing the chip.
>
I assume for this we just need confirmation from the BIOS team that this is how it will be handled and it's intentional by design?

Agreed this is normally done by ACPI, but my understanding is that it's not the case on these particular workstation platforms. FWIW Windows is also doing access by a separate driver. 
I'm not sure why the design is done this way but will confirm to make sure.

With regards to guaranteeing that no other kernel drivers access the chip - I'm not sure how we can ensure that. Or do you mean if another vendor is using this chip but with different platform IDs and want to use a similar driver? 
For this case we can make the driver generic (rename it mec172x.c) so others could add their platform support in the future (the platform IDs will be unique). Either that or I can confirm with Microchip if this particular chip is Lenovo specific.

Let me know if I'm misunderstanding or missing something obvious here. Ack on reserving the region.

>> ---
>>  drivers/hwmon/Kconfig             |  10 +
>>  drivers/hwmon/Makefile            |   1 +
>>  drivers/hwmon/lenovo-ec-sensors.c | 471 ++++++++++++++++++++++++++++++
>
> Documentation missing.
Ack. I assume under Documentation/hwmon

Thanks for the review
Mark
