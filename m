Return-Path: <linux-kernel+bounces-14019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C078216F3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D50C1C21066
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A210E1;
	Tue,  2 Jan 2024 04:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McPftOsw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93310F3;
	Tue,  2 Jan 2024 04:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59574cbcd50so211216eaf.2;
        Mon, 01 Jan 2024 20:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704170773; x=1704775573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WadGb93wcdGqbFMpgW0CWGdc7fJXwJMMfPquKTGcV6o=;
        b=McPftOswCjX+1RRqnskjpWkBckYiaUXVrfVmQEWvpbZ1jrivIoyqs0HM/5MmYLhxHI
         gD3C7dcrTw87n1X7nRjBYGbsEUr9BWIGnK27rWNDvRFKos7to1wnScMf4g9fYaY9CcMl
         fwpIgjKumchvpZ77+JbTy7TlGv2JEta1ab1xT6gv2k+/gwgtN8Ne+5oGAPgNTHFLAGOg
         T3gZaflxrYZYMIRqtTfvadUbdOP9L6ACn3uv0NJWA6XOvNv4kfnr+sXrhqgMNPywWFwk
         6G5pvn3cbzNC89IbbSAkSWwoD6oX0M2QkBf67fUaKKHvgEMkYxIK5rsmd4SXpgDeHNX2
         ONWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704170773; x=1704775573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WadGb93wcdGqbFMpgW0CWGdc7fJXwJMMfPquKTGcV6o=;
        b=wzMeT9H8H8wX2eRFm9Nwebf6F9xqlUvTNfsK1O4Fx6j0yAdqx+KgjALTbJ706wJVBl
         8b/Y4hJ0x6nel0SvY2B18xaijubwLd4TP8zyhMfRnT1oteFUSp8Z1/yBgqfmEeCdW/G2
         lLL8KEbsBsD3uUZhAEQGNsB0oLFf+RuwDBRjG31esK2E674ED7ofFR5YFsXUuJPd3HS3
         TuEm4/uhSxZTwZXVLZKig5X/U1U6pYGi9N/r1lG/Xs06XExlpjqU4X67CtO7//LnmSit
         IEui3xMrigCEZUZCGy7IVXjflDMm8Sup1LI54S0a0LQ+YJMAKxDK1g/tr0vCW+2gOSkF
         Z1XQ==
X-Gm-Message-State: AOJu0YyjMGWoEQq7YvYqCe9uOdPCR4Tpikgh28vuG08oKWSIHV94FdlN
	8cAh6DRDWnHYxsWrUFn/BUQ=
X-Google-Smtp-Source: AGHT+IGJLGIyXfa0cwAT3dmM5lPGsGGqjHONG9Hq4FkGUf6JDZ8upsGNJ+Bksprs4p7mlqvCuKWsJg==
X-Received: by 2002:a05:6359:2e9f:b0:172:d67c:61ce with SMTP id rp31-20020a0563592e9f00b00172d67c61cemr7454495rwb.9.1704170772880;
        Mon, 01 Jan 2024 20:46:12 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b0028c2b2b76c0sm17308392pjs.22.2024.01.01.20.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 20:46:12 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Tue,  2 Jan 2024 12:44:04 +0800
Message-Id: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw@mail.gmail.com/

Change log:

v1
  - Patch 0001 - Revise SGPIO line name.
  - Patch 0002 - Mapping ttyS2 to UART4.
  - Patch 0003 - Remove Vuart.
  - Patch 0004 - Add cpu power good line name.
  - Patch 0005 - Add spi-gpio.

Peter Yin (5):
  ARM: dts: aspeed: Harma: Revise SGPIO line name.
  ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
  ARM: dts: aspeed: Harma: Remove Vuart
  ARM: dts: aspeed: Harma: Add cpu power good line name
  ARM: dts: aspeed: Harma: Add spi-gpio

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

-- 
2.25.1


