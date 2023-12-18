Return-Path: <linux-kernel+bounces-3762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89518170AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86837282BC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED63F11CA6;
	Mon, 18 Dec 2023 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YquedR+o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E041D158
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so29486375e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702906965; x=1703511765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyEG4+5CWlynpKgbnqEksNZUKPX7fzBsT3XPQGSore8=;
        b=YquedR+oCDpFK2QO1vifa6qmqchNGSs6FM34pFufOPCCqjZ5n3nXHrH2UQsgQqUI7Y
         Jn2gjr6+Fy1MZRnrUmICAAZdQ3lWF4szuqHFGY4OVCLErUoexf1NzhCCZaxuQTRhxwq3
         PMer1zr6X/hjNDi26Z3AWlz2A450Lv+8U0IqjN63zW0n7rGFjatz8M/ZxohqvgHqOs8n
         YNnZNrQ88N3kzMTn3BPwRgiuZaqq6SSguX+jMi9FbY7MI/V+da0Ku4ZcKMKA8E3Vussi
         DJXvX8vGldWHg7uwHEzXOLRmirBDXvm0oye+QPbQrO2q43DoeGETTad/O7Qnp/EmRFQP
         VCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702906965; x=1703511765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyEG4+5CWlynpKgbnqEksNZUKPX7fzBsT3XPQGSore8=;
        b=RitDI37xnvMKFDBDZFPQuHSpQl9f6E/SSQDSd8MxM7bftXl8zJo+cAGczD/RsnB8Wv
         lh2Bn9cNB9eBIA2Exr3E2AZGzYYm8KYmQYQZNkZOhH9s9nNNfIyro25rIZT5HnElawqs
         eOudv86N+X8xEnlkch+lnwsOu8yLQzOREXSM7lbV7B9Cog95VdVWAdfn7upJmviclpcr
         D9bQvsB6NtagDs7evoCOLQKffZHzAKujmMhLfum/oN81hPU0f6I3hWD+I2mA98R4+ygx
         lUEWWliVnk2n+URizfuLLQ9CsZImAMxRbitL0GrU7AlcQL6eAAg/WDP9Rm3qQS0egJBr
         +8sg==
X-Gm-Message-State: AOJu0Yxhw+pu2H/sod1qGLJ9SOSr3Y53jVWWysuqM6mRofQdOov/b6gA
	spNiTg09OjQMpxg6oeRQOrqwyA==
X-Google-Smtp-Source: AGHT+IFEsHmQvoI+lwVFUNs2ikaUGdgRgCy7+Zn0cnWHJ6oZBH16pyO7uuiglM/OBqgJBBq7eFjBgg==
X-Received: by 2002:a7b:cd12:0:b0:40c:33aa:4ef5 with SMTP id f18-20020a7bcd12000000b0040c33aa4ef5mr8025674wmj.91.1702906964902;
        Mon, 18 Dec 2023 05:42:44 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906530700b00a1b32663d7csm14242327ejo.102.2023.12.18.05.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 05:42:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] power: supply: drop maintainer-less BQ27XXX
Date: Mon, 18 Dec 2023 14:42:41 +0100
Message-Id: <20231218134241.50284-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BQ27XXX charger driver does not have maintainers nor status:

  ./MAINTAINERS:21808: warning: section without status 	TI BQ27XXX POWER SUPPLY DRIVER

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cdf1575dc851..28b98fc4637c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21763,11 +21763,6 @@ L:	linux-omap@vger.kernel.org
 S:	Maintained
 F:	drivers/thermal/ti-soc-thermal/
 
-TI BQ27XXX POWER SUPPLY DRIVER
-F:	drivers/power/supply/bq27xxx_battery.c
-F:	drivers/power/supply/bq27xxx_battery_i2c.c
-F:	include/linux/power/bq27xxx_battery.h
-
 TI CDCE706 CLOCK DRIVER
 M:	Max Filippov <jcmvbkbc@gmail.com>
 S:	Maintained
-- 
2.34.1


