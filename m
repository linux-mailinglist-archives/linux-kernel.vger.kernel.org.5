Return-Path: <linux-kernel+bounces-57069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD3184D3AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774681F27914
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB15A12A161;
	Wed,  7 Feb 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/8oZ/Ux"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F112B162;
	Wed,  7 Feb 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340910; cv=none; b=cf+Cdw6S9WHa/gYg0+WXhrhI2WRnufIrXlOqO83lcAroLWg727QYZmO7LtVppGymUeFIw+fZu7IqH79PPQA+YcTvfS3aWCsfQgdOxlVbhJMOX6fvYmkG8N1SDQaRLnR3HbB2nHIBZMBDkG06GYMgni80kbe9LwzTIjGAW1UTxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340910; c=relaxed/simple;
	bh=4riSpvDKPsuPfk6rX8NTI0xammA7of+/B6rJJfgnT8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnJUsdfLgsVf5gXKP9xi4tPW6KIZ8Toau0rk/2T7h5NX/vX5WYYLCrTW1lZ/lEDRQCT0hwndpgah2izWUZEdk1ViISEkltCwOt/p7Ju5wJ4Cw8KijsiKgHynn6DbPtU1UMDUeb9VL68RXleLVEBkPQoTYTK44Qc/nOaFxjCoDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/8oZ/Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D92C43390;
	Wed,  7 Feb 2024 21:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340909;
	bh=4riSpvDKPsuPfk6rX8NTI0xammA7of+/B6rJJfgnT8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c/8oZ/UxMvF+ytY6K7krxqkNzI/+DZAHQx5Wm5EtPUWUnzrimxAxu0WJhQHNkSRwb
	 n/P6Q7X1nmqK5WcNgNb4DF9Pp3MGtqfPzrV/iOJ/g1E/dl1dkBT+3J44/8zflG20PR
	 MqLUEzP2uBg82oz8tFrH/xYU5QxmCM3A6m21FEMTdpAvkTq7T+Mkx8lABQfRkfPCeb
	 sxRUCyGIo0knzFdhamqtzghtZg88p62Rb1+lXrvpoyJqzQ/mscypbpUJv3WdZ5Qp/a
	 oJmavJmz8ha6qQuuYmm1+cuKPQzyjwkLMV/4HXpBo03/5rcJKTA3Wlu1hmch7j8J3Y
	 pT6tsvO/cPGEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	hadess@hadess.net,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 04/44] Input: goodix - accept ACPI resources with gpio_count == 3 && gpio_int_idx == 0
Date: Wed,  7 Feb 2024 16:20:31 -0500
Message-ID: <20240207212142.1399-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index af32fbe57b63..b068ff8afbc9 100644
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


