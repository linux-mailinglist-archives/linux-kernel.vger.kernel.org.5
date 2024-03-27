Return-Path: <linux-kernel+bounces-121750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC988ED3D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF381F32FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8C152171;
	Wed, 27 Mar 2024 17:48:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5914F10A;
	Wed, 27 Mar 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561699; cv=none; b=uTLB5Qeuz4Hr9z9Y6iXBPsXB6Q47/qfuwYzK5cNElYQ7HqnaMJCB8qhwnh2bt33n4nINFio7nxWkSjc7NCl7x++nmOTKqTJSRgrNO2VNnZkpST4R3MhWFzVBIomy1QQJeqoSwYHCWmvUan9Eu/gbUDT6iOz4jm0Y+obqaOLlK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561699; c=relaxed/simple;
	bh=a/I//LM8NJtsGdqwIUi4zC1d+cVUdEefVho6N/5BZvg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RKCq4RvKjWXOx+6n99Ei1Bkl8zG8c0RfDNLmZXQZT3Bem3dnsS0fOSgpqWpqdlz0gSk61kK9ROIUxZyWD3NUiyPXBtpsuPAETf10WV/FHTTcIh+tBFtBOAGg9uzlIV9uLFriHmI/+zOyGoSf0Il32arQrSZRJv4LSgOqABV35mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B851CC433C7;
	Wed, 27 Mar 2024 17:48:15 +0000 (UTC)
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
Subject: [PATCH net-next 1/4] net: microchip: encx24j600: drop driver owner assignment
Date: Wed, 27 Mar 2024 18:48:07 +0100
Message-Id: <20240327174810.519676-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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
 drivers/net/ethernet/microchip/encx24j600.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/encx24j600.c b/drivers/net/ethernet/microchip/encx24j600.c
index d7c8aa77ec75..cdc2872ace1b 100644
--- a/drivers/net/ethernet/microchip/encx24j600.c
+++ b/drivers/net/ethernet/microchip/encx24j600.c
@@ -1112,7 +1112,6 @@ MODULE_DEVICE_TABLE(spi, encx24j600_spi_id_table);
 static struct spi_driver encx24j600_spi_net_driver = {
 	.driver = {
 		.name	= DRV_NAME,
-		.owner	= THIS_MODULE,
 		.bus	= &spi_bus_type,
 	},
 	.probe		= encx24j600_spi_probe,
-- 
2.34.1


