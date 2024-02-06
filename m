Return-Path: <linux-kernel+bounces-54982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F1C84B5DA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4096D28A7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03A131726;
	Tue,  6 Feb 2024 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="gsatYP78"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4484312F5B4
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224460; cv=none; b=gyS+WZirhTw/z5x2BmY8qeOFRiR0gcZwZVZgzD4IRgtQT8H84iNiVIjUdMKoBMS/B2yk77+pmKkrD7oZxZztWn9KZNKiQLS6jfDjJfFpMyNR7eQqs9cI2vvls/812JUq0nvKYxVp7g6MywCMLDLXI360uzYylAWalCgXvKs9sA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224460; c=relaxed/simple;
	bh=t2VkaMkevBwQFepnvP2MubbWodHysWbjZTpvnHx6UNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZqYR4qLtryig3jIQVQAzhbRsrsdutLOwDaZhIGHwao1rHmFt6y1GVu7G2nK1xseJ7XOVPQJc3k1sc6j908SLILXEvyKpO05HqVts2FqHqNmVeyzmEMjrhHak+mwv/tIOzaipPqGBXnGg6SiVYckoBLwmrI09m8Y8JHW8Plikdfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=gsatYP78; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d73066880eso47936405ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1707224458; x=1707829258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o9COTEV2bYOzl/Iqcm/zhYhM78MeO/kZatJcokDs1E=;
        b=gsatYP78W7hkRnNhHL/9bXgjPwNGpyfA4jeZwxXgN913ORtCzZECJ6cYFQyT4V3rMw
         nvcNrPWIdJQ+quS+x19Y+/VGyibNCwCnMvmYGJOFecF9GE/bXKRvo4RXkE8mNZpy1A50
         AMrIWyjzipByqRf6MWIh81AQIZ39AGOHiHWk6aAy2PTLyuupKcJ4aBlR7OuUspXlIOZe
         sDrGieMqdnPOcVamleDoyPuPiJdvGWxEjeyrkYwCkBqKpiGAAxtqeo2lHa/7JJkI12tb
         Bh69e3JwHTkMKf7bBULRKoaZSHq4iivKejs1NJroSd1y9OTkOcN+jKnN2kgefYwQvM6O
         5AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224458; x=1707829258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o9COTEV2bYOzl/Iqcm/zhYhM78MeO/kZatJcokDs1E=;
        b=Y52VXy+uIslsV82U7ObOmlydQAvBsAScruBu7NdvnRaPMC1sFYjAQVqWoSVFJWlDlD
         cBFz2xb9M4yixkZPQzdIuyLVkywjLKDwZVvPqe9KE0wInL1XwRApdRnVdkskiHkTWvyq
         CV5oTxFYIFOIIcPiKXgHETLHcBqXa7ThncuoJRwrnnvLsc9bMqTcbKP/s0CbZrBgeWv3
         5EvmVpYLZSKWCDc0J3ogyGF3gHZC97zOJ7G3h6JDHf8OqMA8ckKD0+Ln6L83Oajg7EMY
         Y06GbEFrqEJ67/GAyequiP2fcg+aPvSkd6k/e2hBMlARscGeSZIdQrLGs/EnJdGjBiY2
         cdrg==
X-Gm-Message-State: AOJu0Ywmi0EnqPlFrcm5PBCSsofD6Gbe9kVZZHASJZCY6HCS4U9vhnKg
	dnd1l4//SZE6WfvGqxddLARxO+Z0NVy9yBRalS9dylDuycgbxLrUn/oO0+NEKGc=
X-Google-Smtp-Source: AGHT+IFJKZ84DsUTFIW7z09SM/XolOxhBIXknyjXr5P0qKdSWiGKzHB3JJVRh5mjkS6C+ftBVXN/5Q==
X-Received: by 2002:a17:902:d550:b0:1d9:a148:49c with SMTP id z16-20020a170902d55000b001d9a148049cmr1962809plf.57.1707224457137;
        Tue, 06 Feb 2024 05:00:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW1hX/IZBA8GnFd2p44/zmVh1meywAscFi3SUeBnf+a4ogukr+ONiJMftkTFIb0uX3bLZ1m4rqs26f3+E70hc36ZhZCjcFnuANaNMO6XbujIBTfu44iLkwShC0wJyxOO7oDpypB9jMCXCbv8KoZqyyPUxatUG7Ald6UX1Ou1VC5S1yomuGMi8UpPKDryaqHqyff8HX+NsoENV813T61muGE1rliJDLoEYCA4TVQ9NdghNISSTgDCJLGzZQKOvdrZtSZDfCfD/DCHbSfv2vZ17vIMn+8loqMqBub+kZx9ZAFu8JZiZZEXGZYqbGkH/rAerkZAyi8w9t759zReAwmFg8JruxJCinAjzXHiGumz+TubcYSphKdZBVY8J0dIAk3iAhH2wAM857PzokeVc6GTvMLff2++/auXhx0qUsoNpeA5y2p3iFejMEfG+bQFs/M6gWIVg3rfful8hulfklD3ENjaE0u25igWmU7n1XtJ/Q2nL1YubAnm4tiiuLc7YUXvBGqyJPagkXsxFFFkxyNUcEjJ/LGCQ==
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001d958f8ab2bsm1782167plg.107.2024.02.06.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 05:00:56 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/5] dt-bindings: iio: light: adps9300: Add property vdd-supply
Date: Tue,  6 Feb 2024 23:30:14 +1030
Message-Id: <20240206130017.7839-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vdd-supply property which is valid and useful for all the
devices in this schema.

this patch depends on patch:
"dt-bindings: iio: light: Merge APDS9300 and APDS9960 schemas"

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
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


