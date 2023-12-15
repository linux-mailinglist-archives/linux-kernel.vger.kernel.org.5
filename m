Return-Path: <linux-kernel+bounces-1903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A15581558A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F59C1F25A72
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753933527A;
	Sat, 16 Dec 2023 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2bgX0By"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460B6127;
	Sat, 16 Dec 2023 00:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3332efd75c9so938141f8f.2;
        Fri, 15 Dec 2023 16:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702686187; x=1703290987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uIS1xvpcGYFfMf9N01u33T+TCWbWjii1imIi3mSLAk=;
        b=I2bgX0ByCIK5LsvxD3qeHX/7h6c2eZu1vtBZYJXnhb1PzwTi2X+6nRhsrKjfzIXVS9
         vPrl6ATH4W/g5TX+Ksz0n12vU3LwfwFNNgKlYgAPEVuGC6o1J5zp5x1FtEDpe5XGyJde
         g88WJG7EVhGAKxCjB/qByWhbksDLld51AhNmwse1Tcj1UyGN2h4W2NB6cw/dIu+HuktY
         +mvamT+nwMng0fSZrPQ79FP84SwvbuKFl3mhaxLufzfbV3uzpbW5fBQFzBcsZnsANoDG
         tv+xFlJrl/lDbHtxMmt0W7/UY0cXBxQo7wwwrgiDLT6AgDKDmxInYNm2JrXcF06oIyL7
         pZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702686187; x=1703290987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uIS1xvpcGYFfMf9N01u33T+TCWbWjii1imIi3mSLAk=;
        b=gadwxLqdWXcs7/0vDvvz4jMId3ZhEn7mg9IlZl6k+aIG9iSUNiqQ9d7DzYygsHDX2L
         ORZDTEH03p4Md6bVBkHx0itxRdj7axtvtitwpaeidQfVWp+ZpI/doq1SdY3pyDB5EnAE
         eAwzk5yrfOY45jFny0vZ2vT5OVYT59S/BjRgoe9bN/xvNExjrJQSqG9Fp9C+5N30MI80
         ANZKsuFuORPVMEwAJugVvZHlCTKKsRBHrcBV+hhSgZqhmvfwNbrO/NMnBUZ8oiqMXvLS
         m19hB9IkzfSK69Ia5DabWu4vwPPu8tnzXAETKKstFpNPzGJG6woHG/hjqs6CkJhMtxnb
         n2Kw==
X-Gm-Message-State: AOJu0Ywf3jF5wmX3M+hK/RTL0V76i21zaGZzZ2CJ40HOljmrB7/Y/iZ/
	VtDvlXgJWcs5Qp2oU8l3GvA=
X-Google-Smtp-Source: AGHT+IGMq3ofsVqjDxA9LwdQcYL65+HjS9wukreCSpXDsSYXBAJhSPgRVkTNNZZ8NkyDthWA5jPOiA==
X-Received: by 2002:a05:6000:b4a:b0:333:4052:bfeb with SMTP id dk10-20020a0560000b4a00b003334052bfebmr2988930wrb.208.1702686187282;
        Fri, 15 Dec 2023 16:23:07 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id a15-20020a5d508f000000b0033330846e76sm1496191wrt.86.2023.12.15.16.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:23:06 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: [net-next PATCH v4 1/4] dt-bindings: net: phy: Document new LEDs polarity property
Date: Fri, 15 Dec 2023 22:22:41 +0100
Message-Id: <20231215212244.1658-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215212244.1658-1-ansuelsmth@gmail.com>
References: <20231215212244.1658-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document new LEDs polarity property to define what mode the LED needs to
be put to turn it on.

Currently supported modes are:

- active-low
- active-high
- active-low-tristate
- active-high-tristate

Mode is optional and if it's not defined, a default value is chosed by
the driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v4:
- Drop support for global active-low
- Rework to polarity option (for marvell10g series support)
Changes v3:
- Out of RFC
Changes v2:
- Add this patch

 .../devicetree/bindings/net/ethernet-phy.yaml         | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index 8fb2a6ee7e5b..282bf18f50fd 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -225,6 +225,17 @@ properties:
               driver dependent and required for ports that define multiple
               LED for the same port.
 
+          polarity:
+            description: |
+              Electrical polarity and drive type for the LED to turn it
+              on.
+            $ref: /schemas/types.yaml#/definitions/string
+            enum:
+              - active-low
+              - active-high
+              - active-low-tristate
+              - active-high-tristate
+
         required:
           - reg
 
-- 
2.40.1


