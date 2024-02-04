Return-Path: <linux-kernel+bounces-51787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B4848F4A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAA6283B94
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F623749;
	Sun,  4 Feb 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="cbsct1H+"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F822EF4
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707064307; cv=none; b=GQBzifrrNkRRP1ZOmvXz4tUCoKoGxhxNj0TohzxrQf2qPfnpIQrsGHLZmY4CaDsfh7tDKXFfD9DgLboXO6aDLIM3e/ManKjCxk7tJ7f0NsT78nj1wDbeFA4t6i8E7amImpWKXVZYIVm5dgKbnymGhjNBTVUdJhAhWyAZKBiEQ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707064307; c=relaxed/simple;
	bh=1vCWtqB6ylOUUALqfuFHp9gDM8uqiKTAT9Jq9akjcpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sBSWvIoX5xwCRcNV3GbdyyK/cPEh5zHGqbp3J21HknQ6nNi4Spciw4FBARtQ0T2xReVm8FeeIrKbh+PqXTAa+xWimU83fBk3qG4xNLIGL0b51zw11n0WSS9H3DRRTu2+yesRYIdX/DW39Wj0Z0OjTPuopsXA6tA7xHmjQ+YgQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=cbsct1H+ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7858a469aso26170805ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 08:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707064305; x=1707669105;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNhSAcOQsJgzxt52AFrV6cIjy7K7mCwx+eGcq1tfVTY=;
        b=Pq6bZTin+TD6klt9HaRLMECDTCPX8ecMsxvlkjNwMRKDU/wX+WLJtchk+dbOI+V9Fu
         amzTEsBHz0grteQZg38HqSfJBTPfWB5GxuGQwIToU9Dl89lYGkuyVW9Hr3N6SNRBdCJT
         R2IMKnbQs3BRx6vAjc/wxZ1/VRNOXMk2GGB59aqumHCUYxMaf7TLhBiZ8sOXGo1WFfMV
         //r3kGVZTqNFyOqVsbWdz5f9njst3MGZiAF3g2Ytt1YhyyhGY5jUOMftlTKwB+JHbTJu
         AXUbNNmL09/SEV+2Hkp2jBciB3qit9Zgk7j9b51wcDyPxosk9y3pH7R4lBbuNz/5EpY9
         uHcA==
X-Gm-Message-State: AOJu0YyjrulMrNWcb6Iu+5b3c5MSLphSfHK8usxRhJneHxY+0SAchGdn
	dIbZ4ompphCGSxwaMQ3lK9XF2iw1mkXLWEGUzwaoiIN+60UFC3fl
X-Google-Smtp-Source: AGHT+IFFXzU/1GbmPmeLTmOTZ6yyEqMeLu5u+GStqUPtLo/TcDGkyo8gnWjxkzmNTiFrahnyHENf+A==
X-Received: by 2002:a17:90b:357:b0:296:37c7:3b6b with SMTP id fh23-20020a17090b035700b0029637c73b6bmr6387497pjb.2.1707064304701;
        Sun, 04 Feb 2024 08:31:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVL8oBMiXRE28I9z0RYp7DMI69Cmda749qFoQca9lpG/ctgRv52RZYxchbRK5aI1mS0cMWI6i5m4nCOphEm2KAQUkgUKXdz41YD9A==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170903088500b001d8d1a2e5f2sm4713157plb.216.2024.02.04.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 08:31:43 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707064302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XNhSAcOQsJgzxt52AFrV6cIjy7K7mCwx+eGcq1tfVTY=;
	b=cbsct1H+fF470xncsGDJU6p5IMifK2Yc5Xp0PmFluBsfr1/JVy4dow9NIlblaosAPSWTnF
	09p3YXu0/4AkBt+Aql5gTIa+629hkRSQIn43nP8C2obify+4NtDI1ognSotQn8FdRLAwjO
	fWTOCBV735iUmOrhcJi0JPPUPQXdCRhhFGJfNpKspidqbVsWD503eBxcdM6/gvz+EXoyFd
	dHME307X8Sk1+d9+1cxTWTyCrdQ02A0DiE9tAUNOov+rcRtwFHUYtT/riFVdslt18YM4J6
	RkMbreFaVrUkhnZKrbXgsDxYu5JbZwN+9oDt+e0Trbe4xVxbBmL3/8rGfSE33w==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 13:32:13 -0300
Subject: [PATCH] hsi: hsi_core: make hsi_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-hsi-v1-1-f9318131e842@marliere.net>
X-B4-Tracking: v=1; b=H4sIAAy8v2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMT3aTS4vjknNTEvNIC3YziTF1Ly0Qz0xRjY/Nk82QloK6CotS0zAq
 widGxtbUAOZpSjmEAAAA=
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=1vCWtqB6ylOUUALqfuFHp9gDM8uqiKTAT9Jq9akjcpE=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv7wNE4d5I0fZMJtZNkFvHsjD8g5XL0GH8HguA
 5tqfSTzFPiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+8DQAKCRDJC4p8Y4ZY
 pvd0EACikbxBqfUmQYuu9co0zY1N82UGTzjuk1O2HWaOTBx7qBCyHmacCn/zM7VCgT/ZsedGjGx
 GSknp0XSgfgiZyzIqW79oAi6kMpyulwmaTojWj1KSEwFkig6JJ3vIQxQlANwQoGKdBixhMBmSAs
 9oVCWO0b7eRfOq120B1YcIx38WTXkrA73kkpCKrlJgFxCm6yO9slHoaKhC3lXWSUISgjQolfLFS
 aQKt1AM9jhKglbgM9BuTwk06ddPcTv2S01LFmWyXLxvsPX1r+x0t0lXBMJarWFIcFn4FE875IxD
 s4ZCsJJfIKClldvjzewrWiktKv/JQc4uRip+DkHBfV7F6JJY/9oXNn+Ty3FIMc8vNbXQkAdcxMx
 W8r3nuXBE/7j9gYrwLZoAGNKfccRcKWnZxVc1FowCcX7l8+taWAqQF+plRl4Hiurz9RhfJmlDLg
 meqN8vkRtACwKdID97Ts7S/IT6tZuSQ3BAaJgbD/r+nmvaK3YvpTICoaJsK/4IjX4wpZlgUEDin
 Cmak8gFh+c8suOWQnWkNSPQiaSLHpUiI2BGup0U6gRPTxlNQv2jrcFyz26p9Qe8o6hhfWkBS9al
 Rrs71IM9fJ7cx6F4Tg3NRwRu9j71BiI7CKWG72VfGHt+/TRQeAlnen++XIs3EzkO2dRhSwDTEta
 1YFdEqWmgW7rY/w==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the hsi_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/hsi/hsi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/hsi_core.c b/drivers/hsi/hsi_core.c
index acbf82f755a8..e3beeac8aee5 100644
--- a/drivers/hsi/hsi_core.c
+++ b/drivers/hsi/hsi_core.c
@@ -48,7 +48,7 @@ static int hsi_bus_match(struct device *dev, struct device_driver *driver)
 	return false;
 }
 
-static struct bus_type hsi_bus_type = {
+static const struct bus_type hsi_bus_type = {
 	.name		= "hsi",
 	.dev_groups	= hsi_bus_dev_groups,
 	.match		= hsi_bus_match,

---
base-commit: fa72d143471d04ce3055d8dad9743b08c19e4060
change-id: 20240204-bus_cleanup-hsi-99a65d337c7c

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


