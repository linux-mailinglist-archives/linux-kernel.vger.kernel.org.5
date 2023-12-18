Return-Path: <linux-kernel+bounces-3526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 885BA816D60
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314DE284AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2A2208C6;
	Mon, 18 Dec 2023 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grd9U0yu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDD4B148
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d098b87eeeso24944585ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702901246; x=1703506046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YIT2xVBZqZYxPQc446/fiLF5Jt+cT22dHCDUQGgryDo=;
        b=grd9U0yuqervyuUiZ3fggnMTV5KN4l18q9swL+e8abU+xzs7mlWvboiTt/HgUf+Dvs
         7RoM9pgl5kVJwQDMiezRo04n1dKsnRR1CpuDQuFkBV2Ykp7/T0ivX52KZt2c6pkYCrJW
         LWBhlBIGFSiSYHak2DUQmROIQBO3G9ElBe39a4CZl/I4c8jSVRFtWSvpasl7SM7Kv4hg
         2ClWNJZRFhGt4uA87IYzcRZE6alsCXlx6Nb+W62MzUAKP3rvxWxcAtCN0cdekp1xSKHc
         uPD4j1D5shHazyW7xRXQjSJp2sH2JkpxRULZHcz+0tCqyF45hu60yTtnBZDVF3Mbffc1
         N7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702901246; x=1703506046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIT2xVBZqZYxPQc446/fiLF5Jt+cT22dHCDUQGgryDo=;
        b=SYW+FzeSb5NR3LJyZf4qxe8Lrv+7Z52YHb8dDVuBTFYHMlzXGDEPOPqpl1I0hy84w8
         ELqVNSveL2qnSGMm/COqf02NQMqlTKqVB0EAEJi6Um2F2qIr3T2XOkBfjFpFTR9Yc5Sz
         KqCaPXIFw0J+syX+fMwcMyTVJNR1o67Jz9rExReTsmb6OxoXXEjH74Wt/w24XNdhil+8
         TcQsGygWAbMlQKkEKg+gkbyx2t6yR1mFY8UMYBCZ+VZRmhv007SQnyajJ9QUX+Sx59ju
         fYxZf3SJR/mHv+P/8ylYMcypCCiTDEQUZTekZzPBxBX95EQuStdO3sTsWmhLv/Ul6K8W
         3R6w==
X-Gm-Message-State: AOJu0Yyvfg0lEjUiM6sTHLt2hcJe2c7o2bGGNcjKeV0tYq915O1ONqMk
	oXxo1Wc3LsWoQBpP4S1gzYwZ
X-Google-Smtp-Source: AGHT+IF62LWkz3lwkpu0WCkUeFg/+ogOnQjhslOLrme1tMp/qFPlFNc7VzU99h5VQR80pJvwZd0X6Q==
X-Received: by 2002:a17:902:ecc1:b0:1d0:60cc:7ebb with SMTP id a1-20020a170902ecc100b001d060cc7ebbmr19506524plh.25.1702901245929;
        Mon, 18 Dec 2023 04:07:25 -0800 (PST)
Received: from localhost.localdomain ([117.207.27.21])
        by smtp.gmail.com with ESMTPSA id j18-20020a170902c3d200b001d368c778dasm1285709plj.235.2023.12.18.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 04:07:25 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: andersson@kernel.org,
	konrad.dybcio@linaro.org,
	vkoul@kernel.org,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	quic_cang@quicinc.com,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/16] Fix Qcom UFS PHY clocks
Date: Mon, 18 Dec 2023 17:36:56 +0530
Message-Id: <20231218120712.16438-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes the clocks supplied to QMP PHY IPs in the Qcom SoCs. All
of the Qcom SoCs except MSM8996 require 3 clocks for QMP UFS:

* ref - 19.2MHz reference clock from RPM/RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC or TCSR (TCSR since SM8550)

MSM8996 only requires 'ref' and 'qref' clocks.

Hence, this series fixes the binding, DT and GCC driver to reflect the
actual clock topology.

Note that the clock topology is not based on any downstream dts sources (even
they are not accurate). But rather based on information from Qcom internal
documentation and brain dump from Can Guo.

Testing
=======

Tested on Qualcomm RB5 development board based on SM8250 SoC. I don't
expect this series to break other SoCs too.

- Mani

Manivannan Sadhasivam (16):
  dt-bindings: phy: qmp-ufs: Fix PHY clocks
  phy: qcom-qmp-ufs: Switch to devm_clk_bulk_get_all() API
  dt-bindings: clock: qcom: Add missing UFS QREF clocks
  clk: qcom: gcc-sc8180x: Add missing UFS QREF clocks
  arm64: dts: qcom: msm8996: Fix UFS PHY clocks
  arm64: dts: qcom: msm8998: Fix UFS PHY clocks
  arm64: dts: qcom: sdm845: Fix UFS PHY clocks
  arm64: dts: qcom: sm6115: Fix UFS PHY clocks
  arm64: dts: qcom: sm6125: Fix UFS PHY clocks
  arm64: dts: qcom: sm6350: Fix UFS PHY clocks
  arm64: dts: qcom: sm8150: Fix UFS PHY clocks
  arm64: dts: qcom: sm8250: Fix UFS PHY clocks
  arm64: dts: qcom: sc8180x: Fix UFS PHY clocks
  arm64: dts: qcom: sc8280xp: Fix UFS PHY clocks
  arm64: dts: qcom: sm8350: Fix UFS PHY clocks
  arm64: dts: qcom: sm8550: Fix UFS PHY clocks

 .../phy/qcom,sc8280xp-qmp-ufs-phy.yaml        | 47 +++++++-------
 arch/arm64/boot/dts/qcom/msm8996.dtsi         |  4 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 12 ++--
 arch/arm64/boot/dts/qcom/sc8180x.dtsi         |  6 +-
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 18 ++++--
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  8 ++-
 arch/arm64/boot/dts/qcom/sm6115.dtsi          |  8 ++-
 arch/arm64/boot/dts/qcom/sm6125.dtsi          |  8 ++-
 arch/arm64/boot/dts/qcom/sm6350.dtsi          |  8 ++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  8 ++-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  8 ++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi          |  8 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi          |  9 ++-
 drivers/clk/qcom/gcc-sc8180x.c                | 28 +++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 61 +++----------------
 include/dt-bindings/clock/qcom,gcc-sc8180x.h  |  2 +
 16 files changed, 124 insertions(+), 119 deletions(-)

-- 
2.25.1


