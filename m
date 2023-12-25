Return-Path: <linux-kernel+bounces-11180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 853B181E293
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 23:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8145F1C20E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0197154279;
	Mon, 25 Dec 2023 22:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjX6NS9Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2A53E1F;
	Mon, 25 Dec 2023 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7811b05d23bso323565985a.0;
        Mon, 25 Dec 2023 14:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703543352; x=1704148152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBjIIiV/w0rycQ7ypCmDgdwnPkjj+juDPZk9jbDH0Jc=;
        b=QjX6NS9YfXJfUQT0eOf5SliWIJsrPEJg5EP7INqMXtT1m7ORufij/ASR4z1uHmhNwe
         zYoZaxo3BY82QQHyjZUO5j8VeytCpuRomWA7nfdUgcnwcOpmQ99TA/+WHU6MabukGFoj
         h+bbsFWpVWwYlOkWdHSaT630+2kyzNfAgt6KtW0lBkFzS4Wl+4KnSVN6a8b5YR+YrTYF
         fWG6un+nSxVkKiZ8lHT4jQYIJWmfDvjT4swFaL+nrGCqRAIQ1wywP5JWUcjB6YGoygP9
         bJqie6ZS7azCFfIuU+RgALSNJZM4He8qTMuT2irrc7eS5OyYvEw8amPcvwPm6sWtYzk/
         KdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703543352; x=1704148152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBjIIiV/w0rycQ7ypCmDgdwnPkjj+juDPZk9jbDH0Jc=;
        b=J4ct/Nghz48TOyKoO4YYDzR6gUbgPrtQoqA8NgGy9hsEImBtUI1qCkkw08o+MhsZM+
         74QZ+nanCZs6JNhRa97WluOVYCMNWIzAiwZB0izBlmej+1ayh1pWfhKpkrtAmteVB/93
         zXxhKi+AG1rtD45BNo4oB4V0G1jwEyEnemb/kIce7s32HmHXQiMZWTAeBY8AHup7ydNQ
         pmu5Yy9E+a1eqpy9Kc10WYeYqAR8cZ2Q5+dEooYku2na8eweVmLJWxMQ8b/fbFd1lBrI
         KtdcTE9/jnv07PQ/sJWfgrr8jtlIa9pYrBPG0SmV0uGutF7dxvPpGCMSOc4XypTkWmqc
         jclA==
X-Gm-Message-State: AOJu0YxLTV/sQfW9oL4T/7lW4aL0EQkOKVKZxMvF/bC1/O7/ydqD7axJ
	PGKdqPO/UALJetUMekU/JwQ=
X-Google-Smtp-Source: AGHT+IEq/qS6oCN+yyKq7dAPzoMeuKQ19G2WCt94dfb77pkr9X+bBLthS8GxgqrMi5vIWeihhcrsVA==
X-Received: by 2002:a05:620a:51cd:b0:77f:ad35:dc33 with SMTP id cx13-20020a05620a51cd00b0077fad35dc33mr7182979qkb.65.1703543351862;
        Mon, 25 Dec 2023 14:29:11 -0800 (PST)
Received: from localhost.localdomain (107-015-241-140.res.spectrum.com. [107.15.241.140])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05620a178800b0077f15eb3528sm3881457qkb.70.2023.12.25.14.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 14:29:11 -0800 (PST)
From: John Clark <inindev@gmail.com>
To: "Rob Herring" <robh+dt@kernel.org>,
	"Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
	"Conor Dooley" <conor+dt@kernel.org>,
	"Heiko Stuebner" <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org
Cc: "Thomas McKahan" <tmckahan@singleboardsolutions.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	John Clark <inindev@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: rockchip: correct gpio_pwrctrl1 typo
Date: Mon, 25 Dec 2023 22:28:20 +0000
Message-ID: <20231225222859.17153-2-inindev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225222859.17153-1-inindev@gmail.com>
References: <20231225222859.17153-1-inindev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both rk806_dvs1_null and rk806_dvs2_null duplicate gpio_pwrctrl2 and
gpio_pwrctrl1 is not set. This patch sets gpio_pwrctrl1.

Signed-off-by: John Clark <inindev@gmail.com>
---
Changes since v1:
 - added commit message with additional patch detail

---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index dc7b88f29172..a0e303c3a1dc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -448,7 +448,7 @@ pmic@0 {
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
-- 
2.43.0


