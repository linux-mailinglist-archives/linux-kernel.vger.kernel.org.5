Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA57783C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjHJWto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHJWtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:49:43 -0400
Received: from out-115.mta1.migadu.com (out-115.mta1.migadu.com [IPv6:2001:41d0:203:375::73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AE2712
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:49:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1691707778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PSP4YBxo8D6m3XZCk4VYqj+oPk1gw7bx7s64DSVlKUQ=;
        b=YaL7y1P7Ilsu4wJJ4m5+dVAfhcGn45SVAuDhFrneAsrrW8XTGYmRBcTgk5UEjCJegNEAOk
        Y8iyz9l9ZfPGkdMOshA2ap1l3Q4YizcEqq8tLO0soHkyVLqoHtp/KKfuciEe1vosleWm1k
        ilsOLcoGVqeLnVYY1nBksK5X1P5XZVEpysZTmWqgYJRd4BQ+H1+C70jcOApmyO/f7WThO3
        Aq4rB+OFo5jUcrt3z8jnduHxOTysTcHrGh6XuqCYzYXsztTdHraQBdjJ4282mB9BfrBCJ6
        vaQeDkB0uWMLNH4QM261dAkPK1QMVHLggVoyH4h8RAwleJKfOAac7HMoR8Pu2w==
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
Subject: [PATCH 0/3] ASoC: wm8782: Allow higher audio rates
Date:   Fri, 11 Aug 2023 08:49:27 +1000
Message-ID: <20230810224930.3216717-1-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wm8782 supports higher audio rates than just 48kHz. This is
configured by setting the FSAMPEN pin on the codec chip.

This patch series introduces the 'max-rate' device tree property
to allow indicating which rates are fully supported by the codec
without accidentally overclocking.

John Watts (3):
  ASoC: wm8782: Handle maximum audio rate at runtime
  ASoC: wm8782: Use max-rate device tree property
  ASoC: dt-bindings: wlf,wm8782: Add max-rate property

 .../devicetree/bindings/sound/wm8782.txt      |  2 +
 sound/soc/codecs/wm8782.c                     | 49 ++++++++++++++-----
 2 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.41.0

