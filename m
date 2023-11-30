Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E87FECEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjK3Kgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbjK3Kga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:36:30 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684710F5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:36:35 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C87EFF815;
        Thu, 30 Nov 2023 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701340594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tXGibL4JFLJ6Qk8J3/pSKDXmUg+l1GSINDae8lI3n6g=;
        b=inQ84HZS9Wu7ORtl5d/GTXif5Z4xhhLYPS68duwZfTOmFpUd0vHDXC48Wls+cD6Q//B2k8
        Vmd4Zf8bQgzr3e8YxbyX03/CPim2DjKfK/O5I701B1Ja+5eUNmHjjU997mSmnzmDooNy7k
        lLXpBBh5+cUNRIG7rus3F9LHQRauZXajNJRkRuxgRId/eSYwUWkRyjkDwSL+p0SR7oc6qM
        xzwD7iHQWfpaLK9VnJ0NnhmV0fUlpqRj2lvy+UL1hVgXAw481zTf9BbUzoNLMs3STM/VHS
        gqCLVc6EhlDwxr39ViUZmF5WancLAy/n4+cJavGr0WGj4LlKy1u8Sil9+ncrBg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dregan@broadcom.com, miquel.raynal@bootlin.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
        rafal@milecki.pl, joel.peshkin@broadcom.com,
        computersforpeace@gmail.com, dan.beygelman@broadcom.com,
        william.zhang@broadcom.com, frieder.schrempf@kontron.de,
        linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        bbrezillon@kernel.org, kdasu.kdev@gmail.com,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH v5 3/4] mtd: rawnand: brcmnand: pass host struct to bcmnand_ctrl_poll_status
Date:   Thu, 30 Nov 2023 11:36:30 +0100
Message-Id: <20231130103631.715302-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125012438.15191-3-dregan@broadcom.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7d93debe84e1adc5a299a520c23d361572ab7b30'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-25 at 01:24:37 UTC, dregan@broadcom.com wrote:
> From: David Regan <dregan@broadcom.com>
> 
> Pass host struct to bcmnand_ctrl_poll_status instead of ctrl struct
> since real time status requires host, and ctrl is a member of host.
> Real time status is required for low level commands vs cached status
> since the NAND controller will not do an automatic status read at the
> end of a low level command as it would with a high level command.
> 
> Signed-off-by: David Regan <dregan@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
