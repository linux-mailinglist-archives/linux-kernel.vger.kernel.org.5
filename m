Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96417FECF5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbjK3KhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjK3Kgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:36:51 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D322173B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:36:55 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90CD9FF806;
        Thu, 30 Nov 2023 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701340614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEZ7miS6HTrjZKAV8NWV8so/Cd3xvNaAoPM8VIbL0RE=;
        b=Z8SDxxpkwJC9pJtiiS0ifGleerdoufZGG0zdCezoH0vujHmyWJYFrBsEMC6jbkZeeekZ0h
        1U0gViZL/ps6dk9KwbCwDwOM8m77iW2cudVtpZyMRSPBOwyWj81T5WP/of/gDaMO6radXO
        aF8WQ3m5qtSSsdFolnHOVFgGQtGwEJ5RanGEuOlZRJtuPdvQoGwIcuxHdByTBjipBEtmEX
        aBoJxMiY/Q+9/sgUnrZ8/TmGknbgEtPfeL5YnjTcPqz8szBCDzIAzktu8qp2Gid4EV4J0b
        C7wRzfc+yJvSAIRkZ56Jh5mPl5IDaaacYnEkF1zwPPHiGmb1HXzGnGh9gGB76A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: rawnand: meson: handle OOB buffer according OOB layout
Date:   Thu, 30 Nov 2023 11:36:51 +0100
Message-Id: <20231130103651.715447-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109053953.3863664-1-avkrasnov@salutedevices.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2082b6956ce95b66b03983f3059744f559493d98'
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

On Thu, 2023-11-09 at 05:39:53 UTC, Arseniy Krasnov wrote:
> In case of MTD_OPS_AUTO_OOB mode, MTD/NAND layer fills/reads OOB buffer
> according current OOB layout so we need to follow it in the driver.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
