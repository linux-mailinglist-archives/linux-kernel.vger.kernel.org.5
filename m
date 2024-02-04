Return-Path: <linux-kernel+bounces-51871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 692A484904B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179481F21EE6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 20:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C342555F;
	Sun,  4 Feb 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="dcVIBsVi"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DA25543
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077406; cv=none; b=k4cjOQmT0QNZWS6IhJDfg3MYxhvoOe5Gb8OfcihESLnkFoj2aF2TFNqdfD6prxYxfcy8wrDguHHL5TDkLTfeGOifImnnONRe1/gJYyPYu+QHu38lKFQrCJNpiB1L+2XuSAspI1B10gYyQRufn3nnwpel4TnVXK7RsZJsMEkypwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077406; c=relaxed/simple;
	bh=rp6BrHbUTj7pCYyPa5XTwBQvwM3i+x+nTpk7mE2FD+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WP7sn+qPBKAlWTMzz6pnTckJTj/zvQSO8m2ImdU1bJmhfYWFPzxaRvWBs85oxZJ9ZhFuCrIV+eFxpwqv3CC4ih+f76BNvo4HBs70572rSYVdq1yJp7IYXm+jxgmsJ4j/gBQLZON4o11aPkAyJjTX2dRax8b0ScM42eWgE31ErBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=dcVIBsVi reason="key not found in DNS"; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e03ab56e75so202479b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 12:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707077404; x=1707682204;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz7++Wc5os46epF0VhXdCHXFaDtkArdzJjjj1GnlM+U=;
        b=ws8iZqx1eukjfmH084YUlX2A6M/QMUKENXUhTrgPepzhy2E4GDN9Ym3VzEhEtoYNPo
         QZA5sXyFySOL4W+6MgaiHrw5/Uudrr9AI3nJ/mTP++zUvl1+qOaMvW97+YIvsduQ5RL9
         uiXsZn7hMsMoCjy8KVpb21gkEhNXqy+01ha1UTltmLmF71Q4TSfaKrSsndezQd974MCE
         1Wz0XPV3eam1V+wYUU8zJgMkwEz5gCQNBIzBOfyo52fACg0m6EUvV9ZYNzq9sFY5d9EF
         LYmM2TBGOsFWvUT2TNto766fI2bKhMbPu79XSUi/3TrQ2IFt8zb3AdNuJjARc5bbcvGV
         QdOg==
X-Gm-Message-State: AOJu0Yw+cQqHfnykELEELnosTcy35KVwWSFUsWlO+zy7bfEH8u0uf5sj
	ZTcuEa0hJGBdDcdL0CLFLqHjVXjPFwqyL773wtNXTyLDwNZ0BSh76WhTgMtZWz0Uug==
X-Google-Smtp-Source: AGHT+IG77hW/AbBDfT9Wc0Zq5sHU4o7G7MnA2xBUubZ/aqSTeitdrYfW8qi6/4T2oTAJq42Ksx6C/g==
X-Received: by 2002:a05:6a20:da83:b0:19e:4ae4:7b63 with SMTP id iy3-20020a056a20da8300b0019e4ae47b63mr8158834pzb.9.1707077404490;
        Sun, 04 Feb 2024 12:10:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2vMXFLV0owJLRPaFDdPcZEWQ+FOmJYShQ6r+jKw+hURR0rs7AgGXJ4H40KPCAMwh7TjVFUUz8RVt6f3ZzrHy7LKYtXJq3hWC7Lw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fb36-20020a056a002da400b006de39de76adsm5082421pfb.139.2024.02.04.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 12:10:03 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707077402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iz7++Wc5os46epF0VhXdCHXFaDtkArdzJjjj1GnlM+U=;
	b=dcVIBsViewEvpFaMRjzmaf3M8xQMC5sIcHPlsT2iJdD3usUzZP7kcl0wW0suB0xum/o0p0
	MJ821sn+mAMjWrO/GmZeQ8xrpFiEpHfXpd3u06msntzjV03kAaufdOkpSlkVEtU7/QwJcn
	l8mV9k7Fsebbce/Oxx8IX06blga/018zSAIbKSdQX+3Q/PQFqbqq9e6IRxAXMShVGEeIxF
	30osKLBO4FH4WRH6SAN6mLj7z/Gd5MVIZsymbw5fqi7j4OVUeHm0V88/MJUu7YfvvaGQcw
	XTWMCD0jhE38G/9c6PQ0dRDC5KEqA6y0FmzaOeCUyipZAf9vY6wmzmNsUSQ3rg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 17:10:32 -0300
Subject: [PATCH] mfd: mcp-core: make mcp_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-mfd-v1-1-07335ebc034f@marliere.net>
X-B4-Tracking: v=1; b=H4sIADfvv2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3dy0FF2ztLQki6SUpFRD42QloK6CotS0zAq
 widGxtbUA63mBUmEAAAA=
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=rp6BrHbUTj7pCYyPa5XTwBQvwM3i+x+nTpk7mE2FD+4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv+85L7mE+hjXake6whYcDC8/hhM/2DuWKNRrU
 1ZnGdI22+eJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb/vOQAKCRDJC4p8Y4ZY
 pkOXD/sGhUH2xYU4plHDUluxz9M6UsWlH+GxxFPpGQN4UbcBcNz/tp9MZ82mCOFdLO162yziB3k
 6Qb/kvu+5tWX/bK+iGHkovmAZIrqhajqqD6xfXEhjADqSh/UDfa/+Hp0AsIJRy+4Z9BD8RpbYtN
 CtySb2WHuqJTWPRAMiIb1Icp4P3S/FECEKxjxcwv/XI4kPQO6909VzhGm6elDKvvfXzxhNfae4Y
 lWXdXPvKvj7+gupzbDlNmPJ8rjIUxkOLaNomxysreJ5IWMb3dPvI7gJCSsV59iBxnZehSQ5XARJ
 vC7GLrPuzboUFIrwol9TuRbdjHnH9pgj45jWDsJDK+dTbxguLGCF21oN/Ir9UOMrylIoYIVnaiE
 1esNqJFJ8tYgHUFZXrRAvN54BuIOc28ylNqQa03uszAAz7nsjyIFXcKhxkYoZj2OlqykwWxqzxM
 QZoY0zbK7QMEooCcAcSIsW2EjX2UIkk2pletGoh5sV4JkF2QHCGgH9/ArEiWUAlRjJWMe9oBhXf
 mTGwqTeopJi4d8xIJtpbAkHUDWhCWKgiNB8O4jwMmcKdGf4KtkWZwr4b86X6JIRoz3XVfkhxDug
 HjNi5Bc2/gDMBznfDjCW7vkAeo2+EFuhjgwZTDQ2kQuoZqP/H6GZ7a2bQU9C7ZQaqQYEG187bUx
 qRm7fZE6/ilYe1A==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the mcp_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/mfd/mcp-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mcp-core.c b/drivers/mfd/mcp-core.c
index 2fa592c37c6f..16ca23311cab 100644
--- a/drivers/mfd/mcp-core.c
+++ b/drivers/mfd/mcp-core.c
@@ -41,7 +41,7 @@ static void mcp_bus_remove(struct device *dev)
 	drv->remove(mcp);
 }
 
-static struct bus_type mcp_bus_type = {
+static const struct bus_type mcp_bus_type = {
 	.name		= "mcp",
 	.match		= mcp_bus_match,
 	.probe		= mcp_bus_probe,

---
base-commit: 1e0ea9e75ff3f395ad6f85f0be2258ef114a53dc
change-id: 20240204-bus_cleanup-mfd-6ffb8bdbe13c

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


