Return-Path: <linux-kernel+bounces-60435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71E38504E4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D9B1C20EC7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069175C617;
	Sat, 10 Feb 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="W2GxqCzX"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A95C5F5;
	Sat, 10 Feb 2024 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707578080; cv=none; b=sAYu5i3pBybtZnXaj3k8yVCEZxdtWqAQwoAmCrt6BBUP99e+NWLDOoMVrtOLpIlCjz8ShNYto+yxJwKNhRD80Jn6K/iOyPBV2tc3sRcx9dPBdDEGtQnwU9giMUhj2Sn9YlOQP3T4ulo3chlMw0VaoyL+iamN4wyy8NFmRjhAgOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707578080; c=relaxed/simple;
	bh=JoJOoyztp4EgMKE0w5/pYOrwIDStyJc4o5zoKCZW3wI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQF+SrDnGZBOKHPldP5drA/Jdfn5woZ8FSvau3n/fpBiMssrV26Gx89XHyMmITyskMFXz0E2pNfhpnDWdRxpdcjJ8U/eTYcy+YZCYAJQG1bXBR2ehZ4x05DVaMqG1KC027L7bGB3DQuQqOC0lA1JHo+FVGzPudshr4d3rAxoC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=W2GxqCzX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7232dcb3eso16228625ad.2;
        Sat, 10 Feb 2024 07:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707578078; x=1708182878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NX4kPnkghriz8C5dtPzUceyYxZS8GIQH2mEq/Ym7Bqo=;
        b=mZ+YFD0J8Dxvc64Rtvmlk9DjWCqHZc/hjENDKopcYphZ4EOpyOd91VuIARt1BOHHZH
         lTxPotL3rJef9grbESbFcFgf7+DRtWKZ6ugxDUApk0u8MQgQqA22O8o7+M4cFRomsYnN
         Xa+LWEPBjhESlRwSYv2wt1OR4FqkxmoYiT4BIn30PJZIrXHSvERniVhyasZZzJ4Ci6tJ
         k31Bo2N+zzKNzLq48UAQD4+2dKcpz7/DLKxIeG6Xc9vkMeoCb+yRuSkEiy8vFKOBwuOv
         B28uuAjW0fGhTtltmeTt988qz0Pz8MsZizvs+XTli5nhe1hvC1N2rJnKnXVx7zklFbmq
         7fTw==
X-Gm-Message-State: AOJu0YxaIh8KxcpEWgjogKtujFFG173R9ox3Yi4WRolL5Fmli4NXwu+T
	3yr03zYrcy/icbXAAl2XDFX2zEZQ6NgAv4hTCpmVKAtNj7lK1CRI
X-Google-Smtp-Source: AGHT+IFAP0QV8herioTGJnS27l5EnvuvPFPk0kM0tZefy2wLgXPDEQyAqXRZLep7ilAe1MHMzJuo5Q==
X-Received: by 2002:a17:903:40c4:b0:1d7:7347:d80e with SMTP id t4-20020a17090340c400b001d77347d80emr2526076pld.37.1707578078086;
        Sat, 10 Feb 2024 07:14:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV39fp8PQTzcsikdCZCt6bed5TTjnqQFJ76j1TZJmRF/7uoJmgtpxhg75Jgy13xRQq4nCyu7dmapAScGdt3O2IO2+6s8PqEpzXeIfmgDye20I/inbBE30IWv+evM3PKVj9GwVOq3OJOEw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kp3-20020a170903280300b001d8a5c08277sm3151239plb.260.2024.02.10.07.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 07:14:37 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707578076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NX4kPnkghriz8C5dtPzUceyYxZS8GIQH2mEq/Ym7Bqo=;
	b=W2GxqCzXO8zzIE/IuIWyMRqLULmxoXdB+qFDfqApXPAaPY8CY6jxlvEVxY4s2AgMSLhyR4
	U5eO/rrNXhZ19dVEQhAVKsEOMCcVMVSwnH2eZBOSCaRZl06GpzgJIjH0DOlErtmkPyt020
	lR7U+DFjbcEqbWucgcD4fDaBCzLvvZARSy24OTOxyfMZ3cHuDEpOnsnqEmpioq/m/2oGZZ
	rALgpVRYUCum1xjh0lNoHcceZkPmpgTluTKbFmEXLKGP/9BRAGLhPIdF+uYu6yu5WPcYUg
	lVJH8w9dM+LdBLAR9Ku7BETJMgou8QRduIFGs+CTMfpCD7t79luYp3hEcOALRg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 10 Feb 2024 12:15:02 -0300
Subject: [PATCH 2/2] Input: serio - make serio_bus const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240210-bus_cleanup-input2-v1-2-0daef7e034e0@marliere.net>
References: <20240210-bus_cleanup-input2-v1-0-0daef7e034e0@marliere.net>
In-Reply-To: <20240210-bus_cleanup-input2-v1-0-0daef7e034e0@marliere.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=JoJOoyztp4EgMKE0w5/pYOrwIDStyJc4o5zoKCZW3wI=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlx5L5DNW883c3i//px5uQLulX/pacA+WVTN1VV
 MwzcHOG0VGJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZceS+QAKCRDJC4p8Y4ZY
 pmsYD/wK1YmO40D0PMDD1RYjsRNU20uSX/MD6Op9yUikmaKnAaj417aKLdjR0NVC7JxWHZJIgm8
 i18kvg79pp7UCKhG6dVdUfrFZR6OCXlaJzCPxZnt06dKdaWfrVOTGrwqwOU1G9Ni5WNY7VKNNPD
 CCtmd4uveTxIxuZsnAmy2laWHQfI84H8s2a7Jx+bHeiU/qwSmEcpKBnQAXdzN3OnNFLSzUCxbJ6
 ylyQiEmYNfg9O0KCBqkv1u+TuFbDxU6ptQ2fhlDrzl59dBlWpJ669phEocfcoKXx5mO12NDERf7
 L3DZCDVAUgF71Ocx7D93W9UWD8Ppnau+Cq1BkAQ5rqV8j4meAWYuYEaZTqQhMuDDFDkwNCHOnx8
 AuRCgnQpIm0XWKIwZML7aSXxItYWPKtdCe78xh9QGOlY3f0S+ZtHwWnGYhJx9udIvaft1PlhiAP
 hLvJeW74MqRQawuJxzndFtTIDOpOe8evkyi+Xu61jgju5NEw++QJoK+ofVzjEKi+r1AmyA1ujxH
 w0uF3iF2uDeKojv862ecADb1pN1mUqMTe3aIvrXvIAkaya58m2Oz8Zbvj1UCxwgVbSbbGQUaXgg
 QbB3tjBpQGt1NamzoMNyqVaojo3/rNEuq/OG5VH211vx7Bml9KGO63Yk2b/vKj2VHRL0G4QYkYg
 fbBHstPTIi0OiPQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the serio_bus variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/input/serio/serio.c | 2 +-
 include/linux/serio.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 767fc9efb4a8..a8838b522627 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -1007,7 +1007,7 @@ irqreturn_t serio_interrupt(struct serio *serio,
 }
 EXPORT_SYMBOL(serio_interrupt);
 
-struct bus_type serio_bus = {
+const struct bus_type serio_bus = {
 	.name		= "serio",
 	.drv_groups	= serio_driver_groups,
 	.match		= serio_bus_match,
diff --git a/include/linux/serio.h b/include/linux/serio.h
index 6c27d413da92..7ca41af93b37 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -15,7 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <uapi/linux/serio.h>
 
-extern struct bus_type serio_bus;
+extern const struct bus_type serio_bus;
 
 struct serio {
 	void *port_data;

-- 
2.43.0


