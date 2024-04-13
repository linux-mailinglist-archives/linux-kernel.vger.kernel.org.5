Return-Path: <linux-kernel+bounces-143539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A138A3AA7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2729A1F21507
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A520B1B960;
	Sat, 13 Apr 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGtymMIW"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1824199B0;
	Sat, 13 Apr 2024 03:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978651; cv=none; b=PDa5JbLBTXDwvWX9AaX9HcfMDVtGhRBMnfEtaKAPkRwFvAYtmanT7Fzd6oMf0cUZzYDJVHG+Bg+84WOxmtucdaWdrd16aZ+ZsN05K9qtiz176eYciEVQrzzEW3Az/kCPF9fZCfaJq9Mzm4Eky3/GCmcWUvDUBgZNztRH6LS/Fm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978651; c=relaxed/simple;
	bh=AiqvAzCdZmU93U4wx1RhK3I9vodLPiAIldbQ/XucqrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7zZbdd5/bi5D8rbfSPmaF4SR0YxVbb0emMDJIFHyLtx2WzPT7lR6D2AnTP1hospCYtYkuTK9sSvcUlc0BH5DKlcid6SVqotn7FHyVEut4kBEFMbiQXWTc27t8cbPPaSg0BZLilFJ2RKoPHSZeFdNoDkEWgpG/D3lrIgTl5q1d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGtymMIW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e0b889901bso13108545ad.1;
        Fri, 12 Apr 2024 20:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712978648; x=1713583448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozBxyBBJq7OruyWEYEy28rKSNAILt5L1T1wiMSJY9pw=;
        b=LGtymMIWZUEfc16UMl+QP+yUPBgRLwXiXWaVchOJ7jJIGAk3NV1jFXagiVj6gsQUgB
         J6kGOQGQbcURGJf0QYMPEk65l2Ev/I2mG8O2Q0sIrRTQLvkNp99kBkruZUW1wsC/7Y0P
         60YygKL1akF+7Zm5+rRN6VFNzN7oOaoq4rwvY9jTzpyw6vq7GplxI3uDdwBRNUoZj1Go
         1/3JHr8rqlIXra/z240SszurigFzGto7D4gEBLE8yM2MkKOvV+0WWZv/+OF/DOEdBZez
         K22F14ZdwBccajpRAv0Hpu+sC+qyTY0bsKuoYzjSMSPPOMppGtZdLpg2pi2rljEDD16e
         Zj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712978648; x=1713583448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozBxyBBJq7OruyWEYEy28rKSNAILt5L1T1wiMSJY9pw=;
        b=jU5mTGhAipK5Lj6B4slnU7/1hVnZ0GIveH6ouKBWz4PZiTtxqd8aVH4OMd282irBcE
         76NPVpU+Q7FylF4atHV/Vp6U4oYFYMYV4iHzmwNFQQyNl4xNCobwkUg8/I8Aii5IWQg5
         hkBB5H3Tpfmv7nUdb3YdbO1Y+id6pZkWDkXC1PQRdjINrvXz2oR7a5jgdwoHNW+SiIOM
         tiIumAW3tn9o/9gHaFrR4VzrvP93p8bawt4TeoPX/L1joNamA59j8U2Hb6IZggY0KIHU
         18qYcUoPohA+VVW/SGizYh93c/Sc3INDNEo7hBX+buC78HevTWp1fVIK78q93QV+oMnp
         dAKA==
X-Forwarded-Encrypted: i=1; AJvYcCX6gHJ/wdWjcAW1JqFi5fDzC1cXytHU8w6rPQADdUAA0kxCPFg4DUbRLUMeAPM9hYStvOG3ru//let2D00J4YuW0cqiPAdWKxNzGz6S
X-Gm-Message-State: AOJu0YwDvc/Oewq8KNRmam1mEvImwfd+rit0wWUrHH527RLKDYaGBkYN
	yjeWWBYnfHMPrgjQO/dJpKmV7ym9dYZ1VqMxhSpw3RI4HsCcp7YZtY24R1Gm/cPFjg==
X-Google-Smtp-Source: AGHT+IH856FdYYPdkLOQ9SECQJqOA+QjP0te72n0rh7fTdw+S0+pdJaJwyUTZVs2XiKg4yJWj2MdHg==
X-Received: by 2002:a17:902:8a8c:b0:1e4:469c:8791 with SMTP id p12-20020a1709028a8c00b001e4469c8791mr4180759plo.25.1712978648249;
        Fri, 12 Apr 2024 20:24:08 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902e84d00b001dde004b31bsm3714183plg.166.2024.04.12.20.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 20:24:07 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: [PATCH 2/2] Add devicetree binding for ArmSoM Sige7 board
Date: Sat, 13 Apr 2024 11:23:28 +0800
Message-Id: <20240413032328.784142-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413032328.784142-1-liujianfeng1994@gmail.com>
References: <20240413032328.784142-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 4bd033ade..fd644e32c 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -49,6 +49,11 @@ properties:
               - anbernic,rg-arc-s
           - const: rockchip,rk3566

+      - description: ArmSoM Sige7 board
+        items:
+          - const: armsom,sige7
+          - const: rockchip,rk3588
+
       - description: Asus Tinker board
         items:
           - const: asus,rk3288-tinker
--
2.34.1


