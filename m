Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85DB75A4C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjGTD26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjGTD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:28:54 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42231B9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:28:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5577004e21bso115123a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689823733; x=1692415733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0oNMuifMnagYqKrM9m6tne2TXEDYzPsYeKHQDjncmo=;
        b=M4HqC7jN8AZVdfqhxjxnS/wDHCfOln+PN29vS+/sLBxxp714NS48ojlUBY7qv1rfht
         9UVzKpFmyW0hblPll1g+fVFC7iM2Vqz75okVG0ntCj9DnNl4x/sAwxXevZUGL62ntnnj
         XKvGeQSxtP+o3Lkm6frKkX4WoxUfTaKNOxqTtic1eBR5RCLrDtUS0nzxr5qPFED25pDI
         OrT/VxxHfn8UETIjYwLhYgtQ9uVASRH5JQ+00tPVEGd/0K4L4f5zoF6oacNS8LwVOlOo
         uxAdy+vOQBu6QDvBOcuSyD9A/3aOdBuhfAmCJBcEvu/678B7QrksujMuAonWmxmwbXwT
         Agrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689823733; x=1692415733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L0oNMuifMnagYqKrM9m6tne2TXEDYzPsYeKHQDjncmo=;
        b=gNQ9lfi30D9Gzl5MMlLBQ/b0GgF0kifIjBaew+F2ehYtlhF5EGgl8FZJy5I5tQMhrn
         48uqRjqsisNnb9hrMZfj5GNMmCUFzYR5LFM3RitPGwsx61tDBHumhslGRXWiFRg5Ev0s
         c6Ir4whHn1lLa62wqq6pW5rtrp9JP5XtZ4KZ3wsU4FdO6x8WRylctaPKexUCMG+m8Tq+
         Y6bbTBDq17TZBZct3Zr1bCYJ+OWZVstrk1sz3miH+Os3Jx9woK4QFL9Lo27SmRdfp2gO
         Xc+k2Fj1McSOOcRgPurBppscru4MHqYYKhp+VnncVuYJWV3IFgiBS4P6hbmuDpQ5iure
         ZMqQ==
X-Gm-Message-State: ABy/qLZGKctTOdk9dBZyZyOPkUecz69rzjBT7mV3+LFXgYoWaRidGT1u
        IyVpc7i9avvDztAUSbK4e4Y=
X-Google-Smtp-Source: APBJJlEGrn/TAM66qTK48NqW1RYKdL+5mBzACHHGWOwLXN/4EyYY2xV2QMSTqyAncRjOTwW/ahm+/Q==
X-Received: by 2002:a05:6a20:3d22:b0:133:5352:c7ac with SMTP id y34-20020a056a203d2200b001335352c7acmr8195018pzi.38.1689823733344;
        Wed, 19 Jul 2023 20:28:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090274c300b001b80b428d4bsm23225plt.67.2023.07.19.20.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 20:28:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH 2/2] regmap: Reject fast_io regmap configurations with RBTREE and MAPLE caches
Date:   Wed, 19 Jul 2023 20:28:48 -0700
Message-Id: <20230720032848.1306349-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720032848.1306349-1-linux@roeck-us.net>
References: <20230720032848.1306349-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

REGCACHE_RBTREE and REGCACHE_MAPLE dynamically allocate memory for regmap
operations. This is incompatible with spinlock based locking which is used
for fast_io operations. Reject affected configurations.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This seems prudent, given that accesses will be protected by spinlock
but may allocate memory with GFP_KERNEL. Another option might be to use
WARN_ON instead of rejecting the configuration to avoid hard regressions
(and I think both drivers/net/ieee802154/mcr20a.c and
sound/soc/codecs/sti-sas.c may be affected, though I can not test it).

 drivers/base/regmap/regmap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 89a7f1c459c1..b4640285c0b9 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -777,6 +777,15 @@ struct regmap *__regmap_init(struct device *dev,
 	} else {
 		if ((bus && bus->fast_io) ||
 		    config->fast_io) {
+			/*
+			 * fast_io is incompatible with REGCACHE_RBTREE and REGCACHE_MAPLE
+			 * since both need to dynamically allocate memory.
+			 */
+			if (config->cache_type == REGCACHE_RBTREE ||
+			    config->cache_type == REGCACHE_MAPLE) {
+				ret = -EINVAL;
+				goto err_name;
+			}
 			if (config->use_raw_spinlock) {
 				raw_spin_lock_init(&map->raw_spinlock);
 				map->lock = regmap_lock_raw_spinlock;
-- 
2.39.2

