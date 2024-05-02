Return-Path: <linux-kernel+bounces-166244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A758B97F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A341F24A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728455C33;
	Thu,  2 May 2024 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="Hfh+6qOF"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE890339AC
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714643004; cv=none; b=phzTAQEiw2Cp1ql8NCel+CIaUJK3UaClAPnc34kHhsne8dLNvH3GPMDFF5NnRzhyrQVmru0PrtxrHNFElp93urjAbnBMK1rZaAFGnKKOFxiyzHkfqHP5KJg+5YwGfKk9LKthGYsGUMVqzq13+Em+ebRPkkhCLB9Xgr4DtB79IJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714643004; c=relaxed/simple;
	bh=tURnXtG0YOwkSv3OubW0rz3dunjFwmkvDo4O0w5smXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEh3SIan02wuqVx6gYozavlUjs+q2qdatC0H2pa/DKALVAX1L2EzsQz9jMY212MjOTf8zYKFSasz9DFJaB/skQgLvwWdsZfEwFJ+N0acH39t6upkZtOafN5UMDCA9axO3G/NucrsMGqIDVCr+Ql6JLE0Kw8y1NqQiiElf5lq8UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edgeble.ai; spf=pass smtp.mailfrom=edgeble.ai; dkim=pass (2048-bit key) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b=Hfh+6qOF; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edgeble.ai
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so1224599a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1714643001; x=1715247801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiEinpzKbejXcwmY8FTfMGWznHTz6FpYxSICSjLHhRQ=;
        b=Hfh+6qOFt2IGcMwex9QjD4CfZMwBhYEAvahIGsXInQF2TrlJjHMpAVoGo0aZMbOq9m
         1US0KzT8+BSIafxR/Yb3OMsmVttIl0PhoDLXHmD+GLB5TBdi/DsiT/X86P53raV6MCYp
         CvjyLdFWf/9cMbMqq5UDGHDBhCayWVN+BkqYCxZokZR9Bl10OVvlzyhxD5uwpueKz0by
         ZZq+UiOlVIokPyhEo40qu7edoGV8ncvv1JJyQCoDMOXUn2Fmdvymve6AwxWDvGFKXLpw
         xCHPM6QVqa2bJ1OR4Pd1afbrCeD6Hta9R1RSxPkDzFp6SGlQ69IyjmetqZdlheYeXLnZ
         OMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714643001; x=1715247801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiEinpzKbejXcwmY8FTfMGWznHTz6FpYxSICSjLHhRQ=;
        b=MWlsT7OcA5FnyG9+uEiTLP45/1WFlVEOSofZlx2PnkBECejkWV+2iWy3800wpJdgxf
         qEGJVmQE/uvmJJZGHF8OJpbAKDbTM0PM7GdyATVRxLk0FMcGUIf2cSx3WBPp6XMDfQ5N
         lX1Ns6vIfawcitpXvYcmlXstHIQtsgrNFBWjd41bu75nAr4Fyn9Qk6sSZOUpCo8qJMGY
         tjPz/3SfA7OBf197f0KO0rR2B+nEPyvJg+BwHSy4mPtNKrZhEfDcsuIZ0hTIoqJ5ZNwk
         gYQFPXp7Sa/BBY8D9rsqjm4aFO1wlXrKZR/vKYaEk6xrzSXrIcxPFLt4JBzwoTGzRooJ
         iaOA==
X-Forwarded-Encrypted: i=1; AJvYcCUS0PHeuV7grj7bctAVeq3OaYwBUj79W8p3Q2XyiUuYa4mB4lm6ezCFZfQnpnAttF1r8e7sAnBN3NR/Qf2SWP04PeQYnieB3X0LNNhd
X-Gm-Message-State: AOJu0YyL1/YOnphzB6l43BBMZirfmaeljR0cJckm59p+4VPqs2Fjnsrh
	0aLHxCWdkblxq9qrIaQtYBFECGq02xDq0wNVSMZMneYapIaQoJYpQZJDkJpHbbw=
X-Google-Smtp-Source: AGHT+IE4mfyNAbGwKZ9nME3G59fwEPSFuQ5t8lhGdVZqMqD7QdZb6qTs8RtEfmX0fhNqSYkO+HDsBw==
X-Received: by 2002:a17:90a:c24b:b0:2ab:8e59:9da9 with SMTP id d11-20020a17090ac24b00b002ab8e599da9mr3471747pjx.6.1714643001041;
        Thu, 02 May 2024 02:43:21 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
        by smtp.gmail.com with ESMTPSA id p11-20020a17090a428b00b002a42d247a93sm782603pjg.36.2024.05.02.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:43:20 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Anand Moon <anand@edgeble.ai>,
	Jagan Teki <jagan@edgeble.ai>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] arm64: dts: rockchip: Support poweroff on Edgeble Neural Compute Module
Date: Thu,  2 May 2024 09:42:37 +0000
Message-ID: <20240502094246.4695-1-anand@edgeble.ai>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Edgeble Neural Compute Module add system-power-controller
property to RK806 pmic so that these chips can power off the device.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
index c0d4a15323e2..2c23e89dd2d8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
@@ -162,6 +162,8 @@ pmic@0 {
 		pinctrl-0 = <&pmic_pins>, <&rk806_dvs1_null>,
 			    <&rk806_dvs2_null>, <&rk806_dvs3_null>;
 
+		system-power-controller;
+
 		vcc1-supply = <&vcc5v0_sys>;
 		vcc2-supply = <&vcc5v0_sys>;
 		vcc3-supply = <&vcc5v0_sys>;
-- 
2.44.0


