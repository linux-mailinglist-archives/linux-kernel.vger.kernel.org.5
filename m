Return-Path: <linux-kernel+bounces-97859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F099A877092
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2A8B20B9F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58A39ACD;
	Sat,  9 Mar 2024 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="TSwGxwqy"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434C2D781
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709981517; cv=none; b=mYhKmoQe9cm8CnewnbzviPcytAHSebAV23MSuqayLnLS2SOt+k1E4NZtrb7wfCOdw+5mgpSSf0Hz+KqFQaXAx3giFHnzoBrK4mkJPf+yz2GQCFURbGDzf0wRUxfLE4y1Pvsl245uuC1EKN1nhcqbDj6oMiGYsC+axEDKWdZ9/D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709981517; c=relaxed/simple;
	bh=MJurD3lQkgJh/SJjO1IdmDA0nZhea/ItLzC5yip7HFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VWheytRzM7fIuE3Ixs2nt2gj2vG0/nnbFLFPquAOlB3OAOYdJJ/9ySRTefjEGQYGJef5VxC+LJkT5dPA5uuAZ3ayCLqLtqZEqLW9VFG6uqjCQ22wuB3S7cq0yPXQ2Cj+WcMp1G4MlsHkP7LPbAAovfydGm+e6xICh4k3xHwu7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=TSwGxwqy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcad814986so22753495ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 02:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1709981515; x=1710586315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR1+ke7p4Q047/hy23eOGK+2iosx9giTHTVTkeIgf/o=;
        b=TSwGxwqyvI69fRdrhuj1eISIwoog5kn5ejCNLjq1qod5BXW4UBfrZNdXv6oSy6XE9n
         IAa/ySkFnOQf3oPKL8bcJFBtOxw1zCWBJdpMFcZNbKMh1rHPJPRM3sVpkFH2YU/FBxVn
         4QKx+M+izqZ+DlFxlEEhPuz+NVgopcU0Xmk+Bl/fULzXXYnKw2hiHzUgeKQuDtPWiWMy
         Aqp/1MR5pev1bn9A8aiXGGUEfDp2IgTgPVZG6xQhtFUyBCc5edZUzQV74eR3u2hKDY+I
         gfJFjR+gdGd/SwscYNOc0v3fMZj6h4ZohvLO+yZicBVB4hJQv2RVBRdJrqTKVZzUjdTI
         eAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709981515; x=1710586315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR1+ke7p4Q047/hy23eOGK+2iosx9giTHTVTkeIgf/o=;
        b=Gg226E4j3POM8Mae3iE9HqAMhBSJyc74UEyTqNVkszMwM1F6Ig7gXalklm9bhyGeDU
         QZ4wMaxLva7YXni2ceH8Ewy0g6RFRtJapn+yC42PQUu838nfW4qLrLFGQkywL/5dqN9o
         U4AWmps4uNIbw+RBV9gR429zOCVMjv/TAcCSc/o0CLoe6/uIQl17aL3eqyu36dxzY/0d
         6o925m3J7dVs4BdF55EXz5YkLWif+eva4uKkkjJ1vn5GbMbST41QBBAvmSPc8P7qHlXP
         kVPrsDJkNPCxR6K9gycBwuu8vyCTxQSkVE/XqXN9hQOBP6vVq4AqcIMOmR/W+ZnI/22M
         pddg==
X-Forwarded-Encrypted: i=1; AJvYcCU1HMP4mAV8WgtRj3pG1PP4ZThli8Kjk6vOvlX1YsI7NT5cyfnJ2jmmSiAEuif5RYx1Oksi4EgdMDSD3g1udHEmNQcvs8tnNpiIW5DQ
X-Gm-Message-State: AOJu0Yy7SHn864ulwspKBh9n8s9L+I0yHRboPnwkX33TIqvufQIiZKez
	r/QmQCNZUe0clancR0wzCJV+fWimNLw1YG+Hrpvo7zx0al/KBV6eu15DJ/iJ2f0=
X-Google-Smtp-Source: AGHT+IGgUOcJTk+1DFpfJo4xiOdVcORTwRLx+V25p/IGRHIEuRlbFRy6K5fuiu/UTsxyDzfLtS7n/w==
X-Received: by 2002:a17:902:e542:b0:1dd:6420:847d with SMTP id n2-20020a170902e54200b001dd6420847dmr2085384plf.2.1709981515355;
        Sat, 09 Mar 2024 02:51:55 -0800 (PST)
Received: from localhost.localdomain ([180.150.112.31])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b001dcf7d03824sm1070608plh.55.2024.03.09.02.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 02:51:55 -0800 (PST)
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
Subject: [PATCH v9 2/5] dt-bindings: iio: light: adps9300: Add missing vdd-supply
Date: Sat,  9 Mar 2024 21:20:28 +1030
Message-Id: <20240309105031.10313-3-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
References: <20240309105031.10313-1-subhajit.ghosh@tweaklogic.com>
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
v8 -> v9:
 - No change

v7 -> v8:
 - No change

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


