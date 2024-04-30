Return-Path: <linux-kernel+bounces-163269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34048B6805
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 04:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1C3282CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 02:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA83DDAA;
	Tue, 30 Apr 2024 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlSu/XpJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6E6101C4;
	Tue, 30 Apr 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714444854; cv=none; b=RXsJ+6RMle85DDujirfwz5tpYJj/ZuDiDLy6o7OVAxJDYkd2uHyuW5Xpws3CXPJzZr0Yy9zyBhINdB++aFMa1m9Qx7nNUEtBibpkV1QXnbrZzGC4mRNnZDAPr1Y4uyrZm2ohMSWi91c5BxqZv7duNZHDpD9TT6UgOUnqzgWAQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714444854; c=relaxed/simple;
	bh=ZNyRx0yUkCkWotFvtItmD9fZAAl5qWsRf94uXnLkRJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mfV0SI3Mw7w3jVcYEOiHh423M88LvsfKC8ePNZSfT9B+Mm+YIJlGvlpsrTvLsQPPLvebgniKWoC9x+1Bhgt9GFGbD2iT8hEvOZrkOWyOxx6QPIY0w29YjATVQs3x+SxxihZUTsFmxAvbgOYU88hNjBw2E+Nt3Gy8hRPF8IJwK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlSu/XpJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e5715a9ebdso43076475ad.2;
        Mon, 29 Apr 2024 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714444852; x=1715049652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nmwy26EmAitH/BFdPVZTkin3CZniJ1hlTGeJE7IE+E=;
        b=BlSu/XpJPN9Yi8ZhL85jcpiqBodkONpnpFPEleIfhpXOWZZlMZA5on80xPSs0lfrfs
         r6h39WPbvn2gfX7XbUUgW0eOKeud55hvZ7pZg+/I5792rCBO/tA7Jl/2jrmnLf6SPcLU
         neRbg2rmXYVJ15ayJxwDUNYXwkfJoaJD0EGsu3XHBxsy7801oDOEVhhoPDtxbLVoswbe
         yPdeH/ZYAUu7WIvOKJtHh/DQ2cGK99TGEvKG+P2uxNr0o6ov405SOoSAGvaUfqdBdm5i
         Uxdj+tnNv2yqTAECwJd1W93LtNEHvuhz1xpOUNA3pS4MHz01GqjfmJqq1fuS2lMyDmhQ
         mDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714444852; x=1715049652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nmwy26EmAitH/BFdPVZTkin3CZniJ1hlTGeJE7IE+E=;
        b=kQiOazhBZB3Ybo0n7K0kKyzX2s/mjlF1J15WgvDY4hUqgrB6XpjNqRZ3FV6hAZxMdF
         xmhk9tRR90GWi4v3bffIIVLK6h0+lGP71DUGltkShXMVL5Y61R+zy01iNzWxEip5AYGP
         PmYjgkwwWg4aFMDgXzNi1s8Vbiwliz+B9HSHi5COOMt616jUDyFlVrI/MWmuab1ac4YN
         cED1CsbTBTfTOC5K7s2hp1fqY/m0B2VEFYR96pkaxjiSDcgLlNu4MSathQMwuM60ijxu
         pwVHieuxSb967MzqrHrn6QhwT8WobMPmg7hiHn81tCIMLLMwwHSgjlH4kPoBWyRzMD2y
         4UIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/VG/jhsQkMuP7He9iT67+f7M+eYtLrI/MutAYDPJwF53Px/mF28j4DcQFuDaq6tUGF8IE7NvlES+dxnC8BOwbco2QVK1lGT2ZM3L/KG0wgJQAAKEGpEWuXpIvPh2UtskMaiOprwX7Bg==
X-Gm-Message-State: AOJu0YwThHIKaPE/a3qlkOwYQDRn7RVKxZrukUpVqooMAbl1PPXEczpN
	p2B0qgqLBzK1U7dWJLqN6W5BAG4jaTkJdKhXKgT7ZkBJSoEUy+a8lJxpwLPtetY=
X-Google-Smtp-Source: AGHT+IEsmmNWKwQpbrpKs2CI4HNEKEDXMhVL2Qq1ROslbOo8hS7d1ywEZ35rRyYM/8dSQq44wEa60Q==
X-Received: by 2002:a17:902:c412:b0:1e0:b62a:c0a2 with SMTP id k18-20020a170902c41200b001e0b62ac0a2mr10977884plk.51.1714444852140;
        Mon, 29 Apr 2024 19:40:52 -0700 (PDT)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001eac94472f6sm8400379plg.93.2024.04.29.19.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 19:40:51 -0700 (PDT)
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
	sebastian.reichel@collabora.com,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	sigmaris@gmail.com,
	nicolas@ndufresne.ca,
	linkmauve@linkmauve.fr,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/2] dt-bindings: media: rockchip-vpu: Add rk3588 vpu121 compatible string
Date: Tue, 30 Apr 2024 10:40:01 +0800
Message-Id: <20240430024002.708227-2-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430024002.708227-1-liujianfeng1994@gmail.com>
References: <20240430024002.708227-1-liujianfeng1994@gmail.com>
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

Note that this VPU also has a jpeg encoder, which is one part of
the five VEPU121 jpeg encoders on RK3588. So this VPU121 shoud be
the same as vpu@ff650000 on RK3399. But we don't use the compatible
string rk3399-vpu because of two reasons:
1, rk3399-vpu has disabled H264 decoding because RK3399 also has
rkvdec to support 4K H264 decoding. And we need H264 decoding because
rkvdec2 on rk3588 for H264 decoding is not supported now.
2, There are five VEPU121 jpeg encoders, but the kernel driver can't
do scheduling. So it's better to disable the VEPU121 jpeg encoder
at the moment.

Signed-off-by: Jianfeng Liu <liujianfeng1994@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index c57e1f488..2710bb2fb 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -31,6 +31,9 @@ properties:
       - items:
           - const: rockchip,rk3228-vpu
           - const: rockchip,rk3399-vpu
+      - items:
+          - const: rockchip,rk3588-vpu121
+          - const: rockchip,rk3568-vpu

   reg:
     maxItems: 1
--
2.34.1


