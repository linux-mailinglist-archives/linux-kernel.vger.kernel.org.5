Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194AB7565D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjGQOHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjGQOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FD41A8;
        Mon, 17 Jul 2023 07:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F17F361072;
        Mon, 17 Jul 2023 14:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167D5C433C7;
        Mon, 17 Jul 2023 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689602837;
        bh=TjaOIkKfDPOZsfcumT3Gnw7mkCGRWXT5jNB5RAlBicE=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=dxc/oCtmKqKNX8OjI+dRQ9W1xO3gUZzpRSVkhYqH4GqtpuKAP4mQNs+E3sg1wM77H
         1fe3aQX2H6xNghdKbvAhdTkaVIuInrrPXuXc4GK9Iu7tkYC11t6AWWnR0PFdwqAtkT
         YMwk3NVCk1peLapNcAr+q7TqvyFv0mm4tpaT9UTsmFQjxCNSLsYffMcsz2OBR+jVl3
         UQlTA/e4dorV0bKm7EFi51w260dTt9A+gRoi0rscaEkfeyt0sYJVzTCz69t3uEz/xm
         ULj9AG5ou4opJrWT/diOCiS5KSMb++oAa98cNnQtRMIJrcip1JpOj145Sotdiqhjs3
         OpFUdzqXK6S0g==
Message-ID: <37848a79d953888ab2a73183b0271d18.mripard@kernel.org>
Date:   Mon, 17 Jul 2023 14:07:14 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Frank Oltmanns" <frank@oltmanns.dev>
Subject: Re: [PATCH v4 01/11] clk: sunxi-ng: nkm: Use correct parameter name
 for parent HW
In-Reply-To: <20230717-pll-mipi_set_rate_parent-v4-1-04acf1d39765@oltmanns.dev>
References: <20230717-pll-mipi_set_rate_parent-v4-1-04acf1d39765@oltmanns.dev>
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

On Mon, 17 Jul 2023 15:34:25 +0200, Frank Oltmanns wrote:
> ccu_nkm_round_rate() takes a clk_hw as parameter "hw". Since "hw" is the
> nkm clock's parent clk_hw, not the clk_hw of the nkm clock itself,
> change the parameter name to "parent_hw" to make it more clear what
> we're dealing with.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
