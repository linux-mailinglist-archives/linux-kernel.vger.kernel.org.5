Return-Path: <linux-kernel+bounces-27452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A6382F049
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27535B233E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154051BDF4;
	Tue, 16 Jan 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KQZusFnX"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C81BDE0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240116140900euoutp01f08f88905fb54c488b3ed05a1d44ed5e~q2SAMhiQe3144531445euoutp01R
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:09:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240116140900euoutp01f08f88905fb54c488b3ed05a1d44ed5e~q2SAMhiQe3144531445euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705414140;
	bh=WVZl8JclTuhVrFtDwe7CsHbq2rExh6UF/QGVi2GPLE4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=KQZusFnX25LX6PH1UxHSXtSDisud2sCzT2X2bW6Dfgvs3EajHOxRuhOuE7bSi67bM
	 h0XA8sman7LiJaEApKcpmjlBG6xJ8m9DFIJ3BwS1pgR97cFDROCcAMXLj/pNA6sjm/
	 SXrtlfy5zfGIydsA0AWudCSjV99/AeoR+FayZLKs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240116140900eucas1p16b8b407365c1b7fbe46cf3010d2e1d05~q2R-8cXU43090230902eucas1p1k;
	Tue, 16 Jan 2024 14:09:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 60.80.09814.CFD86A56; Tue, 16
	Jan 2024 14:09:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240116140859eucas1p138fd10cf371ed1e1681a5bdd7e26e74d~q2R-O1zti0761607616eucas1p11;
	Tue, 16 Jan 2024 14:08:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240116140859eusmtrp23ea6f8e336f306213c2cbdfda00ec9d7~q2R-OJmpB2131821318eusmtrp2a;
	Tue, 16 Jan 2024 14:08:59 +0000 (GMT)
X-AuditID: cbfec7f4-727ff70000002656-0f-65a68dfc3413
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BB.8B.09146.BFD86A56; Tue, 16
	Jan 2024 14:08:59 +0000 (GMT)
Received: from AMDC4515.eu.corp.samsungelectronics.net (unknown
	[106.120.51.28]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240116140858eusmtip2ec1fd081e738bcb327f45ce7ec6e2162~q2R_qpEOe0333203332eusmtip2-;
	Tue, 16 Jan 2024 14:08:58 +0000 (GMT)
From: Mateusz Majewski <m.majewski2@samsung.com>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mateusz Majewski <m.majewski2@samsung.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski
	<m.szyprowski@samsung.com>
Subject: [PATCH v2] ARM: dts: exynos: disable polling in Odroid XU3-related
 devices
Date: Tue, 16 Jan 2024 15:08:39 +0100
Message-ID: <20240116140839.1029395-1-m.majewski2@samsung.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87p/epelGjx+wm/xYN42Nos1e88x
	Wcw/co7Vou/FQ2aLTY+vsVpc3jWHzWLG+X1MFhOPTWa2WHvkLrtF694j7A5cHptWdbJ53Lm2
	h81j85J6j74tqxg9Pm+SC2CN4rJJSc3JLEst0rdL4MqY0LGWteCiaMXS/rwGxjcCXYycHBIC
	JhKHNp9l6mLk4hASWMEocXfKUkYI5wujxN6rV1ghnM+MEhsnTGCCaTn5cwpU1XJGibMXnjND
	OK1MEn/en2cBqWITMJB48GYZO0hCRKCdUWLB3WdgVcwCnUwS779OZwWpEhYIleje+48NxGYR
	UJVYem4jO4jNK2An0f9rOTPEPnmJPYu+M0HEBSVOznwCtoEZKN68dTbYUAmBHRwSs/9uhjrQ
	RaL1zyx2CFtY4tXxLVC2jMT/nfOhavIlZmx+DzSIA8iukLh70AvCtJb4eIYZxGQW0JRYv0sf
	IuooMfudA4TJJ3HjrSDEfj6JSdumM0OEeSU62oQgJqtKHN8zCep0aYknLbehNnpIzF6/FSwu
	JBArcaZjFfMERoVZSL6aheSrWQgnLGBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7iRGY
	gk7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4fU3WJYqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1
	RT5VSCA9sSQ1OzW1ILUIJsvEwSnVwNTg/v1BwI7DsgwVv68yb8uZnGrbVMgtkrk0yjs+M3d2
	fK18lciCLxx+h2yk1nfdMf38ZukBO223G/4vbt5eUui/i8G5z6imjq/vCM/izgoN5vCDIk9v
	m1xIb9tx6WFWYp88c5Xrn9/aOgndd5e9mmfT+W6T735RRYvMmCvT+pUcl1RcmxhwcXH33ig7
	pc7Dc+ZGm/yaun0B65Uy83P2cfcc47ddbsvibXnGmrmVeytf0eVbp6+xOa+8q7H+i/lxgb5/
	flLzP3Gt3BqyKKiwr6g3+HZ5zqcZu1fWWpiyLXyua2Io/WzVv/CXe1P2x+3bPunJy/v82x/P
	jJzaYVfT73Rrj4PmJ/kJUi77d3iElSmxFGckGmoxFxUnAgB+V6EAsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsVy+t/xe7q/e5elGtz8LmvxYN42Nos1e88x
	Wcw/co7Vou/FQ2aLTY+vsVpc3jWHzWLG+X1MFhOPTWa2WHvkLrtF694j7A5cHptWdbJ53Lm2
	h81j85J6j74tqxg9Pm+SC2CN0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXS
	t7NJSc3JLEst0rdL0MuY0LGWteCiaMXS/rwGxjcCXYycHBICJhInf05h7GLk4hASWMoo8frw
	SzaIhLTE4S9T2CFsYYk/17rYIIqamSTOXnnMCpJgEzCQePBmGTtIQkSgm1Hi0MxbLCAOs0A3
	k0T34kdAczk4hAWCJb7MKwZpYBFQlVh6biPYVF4BO4n+X8uZITbIS+xZ9J0JIi4ocXLmExYQ
	mxko3rx1NvMERr5ZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIyAbcd+bt7B
	OO/VR71DjEwcjIcYJTiYlUR4/Q2WpQrxpiRWVqUW5ccXleakFh9iNAW6byKzlGhyPjAG80ri
	Dc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamHRnbDz0f8dlbV2WHZ0C
	hfyx74U/lK4zfR0xZ82q20srAnPiz52ZzpHkKsrRK6vJlNpi8azhfZ0Qy6tdn6NiH75lKn9f
	KNyVVt7msppZ/ucl9RP9K4Pu5y3neynFPX39TTNfbomLW6tMf6h+0p8baL1Gue367ojixZ7v
	9luIqrjt9ym+b1ms6anJXh13PSVCWuTJwwLN6NsKmvo/r91kfmz19Wrl/Tzlg3t1nrEZTJvt
	uu9P5tGwf1sW6K7tfPhgXS8XK9OZA7MjP+/y1XNOtA/aaXjm9DnBqDUTBUWqy7bkcjvz7Tva
	flMm31SRU5L1ntGu5TN6X6ecFly2Xk2WzWhlaeS6sye5wv4evTZhvxJLcUaioRZzUXEiAHze
	aIAJAwAA
X-CMS-MailID: 20240116140859eucas1p138fd10cf371ed1e1681a5bdd7e26e74d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240116140859eucas1p138fd10cf371ed1e1681a5bdd7e26e74d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240116140859eucas1p138fd10cf371ed1e1681a5bdd7e26e74d
References: <CGME20240116140859eucas1p138fd10cf371ed1e1681a5bdd7e26e74d@eucas1p1.samsung.com>

After having switched to dynamic trip points, we no longer have a
hardware limit for trip point count and can support as many as we want
without polling.

Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
---
v1 -> v2: Just resubmitting as a single patch, originally submitted with
  patches for the thermal subsystem back when I did not realize that I
  should not do this. The patches for thermal subsystem are merged and
  will hopefully land in 6.8, so I understand that it's ok to submit
  this right now...?

 .../dts/samsung/exynos5422-odroidxu3-common.dtsi | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
index b4a851aa8881..4a4c55a4beb3 100644
--- a/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos5422-odroidxu3-common.dtsi
@@ -55,7 +55,7 @@ fan0: pwm-fan {
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
 			thermal-sensors = <&tmu_cpu0>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu0_alert0: cpu-alert-0 {
@@ -78,12 +78,6 @@ cpu0_crit0: cpu-crit-0 {
 					hysteresis = <0>; /* millicelsius */
 					type = "critical";
 				};
-				/*
-				 * Exynos542x supports only 4 trip-points
-				 * so for these polling mode is required.
-				 * Start polling at temperature level of last
-				 * interrupt-driven trip: cpu0_alert2
-				 */
 				cpu0_alert3: cpu-alert-3 {
 					temperature = <70000>; /* millicelsius */
 					hysteresis = <10000>; /* millicelsius */
@@ -144,7 +138,7 @@ cpu0_cooling_map4: map4 {
 		};
 		cpu1_thermal: cpu1-thermal {
 			thermal-sensors = <&tmu_cpu1>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu1_alert0: cpu-alert-0 {
@@ -217,7 +211,7 @@ cpu1_cooling_map4: map4 {
 		};
 		cpu2_thermal: cpu2-thermal {
 			thermal-sensors = <&tmu_cpu2>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu2_alert0: cpu-alert-0 {
@@ -290,7 +284,7 @@ cpu2_cooling_map4: map4 {
 		};
 		cpu3_thermal: cpu3-thermal {
 			thermal-sensors = <&tmu_cpu3>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				cpu3_alert0: cpu-alert-0 {
@@ -363,7 +357,7 @@ cpu3_cooling_map4: map4 {
 		};
 		gpu_thermal: gpu-thermal {
 			thermal-sensors = <&tmu_gpu>;
-			polling-delay-passive = <250>;
+			polling-delay-passive = <0>;
 			polling-delay = <0>;
 			trips {
 				gpu_alert0: gpu-alert-0 {
-- 
2.42.0


