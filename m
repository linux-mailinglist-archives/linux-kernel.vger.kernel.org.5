Return-Path: <linux-kernel+bounces-72138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F985AFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3EA51C23D93
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03DA5822E;
	Mon, 19 Feb 2024 23:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jz4Br7P0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E10658208;
	Mon, 19 Feb 2024 23:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708386302; cv=none; b=M1S2M6wknpMBxTw3kpH6N1O8+I534Uo454gcOKQeo8t7w1X5+clJW8mPLsLe+QinrpKofxSo6xzCc+IZi++531e0TFgN+JyaDp4oxzKMM6biJGHZyAiixJSMo0O+Dj1tbaK6hb6eWwMOYi1mO43Q+sCBZY/XPbkIYXtjAEhxIBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708386302; c=relaxed/simple;
	bh=jaE58dVT+Z5BQAhxxugZAsJOr197wav/S9cgS2l1Mj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KB+mL0yNv7/eomHhB+5YuS0hCDkpNJUGwwlA9FfxRWNchnePjUXCpzYo7eKRkyfw22B5gM0MkjA7f/kgC0Bp4WslomkLx4BkZxZUEtWQubVu7w9fRzOzNJvOutuPZPGnUSgq7GfkmtB+cuu4X+a3Rv1M0uQplrnlfQca5Iujhhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jz4Br7P0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso12587645ad.3;
        Mon, 19 Feb 2024 15:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708386301; x=1708991101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ik8qJ3aCWPUVoqq8sIut4tSoLjkKaRHYoxxij3VGIi8=;
        b=jz4Br7P0vfedlWnNgsrS0yFZNbYxqJdvLFq9GXrK+xkNwFMgl3bpsUmA0WKiApgnyd
         +oR6zTuGT+eF6jodh4Ib6U5Zw+4x/Z/i4//8E9A9Z9qjG6KK9VjDM0B/fTEx2PuWADlo
         3WzioQPXhY7vR1nV04ZkeWuZtQ3YePKYlcjtYJ38MaMG/JYpLkxOIy2yFux/JZ45mbSc
         fH3rpJ/2Wt+lnczfp2d1/TzcU6c4e6QhTHDYE7pHC846pA2ATayc2i7z65qcfIxJyRZj
         RCiDVY7BHn+fbghK26D4oSj0OGfTJy91BryaM+Kzoc+4E02cVCNCKoeI24nQD3hK01HX
         pFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708386301; x=1708991101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik8qJ3aCWPUVoqq8sIut4tSoLjkKaRHYoxxij3VGIi8=;
        b=oKSmkmOvpK8fEMgXaXvZVI2NRMrWwK2VH+ojr/PwAUml6zcUKHOSC9R1flyH5BMcHC
         oLM/jSF8BQ741ahYx+8OP1otcMWRbMj+gQmSq2IK32Gx7wsiYb48QWx0c13wpZAYSSUf
         6mSyXc9Q+vyuPCa82Iu2chW0JNzgvss0voZH1w67MNoqWju3hgD2wGRuLEq00mYRQ3Oa
         JapfbmGStKGZsvRMURXmfmJD8Ap6ubrGz71YLsFtRTSUX2hg5x7EFPqtkwtGL0/zIqj9
         ZT2lGwT/qysiMai4jMOh72nnP5Ogi7cDIcz7sQiW/nm9moJJ76JQ1AHRT91VvjX4m635
         HMsw==
X-Forwarded-Encrypted: i=1; AJvYcCV/mMnnTU8bpl42kU8poSA88BChqMm/ayEsudLxB69/2TN6ah0Dnfpsr1uos7GQajsY82bEqngjFtM8aHMqNN3AjSiARoJ90VuuYgQDjOfoM3JjGMjv50dXGt8F0qBigOanWbJvKJ5DiQ==
X-Gm-Message-State: AOJu0Yx+PwGels+ke6hfEK051zABYD6yxO04PJPSqMRumwi6dmqQZilF
	vAfBIRCMQ8JbVcpHNDm54ZVEoqtWiBQ64H32Qga37F0Ei6NZcR4l81In2BgtedM=
X-Google-Smtp-Source: AGHT+IGWVm0tSGse6IupEA7m175Dbk/r45hJ5ufpNhJrWBDRFcFErPgV2i19nHNj/gU/NXVKjqYxbg==
X-Received: by 2002:a17:903:298b:b0:1db:be69:d02d with SMTP id lm11-20020a170903298b00b001dbbe69d02dmr12460913plb.32.1708386300772;
        Mon, 19 Feb 2024 15:45:00 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902eec400b001db7ed7ac34sm4903477plb.297.2024.02.19.15.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 15:45:00 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 19 Feb 2024 20:44:41 -0300
Subject: [PATCH net-next v4 2/3] dt-bindings: net: dsa: realtek: add reset
 controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-realtek-reset-v4-2-858b82a29503@gmail.com>
References: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
In-Reply-To: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=jaE58dVT+Z5BQAhxxugZAsJOr197wav/S9cgS2l1Mj4=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBl0+ftkjiEoXvpFVnpXCkvRmQquiU5SZV0hHlVS
 WeRjVQQVKmJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZdPn7QAKCRC7Edu60Qc7
 VsagCACx8ojiSnNf+uyqU0REcyFRzs7wXqxfLprPcer6OACCjy6Xr434XMrOSim5pK7vZSew1mk
 WR+Gu4Okx5DVji5bkKHTC/Dfcq3mQh/QO7rhukkV1OGGZEQ/iJnDCY4Pa4w7Xv+qTJV+6mn1Z3R
 PgMMP2Fz/lu4I/mYP76N2/HfppRALeWahNupQI5QGrlrt45wJV0OVGphYnBEosuqevVylXotQLd
 KEGXV2Rga+zS9GT2akTfNkDNJ2mcZGK3nqzQPsbMJb+K4pVNtLwdsYPMfDtPLYWLZPatqS8NOan
 YOREVlWUJDMKYNdrABosXQUb+v2QjX66kLnsmqVC/UAOlUXD
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

Realtek switches can use a reset controller instead of reset-gpios.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: devicetree@vger.kernel.org
Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/realtek.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/realtek.yaml b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
index 46e113df77c8..70b6bda3cf98 100644
--- a/Documentation/devicetree/bindings/net/dsa/realtek.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/realtek.yaml
@@ -59,6 +59,9 @@ properties:
     description: GPIO to be used to reset the whole device
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
   realtek,disable-leds:
     type: boolean
     description: |

-- 
2.43.0


