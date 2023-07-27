Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6C476572F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbjG0PRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjG0PRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:17:38 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4619A4;
        Thu, 27 Jul 2023 08:17:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 92A40FF806;
        Thu, 27 Jul 2023 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690471054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHbaHQtfSw85aARKWOfMOyJNz803y9RsTzGIH1lyXFk=;
        b=jXTAISrKKe3dhaln7MEYli7ghpFwp9K+yvsgPutbOyG2nK3AGrcdai6FGEkmEiFiF2CiPt
        ZmkYOSewHY/YTILZ8cAeD2f2L6k5aKJ3xQwtkcTtUH1C3Yg4tfYkP60EwCUvUM+2X8tZyF
        0mPl4XL7Ngn4Hg7pyeuGZJSjC1N3PNnV5SC8sM7XdQ0OTXLEXWZQUroZzpHiO7W8khG07n
        wOVg+Ys20sa3i21vRCv06W1eQZkzoWtvcOmV9KR+u3fGCWqytpMkKxJ1qhPfnZtugl/mzU
        4O0uetdzmI5JJi85Zf6Z4Tg47RpYPjMOacQWDiXql5OZENTcVMgdqVeN2VOKIg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: fsl_upm: Fix an off-by one test in fun_exec_op()
Date:   Thu, 27 Jul 2023 17:17:31 +0200
Message-Id: <20230727151731.586307-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c6abce60338aa2080973cd95be0aedad528bb41f'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-19 at 21:55:01 UTC, Christophe JAILLET wrote:
> 'op-cs' is copied in 'fun->mchip_number' which is used to access the
> 'mchip_offsets' and the 'rnb_gpio' arrays.
> These arrays have NAND_MAX_CHIPS elements, so the index must be below this
> limit.
> 
> Fix the sanity check in order to avoid the NAND_MAX_CHIPS value. This
> would lead to out-of-bound accesses.
> 
> Fixes: 54309d657767 ("mtd: rawnand: fsl_upm: Implement exec_op()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
