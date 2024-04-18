Return-Path: <linux-kernel+bounces-149954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D78A984E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46E81C20C73
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796E15E5CA;
	Thu, 18 Apr 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvYxY2gw"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6915E5AD;
	Thu, 18 Apr 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438659; cv=none; b=gQTO5Ga2Iuvkp0Yw9UQvuL/P96Hn0a/puLar4zWecaPiTy6JSQ1+gQRstyQR3/zq4gQP+dGgnR7BeIeJH2vdqUuLtiPo9ZL+7iTC0FS9odhEg/NOH87+raw5MgKgc1ojPwfEFpWo3kbunKklN1qhulQKs7e9log5v76DXL4QDYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438659; c=relaxed/simple;
	bh=bsJCDRz+TKIglM4cWg07JvmVQTPCEJmCzFegytaF78M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpzJTgSVhYfPyCU33ea21q758xnx0Q0YsKzdybPNeCyqb39zJMrsj+m5dBDF0qi208TEyIPdNZos6b7tmOYc3zWI7+7n+caAAffn8J2lOI9mGdvP2EW7icDso03Z76hIWoNZHpOzjLNuht8TDBaHuTaRsr4G+xI7ygncjtTt+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvYxY2gw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e2bbc2048eso6342275ad.3;
        Thu, 18 Apr 2024 04:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713438657; x=1714043457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJC1T3mQkrgyBVmgG4Hu8QZ7tiEZ+HFBgioNIYsukyY=;
        b=jvYxY2gw45+M+QIIpRO8Y15DT4DEPwr054Y1igJhcUxbTWTzdnHuPqN1T2GNeM7qJQ
         w1So3INjKrD6q3uK5S3i2bvd9MjR4OnN7Gn/xEo+KKX2tgnAr2USmGykWP28SPEd+LrA
         1JUQJ1yaxw3pDWjCf6tYsNMLC5Iy6r1n5kEf4ehwSMdiiOG9gdECE31dq+e01X2Rjgvs
         qqPZPVQlKBf3ZtDHIdGHX+SmUHvWvOjUmbSD2TFIKb3WWmioUdjsHZ0+HRwzSlhhzlxM
         KP4rNPd8o2ZUdq2lOefFR3uBy46v/8Rw/gpb7U+5FkjidbBXXxbFT6HHduriIgIgJaK4
         jq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438657; x=1714043457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJC1T3mQkrgyBVmgG4Hu8QZ7tiEZ+HFBgioNIYsukyY=;
        b=YfIF5hpxOiPjB932A1u1jAR2XT/IddUixFJ1oypzmL0nfoaUwfSbh3hpN3mNQMlXLc
         t0RFDdmNZBFB51gSsJFD8sEvOGwHubBLOntQHey4XBbuP8aCZyCjIODK+ra4qWEYUIyg
         aq3JFUe8jkxGOUWPdpH/TosAbC+Ku+T1q3q+1/XhQXAPWsB2QxNzligA1vKOJtrDujSp
         pSNxgO4aSQqUAo2ajzxjamwUGZzwqsd06MXDGV+cwm120ppkiPFWznSwXHcDDXes5TD+
         K//X221b5BlndEJKL5UEkV6ozvFNQmTCO8J4nJI7VklbuYEYGg4aovGzDAQ/NnKu2xph
         eqhg==
X-Forwarded-Encrypted: i=1; AJvYcCX3GwfEZgCXGiiQniFhsLo9a69k3bW7selngg2JBkYZpyyNhI2fbDgGjB4YSt2rzQUh3ISIc1tWgXEeqk1xpca45GCQRQQrBa3qoRXlljIpOclisyk5gwwvShVzplXi/oLCGCRA8w/xHw==
X-Gm-Message-State: AOJu0YwMUiWcKY9E78B3frZ1WUiLdoquq7+1/Wg/DBsbug2vW+fIXFeF
	Axchx2UpiP2b7sIZTvnFKi04pKgQs4pm569zzOK9LOihqARw0KhwFSB8sC/oZR4=
X-Google-Smtp-Source: AGHT+IGc+icXUbFSmOlUkEUSR9oX6zwW9ZpI7DD8PLSjyTb8Y03/SUSR0so++BJZpsPUlfe1xNmGOw==
X-Received: by 2002:a17:902:bd85:b0:1e2:7fb2:b08 with SMTP id q5-20020a170902bd8500b001e27fb20b08mr2211620pls.43.1713438656875;
        Thu, 18 Apr 2024 04:10:56 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e4d22f828fsm1051159plb.33.2024.04.18.04.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:10:36 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	sebastian.reichel@collabora.com,
	sigmaris@gmail.com,
	didi.debian@cknow.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121 compatible string
Date: Thu, 18 Apr 2024 19:10:01 +0800
Message-Id: <20240418111002.83015-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418111002.83015-1-liujianfeng1994@gmail.com>
References: <20240418111002.83015-1-liujianfeng1994@gmail.com>
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
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


