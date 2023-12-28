Return-Path: <linux-kernel+bounces-12814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B681FA5A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B56A28509C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 17:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12467F9E4;
	Thu, 28 Dec 2023 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxFCCc0f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2CDF9C1;
	Thu, 28 Dec 2023 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68009cb4669so24795546d6.1;
        Thu, 28 Dec 2023 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703784626; x=1704389426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4Z7YQkAwcysiA9pCezffCW5EWUHNwwvsbHz268u+54=;
        b=TxFCCc0fNgbCiRRiz9OQFBDdFev1mIb8nlmUGljdUQqOACMlCNFTEZL7ejw7lm+Zme
         SY2LewswnZgif7MixB1lJceRqtHkHerwfaTWza0X5ltUZV4DFVOeKgGVGyCpQ0RNmrdC
         zKszS/1GdTGruOAuPILF1C1pfPiLXpl0CpgT3NIb4z0nvs8vwAdL5EthusizeqUjDwJ1
         Ah53h0YJfGYE+bZ4kRlhvMBA4B8mQebwDYYRitz1DxzxgkFoXw1lpton7gp4lz/dL87Q
         hcTdQWdhNv+NUwnDl3aISJsEzzGdXwU/m6rklxVC/DbMt2uExU/rtGZ8snhJeZWZ3wzU
         yGWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703784626; x=1704389426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4Z7YQkAwcysiA9pCezffCW5EWUHNwwvsbHz268u+54=;
        b=j7KRUu/LRtIsZtdqf23mKzq01Np9cvglUP2AkPRprd1YU/1HI6S2JM55Va1nXgNNrk
         WCkKALeFExz4OqeNPXmu63kYi5Yve4DOP7mkw871MWHCzrQBavMRBqD62tbjC63tm65l
         tQyDxai+x9rzE2K777Aj2y1L1F7WZ9LFXUbefWPU+w7TkTy0j8wgWraDn1lSrsAwja+s
         D1o9f7Gt9xP7Vxhoig3uKXvcPogfg+r4Ze+NifyMzsW6iKl3+w8AwR4oIx0sUhxGbmCw
         TTYJDmQblVeCqmfaOdGw7T1YctSTQQS+rwQsB9M/U29ycH6crIQFZhvCF2uToae3Hq4N
         oOrA==
X-Gm-Message-State: AOJu0Yy4g53KNk19Qs0WyqILu/kjvhbuP8Kg7/8u7LPG93ZI0aBo9L7a
	lsl9iEWH0XBo8grbAXwGNTM=
X-Google-Smtp-Source: AGHT+IH1asPUVNlDf2zYCLocNWw/DPbpdqhnc7Umuc9yND5MTYpiYP5Pk0oH9N3IonyIP77uoBbtGA==
X-Received: by 2002:a0c:d7cd:0:b0:67f:f29f:93d6 with SMTP id g13-20020a0cd7cd000000b0067ff29f93d6mr6401646qvj.129.1703784625812;
        Thu, 28 Dec 2023 09:30:25 -0800 (PST)
Received: from localhost.localdomain (107-015-241-140.res.spectrum.com. [107.15.241.140])
        by smtp.gmail.com with ESMTPSA id da7-20020a05621408c700b0067f2c03d4adsm6392917qvb.100.2023.12.28.09.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 09:30:25 -0800 (PST)
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
Subject: [PATCH v2] arm64: dts: rockchip: nanopc-t6 sdmmc device tuning
Date: Thu, 28 Dec 2023 17:29:35 +0000
Message-ID: <20231228173011.2863-1-inindev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drop max-frequency = <200000000> as it is already defined in rk3588s.dtsi
order no-sdio & no-mmc properties while we are here

Signed-off-by: John Clark <inindev@gmail.com>
---
Changes since v1:
Additional scenarios need to be tested for proposed regulator and
cd-gpios changes. Withdrawing those submissions for now.
- removed proposed vcc3v3_sd_s0 regulator
- removed proposed cd-gpios
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index e83b71510a47..d7722772ecd8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -536,13 +536,12 @@ &sdhci {
 };
 
 &sdmmc {
-	max-frequency = <200000000>;
-	no-sdio;
-	no-mmc;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
+	no-mmc;
+	no-sdio;
 	sd-uhs-sdr104;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vccio_sd_s0>;
-- 
2.43.0


