Return-Path: <linux-kernel+bounces-75845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A0285EFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC921F231E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396371772F;
	Thu, 22 Feb 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAP38SUO"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B081755B;
	Thu, 22 Feb 2024 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708572315; cv=none; b=IL3LT0+krooHSVcbWi/l3/046ZVfeNezpTp/dhKTdXAarhRPTqXzphjNvA+nxvaDPhkSHCPaBQk9vVPSb2vBa4ZxE51Wv8T1c4x7RQcz6aqYhBDvL/CZG8fx83hbJjOtDwl88O93Am3mItgbCmi9O8VcSeVSMrkWq2HbuywhN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708572315; c=relaxed/simple;
	bh=LbLLQRWjAmTW+TCrAgKFeNWDqld2wMMlaegq1z3AipA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHb7OoP+QE9qanMXDt4IztvpFbOTdzHm+Kmk03RA2KHIMzz9lyomcUa4a+yuLiC2Syxgv6tbUMbLdkOklnet/6sN9kKSf+brdB4tESvOxgZ6FPFi+dnp6kBeE1vcZv37JLFUbKTIjMWcGm1O4ACBhRUfVk8To11Y3jCHsKzumVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAP38SUO; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d7431e702dso73130785ad.1;
        Wed, 21 Feb 2024 19:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708572313; x=1709177113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJjLHFzHOOxg5aRXQc96zwBJZ9WYrMKJ+K0shUjS2Ls=;
        b=iAP38SUOd5o0MxEZmRUOaACmWwdT0gjx/BFpchD3aYwVkfkWx4FgUrJCRkfQM10teG
         sj4/ZewyTYkOEhQRo/w9nuZl40B9KlhKPZiGZmwoF1TMSp2tn8kiqT6yr3PIK91gPgz9
         6gFASbGasGDWSvmUjuIli5Wpj/xbu6V+l7CWYZCIXNFg3/HzETVUe1eVRkTu7/I/cc8U
         URw7cvmxLffNE+Ppx1vkME1ito//3FRDRbEfSG4N+ZocDbeCZmnB1e/YeenkbLBQGw56
         ccECiSyu7KFDKlEzBxum7UHPGWh8LB7Z7NxgToSDIvlWbg5ufFFMiazTli8HEO8gcQcR
         79og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708572313; x=1709177113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJjLHFzHOOxg5aRXQc96zwBJZ9WYrMKJ+K0shUjS2Ls=;
        b=nAkGIY7xqm0girsCumoSAuOmFq+uPCNw8QEOqk7t59AnEMO2xTTVAwn7zVamlC9Alm
         n62XCN2GZunilzNuQy4YMri8OJYoOAJbJRjL/b8I6e4rUsdAHYfkmL/+VNPbYDjxNCo+
         rByAJxGtMhnVLMMpwKkGx+6OxOuGO4LM1mhnlP1KV1rp+Ic8IQUePJ+jszrt7HyTbvX0
         uJ66+A1p34EOdZxl8Adry1qiq7xqJbo3tI95zQv9sEo1JFqehz3Roq8ltKFBuW30RiDD
         MRuoGH0Akm8/L7xSxyZPRSWluQ89767WKH9kUUHtaqdjRb6DL4GfV0xJ58gW/P8wP3Ao
         YvcA==
X-Forwarded-Encrypted: i=1; AJvYcCXvsyFElRG6WylO8EqeZKjMZu9KS+om3jAq73WXflvm5XemjMw7VtlI9TO/JYamNwMjUwGNH61WXFHkQKZwHTBE7DFF+jsRn2UY8Me5mpbK9RfO1b2jtNjxmCQaUysbjchYggSTHJWPhQ==
X-Gm-Message-State: AOJu0YzISj8Atr9iYLNCiZUN/5EL/L/hBYMgps5Lq1UdgHJ1niq9sM2j
	j4AzghvEL6rTO7wsB+y0dgKGKKpfG5j0L9g74SJ1vQL6qCx5gceU
X-Google-Smtp-Source: AGHT+IEG/CFzCGbmOpgJHBmhgewL9gM9hzsrOSEcXfQgEffeWwtQjBoIKYJQnj72kGXSs/nyQbdZKA==
X-Received: by 2002:a05:6a20:c704:b0:19e:3a9f:f925 with SMTP id hi4-20020a056a20c70400b0019e3a9ff925mr19940646pzb.14.1708572313445;
        Wed, 21 Feb 2024 19:25:13 -0800 (PST)
Received: from localhost.localdomain (125-229-150-10.hinet-ip.hinet.net. [125.229.150.10])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902f7cf00b001db4433ef95sm8781580plw.152.2024.02.21.19.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 19:25:13 -0800 (PST)
From: Kelly Hung <ppighouse@gmail.com>
X-Google-Original-From: Kelly Hung <Kelly_Hung@asus.com>
To: robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kelly_hung@asus.com,
	Allenyy_Hsu@asus.com,
	Kelly Hung <Kelly_Hung@asus.com>
Subject: [PATCH] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Thu, 22 Feb 2024 11:25:04 +0800
Message-Id: <20240222032504.1147489-2-Kelly_Hung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222032504.1147489-1-Kelly_Hung@asus.com>
References: <20240222032504.1147489-1-Kelly_Hung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3ff8..60a494b7aaaf 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus, x4tf
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
-- 
2.25.1


