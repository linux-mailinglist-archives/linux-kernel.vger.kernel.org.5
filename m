Return-Path: <linux-kernel+bounces-70212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0019E8594DC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C269283475
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 05:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0623F4F5;
	Sun, 18 Feb 2024 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="WRKvY3W3"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE376125DA
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 05:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708235346; cv=none; b=RYLCrpjfkmKku+qNXVIK7PDTU1+nPRrCuhmMBgLJtk/7JdbbBbLp08KACFfeuH7tFg3YVO7K1EVErOIv45kBcmDg/tq6sQva50EFUERT2qLIlCAVVByGV45yTbhjhqAxkM1h3G80aQrJN2yqHxGTv9V4/a0QM31Eoo9d0AJR0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708235346; c=relaxed/simple;
	bh=sNaN+8uZ2OwYk6opRABmHv+QSTXqQ0Oj+nHsi2KqXM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T8RqoK4MLkpb8TqLstDgS7pRLVtSlrczVdJT5JYQrAsvBnK5yvRftonWIxDoExe45+dbBK/vz8SHWweYT6eDhbmwcawWLUd+8HE7kXEBM2ZfkAsjAvrtf4dDMr5xAvdYJEBVuFrBelgpxbDlapffaSrYdZ5twhIY++Ep/LQoTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=WRKvY3W3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e45d0c9676so35864b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1708235344; x=1708840144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uS+RRmEKDa2tRYcsQCTrNfUOTEya4p+k26tpmSP/PdU=;
        b=WRKvY3W3uruDg3fG3NznfFrHDM6Ow5FQcTfurinEzTHfwuxlD+5K+JSSB0LFLxUDqU
         Q+bytRrPqswlHEcNCbVnjY9v79BgpajvrefTuieatzA6qULNSL/PhIcSfQIc29gV/AAJ
         eAsKK5E4SLA3mrJ0zUF8o4LqxzgZXxOlEodfci5OwIHavDYAC/Dw7hNTIveyfOlLI5TD
         aaWzZHo1WG0tfCZprZBx7wqWMbTm71DPRfpjqHncXDToZBwVoWSaGXuWoyMipPmpMDYQ
         dn2O8VJ5uSJiqNC3azs2thuVRCgtvKQ8bAS84MwPukwSwdqlrwjENCwJOmhkSjxktHMF
         fmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708235344; x=1708840144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uS+RRmEKDa2tRYcsQCTrNfUOTEya4p+k26tpmSP/PdU=;
        b=chhWUu4+lk9RrNxAhDlDURFjcXkN1Ch/SMvI94d1rGGMf8aj+iFazCqimIZMM2eMSW
         4T19o83hpw/aRmn9AhAm4B2PP7nihOAN5a/3qxX3EZCJpnKkppIitZLiL/Kx7af5ysfV
         cigSMaCLYku9qLFymIlOqKLELUKUY5HseCugJetT44qTaq4+86bb0Em0QXkf/RpI/gS7
         XiGZjA8nKJA3BLHx2AGhZW9lUsHUHPJj2Cjwa53EVkl3sQHjiYVhmnS4ICQah89DeZqj
         uBVFnPlDMlZ57QQo8Q4wETJPSFrWJpsfZscMGoHw2OXKAjoiOMaaXo8W8ixcPnujOE9z
         iohw==
X-Forwarded-Encrypted: i=1; AJvYcCX6f9yEsHMi8aUYOGiyQ/3BXEaM/6jb65H4UZUZ2HrC2fLbHIYp17RMp3emwbGb4M2Gj/UCJ1Q4V0sO6vBa1CQryOXyR5/L5124l3X6
X-Gm-Message-State: AOJu0YzZNi7oscpnMrHBFYjJqnJyUBzyItuhcsnC4f9/Mo6qOXxy/IH/
	7Iimp5ZVrxQCaRRod5vml87qEmqZpOzX6GAvXmOwuoUOrwyN2BPxK5nk9dY4WlY=
X-Google-Smtp-Source: AGHT+IGCoGlGB15Yzz2OqVgwVSLRcqY6I3+8ga0ROtg9wX13jLMYJD0LZq6SILFivebb1vJbZmuVdQ==
X-Received: by 2002:a05:6a20:4387:b0:19e:4ab2:c362 with SMTP id i7-20020a056a20438700b0019e4ab2c362mr13551548pzl.14.1708235344214;
        Sat, 17 Feb 2024 21:49:04 -0800 (PST)
Received: from localhost.localdomain ([180.150.113.62])
        by smtp.gmail.com with ESMTPSA id 32-20020a631260000000b005d3bae243bbsm2394808pgs.4.2024.02.17.21.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 21:49:03 -0800 (PST)
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
Subject: [PATCH v6 4/5] dt-bindings: iio: light: Avago APDS9306
Date: Sun, 18 Feb 2024 16:18:25 +1030
Message-Id: <20240218054826.2881-5-subhajit.ghosh@tweaklogic.com>
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

Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
Extend avago,apds9300.yaml schema file to support apds9306 device.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
v6 -> v7:
 - Removed wrong patch dependency statement
 - Added tag
   https://lore.kernel.org/all/5089c549-505f-4342-b3fe-bed8a29b6ce1@linaro.org/
   https://lore.kernel.org/all/20240206-gambling-tricycle-510794e20ca8@spud/

v5 -> v6:
 - Write proper commit messages
 - Add vdd-supply in a separate commit
 - Add Interrupt macro in a separate commit
   Link: https://lore.kernel.org/all/1d0a80a6-dba5-4db8-a7a8-73d4ffe7a37e@linaro.org/
   
v2 -> v5:
 - Removed 'required' for Interrupts and 'oneOf' for compatibility strings
   as per below reviews:
   Link: https://lore.kernel.org/lkml/20231028142944.7e210eb6@jic23-huawei/
   Link: https://lore.kernel.org/lkml/22e9e5e9-d26a-46e9-8986-5062bbfd72ec@linaro.org/
---
 Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
index e07a074f6acf..b750096530bc 100644
--- a/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+++ b/Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
@@ -12,11 +12,13 @@ maintainers:
 description: |
   Datasheet: https://www.avagotech.com/docs/AV02-1077EN
   Datasheet: https://www.avagotech.com/docs/AV02-4191EN
+  Datasheet: https://www.avagotech.com/docs/AV02-4755EN
 
 properties:
   compatible:
     enum:
       - avago,apds9300
+      - avago,apds9306
       - avago,apds9960
 
   reg:
-- 
2.34.1


