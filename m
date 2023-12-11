Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2395D80CC2F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343912AbjLKN6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbjLKN4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:56:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB6130
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 05:55:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A8DC43397;
        Mon, 11 Dec 2023 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702302923;
        bh=yQnUnFg0gym5LOztqFTKR9ntwOlf62euBeFOLuLBAiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwcRPpNoShjqREIbxfQ20ZUROcrplsJ3Q/jk6F6zRhBO29y0KFuGzoXg5Pv/XzFbA
         J1p4+SVWFvYoLlrptIbasV3AC6qqFGXx0ejIgc7mw/+f4XRqrgZQahnFKZHCr28NuZ
         kDFfy9Wu5FG/POZS5MkM/YaTuEVZbh1M+0FvqgCKQTGF61iLNgAc6VSxk8fhJGk/6e
         2OdC8zSG2dFMSJuK2N04KeSN89eTDCpa3knuShbWsBcekHuNir7ilPd+THQD51vdtp
         W+/tq37lY0Y7+zC3zeeKfKEkutH0vyyXQKQE+eGyqb/W1EoKw4di8e9QtBdA7cRBRF
         ggEvL6LJcBk4Q==
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
Subject: [PATCH AUTOSEL 6.1 08/29] ASoC: cs43130: Fix the position of const qualifier
Date:   Mon, 11 Dec 2023 08:53:52 -0500
Message-ID: <20231211135457.381397-8-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135457.381397-1-sashal@kernel.org>
References: <20231211135457.381397-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.66
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit e7f289a59e76a5890a57bc27b198f69f175f75d9 ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-2-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index db39abb2a31b5..1fcbf2ffccfff 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1683,7 +1683,7 @@ static ssize_t hpload_dc_r_show(struct device *dev,
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
 
-static u16 const cs43130_ac_freq[CS43130_AC_FREQ] = {
+static const u16 cs43130_ac_freq[CS43130_AC_FREQ] = {
 	24,
 	43,
 	93,
@@ -2363,7 +2363,7 @@ static const struct regmap_config cs43130_regmap = {
 	.use_single_write	= true,
 };
 
-static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
+static const u16 cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
 	50,
 	120,
 };
-- 
2.42.0

