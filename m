Return-Path: <linux-kernel+bounces-70210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B08594D6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11991F21EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84CD5394;
	Sun, 18 Feb 2024 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="ZqhtNPiY"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50FDEACC
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708235334; cv=none; b=bkSQ9rZAV4aguOfAcRunJzjmsl+F5Gmogk7zKCwnDGpGlbBSlvrg2ThvxUZPrpWn9KGvE+nTD7yKpqHUwrHzRO2dkgSUTpMPF+Hzkm3ytKzGW+KxIs5tlymMieo3IYX+DryvRkgSIi1ktapFzAoIdBRXF7QKfuqCJOmEvrH0Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708235334; c=relaxed/simple;
	bh=ZVB0/C361A/m3J7FAGUmwwjrBPnm+1oEIUq/ougwPsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNKKhjwW9as81jTBBRbCz0S2x1iyLm/EjFP4sX6gCSAJx9WSaqpFoXuyxdvPfB2s2l6vjxcE4MAWxEkpA0hhXjlve9muzQbvZSH/SZ/8cLeuilT8bGtDr6QpW9i9Ck5DFtjidOCjZjvZnpTlaXXcdDEwWtcjP1TDG53gZyb63jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=ZqhtNPiY; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c031776e0cso1603819b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708235332; x=1708840132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6i6/G+Z856s3YYipaYhdOaz3XDpws5cWB+Y6cO3Oumc=;
        b=ZqhtNPiYxdBgEK4EIUkJGse4EcApp9H+npK5FR85DqifkmIiwETiCsidVO6EmBZh6y
         hhsXDzwB+laF6S8pYHqpsi/CKIjK07YdDch/fXAeNmJhK0gTRkQWStFBNuTSWmVbI0Uj
         3EJ7oXMjaQW3XEniva7eAMgrPP/ZZfb5WPSjzE/ngc0QlESw9sRL/1JSLOXKKOmecTBD
         yU9mmv5CvZL/yIf1KPXucFgoW2v6ARi7upINkhC+VUwgM0Mzya1OISLYPRNf+f29iR6o
         yHgmfyiMF1+BpZeHmz8uB+VSus2PZJJ//vgvPJmKRBeBXMx0Tx4kVDhHkxMA6Jfpfb7o
         yBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708235332; x=1708840132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6i6/G+Z856s3YYipaYhdOaz3XDpws5cWB+Y6cO3Oumc=;
        b=W1NNySMPubdAq2jQNLkGUOqk0HKfnRMAjLryq2+eYQLGjwJDq5IxlkA3d9odOOefPW
         pwGc9/BboRRA43w5T8RRpkXVk9eDDZ7qwCnZhr6mCa+8ddQakdSXx2BDo3Ar7dMMuEDy
         z+fDfvbBU/vggiSRgvuyQ4tse84b6d4Xdu7zl/lUYVfaZIX120cCfS+2LisDmns8cypo
         1cXzeVpSPP8Cfeu9Ra6qFY74eeUjG9E5Qmj7sGB5s05au2TLBW/fccZ8IKoT8yX/BJ2A
         XYI8aiSqB4DeHZh/jVexFa0GLyi27Q08s4xDCwOBo1pd+nDHnU/QrZP4hXsH2n3aL965
         1gsg==
X-Forwarded-Encrypted: i=1; AJvYcCWNMnUzdO0zBVtNp2HMPYzUhJfxZ9UugwuoULxnUTa9yWLNYAbLzLo1Wtm5o9hHzPPHPglYPRAtNeMLVaiTMcCz0/0DwcriHKlqX/Km
X-Gm-Message-State: AOJu0Yy4VjI9MNDTsx1RM3jZuxRk9Aky3sR+H0h/bdLyyrmIvvbjzvlE
	xuvRWhyKE4cZ97VyJB60L1q/0HBJBHXjZqDer/tCkZvwHq9A0RXnKJZvAKD/HU4=
X-Google-Smtp-Source: AGHT+IGfHjMdF09bzgsPtNr24Ghpcv9HOfPbHnIqHEIpCzqy7C4zRXJU+2keAlr8jXDWKA5Ji6FiyA==
X-Received: by 2002:a05:6808:bd4:b0:3c1:559b:4289 with SMTP id o20-20020a0568080bd400b003c1559b4289mr483217oik.8.1708235331763;
        Sat, 17 Feb 2024 21:48:51 -0800 (PST)
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id 32-20020a631260000000b005d3bae243bbsm2394808pgs.4.2024.02.17.21.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:48:51 -0800 (PST)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marek Vasut <marex@denx.de>,
	Anshul Dalal <anshulusr@gmail.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Matt Ranostay <matt@ranostay.sg>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 2/5] dt-bindings: iio: light: adps9300: Add missing vdd-supply
Date: Sun, 18 Feb 2024 16:18:23 +1030
Message-Id: <20240218054826.2881-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
References: <20240218054826.2881-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All devices covered by the binding have a vdd supply.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v6 -> v7:
 - Changed the subject line of the commit
 - Updated commit message
 - Removed wrong patch dependency statement
 - Added tag
   https://lore.kernel.org/all/20240210170112.6528a3d4@jic23-huawei/
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

v5 -> v6:
 - Separate commit for individual change as per below review:
   Link: https://lore.kernel.org/all/20240121153655.5f734180@jic23-huawei/
---
 .../devicetree/bindings/iio/light/avago,apds9300.yaml          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index c610780346e8..a328c8a1daef 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -25,6 +25,8 @@ properties:
   interrupts:
     maxItems: 1
 
+  vdd-supply: true
+
 additionalProperties: false
 
 required:
@@ -42,6 +44,7 @@ examples:
             reg = <0x39>;
             interrupt-parent = <&gpio2>;
             interrupts = <29 8>;
+            vdd-supply = <&regulator_3v3>;
         };
     };
 ...
-- 
2.34.1


