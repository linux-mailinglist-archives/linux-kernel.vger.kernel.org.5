Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F33751A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjGMH6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjGMH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:20 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4258E1724
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77B091BF20D;
        Thu, 13 Jul 2023 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YcZSU7fWFWYPuYRC5H+q0VcT3fSmOy61ISNXR8KDvgo=;
        b=m0Agc5wR/CP7sFKeaVWce/caxtfPbh15rQGFIyEWDLTIPolP4Why/S1kbbOFpSkK2txgFA
        uZbzVmU1dOgnsXX1Ww0XKq/pTDuNItZ5tZGAo8dpAjkhFo04PCDM56WZNPDreXNqrj9NiA
        pGbxDVEKijmys2QscN3bH0RnvDsxrMmk7F5wgU/AluA0qjZsid5Qif/az6wlrnqi1haIHu
        p1jHCevCA9W6tH3yJAW+8C5gn9ht71z5CuJOP1ssSMWHzKcSRzyn1LmCnIuCXWl6GI7Xwu
        a1RKBYRPwFLY5awuqJkUAPUDe9hWw5rQ73aESHImpeL+TrYDxIYYtJVYTVJIwQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/18] mtd: rawnand: sh_flctl: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:58:16 +0200
Message-Id: <20230713075816.486307-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-4-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4eef841d29fac5fc8500668d1498a1ab8f9a91ce'
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

On Fri, 2023-07-07 at 04:06:08 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
