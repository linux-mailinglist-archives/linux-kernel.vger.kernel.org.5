Return-Path: <linux-kernel+bounces-43674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBB2841783
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C434F1F23E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A591E2030A;
	Tue, 30 Jan 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7H1f7kt"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7ED53C;
	Tue, 30 Jan 2024 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706574964; cv=none; b=k74Si18KkK5duOtQJvdVnApRDZiCc7FKWCvP8XPEw0HtSoVJ0Dvcy/wrgMDeOGRbd3n+POIW8AxEzYPz2KnsQpuRP/sNJGrMulpYlDj0MXnkVaKHPzF2ejrZFCs7viWko3TetQMsk4mayvg0VEHysI2hAiuDhropmPo41mVW0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706574964; c=relaxed/simple;
	bh=Suw9KF5ktIVTK5uerX+D/DxxdHAK+pd3QV3U4IsNHGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVWw7xkIzWYMkB5tZkz8X8cLfOB07CUtsLmVXXSvURX1Zw9WXuYWCwOrsHTTwIbxjblDJmZr8tdgp4kIh9/LFQMvBGlSdl2ei9l6ubJ+B70WbHQJGgiHvWD38FTns7RUFWzsjnV2mawncZPkt/JTtQGuEzmXY4PyC+w7K8LqEEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7H1f7kt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33aeb088324so1239140f8f.2;
        Mon, 29 Jan 2024 16:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706574961; x=1707179761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKfKNYMatjFN+InDvnfGVCOEtv8nXBV5jhJHJ4q+47M=;
        b=U7H1f7ktTXjyAEv78fPV4xO4vS6e8Dk9kb3AVMEwztOGkuXDwerZrManR4N5gzt9Fy
         PIsvU2gbm0p5+z7WwotfKTdfvsMVt+csSPIyq4NfjXWKHQvmTcDE1AgLr2PoKSJdVvhm
         h1PF09vuQ3siRlfZkL6UdoXdI1lry7AvVs+TusggtbMp6N47jow0IBJwJvDM33wvVBoO
         7EKBC9jIcQVVcwrslvalMWB7SlS+6WFHjtFQTGyPGsP8oqblAYbOp84FghBa8kBk43aR
         1iW3Pg5u7VrMpNXuqTiQLh7IYTKRHoRBWqWo7vhuyHf0Cw8A4SsL19njr9GqBwpxhcGh
         xC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706574961; x=1707179761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKfKNYMatjFN+InDvnfGVCOEtv8nXBV5jhJHJ4q+47M=;
        b=GdnEIoB4hetaMFadyBxMa+HeGdEascRgJIILbTBPKqfOu+bFormf8hs9kdGt4RnI69
         BLO/lbA+rX/ki7n4WDETvXnw0k5upTl6b3PxXRuvwTtIO/ATO3YajlVhGhT2QeUhPf/H
         eTD3yAQPISzRSfFEhJS1gSHzkMY7110AANJY5YhlTG1HfUe4aTM/BIylsfENsN4R5ww3
         C4PW5C0YXYpF9SrCJ6kh3wh4hG/CDW53Rd9LxrYGKvW+iCG1qHXAnHYmlEnoYqgnatZw
         xey419/xbzEDZUFFWf3UXeJ/zUMGv74DSoRIi/Mf8CTJgHFZjjmbkR1xbLbGSK/ytyni
         jn+Q==
X-Gm-Message-State: AOJu0Ywuj3+tX6NxBrlwcDZJZfXh6OTdY4Wp1LUgzY+jxyN6g6x0JzjG
	49/rgZmw0YFFoVD+A8STaeScz1x7Xv1yeKK972Iuzt6RjGBpNfM9YFA/ABTs
X-Google-Smtp-Source: AGHT+IGnxM/5A0fh67ZbMcGvRkzCWTBA5FTDG41xGcZ243wX66/qk48SoC+dJFNHI4/Vx9z2o1pV/A==
X-Received: by 2002:a05:6000:dcb:b0:33a:ea63:90cb with SMTP id dw11-20020a0560000dcb00b0033aea6390cbmr4128799wrb.55.1706574960959;
        Mon, 29 Jan 2024 16:36:00 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id l10-20020a056000022a00b0033af350fb88sm2542167wrz.25.2024.01.29.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 16:36:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jie Luo <quic_luoj@quicinc.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH v2 0/3] net: mdio-ipq4019: fix wrong default MDC rate
Date: Tue, 30 Jan 2024 01:35:19 +0100
Message-ID: <20240130003546.1546-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was a long journey to arrive and discover this problem.

To not waste too much char, there is a race problem with PHY and driver
probe. This was observed with Aquantia PHY firmware loading.

With some hacks the race problem was workarounded but an interesting
thing was notice. It took more than a minute for the firmware to load
via MDIO.

This was strange as the same operation was done by UBoot in at max 5
second and the same data was loaded.

A similar problem was observed on a mtk board that also had an
Aquantia PHY where the load was very slow. It was notice that the cause
was the MDIO bus running at a very low speed and the firmware
was missing a property (present in mtk sdk) that set the right frequency
to the MDIO bus.

It was fun to find that THE VERY SAME PROBLEM is present on IPQ in a
different form. The MDIO apply internally a division to the feed clock
resulting in the bus running at 390KHz instead of 6.25Mhz.

Searching around the web for some documentation and some include and
analyzing the uboot codeflow resulted in the divider being set wrongly
at /256 instead of /16 as the value was actually never set.
Applying the value restore the original load time for the Aquantia PHY.

This series mainly handle this by adding support for the "clock-frequency"
property.

Changes v2:
- Use DIV_ROUND_UP
- Introduce logic to chose a default value for 802.3 spec 2.5MHz

Christian Marangi (3):
  dt-bindings: net: ipq4019-mdio: document now supported clock-frequency
  net: mdio: ipq4019: add support for clock-frequency property
  arm64: dts: qcom: ipq8074: add clock-frequency to MDIO node

 .../bindings/net/qcom,ipq4019-mdio.yaml       |  15 +++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi         |   2 +
 drivers/net/mdio/mdio-ipq4019.c               | 109 +++++++++++++++++-
 3 files changed, 120 insertions(+), 6 deletions(-)

-- 
2.43.0


