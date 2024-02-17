Return-Path: <linux-kernel+bounces-70059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF6859280
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F3072869DB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF381205;
	Sat, 17 Feb 2024 20:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="WIMhl9TS"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760380C00;
	Sat, 17 Feb 2024 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200803; cv=none; b=PG55zeBQWy4cpr9Eo9RReTa5vthppgF6Oa7HYnWIjA/RFccdOx11UPHfLpYPCL8M2TxMRAi5Y1f3BicdpeSWdto46Fvv2UdrmE1C9UAL5JnMg2b9KxhzRtpM/8C0wDCpdHA1r7nwhwhT2uTiuZuR9yr2aQaflwjw5QWn7ctaM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200803; c=relaxed/simple;
	bh=eeFgE80nQULg/ODH3WLl9PUdnSdgjTDRNDmmr+zQ1fI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbGKxASldZZYM9jZx77GAs2zJ1xdbtS/CHin5D/kDas0br3OH6iLeRSqT6dBmoMHWYthyRl+Nht6wPWguYWD9T01Gji6TE4w0nee+vDNLirDWNm4GfkvydE4cNnNgKpcdjn2mzxn4SW3SnPAflF3afow/r/IYCbaQzBq6NLVtQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=WIMhl9TS; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso1282846a12.2;
        Sat, 17 Feb 2024 12:13:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200801; x=1708805601;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8iNTygmT5ipcARp5YbQMkBNVEB7RzR82cYZWFFk8+0M=;
        b=ULajX2IBBzx8jTV0Kh3tvW6ZcMPqq+u/JmK24UJy6HR9+dUY3ddrapeFum5gDLmjbc
         yYIRQsGcM0Imtt8rU8pEUYu1JRnnglg4ggHBQXeCDeEnozz+aV+cV8V0gZpLRoAYL6t4
         r8Cur9dSFxG9GRzVJnsmXZ4Kim4cvJ9X4tz1Ecm4fMXdJWga27lcMv7lDP5mdsr52zJP
         Y1jj4HJtQc4ARqvfx4tsCBzxPzC3opD3IWUz+jF5xdxIW5YFOqT3p/vtrh8RA6tGcW6N
         QQECIxMy3wkBN7wE0j400lU5ryIbZItKws/ZtvVCGp1JxDiSk2SqLUrLBFWXH1G6UEyB
         IS1w==
X-Forwarded-Encrypted: i=1; AJvYcCWzVKLDRuyyR3nPZgjbg9srHIZuApPngaOKXgZAzXL5bZhQlC5bgiNnYFrt0zrZFXZ/NyF6YfvSa4+HWjpXo1Z0gZAA0Mf78hVLKomJ9Ccuw723n18cZNbDXfJoErbebjqoLBdw7wa/b69aCGcyH/RnrGc8ShcCUSxut+3OZqzMgHyz
X-Gm-Message-State: AOJu0Yw95tyeblnl15P/HfL++DDeysr55il3JTGs6unRG/Hp7zMVngyI
	ghJz3zdCVuRHaFOtpbu4IGZM7V201B0sZl/CNTzW2as4s5bpsMiP
X-Google-Smtp-Source: AGHT+IHSFdn6mSeJbZau5IuIx9IKsfcMi1A/6wHz+QaGjOuSMIpNBvBhhKVOwa50RrAitceZU+f0Og==
X-Received: by 2002:aa7:84d9:0:b0:6e3:1fde:cb72 with SMTP id x25-20020aa784d9000000b006e31fdecb72mr1774098pfn.23.1708200800938;
        Sat, 17 Feb 2024 12:13:20 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ka26-20020a056a00939a00b006e134c4d69csm2001825pfb.200.2024.02.17.12.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:20 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iNTygmT5ipcARp5YbQMkBNVEB7RzR82cYZWFFk8+0M=;
	b=WIMhl9TSIiodCLJ2hmVc2j5qyyoHKviu61n28l1TovzHev6vEaZc6SP4BK3gFVJBUqqq5m
	EBRDBx+bXWIH5buy9/86HKeTKRrp0mrMnhqSG30q0KP0CPDlIPBU4GVKfjvkRoO5WnQfg1
	wXaJddfm5IWx3/ZA5/cRwnwHVjA9vHopDfkxzMZenPpDKQ5uF5WR3shxhBLLXLlHCJ6yRt
	LHnjaJBsfqtHBKvtumFHmOzDv70kotqKyK72y/8IvBFlgys4fGZfLYLGstARgY1gf20mfe
	KBp/1nP8Zq6zVQTrRE7csmwVwnUws6WnjMC4mhsnRNcz5jt6jUeBHUqIvi7GWg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:30 -0300
Subject: [PATCH 08/12] net: l2tp: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-8-1eb31fb689f7@marliere.net>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=eeFgE80nQULg/ODH3WLl9PUdnSdgjTDRNDmmr+zQ1fI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNtaYr4KM3ym68vowZ6RFZ8dGZ4QSN6ZFoqj
 dePyx6YDuqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbQAKCRDJC4p8Y4ZY
 pvbhEACfDIVsBUMTjBZbGV4kR4SOZZQiVQ3ZsIP9+Qga6a+hrWSp8vxQLL3MXOTueQ1WhMSffTL
 xc5aEmWO+QZDr7qUWUtwcTbtvMswxHFeMJJGWtLpU8skfmMuNKPL43e/GU3q0VdOrYx6l1sgglA
 zaTYZnYousVSSZfafz/zfUik3eQnfFIjACfV6YgZARpniBYYb1PQ8+0jtBKzmaVIv6rzKNk5YMg
 Kjf+lvl2m3vxKGT+M96hZ40Ot6oYKe2+G6e5P/NscQ0LMNjnC+SfKk2xEtvNa/b6wFpnkKQhu3I
 4z0EV833G7g+UDPFuA8F5jVoauFyoA76ujGMgLrKLxlNek600Iov2EmbVpTI/VdLYU3oQAZ/BaY
 fAwRTS0qQ8h17A+9U1gVMQ96HcR6IRcevaxM55UREk1JckbFcm/TcWMPUlSKYONzpKhuunkGQnA
 WOGnSOe6UhxxO/js8tSLU8Xrys7cK9xS1F8pKSKQAye3h65j9GIEEsrQTf5DEBSDdLjGvoLFw7L
 f67MNie/cE1mOe8EA/MVyplPNDYWpgX4FVefNBqBl7pdKoEjGTJ3biF9U9+YCAdYAAls41bksKS
 9danhTGJxyyA0qZSZ90y6qr3g5s5uyhZv5JTxV5qqkurUhgsZUxIykns77OrrFXXTGPeOjCV/2N
 /4I8cY9pNqMl/TQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the l2tpeth_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/l2tp/l2tp_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index 25ca89f80414..39e487ccc468 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -100,7 +100,7 @@ static const struct net_device_ops l2tp_eth_netdev_ops = {
 	.ndo_set_mac_address	= eth_mac_addr,
 };
 
-static struct device_type l2tpeth_type = {
+static const struct device_type l2tpeth_type = {
 	.name = "l2tpeth",
 };
 

-- 
2.43.0


