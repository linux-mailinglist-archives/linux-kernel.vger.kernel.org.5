Return-Path: <linux-kernel+bounces-61146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F85850DED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750DCB25B68
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BE1079A;
	Mon, 12 Feb 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2tmKXUt"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2201FEAED;
	Mon, 12 Feb 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722351; cv=none; b=u3eVIwhbe4hQTk4ptzdrX/G1AAf4QgF6jB9UxsSEXywgIA4QgnCsQg8ykcPKwe4L5sHXUt+uvZThv5mGdl1gEcq2Oy4zTe2mOQyA9KQpxt8iLicoiTGSn22tDLEdn+q6MZARE28j4Ejw2OHROgVwJIlujf16Y3WTt7WzeOMNx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722351; c=relaxed/simple;
	bh=Zuz+NhBAF5z/ZYPqSykHEfLabXWwtRNYTJqqKhH2Hxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayoFyqBVrBL8FiBW9KNruCnPbp3QbFzhWsFJHM9Aw2pMDTyE0DQDlEJM561+UhaNaTtlNLaNbBglgrh9Ct71Vg82teOkLemkiM7XV4Xl6NPmZQTlnjtByhCvbbw1kXzCGfqgzoF0VsxCesXStp+b0spUL5UbuOdbRiuC/Gfv6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2tmKXUt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51032058f17so3355276e87.3;
        Sun, 11 Feb 2024 23:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707722348; x=1708327148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf12Ydzy/Q7rpDRdiz/9pMOuEotBEAtromAO5aq0+xI=;
        b=I2tmKXUtBN4Op6LfrFGhqZZGppKSfhQASI3XW3hGdvBGMKz7HJ1cZSC+IzuCbwddW5
         +Xu0COFg1x64qDRcn1T2W4ybwWLYQGlAJSUzmfRFMFmwQTGtOxU9HzYJVL7gzV6JJxrA
         ODYJMKC2TyPJBtV/vZUHTA5Pa/Q1trCT6jaylDVdYe51mJSHU2qlB28jVA7FKIQNOY+6
         Z2W74+/ADy6RLloiiCpmuROGexV5zsJefYO9Fu0rSUdpZuMr31/FQ3tSzT4cQL1nPG9A
         Ze1LgfZCUJSWR65xEjh+2rkEkmtxsolPFtCWRjntDjSgTctRk0FL9roc+tfyvF5Z3W5N
         BCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707722348; x=1708327148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf12Ydzy/Q7rpDRdiz/9pMOuEotBEAtromAO5aq0+xI=;
        b=ThNJ00l57aADZGCOrK02622yoUxQ5MIP+F/rHCCvhmEDULfhY4JMFDrZUiB/vu5Zpx
         OohAMGtw/x4sxDrtQemgu3I5J/ld9ceh1OoZgqKTOfEPWrqEfSj1dvea4HfxM2eXLPY5
         ZB6Iy/AcASrksqwVeefJuxPKjye9++gbrU9XS9G1mJWAPQe75WUprQL/7P90BnPYqvNl
         Fi4u/JPh9xqGj54FcnHtIB7N1XNyYlPwl6BwItOyR6Z466R5c+ZxK0C2R2QxwGVgOCUr
         BZK+5pwgorV9UyoawIlRbtkfsZJpk5oKJYwaaU8xuHHz2QBH3vPmSSAxdhyTxG+WsK29
         4adg==
X-Forwarded-Encrypted: i=1; AJvYcCX/X64zjGTc2RP1HG3WNJZFeujMqDLKq3I/6AVZlIYm7eqtcTC3SpU3JsEdY1m60tWVe+9yPJmSQGy63nZ+URS6DhFpYXRwmAUBPNa6ijhrAGqSLOls9gSyFnBN+GUezGu7JRfIMsyoa3w=
X-Gm-Message-State: AOJu0Yw9owA9teP8yow1bL3BiZNovCuHWH5SGHzGiAaT1SUGBbzsdeQd
	+pLcXlA6eyry9cHfaLWtJKyQko4RHg089edj9/jnGxsn6FGMolkh
X-Google-Smtp-Source: AGHT+IGiGWZS2V+3b2bbzbYNmEX08dAQxiBou1IF/WT7kghjdk5nl7VZBcI4axxGMXAUF/Ze9EnQ3A==
X-Received: by 2002:ac2:4c8b:0:b0:511:60ba:a02e with SMTP id d11-20020ac24c8b000000b0051160baa02emr3942004lfl.40.1707722347914;
        Sun, 11 Feb 2024 23:19:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUEJvKjK2+6thCbwttedpXE2rLrAAFq5iUNn9XyrIOkBLsCPM3wTO51XvRBlAjhcigHbrEqIi4O6CzG3R+gXEZ0Y8di5TwGEQGZZ/bKc+N8/KjDhnYDr2NY64dq67YTF2HYseImGgLaQ5UdGFGzhmwrojmpDNtxyVn6PtZpxzaF4Etkev2v67nXh8gELdEyS5rkbbF2k+K1mGMb75KKZH8qoHGc4vI5/nWWmBkIX0cjpMEYIqQf/C6EEL/aaID8fIveKUsfGaQrHaU8jPYu6n7pKcjeRjgnsC9DYOTE6/LAq47dGS8CVS7MiMDHNhDj99LoZilsXzffZw==
Received: from xeon.. ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00410cfc34260sm2340327wmo.2.2024.02.11.23.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 23:19:07 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Shubhi Garg <shgarg@nvidia.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] dt-bindings: arm: tegra: document NVIDIA Tegra Note 7 properly
Date: Mon, 12 Feb 2024 09:18:43 +0200
Message-Id: <20240212071843.6679-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212071843.6679-1-clamor95@gmail.com>
References: <20240212071843.6679-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document correct codename for NVIDIA Tegra Note 7 which is tegratab,
not tn7.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index fcf956406168..fc10886235ad 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -97,7 +97,10 @@ properties:
               - asus,tf701t
               - nvidia,dalmore
               - nvidia,roth
-              - nvidia,tn7
+          - const: nvidia,tegra114
+      - description: NVIDIA Tegra Note 7
+        items:
+          - const: nvidia,tegratab
           - const: nvidia,tegra114
       - items:
           - enum:
-- 
2.40.1


