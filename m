Return-Path: <linux-kernel+bounces-5973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A3819254
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBB6287E38
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD83B287;
	Tue, 19 Dec 2023 21:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IidnZyUz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF83A8EE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5d12853cb89so65684637b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703021658; x=1703626458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zwUh/psHh6P+Upw6vf+C67rCFJVu4fC5VMYu2ZcViuI=;
        b=IidnZyUzF7CTa0ZKvy/4GlNK7tP6vMag1X2nRqoa3sZIeR4Jh7v4eqTP+wHDJcuPRj
         L98WZPdzp9FWXH0cfm3v6riQlakGR9rZrhHJStfPQCQfen/0FEHx4MkAoQsxukeQiTt5
         SyjQ+D226LqErd50PaITcBl7/DnygpBUwBkIcK+AnzJhMpdEAQ2/Nu3bRY38zTYbrKR2
         KtBxokZRQjnbPNuyx2LmJm0zhYGX1qGrPr3s+ohn2dQA4oFeZL/LQn1UKT+frmX39qeA
         rBA0oJZEjdpUNEuHi5/k/bdlDtAQzsGPjkZUjyARNr2cbbNRV8G6AUC0bFhJs1tDXRdL
         L6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703021658; x=1703626458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwUh/psHh6P+Upw6vf+C67rCFJVu4fC5VMYu2ZcViuI=;
        b=RD/TBf1f+S3AzhWcq9AeVuj9zNUiGOkNdR3bLwQ9+6HHm1u2EkjBmZpytdia+p70Ud
         RfGuJpKHvT+jRW5o9fCt1Z5nNEc7wB30OqJf4kNS13aXB78YcbY11nhsrPzJHAL14T+P
         tv52hixE4DAMs/R/vv0+MR6ttIExahIzpkXdg5ResvDthDJ9dhNMn0X85An94zJxypU8
         ArizMMreeLj9Zpty4/iPwDD+xo4Bx3G7kDlYNbdqwvcaqsJSSDR1utQIkXgJ9DZni+VB
         9/zh3G/JFPm5yntcJzXQJsvQ0K35S93ryGHFHt7oxuxKBT5OSfOGD8HClz0qyF1q537v
         ExBg==
X-Gm-Message-State: AOJu0YzUWJvaJ0kd4IEXpQr5oxDOAXmu5uCteQtwaYK0cgmuFMSOfDYy
	AKluNc3myxDCu7Yj1zxrWXSfaEv7ZuV1hWnsAA==
X-Google-Smtp-Source: AGHT+IFfWmrwvJ+LQE/+3L58Im6RK0bH8l2Luf5pEP/hNf0sGSRgxZVXWy3OWx7eYylbwxOUqOGEzrLuQfcmLj4PEQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:3507:b0:5e8:885:ae15 with
 SMTP id fq7-20020a05690c350700b005e80885ae15mr500864ywb.10.1703021658435;
 Tue, 19 Dec 2023 13:34:18 -0800 (PST)
Date: Tue, 19 Dec 2023 21:34:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFYMgmUC/5XNQQ6CMBCF4auYrh3TThGKK+9hXGA74CRKSUsai
 OHuVhca40aX7y2+/yYiBaYodqubCJQ4su/zKNYrYc9N3xGwy1ugRC1rVBDH0NthBhc4UYjA7GE
 IfuIrjzPEqdZYgAVjdaGrsiqlrkXGhkAtT8/Q4Zj3mePow/zsJvV4/04kBQoKMg5N6xRVdt953
 11oY/1VPBoJX66SWP7sYnYtUUlbd6qk/Hb120WFP7s6uyfTkMLWmmbrPtxlWe6aYjCEjQEAAA= =
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703021657; l=5996;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=zV8ob/kKeQOCUbTGD4IgUwF1RW2GLaqMgJg6k7u3Ffw=; b=cMMYIbX/ROmR2FxtRFigqf4i65Cb6JavIys72kWHi4zVnvBBVxNg7xh2rRhoIr1s6OuNLenWC
 QexnKn6MD5CAckUhrZtwSEc1pUyJ9Vh0RG6bzsg7cf5QcXGheJLqbvd
X-Mailer: b4 0.12.3
Message-ID: <20231219-strncpy-drivers-iio-proximity-sx9324-c-v4-1-d49ed29ee952@google.com>
Subject: [PATCH v4] iio: sx9324: avoid copying property strings
From: Justin Stitt <justinstitt@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

We're doing some needless string copies when trying to assign the proper
`prop` string. We can make `prop` a const char* and simply assign to
string literals.

For the case where a format string is used, let's extract the parsing
logic out into sx9324_parse_phase_prop(). We no longer need to create
copies or allocate new memory.

sx9324_parse_phase_prop() will simply return the default def value if it
fails.

This also cleans up some deprecated strncpy() uses [1].

Furthermore, let's clean up this code further by removing some unused
defines:
|  #define SX9324_PIN_DEF "semtech,ph0-pin"
|  #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
|  #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v4:
- use u8 return type (thanks Stephen)
- remove unused defines (thanks Stephen et al.)
- tweaks to sx9324_parse_phase_prop related to defaults (thanks Stephen)
- Link to v3: https://lore.kernel.org/r/20231212-strncpy-drivers-iio-proximity-sx9324-c-v3-1-b8ae12fc8a5d@google.com

Changes in v3:
- extract logic into sx9324_parse_phase_prop() and use string literals
  (thanks Stephen)
- rebase onto mainline bee0e7762ad2c602
- Link to v2: https://lore.kernel.org/r/20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com

Changes in v2:
- make prop a const char* and do simple assignments (thanks Jonathan)
- rebase onto 3a568e3a961ba330
- Link to v1: https://lore.kernel.org/r/20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com
---
---
 drivers/iio/proximity/sx9324.c | 70 ++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 438f9c9aba6e..3daad7167c63 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -873,6 +873,29 @@ static int sx9324_init_compensation(struct iio_dev *indio_dev)
 					20000, 2000000);
 }
 
+static u8 sx9324_parse_phase_prop(struct device *dev,
+				  struct sx_common_reg_default *reg_def,
+				  const char *prop)
+{
+	unsigned int pin_defs[SX9324_NUM_PINS];
+	int count, ret, pin;
+	u32 raw = 0;
+
+	count = device_property_count_u32(dev, prop);
+	if (count != ARRAY_SIZE(pin_defs))
+		return reg_def->def;
+	ret = device_property_read_u32_array(dev, prop, pin_defs,
+					     ARRAY_SIZE(pin_defs));
+	if (ret)
+		return reg_def->def;
+
+	for (pin = 0; pin < SX9324_NUM_PINS; pin++)
+		raw |= (pin_defs[pin] << (2 * pin)) &
+		       SX9324_REG_AFE_PH0_PIN_MASK(pin);
+
+	return raw;
+}
+
 static const struct sx_common_reg_default *
 sx9324_get_default_reg(struct device *dev, int idx,
 		       struct sx_common_reg_default *reg_def)
@@ -881,38 +904,29 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		"highest" };
 	static const char * const sx9324_csidle[] = { "hi-z", "hi-z", "gnd",
 		"vdd" };
-#define SX9324_PIN_DEF "semtech,ph0-pin"
-#define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
-#define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
-	unsigned int pin_defs[SX9324_NUM_PINS];
-	char prop[] = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
-	int ret, count, ph, pin;
-	const char *res;
+	const char *prop, *res;
+	int ret;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 
 	sx_common_get_raw_register_config(dev, reg_def);
 	switch (reg_def->reg) {
 	case SX9324_REG_AFE_PH0:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph0-pin");
+		break;
 	case SX9324_REG_AFE_PH1:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph1-pin");
+		break;
 	case SX9324_REG_AFE_PH2:
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph2-pin");
+		break;
 	case SX9324_REG_AFE_PH3:
-		ph = reg_def->reg - SX9324_REG_AFE_PH0;
-		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
-
-		count = device_property_count_u32(dev, prop);
-		if (count != ARRAY_SIZE(pin_defs))
-			break;
-		ret = device_property_read_u32_array(dev, prop, pin_defs,
-						     ARRAY_SIZE(pin_defs));
-		if (ret)
-			break;
-
-		for (pin = 0; pin < SX9324_NUM_PINS; pin++)
-			raw |= (pin_defs[pin] << (2 * pin)) &
-			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
-		reg_def->def = raw;
+		reg_def->def = sx9324_parse_phase_prop(dev, reg_def,
+						       "semtech,ph3-pin");
 		break;
 	case SX9324_REG_AFE_CTRL0:
 		ret = device_property_read_string(dev,
@@ -937,11 +951,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-			strncpy(prop, "semtech,ph01-resolution",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph01-resolution";
 		else
-			strncpy(prop, "semtech,ph23-resolution",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph23-resolution";
 
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
@@ -1012,11 +1024,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_PROX_CTRL0:
 	case SX9324_REG_PROX_CTRL1:
 		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
-			strncpy(prop, "semtech,ph01-proxraw-strength",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph01-proxraw-strength";
 		else
-			strncpy(prop, "semtech,ph23-proxraw-strength",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph23-proxraw-strength";
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
 			break;

---
base-commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039

Best regards,
--
Justin Stitt <justinstitt@google.com>


