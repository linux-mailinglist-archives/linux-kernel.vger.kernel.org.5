Return-Path: <linux-kernel+bounces-152109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F798AB942
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF11F2148B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9474CE552;
	Sat, 20 Apr 2024 03:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3YnnYN7"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839ADDC1;
	Sat, 20 Apr 2024 03:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713584677; cv=none; b=HHs/9OnaPWMgAn4jOSGXaDCs1v4RqSBIbmH4GYqKYXkWtjbeZEmSvbmOE+NLs8mSmFYVOni94At2QvCet6hoWw43zwTzAnCXhe/6sHgcjyhD0bGKPbtyaJJteWmog+TJoq+ei5bGXE2vijoE2HIdQ22VQuu1k8gH6q/6dPccUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713584677; c=relaxed/simple;
	bh=0iz+2Q2DVVH8pk1kqNbpLgM1V9zkclR9YxSTB75ru/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIbLEgCqxxbrufH+9j2ec9GJUQYBCl72leYa0mQhMhzjfdupdZt9omT+h4xKbMXWoq6G9HQBwHKAyJlo2o4SnJ8skwakDl87y+YDDLdM2Qz5Yrz5Dmb0umWwnahJHT1/utqxTjFalZqvn8mKxxsBJazGwyOmfe1L+8KXOEc1QFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3YnnYN7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso2589104b3a.2;
        Fri, 19 Apr 2024 20:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713584676; x=1714189476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWK9lHXVifGzKZL8qjW3u1qt3v5nGsCI1LZZqXIQODw=;
        b=L3YnnYN7+BDIxNe1yxikDPbIANIFK0NXiAJjbNVUAFiekHqIUjJ24g5B2A1DE7+LRW
         evMKzMdWqy0iaAk3S25GZ2DgGbqazu2u5ygOUICjdhs+0M5r7wVyN8IiGax049Q34RKD
         BjYw2IQRBah55rgjxaH7ieOeca7MxDwuOXr8cuHGwAtgpTOEniX8dU2yexwUXDfNuZx4
         Q8/ebPNeSmjYkIdQ7Swj2Y3eZq/kxoSievP3cn4Gjeq33/9FOV7Jr0O6+HCf1IqPOulk
         D6nuv+Z/E2SbJCU1bxwnpn3Tv/NfX/TxIJUG6cpjAaV2WUGufyrI961RtYsjy3EoJ8x4
         a2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713584676; x=1714189476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWK9lHXVifGzKZL8qjW3u1qt3v5nGsCI1LZZqXIQODw=;
        b=YNz8bbPxT+mBEiSPryoGUX7gyjKjtkNJxwp85k944lnbQ+ZYf5kKRMfnQidy67p7dc
         Kvo27R5Zcck4d9bqXq1IfHSERNFEk7yFDXzp07D6e0E+G9wnHMDq6tW9cN/YTy5sJSjW
         EdoKQGGGtZBtPG/MJGKaRyYlbpR76XHNZjzT0WX2TCCUXV4i2DKc48k4GZwwp/kN5j5i
         C2ck3/SyZLKGoveZX8eooEnyaFbh9Me5EAJhyfYFhNcGWFh3vuL/4D1ctPz74bog06jo
         rp4OQyyhgP0gOWbU7azJQJSdpoDU+EH18BOBE40RoHD1P5dC2yQmCtCOdDgpEo1sFzQt
         /+OA==
X-Forwarded-Encrypted: i=1; AJvYcCW1DQHaD1XO6Ez5euIT1EvV7/o7d2IQa6eyhFybcP86b8S2FG4UwjyR83kPkpegXFBE9vDbpRAggZbERCDVTp4Ymkf997vkb3KVvlMm
X-Gm-Message-State: AOJu0YxKmeigKhbrKtPzTmbYVOScamF+Iu9vOSeP+dNxz7zh5Pz+Olp0
	4D20SktIvuD/SCHLD7Z76iW/vxzgLGfPjsTrRmHRaxlD/SINsd3sOrZ6YElJ8xs=
X-Google-Smtp-Source: AGHT+IFfHHEvwusDXwJ7QzyiabKuKmP6IeWc9mF60JbiHSMjpN1nmUGLBDuxtJP+puvL0mes+ZblBA==
X-Received: by 2002:a05:6a00:4fd2:b0:6ed:21bc:ed8c with SMTP id le18-20020a056a004fd200b006ed21bced8cmr4863108pfb.18.1713584675734;
        Fri, 19 Apr 2024 20:44:35 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a00114900b006eaaaf5e0a8sm4005633pfm.71.2024.04.19.20.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 20:44:35 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Date: Sat, 20 Apr 2024 11:42:58 +0800
Message-Id: <20240420034300.176920-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240420034300.176920-1-liujianfeng1994@gmail.com>
References: <20240420034300.176920-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for ArmSoM (https://www.armsom.org)

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Weizhao Ouyang <weizhao.ouyang@arm.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index e4aeeb5fe..e47405535 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -151,6 +151,8 @@ patternProperties:
     description: ARM Ltd.
   "^armadeus,.*":
     description: ARMadeus Systems SARL
+  "^armsom,.*":
+    description: ArmSoM Technology Co., Ltd.
   "^arrow,.*":
     description: Arrow Electronics
   "^artesyn,.*":
--
2.34.1


