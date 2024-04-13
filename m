Return-Path: <linux-kernel+bounces-143784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A5E8A3D74
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D75D1C20B9B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D534CB2E;
	Sat, 13 Apr 2024 15:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN4GqLrM"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2D48CDC;
	Sat, 13 Apr 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022642; cv=none; b=c07rOOH3LJ/2hSQ2AFhx9JkC5Pf7lgkWGgoyysHTBOl6C1onA2u1UMJC6M0F8OXTZn+q6e7CEOb9v4zbvE3r0a/LovTH03fnVQ2K7EAYRc1qd/F/wChakmOEZ55mLZ1AaDZ9APAPRK+u+eGcfkjTH+xVe/vUMMUJY+gSwJnlmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022642; c=relaxed/simple;
	bh=U5W0YkEV/doiX2o+YcVfl0cCqei6pd6TAfnzXFB25nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LePNSqiBjmtrS55pqp4DZJHl9PS8pTQ+EnmlhPCEZRdBX44n2tsVPjSmUhfhaW9/VI9a/0f4eSBi9OHalswBRNTkMt3TPaFqR6GjnsMxiaXrESDcUCazwG7fGyA2dQ/DDwc9wg3/f9uxcRsY17SVq+pXnns/XltgbGCeS4er6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IN4GqLrM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1295330a12.1;
        Sat, 13 Apr 2024 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713022640; x=1713627440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wed/K58PoYmD60dNtijXSLDH6AUZcMsW0hh6I87DqgI=;
        b=IN4GqLrM3neuqBAyW3VAZ9tvslOQTH0d6m2MHStw/fzxc3tnctccfr8U0PaOoLTL8i
         Jr6RZVp2GjO3uAFedrEUGZd0XkMNLlDDqrb0l7kn4+vzcfZo5It02C2BPXUKG1gvBMye
         Pyprixr54hlzuS0WXTpav3iJAjHOLD1QJpXroSxdaL1g1BhSTa3hCjJxyxdaRCVssAE9
         shL35gcOnjNwt2QzG0dw9dNRb041j+flVYSxkApZf1xpCICe02MgjK3+ZD1jmoVh6TvK
         NXCAxwrbI4kaG87UssQjk7AhoIHTKJfJIbD+QIvitVnKbrf71zEhIvPOkQ43XM1BoW7E
         rpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713022640; x=1713627440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wed/K58PoYmD60dNtijXSLDH6AUZcMsW0hh6I87DqgI=;
        b=ty+r5hcF7FkFlbKDGY6AHc42qGi7/Am06Dwq3sSsoEUtCQkKO9pGHZmn7lmgKyFjAj
         E+Jrb8rQNatt5nVbw/bkNhYdvXb6yFpI1NHc6V0CJ1MMsOWtSckmqC1QfU1hCptJj6Pe
         8PTpRKTogkwdSilhedtT/6JGth/9kDQLClGD99YGpN0cQu98xRz07GOegJUJxMSQAhDq
         +XnyraYVI+xmGilS2GEpYYHV2R+JG6cdUxDdLCjZ7b6ywfsngWi5A4+rsHBhBPLh3EgY
         3Mzi9oF+GueOW/y41Cy46Fmpn2ubeof+dIoYfsUKu4+C3bPlgemraYoMFwrMSXuSZGVN
         eCgw==
X-Forwarded-Encrypted: i=1; AJvYcCWcRBXYC5yXBuYdrO4lCa1+2gSxjMxaUx+QcYDNTpb5T6TCGsFCu9LW9i9R+PbZ0X6dqGTlKGxsOVRjbUD0Sf3r9ZSNfUCdct4r1JON
X-Gm-Message-State: AOJu0YwI7ZPmuTzMqLgCXvThoargxz/5Xt5shLLxM7BFgHt/vgYsljqq
	JpQRlUkBhYVprA9do2IsnKTPRciZe+a/hhioozQI3zf2NiNj5drTA+r+ZbnbBPE=
X-Google-Smtp-Source: AGHT+IGAbgTuqPkp0B1kgsTuDrFH6Oy++aHUCGr4XwRHonghXVj5lMeWJ2otf2/+EgeYnTsF9PiARQ==
X-Received: by 2002:a17:902:d48a:b0:1e5:5c49:ad4b with SMTP id c10-20020a170902d48a00b001e55c49ad4bmr5132349plg.38.1713022640279;
        Sat, 13 Apr 2024 08:37:20 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ac24d00b002a706910b05sm2609606pjx.9.2024.04.13.08.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:37:19 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add ArmSoM
Date: Sat, 13 Apr 2024 23:36:31 +0800
Message-Id: <20240413153633.801759-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413153633.801759-1-liujianfeng1994@gmail.com>
References: <20240413153633.801759-1-liujianfeng1994@gmail.com>
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
index e4aeeb5fe..c6af4da94 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -151,6 +151,8 @@ patternProperties:
     description: ARM Ltd.
   "^armadeus,.*":
     description: ARMadeus Systems SARL
+  "^armsom,.*":
+    description: ArmSoM
   "^arrow,.*":
     description: Arrow Electronics
   "^artesyn,.*":
-- 
2.34.1


