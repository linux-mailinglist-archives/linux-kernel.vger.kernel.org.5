Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11408751A96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjGMH7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjGMH6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:58:31 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44912693
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:58:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B8AF2000C;
        Thu, 13 Jul 2023 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689235108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9q2SKNt2PhBmQJxTl3Ovldz3f96cAdwP/DWOmBPMQA=;
        b=IocbEYCQ3NmhSKcKpvl75FWn1Vfro53riOL8Pc/QTA14U411GxTT34cT+w2zf+xP/iBmCw
        u+x570VKhpqXC3Sjx90LMl+JYfirHXY/HGCJIlG1SQY6cVXJztoWlxJqyhYAwgxdcO631F
        Obule/bqODSEB5Xf9O2ax9kVOP7lwSqvYzEvBhWgzCO93GiWs+6Qfw/R5WvOPE152mQQCP
        v5hu8l4Apa6ia3vA4zEIy5kRciVOBB1IuJIDJHhw+g1ABHBNLsPJG86HKtuA4CaCuUNSTC
        WXw7gc/QBf2k/YqoxXe62wEXREMZ7hSJT7GjpJL+l09oW2OnxOpn5gEua6hOPw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/18] mtd: rawnand: sunxi: Use devm_platform_get_and_ioremap_resource()
Date:   Thu, 13 Jul 2023 09:58:25 +0200
Message-Id: <20230713075825.486421-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-1-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'81a16e154cc03e3ec76537694ab4afb8df3965eb'
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

On Fri, 2023-07-07 at 04:06:05 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
