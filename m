Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620B777B7BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 13:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjHNLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjHNLmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 07:42:03 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73110C0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:41:59 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99357737980so562496666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692013318; x=1692618118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IhI41MstBcReN+KiXInXlGALbA3TY4zyWt7Hb7Xh6lE=;
        b=Lpb4nuLPT+nK3Cjb3I7qaZ++ML5Oev14P4kQJSedWS5cBuIkkmr9n9aNloPOa4i+j2
         UeqOeFZ7SCDT+TdY2J+EQ9QdhfmGUPf3rm3jIkmCwE+94J02sTZrhJuqXw3Wega+UdRu
         WUKuExc2VvtWAQeVmcUX9KfjwiMmK1Op943+Glqxgr8YQ7b+2lusBy2XYf3d/8YAUDXR
         +0nhT5C9HFNElWfeu+/YqwiHFiWiUXIUFrXPcZ5IKlPd4VG6SSEderykny1k5t0g7e+q
         yK/lcsunSQht5zHYniNTkMrH0JpO0umocmY6WAidBsu/qoHYCzyToAkUTuUm+VGDNBV1
         k+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692013318; x=1692618118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhI41MstBcReN+KiXInXlGALbA3TY4zyWt7Hb7Xh6lE=;
        b=U+xbGJvhChX3gGPoqPLKe9PuDU2zjeZqRNU86gCzzYpHI7xKmwRQaOtfcgCpbQKRVD
         GvyYs2x3oToXgzgu0EyJph3I3GtcCzUNZkEtBcZNmxJboafujD01KqdwN4VXJirxjHdB
         er3ESDDUa/rG2gkCu1mLtA3Ld0xFFSjjsLb0Fd6FT/EoKDR9kZ2Tyh1o8SF1NtbIYlY+
         Nm5ROroFbEdzCvaRKOW8TGHfd12OwXrNvsX3vbRsU2WYj1YLo2Bqd6DOUbxz+sH2Lb8Q
         cbV2FkkMjrdE12F3SI1zOcfFPffxqlWVpLCW+8299PxSnfxUbquLDuR/3tuz+fEL6Ry1
         T2Uw==
X-Gm-Message-State: AOJu0YxP0yVL4jXvSwnBtcYWJjTnh3LsOBAbUoKtfrkYTtfAM0B7qCvo
        EsEXr/9b/nbzmKxY27uGCPeOeQ==
X-Google-Smtp-Source: AGHT+IG/eVkW2LOammMu0dK30+SXAixKrT/nEbuJdbKpKu18kGx+4imaPC2iN1beqLcDP2tzU7DPNw==
X-Received: by 2002:a17:906:5190:b0:99b:40b5:1c3b with SMTP id y16-20020a170906519000b0099b40b51c3bmr8604771ejk.57.1692013317890;
        Mon, 14 Aug 2023 04:41:57 -0700 (PDT)
Received: from krzk-bin.. ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906490c00b0099d959f9536sm2695254ejq.12.2023.08.14.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 04:41:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: various cleanup for v6.6
Date:   Mon, 14 Aug 2023 13:41:54 +0200
Message-Id: <20230814114154.26017-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not much this time - I just two patches.

Best regards,
Krzysztof


The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt64-cleanup-6.6

for you to fetch changes up to 1193001081e98d13c786fe0cae407cb747104cdc:

  arm64: dts: lg: add missing cache properties (2023-07-13 08:44:15 +0200)

----------------------------------------------------------------
Minor improvements in ARM64 DTS for v6.6

Just two cleanups of missing cache properties for Nuvoton and LG.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      arm64: dts: nuvoton: add missing cache properties
      arm64: dts: lg: add missing cache properties

 arch/arm64/boot/dts/lg/lg1312.dtsi               | 2 ++
 arch/arm64/boot/dts/lg/lg1313.dtsi               | 2 ++
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi | 2 ++
 3 files changed, 6 insertions(+)
