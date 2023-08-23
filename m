Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13C786233
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbjHWVRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjHWVRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:17:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C9F10DD;
        Wed, 23 Aug 2023 14:17:12 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-319e93a1594so5439313f8f.1;
        Wed, 23 Aug 2023 14:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692825430; x=1693430230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HqvTXQQxpEFsJU9721Xhtm+H9CSOKKaBAgAHD9Eag4c=;
        b=GDNZg2IdF2a1yMe3yxFxrH/93twg2DTUC6uif9LXW8axkuWGrCBmJJnMfl4w1yq1ZX
         rVDHizZzvVTpnmCo8LeGDESDUJq0F48DhIyev417cF4uw7A9+IUbzphfeVa6E4+t5nBM
         S9KdoW8OQ+fMQgeawXElp2K1IqvBlPB94x/91UfOILRiGAYeI4/r8Uu/lv/06O1cL6Uu
         8nfQx/iN+JkKr1jpAem6Z1gSpD/NgXeS6E+xTtWYbfShr7nNmMaqc8OXtzKZsiuL56zw
         jvEon//BVXMXcLoYoW68mE0UY/EmpMGExpCg22cnCwwNgVxuja6mCZMonkDoC7RwU92t
         0pmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692825430; x=1693430230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqvTXQQxpEFsJU9721Xhtm+H9CSOKKaBAgAHD9Eag4c=;
        b=ZrvJGsWCIjND0QdLJu67wwdZ+105BsCGD/aJPanvw7bFLJm8ZylY4LvBWfv2RZonBl
         x7apQLTuxq6ZcjM8KoFeXMQVmKLBiu93Gd+C1M7DVCIofCQWQjRknEsURg5+fvS8VXkM
         KLoir84B4cuFIv8X5tjWtVYPStgslDD+I/hW9Tk1xoFMZZ5PE9tEufWCLHtO4lWdeudH
         oqwYeL9ITXwajmodDDbZT916G9PEgMBFx1GSrnlj+PA3tP9jRvaSrlBtmJVf47Wyz14p
         AHYYMoSo/59Akb658Su9szxtCSXWEVTCWp/cTr4rHiskSf2cIwVrdnNaLs3pjBZcPID8
         ZOCg==
X-Gm-Message-State: AOJu0YyjMA6YG8Y2ESi+OcQoICypbwawt2dd1DvqPUW3ME0dO7J5z/Rb
        8RnwpaOP2UpwSEKAXH+xF4k=
X-Google-Smtp-Source: AGHT+IEddox/bkLvjz6heBTwdc99NNkJXFUpbFi4S2sAhzJJ0YW7W/qMMzBf29U4tQbEzzWF329SCg==
X-Received: by 2002:adf:dc86:0:b0:317:3d6c:5b27 with SMTP id r6-20020adfdc86000000b003173d6c5b27mr10133611wrj.46.1692825430431;
        Wed, 23 Aug 2023 14:17:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:bb2:6df0:64ae:3840:3a64:b26a])
        by smtp.gmail.com with ESMTPSA id p11-20020adfe60b000000b003176c6e87b1sm20193399wrm.81.2023.08.23.14.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 14:17:09 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v8 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id table
Date:   Wed, 23 Aug 2023 23:16:38 +0200
Message-Id: <9950e3963600465e1177a20ad8a93a3927c026ef.1692824815.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1692824815.git.mehdi.djait.k@gmail.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing i2c device id.

Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v8:
v7:
v6:
v5:
v4:
- no changes

v3:                                                                             
- no changes, this patch is introduced in the v2

 drivers/iio/accel/kionix-kx022a-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..b5a85ce3a891 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -30,6 +30,12 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 	return kx022a_probe_internal(dev);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
+
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", },
 	{ }
@@ -42,6 +48,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.of_match_table = kx022a_of_match,
 	  },
 	.probe_new    = kx022a_i2c_probe,
+	.id_table     = kx022a_i2c_id,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
-- 
2.30.2

