Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CABD7FAE35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjK0XK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjK0XKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:10:24 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C1B1AE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5079f6efd64so6525718e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701126626; x=1701731426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bFBvRvbyeQkmeHFtf4FwobIxdNGDTFW8Ona6LFco3UY=;
        b=nU5H/ph8MkQV9JN/z8U1h9yOSYA7SgXiTcX2mw1bGs4Pg61e2cRAztpjoh0jLNyfe4
         Z2InicKR/HYeZZni2J2M4k/7Qui7zbElke6g766JaI9nufYVj2Nh0AspFeBEDgbvn8AI
         lqPjq3aUdKiZKx+EwrGGoMXNZfWIDLicnrqS/8h058K9SfVjekvNZlX9Nrox8oueQK9Z
         4oKsYUc0Wle+eiAFIU0VBaAwVT4RofFc5N3fjM9RdVvNJ729J417h6o6NGQTYrJB5TED
         VhMvf6C+z6RX7ByKLhBoeZn9vAqmsMvOhHV2Cy3yGB4scUXmn2Bdq6l0RmH/yP2J9K8M
         SQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701126626; x=1701731426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFBvRvbyeQkmeHFtf4FwobIxdNGDTFW8Ona6LFco3UY=;
        b=raBPNcKNq4ssZorkqR2A1qI4n0HU9k9YIpjfWahs04xqkZpoCwNvPkIo1e9q/FDcn9
         w8YuvaCpWg9fE2uFFu7n9yRf/ugvXyHSA840jgYwGxlP41ZC3ihlokfwbwFqnGeV90BR
         o/CwvuQScepOwCQeUek4IuyNzgwYU/kM70VkKTarVTHBeuLYTmnTQCj4tSGmq5ST6S6E
         vJv/sF3ga30BOUytdsd7PCyimrlv4/Hj+ByPLL7reEfG1byfWS5klUULR5zEcCMnDNcL
         x4g78wDBQF5G/OjaXB/Q8CLNLPq0rqWbC/PRge5i+DLd4yvvlIT4dKmljzMfm0pjhSH4
         t/8w==
X-Gm-Message-State: AOJu0Yzb0JETBGdEeQXL2vTiaT4Pgg0Lphs81ZKP9HkxR+RA/4le0/f0
        6LR8T98gq6dt8OqGAq0VMayv6A==
X-Google-Smtp-Source: AGHT+IHDs7LKiVDhWcgD84ekXWzD2vRIoLMzcp8biogd3dgjxvKbFxjvr8a4CKDapNHrkGy1i8V05g==
X-Received: by 2002:ac2:4a6d:0:b0:50a:a9bf:a61e with SMTP id q13-20020ac24a6d000000b0050aa9bfa61emr8378429lfp.67.1701126625970;
        Mon, 27 Nov 2023 15:10:25 -0800 (PST)
Received: from [192.168.1.2] (c-21d3225c.014-348-6c756e10.bbcust.telenor.se. [92.34.211.33])
        by smtp.gmail.com with ESMTPSA id cf17-20020a056512281100b0050aa94e6d15sm1636877lfb.9.2023.11.27.15.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:10:25 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Nov 2023 00:10:19 +0100
Subject: [PATCH 1/3] Revert "driver core: Export device_is_dependent() to
 modules"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231128-revert-panel-fix-v1-1-69bb05048dae@linaro.org>
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
In-Reply-To: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
To:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1d5e8f4bf06da86b71cc9169110d1a0e1e7af337.

Greg says: "why exactly is this needed?  Nothing outside of
the driver core should be needing this function, it shouldn't
be public at all (I missed that before.)

So please, revert it for now, let's figure out why DRM thinks
this is needed for it's devices, and yet no other bus/subsystem
does."

Link: https://lore.kernel.org/dri-devel/2023112739-willing-sighing-6bdd@gregkh/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/base/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index bfd2bf0364b7..67ba592afc77 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -328,7 +328,6 @@ int device_is_dependent(struct device *dev, void *target)
 	}
 	return ret;
 }
-EXPORT_SYMBOL_GPL(device_is_dependent);
 
 static void device_link_init_status(struct device_link *link,
 				    struct device *consumer,

-- 
2.41.0

