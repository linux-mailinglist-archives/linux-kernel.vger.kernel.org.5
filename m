Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8D79B835
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358821AbjIKWNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242598AbjIKPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:53:59 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D10C1B6;
        Mon, 11 Sep 2023 08:53:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E264560010;
        Mon, 11 Sep 2023 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694447631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlumLDfPViZc0xloFKIh644KDGw78c+ut/NV7iKNtlQ=;
        b=PGYyhmBDNxgZ23BYOsmdh+lwPt+28Bu0FcRd5Y0euqtud4y8TVkLV5w1nqSLU3RhGc0ged
        ZMx0YS7XU4RIMdFShZSRG+7+4uq+tYiS7oSIvMd/O0umfw/ZAh+O89Y0qHI5+XaI8QdMw7
        tqBE/RfhWXmIMGu0bqpYBl9i17WwJxQfRZ0Pwalccef1RMGombaFZaiT387NI50rfg6ehm
        hJWDgZ/ITNPFRxUySAvfzy0G9acnFCbnvJacSil2KtV/76zis/Ay+tXHP5buSv2KQoCUSC
        xKAnqYm3NFswi6TeVP9y2dpSpk9C1s6tcx3+my40GVlrHjqceleGPILjemvVwA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ricardo Ribalda <ribalda@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: physmap-core: Restore map_rom fallback
Date:   Mon, 11 Sep 2023 17:52:42 +0200
Message-Id: <20230911155242.610991-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <550e8c8c1da4c4baeb3d71ff79b14a18d4194f9e.1693407371.git.geert+renesas@glider.be>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6792b7fce610bcd1cf3e07af3607fe7e2c38c1d8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-30 at 15:00:34 UTC, Geert Uytterhoeven wrote:
> When the exact mapping type driver was not available, the old
> physmap_of_core driver fell back to mapping the region as ROM.
> Unfortunately this feature was lost when the DT and pdata cases were
> merged.  Revive this useful feature.
> 
> Fixes: 642b1e8dbed7bbbf ("mtd: maps: Merge physmap_of.c into physmap-core.c")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
