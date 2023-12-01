Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD9800B78
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 14:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378941AbjLANKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 08:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378926AbjLANKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 08:10:51 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2323A1B3;
        Fri,  1 Dec 2023 05:10:58 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7B5B61C0003;
        Fri,  1 Dec 2023 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701436256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FeCe/iJRh9PXhO+JUUpdycmH2P44LnefnJNVIv/kuk=;
        b=AJqYPYmBu/vDoqeI9rBu4CN8GosfUMAM2vgRkj1+t+8ObxZRYocEBYtYfbqbdzcnWL30W0
        tuGpzJtwIojPVVL8qILibvkexgcKaY7wB8B8oA41718xyiTvDJiPy8SQplMAiYG052ymRg
        itl6SdNjjXS3RTFldZfonOz6aiFIfA5xGQV2bBHnNX0BD49SRqw7E9jSLlFGbluhECx+6Y
        //s5Iqw1+gdCR8Q7C9wa4Mp+qWNgM7FHbUoHQLrtf5t2L4oTN4vQiFyCji5oSZasTUQfbX
        ZWDNQqBXlR0bgjXlG9QFmJDjk7ZuQVC6ydCPEmJdzK2y06x5aHabjC0L/aRLkg==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
Date:   Fri, 01 Dec 2023 14:10:42 +0100
Subject: [PATCH 1/2] docs: nvmem: generate kernel-doc API documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-nvmem-docs-kerneldoc-v1-1-3e8f2b706ce6@bootlin.com>
References: <20231201-nvmem-docs-kerneldoc-v1-0-3e8f2b706ce6@bootlin.com>
In-Reply-To: <20231201-nvmem-docs-kerneldoc-v1-0-3e8f2b706ce6@bootlin.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is useful on its own, and it also enables hyperlink generation for
functions mentioned in ReST documentation.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/driver-api/nvmem.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/driver-api/nvmem.rst b/Documentation/driver-api/nvmem.rst
index de221e91c8e3..d5655b95c0f4 100644
--- a/Documentation/driver-api/nvmem.rst
+++ b/Documentation/driver-api/nvmem.rst
@@ -200,3 +200,9 @@ and let you add cells dynamically.
 Another use case for layouts is the post processing of cells. With layouts,
 it is possible to associate a custom post processing hook to a cell. It
 even possible to add this hook to cells not created by the layout itself.
+
+9. Internal kernel API
+======================
+
+.. kernel-doc:: drivers/nvmem/core.c
+   :export:

-- 
2.34.1

