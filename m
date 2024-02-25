Return-Path: <linux-kernel+bounces-80200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8BF862BBB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B611C210AE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB34C18029;
	Sun, 25 Feb 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhwlnri6"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3B0175B1;
	Sun, 25 Feb 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708878605; cv=none; b=CRY3kGuPko5Vk6ItDCsa4QNhbPAfnBRRa15E8v6xT1fWp1xzgcFqLd+5tY/RRrdWo3cTbIMOXCYBZdP5eULmnuZbfvKRR2elwUfYUcMBxBJj2bgKlfRG5nuS3xm/AluDRL8XvpC9iPC16uyjYLFOuySQu0aqGQTlRVMV1mbVOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708878605; c=relaxed/simple;
	bh=4guceXm7JqD7FE8mAp8QWs5E4MPeZjZ52K4eeMVUmQ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mQEn+GGzlsbbjM2eBEDAaDhhjzKU4TdSqU0aiP99qO4IdfrHNcsoWMfzSvAdycsVQlOFnYBmV179Thr8GNgZU3d5FaDNCPiPMi272xu04xDErTu2Pla+TIn0wzc0fiBiL3b/hFqz78H6OCa8COX13dqqKRNt86xUG1Op5DNweh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhwlnri6; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bd72353d9fso1525473b6e.3;
        Sun, 25 Feb 2024 08:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708878602; x=1709483402; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uNJEXFGpk4yAstmGFnAIGxSja9Jjo+7NQAHRaWjDtYY=;
        b=Nhwlnri6R4Pyanw54mJmsQFnwttONHnVef2jgjfNyvFwUD/opwRGAxBo33++ExvHev
         L+vWP4VD2yAvxsQ9wOYs1Q5GmVkB9XXUJMn+OBW8tu/eTLxJhzMQjPhFeQUjD5aiLDV3
         pyFkgRWtmSieOwLXQ5uiO9IfAe16DhActLDCT1vxFJbOByMc6SLc76khWu2rVm9a6cbD
         PKGkNYfVGHatIZjQqCTRfwficV265whbM2E8alXmfACn4TP5w/eskdqowwYAKnfHbiCm
         IBvMubeSZXOgNTQQLRPOBukkIY/zWBKqqYMSwb3+p1JOItuHtOSSZFBHv+hbkWxbdieD
         dntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708878602; x=1709483402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNJEXFGpk4yAstmGFnAIGxSja9Jjo+7NQAHRaWjDtYY=;
        b=SQpQslZA/8cCxFv0inIo7VHwoUxWb9lqqkUfoO403aBeL1vQGYLcZJrf4C3U0i834t
         a9KydBpEqQd94WWf7BvIIwaC53uCBiWn6In0vVLct+pB1WF34kpbirQW8eP2xZ9wcEiP
         wL2lvf4lrjq+J3cVR2x5ovrCKtfMsrc70QoonjwcO42WmPI01HXXUat88hpQoCh92s1i
         UpUQH3f76o/9tzBVyThcMh7yD6gVYWy4pjDivmY1vhBKXG7xBrLXzEfDKZIZhTiADrhu
         /5eJb0oSSgYDKVP2GQyeT7zIXJUIh+EZjltm1Yf6am+uDG7gDT3om9zWC4ZkrXj8zLRh
         T9+A==
X-Forwarded-Encrypted: i=1; AJvYcCXgF/XdR4pgReQxD5FUgRuRMiHAZnmCZNX9EGJ9DHVDdZMv41FWYGfWxalPyHkVrkTx6zqBk6bsCH+rbwjLDgJPjVcP/Ug57uxNLzejqj049GVyDdcnTa0RAfjl2RUX7I6CX1UxulkO2A==
X-Gm-Message-State: AOJu0Yz5o6Vtk2y9ewBQvejcKZmHHFpD6XpaGvADcA/Go6/AjBNOuVJW
	A5hN03q+Wh5851my1YyRnaR0HGsgJAgcexmx6JP+gZJUaC0nbxpN
X-Google-Smtp-Source: AGHT+IHk+3H4yp2i3YGNHYDsa7ESXAzOfg+dWFU4CWmnooE/172tuzn1xUaI+ABtA8UvJS2CXLTADQ==
X-Received: by 2002:a05:6358:5713:b0:17b:759:65c2 with SMTP id a19-20020a056358571300b0017b075965c2mr6448644rwf.10.1708878602442;
        Sun, 25 Feb 2024 08:30:02 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br (177-131-126-82.acessoline.net.br. [177.131.126.82])
        by smtp.gmail.com with ESMTPSA id a12-20020a17090acb8c00b0029a4089fbf0sm2838367pju.16.2024.02.25.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:30:01 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v5 0/3] net: dsa: realtek: support reset
 controller and update docs
Date: Sun, 25 Feb 2024 13:29:52 -0300
Message-Id: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAABr22UC/12NywrDIBBFfyW4rsWMiqar/kfpQtNJIs2jqEhKy
 L9XpIs2q+Fy7zmzkYDeYSCXaiMekwtumXOQp4q0g5l7pO6RMwEGgkEN1KMZIz7zDRip1obZDqS
 1ACQzL4+dW4vvRuY8mHGN5J6bwYW4+Hd5lHjpv05+cCZOGeVKc4VSCVXzaz8ZN57bZSqmJH7p5
 kiLTGuprQYDjWR/9L7vH30e59HyAAAA
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=4guceXm7JqD7FE8mAp8QWs5E4MPeZjZ52K4eeMVUmQ0=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl22sE78pocRCNweliEnVncfNS6DISWyKDWIhEn
 NpOVNKpPCKJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZdtrBAAKCRC7Edu60Qc7
 VpX+B/9isBfrtbMraz1QW795IvYv/0LY+myNfCe/ITKCi9fu+0tgKQTsmF+gn2xPbkRKOlUyaCK
 I7K8XRszVfHJwTSiCBlfJ+jhhehbD5BFGMnDIB489/80pmc0xpfjyXTxhh3v26FDvPohdvI8AHA
 K6w8Z+eOoztp3+pnHerQhsUrEQgt5qZ/9EKFyjh+bMnA0BGlUM3uk/jgFzPLOV6MulpdRFjGU8q
 V28TQOREZ5uWUEZGZzJDmGuXYe2MgfsVRQIwDGpBjjyXIl4u5+byJ3IEt8YGrq4iSmFQEhaUKka
 XTxRfQSiyrOrOyMdkOOV4bBH+2gFnbgnL/OBAabL7bb/5IMU
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The driver previously supported reset pins using GPIO, but it lacked
support for reset controllers. Although a reset method is generally not
required, the driver fails to detect the switch if the reset was kept
asserted by a previous driver.

This series adds support to reset a Realtek switch using a reset
controller. It also updates the binding documentation to remove the
requirement of a reset method and to add the new reset controller
property.

It was tested on a TL-WR1043ND v1 router (rtl8366rb via SMI).

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
Changes in v5:
- Fixed error checking logic when reset controller (de)assert fails
- Link to v4: https://lore.kernel.org/r/20240219-realtek-reset-v4-0-858b82a29503@gmail.com

Changes in v4:
- do not test for priv->reset,priv->reset_ctl
- updated commit message
- Link to v3: https://lore.kernel.org/r/20240213-realtek-reset-v3-0-37837e574713@gmail.com

Changes in v3:
- Rebased on the Realtek DSA driver refactoring (08f627164126)
- Dropped the reset controller example in bindings
- Used %pe in error printing
- Linked to v2: https://lore.kernel.org/r/20231027190910.27044-1-luizluca@gmail.com/

Changes in v2:
- Introduced a dedicated commit for removing the reset-gpios requirement
- Placed binding patches before code changes
- Removed the 'reset-names' property
- Moved the example from the commit message to realtek.yaml
- Split the reset function into _assert/_deassert variants
- Modified reset functions to return a warning instead of a value
- Utilized devm_reset_control_get_optional to prevent failure when the
  reset control is missing
- Used 'true' and 'false' for boolean values
- Removed the CONFIG_RESET_CONTROLLER check as stub methods are
  sufficient when undefined
- Linked to v1: https://lore.kernel.org/r/20231024205805.19314-1-luizluca@gmail.com/

---
Luiz Angelo Daros de Luca (3):
      dt-bindings: net: dsa: realtek: reset-gpios is not required
      dt-bindings: net: dsa: realtek: add reset controller
      net: dsa: realtek: support reset controller

 .../devicetree/bindings/net/dsa/realtek.yaml       |  4 ++-
 drivers/net/dsa/realtek/realtek.h                  |  2 ++
 drivers/net/dsa/realtek/rtl83xx.c                  | 42 +++++++++++++++++++---
 drivers/net/dsa/realtek/rtl83xx.h                  |  2 ++
 4 files changed, 44 insertions(+), 6 deletions(-)
---
base-commit: d1d77120bc2867b3e449e07ee656a26b2fb03d1e
change-id: 20240212-realtek-reset-88a0bf25bb22

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


