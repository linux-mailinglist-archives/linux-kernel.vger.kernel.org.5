Return-Path: <linux-kernel+bounces-121724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5498D88ED01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8628E1C2E4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7895514EC7E;
	Wed, 27 Mar 2024 17:45:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261B14EC63;
	Wed, 27 Mar 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561540; cv=none; b=eIGi3bC02U4jI9xo2I966sa1V9LYmddaaiqwbuoe+RyVsxyKNhqx9+9d6x/JD4aSvA0wMrG+88ktPssPmkDWN2iCejtwSmfo8qMr4FRonUmpj44fUf/IO3toQh1mrDveq7hPMdIqX3Wz4hrlgaaUDX9nkLs8qMTEaTU1U4pPsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561540; c=relaxed/simple;
	bh=G3qDvzvaAriAFdEKuhbrwzjm1GWzjjiU/QZPkOJtje0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ywdt9Ga/T8agdzWZIxlS0Z9XJpMWBSDeLN+ugqcKhLgT0WXNS/8H88zRzl9eXX9770Ghv88BGgh8gW8tWp9kGWX55ubzEPINw+UA6823JrYlweMeqdmZPHBkNTK/kJeljqQjyoykLhYyp21lw8FeCEiT5wG6x92QuVqyWTonnPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2935C433C7;
	Wed, 27 Mar 2024 17:45:36 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 27 Mar 2024 18:44:44 +0100
Subject: [PATCH 09/18] ASoC: rt5682-sdw: drop driver owner assignment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-module-owner-var-v1-9-86d5002ba6dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=675;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=G3qDvzvaAriAFdEKuhbrwzjm1GWzjjiU/QZPkOJtje0=;
 b=owEBbAKT/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBFsT/UreYIHR1g9/K4OLagqMOr0rsnz6zzy/j
 xGR7m8FyiOJAjIEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgRbEwAKCRDBN2bmhouD
 17laD/j3N0YEadzDYviV1gKA4bj0vkzHi1obmdadp4x1MKrX1QwwJZKLalouffTb5DsGROoHqFP
 oBzUQwbfgIOdG9TxBHQ0Aw5JXPLjp9DieNXpKrqJmyfqYfsmpZ+1KR7zxgujxZrLudkHp40nHke
 h1+6H0ThaEkRUFtFyRhUNbOIjf/74+q6kq0RhRjRdeEt8trD89Bc7z3ZzT7zrCpk+ZQAPkt/N1B
 K6JrEdZRmFsQR4P/GiMAxccHJ7WnEwqX1nQvH9MTVN6qNZ82Z8DI9VBT97QmwWy+OW4teirtR9V
 LhCTirdLs0ELOb0HbufmDv6R5X92bldElp6lr8+k945pohB/1Pg0eHTqXXsImQ15jusNZenHeAZ
 TpoEYS1ZF/sCErEDD0afLkYFaMj/+NRq/2JTV0dCq2Hu9dKhZnI2JqfSHCOIo0dyEKxqhGUTQzN
 w6Qbbu7HMA2pX2lGWpgKxE1w285rpbF+8xxWibfIskMyHPz8V7tL5kv0rbJwMHqnYVDPG+BG9Vc
 3b051XdUWdvV1p4KBej4jTzgJOZXw7OJfCDC6lRvxY2GGJ3TrYLYCO2mgzqcAaCHN37jnfK/UTe
 j9Xr8yZstzeY0Q2Y9NCVP8YZFvxOEHLYUqRFjhILYsFFDkv+fDra7I/Vecfa70h4kBYScPe2nPD
 mzoBqGHwxvwn1
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdw_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/rt5682-sdw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index e67c2e19cb1a..43737d5cedd0 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -798,7 +798,6 @@ static const struct dev_pm_ops rt5682_pm = {
 static struct sdw_driver rt5682_sdw_driver = {
 	.driver = {
 		.name = "rt5682",
-		.owner = THIS_MODULE,
 		.pm = &rt5682_pm,
 	},
 	.probe = rt5682_sdw_probe,

-- 
2.34.1


