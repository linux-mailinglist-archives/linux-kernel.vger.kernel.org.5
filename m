Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44567727DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjHGOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjHGOfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:35:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023EC10DD;
        Mon,  7 Aug 2023 07:35:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so628613566b.0;
        Mon, 07 Aug 2023 07:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691418931; x=1692023731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGYSWbN7PMS0f5vrz8dhv/rjh9hiks1eC9dOt9xyQUM=;
        b=bp1TLXRvHNSid4EjH1/QveY/HipnZUWNjWTL5jsgeD/1GT95iQ1tNH9UoS77Cgxxwf
         PA09gwHTQ9j0TUlMLBvpWzgAWeabnUjzi2fXJknfKo7Zt4/TtOoYVniwGpAvlDreHeOF
         YmwYf8QKyb1Y743cM1NE40xIouKeM5kzNTi6+H6yKeqEcrB7LMsSKTB4TrYqKWBgtnE5
         9n8w+b8eE3ibBIGzon+rySTEDJWOeWPtzmsWG1PtRInWngIrQYv2rWq/rrPF4qHPEuM3
         biiRq5gWk8fbaOWN+6lUFmcXZMQmdXEIsTtPyhLUoMcxBN9uYSCb30bFP5BFNAsxNhOl
         ZSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691418931; x=1692023731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGYSWbN7PMS0f5vrz8dhv/rjh9hiks1eC9dOt9xyQUM=;
        b=AWvxnu/YsA+LIEI3LcL2L9VFSCczyJVBR7+fLTEeI1+CYazrebjXnUACnARUzzlQiS
         3gqsT5hHo92xxdzy7NZYvwgCdrDy75KGOxLAaOV6xcTVNEHkxqeGO/mX5BQROB8I/45J
         svWirIXmRxp2g2xU8xBXnXFF3pITp5UOnV8J/SNc+y1kXSjKGq3fLVuC71WhfINunSzr
         Gzu3mSVcUORbXqHSuCA5Ni7P4BqXsaV9JF+xrlkWhA9BDyT0SG1/3+Elzf/p3YVBe87Z
         gh8y/xS8vvYd32cVYW6sfit87zE2B1eyOw3/eVWAxgyM8QmwIzAdCNR0nvk4Ywv5juko
         LH3g==
X-Gm-Message-State: AOJu0YyM6HPNZ3Ea6KtsGlCwy2Urn5Cer1hylMmz8YOEOajp9IwVaIbF
        bv6Tf+V9rg2Lt+ASF+S2j/U=
X-Google-Smtp-Source: AGHT+IFjTFWA/gj0Ka2hniiSJFmIIgLMsQotBuRcjNn9ShgdWt8Pp/COmTMd1mmaUYbit0xS6Zorjw==
X-Received: by 2002:a17:907:a068:b0:99c:20f0:dec0 with SMTP id ia8-20020a170907a06800b0099c20f0dec0mr7106521ejc.43.1691418931285;
        Mon, 07 Aug 2023 07:35:31 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099329b3ab67sm5323292ejk.71.2023.08.07.07.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:35:31 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Support bridge/connector by Tegra HDMI
Date:   Mon,  7 Aug 2023 17:35:10 +0300
Message-Id: <20230807143515.7882-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the bridge/connector attached to the
HDMI output, allowing to model the hardware properly. It keeps
backwards compatibility with existing bindings and is required
by devices which have a simple or MHL bridge connected to HDMI
output like ASUS P1801-T or LG P880/P895 or HTC One X.

Tested on ASUS Transformers which have no dedicated bridge but
have type d HDMI connector directly available. Tests went smoothly.

---
Changes from v2:
- added missing descriptions to tegra dc and hdmi yamls
- fixed "Warning (unit_address_vs_reg): /host1x@50000000/
  dc@54200000/rgb/port@0: node has a unit name, but no reg or
  ranges property"
- dropped reg from port to avoid same warning with hdmi ports

Changes from v1:
- no changes, re-sending
---

Maxim Schwalm (4):
  ARM: dts: tegra: Drop unit-address from parallel RGB output port
  dt-bindings: display: tegra: nvidia,tegra20-dc: Add parallel RGB
    output port node
  dt-bindings: display: tegra: nvidia,tegra20-hdmi: Add HDMI output port
    node
  drm/tegra: output: hdmi: Support bridge/connector

Svyatoslav Ryhel (1):
  ARM: tegra: transformers: add connector node

 .../display/tegra/nvidia,tegra20-dc.yaml      | 31 +++++++++++++
 .../display/tegra/nvidia,tegra20-hdmi.yaml    | 32 +++++++++++++-
 .../dts/nvidia/tegra20-acer-a500-picasso.dts  |  2 +-
 .../boot/dts/nvidia/tegra20-asus-tf101.dts    | 24 ++++++++--
 .../dts/nvidia/tegra30-asus-lvds-display.dtsi |  2 +-
 .../boot/dts/nvidia/tegra30-asus-tf700t.dts   |  2 +-
 .../tegra30-asus-transformer-common.dtsi      | 21 ++++++++-
 drivers/gpu/drm/tegra/hdmi.c                  | 44 ++++++++++++++-----
 8 files changed, 136 insertions(+), 22 deletions(-)

-- 
2.39.2

