Return-Path: <linux-kernel+bounces-2716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1F28160EC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EC01F22D29
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF9F4E600;
	Sun, 17 Dec 2023 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lKtuZneb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5D44D5B9;
	Sun, 17 Dec 2023 17:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AC0C433CA;
	Sun, 17 Dec 2023 17:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702833716;
	bh=kMQB4e2QHPk7g2PPNEnNtBNn08sDePnOrRq8YPpIxq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKtuZnebNKLv2xBCYWTeTvdiRpqZcbatxoHtg3PGcdjwYx+gntxCRJyMLBL2jQsyo
	 WmD9Epz9NyGbrbH75V41PUTurUGnO2YnWqzpSNAfanWya0YWG26n6rvTFu+LD02jTf
	 ++z220WwvfdGaO71oPiU+BikqMF22vchHwbPhhfafZtuTdtIqZnZ9+oO0EScfm2U18
	 Wk791VW5rK+pisufrW9RSI462VuG3fh19ffavy9+9oGw8TWhQy7phjAD0MBbjeOriT
	 +AtgqSiGSBGf978hXYBIau/HC1xdDNdHEmgo6KQ3dDkPsGlR1qvudIUVu2nJkGwZSu
	 enl+pxixW9inw==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: qrb4210-rb2: Enable MPSS and Wi-Fi
Date: Sun, 17 Dec 2023 11:21:10 -0600
Message-ID: <170283349404.66089.15631744354616446674.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231104-topic-rb2_wifi-v1-1-fd45ae535d2f@linaro.org>
References: <20231104-topic-rb2_wifi-v1-1-fd45ae535d2f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 04 Nov 2023 21:56:35 +0100, Konrad Dybcio wrote:
> Enable the remote processors and tighten up the regulators to enable
> Wi-Fi functionality on the RB2.
> 
> For reference, the hw/sw identifies as:
> 
> qmi chip_id 0x150 chip_family 0x4002 board_id 0xff soc_id 0x40670000
> qmi fw_version 0x337302d3 fw_build_timestamp 2023-01-06 01:50
> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HL.3.3.7.c2-00723-QCAHLSWMTPLZ-1
> wcn3990 hw1.0 target 0x00000008 chip_id 0x00000000 sub 0000:0000
> kconfig debug 0 debugfs 0 tracing 0 dfs 0 testmode 0
> firmware ver  api 5 features wowlan,mgmt-tx-by-reference,non-bmi
> crc32 b3d4b790
> htt-ver 3.114 wmi-op 4 htt-op 3 cal file max-sta 32 raw 0 hwcrypto 1
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: qrb4210-rb2: Enable MPSS and Wi-Fi
      commit: ff753723bf3916770c1e2580fe1f34ad9d6f0283

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

