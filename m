Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF6800F95
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379460AbjLAPcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379398AbjLAPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:31:56 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E902C10F9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:31:59 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4A7665C00E0;
        Fri,  1 Dec 2023 10:31:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 01 Dec 2023 10:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701444719; x=1701531119; bh=S2
        3umPlXJQkeulBSJ4NyHT/ySrJcetJwnTwa7Bmt//A=; b=GCgnEJblV3NjK6qiRz
        12TBLKwVjPHyT8xGbs8zmQj5y0esR77HR2kGT2V0uIyEQHQT2Ld43Ty53uK0xboW
        ram+ZE6/UWM7J0H8XOGgqDXV348NO00EHdFhe+NyQ0k8F2Eo1oGiKi6Rot27IjWy
        rvmGuhvs2ggvVnD1xKuKGh1XAiXVvFWGh6quY7Ws7elg/IC3HeGwMYCxqN6ZhiKF
        9har4YLSuV17ig6Snm7+9aZQJECTbzAcQkDW3EX4FEqBBryKwSOPxi1qNGXI+65N
        v4NwOCWIOnK24U4Sig4i/mCLg9TTXAFOur8aPOOqxUVH2P0OVRJ6UZVInzoZ6Jk0
        6+HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701444719; x=1701531119; bh=S23umPlXJQkeu
        lBSJ4NyHT/ySrJcetJwnTwa7Bmt//A=; b=M7Y6Tzi3+CtpLrklENV7GZQkfjvn6
        ox3arxwg7QfZfqEiqVSRAiKkxON6U/B6KtOq25nh7u2gsRk6X21TLfScB0n5B+jP
        TZg3OuOQEpgc9JSR6HvfF+98BItPKJdu+jq464u/ShCZ3qQJm0tLNRYzhjg7+GrQ
        9uQqoPYwxvxMXRReepRBvk28dNXcfRicat8gyczobRxaatYY1Xg1CDeYIprS3Je8
        aOcDXGgWtBBotix2rcNKMvnGQKIAvPVLhB4/50rqvqlEMciCFYC8FvFZ3c43XFSh
        OkEpa5YApTWtulyQZcvOA4By9K3L7gBz0+TUTqjJOKa9v5o7piRDFi6Rw==
X-ME-Sender: <xms:bvxpZaLjHA_wtw8fNniMtRzggxYTwrS1uAehlU5pUKXddSEWWmGmkQ>
    <xme:bvxpZSKUHgG0PRQTmL02-3arBK6G4u5aL15Y1boOcMJcjV8dAWn-kxIsWDpUN_EgN
    uNGlRsYPX6YfvZ_Qnk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:bvxpZav20_WiL886aUxDD3IyF_wRtfaAuzSEUeSEgv6R8GkhumynOw>
    <xmx:bvxpZfYUZQ9Me4GkAFN8ASQy-QA3LynZogDPwkcnxrSooA4oZTD1Jw>
    <xmx:bvxpZRa16kGx1eHmkIiRw5vySjms0-AWAnoWZPmumUU9qSpo0hhhaQ>
    <xmx:b_xpZWN18qCVdRJu1_i6n1dJk9Dg8LSpLT81CXnOTre-n-2WFzOUeQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8A674B60089; Fri,  1 Dec 2023 10:31:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
MIME-Version: 1.0
Message-Id: <855dfa50-a3a3-415a-8612-4da59f995ef0@app.fastmail.com>
In-Reply-To: <20231201064919.5mbmqo5fco7n3rgq@endnote>
References: <20231130231657.12715-1-francesco@dolcini.it>
 <20231201060346.GE5169@atomide.com> <20231201064919.5mbmqo5fco7n3rgq@endnote>
Date:   Fri, 01 Dec 2023 16:31:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nishanth Menon" <nm@ti.com>, "Tony Lindgren" <tony@atomide.com>
Cc:     "Francesco Dolcini" <francesco@dolcini.it>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, "Tero Kristo" <kristo@kernel.org>
Subject: Re: [PATCH] arm64: defconfig: increase SERIAL_8250_NR_UARTS
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023, at 07:49, Nishanth Menon wrote:
> On 08:03-20231201, Tony Lindgren wrote:
>> * Francesco Dolcini <francesco@dolcini.it> [231130 23:17]:
>> > Increase CONFIG_SERIAL_8250_NR_UARTS from 4 to 8, the current legacy value
>> > is not adequate for embedded systems that use SoCs where it's common to
>> > have a large number of serial ports.
>> > 
>> > No need to change CONFIG_SERIAL_8250_RUNTIME_UARTS, see commit 9d86719f8769
>> > ("serial: 8250: Allow using ports higher than SERIAL_8250_RUNTIME_UARTS").
>> > 
>> > This enables using the UART connected Bluetooth device on Verdin AM62
>> > board.
>> 
>> OK makes sense for distro use.
>> 
>> Disabling unused ports leads into port names shifting, which we still can't
>> easily tolerate until we have the DEVNAME:0.0 style addressing available for
>> ports. So for now we still depend CONFIG_SERIAL_8250_NR_UARTS, eventually
>> that too should become just a legacy ISA port array.. Meanwhile:
>> 
>> Reviewed-by: Tony Lindgren <tony@atomide.com>
>
> I'd prefer to get Arnd's view on the topic as well (I kind of
> recollect some historic discussion which I am not failing to trace
> that there usage model doesn't exceed 4 and aliases could be used to
> map these as required for the platform). The 8250 debate has been
> popping on and off over the years.. Sigh.. memories of [1] still haunt
> me.

I don't recall any reason to have the limit set to the default
of 4, other than possibly using excessive amounts of .data in
vmlinux, but we have other serial port drivers that just hardcode
a much larger value.

    Arnd
