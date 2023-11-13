Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEC7E9ABA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKMLJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKMLI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:08:58 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE06E10E2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 03:08:55 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C701B1BF208;
        Mon, 13 Nov 2023 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699873734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eaphmM6hYiQBBEFR2QDcmwO2Aw4HESGApRcZOOVCqXE=;
        b=BijmxQERoMJLuoyPvHgHMppRMk9EGPFtaz3Er9me4bT3uAkjxg5jxzib5ndPgsyoGKC9S4
        ksq886+JqTIBAoRgkjYzJdFrTR7QtQWZIqDda4l2Fkt7O1CxL6hq0RQu/wWe8m89URQagd
        zOBZursmeyUeb7YQlYNHwiHDfqKRdt1kRWI9WCBomfZwFaps46pHL0z+/YqpvH/JRWJsJG
        8HBzaDj+uSpDQy6/dxmUZPEDLj3sjU+2cmC70YhLb4hQqwsHcx2522TAbIRe6A/G7Clsuc
        yDXasF5fP8BqEIyzA/oZp0LKJ3iD9MrdWpyqBdSB6utpfpbVHNSe1i2FxC3xXA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Han Xu <han.xu@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Roese <sr@denx.de>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: gigadevice: Fix the get ecc status issue
Date:   Mon, 13 Nov 2023 12:08:52 +0100
Message-Id: <20231113110852.281040-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108150701.593912-1-han.xu@nxp.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7c1b1906229db88c487e21e1ecb622db64a1830d'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-11-08 at 15:07:01 UTC, Han Xu wrote:
> Some GigaDevice ecc_get_status functions use on-stack buffer for
> spi_mem_op causes spi_mem_check_op failing, fix the issue by using
> spinand scratchbuf.
> 
> Fixes: c40c7a990a46 ("mtd: spinand: Add support for GigaDevice GD5F1GQ4UExxG")
> Signed-off-by: Han Xu <han.xu@nxp.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
