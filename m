Return-Path: <linux-kernel+bounces-123746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6E9890D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07701F21CA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563D147C71;
	Thu, 28 Mar 2024 22:07:56 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC52147C62;
	Thu, 28 Mar 2024 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663675; cv=none; b=Dgs9Qfdkdfu7o3EExenwQflyEQOqRC2aMABeGZuStGrnbZVMQW9DReDvYdUCM9q4OJc/SXehBidXN+7yDkBv2Y7HrHUk0UjOgfnkMG6TCgdeLfmJdCs2VCcNjLyMREBokxUiNqM8UsYFRjAwRqJEtIT69e0wyM95TX/mBb9HvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663675; c=relaxed/simple;
	bh=knNVVDokeLkUtIiM/RNUHlIV+ElW5WuXfrWQm+3KY74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZ0cVKXACW1o5EgT1VdX7qXmrOthuJ1Ykataq9QfbcPh4izy0Q9TJHhgWZ7gc1pHI+hKdJ/eQ3pdoaTPS8/dAVDnRFwB5R7B0wOKqzKSb2QPqvHkVbZFfeIOGj5pkvQXx7lPsfiiCs7NRyWX+0f5D0xEfM6KTEmcY6wne8VoL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E95C43390;
	Thu, 28 Mar 2024 22:07:54 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:18 +0100
Subject: [PATCH 40/52] USB: serial: sierra: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-40-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=681;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=knNVVDokeLkUtIiM/RNUHlIV+ElW5WuXfrWQm+3KY74=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBendl6kwG8noPA1Nu2yFnAMKge5QtE22o/iRP
 +gmnPJ21/+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp3QAKCRDBN2bmhouD
 18sJD/0VCdFTPJy6poTy4fHrLeqwK6WB8ZJeBG5Q2/Hzf3vvT5Bu2PltxvfSy53bbP4oK/6XBm2
 BDj7VNkeH1jV4GvD1pBnjFIK8/ygQHpXlTXdYTlFhuH3pgawiRnn7CIdQhk3LaOgT4Kjs4mV7iV
 /noQSy0CMgimIccLhP2TCKa+duEKu5QbF3P8E+lrpznVgVzRF0X+SaBKNHDMS5mfMDcr8DZ/212
 bPbrVr40yMZ7V3Q5VLng/1op7jJCW5pX7MLs0hgdqJwLdnMBZtOEi34q913EOMRjdrgTx4R5VGR
 FMGA0ku/Bv3RnDuN/LtYrSNYlSsWw3GQPQftl/XKCyMkxZDRh+GyVBPploWAzlXAysuoqMBJVv+
 OnSWA3BbZrhrm5H45Qk6V4bbLqMTEmS1e/0IvUMWsh1tUI37cQWv1NBqE8v/6JuNGapZlLrgbLZ
 /dCjXau3Ikyt2IB46Kd8Fr5aHNjfG3F3aWW2maENqRNDTb/Hiq1qAMwux+0tp52K3ep6/HdIoSq
 0UTevYVkLd1L9+oo6aXP71aZPDp55Gxo/9pZKOg7ll9p8c7NlmNki9+h/sUtk7Wp2ksxqqGQ3tX
 cF5svva8ZMig0G/vz+MIssGRyZM5tjTPEmOoxr/LN/WVHNqpe+m84M+N2GkuLvDicyUiG+FTit5
 qxy77OuLL1mlcwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/sierra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 353b2549eaa8..64a2e0bb5723 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -1021,7 +1021,6 @@ static int sierra_resume(struct usb_serial *serial)
 
 static struct usb_serial_driver sierra_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"sierra",
 	},
 	.description       = "Sierra USB modem",

-- 
2.34.1


