Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA080CB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343748AbjLKNwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:52:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343853AbjLKNwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:52:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CFE183
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:52:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695FEC433CA;
        Mon, 11 Dec 2023 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302742;
        bh=rnIVZ5NoqCQIqFSODCtBfY9Y52CWqEGI28+S0xTxYaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G16tMg/2fD+VamOP4Nm3kuLPCOrTvlpcZilW8J25mYsNXgLlkPrGuTNE6WuaqeLlz
         Uzw+dZEaW3eSv3cAzh4i5cy8XKawZkQzeHWv0/t4omk16jvDWR+vhJKyxhIuUd1ZwL
         taCwojDWUKaqHMNDPk5C3b/wNzHW92P3oQk3pMoK4DOviMeJt+qXq+64hebqPXcfr5
         9OvKhHpv/lmWkloi2yxiNPWotPemhCdDJ0889NdrwVwHAMt+AEvWWSCQjfIPFoxRmt
         fTQmVUMdjyh9mhYdsUFZHS1v6HL2Vxiep6EjSgsB3ehbZk/9OiuX9UhY93SoXdXEJv
         E7S3ONiCNrjxg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, james.schulman@cirrus.com,
        david.rhodes@cirrus.com, rf@opensource.cirrus.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/47] ASoC: cs43130: Fix incorrect frame delay configuration
Date:   Mon, 11 Dec 2023 08:50:12 -0500
Message-ID: <20231211135147.380223-11-sashal@kernel.org>
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

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit aa7e8e5e4011571022dc06e4d7a2f108feb53d1a ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-3-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 778a62e57d456..206008bdecac3 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -579,7 +579,7 @@ static int cs43130_set_sp_fmt(int dai_id, unsigned int bitwidth_sclk,
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		hi_size = bitwidth_sclk;
-		frm_delay = 2;
+		frm_delay = 0;
 		frm_phase = 1;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-- 
2.42.0

