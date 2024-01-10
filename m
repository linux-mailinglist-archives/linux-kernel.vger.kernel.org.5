Return-Path: <linux-kernel+bounces-22430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 165ED829DA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3361A1C226C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A264C3DF;
	Wed, 10 Jan 2024 15:38:01 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0A4C3A6;
	Wed, 10 Jan 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-557e76e1bd6so3086995a12.1;
        Wed, 10 Jan 2024 07:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704901078; x=1705505878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4XrHqEPP20R01xmGCuOPfv+KVCp64Vi1x9YnoG1SFg=;
        b=Yec0dMz+qlYYGXA8BComR+SImhD9KoGUA5oY1YqorNC/gSsPB7EJfq85lNSazRk7/J
         gWs92ERkMG68QgmQn3la/8SPJZpa7z8cGEkb9knHRa9kxWPmR1kK1ig2fXuhQ6YG+D/B
         INrNS6ZArBITSKcX8tjaJStW+FZnxZo0CWu8Idh1aa5h8x8fvOx9zUI8Uh8ukvriVqsP
         gw8Ozw9u3V55ogQY8Ibk7iwdyhdaEB9VRBtezfrWpZek1TEGu/SqswJBB0oRe3eG14iu
         zAYFvi/ZRSoY2AC4pErp+G08jTom0LYXKMFY8TtwPdEiJ6xeX7jjZ3LWp0yT3fjfiBdo
         5Huw==
X-Gm-Message-State: AOJu0Yw3q+Ny7pzInHAAJXpnfBgZ2huB50ibKMPp1WK0dtMd7vKtfYIb
	d57Z/V91tNLV2AoD+DlY5Yw=
X-Google-Smtp-Source: AGHT+IFds5J+pmhXNSFF50B6wsyc8BDblllR+tNwXXxBcdJoJr0VRCEx7inE4wKr+XwWw8//Dz/H9w==
X-Received: by 2002:a50:f60f:0:b0:557:c43:1fc3 with SMTP id c15-20020a50f60f000000b005570c431fc3mr498857edn.76.1704901077760;
        Wed, 10 Jan 2024 07:37:57 -0800 (PST)
Received: from ramallet.home (cst-prg-39-31.cust.vodafone.cz. [46.135.39.31])
        by smtp.gmail.com with ESMTPSA id da11-20020a056402176b00b0055668ccd9a3sm2113105edb.17.2024.01.10.07.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 07:37:57 -0800 (PST)
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
To: 
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Lucas Stach <l.stach@pengutronix.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] arm64: dts: amlogic: meson-g12-common: Set the rates of the clocks for the NPU
Date: Wed, 10 Jan 2024 16:37:01 +0100
Message-ID: <20240110153704.1364073-2-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110153704.1364073-1-tomeu@tomeuvizoso.net>
References: <20240110153704.1364073-1-tomeu@tomeuvizoso.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise they are left at 24MHz and the NPU runs very slowly.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index ff68b911b729..9d5eab6595d0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2502,6 +2502,9 @@ npu: npu@ff100000 {
 		clocks = <&clkc CLKID_NNA_CORE_CLK>,
 			 <&clkc CLKID_NNA_AXI_CLK>;
 		clock-names = "core", "bus";
+		assigned-clocks = <&clkc CLKID_NNA_CORE_CLK>,
+				  <&clkc CLKID_NNA_AXI_CLK>;
+		assigned-clock-rates = <800000000>, <800000000>;
 		resets = <&reset RESET_NNA>;
 		status = "disabled";
 	};
-- 
2.43.0


