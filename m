Return-Path: <linux-kernel+bounces-121752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAA288ED40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6DC1C32364
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B253B155380;
	Wed, 27 Mar 2024 17:48:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D614F105;
	Wed, 27 Mar 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561707; cv=none; b=RzZZuzM55bxfZ8x26UNH8azE5PraZ6Z6jmdCFRDF5bMzRW3sHxz4mOZjC9Y9YW0rHSKjqWevvWBdGfexSXOQdvV+kzqCZ7umF8zgEdRIOU5+H6pXz+fgfFSHvvUiwImHumFiGy0KlqWE+KE3lGIZxJqqVG0siSYKCWwfzeNa7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561707; c=relaxed/simple;
	bh=hSedw07vWJALRZnkhNHXpxs7dAVflXhYDSmfvk7WWFM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpAk87rh4wCfU0AiqFNydeeifMhdyrogM1AGKUKfWCyIc4iY/ZNfLa+NJjx0jBMt8+m1Blc2FYYc/YGi6++hQ8xkBtNxvPvyzuSk6uEgZpXDE0yU7CrukDEBlC1tWTpMRS2eFagHhW7hzgdyeJ5uGfpcX+AMwDmi4j8lFE/HDks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A002C433C7;
	Wed, 27 Mar 2024 17:48:23 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] nfc: mrvl: spi: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:48:09 +0100
Message-Id: <20240327174810.519676-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
References: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Core in spi_register_driver() already sets the .owner, so driver
does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/nfc/nfcmrvl/spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/nfcmrvl/spi.c b/drivers/nfc/nfcmrvl/spi.c
index ad3359a4942c..9c8cde1250fb 100644
--- a/drivers/nfc/nfcmrvl/spi.c
+++ b/drivers/nfc/nfcmrvl/spi.c
@@ -199,7 +199,6 @@ static struct spi_driver nfcmrvl_spi_driver = {
 	.id_table	= nfcmrvl_spi_id_table,
 	.driver		= {
 		.name		= "nfcmrvl_spi",
-		.owner		= THIS_MODULE,
 		.of_match_table	= of_match_ptr(of_nfcmrvl_spi_match),
 	},
 };
-- 
2.34.1


