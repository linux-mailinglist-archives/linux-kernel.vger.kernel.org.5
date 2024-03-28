Return-Path: <linux-kernel+bounces-123736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84AF890D33
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52FF297C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D764A145B05;
	Thu, 28 Mar 2024 22:07:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE312FF95;
	Thu, 28 Mar 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663658; cv=none; b=P+MX8ScY34ii3jGTchwlhzdF7BlGh7y0AteOc87zjDLiQiTIGds3odvNfqSFxNjLKYt9PqgmVkY2F+F32GzUZwpR3V63u9qZ7D+M6gy/mWl519/N3pHrfo3XFmCO367HANbDk6fJpXgVBL9UUM7E2g36h4NvvEIVqccWhSKoJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663658; c=relaxed/simple;
	bh=scoeb1hRYcITW/jA/Xrd1v3gR/9o4O5JKMR6NyR9KmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sYv0l9kEmmr7yccVhzPy6UGgs5Dz4+xCZeTW5xKdltUAydfXtR1G0a2zA+bvrtU40l6cxu/qR6gz8mAlEoKMN+8gzNo6EW58rIE5lbfa48x+/PPwz5qfV4wBguMXOREJ16sR5VsyhXnVojw2DK31CGBI3s6WnD3IT9H3Xv4uTww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41440C433F1;
	Thu, 28 Mar 2024 22:07:35 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:06:09 +0100
Subject: [PATCH 31/52] USB: serial: omninet: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-31-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=673;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=scoeb1hRYcITW/jA/Xrd1v3gR/9o4O5JKMR6NyR9KmM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBenWkDSZCKOBI0ifuOUXxNH+UokEosW9qELBY
 PjrNgdysSCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXp1gAKCRDBN2bmhouD
 1x/QD/oCapB3utks2AfeX8NdfnKWm6wCCWjoruHmcmuf5xDWvoX+L8DXhERmwxrgsBLHqUUS+Rv
 yskVpv28kD/2lN75bl3gidN49CGN5ccDZS0ZaF5gO4rDH7hbpXLNmJ8Vl4bizsMuTrWIdLqK+T7
 Re9x48Hxbaa/Fbw+LyIfPk9oB1cRd5CR5/B7C/lgZf8Gm1wDp/VAGvNBKN29GsL56qJwf0NLYKH
 ZzbWnbJdywocRFj+rSzZBYGn2/W+Cew9kzUMuMHIyY3VKY/8zExX4pHTDAbq+T21MbXDCHVdP3b
 ind8hIR+zVRVvziGhvACq4hAzzklMBAzZD8+NZtChY/W5nbe4KFMkbMZCpGf16l3gj8ulfryJoj
 8hymcKd6sUMshMfTFBx+3tkJSoVh/WFm+OGggLKlD8EF95GQSY9FOtNOaWg3ckj9gVGapNRG3tq
 rMifeUZ3Q+MWKoUEfa8SWGvOy3NLu27o09x+CGyu2atnpQ5mp8SWlMS81QpFG1JBpnmjT0PaN43
 0GD6lHOPAmTQWktO0OU6pCGGRmo0i1Vu8NFx99G65y805pPgBK1El9o18YZgpQ58k1cHbRhu9jy
 eGztPEJ5NsQ9uT81TjMPggAnALYvlhrDBkjmbTaukJddN9LiiwYIE4+4MOtir64E1N6ebm95RxJ
 mPBGLa0RL8VGvKw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in usb_serial_register_drivers() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/omninet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index 41f1b872d277..397ebd5a3e74 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -49,7 +49,6 @@ MODULE_DEVICE_TABLE(usb, id_table);
 
 static struct usb_serial_driver zyxel_omninet_device = {
 	.driver = {
-		.owner =	THIS_MODULE,
 		.name =		"omninet",
 	},
 	.description =		"ZyXEL - omni.net usb",

-- 
2.34.1


