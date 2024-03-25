Return-Path: <linux-kernel+bounces-117678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1416988AE56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462911C6099C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9574535B6;
	Mon, 25 Mar 2024 18:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eavuOgEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B276EED6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711389919; cv=none; b=ZyrPyWQuEo5JZgnC64TIQGY5VeVPVq4yBRgY8MezUI2OP0fXj3G1+i3JQ+u2tglrXlg+Ia3iJR1KfzvIPoLD24fMOvfrsmriYkuYXrsdO/i9PmSkhYwTrQ7RLYk7f6gSVKCgC3zXCvBMvZyfl0rSFfmIEDhzcY6FeYXNVz1s6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711389919; c=relaxed/simple;
	bh=Eq9Fz0FjOM7wjrEHZc/skgv0SNQKVWFRNKIAHFfafOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T17M7v3KleDyxpv/jSQ8mzq3UC/AZHodNgAMULdzEPg6p5pgJKubDy6lS57WKgl61nkuME4rIIG2lpS1o0WpUWPDu/JsbcYDQQhjMc9A4Yv7SIoTF9/2wJz7rz7oxQRSIvoPuPYPb0tgx1ZQ0gBP8TalgKq/OL2fXa8YjYI7P4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eavuOgEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF348C433F1;
	Mon, 25 Mar 2024 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711389918;
	bh=Eq9Fz0FjOM7wjrEHZc/skgv0SNQKVWFRNKIAHFfafOA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=eavuOgEIiymwBcEd/cs8izkXMRebRRESN5+fMl8z0itRu3v49AjIBf2T82afUFX2f
	 jPPieho8uMaIWb9ZC8VnAaxXY4X9NKdXJO2LSSE4Zv34JyD3c0Xd0bSz6Oq7pIduRN
	 Xwt1oyJdDl7naGA+2I5QMYNCpeEgKH65MMNMtVwb0Iynjj3YinRhEeRSVNosXaG+RZ
	 nz2j/1l6J23hoePlRquoMsMAXIUA7wnpbM6rUAoAudAzCvjkduG+LARmUNZ+6f+/or
	 VgJuzy9CurYZWpKLAEFTPV7VjwjFwtBGvl4XafeJ8kWrQvnfbo5bFvlu+8bG2rw0Xe
	 +kjoKGe5OaIcQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A273CC54E58;
	Mon, 25 Mar 2024 18:05:18 +0000 (UTC)
From: =?utf-8?q?Andr=C3=A9_Apitzsch_via_B4_Relay?= <devnull+git.apitzsch.eu@kernel.org>
Date: Mon, 25 Mar 2024 19:05:09 +0100
Subject: [PATCH] regulator: tps65132: Add of_match table
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240325-of_tps65132-v1-1-86a5f7ef4ede@apitzsch.eu>
X-B4-Tracking: v=1; b=H4sIANS8AWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMT3fy0+JKCYjNTQ2MjXTMLY0vzRNNEy2RzIyWgjoKi1LTMCrBp0bG
 1tQA1zrrTXQAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711389916; l=1264;
 i=git@apitzsch.eu; s=20240325; h=from:subject:message-id;
 bh=Y23B5v2pnT5ytkfuGZwM57ZFxcbAa4hFV6lYc2Evsoo=;
 b=FGBKARqa/RCXMwGNRqo61P/XH/+1MAcptJw6JzImB7Xdoaz8tiLaQzKI+eVlCfbcvuFjjVfMw
 KT5ItZH7RTzA2KhytGWXHlJlJymGVDFGdGsy2ONsHVXVr6ZOXcnhIrW
X-Developer-Key: i=git@apitzsch.eu; a=ed25519;
 pk=wxovcZRfvNYBMcTw4QFFtNEP4qv39gnBfnfyImXZxiU=
X-Endpoint-Received: by B4 Relay for git@apitzsch.eu/20240325 with
 auth_id=142
X-Original-From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Reply-To: git@apitzsch.eu

From: André Apitzsch <git@apitzsch.eu>

Add of_match table for "ti,tps65132" compatible string.
This fixes automatic driver loading when using device-tree,
and if built as a module like major linux distributions do.

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 drivers/regulator/tps65132-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/tps65132-regulator.c b/drivers/regulator/tps65132-regulator.c
index a06f5f2d7932..9c2f0dd42613 100644
--- a/drivers/regulator/tps65132-regulator.c
+++ b/drivers/regulator/tps65132-regulator.c
@@ -267,10 +267,17 @@ static const struct i2c_device_id tps65132_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tps65132_id);
 
+static const struct of_device_id __maybe_unused tps65132_of_match[] = {
+	{ .compatible = "ti,tps65132" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, tps65132_of_match);
+
 static struct i2c_driver tps65132_i2c_driver = {
 	.driver = {
 		.name = "tps65132",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = of_match_ptr(tps65132_of_match),
 	},
 	.probe = tps65132_probe,
 	.id_table = tps65132_id,

---
base-commit: 1fdad13606e104ff103ca19d2d660830cb36d43e
change-id: 20240324-of_tps65132-68397a5a9c72

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>



