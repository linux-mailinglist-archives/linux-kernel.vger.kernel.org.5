Return-Path: <linux-kernel+bounces-70052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A785925D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB34BB22372
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FD77EEFA;
	Sat, 17 Feb 2024 20:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="S2YAL+kh"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB887E76D;
	Sat, 17 Feb 2024 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200780; cv=none; b=eczna/Lunm+ODWQjffvmG4Nv1pAhn7mRVWKjCVk1uz9Lyd2k8OMJJG8b9uxz7cOVkPrV0gSrC3inLjybs/lP5xxY4E16fK4MQ4NsgG1Nd7VFSzAaeWzz5N/bE21jmwTfDoxXRRRhm2TkLwdHZEyqTMwGtnXk1bBGuJFyil9S5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200780; c=relaxed/simple;
	bh=IyZ5Y2ln3RlvrkcZB5wxYoE9pnILf6gx+8QtBGCE55w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAawgPFpctB9coQvEtbbHC9u4mSfob2TVmTwZUjEw2qCrk7chaFHKSx0CObi4kMi8Au52mZpsuFBBjZZM89KIKAEGkmxBfSfoFnjlVQ1Kmc/6bPgcik2WIac9OMhd9XiGWTcgeCQSIpvaAgUp4cQIjDtf9xGQ/uudfnv+a8+Cmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=S2YAL+kh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db51e55023so18453985ad.1;
        Sat, 17 Feb 2024 12:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200779; x=1708805579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=56fgxRj3TpAnVefFQ6EA11ISjF6QjKkNNnHYVEnweY4=;
        b=mSPaqaMx7IflpYuKnvm0X+4MRVMU9HTXmjk0HDIFs82GbLsQJjmA7YEF6IqwDE0tQe
         XqTzgSNauKdyYaqzddhHwNS9v2OnCwf/nNRV9vlBpz4Wv0JEQ0DLSRcnIcWRsa29kYrV
         Jc5ORtEJ27iOX3pwS+LtBOJzefofsoedWsvYZF2aV5CpJXkEBqXXpRJO+/ouCqz5IUwq
         p23AHZ9/0OGepNkaNXRrOcZRztvNR6phMJ7v2yUJL5nDGF3vFkNgpoXyejdgWH+GeQM6
         wirL0kDHP2fCdyY9FGm7jCJDY7WYC1JEaEW3M1ByF4NP0KPx0cEQHrmPyJE4JaQ3Tplj
         zL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9LjPr1bk18ISHtMznCnaxFQMaAUQss6seC2ES+ePlUWbr4nnu9nnK2Q41X3lM42fVG3ezbA3sV/asY+uZqTH9KLuSX2YShOcR71oPKvzdy2D/5+cy9XI2ieaE0EHIIX1zSh27WSu6zramPBYulwR/42fkunCCbJ62CjElSRKRnHBe
X-Gm-Message-State: AOJu0Yzz3NRhuXzx5oRJOd9Fi6xZF6fMZ7q0simy4k+RTgp3jrU5kz7+
	dCWvcJ9U6PJjmsnwD2Sibufex+EWtyHlLS1vukvtL6l89VW+2qVv
X-Google-Smtp-Source: AGHT+IFN0G4viv/q31g5wHX99KqakJNN37bIX87mIyybeLlZ/Sfgqj1rQ6hk9aP8wEZXTEX+ZVNd8A==
X-Received: by 2002:a17:902:bd0a:b0:1d9:4ebd:b94d with SMTP id p10-20020a170902bd0a00b001d94ebdb94dmr8124665pls.55.1708200778637;
        Sat, 17 Feb 2024 12:12:58 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902c1c600b001d717e644e2sm1775479plc.247.2024.02.17.12.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:12:58 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56fgxRj3TpAnVefFQ6EA11ISjF6QjKkNNnHYVEnweY4=;
	b=S2YAL+kh0Ndho84cJSPnOrpRjlxyb10n9jAW+DUbupNBUfDKzggwmjd/9WCaHSkR+46azL
	2AK6aG04VRb1ndhiyShUpQ6j9nWDkXbHcjGG9s4n/rpJ2bQUUjIGFkK9MAji07zV7pmDzz
	G613qt5cPe9zQQrvzu/2f5somHa/UHHhTwA0McZ7XmghcN2xCxwaG7iBYOnYhiuqeHf8j2
	QieSU9bzCTL5OP34PkoO+XO22QVtSbt0gTim3r2TQYbAQbMWQR0CdeuMle49EHZh6Fe57V
	l3Cnft1drmIStHNSBjZyDu1yfPgFgq1PbzJry/h1quTjvoWv1yjPDVHbQgK5kA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:23 -0300
Subject: [PATCH 01/12] net: usbnet: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-1-1eb31fb689f7@marliere.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=IyZ5Y2ln3RlvrkcZB5wxYoE9pnILf6gx+8QtBGCE55w=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNr6Gp9GNDXZ/f9gFTZqt54W8bHuxa5WRwmT
 +10IQuF+3yJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETawAKCRDJC4p8Y4ZY
 pnTGEACcHsdt6a9Y5FfAgBF8o79GsUsKvuWD6AwO8fxF1xsijq8IXzEgayakRi1jxuMExJQSpCS
 ISM72jxPJfLkGTCGYLwaXQfwosqcvOl9wrPMzp12IATU+XnrR1yadpQZq/44LqgNEFXXYzn3Isd
 Csle38sZO51Pe+qP1AAwL+Zq8zsC9WdHkI/ymiHlRrCdzFdGyaZwofjuZtf9/HkaY7cpzou55Q5
 G8Z4Izv2JmWIQygfcJr5OQQcyzgsCsp2D9rLmE3BXKfU8RQZOl2uaMED/eW7z4m0YlvujrZEm2S
 z/8hUyAu33WfQb6Rv/+229jp19oC9kERVHbd3SV6m+KoHuIKdICqy1ICwkVyPe2DpW2ZLr2bdy8
 vvkZwAvTPPAotk843CsLHFOFXdQqpfQEysp5jXGozYuTl0/+iyzONeM+wC/od67xg6/7CuDH4NJ
 N/tOYh2W6RMpiCLDJaLLg+xdZzsUgy4sToMzr6xcPSF+D0yyM7NiQQkXnWHNq/x1bbfibrQ+YFp
 k96qCXv7Ngao3mDdPCinT5jeTmEcSJxfg6jYgeeEH2HjG1v6PZ04oCMRtOMooEIUC3gHF8CPRRJ
 K6W76lFmenl8n55n3zGcQRsWYNVNYv/NCPRwNKg++h6YSR15tKMlUaCakay46OZpqtR8qNbapsp
 Kt3+s3o0ks63iOQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the wlan_type
and wwan_type variables to be constant structures as well, placing it into
read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/net/usb/usbnet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 2d14b0d78541..b21ebe24057f 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1654,11 +1654,11 @@ static const struct net_device_ops usbnet_netdev_ops = {
 
 // precondition: never called in_interrupt
 
-static struct device_type wlan_type = {
+static const struct device_type wlan_type = {
 	.name	= "wlan",
 };
 
-static struct device_type wwan_type = {
+static const struct device_type wwan_type = {
 	.name	= "wwan",
 };
 

-- 
2.43.0


