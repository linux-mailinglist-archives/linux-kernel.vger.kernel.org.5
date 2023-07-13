Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09990751A93
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjGMH7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGMH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:26 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221A42113
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:24 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEB32C0014;
        Thu, 13 Jul 2023 07:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOOKKOgHpze4FeXkYNNaRLp/XT+oG2qmHyAhGV4nrro=;
        b=SVLYoMMOcJX5aFQU3D7QXMSNQLy7T6vHOFefe+6TluM+6+98qopFN9rD7wt5yVuhKRbXpR
        hhuqzmyM/MVXnyubqTS18WhPTCklvG74QD2gfiZBkl18LYZHY4GXET/EN1RBX8b86m/PK4
        54P/jdjgIg+Y4uzV7CTbrILLuZAt95zH1Kz9+6qFo2EOSvCRKBucUTZnA/n978ZeOogEpI
        p3VSD/tw16b6W4QgZB7BJYaPPdVnKkAa2Mo0q3V/txqR/8lUIqVUZ/9r7SWabRIndqOg1/
        XHqh+6S3TA8kbw9ccgmlWy5S4zlzmFaYit0VSe8nmJlcEZ1JPfQ8gnZ86Sr1mA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/18] mtd: rawnand: lpc32xx_slc: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:58:22 +0200
Message-Id: <20230713075822.486365-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-2-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1c66c7523f2fd2d9c8f81a2b7116252c323847a0'
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

On Fri, 2023-07-07 at 04:06:06 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
