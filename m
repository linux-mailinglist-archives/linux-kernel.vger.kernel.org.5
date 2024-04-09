Return-Path: <linux-kernel+bounces-136971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB989DA7A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83AC328E587
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1591350D6;
	Tue,  9 Apr 2024 13:35:23 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9DA1327EF;
	Tue,  9 Apr 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669723; cv=none; b=aGZjjcqURoy96OlMtfVQYOe/KKT4o25nSxzvowkWb4rII3swt7ojs3OiYWc0gA+BhGbbJqjOBLv1oD2NYeTrjCBFxVRyvu5xnFGyXPNIau3pSkoZn+Tejag9seuaZR2kJGy4BlzFUiC34PjNFvc/sSKqrPJnbSfhRTDNZhU4DjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669723; c=relaxed/simple;
	bh=yl5/q/WUU1uXbLvE3Nqu5YfCmbzQezEakQ9PUdxCvNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0IfkP4PLUnB+2O3ZNxkdcxs2ciq0eUgQj7TjqMvbjSZC5UwPmmmZZc9QqAE6A0/y4ZZ5KQVaIBfDThUaiJwS8Z+5hPJikOniNGXvsKhKlzQ/EIyH5JsODfTNXrzprJG1jKgkbudTLxLwojriBQGqiqZnS7E1t2uGmjaOBD1o5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so1588889a12.1;
        Tue, 09 Apr 2024 06:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712669720; x=1713274520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZJgm0se1InYmQN1IGrU37BSkJWkNutCdfnN9qnmHSI=;
        b=MnoWJwjjSc84kHHmoGvWi9zoyQt0DRYZLV1i/UFuqLl3BTZyU9Irl3PlrS2PY/GNzh
         g/OCUshy3fL3wMcAMEA8FqNIT7pWLGLZWXvR9Lug/xWWwpJFWKqdirx2RNCqqvyCvaq0
         XDj7C5QXvaclXpa/1QFEvdOGW0NSVAItu8lC8ZnhXTycnWDEWNOH28Dd16tCIdI2GI1o
         YUhLJdvl4iN336O03+w6z9t5yyC6iWTG96c/yTEugLNEzrUiIqmA6VgA3hXD60gR4Vgr
         ctO+KP4KdEmsKe8PtFHMcH/M5SAFBE1Fz84gE8TfII5xfsQlOB1B6lT8Yd1YE3LZac7Z
         r1Jg==
X-Forwarded-Encrypted: i=1; AJvYcCWymXjaTBf3uehDUdyi3Lam6a/kKEFJV6f8xD55hzhs1PPY8CHyAPAtxkcsBM9G+x8/uz+zeOSQJfkP6VjrN3z8jjCwm+cVJLJAIZb3S09ylZObvYO1chr3nIPwwuLHGFL8
X-Gm-Message-State: AOJu0Yzc5rqNolQA3i8VKQvCny6izQGLuslX5ZkFY3rSjd0NWWL8XtNc
	UyGTf9Ycsc1nJD8XaXhcUmT4rbVy+3V0ejDAiJLA2c+gTZhOadHXWZAYMXLj
X-Google-Smtp-Source: AGHT+IEYYrSlucZVJjyhA9IPgoogSAMBJMlUWH9sZRQKH8wvejXGi01JBOZ3Q1xzc15zz/wShlyWLw==
X-Received: by 2002:a50:a419:0:b0:56b:e089:56ed with SMTP id u25-20020a50a419000000b0056be08956edmr9798348edb.39.1712669719705;
        Tue, 09 Apr 2024 06:35:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id c9-20020a0564021f8900b00568c613570dsm5293760edc.79.2024.04.09.06.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 06:35:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org (open list:USB NETWORKING DRIVERS)
Subject: [PATCH net-next 2/2] net: usb: qmi_wwan: Remove generic .ndo_get_stats64
Date: Tue,  9 Apr 2024 06:33:06 -0700
Message-ID: <20240409133307.2058099-2-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240409133307.2058099-1-leitao@debian.org>
References: <20240409133307.2058099-1-leitao@debian.org>
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
PS: This was compiled-tested only due to lack of hardware.
---
 drivers/net/usb/qmi_wwan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 5528a9c2b9d6..0e764f09a57d 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -121,7 +121,6 @@ static const struct net_device_ops qmimux_netdev_ops = {
 	.ndo_open        = qmimux_open,
 	.ndo_stop        = qmimux_stop,
 	.ndo_start_xmit  = qmimux_start_xmit,
-	.ndo_get_stats64 = dev_get_tstats64,
 };
 
 static void qmimux_setup(struct net_device *dev)
@@ -638,7 +637,6 @@ static const struct net_device_ops qmi_wwan_netdev_ops = {
 	.ndo_start_xmit		= usbnet_start_xmit,
 	.ndo_tx_timeout		= usbnet_tx_timeout,
 	.ndo_change_mtu		= usbnet_change_mtu,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_mac_address	= qmi_wwan_mac_addr,
 	.ndo_validate_addr	= eth_validate_addr,
 };
-- 
2.43.0


