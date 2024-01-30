Return-Path: <linux-kernel+bounces-44414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E7E8421C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1119A1C27EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1E16A33E;
	Tue, 30 Jan 2024 10:44:02 +0000 (UTC)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F05A6A016;
	Tue, 30 Jan 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611442; cv=none; b=JntdLfw2SNsk3Mc8lALo/NhErBpwB5IzPhHPS8+YTv/fdxf5B+DkXj6qxEPpeEDtqpggeWtocqL1UfzCJvw5rjsRyVaItASmkbX0WDq9l6xr4BO/QJYsqKP9/hJN1yK547vHUhbeL0aTKIi1RBLonyPAtZFwBbJ+rkBxLTIv1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611442; c=relaxed/simple;
	bh=bddUoh0vrzJAC62VpMem/mVGELq2exyvym8+mursGMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fpoU7glZL+3dtPlK5qEFZj1l6jHNvVyyFRslYQo2X4qiOrTH+VjOesPXtTodHiWN/IvVAjxDAecJTjJzJnc4HRWhTCYLN+eGWQQOG7y3pktHna3A8xenyIB9iuf9z8KCU279L0p/bIXN0avhY+4R4bDROTwq6ulOaxA+dy6bEzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf328885b4so43818121fa.3;
        Tue, 30 Jan 2024 02:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611438; x=1707216238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2hIslwX7zDUitnZgFr4A5pcX7VA5sGMR+7J+Ts8dJU=;
        b=gC775Np1/uBrJbAoFrcIgocnzg4N9pEH6xZIFWEJwo2DsBGlgNDB2pzFYVEiyTqJMC
         HVj4bPTTXgCy4l+mCtMlbJ5zsl7DcA5RTLNi0f8M4/nEKN+NYGlb9LBqpdqnRSblTBRs
         p8SrSrquHZtaQuFxwGQ5fhnjhGNsMYsydm58qyD+Plxic7sRZAX7lVnsDc4cjjhufXPW
         572OjP6grRg+CHInSSam5xIb/+LCDpfCLcdXVRsQJNrS2TJub1PRvebIX5UTU1H84GGn
         gpAYHfocwLuqz4+eeWmk/qt+ynzr1oD/O0aEZFx5de2BEycNgSglNUnQ+tbb0RxeIPlI
         IkIQ==
X-Gm-Message-State: AOJu0YxDciblotf4MixCgS7rvVn9wrt6oIEh2e2NyHsD8sRYzX9nOKtS
	LqbjQqv7bo5kMT6lfiGq7MggeBJb/vdjPTs64vt07jo/rwLZCgF8
X-Google-Smtp-Source: AGHT+IE2naGw7VHTuOXM5Ylli8b7HfsG5qtzq1mUFoP9fuAA5DPWBFa5swHLxY6GdVV43oBJhz0a+g==
X-Received: by 2002:a2e:b8d1:0:b0:2cf:457e:61fa with SMTP id s17-20020a2eb8d1000000b002cf457e61famr6529905ljp.37.1706611438514;
        Tue, 30 Jan 2024 02:43:58 -0800 (PST)
Received: from localhost (fwdproxy-lla-111.fbsv.net. [2a03:2880:30ff:6f::face:b00c])
        by smtp.gmail.com with ESMTPSA id d15-20020a056402400f00b0055eebd3db08sm2452144eda.66.2024.01.30.02.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:43:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Christian Lamparter <chunkeey@googlemail.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	linux-wireless@vger.kernel.org (open list:P54 WIRELESS DRIVER)
Subject: [PATCH net 6/9] wifi: fill in MODULE_DESCRIPTION()s for p54spi
Date: Tue, 30 Jan 2024 02:42:40 -0800
Message-Id: <20240130104243.3025393-7-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130104243.3025393-1-leitao@debian.org>
References: <20240130104243.3025393-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the Prism54 SPI wireless driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/intersil/p54/p54spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intersil/p54/p54spi.c b/drivers/net/wireless/intersil/p54/p54spi.c
index ce0179b8ab36..0073b5e0f9c9 100644
--- a/drivers/net/wireless/intersil/p54/p54spi.c
+++ b/drivers/net/wireless/intersil/p54/p54spi.c
@@ -700,6 +700,7 @@ static struct spi_driver p54spi_driver = {
 
 module_spi_driver(p54spi_driver);
 
+MODULE_DESCRIPTION("Prism54 SPI wireless driver");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Christian Lamparter <chunkeey@web.de>");
 MODULE_ALIAS("spi:cx3110x");
-- 
2.39.3


