Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894AA80CB6F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343753AbjLKNwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343629AbjLKNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5620D1B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C27C433C7;
        Mon, 11 Dec 2023 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302732;
        bh=MRUhMqC+GDJw65ZzM06rgKE7O0ZbiTBnjSVH5YENzYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6PPchxGM8dYm9YBCec7qZ2Ugx1hxOGvqDVUJcYjHxP3Ywj8efkbR1900cfkaxuUs
         p1L1OygU2dO8hPPn9scI4ePhefPSsMPFvxrsoPKmB4VXCVZK0g1OKsoTKjP3ZzHcCw
         82wVmNb0Kg3wuIsb9W1pWAXO9dsh0ce+iF8KrqNIn0jIth8g4BJCmy5QiK4l/2LNiS
         PgL1Y+ByU+oNXpjhtP98dB3j45WjUiyQr47k4qgYmklLqJ3kSirBpJaZahqc+2b4Xf
         YffCPPN176kmA1lLg+skWkIPchkDCuX1IInY3k2L5r7/ip7dBk5vsmULUxgZP7Jnvp
         vgILTJ0nagZTA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Lin <CTLIN0@nuvoton.com>, kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, francesco.dolcini@toradex.com,
        emanuele.ghidoli@toradex.com, u.kleine-koenig@pengutronix.de,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/47] ASoC: nau8822: Fix incorrect type in assignment and cast to restricted __be16
Date:   Mon, 11 Dec 2023 08:50:08 -0500
Message-ID: <20231211135147.380223-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lin <CTLIN0@nuvoton.com>

[ Upstream commit c1501f2597dd08601acd42256a4b0a0fc36bf302 ]

This issue is reproduced when W=1 build in compiler gcc-12.
The following are sparse warnings:

sound/soc/codecs/nau8822.c:199:25: sparse: sparse: incorrect type in assignment
sound/soc/codecs/nau8822.c:199:25: sparse: expected unsigned short
sound/soc/codecs/nau8822.c:199:25: sparse: got restricted __be16
sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16
sound/soc/codecs/nau8822.c:235:25: sparse: sparse: cast to restricted __be16

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311122320.T1opZVkP-lkp@intel.com/
Signed-off-by: David Lin <CTLIN0@nuvoton.com>
Link: https://lore.kernel.org/r/20231117043011.1747594-1-CTLIN0@nuvoton.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8822.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index ff3024899f456..7199d734c79f2 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -184,6 +184,7 @@ static int nau8822_eq_get(struct snd_kcontrol *kcontrol,
 	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
 	int i, reg;
 	u16 reg_val, *val;
+	__be16 tmp;
 
 	val = (u16 *)ucontrol->value.bytes.data;
 	reg = NAU8822_REG_EQ1;
@@ -192,8 +193,8 @@ static int nau8822_eq_get(struct snd_kcontrol *kcontrol,
 		/* conversion of 16-bit integers between native CPU format
 		 * and big endian format
 		 */
-		reg_val = cpu_to_be16(reg_val);
-		memcpy(val + i, &reg_val, sizeof(reg_val));
+		tmp = cpu_to_be16(reg_val);
+		memcpy(val + i, &tmp, sizeof(tmp));
 	}
 
 	return 0;
@@ -216,6 +217,7 @@ static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
 	void *data;
 	u16 *val, value;
 	int i, reg, ret;
+	__be16 *tmp;
 
 	data = kmemdup(ucontrol->value.bytes.data,
 		params->max, GFP_KERNEL | GFP_DMA);
@@ -228,7 +230,8 @@ static int nau8822_eq_put(struct snd_kcontrol *kcontrol,
 		/* conversion of 16-bit integers between native CPU format
 		 * and big endian format
 		 */
-		value = be16_to_cpu(*(val + i));
+		tmp = (__be16 *)(val + i);
+		value = be16_to_cpup(tmp);
 		ret = snd_soc_component_write(component, reg + i, value);
 		if (ret) {
 			dev_err(component->dev,
-- 
2.42.0

