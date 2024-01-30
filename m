Return-Path: <linux-kernel+bounces-44295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B7842006
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4249E1F26281
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AA1664CB;
	Tue, 30 Jan 2024 09:47:30 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C0657BC;
	Tue, 30 Jan 2024 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608050; cv=none; b=BVL+tmHAq9V1C8EJ4cAetuaJzIpy/3BTzXxtsw38xHux4XY7f8ZfthTuwpNZ8Pe4WseLJwye2M81X9L6+ZEoLyNo3bbJycZ4SGG/GCdQPQur0vhazjGhl787se2OmSlY4zzBMuHz5L+5MEZfHQwMUs3KjU2/55d5HEF+//IFp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608050; c=relaxed/simple;
	bh=76vNyh8F4XZ0a480DjHSCr5Iu/Fp4x+9DNu9tsjd75E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iu8bOWLqWL1OUJ4k8NmH+toBvgPU8qeDhynM0Yln3bmas7NsbMxC4um0kmskmq/LLvint3ljCfnTtN8zUE/wUsb40HDM63CDd+jFansFG3W+hmuRyv7+Vhfi9tuDwd9akPrbZytMuUQH7ZqN77DSZVtObqx6TNOj2uVPVlzUk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 889142F2024C; Tue, 30 Jan 2024 09:47:21 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id BF8882F20242;
	Tue, 30 Jan 2024 09:47:14 +0000 (UTC)
From: kovalev@altlinux.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org,
	u.kleine-koenig@pengutronix.de,
	a.firago@yadro.com,
	sashal@kernel.org,
	zhuning0077@gmail.com,
	tiwai@suse.com,
	perex@perex.cz,
	broonie@kernel.org,
	lgirdwood@gmail.com,
	kovalev@altlinux.org
Subject: [PATCH 6.1.y 1/7] ASoC: codecs: es8326: Convert to i2c's .probe_new()
Date: Tue, 30 Jan 2024 12:47:02 +0300
Message-Id: <20240130094708.290485-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240130094708.290485-1-kovalev@altlinux.org>
References: <20240130094708.290485-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Commit 784252bac835c831e10c48be633cd1ff0d697326 upstream.

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20221118224540.619276-602-uwe@kleine-koenig.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 sound/soc/codecs/es8326.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 555125efd9ad3f..28a0565c2a955b 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -816,8 +816,7 @@ static const struct snd_soc_component_driver soc_component_dev_es8326 = {
 	.endianness		= 1,
 };
 
-static int es8326_i2c_probe(struct i2c_client *i2c,
-			    const struct i2c_device_id *id)
+static int es8326_i2c_probe(struct i2c_client *i2c)
 {
 	struct es8326_priv *es8326;
 	int ret;
@@ -897,7 +896,7 @@ static struct i2c_driver es8326_i2c_driver = {
 		.acpi_match_table = ACPI_PTR(es8326_acpi_match),
 		.of_match_table = of_match_ptr(es8326_of_match),
 	},
-	.probe = es8326_i2c_probe,
+	.probe_new = es8326_i2c_probe,
 	.id_table = es8326_i2c_id,
 };
 module_i2c_driver(es8326_i2c_driver);
-- 
2.33.8


