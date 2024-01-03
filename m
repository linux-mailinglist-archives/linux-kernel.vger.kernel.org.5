Return-Path: <linux-kernel+bounces-15642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E67822F54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CCF1C21746
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65721A5B7;
	Wed,  3 Jan 2024 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYO54ebB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A41A58E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5537114380bso8222565a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 06:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704291657; x=1704896457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENyq9C8VT12HKkFyaBEnj5k/Q7yDIEUWoULUxoNgLvw=;
        b=UYO54ebBY4UoITxOiJvd1TFS5ZMEa5mwZtNqBc6yXBt3ps3QfnS4hp7rZMIsjfQ5UL
         TkovF3f+h1TDY5Cbq/wBjTYVFbVk7GgX6vpZjAKnauiEjY1MqaUqe5Pc3zptMjaCHrVK
         GgnARH5PhKfJKnIDGIyjlrmmsORMFtr55dHy9n2FyWzUMYjwzx+1j5j+nm1ZS5sXNJnu
         Ch2J2UA+6kujy9DkC9+vAr+MIxtV72sLNlqrtq5zMMLS+KZoDA42qGc2QbI9gpLk29/A
         psK6Dz3p16bIUyANzytxYiWaqk2slu7bszTb9qWjgL/vEFTIYsFUqWssWclzBSiHnUMM
         3UhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704291657; x=1704896457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENyq9C8VT12HKkFyaBEnj5k/Q7yDIEUWoULUxoNgLvw=;
        b=Z6WljXX2aNfIyOosroD94izzsVcg3j0TukBLaskwmQXhBr4oSk5ZGDkhUf8vNR37Z5
         /40j1ugLvxbkGBWL0DelvFHSPCQxTopjBx9lOIn+BpVOJ5gJp6yF7wkyebpfJvPQ+3rH
         kdvK0lZxjjKDas/v1DPIRs9Cb7Y5RZeL1XUdyrjpHbUjClf5jI54epFAbsZDghzwgGmF
         1vF7EormE02niF+Q1UIvxk8+tYgqGqdj1V5esObbhwkibLBuon2UvS2g0l5GNoNDKeIJ
         tT8T8jUZBVGz1J3KCyBl0LumSs3ihz5TIWdVuO3uOjpOs62SscYj5riXv251Y3DYJsrU
         SFMA==
X-Gm-Message-State: AOJu0YzWm6tbrp+e51AhJ6GgzbIpirR1JtPcJtEs++vdguUmUzb9m/hN
	upjcOD+owBh9YTgvPWQmYVNKpKEYRQiApQ==
X-Google-Smtp-Source: AGHT+IH7MJevMD7XZ43XmWVT3UQtQVmLymVJAkmIgQoi6Jelzk4nVGGYuMAwr4bcDeCTaDCGkQQfPg==
X-Received: by 2002:a17:907:968d:b0:a23:357f:f583 with SMTP id hd13-20020a170907968d00b00a23357ff583mr13158197ejc.30.1704291657122;
        Wed, 03 Jan 2024 06:20:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ka24-20020a170907921800b00a26abf393d0sm12229325ejb.138.2024.01.03.06.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 06:20:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Amit Kucheria <amit.kucheria@linaro.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 2/2] arm64: dts: juno: fix thermal zone node names
Date: Wed,  3 Jan 2024 15:20:51 +0100
Message-Id: <20240103142051.111717-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103142051.111717-1-krzysztof.kozlowski@linaro.org>
References: <20240103142051.111717-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux kernel uses thermal zone node name during registering thermal
zones and has a hard-coded limit of 20 characters, including terminating
NUL byte.  Exceeding the limit will cause failure to configure thermal
zone.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/all/CAL_JsqKogbT_4DPd1n94xqeHaU_J8ve5K09WOyVsRX3jxxUW3w@mail.gmail.com/
Fixes: fb4d25d7a33f ("arm64: dts: juno: Align thermal zone names with bindings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 4 ++--
 arch/arm64/boot/dts/arm/juno-scmi.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index b897f5542c0a..98ed2b329ed6 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -773,14 +773,14 @@ soc_crit0: trip0 {
 			};
 		};
 
-		big_cluster_thermal_zone: big-cluster-thermal {
+		big_cluster_thermal_zone: big-cl-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 21>;
 			status = "disabled";
 		};
 
-		little_cluster_thermal_zone: little-cluster-thermal {
+		little_cluster_thermal_zone: little-cl-thermal {
 			polling-delay = <1000>;
 			polling-delay-passive = <100>;
 			thermal-sensors = <&scpi_sensors0 22>;
diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
index 31929e2377d8..f38c5b6ef657 100644
--- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
@@ -84,11 +84,11 @@ soc-thermal {
 			thermal-sensors = <&scmi_sensors0 3>;
 		};
 
-		big-cluster-thermal {
+		big-cl-thermal {
 			thermal-sensors = <&scmi_sensors0 21>;
 		};
 
-		little-cluster-thermal {
+		little-cl-thermal {
 			thermal-sensors = <&scmi_sensors0 22>;
 		};
 
-- 
2.34.1


