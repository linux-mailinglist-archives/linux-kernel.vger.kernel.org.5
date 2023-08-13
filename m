Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372CE77A974
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjHMQNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjHMQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:12:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E153C20;
        Sun, 13 Aug 2023 09:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AEFA6356C;
        Sun, 13 Aug 2023 16:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD26EC433C9;
        Sun, 13 Aug 2023 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691943082;
        bh=Xl+zWuxlzf8UrZZuScqSJCZOz7bnr8WH0zt1Hh4Qr00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bv7KSdTJ0lA805HeMN/fnjuNl4yEWbGFW694vEMhu0z+Xj4InDf6saXe7+TjhJ1Zq
         Qr+loXLrYVoAEk/wteyOmVrUbKMVrmc5ZiWYW5s9aqwFSTKNXBg+q788b6p64hqvfl
         mhgKO3ky1WAGCAKbbLFSvd0ZcIplhXdV6mrJNYEcdxgGPvYv/tLzxMwpMuOaI7fyQf
         Os0zwWTjpNf1RS0KNTHC8PiqK7zsStCGDDSUZerwC0fDhTyI/DEKpVtOfcqAY+XAge
         lelD9PPftsVIqppMqFiPq7wYrqOxM6uLh126n/vj6rUiEWbAmicViNCzif9sDf7rBe
         1MY3fKbx8qw3g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 23/25] staging: fbtft: ili9341: use macro FBTFT_REGISTER_SPI_DRIVER
Date:   Sun, 13 Aug 2023 12:09:34 -0400
Message-Id: <20230813160936.1082758-23-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160936.1082758-1-sashal@kernel.org>
References: <20230813160936.1082758-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.190
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gallais-Pou <rgallaispou@gmail.com>

[ Upstream commit 4912649e1cf0317bf563f91655e04a303cacaf8d ]

Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
ultimately causes a warning when the module probes. Fixes it.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Link: https://lore.kernel.org/r/20230718172024.67488-1-rgallaispou@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/fbtft/fb_ili9341.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
index 9ccd0823c3ab3..47e72b87d76d9 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -145,7 +145,7 @@ static struct fbtft_display display = {
 	},
 };
 
-FBTFT_REGISTER_DRIVER(DRVNAME, "ilitek,ili9341", &display);
+FBTFT_REGISTER_SPI_DRIVER(DRVNAME, "ilitek", "ili9341", &display);
 
 MODULE_ALIAS("spi:" DRVNAME);
 MODULE_ALIAS("platform:" DRVNAME);
-- 
2.40.1

