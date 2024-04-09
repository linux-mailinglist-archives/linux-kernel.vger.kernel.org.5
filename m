Return-Path: <linux-kernel+bounces-136604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D289D60F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B11284C6D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEC081754;
	Tue,  9 Apr 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T08Ib/L2"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951280622;
	Tue,  9 Apr 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656608; cv=none; b=HSC9d44LUr9pIpyU+Q52V4WMkc56JQcdQIX3dh6D18UVNjlH1jl9H8I6+caKMXmgA71+bUdn+k1vMle4prO4eZPb2mvgpWNiG/wdhIHPpA4YPEnqSNWIZsvZdG6K+yQZmSzM5AsMPeNYacZgniY4le9HqJFyMamsAwCGE7WtHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656608; c=relaxed/simple;
	bh=9lxj8u4aDM7kKtk7HKEsPhYcu6NOgcXgkGng+hS9kkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T/x0B1PcFmdE8qnmr9n0/Uj6WFZ9IfBuTwuALt7XzuqGObjuomkBHbciOeJnPStOQdoxgYQEjEQzBvHVV/fuRG4LL/N3oK5kx/KMSdVfR1FplPq5g5C1hMOrCaErqcG+7UZbGJaSTfkBwJbtlMyv87ZXND33yYONxgzHn0jpIkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T08Ib/L2; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e4f79007ffso3613250a12.2;
        Tue, 09 Apr 2024 02:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712656606; x=1713261406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=T08Ib/L2HFGzeGkMEqbNP9FgsWSLGbnU02bNqjh7ieV4HKIbkaUTFSxSEvi93C1AnZ
         kMbhr3A2e345Y3dZQW6nqLcHOY65hvCjY1nHGQuVPDaxRCcy4LYz/oLyFt8f3QCP83bJ
         cu12fdUgKWRjY3b5MPIpkQd/5vLj+bcCCd8TFJQOfolp7n7iHTL/FMdM6+x0s8tF/JoR
         7zDpMd17DGOygErOQYsn6wmrAo7YiGdMeQqP4MJF7hQ/Jq5MGWJMy2P+VfS1V5d1t7WL
         Is8wKRVtJraEOqbrRAifb57PsCui1niywxn67vd8prO+Fn/AjnPAgpeOw38VDNYID3zQ
         A2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656606; x=1713261406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XuZnshTHKl9Tg/cmKKixm6682TVpUXXm5RT75oPZP8=;
        b=FB+SpJe3icJkgYFnq7HlS4ZoJ6/XKStbtgTLlMWLAUdieYgAyHCX0hiDmOGIjscTRO
         YMxvpihSs++6Hxkx6tqD+k4xRE7xrugym9L6uXfQY1PrkpGzOLrQQIoHb0tZuaN109G7
         RAjZXCxvByTC0DRxQt3XVmNkv7dPtEHr8sgkMTNabhupk+Km2TJo8Fp1ZlrnlKbtqvNO
         Qox+wvLo+gUwKikhwiy4dCUzsKpiN3ddgDZFLdF6m/InVcQnP7qZY26IclX+KA65sOtG
         oKgDITKlC1gP6DDh4kT4FJbpPw+4AZDhQHvMz9VirPokru4nVNRGUY20y6P/w8A6UtHm
         RMmw==
X-Forwarded-Encrypted: i=1; AJvYcCUbu07gVBxTqvhvP7DUHSrwNy/5arFpQjszuY21+7fxgaqVv6HlO8kH7XhkCTSYiGXu2JqS/EVo3cQ5AUBHu6luVsIjhNMv2UtFLGu41FvWYShZr6eK7snkAHHXHJYSuSbNDrKF9RM0egT43hjWyPSSlXEjgiWm9GbdVYDwNO3LdjijkW4=
X-Gm-Message-State: AOJu0YyTPoFx2qTiyTcJMQvixA9J2TmPKHWqplI1y53jYgqnKHSttQ72
	ugDFVdXuyqPB2kR4OlhzO0A7WuA9pK7WL2scqOcuAySw7GJiqLly
X-Google-Smtp-Source: AGHT+IHViuFqPmChUukGGn7/H3AVFC64nvRCInvqXsGFSU2LJZsPlYUPv2DVcpIpgny8uxgGDdJaWw==
X-Received: by 2002:a05:6a20:430b:b0:1a7:a6f3:1827 with SMTP id h11-20020a056a20430b00b001a7a6f31827mr1668768pzk.46.1712656605656;
        Tue, 09 Apr 2024 02:56:45 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902d4d100b001e3f1596baasm5100445plg.298.2024.04.09.02.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:56:44 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	j.neuschaefer@gmx.net
Cc: linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/3] dt-bindings: reset: Add syscon to nuvoton ma35d1 system-management node
Date: Tue,  9 Apr 2024 09:56:35 +0000
Message-Id: <20240409095637.2135-2-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240409095637.2135-1-ychuang570808@gmail.com>
References: <20240409095637.2135-1-ychuang570808@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

Add a compatible 'syscon' to the system management node since the system
control registers are mapped by this driver. The other driver must access
the system control registers through 'regmap' using a phandle that
references this node.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 .../devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
index 34c5c1c08ec1..3ce7dcecd87a 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     items:
       - const: nuvoton,ma35d1-reset
+      - const: syscon
 
   reg:
     maxItems: 1
@@ -37,7 +38,7 @@ examples:
   - |
 
     system-management@40460000 {
-        compatible = "nuvoton,ma35d1-reset";
+        compatible = "nuvoton,ma35d1-reset", "syscon";
         reg = <0x40460000 0x200>;
         #reset-cells = <1>;
     };
-- 
2.34.1


