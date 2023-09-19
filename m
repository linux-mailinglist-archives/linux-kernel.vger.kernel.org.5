Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591387A5873
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 06:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjISEl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 00:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISElZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:41:25 -0400
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D3310E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 21:41:18 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-3aa1396ffa6so6725416b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 21:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695098478; x=1695703278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=of1G2AjFUxK4T2lKuwOZsNYvvlYd/OC9AdRH6bOHIA4=;
        b=kcJjzbMCd39hA1de/mqscnEh3qvoZLW10D59Wm12N9CbtY002l6eXtp6T+yGXEcmZB
         1njIp3cQpvk+Wsvenx99PbG1nIU0iaqh9ACYrh2bTINF8yahpQZ9XNsprvJ8h26Vj4O4
         1TFG6qhtYBYQ6mGaqECaJVP+BrHKqUSwqbeXtToHmsxYxPzqFeRrxtYHcBpaWwFHQ7Wy
         SeZIbQxl6Kagv79bTw1wLzpZ0iKlL9o+6JRa2L0QnTFmOcngvuubz0GOqhvs+saCZfIF
         H5PQoM+USm2z7F4Xkz5wczpggTALGrs7XIZg277KgFXELUH5s5waUund3H9HqTkZHbE/
         prZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695098478; x=1695703278;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=of1G2AjFUxK4T2lKuwOZsNYvvlYd/OC9AdRH6bOHIA4=;
        b=dgs0iX9Na6t4+Y7X53JykBHx/0M8ZSt/IEq+bEerS/H1bokTznLi/lV48wkIrw/GN5
         FZFgHNnIuBtjuSiu/B1d/yv29AZrwBGdb1yMA1gWT/8RDHs6boFqI3KxX43hRWSNbpd2
         BN1PoOV7L3xbAeUabk7lFKxo4sSzyvui95jqa5DBnJwEVy+81Hj0Ig1ufnmeA4yygZ1X
         LTz3SO3IGI7zK/QFZHpowDPtXvpjC8YhhoLPN9Bf90vm1W8F79COhtY/8sOXXDOA9+tn
         XGCVTHKRooluCcx3WI3ay55wQM86I9XF8Mo35Sc8JNVHX9WYduXzdHh8rXwH6R7H+a+H
         6taw==
X-Gm-Message-State: AOJu0YygWHHHJsRgrjyWS36cekeGRvyKrrj8IPj2u5+zPed4EXkHZNjl
        jnHCaHpRJCIRGy344cxxjtQlWu4YOaEFhgfmJg==
X-Google-Smtp-Source: AGHT+IGnU5s6OIGSn5cC7NWVIFxeeVBC5IQr4RpFLYJ+aIpO5DZ6NNzapgJD0y8MYnNPStPJqYpbkxJOERDAES36Jw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6808:199a:b0:3ad:29a4:f542 with
 SMTP id bj26-20020a056808199a00b003ad29a4f542mr756370oib.5.1695098478040;
 Mon, 18 Sep 2023 21:41:18 -0700 (PDT)
Date:   Tue, 19 Sep 2023 04:41:16 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAGsmCWUC/53NTQ6CMBCG4auYrh3TFsGflfcwhNR2KBOBkik2G
 sLdrRzB3byz+J5FRGTCKK67RTAmihTGHHq/E7Yzo0cgl1toqQt5UUdwTAk5gp9e+R7AD6aUEoJ
 5zmyob/rkYkPaggVTFrZy54erdCvy4MTY0nvD7nXujuIc+LPZSf2+fzFJgQKZMSNPlUUtbz4E3 +PBhkHU67p+AdX0M2DlAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695098477; l=1887;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=mJhdmvY4dhQaVYSKiTNMqir+icefxTZRFVt1lST3CX4=; b=tMzBU+KLFc2Eppj6xXIygZ2Dq/nC2zJMApa9X+WMt7T4LpaJjlfb6RpBbKzgk5C4yKzfWUYPB
 NhfiYY2Kel9D80fFCLgHDN2zBJ88PddQysZHhrrgQAoCI2mJ91yQ9I6
X-Mailer: b4 0.12.3
Message-ID: <20230919-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v2-1-9ebe6983b4cb@google.com>
Subject: [PATCH v2] drm/gma500: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

Since `chan->base.name` is expected to be NUL-terminated, a suitable
replacement is `strscpy` [2] due to the fact that it guarantees
NUL-termination on the destination buffer without also unnecessarily
NUL-padding (since `chan` is kzalloc'd already).

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- use sizeof() instead of I2C_NAME_SIZE (thanks Kees, Patrik)
- Link to v1: https://lore.kernel.org/r/20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-v1-1-0a53a076ce20@google.com
---
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
index 06b5b2d70d48..939c53fd09e8 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
@@ -141,7 +141,7 @@ struct gma_i2c_chan *oaktrail_lvds_i2c_init(struct drm_device *dev)
 
 	chan->drm_dev = dev;
 	chan->reg = dev_priv->lpc_gpio_base;
-	strncpy(chan->base.name, "gma500 LPC",  I2C_NAME_SIZE - 1);
+	strscpy(chan->base.name, "gma500 LPC",  sizeof(chan->base.name));
 	chan->base.owner = THIS_MODULE;
 	chan->base.algo_data = &chan->algo;
 	chan->base.dev.parent = dev->dev;

---
base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
change-id: 20230914-drivers-gpu-drm-gma500-oaktrail_lvds_i2c-c-a53c6d8bd62f

Best regards,
--
Justin Stitt <justinstitt@google.com>

