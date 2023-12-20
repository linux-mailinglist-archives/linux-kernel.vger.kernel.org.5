Return-Path: <linux-kernel+bounces-6657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 200BA819BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CB71F253CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BFE2030B;
	Wed, 20 Dec 2023 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emxF14ob"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A520B1A;
	Wed, 20 Dec 2023 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-553e22940a3so435222a12.1;
        Wed, 20 Dec 2023 01:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703065942; x=1703670742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGX77AFM52taWZ32rxqG8Bwre+qwZG4HAT6q9bfPoTE=;
        b=emxF14obejBu5tWJyKsIxgItFAKtDTrQ3pp71TcjenOVtwzce7t5P/Hi+FAtLQl/tT
         2X0wtxYuMoTs2fd/7cGl7fpeHv4DS944QhGP6Rz18fGjk6qCBPk/sL0oBZNIS46zJbFL
         JvoNm0KJhuKIHwSgXFGc4ejbgXIrUeA+vusUiry8/UkhXu75GNq8/L13hylSFNbTD7WI
         uTpstlyF4WA6L5dFUiIAW5i6BHdh7H0Kzv5I99su3GR5hLrzSLq8nL2wu2pMaw7opU/m
         srQIrcGFs3woYClCvP5RCPDndhz+XXrXASZYjcp1Iae2MJYCVQu32mLqeQMPa4ngRFB9
         28ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703065942; x=1703670742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGX77AFM52taWZ32rxqG8Bwre+qwZG4HAT6q9bfPoTE=;
        b=OZLUkCu9hEr0FGg58fZz/6xcgs3OudLQ+EVhpNHdPyeyGW0ZKT8dirHDl1mr/37ocJ
         ggssYlfuhnrgQcEx5CWNU4zFTrJ06BNALR/6bGoe3aHcDMo7HgeZYXPdB1OUMT1zFMF0
         5eMxyE+GvlvsVWHaSNbzO9sVHo3n1ZNynpE1+8v81n2xYdOnV582g+JYi96Ur8GUBe4/
         OqQ2hdcpzc3o8EykFUQP/W1DHFhTQ9TmUAkmB63mI2uthm+XrvZkh4ejWqvUOM9JBt0q
         /rBfmXEuLviR1qOuIweRSYqvsm48UnU730FLnSlpJsbvAm/JvitRJ9JY1TEio2Nz61pT
         24wg==
X-Gm-Message-State: AOJu0YzfEvbejbQ6ypHIKTs9d8HmyvZ7fPh5C6cwyOu53DIdHuk9sRxx
	le/T8jzGY2Og7bjfzI2Jjh0=
X-Google-Smtp-Source: AGHT+IFVwEX6DGx95xrmNxtWF3DNvy+WJuinCzQ56EUrqHU17sekrONr1kDAVmlp0UrKjEcsHl00/A==
X-Received: by 2002:a17:906:1de:b0:a23:743a:ac6e with SMTP id 30-20020a17090601de00b00a23743aac6emr1420552ejj.104.1703065941785;
        Wed, 20 Dec 2023 01:52:21 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.158])
        by smtp.gmail.com with ESMTPSA id st3-20020a170907c08300b00a1c4fde4e88sm16596791ejc.18.2023.12.20.01.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 01:52:21 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH 2/2] riscv: dts: allwinner: Fill in OPPs
Date: Wed, 20 Dec 2023 10:51:41 +0100
Message-Id: <20231220095141.27883-3-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231220095141.27883-1-fusibrandon13@gmail.com>
References: <20231220095141.27883-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifies two voltage ranges, in order of increasing stability,
for each OPP. This is heavily inspired by

https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L133

and

https://github.com/mangopi-sbc/tina-linux-5.4/blob/0d4903ebd9d2194ad914686d5b0fc1ddacf11a9d/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L182

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 2f1771c19..8e7bc8bd0 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -48,13 +48,17 @@ opp_table_cpu: opp-table-cpu {
 		opp-408000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt-speed0 = <900000 900000 1100000>;
+
+			opp-microvolt-speed0 = <950000 900000 1100000>;
+			opp-microvolt-speed1 = <900000 900000 1100000>;
 		};
 
 		opp-1080000000 {
 			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt-speed0 = <900000 900000 1100000>;
+
+			opp-microvolt-speed0 = <1100000 900000 1100000>;
+			opp-microvolt-speed1 = <950000 900000 1100000>;
 		};
 	};
 
-- 
2.30.2


