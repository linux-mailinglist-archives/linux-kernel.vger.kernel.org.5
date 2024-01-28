Return-Path: <linux-kernel+bounces-41943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F38E583F9D1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 21:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905031F21B45
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 20:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030852F9E;
	Sun, 28 Jan 2024 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="aj5epTaS"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C74C601;
	Sun, 28 Jan 2024 20:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472701; cv=none; b=dunlCuLa4pImc92m/6uNmFtSyf4Sa28rfvIrqyA0O4zmuQnadnG4/KPhRlgrt/vIyIKEJ5q+yGqjzscH2aKCFX57E7ArFsFKgEfA0JB0CojWoBrbafUBzbOXVbnd98/3txdgg0lXWcmVrlYEHnkpmue/CE/SZpA6diTMtUc7SO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472701; c=relaxed/simple;
	bh=TdAVXBepThtonvq05OjVh53CVgb2tOWE132D7XX4Sa4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cShq14lIrrG38QezTNuObNOcF8Li8KJ8cNag1evkfGA4LT9DmTf5t4kkATVKsGLIbcdRysrA3/bPsaOrvFymHuk7motcyKa/RyNi8QaUlEDqHusz0XtCtzNJ4kQQoWVSFnIk1xAe5g4JfrSdli0SjZGnz41zZXt5i4JAhpSuS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=aj5epTaS; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706472685; x=1707077485; i=wahrenst@gmx.net;
	bh=TdAVXBepThtonvq05OjVh53CVgb2tOWE132D7XX4Sa4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=aj5epTaSsEtWxIOT7Kyn70WttkHX8mO97Y+usp+O9OaxDrZBh4/WCziFrRFiJl5w
	 hgbjqctNJ5/R2T3RwoGqNkuxoxRRZIyWr3ZpQm5l4JpTxhbJrd9gG9lc/Ttq2bMTg
	 Hs+EZs+cQpySfKuvPSl2S5TqChDgGJq6m1HTXcpYNwW2dcY0vIP487V8BqwwtZL0N
	 6mGXJ4djtWqNtLrFtVdPV4MNRVv6XI7V0I6SXf1k59aMzrxVzl4dPjkldPxuJhZk+
	 Ggu0kYz7l7YH2wPPFspZPzKlO9GM3piBsIs8XGjYCZB276ZtFRaBS/CnfOzRdPtYY
	 bsHjSceec8Up3dNGqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHXFx-1rHD493e2j-00DZDf; Sun, 28
 Jan 2024 21:11:24 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V4 13/15 net-next] qca_7k: Replace old mail address
Date: Sun, 28 Jan 2024 21:10:57 +0100
Message-Id: <20240128201059.6259-14-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128201059.6259-1-wahrenst@gmx.net>
References: <20240128201059.6259-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M7V2PLT1HdFWGe649SBJERW5zbJXCKK9SHEqd/xKGEfk9NdcNmI
 /UJK5NmLBgbvK4wHcp3waD3PRuxwTUhLElYIR62NFWCbBe3L3adtbv0zRSlZ70Rgb2TrYoT
 HKg4zsomHoIsCyvh6gOxzvyP332VtRRi4/orXftrNAu6Crkoew2JLo4dNiTfDQuF67OuDv6
 lbLolxQ5y6pivDO1oy0kg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cFGmtwLpARo=;p2dWNyQr6Cp6iuFFcjo23Njz2eJ
 +EdjIT7t66ij9YpcskLQ0S7q0wFRxUuFcMIUauI0lv7VGochwSBWX2SCMv5OMaqIP+0fmmPIM
 oJRW6jH/Y6YVg1sqNrXcpZkcNe9BqbMAVJjRqslAE0lSa4ahnJ2gWZhU4uR509BXrz04iWVpr
 QuD4eva+fn4zksDGCJjhG6SjegL2sHLEJMa14dii38lqAts+nNFDm+7KQToVQDBgzC5Q3+7MH
 ksCbmY1U2GwJcHLohs8c2WPEdVMjbLnzyTDjijMsVAFWXgOsG7GwD0k3vmwLrvzx2mPWqM8Kq
 3A1HwZHFaTf7ZLfGp5WrRwlxNlHaP+X+GkS3pgpYA8YAy8lDxQtkd8c8fronDIxbsFDwjnvAt
 /9qVSDzapQWDiWkPpD2yyDrSkaoIh8hE2uKvHhU2K2fpzOBbQO1aMNr+rvgeIo12C8q/nWHXH
 b/ggv8CDhY75v3z/F37kSEZ9y1n9pxx3UXJEEwEpw0/h1SHU2UUR3I/iM5mIwaz7z+fK5UW9A
 r0v5QDqDmW4XbS7s5Wr8MuWAiu1kQV4tu8mGQSf7e8n+jVtLC//MiWxKcOcRWsfj6fzGDaceY
 Z4IrEID3BXQ06jVQHb9eYM849zmIJI0s1uNe23bxwB5OqDJj7f+Wdc9GHh8Zbx0fRXjWGRnkY
 4G09s7uw2jnh0omUNUb31cI28c37QeJuuPKrPC4Uuf55Ch0/XX6x3MzZe1PdWXIQ7oUZP702L
 G3w6qM0sU6kVrBP2rN/Qxv5TEhSY8KzO5DTQ2wQsC0rBfwqmyEeqiGpdOrNNpEKXBiBL0kw/T
 pTfHUAbo4u6lkKEnQFbIAO8SXqb9wn+EGER+bhbgt9czWTmfyLK9h7is7c0t8zdvEjcoQGMlc
 iHV+d9JQA4je8cnuB7OsGsead+wNWLDBM12qdfOWzaNZ/wQxTyJl6DW9Ap5tmEOoM86NJmIK5
 TN/rfA==

From: Stefan Wahren <stefan.wahren@i2se.com>

The company I2SE has been acquired a long time ago. Switch to
my private mail address before the I2SE account is deactivated.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 2 +-
 drivers/net/ethernet/qualcomm/qca_spi.c       | 2 +-
 drivers/net/ethernet/qualcomm/qca_uart.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.c b/drivers/net/e=
thernet/qualcomm/qca_7k_common.c
index be2f754efd21..5302da587620 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.c
@@ -149,5 +149,5 @@ EXPORT_SYMBOL_GPL(qcafrm_fsm_decode);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 common");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/etherne=
t/qualcomm/qca_spi.c
index ed6d20be19bb..5799ecc88a87 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -1043,6 +1043,6 @@ module_spi_driver(qca_spi_driver);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 SPI Driver");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(QCASPI_DRV_VERSION);
diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethern=
et/qualcomm/qca_uart.c
index d0db9d0adad7..321fd8d00730 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -397,6 +397,6 @@ module_serdev_device_driver(qca_uart_driver);

 MODULE_DESCRIPTION("Qualcomm Atheros QCA7000 UART Driver");
 MODULE_AUTHOR("Qualcomm Atheros Communications");
-MODULE_AUTHOR("Stefan Wahren <stefan.wahren@i2se.com>");
+MODULE_AUTHOR("Stefan Wahren <wahrenst@gmx.net>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(QCAUART_DRV_VERSION);
=2D-
2.34.1


