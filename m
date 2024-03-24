Return-Path: <linux-kernel+bounces-112870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C3887F47
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1229C1C210C0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB288266D4;
	Sun, 24 Mar 2024 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfdRFgel"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA663FE37;
	Sun, 24 Mar 2024 21:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711316667; cv=none; b=bg1OMaNadpfPNzfSx8mKNFPb+R2x5VT1LY3xlyOAgxZKyrU9jx5PR8K5082gM/odI51B1tCx5YL0YHuAXA1NyKCRpua+JZITymigHnvmi2h8CLHhZoxVxkizzvQQCERE+3m3B/bfgXsQpJVJN3gPkpua87bI9+Ikbe4hJ1/p7pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711316667; c=relaxed/simple;
	bh=24Bcn94uOhIm4Q65t142ORNerek4nnmnXNqFaVAQQeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LgEoULXlE9G700PbTIVj0hZ/hD9952ppkYmvm/u58S7ZEbzqMsnBNHprqE9WuZbSiA6XCMYx+rLrBnOxmT2Xm+iVcz/hOKDo1uvHLpM9+VDGBrniNmEXfbPhOtnT62yE7a9BvR+LEY71f93B2ckv007vS7IqsD+a2BnrYFg2wLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfdRFgel; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a468004667aso509195666b.2;
        Sun, 24 Mar 2024 14:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711316664; x=1711921464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2ZVW4aJABAAmWXPuu7ZneHSp8VcNx713saz+l6Eqzs=;
        b=jfdRFgelz5koc3Ox0ZOtuR9QJGN5exsko6quojc9YpwsSaTe8v4cJ/yy0irS7icRtS
         U+AVeiEZABzFxsAoxULBHepohbXLXnZBotd/RoYOuQC2KM/mZcpu77Ygk+CaXhXKOh+T
         88B+qAaMc3DxhGXmpk3l02p06zg1wFBqSNx1I3hax3+M/XgoFPcn4wfDykBZIZDGGPni
         LreFfRp2wcaQrsSNUDyA4BaSPFpohEqXotasYKsSIC3p+qNtuh01AvhcBU/ZQWWRwjNw
         Vzb5dyl0D5QQhWVBlj9NuCGVYONp2TrxnJByGIg+GUUG+I8L7CXbahzp2Gsi5fc/U66o
         msbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711316664; x=1711921464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2ZVW4aJABAAmWXPuu7ZneHSp8VcNx713saz+l6Eqzs=;
        b=nde5b2bP/zZMJlSiJyte2iGe1CtE8ADwx9dY11Doxbs2dlQ5Vpw+xfDDJLhvcmptn0
         OLEHUpQofr+8tZ7jctOKRaTxLfwnCaXCD/aD5lr/879hRTboEJJgMx2xqpUX7WiRkrGm
         pWOQ0EV9W7fjnJ8uOoislPyqyuCTHuvG/Vp41NYHhbbJeOHTtuQvrigz31J0sSBRjdLV
         dkFh4nyFV40JkfwRgRr1wOdzoxWR4iRUAbOYmBvmxCguN2YPBiMgv/DwvXDnEiZpP9fG
         BN3z7KGxWZJ4YJVH5sd5dy7a9f7e2aHbynujbnTh8MU5+KirJq23gOKTaYzvaNKLj9XA
         VE5w==
X-Forwarded-Encrypted: i=1; AJvYcCXHw5KEQoJqfjPOoxXNr2wfVBjw+11PYi7PBzmc1g5unuBhs6XSq4Xu1B3uqZhnSUlpzUrotbTj/gpy7pnbJwbyhvgi+VeaJK/UZxzcg2EHVWfmNcsrTlx367w/KuhMfcLp5FuxK3xKd2ZFEPpJLt8fTeFWu91rsXFH5103bCf++mGfUqEznSE6y8vlvJ6qYrFA83M5WDtYzT1dZNcjrGGucg==
X-Gm-Message-State: AOJu0YxGqFRb6pHngtWp0HGBxMTKofKoKzqq+rQ314lUeZF6I8bqhi8V
	TO5fPK+w24uL2YpOKU9rpUB7U6gyXTsu+e1/uCpMfD/xcrIwmTAF
X-Google-Smtp-Source: AGHT+IHxgRxyDvn5tOFINY8W7idcbIamVo7i0+/Zelk80ySjeUVfPA3Ll5JWuj7eD7f3hx9/+mWrBw==
X-Received: by 2002:a17:906:db08:b0:a47:52ed:8961 with SMTP id xj8-20020a170906db0800b00a4752ed8961mr1712763ejb.7.1711316663847;
        Sun, 24 Mar 2024 14:44:23 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::2043])
        by smtp.googlemail.com with ESMTPSA id w17-20020a170906385100b00a46d8e5a031sm2327542ejc.209.2024.03.24.14.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:44:23 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support
Date: Sun, 24 Mar 2024 22:43:25 +0100
Message-Id: <20240324214329.29988-4-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240324214329.29988-1-wafgo01@gmail.com>
References: <20240324214329.29988-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
driver works also on S32G3 platforms.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 82eb7a24c857..466e7157308a 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -90,6 +90,9 @@ properties:
           - enum:
               - fsl,imxrt1170-usdhc
           - const: fsl,imxrt1050-usdhc
+      - items:
+          - const: nxp,s32g3-usdhc
+          - const: nxp,s32g2-usdhc
 
   reg:
     maxItems: 1
-- 
2.25.1


