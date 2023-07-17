Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FE97565DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjGQOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjGQOIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:08:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3B10D8;
        Mon, 17 Jul 2023 07:08:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69BEC6108B;
        Mon, 17 Jul 2023 14:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFB1C433C7;
        Mon, 17 Jul 2023 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689602908;
        bh=1C/1zFzPAcvFdNbVlwJcLs0b2J8Mxp77yP1oYPB/Bd0=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=nkxZhT6S2eQD3ZswL6Gq1CcBLtuji6c7eqZ+k4btRrwenFlKWnbi48oaHWQXOOIBU
         GdvkpGaxI/dZAAgl1/yJsNYZcf765oz/sngpFXAomD+EsRSyJVWM2enAmRfprtXVzo
         EALL9EGM3W+q7lPE1uFdHEg/zGW9ZmGOT5Z6kIOvWhXya5fVi+IHNfXetAihrdJq7y
         MkmX2NKWFLgq8UgQpQILDuw23qz3lR7VDHCZiLi8ZaJh4cvtOg68GWPG7v7p/r8Az/
         /DHKJcuNvrQC0FqMQR0o1EPkEumytWR9yRyvLg+XK8mNqlH/IJihqLWOORe7JgllEX
         UZ8SuJBJA1aDQ==
Message-ID: <5721cdc0f98faea5c00051a3e6c8701c.mripard@kernel.org>
Date:   Mon, 17 Jul 2023 14:08:26 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Frank Oltmanns" <frank@oltmanns.dev>
Subject: Re: [PATCH v4 06/11] clk: sunxi-ng: Add helper function to find
 closest rate
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-6-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-6-04acf1d39765@oltmanns.dev>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        "Andre Przywara" <andre.przywara@arm.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Roman Beranek" <me@crly.cz>,
        "Samuel Holland" <samuel@sholland.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 15:34:30 +0200, Frank Oltmanns wrote:
> The default behaviour of clocks in the sunxi-ng driver is to select a
> clock rate that is closest to but less than the requested rate.
> 
> Add the ccu_is_better_rate() helper function that - depending on the
> fact if thc CCU_FEATURE_CLOSEST_RATE flag is set - decides if a rate is
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
