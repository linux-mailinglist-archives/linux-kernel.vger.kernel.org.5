Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF257FECEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjK3Kgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbjK3Kgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:36:36 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D0F1708
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:36:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32BC160004;
        Thu, 30 Nov 2023 10:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701340602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD6NzcOjgtTtJsTzF2WOxi5yJUg/3VS2nIW03qLJHts=;
        b=nHiWyfrEn7/XnSCyyIuVvBA417mXeWm5/NwO0X8fcYTcSl70shKbqkqQFJf6rL25UQxQy7
        KhOq+eTMiI7OuH9FFQMiFBwN1hNgHERX6v9M/Ea5X2nrFDmyMh9G7wrm1IafJT3LdVjOa0
        MlxIZnTUE+wKCtMi1+GrOe31s5CBmiYoDNf33K6CddrPJeDIZVQ/6ghwVVRwowACwduG7+
        jT/uqfzpLG1CaSY/3mCabqbfbpfnoXa3thc5qNFB+3EjAsFj2whhQjN1MoVfYA5J7GQP9r
        4w/kW/WQeg6b8VGLKeyHW12zEfBzNJ3DaF9bvs8fZFVE3qloXVns5Y+WFOB9Mg==
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
Subject: Re: [PATCH v5 2/4] mtd: rawnand: NAND controller write protect
Date:   Thu, 30 Nov 2023 11:36:37 +0100
Message-Id: <20231130103637.715341-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125012438.15191-2-dregan@broadcom.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'42ae3f2b5f4942e0d36201184a1b5366d9430c73'
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

On Sat, 2023-11-25 at 01:24:36 UTC, dregan@broadcom.com wrote:
> From: David Regan <dregan@broadcom.com>
> 
> Allow NAND controller to be responsible for write protect pin
> handling during fast path and exec_op destructive operation
> when controller_wp flag is set.
> 
> Signed-off-by: David Regan <dregan@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
