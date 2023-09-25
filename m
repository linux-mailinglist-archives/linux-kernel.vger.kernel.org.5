Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2557AD387
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjIYIjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjIYIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:39:17 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D384FCE4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:39:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fa455cd94so3634020a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695631148; x=1696235948; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kt531lV/49PNzylTwWw5xyk5QvUpAoPyaIHXHiJOv2c=;
        b=yuUFGnr01i1fWzxBmGjLm7DnSnzIcwnMOpYclRR1nr2XP75CMWJRsdVvZGsENUBMph
         c6kExwKAYpCl3ND2Wlz+4vhY5mcxEgwA7egl6DT6vJkCrnnYVpEhDHoHjVFbES0Ot6X9
         QQfL8QOfzKguRnRMkVJsFe2L8WQwNyC7Y9NNSZpUDuALVZU1pcACM6IIx1E/6Ny8lI49
         6PuavQiEKHPKPf6+KKarUqkmntNdX3eZUinyRwBRNBtoCgg+DGlEner1z/FTC6AZKYTc
         /4pPNyoUn3WafzdXAsa0+SMX/UHLOnt6SpGPZeSHYMTvJpb/tFmUmD7KkEG5WO0rFKXP
         KGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631148; x=1696235948;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kt531lV/49PNzylTwWw5xyk5QvUpAoPyaIHXHiJOv2c=;
        b=jzPyLMlvhJCfvm5F4Zfi3MMUbpa47z3dDzilzS1/SxwjaoYxHTvg9WRkpiNJ3qjcRP
         toFLuKeplK5e7/G1GiHsUKq0+eQum/IpH2Ck85gfahb/zE+i6lIzAzYRdy+r5kzSXhUt
         3bKIJhKmPr7/suU7EcJsKxRkJ1ECH9P9DwOo9Aru6dqUshvjulhVFRhuKE25WTOfjiqg
         q8dzazpKYpMQrJy6ubd3IA/FYotslTPKcDxPewp1LcKHijfgYoDRLpvArhJQ1eDMnObZ
         vLeegZbPjzYcNPkM2HQzhcxqqdwP6vn1Q0E9jkzVFPsStp6NOI6A7Hih4uCBLri7/bPm
         J7/g==
X-Gm-Message-State: AOJu0YzD0JGyLEviUTPap5D9ljTx8KkJEriIsaGn5+GSPDB+lyFIVP5j
        1lA6+EypCyRYx7E7Fq+jRuN9wA==
X-Google-Smtp-Source: AGHT+IHx3J5ySfw9Wuxosg5Z6sG1PprCJbEmmIZOATHNOQ864gnhC7D7+VS5LClGiArL8V2tqHkKDQ==
X-Received: by 2002:a17:90a:e50c:b0:274:1bb1:415a with SMTP id t12-20020a17090ae50c00b002741bb1415amr3509215pjy.41.1695631147932;
        Mon, 25 Sep 2023 01:39:07 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a004e00b0025dc5749b4csm10141132pjb.21.2023.09.25.01.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:39:07 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     lgirdwood@gmail.com, perex@perex.cz, trevor.wu@mediatek.com,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v1 1/2] ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S support
Date:   Mon, 25 Sep 2023 16:38:46 +0800
Message-Id: <20230925083847.1496-2-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230925083847.1496-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20230925083847.1496-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string "mediatek,mt8188-rt5682" to support new board
with rt5682s codec.
---
 .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 43b3b67bdf3b..92da36137270 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - mediatek,mt8188-mt6359-evb
       - mediatek,mt8188-nau8825
+      - mediatek,mt8188-rt5682
 
   audio-routing:
     description:
-- 
2.17.1

