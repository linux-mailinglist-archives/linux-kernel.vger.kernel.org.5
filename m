Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5DC79F02C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjIMRQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjIMRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:16:07 -0400
Received: from out-226.mta1.migadu.com (out-226.mta1.migadu.com [IPv6:2001:41d0:203:375::e2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A025A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:16:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1694625361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VCy5Fm2ZbO6JXF49obe3yELdCB4LbYDYhIgHM9669eI=;
        b=MopDdj+zlz9nV8t6ZnIoNnxG2DgoGWJxW4X6tFEfIGfqeldt3QDA5A9focV3BTzgftWxu0
        tg7qLsc9XLXozEqHe71TBgD+tQ1tr8AA4AXvj3cLCEwfIslmO2/pSihOfl5Me2PR2nByN9
        F2Lq1jfD7j49idNUYIZVAZmcaWcFqNQRaCLgi4tZNJDwp7BW5azuHrGP6gvcGzAknJ0ctH
        XsAJkBVUBD4iki/fPv82AXwPiXwoCBooxo7sdy9zpx1o1TW+F2TITap21LSIp/L7cPOsaF
        L0obz0Xfpe1CxctwEil2y2dPZ7C2/ze6/OKxMp9MF7Uf83I+LBUq0LQYiZavOA==
From:   John Watts <contact@jookia.org>
To:     alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, John Watts <contact@jookia.org>,
        patches@opensource.cirrus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ASoC: wm8782: Allow higher audio rates
Date:   Thu, 14 Sep 2023 03:15:49 +1000
Message-ID: <20230913171552.92252-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8782 supports higher audio rates than just 48kHz. This is
configured by setting the FSAMPEN pin on the codec chip.

This patch series introduces the 'wlf,fsampen' device tree property
to indicate the pin status and control the maximum rate available
when using the codec.

v1 -> v2:
- Switched from max-rate property to wlf,fsampen property
- Clarified property is optional, not required

John Watts (3):
  ASoC: wm8782: Handle maximum audio rate at runtime
  ASoC: wm8782: Use wlf,fsampen device tree property
  ASoC: dt-bindings: wlf,wm8782: Add wlf,fsampen property

 .../devicetree/bindings/sound/wm8782.txt      |  5 ++
 sound/soc/codecs/wm8782.c                     | 66 +++++++++++++++----
 2 files changed, 58 insertions(+), 13 deletions(-)

-- 
2.42.0

