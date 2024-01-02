Return-Path: <linux-kernel+bounces-14023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037BD8216FF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10FD1B21561
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABCC53B8;
	Tue,  2 Jan 2024 04:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC/dlTIQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853FB5663;
	Tue,  2 Jan 2024 04:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-781590ae919so465306685a.3;
        Mon, 01 Jan 2024 20:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704170782; x=1704775582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=DC/dlTIQzGkMmVG02EChd5hCHOUQ2qSANhpezTolibKud+UR+yDl21VztL2xYiSSIB
         Fv4V3u++D+IKM0OZR5eLP2XW9PGWm2nhTQZPimy0Ja+lUH3AcYkltfRZ5SR31VB1mcVW
         dxVE/EdrGjZXmjtjecnW+ygA/fhuPBIxOhLxklsqEAe2ltnSvPSDzS4WlQBEfAbU57Ac
         93fC0BvMq/UUKgsj8Rm9a3blN/bXbBpyBqpDK/eX3n2PHgwbPxPnedCOg05NW3/wOe7G
         RI+ETdGV/3IBpyB35Qqtlvk5yOjNJUxHpiOoF1YfOxR74Sm0TA7k3QHl8vkkY54piFL7
         Bdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704170782; x=1704775582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mmt0UdSDV+w1BWZtmNFxfAxPy3KjCbVYZPCzBNdDlQ=;
        b=Z1FuVBKi9Nky/UeNXoo/tmn8xcmo5080Z4WqkF/r+u0zelIUcE0t86VPzn2oGPjs12
         Z6qBY1lvqcOi+vR9XBLmR0NujeuKUXWDeKstYr513wDvZeyaTnm3fu36E5vYb6oBEVjW
         +N7ktJ6asYL3RYrrmv3O4FGg1dhI3MnYLeAFPo7ynhOVn5agBAFeJvggpJiZUdo3DqGb
         xM2iA56c36Cv+Kr2xu93xQ2OU811Dpx6ENHK3yN35NbatDFC45bqHeIfFQAfJojhRRdc
         0XNUFJbs8aB1NkHl2DzUyefGxuMVxe8P34Z3SfTZrPfxpF6rI7qRVeXvEOWMi9B6eiuA
         ycgA==
X-Gm-Message-State: AOJu0YxRwViEyOwW5Pk3Tp2znQpOYZ5VGL/pSBg6aIXxHjfroVlmGg+i
	4eyWovJNruH0+2gI1TvL8uI=
X-Google-Smtp-Source: AGHT+IFekV5ykuriyA0cyhHIsh3wYdvqjCWU5c4oxMfbMAa88xJi8Tq/V8wVvPx7CwejKkS8Ffl2Uw==
X-Received: by 2002:a05:620a:4ace:b0:781:bac6:e252 with SMTP id sq14-20020a05620a4ace00b00781bac6e252mr3738109qkn.8.1704170782408;
        Mon, 01 Jan 2024 20:46:22 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b0028c2b2b76c0sm17308392pjs.22.2024.01.01.20.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 20:46:22 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] ARM: dts: aspeed: Harma: Add cpu power good line name
Date: Tue,  2 Jan 2024 12:44:08 +0800
Message-Id: <20240102044409.3810873-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
References: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a line name for cpu power good.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 5d692e9f541e..36aad01dda20 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -501,7 +501,7 @@ &sgpiom0 {
 	"","reset-control-cpu0-p1-mux",
 	"","reset-control-e1s-mux",
 	"power-host-good","reset-control-mb-mux",
-	"","reset-control-smb-e1s-0",
+	"power-cpu-good","reset-control-smb-e1s-0",
 	/*E0-E3 line 64-71*/
 	"","reset-control-smb-e1s-1",
 	"host-ready-n","reset-control-srst",
-- 
2.25.1


