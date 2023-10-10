Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2937BF18A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442039AbjJJDcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442026AbjJJDcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:32:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB8A7;
        Mon,  9 Oct 2023 20:32:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47378C433C8;
        Tue, 10 Oct 2023 03:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696908729;
        bh=B68ZS+iZCQ2ic0jSsOKYvXhYAqB/F+u9BsETN2n0sX8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h1+aKPjAV7G3J5eiPgE7b3bj1RVkNT3nz1aPEqhMgNdPCrXZ52ZQTMR64SlgIA/eF
         ebPLu/BtaIo2KzUdQTJsUpCWikLuuiNprf0YaW5dfFLJgdNEetOhCTBKNMcPAFNdOM
         VjrnltBktkPHkut+3GwgqgqzWweqmcnL6BR6wmpWKS6tRZ6lWvrIMaD6i31hTBjC52
         t7y7d1qrfN6W3ZHWqkvai3E0dJ1DY8KZd9YcDUIMxbv59Zojn/MQVfn/ZvKAk7XjW8
         tlPw0QwTYdkp0cFlMFGeq7LL+HP1jZREUsGFDut6pbMYw0Y+0bz6RvIZc7Muj/llrY
         ubp2n68WB41VA==
Message-ID: <97b9af079df94e61755452fe15c160d8.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230929-clk-maple-versaclk-v1-3-24dd5b3d8689@kernel.org>
References: <20230929-clk-maple-versaclk-v1-0-24dd5b3d8689@kernel.org> <20230929-clk-maple-versaclk-v1-3-24dd5b3d8689@kernel.org>
Subject: Re: [PATCH 3/4] clk: versaclock5: Convert to use maple tree register cache
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 09 Oct 2023 20:32:07 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2023-09-29 07:26:07)
> The maple tree register cache is based on a much more modern data structu=
re
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
>=20
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied to clk-next
