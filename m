Return-Path: <linux-kernel+bounces-72136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A54A585AFD7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 300B0B217D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5161F56B74;
	Mon, 19 Feb 2024 23:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgEsfXpQ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE0C537F6;
	Mon, 19 Feb 2024 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386292; cv=none; b=HC3CkeyMsrLxM/gXgOf3F5f079OkdC3xUl9vROXIpCCG9wiHdc3eT/Qu/H1tTPXAJGvznqk06fpPY/E+fc3BO+aLXqkMORuwrT/2I2ia6ABexIjEbpI54diod0iaQ83dmfuCK3VOfLchhfY4NeFvwEnc7j0R9NCFrzSJhEH3SG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386292; c=relaxed/simple;
	bh=8QtiyWrWfuzQjwuwyJxh0N9o8CzHsc9182ryunCiVNA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ovTp/aKUHVeGAGnV05zSLoeIZPq3vsqyAktR7U9S+eLF8xZnRRduMgCoa8VP7QsmEWgRVuYDEFUGyFBNIdD05yTsQcjDdbXdRSal0O7SQ52wEgK8s3UEtg2wZil6MQy1Bs1iNVO8UFKobwX1rv5GtxnArYbEuqle2dXlZgwmtEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgEsfXpQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e22e63abf1so1419073b3a.3;
        Mon, 19 Feb 2024 15:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708386290; x=1708991090; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1aJuW6j9tgwUyJl9DgLg8w9vuSaZM6Q1DPHNzf8iOI=;
        b=PgEsfXpQSBJGfS7CcmB+ywPMeveehd45br/RyVassjYKBgRVhzFT78iKQ1kxiojPxo
         ArpMGUmKBZpq6dFd9aHo0u6qn4jFuXd/9rpTJfZM4uGyIklIpc/3cyHnDzB4vfDNZQ+4
         11X/EOs/uKZE99dzXggcOEsc0HbiYhdhhJj226rh+5CaQJj4cO82fgBPCBjaZur4c1PF
         o4UB4V4nYQ7t03Lgf8rMnBHhJnC1qVFYyRGwHQ4+uhDz8+0Yq16m7HYfuDVBko7hcztG
         unTdHioSjEZ8GTDGrU0h0tVwlWsogbEwipcBx8cL3lSzBCegqJcskwyhIgp97MhBS90J
         fffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708386290; x=1708991090;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1aJuW6j9tgwUyJl9DgLg8w9vuSaZM6Q1DPHNzf8iOI=;
        b=cZQPTuivi2Qb/zkDfgjdD5pQkIRlWu3t/4qxSYrag+yFqW35nPJwawwizBhlxoTIlZ
         oX/9+zES/DzTuSuWLXybNGsfsME6qRGtTrq9cIPPti7MoOe7hYnx/2Ey04UZ4vkJ/TcU
         5KMu3B7i5CC3Uft5WMPVjcsPrcQvTouZNTI00rl693H3hGwZ2Gl1lRx1WrtEqvxecAnZ
         6ttxdJNZheClyxJh83zq14fBkYnCQ1H4zlV9s0Q4EmL8acbt7ZyWwguU6tTmtd5oE6q3
         XEAQ7iGDNervHKL2HL99XxRToroHIUMDezMIW/FDtfSy1nRQAa7Vy0QN38IERSzFn6Wq
         hPKA==
X-Forwarded-Encrypted: i=1; AJvYcCWx18bthmgnQJblBO0WvllfJZ+bBR4ZBtdnxWw2bKs4S1OMLUqHDfLVP1LUthBeFW4z+1dpG67leO3PK+BCiWtDoZOWXNViux0FoUR3upPitSJ4oiulxsgDvhyclfxDMBGinoyAgbdOhA==
X-Gm-Message-State: AOJu0Yxo8/pLQ6g/Fg7jyzZO0P4fqLO+TQA7cgvJkn5T2Mr69xx26rD+
	e67AXCQmLMiA18O8eopqHLRUyQjA8C0MHxvLG2LoxEmBAZ6ZeRz8
X-Google-Smtp-Source: AGHT+IFi8j4fOnROdnnuPW1Igl7EDTZav1azQk8bJAAgCFTIAUNGUljNFn5PIbRTZgpJNbavS2bxxg==
X-Received: by 2002:a05:6a21:168d:b0:19e:9c82:b139 with SMTP id np13-20020a056a21168d00b0019e9c82b139mr12417262pzb.45.1708386290406;
        Mon, 19 Feb 2024 15:44:50 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001db7ed7ac34sm4903477plb.297.2024.02.19.15.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 15:44:49 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next v4 0/3] net: dsa: realtek: support reset
 controller and update docs
Date: Mon, 19 Feb 2024 20:44:39 -0300
Message-Id: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOfn02UC/12NwQqDMBBEf0X23JS4USI99T+Kh2hXXaqxJCFYJ
 P/eEHrqaRhm5s0JnhyTh1t1gqPInnebTXOpYFyMnUnwM3tAiY3EGoUjswZ6ZfUURNcZOUzYDgM
 i5M3b0cRH4T3A5oKlI0Cfk4V92N2nHEVV8h9T/TGjElIo3SlNrW50re7zZni9jvsGfUrpC3o1F
 vW0AAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2428; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=8QtiyWrWfuzQjwuwyJxh0N9o8CzHsc9182ryunCiVNA=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl0+ft4zDo/D6lzha4ZuSPn8C1KJ1vQeB0gCWV+
 qLQA9DxMfqJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZdPn7QAKCRC7Edu60Qc7
 VjUhB/9acQZ8JinWv+cLeQabihlpWgx9N2BiuteygJpRL6qCMRBhO8Z6Zpszdz1QshmEnKjjWtp
 wvrBVSE8aJNAmfsODpaKX6aaa5W4GB8a/ICCHFr6tOP0m3ezGQIIXmMgyl6DR5abhPQ1H9WNQqf
 Mz0xjAK3e+6BmcM101OfUsSyWNRoaEhoXajQqQSs5woqWBVliTH/79hwvDiD/4UDaPBv1l21gt5
 E3srGHoDUiFWPGp8DOxbXIOx1Z3KrD9dBO1qRenLI3IalO59L+D194r69aWcMEiaN9n/P1ddooB
 +05wFaIz5rn+nel1PJNUvkkYGhPCOcUtDU+hBDKSZ15xsMJc
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

 .../devicetree/bindings/net/dsa/realtek.yaml       |  4 +-
 drivers/net/dsa/realtek/realtek.h                  |  2 +
 drivers/net/dsa/realtek/rtl83xx.c                  | 46 +++++++++++++++++++---
 drivers/net/dsa/realtek/rtl83xx.h                  |  2 +
 4 files changed, 48 insertions(+), 6 deletions(-)
---
base-commit: d1d77120bc2867b3e449e07ee656a26b2fb03d1e
change-id: 20240212-realtek-reset-88a0bf25bb22

Best regards,
-- 
Luiz Angelo Daros de Luca <luizluca@gmail.com>


