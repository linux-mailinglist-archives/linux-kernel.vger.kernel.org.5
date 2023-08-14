Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8675177BE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjHNQya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjHNQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:53:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135610C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so11562479a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032035; x=1692636835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpG5xoR5nd9ii5gkHdTczwLX0qJ5SYNBKOgpUUODUYc=;
        b=lX0S8PUOiLkqwNBSyEWVFeDLHk1n20HS7DtNlkS620YBU0Ic+6p/owCcWhAU+Vxj+V
         MPk7pXqFvIwKKQ2cvUMqOudCL3134OVFYAEWr+PSbB4P2wHVXfB1BBpxLqdJau2Rg6h8
         5kL8w9hG9EzkBgtwslrA9hfWpczDxZwI/vKF0beHvcsLamSNA8/cpdqW240rPUcEGyDg
         4MCseEyv0qMWXU1tpWWZENOSaTRU6bSWksUZJ0YJJzieKfUB43v4XPxytZo0XlHb68+4
         QbzADFqRoNoe2wmlD9Q5jRXXHkYaPFwYIDas8HITkTsZcapRjetViVM+qmsGd5wfnKCb
         vyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032035; x=1692636835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpG5xoR5nd9ii5gkHdTczwLX0qJ5SYNBKOgpUUODUYc=;
        b=FSgaHynm2FWw6cPzVgOeAJC7QUpDE+vIoykzmNKku6Bq1qo1F/R4FzGincHSWns+h3
         hpjr8HoqG+L8Jv0uagxiII2phnaQkRgqcYEJufEXXfgHsh44aCGbNzxx0CX4oaQtunUF
         qwSNMLDxMUiigSwcG/gCobaUcwHaIG0L0+RGmXa8A9mNsHSPkYAiVOfdTuUuQXms4Twj
         YBlsxI+Y64YG5yvEfHN+0NsvsMEFgG/XfxvRlWFBDjDZVb27GnUoLIb0TMCdIUS4SIut
         2FnmDEaYPijAnwQK3PzBA2umxeMPMPODklKaANvmfKVkICikHrBavHUO0rdiZCkvnvmh
         D3rw==
X-Gm-Message-State: AOJu0YyLlpZJ8Nu9TD6YlAnMCmCIm6GZ9/JzrNxN+gVrfxwwC4dcaSPK
        9vyWCnVAKskfjRAQgCiJEfRlHg==
X-Google-Smtp-Source: AGHT+IGMkff9aNIBPoitasXSG2Quwal4eOKLoQ6lzIuhnbAa+mp9r/DuAvasKBoup34yF1L7jlVutw==
X-Received: by 2002:aa7:c2d1:0:b0:523:37f0:2d12 with SMTP id m17-20020aa7c2d1000000b0052337f02d12mr10468029edp.17.1692032035200;
        Mon, 14 Aug 2023 09:53:55 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Atul Raut <rauji.raut@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 18/22] nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Date:   Mon, 14 Aug 2023 17:52:48 +0100
Message-Id: <20230814165252.93422-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atul Raut <rauji.raut@gmail.com>

We are moving toward replacing zero-length arrays with C99 flexible-array
members since they are deprecated. Therefore, the new DECLARE_FLEX_ARRAY()
helper macro should be used to replace the zero-length array declaration.

This fixes warnings such as:
./drivers/nvmem/u-boot-env.c:50:9-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 80c5382b361c..c4ae94af4af7 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -47,7 +47,7 @@ struct u_boot_env_image_broadcom {
 	__le32 magic;
 	__le32 len;
 	__le32 crc32;
-	uint8_t data[0];
+	DECLARE_FLEX_ARRAY(uint8_t, data);
 } __packed;
 
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
-- 
2.25.1

