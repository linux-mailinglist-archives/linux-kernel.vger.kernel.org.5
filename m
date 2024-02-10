Return-Path: <linux-kernel+bounces-60535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA53850649
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB3E1C23251
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645535FB8D;
	Sat, 10 Feb 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUW2pYLt"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE48BF4;
	Sat, 10 Feb 2024 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597978; cv=none; b=FYfAxacKF4QGKjWqyrlNrhul8bNDncEqXqlqT9Oom3xpXFB48sSrOj+s4JLT3YN2RuGYDUzshxtFNGkEMbeYSAeJVDz4RYsLvui6NDQqjwyQGfNzbAnZGpLElJC5a1WJXdY/si7e8JWYOJua+5Si6F9FwCOm+d4OswghzNDMLCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597978; c=relaxed/simple;
	bh=RNqSd/ObHIvfQ8aY7qzUp9lWuC/QJSdJd609GIP6/XE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AYRMKzZJFt+AoPZzZbowvXsn9PW+0Jok7Q4XQ9CmQmCUQoxK6reJEpT39u6ObTYXlBZLStpj9djHHmgY3MUj/2/lu1HhyPS0h+UqXm0E3DOFUSzY+1EOpl+eqwWkJJz0hEYdGUo1Z4UkP9+gMEPsErIr1L2DFWph7DWlRiSqnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUW2pYLt; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68c8d3c445fso11044316d6.1;
        Sat, 10 Feb 2024 12:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597976; x=1708202776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9dpTBORzvcr6rF6XXf+SosfV3PtzsuSPAw4k+uR/IS4=;
        b=FUW2pYLtKhbchSzcroaY37wbiaBkz3xZKEs3/48K2J/4UKdIH2NR1h/nNNzqiiDQh6
         GEZU0oadWkltTFlFlBQesJ9bZBEp8MhjCk9myv/CCoYqHpKHYJo25vpduppdACsfXopn
         uYoNrJV9lgovrLPf69oJ4L7Q8g9qppNwwGO6Qbojtn7DRPAy7XdILJqCe6Np3QTCKxKH
         7Y58XJz5f26o0ivWt12rSttlKPTttPXNxTdMZOk3p6RA7fELbX7TPB5mzfpYOeR+E+/z
         Bo6HicNSKqYgLSvqdhRKhkqXXngfsNHfwnB6VKe7LdUS7QwQQRmfRBkFIHmphXxhQLOB
         mtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597976; x=1708202776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dpTBORzvcr6rF6XXf+SosfV3PtzsuSPAw4k+uR/IS4=;
        b=sAssikBGgUKP/hHWO12RC0YVbQiT8/TZk0uxHBjOPweCppKC63VaxF7c34mjyKQ0AV
         mBp4ezMZjsEGWl9CwrhQjTjzN6V049uSsiXLQw+ACHgHSGPABP/MuUa9aeB/mVrYy2jD
         Kiw60msBmpP50jWcwx6f0ubjRgoSL4ZbLGTqNTp/buVs801+BfUuh/DGPoCWnVwGW9Of
         on4SpAjX1Re2Tam/Vy7eWQvKvD7vHeZRMenL04eaPruvRnwCADpc7GHQUTfUb6Z3BYtO
         36QoxQp4+GI6rzia1r7NSwF4bVdjcRCC4l9VJ8lohaBWHNa051gLhu7BnCIwAf6GpN+E
         yyZg==
X-Gm-Message-State: AOJu0YyiPg3PskU+S8TDnd+2J/ym67Lz3oAOSPvoi1FVJLEc91FO95d0
	n2xP2CS5RvdAPtV7dPNzlTZ3Yak6Q3XNQaaEBpnpCnHWpTL4mCDM
X-Google-Smtp-Source: AGHT+IFcn8J0TevF9WZ6w5Db5BRLWD3hiNNHAAcu1bnhmw5dWyBjVgAFHcF70cj/6k2D46yZO4ZoZg==
X-Received: by 2002:a0c:e2ca:0:b0:68c:bda7:3dc7 with SMTP id t10-20020a0ce2ca000000b0068cbda73dc7mr2745130qvl.20.1707597975693;
        Sat, 10 Feb 2024 12:46:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVtj022cdUZKFt2ePjfGc4JKbsKkFj6bg3zIoePxxP1sTazxeh8eFGAfhvuIOn7ORN2GsRVQ3vc3NxGOvSALHJZO2uvK82axmWazGDk0DzCJqNK19aYH69czBhQEtdAfiEaouvJvm3XtgD0XKlQtF/yc0HO+OASYiawWCzlv5Ac/8FQ7Ns+DQWEVrk7HEe6QL3Judr68ASTXniexW411g8OuPul8u8p49TF6cvyv9tgkOcEmlpJsxbjV3zO4og49z5EptcKrLdT+KzLMeAHuskQZHESfyTYarv08caQ4gXL0PXjoiv5l20AdGaI5F1VAbHXFiRQyPR4JxiYDAFasnhRSAVGoIR2GGOnwxE5yw68VoHGY3yMgLN8Quj0TDye8s+Vxn1QBwJ8Haij2ubzvW01t9YjBtNlHrJBn4TI3s3BCbL3F9S1wGkQRrTec3bNBC31Le8VnILwHzPjuwWygrEU6aywkGafjBhcaPDr9bolqob8hxTx3/c85g6TU/KV42H4jYoKI85HWNphpKVMP66M4MRO+u9hB6ect+KHP5r6NQD3t/IfXJX2BwWaT6k40n6qb93M/s5YO619NY5odfPB/RZnK5ILdxPm/W8irVKibQ==
Received: from aford-System-Version.lan ([2601:447:d002:5be:27d7:3989:2897:88a7])
        by smtp.gmail.com with ESMTPSA id m20-20020a0cdb94000000b0068c9db26ae1sm2079526qvk.41.2024.02.10.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:46:14 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 0/6] soc: imx8mp: Finish support for HDMI
Date: Sat, 10 Feb 2024 14:45:56 -0600
Message-ID: <20240210204606.11944-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The i.MX8M Plus has an HDMI controller, which depends on several
other systems.  The Parallel Video Interface (PVI) and the
HDMI-TX are already in the Linux-Next staging area 20240209, but
the HDMI PHY driver and several device trees updates are still needed.

This series is adapted from multiple series from Lucas Stach with
edits and suggestions from feedback from various attemps, but it
since it's difficult to use and test them independently,
I merged them into on unified series.  The version history is a
bit ambiguous since different components were submitted at different
times and had different amount of attempts.  

The previous attempt I did used the wrong starting point for the PHY,
so this update includes a newer starting point with tags from that version
and fixes from various people's feedback.  I hope I caught them all, but 
I apologize if I missed something. Any tags from the previous attempt I
made were intentionally dropped, because of the significant change,
but I kept tags from the newer version I grabbed from patchwork.

Because several items from the last attempt were merged, this
series is only focussed on adding the HDMI PHY driver, and enabling
the power domain, irqsteer interrupt controller, and HDMI pipeline
in the device tree. The version numbers are a bit strange since
these all got pulled from various attempts with different versions,
but I wanted to push them together as a series to complete the pending
work.

Adam Ford (1):
  arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module

Lucas Stach (5):
  dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
  phy: freescale: add Samsung HDMI PHY
  arm64: dts: imx8mp: add HDMI power-domains
  arm64: dts: imx8mp: add HDMI irqsteer
  arm64: dts: imx8mp: add HDMI display pipeline

 .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |  62 ++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 145 ++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/phy/freescale/Kconfig                 |   6 +
 drivers/phy/freescale/Makefile                |   1 +
 drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 721 ++++++++++++++++++
 6 files changed, 936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
 create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c

-- 
2.43.0


