Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647DA7A27C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbjIOUL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbjIOULF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:11:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF102735
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:54 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c39a4f14bcso23390685ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694808654; x=1695413454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rGCQZXOZFob52Gnc+msXzDi2Oa5SKWBAnf/TmWNgRE=;
        b=RSLa+SdsZjo7xryoCNlLiD17Vgf8IBCUn93v511Mr6wKCDJ0OZX22+5ch6X7toJa0d
         a3R5VLM75B736tA1Oy3bccnrLH7wMEInufT2W9oDyqYwOt0aJf0WS/RBZrTvn2uiPIdm
         lbJYlUX4dE+hBOpnChhPX7GgO1ivg621OIzDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694808654; x=1695413454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rGCQZXOZFob52Gnc+msXzDi2Oa5SKWBAnf/TmWNgRE=;
        b=vv7aCbopKicvLDcE4bEh4tNn56wzZh4Gg9eQCgd0Ee+EJX1h+NsY6cMKpg+XBSQAR3
         5uXFDgDoCTNnpFNYz5r9E82uGVlr6NUVStfrbTiuaRW0Hv2G6y3jsDF+9/AYRq0ZHJQe
         p1Hy97MlNtqXS/M4dHckg2cozGhV6XRVIgtsI26IqUzzF3j2SgiKbDC1ZshNCNRGu0Lw
         eNGJmAGrHxvpZkAyN44mJomo30LUiCQamxTzyQFy+3OwR+bLUd5STGzEGqfCodcyD44F
         fLD77vkMPMTXgZcYYpUlVTVhjPQmzcekPBpvFT4CpeqDIulr+x5Rs/t6srpO0/43dsv1
         UesA==
X-Gm-Message-State: AOJu0YytQCXDIf2MHU0WtaF6QztXfuWLhlnKep9jfcXelwUeE6dey2YY
        q3TktKgVaAQhfyvGyZQqNdYnKg==
X-Google-Smtp-Source: AGHT+IEs5lOaR2Ta2Mws1l9cp/mRyT2P58L6rAu8X1p1avpmZi1GYS+ZtJEyDjHT8joJnRpmAmtC5A==
X-Received: by 2002:a17:903:22cc:b0:1c4:13f:9dd3 with SMTP id y12-20020a17090322cc00b001c4013f9dd3mr3457711plg.62.1694808654451;
        Fri, 15 Sep 2023 13:10:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b001bdca6456b9sm3904606plh.17.2023.09.15.13.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 13:10:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Kees Cook <keescook@chromium.org>, Lee Jones <lee@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alice Chen <alice_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        kernel test robot <lkp@intel.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] leds: mt6370: Annotate struct mt6370_priv with __counted_by
Date:   Fri, 15 Sep 2023 13:10:52 -0700
Message-Id: <20230915201051.never.429-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=keescook@chromium.org;
 h=from:subject:message-id; bh=coE/iSzW/9UhtjCTK3P8Gz63+gP8L3K/+tYQMkvh0is=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlBLpMEabFyu4iy+cSm/IiRf1sxT9B50iyRXrIa
 1U8Y2+HfRSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQS6TAAKCRCJcvTf3G3A
 JqR9D/kB+HRM4Ne/WaOq10KenW2vk7P75UuXI5Jub8jHjnyyum8tphcbeG+hgOsmtv/58Whcs70
 n0FswYXFTWoWh7E7chImCAqAjk7e1w+p6hX+cDqRx/p2Ye36TpSe4GRFESmTs8qvf5jJeqpkgI7
 a13SXZalZVypMYSHWpxC8SnLbdfRnZjwc+aii8s7cwTxD6SRB6is0+q91VfuFeZzBX24z77AGtT
 VkXo6fdWWZV4GIWD12a0kzcul+7Uxpa0aB4DQ1NOFLjA9WrHyRhwrGmDGbHuswn5kFM4IayZzui
 Pkis6fT1iFeKKO6RdYKDGUtYbEP4mvXOVQ2/XMUodrY2c9x/oA+KosAoPSrir673KWOOHofAHD3
 5AL8W5EzhbS3BnTwYJX669gI82yKLDX+IEX7CodlJVrK33ZNmVF31puCUqzL462U7tMxWPmnlBb
 OftVJhzzw7hfxwndI7LoXe8OevLuAy2DYbWh389xPIoLPh7X0BZR4xHqgMTHEypF08hh0q5lNlx
 +EZ03lTN7zwMfA/0RUG9XOexK+kmOhS8Y9Qj4aw45BxhvPHhRJw8XETmXO26Rc/+RRfL1+KH/o7
 Mqw0xayOuPh650DTC2CZv0a+PoHnaYkOm1kaE4tFx0OX9R1VTMeJD8TmvF8+r4Il478NvyQxABt
 BcXYqKz l4fOiO5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mt6370_priv.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Alice Chen <alice_chen@richtek.com>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: ChiYuan Huang <cy_huang@richtek.com>
Cc: ChiaEn Wu <chiaen_wu@richtek.com>
Cc: kernel test robot <lkp@intel.com>
Cc: linux-leds@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/leds/flash/leds-mt6370-flash.c | 2 +-
 drivers/leds/rgb/leds-mt6370-rgb.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/flash/leds-mt6370-flash.c b/drivers/leds/flash/leds-mt6370-flash.c
index 931067c8a75f..912d9d622320 100644
--- a/drivers/leds/flash/leds-mt6370-flash.c
+++ b/drivers/leds/flash/leds-mt6370-flash.c
@@ -81,7 +81,7 @@ struct mt6370_priv {
 	unsigned int fled_torch_used;
 	unsigned int leds_active;
 	unsigned int leds_count;
-	struct mt6370_led leds[];
+	struct mt6370_led leds[] __counted_by(leds_count);
 };
 
 static int mt6370_torch_brightness_set(struct led_classdev *lcdev, enum led_brightness level)
diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
index bb62431efe83..448d0da11848 100644
--- a/drivers/leds/rgb/leds-mt6370-rgb.c
+++ b/drivers/leds/rgb/leds-mt6370-rgb.c
@@ -153,7 +153,7 @@ struct mt6370_priv {
 	const struct mt6370_pdata *pdata;
 	unsigned int leds_count;
 	unsigned int leds_active;
-	struct mt6370_led leds[];
+	struct mt6370_led leds[] __counted_by(leds_count);
 };
 
 static const struct reg_field common_reg_fields[F_MAX_FIELDS] = {
-- 
2.34.1

