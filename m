Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051E67AB411
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjIVOvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjIVOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:51:30 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C66180
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:51:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B41AA6000B;
        Fri, 22 Sep 2023 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695394282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XoRUll6CaorBhs0khbfmRz9BF9/JTkYhq0xhHzZ3EUM=;
        b=ex4JyoMjQ1GB/sXvlDYbkr5R/96btL6C1gZgOnfYfsrwAh92b5cF40Go53MegJ5I0xwv3/
        hO9PNGlRcP2zlAYmdNI9HO7XnD+GSCliVsIRQ9nC+210FkZh1FA188FXxEBBawpkPOgm2r
        BaQHPgYtGGyXu7hIAcZcIGT1Ow9nkUHejkz8tuCXNWIvk2sxYGkeyo/WwBy0x9ZZ5IfTPR
        qxWOsWrayM8AMV+tdnaZ5Tu8FiccEe2VLAs4XE8B1h4CJgVRI0wHuhcEx+B7+hOuUMB6mr
        8K8veM4IEAATv7QzSvfwuhpDfIr1iVqWB1nIS5jDCuoHfi87g2X+eXTGf+K/iA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org
Cc:     linus.walleij@linaro.org, b.spranger@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: map_ram: prevent use of point and unpoint when NO_XIP is set
Date:   Fri, 22 Sep 2023 16:51:21 +0200
Message-Id: <20230922145121.578332-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919113320.16953-1-shivamurthy.shastri@linutronix.de>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3cff177fc2793a362d784c912f536e69a755925e'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 11:33:20 UTC, Shivamurthy Shastri wrote:
> When the DT property no-unaligned-direct-access is set, map->phys is set
> to NO_XIP. With this property set, the flash should not be exposed
> directly to MTD users, since it cannot be mapped.
> 
> map_ram() exposes the flash direct access unconditionally which leads to
> access errors (when the bus width does not match the RAM width).
> 
> Therefore do not set point and unpoint when NO_XIP is set.
> 
> Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
