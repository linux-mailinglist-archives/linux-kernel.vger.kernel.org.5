Return-Path: <linux-kernel+bounces-57152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D051B84D489
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D282F1C2250D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA1B154BF3;
	Wed,  7 Feb 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0RuEvnX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8450155302;
	Wed,  7 Feb 2024 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341112; cv=none; b=UGA2OBykArttq3PYqtqtYOaUOMoXpOGTT2TkkxsKAkJtN+WhGX/RiItuqKMggUgssGeVgdJbgoUCxVxYGT2S16r+j6P560Op4vK/qDBKTbP0dq0qvC6OBZiakAlw4CWyyTUnKv42aWljfEGmJZEpajH6GKSLjp20y23Y39+5mz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341112; c=relaxed/simple;
	bh=HxzqeR34vWKyBCxMv6Ub7CmvMT1sXq3Y15wW9tH7EGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS6tvXCRb6uawZYuvyMm+IfGqVtUYCKyMDsyiBv9cP0Hgm3Bv7uKcLWhgYJXjTdmQcvOMCQiurdTj5u/R+dMUNV8W3VJe5FjS9uAVBAwWnxK91rPfJVN76dzyhCW6aTQ2dE5HsXzHp994smeNLGe3grmtH4lEz5V8MLmBAQXCvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0RuEvnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9078CC433C7;
	Wed,  7 Feb 2024 21:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341112;
	bh=HxzqeR34vWKyBCxMv6Ub7CmvMT1sXq3Y15wW9tH7EGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0RuEvnXTExRkjO/dAO6bVRmxqbEcr31KufCb4eCxWqy7pgb/bxsP8flc98jUUdoe
	 KasOagCNgL/5Otu8ehNMgv9kVSDzudPsHIIz2opPZCSNW73PihwWcOKGD2o4981fi6
	 X/Zi2Kl/DZlwWLI0e5wUXDbse/QaYqVoakJ6z08M5NUXGXdGl7KbsKlS9hLVd/CR3j
	 9qUSDe57mz+HFOSzkuoseYcPRX+DeWgcdVaWqokcc+OeHTfkDXqXAvHOv3fSaeIFUD
	 /pQlV0SfE1ero2sjJWie3VjC9OUuDgVzcebIhSLoO0UBeRNR4iox5NUdX56iH6mlBQ
	 qgPuZVCRoT/aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	hadess@hadess.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 04/29] Input: goodix - accept ACPI resources with gpio_count == 3 && gpio_int_idx == 0
Date: Wed,  7 Feb 2024 16:24:29 -0500
Message-ID: <20240207212505.3169-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 180a8f12c21f41740fee09ca7f7aa98ff5bb99f8 ]

Some devices list 3 Gpio resources in the ACPI resource list for
the touchscreen:

1. GpioInt resource pointing to the GPIO used for the interrupt
2. GpioIo resource pointing to the reset GPIO
3. GpioIo resource pointing to the GPIO used for the interrupt

Note how the third extra GpioIo resource really is a duplicate
of the GpioInt provided info.

Ignore this extra GPIO, treating this setup the same as gpio_count == 2 &&
gpio_int_idx == 0 fixes the touchscreen not working on the Thunderbook
Colossus W803 rugged tablet and likely also on the CyberBook_T116K.

Reported-by: Maarten van der Schrieck
Closes: https://gitlab.com/AdyaAdya/goodix-touchscreen-linux-driver/-/issues/22
Suggested-by: Maarten van der Schrieck
Tested-by: Maarten van der Schrieck
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231223141650.10679-1-hdegoede@redhat.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/goodix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 3f0732db7bf5..6de64b3f900f 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -884,7 +884,8 @@ static int goodix_add_acpi_gpio_mappings(struct goodix_ts_data *ts)
 		}
 	}
 
-	if (ts->gpio_count == 2 && ts->gpio_int_idx == 0) {
+	/* Some devices with gpio_int_idx 0 list a third unused GPIO */
+	if ((ts->gpio_count == 2 || ts->gpio_count == 3) && ts->gpio_int_idx == 0) {
 		ts->irq_pin_access_method = IRQ_PIN_ACCESS_ACPI_GPIO;
 		gpio_mapping = acpi_goodix_int_first_gpios;
 	} else if (ts->gpio_count == 2 && ts->gpio_int_idx == 1) {
-- 
2.43.0


