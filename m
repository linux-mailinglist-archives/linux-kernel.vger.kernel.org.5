Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D0771143
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjHESFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjHESFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:05:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01588187;
        Sat,  5 Aug 2023 11:05:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-317798b359aso2530602f8f.1;
        Sat, 05 Aug 2023 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691258738; x=1691863538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sdRAieAfV+HXU2d8HHj56ySjii4cMQwtBoYAE7N8g5s=;
        b=n0fK/y30pRu67o6OdFtdPg9SBOZqPhrCfGUIUocdWZjGdUAnThcdzYcbzdDR5Cy7ZF
         Tb4BjhaShFAziu49DZm5WGefcbR8geefa8kJjdc8BO6EgWlYcMlFibBJiaEvgj9WlP6v
         qSkkm02uz2+hqpZi66JrB69ZA+yjSKuauQ3jGgYf1Nxlp2aFzSycIoAcf4bklWfTILZA
         v/fVLZmzWwh6YwsMLwsmDw2UMQXXP0k0iol0blojjuQXXalegi1jH91cCOwFeLvT8J2i
         qlEXnndY6XpbggsMj9nzzDdKUDtQpzljDFtYbAqLz+ivTVk0PtRzBfmWnCXbzLTpMeWY
         5N7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691258738; x=1691863538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sdRAieAfV+HXU2d8HHj56ySjii4cMQwtBoYAE7N8g5s=;
        b=RaPD9QltI2WRmAMmIJUmShQT6TkqwlKu4XFc4mt2Vp77o+LkXWLiElyCUVQ+pTXgMK
         MZDr5iThl9I80uaNVWf8fA23w/8OPngKjneaDdwk7J4QWWpMD1/4pg+X3wQ8/ZieBrY1
         ybE+JIVspY2LYffGNLxO54ClWs8eQScyhxtDQEynp/hMxnf2COzdKOpj86GVqUoE0FQC
         Sk51q3d1vqjWzN8MgS/h7MWMZM1+dEhhfM6tuCO7JecbPvu7y218Q8diQTOXX2tLWP83
         DOAUkDifjycSI+qNn0JCgvwIjzTd1DsZWhIxxIlxNEnIh26qU3u22h4YWmj/rmCzWb//
         UjvA==
X-Gm-Message-State: AOJu0YxiNRR99mZWI6jvSg/7OrFY9w4zGCzyYtEBC6Xa7zUegLtKDwLf
        aKebeZiR/V8J0VWF2OgAN2WUvSQxuQn0Cw==
X-Google-Smtp-Source: AGHT+IE+5m/SQ3eshBedJihbRDlO9MZ+wChC74UcCgeJKgphC3WBm37dlSMr1RZdbjAWZFPdnVj2lA==
X-Received: by 2002:a05:6000:10c6:b0:317:6fff:c32b with SMTP id b6-20020a05600010c600b003176fffc32bmr2915238wrx.53.1691258737930;
        Sat, 05 Aug 2023 11:05:37 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6104000000b003176aa612b1sm5710402wrt.38.2023.08.05.11.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 11:05:37 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 0/5] ASoC: sunxi: Add support for D1/T113s internal audio codec
Date:   Sat,  5 Aug 2023 21:05:00 +0300
Message-Id: <20230805180506.718364-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Hi,

This is the series adding support for internal audio codec on
Allwinner D1/T113s SoCs family.

My work based on Icenowy Zheng's patches from sipeed repo that adds
support for the R329 audio codec. But, unfortunately, these patches
were not sent to upstream. So, I adapted them to fit the T113s.
In the future, support for R329 could easily be added on top of
this series. Because D1/T113s and R329 SoCs have almost the same audio
codec IP, with slight differences in the analog part, plus the R329
has two additional ADCs.

The series includes modifications for the existing sun4i-codec driver
that brings support for the digital part of the D1 codec. And adds the
new sun20i-d1-codec-analog driver for the analog part.

I would be glad if someone have a look :)

Cheers,
Maksim

Maksim Kiselev (5):
  ASoC: dt-bindings: sun4i-a10-codec: Add binding for Allwinner D1 SoC
  ASoC: dt-bindings: Add schema for "allwinner,sun20i-d1-codec-analog"
  ASoC: sunxi: sun4i-codec: add basic support for D1 audio codec
  ASoC: sunxi: Add new driver for Allwinner D1/T113s codec's analog path
    controls
  riscv: dts: allwinner: d1: Add device nodes for internal audio codec

 .../allwinner,sun20i-d1-codec-analog.yaml     |  33 ++
 .../sound/allwinner,sun4i-a10-codec.yaml      |  64 ++-
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  22 ++
 sound/soc/sunxi/Kconfig                       |  11 +
 sound/soc/sunxi/Makefile                      |   1 +
 sound/soc/sunxi/sun20i-d1-codec-analog.c      | 220 +++++++++++
 sound/soc/sunxi/sun4i-codec.c                 | 364 +++++++++++++++---
 7 files changed, 643 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun20i-d1-codec-analog.yaml
 create mode 100644 sound/soc/sunxi/sun20i-d1-codec-analog.c

-- 
2.39.2

