Return-Path: <linux-kernel+bounces-45451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE708430ED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 181ADB21D00
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9C7D3F2;
	Tue, 30 Jan 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsFKyBM4"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F0A7AE64;
	Tue, 30 Jan 2024 23:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656444; cv=none; b=fxj2bBJ+/VIvIu+DXcnQn6ml3CFUeiY6rQIfch9sMYzQOeBb6RdNS6Q9Y/FtceAKpI5AQ6wl6qS5Tg6AIqo6rs5zR/yhus748smbpAoHVbTCb5h7kUj7UX5Pje9QC3gnZ9ALSJPBSt3g1/5ZGDdm4QbhdJLKvy4W3riDHFFOIjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656444; c=relaxed/simple;
	bh=Ozk2yGiD6MdjA0WNn2QypnKH2DYKdhiTR52YxHkZMW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZkFzbA3FsloNgye4WmEKiUc1FlYHN6+RQse4NVI3B6GJ5/qPekNJ7QsG7zOVLN0yHQFp+Xh1e+ls1dd7zGFhvfsY9LnjDqJC7ZLemfvcorFgbL8BV26F48x1LuHjUrBff3/SRJwtlF1HU4/Yag3iwaTVJI5wFhlMNdqy1KxDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsFKyBM4; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8da50bffaso14420405ad.2;
        Tue, 30 Jan 2024 15:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656442; x=1707261242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8BOaDX/3nN2EaexhvCYOL8Nx0Gef5sVSXcvwUb8P0w=;
        b=DsFKyBM49k4sNHAYh2i1RtivmBkzOmrQvTSYZWibIjeOA6crRuoRiyGLCO6Qvvx0TL
         tIOEwYgcwaQ+hS2OfiB0DFS6bJRb6bs9NTQQc4AoQEzU4c6YkSXblqM8fqpfQa+z6FFq
         1b2C7LwkBbWVClOPNAtkrExi5N436PppI9bXoYImNx7CUfL/7FdtWvKYLorWDmmZrjNd
         LhLuwdMsubQUBRhVuxMKnTv/559RsTpFZ1/iYMVtWzhCyeBpNFu9Nt/9+1gplvgcjbBz
         Vkkkm2+VBXfcrJXKWTtwFXyOsMbmiblAPKT1X+pvef5JWxTnZhMBuP0+6vsMPq6kYJgo
         vRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656442; x=1707261242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8BOaDX/3nN2EaexhvCYOL8Nx0Gef5sVSXcvwUb8P0w=;
        b=s2E0QFdqdOq43/Vw2YDqCGzODuD77CclHckR3tY73vxu56yVfUpaBzZ4cqPUKMEUz0
         Q7cv4chiZvQNTKwkZSS0nY7qmZsDn8zEHfZqq9xrHn/5gX8e+oZvy78PLFWzVGTRjLe9
         escgaJre3NjNcu0//IbJD0gazpOf3Alq6q799KhovV2iZPj5rp+BAhI88WFu7fE8QBab
         GXaoI+bR9z+O/TupHXUmoSIEhlYACkXrtc32RZ5Mi/dlXZr882YHAGEHIM3onbQbVTeb
         82WGjbvHr8YAEH1mYg+9MDmR9QPULyRme7jBOE9omhFeo9bO58ngnmAVAzyErfoyozhp
         mhQw==
X-Gm-Message-State: AOJu0YzPbxGjgU5ySHOZAeZeD3vz9S2Muk05UWW9hOrH7Ytp3T836xqP
	KgUfem5KFIWpffc1Dzbalm1Gb25qYDrljJjMBKZVhE0v1AFacBmH
X-Google-Smtp-Source: AGHT+IFLE1kKRLgtrJf/FLuhChmnNRaEBeZeDfzemnc9+Chj+hAe9uNihozRqKIrMEYZ5A+cHKR8OQ==
X-Received: by 2002:a17:903:2286:b0:1d9:1df6:6e23 with SMTP id b6-20020a170903228600b001d91df66e23mr53472plh.39.1706656441915;
        Tue, 30 Jan 2024 15:14:01 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:01 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:20 -0300
Subject: [PATCH net-next v5 01/11] net: dsa: realtek: drop cleanup from
 realtek_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240130-realtek_reverse-v5-1-ecafd9283a07@gmail.com>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
In-Reply-To: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=Ozk2yGiD6MdjA0WNn2QypnKH2DYKdhiTR52YxHkZMW0=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKwFKYr0qBJBz/xfInx52i8M9FYEXieNMMc4
 Raun8PPrPWJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsAAKCRC7Edu60Qc7
 Vt3HCACwJQYSN8sKFrFLsMiOvwMFC4J3mEUATEVwSmugdv/xGq2HklwxlzUoNNn6zxN1YJUKuR3
 P7q8112MsNOOgFblUHg+tfs+PXGlt3pdd4+7E27bpjvUQ2DgLnDZ9tKPe7X9IwfSpltF4Ie9ZEW
 s93+DHEmjqr1OpETIpM/NhIZMf9+PasN7+zYyBPnsWN78SvFhlDj54JcAU2YdR1UCFSekISmhnQ
 +jNkHReJ32ozplGNhgu11yUiXqCmdCBhBefSMydPNcFlRCUTOBKEsGHuKLSZ2L+aWSLh+ENS+Ca
 6VXMVz8UHYe9Vb4w0gXTLFiMpflu2oKBda0iAgOHjBlMC6gA
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

It was never used and never referenced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..e9ee778665b2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -91,7 +91,6 @@ struct realtek_ops {
 	int	(*detect)(struct realtek_priv *priv);
 	int	(*reset_chip)(struct realtek_priv *priv);
 	int	(*setup)(struct realtek_priv *priv);
-	void	(*cleanup)(struct realtek_priv *priv);
 	int	(*get_mib_counter)(struct realtek_priv *priv,
 				   int port,
 				   struct rtl8366_mib_counter *mib,

-- 
2.43.0


