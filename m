Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F06806564
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjLFDFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:05:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C31AA;
        Tue,  5 Dec 2023 19:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tCDaEFASEaOM0xCnH4GzWPewdM5mMFU6qA94jFCl3Wk=; b=W+IumrHhlp4WIUBpIpxh4HMWIa
        NMKWZOmrhl4rGxxkvHVzHJRHB3f8/1caKxSntLEuEmki1LgjTU+jZ7xuDC7ruVnK94v81Jt3kmy1W
        sawTOVM5UZbC0n5O3c35VUvOeeJ/96CCCjyDzY7uhYMUGn2PF0yKGaMClw2gmhsL68U6z0ivTDli9
        FLjYhLH+w9dMLpPzBsGaYigiCRGZjdA+eUaYbf/OEPPg75cemIfWrlTzdIjZREwymcpA04BakODbE
        J8fOgGi1JUItV3650Dbal18mN7mwuzRl+XnaxTIisZXcN0GWcjRdph5Qks6k50MWUHO0LvUMxcVNi
        Pa3i4yLg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAiDz-008vhk-2a;
        Wed, 06 Dec 2023 03:05:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] gpio: max730x: don't use kernel-doc marker for regular comment
Date:   Tue,  5 Dec 2023 19:05:23 -0800
Message-ID: <20231206030523.302-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a common C comment (/*) instead of kernel-doc notation to prevent
warnings from scripts/kernel-doc.

gpio-max730x.c:3: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
gpio-max730x.c:3: warning: missing initial short description on line:
 * Copyright (C) 2006 Juergen Beisert, Pengutronix

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/gpio/gpio-max730x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/gpio/gpio-max730x.c b/drivers/gpio/gpio-max730x.c
--- a/drivers/gpio/gpio-max730x.c
+++ b/drivers/gpio/gpio-max730x.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * Copyright (C) 2006 Juergen Beisert, Pengutronix
  * Copyright (C) 2008 Guennadi Liakhovetski, Pengutronix
  * Copyright (C) 2009 Wolfram Sang, Pengutronix
