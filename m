Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3433775BF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjGUGj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGUGj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:39:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E546330FB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:39:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A4761407
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D87C433C8;
        Fri, 21 Jul 2023 06:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689921548;
        bh=pPac8yPWmSjpPBsh2tgc9lsmk3v6K1eiIR2YrRDKCmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pIzdtq4z4rxbfnpL5U/XnFx1v7IJsNaG7Hw8Ha1yG2Lzvs4UdfQ2+p4A7bL/19nW3
         vxZMBu7Ql4pxAt1lvhGu7vMu+2qHp6lvqPs5PdLRPu6nRC0h2IwUAa3DaEytV5IcKf
         R8Bc7RtmqkdGcM4eRNoj9nxyaHPO90kPJ8miKTnBnTw+nhTmYzaGQuIkVQZvezBlCv
         aF5drmXgGboVEsIfIuCCrexGm9W71CRtg9R1T5zCtjFi929ZjARL+9LAHD921jMpIC
         RKAiL6hlVVAIse1xoXYG/XC8pEhfLGKS7+BkmyveacjxyZEAjBzlbwgK0txcnR58Ta
         Y9PT4ef7tTbPg==
Date:   Fri, 21 Jul 2023 14:39:05 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Alicja Michalska <ahplka19@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robbarnes@google.com,
        lalithkraj@google.com, rrangel@chromium.org, bleung@chromium.org,
        groeck@chromium.org, chrome-platform@lists.linux.dev
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Add DMI definition for
 post-Skylake machines running custom Coreboot builds
Message-ID: <ZLooCXV11JCdWOdK@google.com>
References: <ZLm3G5G6/gmLZwkn@tora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLm3G5G6/gmLZwkn@tora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:37:15AM +0200, Alicja Michalska wrote:
> ChromeOS EC LPC lacks DMI match for newer machines, which
> use "Google" DMI_SYS_VENDOR as opposed to "GOOGLE" in older models.

I'm confused about the sentence as it looks irrelevant to the patch.

> This patch adds DMI definition for MrChomebox's custom Coreboots builds,
> which we (Chrultrabook Project) are using.

s/This patch adds/Add/.  Search "imperative mood" in [1].

Looks like a typo: s/MrChomebox/MrChromebox/.

If you get chance to send next version, please shorten the commit title.
I guess "platform/chrome: cros_ec_lpc: Add DMI match for MrChromebox" should
be quite explicit.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> +	/* DMI doesn't match modern machines running custom firmware */

Remove the line.

> +	{
> +		/* MrChromebox's firmware */
> +		.matches = {
> +			DMI_MATCH(DMI_BIOS_VENDOR, "coreboot"),
> +			DMI_MATCH(DMI_BIOS_VERSION, "MrChromebox-"),
> +		},
> +	},

Put the block after "A small number of non-Chromebook/box machines also use
the ChromeOS EC"[2].

[2]: https://elixir.bootlin.com/linux/v6.4/source/drivers/platform/chrome/cros_ec_lpc.c#L533
