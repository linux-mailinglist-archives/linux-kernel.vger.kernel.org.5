Return-Path: <linux-kernel+bounces-8186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5881B350
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967CD284216
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98DF4F21B;
	Thu, 21 Dec 2023 10:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="umB+kXZ1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA55102F;
	Thu, 21 Dec 2023 10:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BLAE3W4030693;
	Thu, 21 Dec 2023 04:14:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1703153643;
	bh=jIF3ygWneWyg4E9/HdJotb5ROUTYDslZO/q/Izyycnc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=umB+kXZ1g2hALmaW4+Q+IXAAd0xtTIUWv+eUTvwTtpSY+vvNYuCElw1wm3uCrkaUR
	 /1Tgm1uj1UZ7ATpFHPsiEj8UMuvVJgg3Qsw9YG77OunPyxAwRcNsjWljWID717TEqy
	 063N6k20Rn6W11yzeFlLs8U8GLlaozmjKGR7FpJY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BLAE36j003779
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 21 Dec 2023 04:14:03 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Dec 2023 04:14:03 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Dec 2023 04:14:03 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.210])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BLADoQd069419;
	Thu, 21 Dec 2023 04:13:58 -0600
From: Shenghao Ding <shenghao-ding@ti.com>
To: <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <kevin-lu@ti.com>, <baojun.xu@ti.com>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <13916275206@139.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <soyer@irl.hu>, <tiwai@suse.de>,
        <peeyush@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v2 2/5] ASoC: tas2562: remove tas2563 into driver
Date: Thu, 21 Dec 2023 18:13:42 +0800
Message-ID: <20231221101346.429-2-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20231221101346.429-1-shenghao-ding@ti.com>
References: <20231221101346.429-1-shenghao-ding@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Remove tas2563 from tas2562, it will be supported in tas2781 to better
support dsp mode.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Change in v2:
 - remove tas2563, which will be move to tas2781 driver
---
 sound/soc/codecs/tas2562.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 962c2cdfa017..54561ae598b8 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -59,7 +59,6 @@ struct tas2562_data {
 
 enum tas256x_model {
 	TAS2562,
-	TAS2563,
 	TAS2564,
 	TAS2110,
 };
@@ -721,7 +720,6 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 
 static const struct i2c_device_id tas2562_id[] = {
 	{ "tas2562", TAS2562 },
-	{ "tas2563", TAS2563 },
 	{ "tas2564", TAS2564 },
 	{ "tas2110", TAS2110 },
 	{ }
@@ -770,7 +768,6 @@ static int tas2562_probe(struct i2c_client *client)
 #ifdef CONFIG_OF
 static const struct of_device_id tas2562_of_match[] = {
 	{ .compatible = "ti,tas2562", },
-	{ .compatible = "ti,tas2563", },
 	{ .compatible = "ti,tas2564", },
 	{ .compatible = "ti,tas2110", },
 	{ },
-- 
2.34.1


