Return-Path: <linux-kernel+bounces-44416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2838421CD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38333294731
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E66BB5B;
	Tue, 30 Jan 2024 10:44:05 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29F6A35C;
	Tue, 30 Jan 2024 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611445; cv=none; b=uOnEqR0UtRVM755ry5bo5L+trgmtoZZUU6/x24djORz/k8xHD5lJdC15ZTZZrE7p1S2YlxerunlyohvpXxJI8lHfT20/bs+eZw5P/KFEIuoAPMzKKmfUCzoO9/5FxOPD2n6KzJfFPz3YUPhQFhmw9I9rz15CxX28v8vL5yvLP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611445; c=relaxed/simple;
	bh=r0XNrSM8xrYrjkGY+kLXt0iVTRC8VsPT0yPJ0PYXU/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgfjKwoKPKX8gkH9G/k0GRU7Uty2NfI2Aga8ALDFsmmk0wi70J4bZS8ikd6pK2wpm22/UNKDw4ZrCwMp35yvYD2F3DOrXFQY385bpV4N6BqEJkJlleMjQquBK96kTMnrtYgueU9RxouYxsBV+06yyGYq7pXQTFIkR7Tvy2wPrs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so3530559a12.0;
        Tue, 30 Jan 2024 02:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706611442; x=1707216242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/FBsGmaU0v38mjD0wQsroCdxmJrzCQpL6ZDqMWITCc=;
        b=ufJMk8ZfV9xrnujEhzgF2Icmf2LahWrcCPO6nv9gkxgCdVFT+4Af3rY9LdI5biPk1p
         lErRNj3nrWLJwWpIgtR2glN1kS89Wc8JzF1rwh72HzMUlqy42n2JGDiZXQK8gelf1UIS
         i5ahTo0q41Ddy6X8EMJ4WYvNbXAsMLxYLh+JE9Zmj22aZwVDlOsq1B8oY0MDFQPa0Tne
         VyRkLAmkMjNSTrMoN8sy7Lj/ip1fiH3tcT3zsGi1l6KmSUhgn1bUxF9Ip9keeSI8w202
         IfA9J9tk0pHJASeUwJQq2LX3kAtM6wqUt4rKa2YsESkE63+ObGgT1DOZgXiT6AEkKmN4
         nX4w==
X-Gm-Message-State: AOJu0YzbfgG0vAeQun3EgwgwMCc+BWwvRy9LU+Dv7a4yeUKoJBPLkVi3
	8390WgW4nyiW6tUb+BfptgGySV8DCsUrbqpff317a4vybIoUshiV
X-Google-Smtp-Source: AGHT+IG26FT+gevDQpYSFljgTDG5f6QVhZLBk5s2lMOjjITAri8rY8kBYrX/aOhgKF5fSpjn7vSLjQ==
X-Received: by 2002:aa7:daca:0:b0:55c:6935:1b1c with SMTP id x10-20020aa7daca000000b0055c69351b1cmr5603178eds.36.1706611442061;
        Tue, 30 Jan 2024 02:44:02 -0800 (PST)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7dacd000000b0055eb8830906sm3602167eds.85.2024.01.30.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:44:01 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Kalle Valo <kvalo@kernel.org>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch,
	leit@fb.com,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-wireless@vger.kernel.org (open list:TI WILINK WIRELESS DRIVERS)
Subject: [PATCH net 7/9] wifi: fill in MODULE_DESCRIPTION()s for wl18xx
Date: Tue, 30 Jan 2024 02:42:41 -0800
Message-Id: <20240130104243.3025393-8-leitao@debian.org>
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
Add descriptions to the TI WiLink 8 wireless driver.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/wireless/ti/wl18xx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ti/wl18xx/main.c b/drivers/net/wireless/ti/wl18xx/main.c
index 20d9181b3410..2ccac1cdec01 100644
--- a/drivers/net/wireless/ti/wl18xx/main.c
+++ b/drivers/net/wireless/ti/wl18xx/main.c
@@ -2086,6 +2086,7 @@ module_param_named(num_rx_desc, num_rx_desc_param, int, 0400);
 MODULE_PARM_DESC(num_rx_desc_param,
 		 "Number of Rx descriptors: u8 (default is 32)");
 
+MODULE_DESCRIPTION("TI WiLink 8 wireless driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Luciano Coelho <coelho@ti.com>");
 MODULE_FIRMWARE(WL18XX_FW_NAME);
-- 
2.39.3


