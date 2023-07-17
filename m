Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B33E7565D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGQOIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjGQOIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:08:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448341723;
        Mon, 17 Jul 2023 07:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C417461072;
        Mon, 17 Jul 2023 14:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC19C433C7;
        Mon, 17 Jul 2023 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689602877;
        bh=qulwdyHb+9uPhm4p3WCoPEZ37M3yifnixVDvq2o+ERM=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=SeJihIoqimuGmtiSuPXJ5gWEw//j+ImhikcgFKXSJFpVlaQK5/8wRZr+ItAI2RCv0
         vxmGlwoLPO0xF8TP0TfnryuwcGNCopNioiYBwv2enJVlTIzqE8QUAn6fZtEXn4XBrw
         S4TzBQmmRX7pI6SpU/qtNuHwt3IMODL2NoS182r50gCVlqLmPVjtspCh3MglMI3JUM
         3SlqBgVKnrSyOGP1Q9AIUhn2pZxqLj1TeIwE9u06LW6CMOpZ2VcAa7Cgq1W5Ntk10S
         SXlO5Q4fumh6lZ9lPcIclgmu3IoL3SXcrOgY5yeMZDbINz3bOJwd95MfYXGCgfisfx
         MiC6kVjaN84uQ==
Message-ID: <e168b853cd49e09f5ac081db086bef3f.mripard@kernel.org>
Date:   Mon, 17 Jul 2023 14:07:54 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Frank Oltmanns" <frank@oltmanns.dev>
Subject: Re: [PATCH v4 02/11] clk: sunxi-ng: nkm: consider alternative
 parent rates when determining rate
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-2-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-2-04acf1d39765@oltmanns.dev>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 15:34:26 +0200, Frank Oltmanns wrote:
> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
> parent rate when determining a new rate.
> 
> To find the best match for the requested rate, perform the following
> steps for each NKM combination:
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
