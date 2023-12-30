Return-Path: <linux-kernel+bounces-13512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F64E820785
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE871F21664
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE409479;
	Sat, 30 Dec 2023 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/FY4h8O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD418F45;
	Sat, 30 Dec 2023 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5e76948cda7so51770167b3.3;
        Sat, 30 Dec 2023 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703955067; x=1704559867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N7GzBuGBQMyhaiHbCBvaBY2rzm7i1pkPQ9l+6GmBtSI=;
        b=Y/FY4h8O7bznZ6U6u/fTRPUIdnj5bW+RJzFQRj4QVkWl/Yn4iMIW4ak6cerwVKsAvI
         qsSoBPGL1nX3OYRC5aGl0Zf+7dpdzjSdNdoOnVE1lDPL7I9cn/UFcV9lZUrAN4djZFlw
         Z3koaA2Xokvpv6GgUDdojUvUeGYQIGOjufdzOVcsIH3WIyeGQyJJDcUZZqhc1l7aQqhq
         DeVwnuRcTJ07E/6AYnZVqeQieUvID+cZqLxjm584IJo97gX1FOUUQzNbRgghL21tubGI
         HPtaSdpS06Pj0Z9n42G6AgqSx2nJCyd7tmTwEqxQWRvVk9YLpHcnPVfDV9ndKUFAgD1q
         5Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703955067; x=1704559867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N7GzBuGBQMyhaiHbCBvaBY2rzm7i1pkPQ9l+6GmBtSI=;
        b=SzN+SA0NnQB19c52ts+BPAO1H7uycljYS0GwMytu5YCIroZeRbdcRG9Q9HfSd2VYy4
         jb0w4l1iKktp2MQrhP3ghHRJL6el2eOTkC8kofYHVAFD8sc3agpub0abjq4UsORIrI4I
         KCNWb/2oF/ok/KdKnILi5N4zB81rNTV6TzjH4GSftuMXyNHQAadvXa22MzKa3R6wG6Gv
         mFm1NNcIu7rrOaoFCuvPLvWD5Jd/COtlW47/iknq7sHNYkIuhIiIUMp7Nw4lQxhL7Sil
         p7e1XIYIIU0LeqZi0ZMPvloB/EjknA+fPza0mfUp38HC6j2Z0nG7Do22DLQuzinaTalc
         Yq7Q==
X-Gm-Message-State: AOJu0Yw7zL+nXd6KQQ2b1M1qlwAOuliQnzAI+68Yt18neLPBNCZ4RwAZ
	iqa8fknjvzsSJOqx0aDh2kQ=
X-Google-Smtp-Source: AGHT+IGtpeNc+Ln7iph7NJ6Vjjx23Vos8GRu3WoJnP+4Eejsnt/jImrG+J6nX6J8LSomPjt7xl70lg==
X-Received: by 2002:a81:8d14:0:b0:5ea:5395:859e with SMTP id d20-20020a818d14000000b005ea5395859emr6193379ywg.11.1703955066933;
        Sat, 30 Dec 2023 08:51:06 -0800 (PST)
Received: from localhost.localdomain ([192.34.165.40])
        by smtp.gmail.com with ESMTPSA id u83-20020a816056000000b005e75b28b8a8sm9602988ywb.49.2023.12.30.08.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 08:51:06 -0800 (PST)
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
Subject: [PATCH] arm64: dts: rockchip: add sdmmc card detect to the nanopc-t6
Date: Sat, 30 Dec 2023 11:50:53 -0500
Message-Id: <20231230165053.3781-1-inindev@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nanopc-t6 has an sdmmc card detect connected to gpio0_a4 which is
active low.

Signed-off-by: John Clark <inindev@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
index d7722772ecd8..54445f929a37 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts
@@ -539,6 +539,7 @@ &sdmmc {
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
+	cd-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	no-mmc;
 	no-sdio;
-- 
2.39.2


