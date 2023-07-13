Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60379751AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjGMIAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233639AbjGMH7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:59:32 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F9030D1;
        Thu, 13 Jul 2023 00:58:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B96A1E0008;
        Thu, 13 Jul 2023 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=btfcTaMxTQ02PSlnbX5V3o2sBc1OCsVPCe9sHQUY0AQ=;
        b=i5gFwm9c0W4b8Kq3SQR47prgKPw792/M8EFlTQZWMOXe99ZwXKhuLl/WiI58Owu2cBbJLc
        WIjsLx4KPTsF9xcBVtW4HnnRRfBge6/zt30sT5cpp/yjbrpkj67blmA+opX6QHCinZZ+Y5
        PXO3ksb9GQnn8hTgb0NKl+RpbCrIXMHDojFboGUENuPV9vWbumF7Vodkg0UHP3AlHEor3r
        ekW0h1TZ4AYL7Di6ChJPG2TVXkJ8x9CrId1KEE81pdZrrR482KhhgRsYUfbd556n2BFsOK
        to5FDO96WqqRvpET/yYSGsLb0OZMqoBGS3mVDnHGXDmYMlK+lZphqapy0Us6lw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     William Zhang <william.zhang@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux MTD List <linux-mtd@lists.infradead.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>, f.fainelli@gmail.com,
        rafal@milecki.pl, kursad.oney@broadcom.com,
        joel.peshkin@broadcom.com, computersforpeace@gmail.com,
        anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
        tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        stable@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: Re: [PATCH v4 1/5] mtd: rawnand: brcmnand: Fix ECC level field setting for v7.2 controller
Date:   Thu, 13 Jul 2023 09:58:48 +0200
Message-Id: <20230713075848.486574-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706182909.79151-2-william.zhang@broadcom.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2ec2839a9062db8a592525a3fdabd42dcd9a3a9b'
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

On Thu, 2023-07-06 at 18:29:05 UTC, William Zhang wrote:
> v7.2 controller has different ECC level field size and shift in the acc
> control register than its predecessor and successor controller. It needs
> to be set specifically.
> 
> Fixes: decba6d47869 ("mtd: brcmnand: Add v7.2 controller support")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: stable@vger.kernel.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
