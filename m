Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C1B77490C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235526AbjHHTrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235476AbjHHTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:47:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF9124FFB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:51:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99cdb0fd093so319576466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691513500; x=1692118300;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/kMxPLtuYtfsGSJG2tOdeZ1yEQcKsWU7BmPk/CzUa0=;
        b=scBHgpqk7EagVLbeen3bq3bqLMXS6JxWJ/8FVfrDEPJisTI6zpOLzm0XLC+fnma2RZ
         nw9pBeY+WE2BQvt3zlSmjS79S5FavQH1Dx16oMU7lpxImCJVmJzEZJrQPQyDnJN0VnqV
         4eYa3S76ilL9LBoJzvto1gjtARcRndwVI7RLIElQBIWJtBXGOy+vKl08S2rlbk3hxfj4
         UjGcjT91rlW6XFr/te7FZyYjzpR++vzdkJkQag2wYGflqN5TEAgptKu+dFR9uIdlFSko
         jNe7i6wMgTzMGH2vIMxp/YUFW9Lkcvtr21gHAxTrl8owyn8qN49qeRzua6DsjLZDw8XD
         Hbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513500; x=1692118300;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/kMxPLtuYtfsGSJG2tOdeZ1yEQcKsWU7BmPk/CzUa0=;
        b=au4Kl+XbsvX0zQfcbO/7nqt7BSYGnQpkLJX7MVXxmI4cXK60deWlXfgI465g4Kqb4o
         orKVIdLZH1wvAC9TQtbbZyWQB5TPnp1b653G/rg83IOjtIadlXWI4DvSQCxX2/MjwKvF
         Tztzg9383xCknFGrQ5sru9jSgK9L6O95IMRQbqt7ufEZhYjodtB86pmJ1CE2vPnxKrqq
         vSz9qxGMge7f0OwlK9ED89jqn0nn/MzhXa6SwPnxET7kKTO/7ayb19jFf6X3yuF+/lUn
         Gy/YschmgUCbUmWHlIArZb0iK3JB8aY7SD2hCyQeT8vDXvM2DUTQPHekuCXFrZrQwSlW
         xYQw==
X-Gm-Message-State: AOJu0YzRlw2AlYeQfbuhAHs4uk/aMyOXzzZQhH4z0KH0ALbhFraFyqXv
        KINL+8rE1sAGjVKlCM1AzhRgAIErvyigbHfS3I8=
X-Google-Smtp-Source: AGHT+IHWCMZNWUenzR2ow6DEw9qzbs1hN0zvPorE5eMO9zjCNiMy4ZjezjEMoOdrW0oJwauJJK4sjw==
X-Received: by 2002:a2e:9e0c:0:b0:2b9:a6a1:f12 with SMTP id e12-20020a2e9e0c000000b002b9a6a10f12mr8506359ljk.43.1691502397847;
        Tue, 08 Aug 2023 06:46:37 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e8557000000b002b93d66b82asm2284493ljj.112.2023.08.08.06.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 06:46:36 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/11] Regulator legacy GPIO header removal
Date:   Tue, 08 Aug 2023 15:46:27 +0200
Message-Id: <20230808-descriptors-regulator-v1-0-939b5e84dd18@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADNH0mQC/3WNQQqDMBBFryKzbkqMtUpX3qO4iGaiA2Jkpg0tk
 rs3Fbrsbt7n/zc7CDKhwK3YgTGSUFgzlKcCxtmuEypymcFoU+lWN8qhjEzbI7Aoxum52HyqCl1
 jL8Y73RjI243R0+vw3vvMM0muvY83sfymP2P7xxhLpZXxvq4GfbVDbbuFVsvhHHiCPqX0AYvhI
 ou7AAAA
To:     Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes some low hanging dangling <linux/gpio.h>
includes.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Linus Walleij (11):
      regulator: tps65910: Drop useless header
      regulator: s2mpa01: Drop useless header
      regulator: rpi-panel-attiny: Drop useless header
      regulator: rk808: Drop useless headers
      regulator: rc5t583: Drop useless header
      regulator: mt6311: Drop useless header
      regulator: mcp16502: Drop useless header
      regulator: max20086: Drop useless header
      regulator: lp8755: Drop useless header
      regulator: bd71828: Drop useless header
      regulator: bd71815: Drop useless header

 drivers/regulator/bd71815-regulator.c          | 1 -
 drivers/regulator/bd71828-regulator.c          | 1 -
 drivers/regulator/lp8755.c                     | 1 -
 drivers/regulator/max20086-regulator.c         | 1 -
 drivers/regulator/mcp16502.c                   | 1 -
 drivers/regulator/mt6311-regulator.c           | 1 -
 drivers/regulator/rc5t583-regulator.c          | 1 -
 drivers/regulator/rk808-regulator.c            | 2 --
 drivers/regulator/rpi-panel-attiny-regulator.c | 1 -
 drivers/regulator/s2mpa01.c                    | 1 -
 drivers/regulator/tps65910-regulator.c         | 1 -
 11 files changed, 12 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230807-descriptors-regulator-3ed7a42fd072

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

