Return-Path: <linux-kernel+bounces-13728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B920F820BBC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 16:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F7F1C2119A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30F3944D;
	Sun, 31 Dec 2023 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjE8+0aY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E418AD48;
	Sun, 31 Dec 2023 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d2e6e14865so37444625ad.0;
        Sun, 31 Dec 2023 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704035556; x=1704640356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LxeA0IIZhqjEAhSl3nYPkL3LXbf+ObZ5X4oac0U0NA=;
        b=LjE8+0aYx7dpMcgP/cBEZJ7mhExAgYeKUoNj8EBUs8MWZbjfontFTi7bIJRQE9coro
         AmdYliRaRlUiDFKqBZe2vmNzqHRu82yNxk3Cg2aN6HfqpQSvl6jPlwqn/cqUZzE4mgwf
         j5IKvlg1SgzQr1Ry6XWxox5XXfk6XBl4gUjO5NTSyPxqbmTj3VwUU1pVp3HGaCtw8Kho
         /k/eJL0o9Dim7zSrmopi8t6sPVhueVJQ7T6b5G+UIu/xT9FIEWxw95+rrLVrDcOEdJdw
         lGCHaMVseLVDzJoginrzy49DUoXXSmyZ8on9mHOC5OdKWZT+sV6Pm+uRTezjCcuKavOY
         zgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704035556; x=1704640356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LxeA0IIZhqjEAhSl3nYPkL3LXbf+ObZ5X4oac0U0NA=;
        b=luKJ22jTIN0HuprW3PIGn+CkRF+qVP3x2FCXRUW5XzGUa/EbJcoK1CI1gGvtlHVdnu
         HN2RkF94b4shfU2tcUa6gzbZZXQ+MGNI6Zr0c5+pXR/IafR6J/e3mvzF2+R4oci9Aj1g
         yjUQayG8FaDL4tHUEHCQUeMsv1xqKko1q7KC3DFYlLmCTkVNkS20nn1laVM0KGbFRVkq
         N0M2BRhalATht2+4lJEIhSdHfmZHL/izieH83hKHePP2krm+CFOdgpRaSBy/8QZ2BMWi
         H2sy+Z5+EqOzjjX9cuUwdzgUEO5EaEYvJd+luxeVSeSI9UqfKDaaMEFYHkKWHWTjB3UP
         UT0Q==
X-Gm-Message-State: AOJu0YwmqPu3+NkdFgTsP3Sqze5QzFZsKCL3PU0MTOvQmHO9DRQ3VUP8
	x1EW36aQWAXg6fpzWpwC8kk=
X-Google-Smtp-Source: AGHT+IEeC/oNDmebvGAlCDPpcUUA71dA7m7XJNDO6ov3pNSjePgSV63EBlmsTgDSigIUfGJ9GW9DjQ==
X-Received: by 2002:a17:902:c601:b0:1d0:c888:d129 with SMTP id r1-20020a170902c60100b001d0c888d129mr5937727plr.103.1704035556512;
        Sun, 31 Dec 2023 07:12:36 -0800 (PST)
Received: from localhost.localdomain ([2408:8207:2540:8c00:2643:6273:f90:f77e])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001d058ad8770sm18775011plh.306.2023.12.31.07.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 07:12:36 -0800 (PST)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: sfr@canb.auug.org.au,
	liujianfeng1994@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	sigmaris@gmail.com,
	knaerzche@gmail.com
Subject: [PATCH v3 2/2] dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible string
Date: Sun, 31 Dec 2023 23:11:12 +0800
Message-Id: <20231231151112.3994194-3-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
References: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
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
index c57e1f488..16886bccf 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -31,6 +31,9 @@ properties:
       - items:
           - const: rockchip,rk3228-vpu
           - const: rockchip,rk3399-vpu
+      - items:
+          - const: rockchip,rk3588-vpu
+          - const: rockchip,rk3568-vpu
 
   reg:
     maxItems: 1
-- 
2.34.1


