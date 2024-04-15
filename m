Return-Path: <linux-kernel+bounces-145635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634A38A58D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185931F20CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F0212883A;
	Mon, 15 Apr 2024 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHjbLgEl"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495FD1292D8;
	Mon, 15 Apr 2024 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200882; cv=none; b=usvHcUYijCL0VzDgM6FwCXFPzqO+JvSbMileH9frCNOtjUbrbMJqAp/1100eX0bD1duDKU+NMG8PrW6kq7kAKMdMa/BmeQyJfuOyX1jmjj5gY3PAOxecHxzjIO2XDAYWhzMnwFNio+YDS8IKtLYZVnJA5xchd4WQT+nSwLot0c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200882; c=relaxed/simple;
	bh=wLtQeaij1UkRJURSiqhWruB+lx4Jwv+x8lhGkvvqszo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n+IAxYWos9UxRSnSYPP9hD9FVgFpnDYxZk9zsM3db1Q+BqIYsLpadGULvgndlJlXrp9I7oH/lF0JZjto5ZwfXL2q1Jw7/VNKT77SbKydDz+UPoi8UMAul/8IIkvsLTi+lpAD4IbOAMWX5j1ro+zS5rgW/Km7Zn7a2EQG+n+hT08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHjbLgEl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed11782727so2933290b3a.1;
        Mon, 15 Apr 2024 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713200880; x=1713805680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxqWvddsK3MTcsP5PP2zajM9rLezNvqOsmF2usnJs6U=;
        b=aHjbLgEln8oWbvRn8Hz4YoJsSvWYfkdajJATupGdJwS+dmBe+0tWVC3L4XGnz+Ss1H
         x03uA50w8B4POvltstOC7FxbUfiHkjuRVlVDwELMvdyEqKeHglUhmtPscpLB98uViQkJ
         Bu+IhoOwAt6MeOaAO2y4CUFK0T/cGo023GTi1k1b+/X3kXkWMml+ax2V5CNcAC1d6stS
         KqA/S5yvh/yNEOjO7ulBrDPLR/WoidG4w3S+tDeqa8HRdsao4U8OVNNSgRy7DLi7QFzZ
         U8TizdpJY1ErPMxDWVOV6wFH36mTQWwYsh0EQYPImizJz/DU9WWrLrsJ8KA/BkVCxhJH
         Fqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200880; x=1713805680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxqWvddsK3MTcsP5PP2zajM9rLezNvqOsmF2usnJs6U=;
        b=NU2URfnuQQsg8rg6KdgktZZhWYXXUIBKmt/fIePdg4uI/WAkyF8Ix2L3Uo1RFvSrFN
         TgAnGf4i9n/PFfeguVTs2Y2rTToTLJLxKGgU6jZUpbwq6TX3kE/MxNtVsygDKjPE/P8L
         mLKoJP6KxJDmM5L21KsnUVngFmo3TQyqfeHI/eBv/5SKKFAzRgRZNMfNsjn8aejQE2/y
         VBkMeRBSl8BWZVNRvfy1L4DQiKP9zeYj94Xoyr4KNBOJGJPEAXfs6KYXOlPqbpG817Rx
         9bLeJj9JlzSNCP9GEjbOeneKDbqdGcDPvyV7WzaZMTb2OZdTvQMVUlj8/3AkyT6qz82R
         eueQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg9ND2oxRoH717/ubEVRcFDva7CZba2UobtrSp0NOvJcohA+VqyFsMtFxmKGw+oK6TdRh174pwqG6iPg3zVE12bP7iUBLFkp9zm/ea
X-Gm-Message-State: AOJu0YwEbbxvPzxoC/GCyTWyNFN8lSPu57BTk+TdgQOA/zfEImhMDr08
	R3OKmnowB4r2gKGUohJ7YA/eZeBoxd0iIDmegG6WR73MV9zJUJm3huRbUdRvmtA=
X-Google-Smtp-Source: AGHT+IE/M93H7RShff9G0/0UD2rlc/o8B9Ew2BikCCcTsbEp5Y3e7mZva/rH/6QuNX/dRku0BnUEPw==
X-Received: by 2002:a17:902:9a4b:b0:1e5:5c8c:67ec with SMTP id x11-20020a1709029a4b00b001e55c8c67ecmr7957974plv.5.1713200880255;
        Mon, 15 Apr 2024 10:08:00 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id r1-20020a170902c60100b001e0b5eeee41sm8203983plr.38.2024.04.15.10.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:07:59 -0700 (PDT)
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
	weizhao.ouyang@arm.com
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Date: Tue, 16 Apr 2024 01:07:35 +0800
Message-Id: <20240415170737.49350-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415170737.49350-1-liujianfeng1994@gmail.com>
References: <20240415170737.49350-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for ArmSoM (https://www.armsom.org)

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
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


