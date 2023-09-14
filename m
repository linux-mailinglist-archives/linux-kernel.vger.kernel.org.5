Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7C37A0F4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjINUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjINUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:52:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1761BEF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:52:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7b957fd276so1744677276.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694724742; x=1695329542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y1bfYCZeoEdKY0xCX07ePzY5ryWaYVbqIYptARC7NJg=;
        b=NvPAN8vmZH8DfMmys9TDmLInWpPq9YbkZCLXR6RLNMVSrtBW/FzkjXrkR+VJNe0Dk/
         FviCs/pFWGDPVZGFlQPpspZLWWGo2yP+Emun8VHb1tdvrjDrluv91O5Zknvw7yyTymmd
         9V3wVViLLN4reoAYmNS3vX2rGdOr0Ppefq8w7bwPhuBQXeApw8dH9137o0StaDePj2Wt
         d2O0i1CWBZPyj5Cf89PtqTuWbinqvV+bVIV8ow5sd1LobS1AreXnJ+mRete+ZUBng0Un
         tWfRpTtSIXNVSy96Caecylmey7Wy8b3ioYGo05AO0Ko8L7l6tl4xteD2qJdjZzjiRpp3
         f+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694724742; x=1695329542;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1bfYCZeoEdKY0xCX07ePzY5ryWaYVbqIYptARC7NJg=;
        b=SggYR6+AFmt5P3i/bEn31t4psBMS+KKqQZCTBUKJX5cUj/BhvAN3JVJhWGFM2hdFVm
         YS07c/yAegmhVJzcm6rdJWr3mpG75yzzmOC3YRBTo53/YTapYDtcR5gPdV0ewu39Zif+
         jdbOY/RUKD5sb/XRUSuzKfy8ycfk3UbmJy7snBk2gR7FDG6FAbc9InRbAgxqdBlzJcSJ
         doUaToc7GEoFocCgt7GMFj+eIqiFrbRBT8VTkMwiT1urGCqYdadOjDuE0OekrNzKl3us
         fPUt9HF7/NLI06hegqSdp6M1AVF1QfHhkcVVFjWKGsDPn5njEVEKVuUz2378xGDevxzF
         SJrQ==
X-Gm-Message-State: AOJu0YysJQkYrwZmECwu8UrCy+QwXzK3TS2pz+0wPZSY2Bz4Zw1uqo0r
        9jcP4HKR5kPLDSk+H+6y6csxSfhwQWnIv1L8wA==
X-Google-Smtp-Source: AGHT+IFttkDgh3STEULt9nazdb9L/1U62+xkGrM5KSilaIH+f9BeV8ytqjsC9zn8dQK4VotAls06A/tr0JmiYNXTAA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1816:b0:d0e:e780:81b3 with
 SMTP id cf22-20020a056902181600b00d0ee78081b3mr162906ybb.2.1694724742466;
 Thu, 14 Sep 2023 13:52:22 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:52:21 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIVyA2UC/x2NywrCMBAAf6Xs2YU0tUX9FSklZrdxsS92NQil/
 27wNnOZ2cFYhQ1u1Q7KWUzWpUh9qiA+w5IYhYqDd75x1/qMpJJZDdP2KTxjmkPrHK7h9dYg0zB lskF8xIihbWJHlwd1foQS3JRH+f5n9/44fp7rBQF8AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694724741; l=1689;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=ypZuHuWedw2GdaZjNukTcmFpVtl2zdn1sIH4RGMXcEM=; b=a3tnv1zYiSyHEe2n2OO9Vj2FcOGK7a0XpbAyi3Lxqx4nnbv89EszV7CesMgdUuN+kDtlRMpFC
 pVAkhV0uNoXDTUPACgysTkT/3J06KPMo1mFrHQQCpMGJzRWbEQYIu7h
X-Mailer: b4 0.12.3
Message-ID: <20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com>
Subject: [PATCH] drm/gma500: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

Since `chan->base.name` is expected to be NUL-terminated, a suitable
replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without also unnecessarily
NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---


drm/gma500: refactor deprecated strncpy
---
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
index 06b5b2d70d48..68458cbdd6d5 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
@@ -141,7 +141,7 @@ struct gma_i2c_chan *oaktrail_lvds_i2c_init(struct drm_device *dev)
 
 	chan->drm_dev = dev;
 	chan->reg = dev_priv->lpc_gpio_base;
-	strncpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
+	strscpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
 	chan->base.owner = THIS_MODULE;
 	chan->base.algo_data = &chan->algo;
 	chan->base.dev.parent = dev->dev;

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-a53c6d8bd62f

Best regards,
--
Justin Stitt <justinstitt@google.com>

