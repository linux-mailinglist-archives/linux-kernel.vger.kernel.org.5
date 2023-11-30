Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A74C7FECF1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbjK3Kg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjK3Kgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:36:43 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFAF10E6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:36:49 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A873EC0002;
        Thu, 30 Nov 2023 10:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701340608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B4R/rT8omslDNFvMUpnsZeXUCmWStLp6MEVstgqvAhQ=;
        b=NaDVvJ0cIuXqVRZEYS3m4S674zZtbn4deFb0tLqg1hOKUc2RMdEECclq1rAaJ21YgBFJIx
        uhaPoQtTGgm5AkXlLsQMS7f6ldArPes5b1tmrDdQXEyDc1HL/NQEu0EiWEaz9a5f35bYAP
        9eNaFYzw5DlEob2qDBtD9NH4DDEyXNBTnO3xrzWVQzJo6oS7TUdV+d95C7ZSNzNWHqTvYg
        NQvhKaw63aQG+U6ym1xAztxIkRgTksrwtMGxqiPter6XzPUjlaL8n1/iU17gG//su8aNOT
        +aQiyuciA6R7dQwV8JMsrtxpy55ED+29WAG0lMfQ4TeOcHoQp6SXrPhyVhzsEA==
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
Subject: Re: [PATCH v5 1/4] mtd: rawnand: Add destructive operation
Date:   Thu, 30 Nov 2023 11:36:44 +0100
Message-Id: <20231130103644.715379-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125012438.15191-1-dregan@broadcom.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e82a5a014dd54496efa3f09430d5eaa9726b0f5a'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-25 at 01:24:35 UTC, dregan@broadcom.com wrote:
> From: Boris Brezillon <bbrezillon@kernel.org>
> 
> Erase and program operations need the write protect (wp) pin to be
> de-asserted to take effect. Add the concept of destructive
> operation and pass the information to exec_op() so controllers know
> when they should de-assert this pin without having to decode
> the command opcode.
> 
> Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: David Regan <dregan@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
