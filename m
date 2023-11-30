Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D9F7FE9DA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344767AbjK3Hkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344694AbjK3Hkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:40:37 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CC9D66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:43 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cdd9c53270so565607b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 23:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701330043; x=1701934843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzMcm/4giFrxMClkYwrYltTytmsL0thmxiAZbeFwHOg=;
        b=fZ9efIe7fP13ZrygS8ejUl+76g6aLDUIABVn9B1Xp1VQE2NQAXVdAxZcw82RbHKvBY
         b3SiWqUlCofl89yB6puRuvsTwCOOtbKaQzIppKGakD9SDLR+Kg50hc7mzkCkWXnqdWxi
         3eeHjPG7jHbmvZJPk1/7ZpLpcnfMFm1Lrqn2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701330043; x=1701934843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzMcm/4giFrxMClkYwrYltTytmsL0thmxiAZbeFwHOg=;
        b=aL2KZrxQ6qRgNA0tNnX4C1pAMVKIHjrYbq6MJpqwOAnC/DdgBhSGnUuJ6JIGX4T/I6
         kXcRki7vyyFX5BRdH8Ktd3KyuvEm75Xz+4ZkWPRzVHsjw7pgeVZzcbVvRzjoTYDomOeq
         0qj55cp5Wj82aCRFVWsxvd8bsvMEgkacIz1dB6NDjFQHGOf3TeSCooGDIz+Er2D8QUL7
         Jq9KQGZnR49oLBMHYNqBVgjLyARPHzT8AhR/o0NfauvGwoEJGZC/VAFqJJaslOdA41EG
         AUdv09ToMSVvt2r0i0v96IzlCuaBlSqLTjqX7gCiEfZ3mCKyRSXrJzeqPtXQur7cWrKd
         5mJg==
X-Gm-Message-State: AOJu0Yz/l8WeOF0q863FmFJNCsS8RnvedGyoVlq8SzC76pn1n9Z0pKLG
        j8MPitQxdWP8ZkqVryYddt5ykw==
X-Google-Smtp-Source: AGHT+IH4Vyiy69Wx5dpcW6tYy2rej0U+Buxiro8U+QktBGOAg6tGBdr4/KhwXWHc9RHdnAT00fhu9A==
X-Received: by 2002:a05:6a00:3a09:b0:6be:acc:8973 with SMTP id fj9-20020a056a003a0900b006be0acc8973mr20577904pfb.20.1701330043351;
        Wed, 29 Nov 2023 23:40:43 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:7c8f:dafd:65c3:2bcf])
        by smtp.gmail.com with ESMTPSA id p35-20020a634f63000000b005bd3f34b10dsm612870pgl.24.2023.11.29.23.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 23:40:42 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/3] arm64: dts: mediatek: Random DT cleanups
Date:   Thu, 30 Nov 2023 15:40:28 +0800
Message-ID: <20231130074032.913511-1-wenst@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some random DT cleanups that I've accumulated. This should get
rid of some warnings.

Please have a look.


ChenYu

Chen-Yu Tsai (3):
  arm64: dts: mt8183: kukui-jacuzzi: Drop bogus anx7625 panel_flag
    property
  arm64: dts: mt6358: Drop bogus "regulator-fixed" compatible properties
  arm64: dts: mediatek: mt8186: Fix alias prefix for ovl_2l0

 arch/arm64/boot/dts/mediatek/mt6358.dtsi            | 13 -------------
 .../boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi     |  1 -
 arch/arm64/boot/dts/mediatek/mt8186.dtsi            |  2 +-
 3 files changed, 1 insertion(+), 15 deletions(-)

-- 
2.43.0.rc2.451.g8631bc7472-goog

