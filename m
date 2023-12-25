Return-Path: <linux-kernel+bounces-11027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE26681E039
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA281F220E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E551C3D;
	Mon, 25 Dec 2023 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhdOYgJF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CB5102F;
	Mon, 25 Dec 2023 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d4d9d9b77so20855325e9.2;
        Mon, 25 Dec 2023 04:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505815; x=1704110615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9FH57aGkJw13IKFppWR0d0ExXBNDN8V4v9B+/Ni+Oo=;
        b=jhdOYgJFul0zsAMk/6d2TXC2T85GIcPOBnpTOnMq/k4Bo/9q3mx4xxUSqF1R05ovXk
         tA2+5W2HMdw9xjx3sqneqvl2eLai+WmLLtBAgSWdD2hH5QQriTPplFbyKQzDq0czwZel
         2lCQVTGsP5dEi9AcXtVOvempYDiGRm/66Rdq62KAizcTVMRzvrTkf9imFTWdbVlBLFPj
         yKDg/f8+lLCyF+fHkdvooJB98C2gWm6cxt+pzFhReUtHmJqY/oyMl1lhs19wL+FLvckC
         fdpQ1ALd4w3B/yutQTElysEIB61JDGweLmfjXLnRrAjPnjhOEJDiu7FMwL8fvhEPPN1+
         IBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505815; x=1704110615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9FH57aGkJw13IKFppWR0d0ExXBNDN8V4v9B+/Ni+Oo=;
        b=E3/iCgiZ6gLHrBWLxcF8HW/tyQpxMFcaKRYYUT5ObpRhUVV9GThOoBAhyEWvN7TD6V
         i+D0Yp/dBx83nBfAD4gZeVZovCzHmRBig8D8BazS5FlCJEilk7pf0VHE7GgYvMnVxD4Y
         bPzsM9KKoSM1Vt03bahkHosx6YCcwCVkFOipJRemHXcsFADm1jWImKr+u5YNoecw3yCI
         5NamBHkWqsoWxz6pHyzWZYJH5cNVcPo6jXFkb0sOBdviCAEX1azOx0VJQBxG5Gj54/gS
         tR+ZKj81koZU+7Lg72nXWcaWiORmp6w79P4ux5Z5gh7GmkDNJpO73EQoKpC2d0EsUjRn
         JlFQ==
X-Gm-Message-State: AOJu0YzM1Z2PbpWKYq43kSzNPllpl77n3DtAvBr1i7e9UzQwm0f+oNlp
	FOyTP8HZqmnCN2Zv5A8nQgY=
X-Google-Smtp-Source: AGHT+IG/Vs2hMcBk9dE1QNzxQyPaPfS892cgWA78VxcazBgLVeHJwXbFGn9Y6zC2d9xt6CMKPtcfRQ==
X-Received: by 2002:a05:600c:1c2a:b0:40c:5971:6162 with SMTP id j42-20020a05600c1c2a00b0040c59716162mr4046285wms.81.1703505814885;
        Mon, 25 Dec 2023 04:03:34 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:34 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>
Subject: [PATCH v3 0/8] Add UFS support for SC7180/SM7125
Date: Mon, 25 Dec 2023 12:59:53 +0100
Message-ID: <20231225120327.166160-1-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces UFS support for SC7180 and SM7125, as well as
support for the Xiaomi Redmi Note 9S.

Signed-off-by: David Wronek <davidwronek@gmail.com>

---
Changes in v3:
 - Use SM7150 UFS PHY compatible as a fallback
 - Fix dts style issues
 - Add regulator-allow-set-load and allowed-modes to UFS regulators

Changes in v2:
 - Fix device tree binding for QMP PHY
 - Separate ICE into its own node
 - Fix style problems in sc7180.dtsi

---
David Wronek (7):
  dt-bindings: crypto: ice: Document SC7180 inline crypto engine
  dt-bindings: ufs: qcom: Add SC7180 compatible string
  dt-bindings: phy: Add QMP UFS PHY compatible for SC7180
  dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
  phy: qcom: qmp-ufs: Add SC7180 support
  arm64: dts: qcom: sc7180: Add UFS nodes
  arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes

Joe Mason (1):
  arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S

 .../devicetree/bindings/arm/qcom.yaml         |  1 +
 .../crypto/qcom,inline-crypto-engine.yaml     |  1 +
 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        |  2 +
 .../devicetree/bindings/ufs/qcom,ufs.yaml     |  2 +
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi          | 70 +++++++++++++++++++
 .../boot/dts/qcom/sm7125-xiaomi-common.dtsi   | 28 ++++++++
 .../boot/dts/qcom/sm7125-xiaomi-curtana.dts   | 16 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  3 +
 9 files changed, 124 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm7125-xiaomi-curtana.dts

-- 
2.43.0


