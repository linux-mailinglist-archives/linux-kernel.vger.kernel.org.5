Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802CA754A17
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjGOQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGOQTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:19:36 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE030E5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:19:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B81760005;
        Sat, 15 Jul 2023 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689437968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5eSGz3mdDJT8ii5lSTM1lv7ax6hZiqzfSWulMz49pEw=;
        b=cpVqsvmThjjQ8rjhsGQ7TRfrsXzx1zXOJsnGisC+xFld92EpXtx83zTE8H02zXHT6SydVr
        IbiRUgkHobbzgaQ5RSEbFGOQkWL0hVKx2pfV5ry7QKOBPJh5P1ZGy3/1RgQkqacdNNeWPo
        +mEGawmiEnhRFabXMow+Qwt/ljk4mMbFwX/B8ky/Jl86TKDMoigYBWDhe6s+AAXK/C9Kwr
        2Jdfou1E7s1z5IZ3yygogkf2adIZI2KxNySLaxbX6lcKoY0woM6DEokO/ZX5aiQsqatj7y
        Q06JJK/WTjZAln//bBYn78QKt2CDFK7den17iM8XMW39YHg0V9vQ3voajmO7Kg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Johan Jonker <jbx6244@gmail.com>, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, yifeng.zhao@rock-chips.com
Subject: Re: [PATCH v5 1/2] mtd: rawnand: rockchip: fix oobfree offset and description
Date:   Sat, 15 Jul 2023 18:19:25 +0200
Message-Id: <20230715161925.20644-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d202f12d-188c-20e8-f2c2-9cc874ad4d22@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd0ca3b92b7a6f42841ea9da8492aaf649db79780'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-14 at 15:21:01 UTC, Johan Jonker wrote:
> Rockchip boot blocks are written per 4 x 512 byte sectors per page.
> Each page with boot blocks must have a page address (PA) pointer in OOB
> to the next page.
> 
> The currently advertised free OOB area starts at offset 6, like
> if 4 PA bytes were located right after the BBM. This is wrong as the
> PA bytes are located right before the ECC bytes.
> 
> Fix the layout by allowing access to all bytes between the BBM and the
> PA bytes instead of reserving 4 bytes right after the BBM.
> 
> This change breaks existing jffs2 users.
> 
> Fixes: 058e0e847d54 ("mtd: rawnand: rockchip: NFC driver for RK3308, RK2928 and others")
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
