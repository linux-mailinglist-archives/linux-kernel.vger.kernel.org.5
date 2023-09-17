Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF847A3E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbjIQWk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjIQWki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2166912B;
        Sun, 17 Sep 2023 15:40:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40479f8325fso29972355e9.1;
        Sun, 17 Sep 2023 15:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990431; x=1695595231; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pu55F0bb4aC5tU7CS7Hj+QvENmRKx9xwc5E2LcNAfp4=;
        b=FYMljGgmPGRvBwI4FGBxfrlNEQBof+nqWESW5HoBjEwD59CKYxYqxRD50ZNE0P+eV+
         kVtOncNplDTuDiQwwzJKYEz7R/XnmBbvyl8DMr87pTlNIGVDyIQKdHcr4Osb1gS+NDSV
         Qbrv3BZhgzhoxJOMxIRAx6l4IkRF6Vi1CKPWOvqQoxPgvc7ooBf9K8smwTJ1VQhu00Tu
         vu4BwcsFv5EdPPrIHObSdrHhHxmjuz7tgx4gG3Q8cbNxY6BsE8X2cfS5Q69Dub4hGzI/
         v1murZQvLJd0JiRu6Tl5WN4SRMxzvLrOum0iROUyRHQjYXpaXEZJ9WIkQnRnvZDjmaJM
         TizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990431; x=1695595231;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pu55F0bb4aC5tU7CS7Hj+QvENmRKx9xwc5E2LcNAfp4=;
        b=gKJiOlvTQX3FqTxezz+7yfgASTKxs4grY7IMoMFh58+LUm4lve6FZ0wbvbzjULfH51
         pnC5clfb61x8BW0BNW/l3E4dQx1+fB0A1U7J6efF8FedZJ+XOP1rAt62CnikKMv0RTwS
         pBPQSniHrr8UJJ08dp0McYoXA6LRNq/6IxNBXLgATNoPy/TSNEeVwK4Bzh9tOtcxuz5W
         X9dlIMNOaS7SpGi2dN44ItE0TLPpxRpzhxxd19+B3/74y2dQLqBUlC9oQLTyt93Mzb6i
         OG9ca/+cucbdoKF8s16BHkUybIN0lC81OeL+apXfgKJ6aBaRPhIKRdpF4jjgP9NntKkq
         Y+/Q==
X-Gm-Message-State: AOJu0Yz11jF/vzJH3T2JoXqlbuQOamAsZ9By9fn8jcjnD0h2amIQUuh5
        8dqyRR/BWEy9+cdCs14L85Q=
X-Google-Smtp-Source: AGHT+IG1VR6cDCdZ46S19smX52QInRtz+mz6NvGtQgk0lwi5BOk5UmykR5KiLbJFQ+OC5vUw/6UaRw==
X-Received: by 2002:a05:600c:28f:b0:402:e68f:888c with SMTP id 15-20020a05600c028f00b00402e68f888cmr6072309wmk.7.1694990430795;
        Sun, 17 Sep 2023 15:40:30 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:30 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH 00/13] imx8mp: first clock propagation attempt (for LVDS)
Date:   Mon, 18 Sep 2023 00:39:56 +0200
Message-Id: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADyAB2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDS0Nj3czcCovcAt2UkuJMXfNks1QjU0sD81SDVCWgjoKi1LTMCrBp0bG
 1tQCBWXH5XQAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Target of this series is to dynamically set the rate of video_pll1 to
the required LVDS clock rate(s), which are configured by the panel, and
the lvds-bridge respectively.

Some background:
The LVDS panel requires two clocks: the crtc clock and the lvds clock.
The lvds rate is always 7x the crtc rate. On the imx8mp, these are
assigned to media_disp2_pix and media_ldb, which are both
clk-composite-8m. The rates are set by drm_client_modeset_commit() (and
later by fsl_ldb_atomic_enable()), and the fsl-ldb driver, first crtc,
then lvds. The parent is typically assigned to video_pll1, which is a
clk-pll14xx (pll1443x).

The main problem:
As the clk-composite-8m currently doesn't support CLK_SET_RATE_PARENT,
the crtc rate is not propagated to video_pll1, and therefore must be
assigned in the device-tree manually.

The idea:
Enable CLK_SET_RATE_PARENT, at least for media_disp2_pix and media_ldb.
When this is done, ensure that the pll1443x can be re-configured,
meaning it ensures that an already configured rate (crtc rate) is still
supported when a second child requires a different rate (lvds rate). As
the children have divider, the current approach is straight forward by
calculating the LCM of the required rates. During the rate change of the
PLL, it must ensure that all children still have the configured rate at
the end (and maybe also bypass the clock while doing so?). This is done
by implementing a notifier function for the clk-composite-8m. The tricky
part is now to find out if the rate change was intentional or not. This
is done by adding the "change trigger" to the notify data. In our case,
we now can infer if we aren't the change trigger, we need to keep the
existing rate after the PLL's rate change. We keep the existing rate by
modifying the new_rate of the clock's core, as we are quite late in an
already ongoing clock change process.

Future work:
The re-configuration of the PLL can definitely be improved for other use
cases where the children have more fancy inter-dependencies. That's one
of the main reasons I currently only touched the mentioned clocks.
Additionally, it might make sense to automatically re-parent if a
different possible parent suits better.
For the core part, I thought about extending my "unintentional change
check" so that the core ensures that the children keep the configured
rate, which might not be easy as the parent could be allowed to "round",
but it's not clear (at least to me yet) how much rounding is allowed. I
found a similar discussion posted here[1], therefore added Frank and
Maxime.

Thanks & regards,
Benjamin

[1] https://lore.kernel.org/lkml/20230825-pll-mipi_keep_rate-v1-0-35bc43570730@oltmanns.dev/

---
Benjamin Bara (13):
      arm64: dts: imx8mp: lvds_bridge: use root instead of composite
      arm64: dts: imx8mp: re-parent IMX8MP_CLK_MEDIA_MIPI_PHY1_REF
      clk: implement clk_hw_set_rate()
      clk: print debug message if parent change is ignored
      clk: keep track of the trigger of an ongoing clk_set_rate
      clk: keep track if a clock is explicitly configured
      clk: detect unintended rate changes
      clk: divider: stop early if an optimal divider is found
      clk: imx: pll14xx: consider active rate for re-config
      clk: imx: composite-8m: convert compute_dividers to void
      clk: imx: composite-8m: implement CLK_SET_RATE_PARENT
      clk: imx: imx8mp: allow LVDS clocks to set parent rate
      arm64: dts: imx8mp: remove assigned-clock-rate of IMX8MP_VIDEO_PLL1

 arch/arm64/boot/dts/freescale/imx8mp.dtsi |  14 +--
 drivers/clk/clk-divider.c                 |   9 ++
 drivers/clk/clk.c                         | 146 +++++++++++++++++++++++++++++-
 drivers/clk/imx/clk-composite-8m.c        |  89 +++++++++++++++---
 drivers/clk/imx/clk-imx8mp.c              |   4 +-
 drivers/clk/imx/clk-pll14xx.c             |  20 ++++
 drivers/clk/imx/clk.h                     |   4 +
 include/linux/clk-provider.h              |   2 +
 include/linux/clk.h                       |   2 +
 9 files changed, 261 insertions(+), 29 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230913-imx8mp-dtsi-7c6e25907e0e

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

