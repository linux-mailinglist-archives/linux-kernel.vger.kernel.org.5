Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E57AF8FF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjI0EEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjI0ECz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:02:55 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1644492
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:36:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-69101022969so9126786b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1695785774; x=1696390574; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8iHvx1dsePHhcovY1cm1S5dLZsg/5oNsoEJEmRXpTU=;
        b=wxenVGeZB84E/L///SK9MvPtFhps5wQIQz2H6VUrXK48OY+jtiAhcuvjKtAo1AP0X+
         t8xBlgRxSApmn9aV7eHzDC0kQ7pjebljZ0Tixim91jpBaQ48hyjJ3MvIQ5KBRFrQt04y
         +Ky09zmRGG2V4TBAw8cXeLQXbwX969eoEESNFrTWisNcXFVVDKoPDxXzjHFS8ujrZEgL
         N8NyHD/q9mHv9J7STuulP2DRCkQ3Xxb0JKlZ2SxQJxN+Rm4EN67O2AkxywhzVBDA86E6
         cMvh3kYU88hKhRkgsnS0R6qO7EsBYNWis47WUU7U3cKPe4Ryza5ZcRd2rhqArBbadEFC
         qrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695785774; x=1696390574;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8iHvx1dsePHhcovY1cm1S5dLZsg/5oNsoEJEmRXpTU=;
        b=udphq/NqOjLhMlSQ1zkIF2rS5Lbjus71HGw0MO1tVUpCgEP10tq++zU8XOot9skLkh
         9xVtBVPIlGgU+weKKkBunh7BsRDl8fGJtFyxiwNyJKcAfYYLp8vYQmlUQkmZqOsOM7DP
         JfjQjeYY3yLn7ggQW1JcJpD+knYInPnzZwr0tPMAf0up8KJFHLxkTo5z5yeSrAqXH8kt
         3SJ8uNkiI2vbez0eKTsLxMlRFtNO6YO0rG+VbNXsAxdytaHO34V2neuFXye95tDNlX3j
         wNEqMjMSZ888ctjhYwVzUp3UPRtFFvV9VS1iprJvUwXlMURZgqKjeJ+ifZ7MpDG941g/
         qhUg==
X-Gm-Message-State: AOJu0Yw2NrDEBnCBON9wceT6L+M1fLLh+1pAyzQuvBTj3OR1c2NR1G95
        aT4KR2fr6UpCSPEoef6zVANM8vKmI7yIhg7neqA=
X-Google-Smtp-Source: AGHT+IFg9MWz/BGS1JWCEp53YleO3c0zitqJhgHShflpegjZA+hBbgouhBmH37EO3HQwfo42LiHEhA==
X-Received: by 2002:a05:6a00:2493:b0:690:1857:3349 with SMTP id c19-20020a056a00249300b0069018573349mr1043900pfv.25.1695785774386;
        Tue, 26 Sep 2023 20:36:14 -0700 (PDT)
Received: from ubuntu.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id i14-20020aa787ce000000b006870ed427b2sm11067570pfo.94.2023.09.26.20.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 20:36:14 -0700 (PDT)
From:   xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
To:     broonie@kernel.org, robh+dt@kernel.org, tiwai@suse.com,
        trevor.wu@mediatek.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        patchwork-bot@kernel.org
Cc:     xiazhengqiao <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [v3 0/2] ASoC: mediatek: mt8188-mt6359: add rt5682s support
Date:   Wed, 27 Sep 2023 11:36:06 +0800
Message-Id: <20230927033608.16920-1-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use RT5682S as the codec and MAX98390 as the amp, add a new
sound card named mt8188_rt5682s.

Changes in v3:
- PATCH 2/2: modify mt8186_rt5682s_i2s_hw_params to mt8188_rt5682s_i2s_hw_params
- Link to v2: https://lore.kernel.org/all/20230926040901.20338-3-xiazhengqiao@huaqin.corp-partner.google.com/ 
              https://lore.kernel.org/all/20230926040901.20338-2-xiazhengqiao@huaqin.corp-partner.google.com/
   
Changes in v2:
- PATCH 1/2: Modify mt8188_rt5682 to mt8188_rt5682s
- PATCH 2/2: Modify all string "rt5682" to "rt5682s" and merge code 
             in mt8188_fixup_controls
- Link to v1: https://lore.kernel.org/all/20230925083847.1496-3-xiazhengqiao@huaqin.corp-partner.google.com/
              https://lore.kernel.org/all/20230925083847.1496-2-xiazhengqiao@huaqin.corp-partner.google.com/

xiazhengqiao (2):
  ASoC: dt-bindings: mediatek,mt8188-mt6359: add RT5682S support
  ASoC: mediatek: mt8188-mt6359: add rt5682s support

 .../sound/mediatek,mt8188-mt6359.yaml         |   1 +
 sound/soc/mediatek/Kconfig                    |   1 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c     | 141 +++++++++++++++++-
 3 files changed, 141 insertions(+), 2 deletions(-)

-- 
2.17.1

