Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5FA812F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444222AbjLNMBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444191AbjLNMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:01:40 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B4BD;
        Thu, 14 Dec 2023 04:01:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E6A1D5C01FA;
        Thu, 14 Dec 2023 07:01:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 14 Dec 2023 07:01:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :subject:to:to; s=fm1; t=1702555304; x=1702641704; bh=Baksf+ezVF
        lYZ2aIOXFNfU8ikmrbeyERoCYqa6/cW4Y=; b=fuI254nTWrgEL508ZUXSr5ts7/
        kL5NSSYQ9JyWAcH/I0aVXU+xp7FkYXP3UpSL7twuKSg9dSynv2q9ATL6UwFiQntV
        FbjMNsWLD7EbXgwk9sK73Xev9A3NcxXYtKDIxHZ/txh1DZiFkqdYoXWYM0x0qmTx
        VJrZKtRpdftK/xUC9+DUCsVDcEXyPP7YxVl8JYE86kybQ/bVWjzbUvoST4/OeTMK
        dtIcHKbaotzXZ3hN9stNCbPuMbly5XG6BINTpdP1cqEY7GYer2pjiSReD4bIN7DN
        mVJkhwR7P9s/zWjn6jBiAKr9qikX1el6R4abP+xop0BK1YVsgTWELj5R45cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702555304; x=1702641704; bh=Baksf+ezVFlYZ2aIOXFNfU8ikmrb
        eyERoCYqa6/cW4Y=; b=H4hUsGCD+UIpPhvTp6EDda5x184ckDpINaoPPwYhG6Bz
        pHrj1+s3zIJMTXmqdvx/JGqJ/hd2av7VtEQIPEm6WT++DwSy7BMNCiOWGoCPX8Pb
        eyu9Rr7n4WLnuV7XODR4sFJzUse0N2foWWq5LZoxh7urMYi/npT7AH8G5+sJG13H
        qKAxFJyp0e3UC1vTtvJBGJjF19LSovxJt+wS2iUU5KA/T1hxeOwqmcEQ9yws7UIT
        ekEE1qbPICwOFcUJV8dk/8cX6od0dkCsWEOWZbUXvuSkQBkbA5LHKmah+BXF8qxB
        7X21c47xO5o4wBJptgZc80EB191pJPTwlEwQJS0KLw==
X-ME-Sender: <xms:p-56ZfivBsopwzJZUolzYfIwCyeb1_gUGFaQFErpr8dBiVYSiiTJ2A>
    <xme:p-56ZcDYh5fT2_FwBR5UmjS4-ld9llEkSfj-nLAWDISM9s8emwpjly7LjXh1nMNmb
    I8OAehJrVT-gTxOXrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:p-56ZfEh9NlIyqEvfieC3ApXwdqjkVDtV84AZttHKOUhd3fY6NBbGw>
    <xmx:p-56ZcRlgLBGG20YuLoW9BvjkhNfpbGJE4AymzTznyVL5qXxb7yVkg>
    <xmx:p-56ZcwwDYeuLqtfeNo6KEDmz9WFiKgU7XZUFEoxj0Oj05LSun0qHQ>
    <xmx:qO56ZZjQr8S5MbXEpxTVcjgIE1nGGY0D9mobT7rrgS1E5yJuuh1h8g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 779C6B6008F; Thu, 14 Dec 2023 07:01:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
MIME-Version: 1.0
Message-Id: <1938fcf1-eb5d-4723-a6c6-d2fe2c6dd1c0@app.fastmail.com>
In-Reply-To: <20231214105243.3707730-6-tudor.ambarus@linaro.org>
References: <20231214105243.3707730-1-tudor.ambarus@linaro.org>
 <20231214105243.3707730-6-tudor.ambarus@linaro.org>
Date:   Thu, 14 Dec 2023 13:01:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tudor Ambarus" <tudor.ambarus@linaro.org>,
        "Peter Griffin" <peter.griffin@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>, andi.shyti@kernel.org,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Tomasz Figa" <tomasz.figa@gmail.com>,
        "Chanwoo Choi" <cw00.choi@samsung.com>,
        "Sam Protsenko" <semen.protsenko@linaro.org>
Cc:     =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        saravanak@google.com, "William McVicker" <willmcvicker@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 05/13] tty: serial: samsung: add gs101 earlycon support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023, at 11:52, Tudor Ambarus wrote:
> +static int __init gs101_early_console_setup(struct earlycon_device *device,
> +					    const char *opt)
> +{
> +	/* gs101 always expects MMIO32 register accesses. */
> +	device->port.iotype = UPIO_MEM32;
> +
> +	return s5pv210_early_console_setup(device, opt);
> +}
> +
> +OF_EARLYCON_DECLARE(gs101, "google,gs101-uart", gs101_early_console_setup);

It looks like this is already done by of_setup_earlycon() based on
the reg-io-width property. Any idea why it doesn't work with the
normal s5pv210_early_console_setup() function?

      Arnd
