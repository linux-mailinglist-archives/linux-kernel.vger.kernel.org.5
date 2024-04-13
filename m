Return-Path: <linux-kernel+bounces-143604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D440D8A3B55
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E2280F63
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7522C189;
	Sat, 13 Apr 2024 06:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0EuayUA"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C32C6B3;
	Sat, 13 Apr 2024 06:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990812; cv=none; b=H5OtAqrbJLP6wtQlQSvtjU4g21/gqEHCBHrAdGStAZ1U4XNR/P9nvn3NGhtynfyDHuhvvOUXADwg0lr3bq//Ltd1fmFyq3xiKk/mtfe5+2uIwO+MZYmtcJ401WTXNVtQx3OL5r7Yc0NnaRr7SCXfeavsAM3YluSEtOm6AdA/ElY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990812; c=relaxed/simple;
	bh=TbV8p/Uva02TlZLiHlOrzb+Smt3ZT8NektIy6PK2auE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkQQ+61PXBOznjqK+4Vvu+JxTFHLuJZZHpOMpr8evvwkH/qoDCK7zAIQC13cPGHMRa1Z0NMcRhXdFr6qvA1cUg7KZkipHLMcQ8YoIdNo5QSSBXBxPLg7YYdHBWC7Xbq/VxNjj/6BCGWYhiiRDSeBnFKES864gQ9evVASEwthhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0EuayUA; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c611c787c1so292600b6e.3;
        Fri, 12 Apr 2024 23:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712990809; x=1713595609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbRqb26QfAthS3CJVq90TpB3Bg3AO5IdQEZJltedfdA=;
        b=K0EuayUAarcO/PRjqHJZgiLe2gHt/heOn03XWA6VYPxwqmjP9kyJWBtJ3emmbkDT1O
         MQY/iLTOEYkxHAsgLKWWY8cprblj/qUwtexjM0WJb2SCi4b96Ub3xgKsuWL/ncuhmu14
         enk+C4nn3CND6BWote4Df7eeDXp6mrph/72aJLDZ3kE82HqfCGsT01CmpumhtlQK3fyf
         kPwy9AHnaHEGxAdCMFKtKxl6NXxkuebrg0dZoAYYGd8ZUHL1wZh5iT+cyvdU4Z49zY+Q
         PPMBKvcODJmD3lSNhUltZ8lESRTVqR4Vv6W2Vp9pprchlskvrlDeKbBzHez5zfFN4caG
         dFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712990809; x=1713595609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbRqb26QfAthS3CJVq90TpB3Bg3AO5IdQEZJltedfdA=;
        b=RsBSqRFSFyHrYNzFGCaALJ1jPW66D1UbF96YHqgv6w4EIphLzJEHBHNjbYFqSMHGVx
         IREESZh5qjDzVPXAEANlPDy1i02VY1iQw2CGk2uYzckGgzQHOiJRi3OQzUAay+uwBQ/7
         Wa+P83ns2R9ihHljYl5q9HZ7c/G4fhS8YMeQNF8e+mU0ZBecUonbZnd5NUz60u8xuV+N
         gnB3+3Y5DlIwidbyBUsty9K2j7e0lTXv4BzWBEMEE3UT83QETzGrRoH4ZkK4Qw0x0B9K
         riImmod3x01GHe6YdSYK9JvdSuiTyGu7pdtbbHNSWld8JAcSEFE6+gygG+EPq3JaURdG
         PD8A==
X-Forwarded-Encrypted: i=1; AJvYcCXP+DQxGdsg449Y6qwxWPjvLOBm0IF6DvqlUIxLUMpqvsXA9n2S4zjSs9+HJYCX/1CP63Hg4ejaGinRy1wRYUVdlqPZwLrq6FjI0FFnRe7/D4IBPZVh0P/Izg9yyE5KteDy9VZ7OBQDnCc=
X-Gm-Message-State: AOJu0YyNzGmx+tEN8/rIsxwIzVRYZia0LvVCiGPh30vPSZ6wr0qWJrEf
	3dWG3gRVOg1q2Xc1sbs6Y759F+8yY/6U7XMQ4PB+dAvhwWLwPp5njp65S2taFsc=
X-Google-Smtp-Source: AGHT+IErS4TJR2V/CrbkM0Eg5mpkObIhcMcSXT4YWodzpv5E2aaVxsMHBZjnG/n/21SFsqBLpCqNMQ==
X-Received: by 2002:a05:6808:1a82:b0:3c6:f5ca:86f8 with SMTP id bm2-20020a0568081a8200b003c6f5ca86f8mr3908304oib.27.1712990809391;
        Fri, 12 Apr 2024 23:46:49 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902780600b001e2a7e90321sm4096693pll.224.2024.04.12.23.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 23:46:48 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com
Subject: [PATCH v5 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121 compatible string
Date: Sat, 13 Apr 2024 14:46:08 +0800
Message-Id: <20240413064608.788561-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240413064608.788561-1-liujianfeng1994@gmail.com>
References: <20240413064608.788561-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Hantro G1 VPU compatible string for RK3588.
RK3588 has the same Hantro G1 ip as RK3568, which are both
known as VDPU121 in TRM of RK3568 and RK3588.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index c57e1f488..4f667db91 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -31,6 +31,9 @@ properties:
       - items:
           - const: rockchip,rk3228-vpu
           - const: rockchip,rk3399-vpu
+      - items:
+          - const: rockchip,rk3588-vdpu121
+          - const: rockchip,rk3568-vpu
 
   reg:
     maxItems: 1
-- 
2.34.1


