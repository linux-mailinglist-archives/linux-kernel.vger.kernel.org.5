Return-Path: <linux-kernel+bounces-121730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEA188ED13
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1F521F31D40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB63152DEE;
	Wed, 27 Mar 2024 17:46:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262614F123;
	Wed, 27 Mar 2024 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561560; cv=none; b=BIgy2pRbpWrIiZTjTj7GrcDrPh8URmB1YrBQTmNKrkJs3tInYu+GPKwv6Ss7eT3TLlIJdrS7/8xGvvTpD10DADrSzTJtk7NKOzN9eUrKq8mCj90qUDuXSVplpFYflNnnBgxUwmz7dd6f3HeGnnIJZRXvmsyOkwhtllccy13F8kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561560; c=relaxed/simple;
	bh=ZFjPJ8bFFVWDPfXrcr0sa1qRi9l9p3U9KSsG8676i5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qE13Y1TU8+prTJ6BfmEJJTTvVZw5LpTBrrRr0kMu8LPCbOYU3I1eQUqGMdyKWYnJjFioAOYAxMvoDF1zlsXPvJ8zvCz4A2yzMOP1yOKe9gxDN+akeDq/HJBxDW6RjMSKxQ+L3K/jksl3gHlB5gbZTAATj43M2MfKWeaJTvb1vQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4CC43394;
	Wed, 27 Mar 2024 17:45:56 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:49 +0100
Subject: [PATCH 14/18] ASoC: rt712-sdca-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-14-86d5002ba6dc@linaro.org>
References: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
In-Reply-To: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ZFjPJ8bFFVWDPfXrcr0sa1qRi9l9p3U9KSsG8676i5g=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsY9+zpkWO1Wlj/5upo7qKd5m6OB01R+H0rZ
 nuLk/0FitWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbGAAKCRDBN2bmhouD
 19UkEACTtnVCSuzTXbaxBY7IiHr8KjsFsRld7gDZE/B/5i+GdcgnUdFltafvrtp3tU0ECLsmIDJ
 wX8YZvgrFkdxOPtBl1Tn/RNmhj1LLVFKXIcZklKpCHp24HURYsSqJHfNrs5IMrIoLwtL2OvqSaB
 4A+x2vo8q2nWnrqMctUi929TLm3inZVZueavD+tAbV3/LJc5KBIKoa01RIINK0sgdl4EJF9CF1w
 uq7UdaAH+uQ257RiMpcZRTa845m83AId0R4/0fI3PcSiJV/l8G3ac4eORP46IaLnqzc0xBX9RLs
 OOvdF5xKm+jGzW83aUPlHA9AfWI0qgVirFkeHSr9e0RYkmc8Vb5D6+VIGKqeZsbooV82l9H+Os9
 +UHdqxFl7tCBiZWTmzt+Ye5O0OAjEBUNsfdg1eQvqlvXB2dlUugguEna6Fi2kUEZ+dvCFTEOc+H
 NwHWwfByLECQ0dsoJ1FY4WKNZ774+Pu1v0hiMV/VLGgipCONFE81bXp/Llkvy0EZBK7g1nIwMKt
 MkQVquas0ppcUh5DmrfHhjRQ0nBH5j0PdZDbZtYMw+CHCNyE6tpLwLvdBC6IV+lBSU6bZu2oCxY
 W7hALV+kq0ovw0uWpzNlasAeE0LzjvnvW35uX5yrM1hcLPlXBOhU5zRZQb4jk0U3D9ovMBpzX05
 BsIccqvHzRBVYHA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt712-sdca-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt712-sdca-sdw.c b/sound/soc/codecs/rt712-sdca-sdw.c
index 01ac555cd79b..f04e11980591 100644
--- a/sound/soc/codecs/rt712-sdca-sdw.c
+++ b/sound/soc/codecs/rt712-sdca-sdw.c
@@ -474,7 +474,6 @@ static const struct dev_pm_ops rt712_sdca_pm = {
 static struct sdw_driver rt712_sdca_sdw_driver = {
 	.driver = {
 		.name = "rt712-sdca",
-		.owner = THIS_MODULE,
 		.pm = &rt712_sdca_pm,
 	},
 	.probe = rt712_sdca_sdw_probe,

-- 
2.34.1


