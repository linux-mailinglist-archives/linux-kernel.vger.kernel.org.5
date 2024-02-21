Return-Path: <linux-kernel+bounces-74426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048885D3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F7228584F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627E73D3A8;
	Wed, 21 Feb 2024 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL2x4LtU"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E613D96A;
	Wed, 21 Feb 2024 09:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508495; cv=none; b=PmcYFuKtO/A3g6GY4g5xSVsFZHoJCPaGrCnGozqlpXpQ6/BtWIub10SZpvTh/TaQo2jItl6uuAjEG4YHcf8Y2Vc1nb+NjmtUGIj327vDHW+75YN1yGcN2K2csbCqiHm4JJDADiuJpumHF9vUgIzgDa7/hMlEKy4N7Pa2TeQNmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508495; c=relaxed/simple;
	bh=7sp5OIimh+NGxS8fpc5RW5A865+3zGI6jwHVqgoNhRM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7S1uj9BwtJFTrfNQsSy/jP6feHn+R8OzQ6d7hRZeIxRyv57sNDWH9VkoaS8Osc7De2KzyXsnbitJkTi+zXXMui0MuGUfpgm7YMjkhw9bDTPvkd3J6wdbOqfwkwGLe3MRwwz4vf7bBnRkkJagp1rCDAF7wKKdpcfnWJ3bw1XhEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL2x4LtU; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c02adddb8eso289533b6e.0;
        Wed, 21 Feb 2024 01:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508493; x=1709113293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=cL2x4LtUSRzVXLos/FRwIK/nvkR2f4NPeFCbha31yavKt6vloRljd997EFO9V9pv5I
         HjK26iVqiSLWMvl4s4dXRrfwftA5iCa2UQoGq5dx+ZhW2kGwHlVjWWJ2gDPluqwWAF0g
         vZNX2R8R/+ODxxbvplioWfU+NE4nu7uKTKT6sPEITyCcaeIS2NV/BWbUrPqxIKYhYkfo
         +QTXQUz8oEsx7R6ZTncbanIPYsvNYTTlbKy1VfDr2xEZlTbNlO2xnRqy2RHPcu+lA2fu
         I2/4ymtfWpFz+dkldq/1SU+92+i36nwtfrM/kgMFxUqubCPK7AOW07botvNcSTKAQjSY
         u6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508493; x=1709113293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=cPH+XAP+1L631WJH/CQ80MOIhxSaPQ/YYBr9YO7AykzzDUe6o36qh4OKx3a5jBWn5q
         qb37Ee5QOYWHxQtLzBBc71+SaE90dG0iwi8zF6MQVAAkFkDtlg8hQv84MMtjTcUsK9Bb
         1wMb6IGs8t5misUg3IjpJzTVRrVZaoMb2R/gKDDtOf0pqf/kpPqHvUzH4gzW678YYD07
         evMytcOsaxcOL7q1eVlBURNcZtXXQk4t9w419oOZvjZ55otabrqR8wD61+ht0YF6sbIH
         SHdQfaNl3NfZkXsOLza111KD4v9zhE7FIrR0ciTsheCxfnfsxXHLu8pZ2+mwaKN9u3jX
         VqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYp2vYKczm4kXY9OS18lsdprxa1RLaj/AUO5B3J3fdGsVu7DJYLFiSvQCcNJvPubi35RBL1eH/hao5H9fNBmzuyLUvoRmp2Rw5lEantTVVmCQ68e025DQUf+3173W3BVL1HudF72U/Qg==
X-Gm-Message-State: AOJu0YxZsk+A/ZLFe6p/LJ9pYH7suoNve94WwHccq4ZDJU9djxxRBNE9
	6vg28xB4tfvM/6gCfaTbnpGBcOQ/e5FD2slCRJxQzZd4dAGV+BD8M22rNvC+
X-Google-Smtp-Source: AGHT+IFC2zgBN0UcD8wSEP83Sn9N8sisyohWaovgJYqL2xWu2TfI7wbcUFKafbkvIvCX7DRAyIk9Lw==
X-Received: by 2002:a05:6808:1891:b0:3c1:3f1b:ffea with SMTP id bi17-20020a056808189100b003c13f1bffeamr18441893oib.47.1708508493376;
        Wed, 21 Feb 2024 01:41:33 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:33 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
Date: Wed, 21 Feb 2024 17:39:17 +0800
Message-Id: <20240221093925.2393604-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change routing to match SOL(Serial Over LAN) settings.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 8a173863ef24..a0056d633eb1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -12,8 +12,8 @@ / {
 
 	aliases {
 		serial0 = &uart1;
-		serial1 = &uart6;
-		serial2 = &uart2;
+		serial1 = &uart2;
+		serial2 = &uart4;
 		serial4 = &uart5;
 
 		i2c20 = &imux20;
-- 
2.25.1


