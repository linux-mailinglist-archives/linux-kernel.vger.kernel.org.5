Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B79A753488
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjGNIDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjGNIDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:03:17 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB093C05
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:00:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 59EE75C0117;
        Fri, 14 Jul 2023 03:52:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 14 Jul 2023 03:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689321177; x=1689407577; bh=b/
        FpYE9gRyWan5Kijm5mW7aAsJqcrCjasznEjLUEM2Q=; b=OoX4gFKlLUvwJO0sN5
        RzPPGXU9EVAX1DpUpgAdNgGH8Ug2jHoOdq3qooNN8Eqqq1Ut1qkZoZEVVnuRV7xc
        9QXOhoWju3StOmr8T+bTEjpzoQknG51fpeTEGwg5psgn/t8cwS0x5aLIVChwJXbg
        xFl7tzio/iuCU2jyKBu/W9z5I/O05JqosKCWyTxC6CMYn/mWVi18r+quHMACXg3p
        MVoH33+2aeYpNBCOT10eZzmCApDqGdybSgwVj+19l5+nghJCxJL32pQMqSFwQBTY
        I/ooXWtwHETFQJaGH/yLqpxl2dNvpzVrOpiCAZiJM9O3PQovkg3cr9QrxGGBNZ0B
        44OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689321177; x=1689407577; bh=b/FpYE9gRyWan
        5Kijm5mW7aAsJqcrCjasznEjLUEM2Q=; b=E0aajklKAHlN8obPHN5HLgv0QzBSr
        v9qmrsRqkEw3wVW5RPEXFqO1e++qIuf47F9X4v4TiJ/MeujMROohVfzoRkhpWlaz
        fOcD7Al5PsFh+L1F8IbfF3qtTaeK+Fqh6rr0ZY5xvP+GvsaOPGhkw2/hu+fF6Zgs
        wj8ufifDyXQ49s/2h2MUTDNCr17yG8sXKAYDeTnrrLMbmv4lJD56ezuoj8ZoAFjK
        atem52gHfi+55xmznEVhKtgrs9WmptPK49SCX+vWJQ/nnBuzhUp5Jf8tcZpQfPTW
        lqcEXUUn0O0mwiPyoTHv1zDqExkxUrw2tfEQ/UonuiEHUHjiZ19Pib7sA==
X-ME-Sender: <xms:1_6wZESQg0igUfZQ36oYypsA1uqMsjoayHxF0Ar3cZ9BeLgRewR9GQ>
    <xme:1_6wZByhR1K3aXkxKi5ajRRVjs7k_NIxdlhAzqELM85RdI4nVFZqli3h6G_wX4bQQ
    6EL0xFkVbxICqINGQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeehgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2P6wZB0ZbygYGAlLd0LMH4d8nrN7S1uy9utaAXIs5w5yZEYUhD5_xw>
    <xmx:2P6wZIArfZnZcWWbWK_-kR_T2piC12aDaov9TJyVBhSOi6AxOVMgGw>
    <xmx:2P6wZNhJpCWDVElewCsuTjTiVqqei8sA5OviCUc9CBTX8xNajQf3eg>
    <xmx:2f6wZFiqi-aN8KAgib2OALoEdT6rMJQ7nmdYyC-syk5ST94YPXnjVQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D3A72B60092; Fri, 14 Jul 2023 03:52:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <e06e8927-5c77-4df4-b595-dbcf647076ee@app.fastmail.com>
In-Reply-To: <3611feaa-9c89-b580-6266-c12cf048f56a@ti.com>
References: <20230515160234.289631-1-afd@ti.com>
 <20230515160234.289631-6-afd@ti.com> <ZGJeRiqylcysFPqu@shell.armlinux.org.uk>
 <3611feaa-9c89-b580-6266-c12cf048f56a@ti.com>
Date:   Fri, 14 Jul 2023 09:52:33 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andrew Davis" <afd@ti.com>, "Russell King" <linux@armlinux.org.uk>
Cc:     "Baruch Siach" <baruch@tkos.co.il>,
        "Vladimir Zapolskiy" <vz@mleia.com>,
        "Kunihiko Hayashi" <hayashi.kunihiko@socionext.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ARM: mach-airoha: Rework support and directory structure
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023, at 20:44, Andrew Davis wrote:
> On 5/15/23 11:31 AM, Russell King (Oracle) wrote:
>> On Mon, May 15, 2023 at 11:02:30AM -0500, Andrew Davis wrote:
>>> Having a platform need a mach-* directory should be seen as a negative,
>>> it means the platform needs special non-standard handling. ARM64 support
>>> does not allow mach-* directories at all. While we may not get to that
>>> given all the non-standard architectures we support, we should still try
>>> to get as close as we can and reduce the number of mach directories.
>>>
>>> The mach-airoha/ directory, and files within, provide just one "feature":
>>> having the kernel print the machine name if the DTB does not also contain
>>> a "model" string (which they always do). To reduce the number of mach-*
>>> directories let's do without that feature and remove this directory.
>> 
>> I'm guessing this is copy-n-pasted description. However:
>>> -static const char * const airoha_board_dt_compat[] = {
>>> -	"airoha,en7523",
>>> -	NULL,
>>> -};
>>> -
>>> -DT_MACHINE_START(MEDIATEK_DT, "Airoha Cortex-A53 (Device Tree)")
>>> -	.dt_compat	= airoha_board_dt_compat,
>>> -MACHINE_END
>> 
>> If this is actually used, then it will have the effect of providing a
>> "machine" that has both l2c_aux_mask and l2c_aux_val as zero, whereas
>> the default one has l2c_aux_mask set to ~0.
>> 
>
> Given we set l2c_aux_mask to ~0 as a default for "Generic" DT system I
> had assumed this was safe, but no I cannot prove it for this board as
> I don't have one.
>
> I wonder if we should have some way to set this in DT, that would
> let us drop some more MACHINE defines that exist only to set
> the l2c_aux_val/mask..

Going from an empty machine description to the default one is
generally safe as long as there is no actual l2x0 cache controller
in the system that would incorrectly get enabled by this in case
it is intentionally left disabled. I'm not aware of any such case,
but it's possible.

For the Airoha chip, we know this is safe because ARMv8 and later
ARMv7 cores (A7, A15 and A17) never have this type of cache
controller.

So your patch is fine, just mention in the description that
the change in the cache controller handling is correct.

      Arnd
