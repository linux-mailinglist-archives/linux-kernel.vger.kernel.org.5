Return-Path: <linux-kernel+bounces-59004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DBE84EFBD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EAD1F234FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5984356B92;
	Fri,  9 Feb 2024 05:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK9JklZS"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CD56B82;
	Fri,  9 Feb 2024 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455063; cv=none; b=S7h+7ggZ9OCxUkxxKL0x5TOjcOntzBrDuAmCSueVhjQdyOhqTpGqxYMkOMXBW3Xp5RuAIEpGb162iv8FcLAVzUjq4EcgPPiZg1HqJNCID5Rb2W45La87qH00gHJXOQr67PKCdB/kpD7qC940yIsPtPWISSyydb/RB5ecHRDuFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455063; c=relaxed/simple;
	bh=iMZJiu/bnxPiAITK7fctYgy8EgGCASzYGj8tEvNQlZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OaotZoRzNZ8B0vLA44ZVgSoCGx4Cc4pBlLk+Iv9ZsoulR1g35vYN26xXbBKjwTqU3Fkj56H6K4qvf5GyxOWB3KlGjtzDh3LrjdnujDvZ5+UurEsOBh3v+Gb40YNH+iAn2se7CscfkrGvuL2ZhlJcVtHDaJ67+kUeLCpguYnTf/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK9JklZS; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59a146e8c85so303815eaf.0;
        Thu, 08 Feb 2024 21:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455061; x=1708059861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g7MTZBCKHzjhM18x+n8O/DVUc7G/XYEcwU6xuwWh9ZA=;
        b=bK9JklZSAs+6o0thVRjU8DDE4spoM3ItVr6kM9Dq0Vca1KvSW4AVK9Fo7nE+5cWzjt
         Uuee/QwBgsx3BKUKaIaayKrJra9NN5CVclHR2rRrfsrYf8UEVORwkCV8NLWW38IXPzwm
         hYB8zloDTg7i6bGfZiy0H5abNyOiBRxqNufXIo4lHbGPUYzw8zqIUFP3b6UpXfkq2ZnE
         UeYsAxQhOUNNvZ9M97XWs3v5A+EPOV3VqCKRJGTxaIeasnNqZ6GXQL3DipZa5stRfAO9
         BtYfLoEVjyUr2H2qSkx24zsW+p8Y4JSumeeoQ3nMIN/UFEteVjfAek5vtMQVWFrcuDKi
         sb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455061; x=1708059861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7MTZBCKHzjhM18x+n8O/DVUc7G/XYEcwU6xuwWh9ZA=;
        b=L9HEHckZR+JbMXUG+8gmVMNtA49cxZhggkiyYs3ldZowxhLOp2IMyL2i6aKKHfbHdT
         0SJrvhr+t2J71hV0we6xCQrxch3KQky5zs5MxeGoykQeL2cfJwqnm9H4qFGvBxo0bcwd
         9XOYuwfb9yNSgbzCg0vzgN6GgyxTL+5m/Wx6wDRuXdutJ39YlrPJJjgMnZ/dMfKf2lCf
         ACOf7dx6s3fa5P+k7YzAKvYbSFKdIFCl1iFwYZzTmBHSF8Gf6aSe1WlnUPpG0GJwXqzb
         WupERSUIUqpkgW+xbAkZe6z1h31fkKaDIhaLTPHiaTyE/TQ19SgddrEMVLhu3XvlcSO+
         TQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjZuSoopqnR5gqwpMpj8soPghPX3dn6FR25RqOX9SmxCwOQRC3H4Urj8TFo6ggYKRQ45MEAhDmRY9wh90wQOcgxsDXLFbF7ZZRKIcn
X-Gm-Message-State: AOJu0Ywaa3KM5u2PRrfIKLnAddX/oQ5eMurSF2/mPbpnC7MRpfzBuMuJ
	ARjrrEwhmp7YQj1JCgtjAUmQOl6IlvQsgaJODpJLJ302erEvumsN
X-Google-Smtp-Source: AGHT+IG3uTTPo8eiY2siXSqjOduywyGtV94rJ2z6r/VK6TpVS9phCxGoC/7Qt4wq/xOazqFwgK/QEQ==
X-Received: by 2002:a05:6358:9986:b0:178:7540:999 with SMTP id j6-20020a056358998600b0017875400999mr502758rwb.3.1707455061077;
        Thu, 08 Feb 2024 21:04:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUKtQfOnpUHSaPvXR1U2hUbTvxqzIqzZprJ73VjB8ujdVw6vJ/y8i0LKLb9iv27dehJZFQlu485Dbm9ezac45vVz6COmzMZ9cEVyCkOTsVGstE1vNXe4kC/LOuhfFYNd1jUgIpGmtJlPDKJIwJtTcoEnQ6gWOJqUUdqVofCSmQ49Y6H/GCYtfkbYfWuWOrHa+07P1haswfwCOEtKYD/oAKGy7oULsYSTMJVUfF7VXEn/6xqtGmf8VfGBikqL0kucCSF6/2scOYBV0wDf4IMX01bZ7is5SHequV5ZxZmnAvrZTYsHIDbfIszfOgCa1lX55qIlOboiVr+6IALrVk8l+45O6ymIM6Q6FpnWkzihztz3aDVsQQgBQBs/x1gGXLO5w/p/1abpyrMP6HFtq5pu++1acXa
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:20 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:37 -0300
Subject: [PATCH net-next v6 01/11] net: dsa: realtek: drop cleanup from
 realtek_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240209-realtek_reverse-v6-1-0662f8cbc7b5@gmail.com>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=iMZJiu/bnxPiAITK7fctYgy8EgGCASzYGj8tEvNQlZU=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJLy4TTFFHnoKpMhmPmsVw71Ws4vHVm5R50e
 F4tqNBaK6qJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 VunvB/90ufR+wgtQ+49IsDa23xE8afdXbAPBqjhMGssi21dNhzSrypcFip+Uwdnjg/JdNolhXYF
 Y36mU0E8IsTjTT/wLZKnpmhjpT8H17Tj+pSsafci17ASGX1rRX2L4/Y0LC0eMqa141/lfIe8WX1
 r3s9cq2bLQWhZi0D86D9+dbj529Bz6Se1rVex6b/C7l80eQGaa/Ie4KNxvebzAovlZN5m0bJq1V
 UDPTMevSrArsopTF6oO2bdu78KtxAobfXuRCZC5cCMVCzVmFRXFX60o6rjj8hAlml5NzMfwD010
 7U/zSBMewcpaJgotaF4X9mO79EoNqiJPmusCfhMLkFALQe2k
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

It was never used and never referenced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
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


