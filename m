Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97E803355
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343925AbjLDMri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjLDMrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:47:37 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AA7A9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:47:43 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54ca43031d1so1245447a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694062; x=1702298862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ziVbN5ZTP69p6FxRTQ/DrNWjlcr9menHHHhzgnVhU0=;
        b=oaxeCEdai59i2UFpX60wj06AWKEDDInfc+sS6P/buF+nKMxpHtCcGsOvMzr3t1DVUi
         mx/PEgtgzSoMLJ+jeVRDBWCtDE9+tDmstiWpi2EfTb9j4miy5OSmpBx6X2AWbjKqNpWG
         ZbM8OODMkuvE5yNutRRs9NvBm8q9OKyrcVDVDeOGYfxyT5y1UIjFPz4ZNackzTc7qXW8
         adS4yOJMxN8BcmpoaPlrdEDnMWN+aVy2QZdTDccTFWI+PSGXm5mehX3NqXrNLn/QJxZ2
         lwUsAZcuZ7W4YjdVuIkaA7/BtDoO6sOFa0VrjKuDZRauepryWj86Hqn/BailDq+8A154
         0Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694062; x=1702298862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ziVbN5ZTP69p6FxRTQ/DrNWjlcr9menHHHhzgnVhU0=;
        b=hPuDDLRpn4hsvQu4EsKLidgOXo+qIR01m4BGA/jWvBIrJqvnpWFJ4uNCmbjbvUPRy+
         rh+ZhbYn81GevZtQkk9A8S1Oc7nfJJf4kfMTVNgfL0CYGvN4r1HFX+/Uj3unvbN5Hl/t
         OUdZ5Uu9/wAAKkyQnXh8FwCD3CG2uoJnf4mbyz4Wd1CP8vMdeWDeYLJNa4/EHFyFXv6V
         CrWaxvknNpAyTGLNKuBerb/BaGyZ8zacIpm3Tvg7KtBlVKAuwVzDjoO6/as0sH7Gj5tR
         q9Hqc42aucO78wo9NN3swteSuGW34YHBZrft3IaMabo22CC7HfwkYpUpI8hTFc/X4ooU
         3xJg==
X-Gm-Message-State: AOJu0Yy0lRbzbS8iWC1KGMX6JtRCGghICeRHdxnDWSEDvf38VH4SZt+Z
        4VDhxJoNubBHKNvJ/u1MoTCOkw==
X-Google-Smtp-Source: AGHT+IHApXDdpr226FRyb9j61M1tzyPuEc1Ds/nq5f9VgF00NIL9sLCBQAy4dDG6sIZWA3NbhrjkNA==
X-Received: by 2002:a50:d59a:0:b0:54c:4837:903c with SMTP id v26-20020a50d59a000000b0054c4837903cmr3836618edi.52.1701694062023;
        Mon, 04 Dec 2023 04:47:42 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id dc15-20020a056402310f00b0054ced65bd26sm457017edb.41.2023.12.04.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:47:41 -0800 (PST)
From:   srinivas.kandagatla@linaro.org
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: ops: add correct range check for limiting volume
Date:   Mon,  4 Dec 2023 12:47:35 +0000
Message-Id: <20231204124736.132185-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Volume can have ranges that start with negative values, ex: -84dB to
+40dB. Apply correct range check in snd_soc_limit_volume before setting
the platform_max. Without this patch, for example setting a 0dB limit on
a volume range of -84dB to +40dB would fail.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 55b009d3c681..2d25748ca706 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -661,7 +661,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 	kctl = snd_soc_card_get_kcontrol(card, name);
 	if (kctl) {
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
-		if (max <= mc->max) {
+		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
 			ret = 0;
 		}
-- 
2.25.1

