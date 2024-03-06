Return-Path: <linux-kernel+bounces-94048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7201873908
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91903283A1F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC5134721;
	Wed,  6 Mar 2024 14:26:54 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917AB131759;
	Wed,  6 Mar 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735214; cv=none; b=efUVIu2hU9j6CjKbE/GBc2khftgSr8XLmDXWAWA7YyumXDxVxqrkxHK2zUJzF/I97LHy8trEy/UwqKc5uszW6kfMRUnOD3Z/WSjxyuh8vkjV3vUQWowN2FAn8oNszSGuZjtffUmgY9FJ0gGRZp9bhja2QH9rUa3koauK/M48TTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735214; c=relaxed/simple;
	bh=IPhqRpKqR3sy7ZHHLSH1nPq95d8MYyZshYGrN4QCbF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebpWW7uGJdRacWqftYYlMPpcEk9XCiWQA/w0oyCGpm0WVtbEiJdPHM1F0KLLzEmTs8sNrU80Z5JWdWlb3VitU9UGp7mDftGJvL20hBoekBZdAlX+k+7EWmBppHEvjuvTdcrZaqJ/HSppbNUU2llEO8heTTzehCpelOb6T6t7PJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44f2d894b7so545716066b.1;
        Wed, 06 Mar 2024 06:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709735211; x=1710340011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqjfQ3I1iB32XahTp39x8hHpwxXe+SMvVIkZ0gdQ7VA=;
        b=pRQZjLp/0/ysbpSdMK9Pa6EdRgO288mp97Wn1DphyE+Oh3972f13CUMMBDnZfagefX
         GJmROdPV/+idUKx1vs6SN9XCP7WGQ4wpqo8gya48hpAVfSL+23DPAQ6w38jZvznh/PDu
         dEyxzMUR51jP2fiKaalazKH17uHyne9mE5vopjBT7/db2t8juGI/6UhNLKUw9B4PPP1O
         5fZj6yrE7Qk8POTbIe3nqZck/vBBLqt+V8mOS3YaFv7/S5lxM+j/VGfTX12xDOwrWlYd
         Zb+uHA2mqJfzj3+XXd/chp1lvrDhzWhtq0rSvlbQNynAiVKWKddj8j77BTae+zJB5yj3
         OOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLVwofm957UmRECzLoTKW4CwNFPeZE4BFZAU5kl03P9krZWFym9nEo9lmpl3PVHzKE3a8RRZX/jm5BWzt8OMEaWHSH0rwCf9FH6O057sYNWPAtuuoOQ4lXpZqZth8jXsOQRdD0NWXu
X-Gm-Message-State: AOJu0Yz7/Er56BEw81ck46nBPma4RXO3XIJgxW7SeQKtdFZTM11C5Sa3
	wNGXsD5gJQHcJ9UML0AyAO+15JVFD8fPYhSiMlnANE6ru68x0zwJ3UVPhxAe
X-Google-Smtp-Source: AGHT+IEpVtnkvtOGqj3WqkZPoejKhkOCpVak/Ik26VZx9HfShSlg42b94xwnXJI0tavSXyXlIHv/Ng==
X-Received: by 2002:a17:906:5953:b0:a44:b90b:3262 with SMTP id g19-20020a170906595300b00a44b90b3262mr10343584ejr.5.1709735210946;
        Wed, 06 Mar 2024 06:26:50 -0800 (PST)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id w8-20020a170906b18800b00a43fe2d3062sm7231231ejy.158.2024.03.06.06.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 06:26:50 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS)
Subject: [PATCH net-next 2/2] net: usbnet: Remove generic .ndo_get_stats64
Date: Wed,  6 Mar 2024 06:26:42 -0800
Message-ID: <20240306142643.2429409-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240306142643.2429409-1-leitao@debian.org>
References: <20240306142643.2429409-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/usb/usbnet.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index a3a46794ce43..e84efa661589 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1644,7 +1644,6 @@ static const struct net_device_ops usbnet_netdev_ops = {
 	.ndo_tx_timeout		= usbnet_tx_timeout,
 	.ndo_set_rx_mode	= usbnet_set_rx_mode,
 	.ndo_change_mtu		= usbnet_change_mtu,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address 	= eth_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 };
-- 
2.43.0


