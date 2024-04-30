Return-Path: <linux-kernel+bounces-164263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1FD8B7B84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9B61C22BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58594177986;
	Tue, 30 Apr 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1jjjsTt"
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D21175554;
	Tue, 30 Apr 2024 15:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490854; cv=none; b=QaAda4VcqZtOVEei2T+7GUouN6XFit2rUGyD86M9JycujOVyiKiCsylXKVXKXMFKmZjcKCiZGrOOZ43EtkgQa3y9DLgEsSfEIeb+I0ZUBpZUuW8NocfTpDcPYMy1yHqyO0xK45UeQ5w+Xc5GTtjFcagqUAqtwJ93OdlSwJkwrP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490854; c=relaxed/simple;
	bh=GLPkDYuhGT29VLhMic9dO8Y0lzclOq4is89TUFXMZDE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uXV8izyUdbbLMiHsUxxDTl1IykG9uAWG1tmvn1I5ZFpCUsabtRiV6ZPV73GiIXow/PRvlumvg/TIgIUOwuDAb1flq7TQzjSRtOxvcdCiPnFFTB1bBcUsRFP2wiO2Pdbw89/rT6odlJeK4iBOvgyUnjWZdtnTjnlZdQwJTTBCgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1jjjsTt; arc=none smtp.client-ip=209.85.166.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f66.google.com with SMTP id ca18e2360f4ac-7deb424da41so182930239f.1;
        Tue, 30 Apr 2024 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714490852; x=1715095652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UQYoJna7w7pSNE1L7t4Hc2/L2BmjKZjh0BD0hkD3YNs=;
        b=N1jjjsTtnjz1+RfnC1IG7PFRLfE4ZtQXgC+q46T2Bm4T6rFyRCss1mm3TAa4KFcG/m
         UIE41eCZhymxeAX/gBBkV+3609nQEfWcHQYPRzGEDEeCFUO9/iPv44W2GJy0i7t4d8n4
         Q4ha2sWmtyejdElw5j5cyuTFWcChUMjEQUzaZdV2A75QoemuDuh619Bd/y1kdPAAz9/Q
         Y1dcg5a1ReqTpcQaOeCSS+Am5RxsG//3Cvi8CA/srr6YJjpXBGaHjpcCZHxlVfdwA08a
         qH1Q7ZBt3DX/uKqQPL6p8hAW+gLcvZ3g6ItFuNua0ckNe8uvwyTt+VUONAXhgCCczI9F
         mTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714490852; x=1715095652;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UQYoJna7w7pSNE1L7t4Hc2/L2BmjKZjh0BD0hkD3YNs=;
        b=Bzzhjo794opoBNQ1snmf0A+x1Ubp7MwTSWES0sK6G3vsU9J31GDsL96gRsuDJTd9Ei
         tt2weHYV6xkKo7a8wDLYanBbmVrPi2hihE6tZm0MsiA5Qd52fALwVGYD2SCiwMLhmM7o
         nPXsfH9YTcdFhc+fT1VX93FoFo6w4tNiVMTxagpbvSTQUS4Lv3WC5T2YSKgWP2co+Bka
         PG64du/Ta8jwCxO5v3Mva4nRcGlbHx8SoXrIFzE1p4Mxz6vfBVAeRacWoCgyydj0SwK5
         DiDnIk23CjgQXk/RSRT9S/d6lJshvop0xH2pqpgDn9E8tckRTcrV/M6rMQijYlIZCw+h
         RNpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJbpi/SqhQ7XuT30cSx8cRtCDABZLKh2qXn8O5KXdbaaOmWov5cdkLIb0WiodhsS6ROAID9wYTf/58ktlmNiolLoyBpTUcrFdjmK9bE1Pm2qS4cSZS+6dxQ6CsEVDQjD4S4ouJG+alvw==
X-Gm-Message-State: AOJu0YzAEfg/RIKCURuMxOq0NGdz4OnegsklDOD38qQT+YZsuro1NMtV
	DQO7UUlk2pjdkuhX7y7Qke/+K/OyHlb8zcsdId9SOD9/LTfSDU7D6+mTGtKQDOBRcbJX5gkYGz6
	h2ztOFzk92HUdgczoeqDBioF83gHfhvqLjvo=
X-Google-Smtp-Source: AGHT+IHkdmFwhGKAjtWssVjWhEU2hqQ0UEKH09wmow7Zft3EXXWqVvZvO3TlWsY1JlUUrAKbJXbeNCXwMpgrK4ySmKU=
X-Received: by 2002:a05:6602:2589:b0:7de:d032:1fee with SMTP id
 p9-20020a056602258900b007ded0321feemr175169ioo.8.1714490852250; Tue, 30 Apr
 2024 08:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Tue, 30 Apr 2024 17:27:20 +0200
Message-ID: <CADFWO8GC6RP6A7H-Cq5UZHfBY3VJZTCqssdZet61hH031euhwQ@mail.gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Rob Herring <robh+dt@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 60f5cc7f65b07124f19428a713c3bc33b9e4a7a7 Mon Sep 17 00:00:00 2001
From: Petar Stoykov <pd.pstoykov@gmail.com>
Date: Mon, 15 Jan 2024 14:29:25 +0100
Subject: [PATCH 1/3] dt-bindings: iio: pressure: Add Sensirion SDP500

Sensirion SDP500 is a digital differential pressure sensor. It provides
a digital I2C output. Add devicetree bindings requiring the compatible
string and I2C slave address (reg).

Signed-off-by: Petar Stoykov <pd.pstoykov@gmail.com>
---
 .../iio/pressure/sensirion,sdp500.yaml        | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
new file mode 100644
index 000000000000..3cdf17df7d52
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp500.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/sdp500.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: sdp500/sdp510 pressure sensor with I2C bus interface
+
+maintainers:
+  - Petar Stoykov <pd.pstoykov@gmail.com>
+
+description: |
+  Pressure sensor from Sensirion with I2C bus interface.
+  There is no software difference between sdp500 and sdp510.
+
+properties:
+  compatible:
+    const: sensirion,sdp500
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      pressure@40 {
+        compatible = "sensirion,sdp500";
+        reg = <0x40>;
+        vdd-supply = <&foo>;
+      };
+    };
-- 
2.30.2

