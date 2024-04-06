Return-Path: <linux-kernel+bounces-133975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5F989ABA4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 17:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84DF5B218CF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 15:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF423A1B0;
	Sat,  6 Apr 2024 15:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="jgLHFDZ0"
Received: from ahti.lucaweiss.eu (ahti.lucaweiss.eu [128.199.32.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56B139AF3;
	Sat,  6 Apr 2024 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.199.32.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712417471; cv=none; b=jStI8CYCHH4F570s0din47eDzr9bJ/NN13syg3UMmtG8CP4/Az4vRMFAjZkF8GwJTB+B6Ga+F5tPXiRIr2EIrpv6XgnO/HJdzgeK7/OYr8fpVMXBVOsAQnFi7bc/oz17ixlw9qs6K3IAooPIaOCPany4XpRyVFxBl9Gke+OIclw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712417471; c=relaxed/simple;
	bh=wIE3eE1Fk9/n0HCYeNICyeELqzEI99x9rlfFVkFZ/Uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AuiTBFsll/cSM+UENPf/zTAKWVzddbbwVWUxvxP8G6pa3CGxrNi745eSHHMMm5sMWz34HOncoQx+NS9Kg7BGqpEvwdumTzZKBLTjXjjApnjYjW11TMiaN/sNgYpJ1ldJyaujeTM98fg6Sfo4rnQPG4VyO3Gf943krDFGfhC2NrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz; spf=pass smtp.mailfrom=z3ntu.xyz; dkim=pass (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b=jgLHFDZ0; arc=none smtp.client-ip=128.199.32.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=z3ntu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=z3ntu.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=s1;
	t=1712417466; bh=wIE3eE1Fk9/n0HCYeNICyeELqzEI99x9rlfFVkFZ/Uo=;
	h=From:Date:Subject:To:Cc;
	b=jgLHFDZ0v/h6G39RDRJsMzEVQudSsxR8pzQlS1+/etx8Svs4qX3bhvQg/Q+Mgbb31
	 A+DRe9fpKJaujR2nm53kB5UMkx6NaCYFIX+I7nRao0U8XEHpd08EYOtqgB0ZloaUc6
	 e2pXiUse6B+ssfwBntVZ2vEtaGM+AI9RUCxEXaZU=
From: Luca Weiss <luca@z3ntu.xyz>
Date: Sat, 06 Apr 2024 17:31:04 +0200
Subject: [PATCH] Documentation: ABI: document in_temp_input file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240406-in_temp_input-v1-1-a1744a4a49e3@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIALdqEWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEwMz3cy8+JLU3IL4zLyC0hJdE1MD0xTztMS0tDQLJaCegqLUtMwKsHn
 RsbW1APcBjG1fAAAA
To: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=wIE3eE1Fk9/n0HCYeNICyeELqzEI99x9rlfFVkFZ/Uo=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBmEWq5M6qweSr8YOc7WiqtuxAwWzXGkmwq7EjB7
 ArF7h8R1/6JAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZhFquQAKCRBy2EO4nU3X
 VjCRD/0aH7atBXrXYNuylYVENhupz6+EmKz6ucP8OLOQneEOq0X4tewrrxZUeD2XWgtJvFC1eqb
 b5zA+jWtVhYWwJnpLemQqS/+WOsjokfbKV+x3xVPo+0zqrblL+T+a9oaJSQSWZHIMscH3W//Mv2
 BqT/Olg3nBy9yDYAEC2spY4JSR8DiHJ7S20V/vN/TZkS7zFZiWdWBv46V8Y9v5tujK7u6M6Isb5
 QdfxmTqYK1RkZ9dI9WPyrnGKIMK7W9Y4RjZMG29U7ga2ackLq5WW2DDqXQkaDE6dwEyRshGIDH/
 cqa63acMVOT/NmlKaoET/WNwouTf0ieHaJBYe8UHlpngTJcRKOin1O6O/gSgAknYs0LUFcHEYKT
 I7vaQZa1jYxFKos+F9pYZn4pnidMh2fx4RcjN2eIK8QAaYB/kvY4MbkLvrk+zrYtx++vYSPA3rL
 YkqdcVKXp1TyIftH1ebdrf1NNcvL3wjnuZH+09y1vYTk2lBn38NZoDHdjWxwfSWtulb3Ml828Br
 D/v5klIqP7eza6OPLIaQL9Q58XuNnS4HWWTOwpEubYzKcYa62IKQ44dUBKyjN+I8O3guuWtKHDM
 EEJOJsPbhFcryQRTzUnHjlFKU2GMvNk20gY1da3Lrt8YwtXhmnFlTt3nqYyitRaYOIROU22+jls
 FzWcS5qMFxnCY7A==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD

For example the BMP280 barometric pressure sensor on Qualcomm
MSM8974-based Nexus 5 smartphone exposes such file in sysfs.
Document it.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/ABI/testing/sysfs-bus-iio | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2e6d5ebfd3c7..7cee78ad4108 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -243,7 +243,8 @@ Description:
 		less measurements. Units after application of scale and offset
 		are milli degrees Celsius.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_input
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_input
 KernelVersion:	2.6.38
 Contact:	linux-iio@vger.kernel.org
 Description:

---
base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
change-id: 20240406-in_temp_input-4505d7fafff8

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>


