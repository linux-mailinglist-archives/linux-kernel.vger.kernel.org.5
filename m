Return-Path: <linux-kernel+bounces-5157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C2818754
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34C628547C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAF018022;
	Tue, 19 Dec 2023 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkzEyy2v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C332A18632
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d3c76ee799so13414725ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702988542; x=1703593342; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bydYSCX5eHzsLJIGwDYljI+FhHkzmfYKJABU0jjK5e4=;
        b=TkzEyy2vDXJEzKy6wpbe8jKURklIGAtxNs8EMOMzJ5dpLbC9rQ8BqPafuk+45v6GtQ
         sV6P4kgKRiEhF4pCw/XwjjHd4B63z+Wn9N1rVWgVx1+jZDlE47RbpQic1u1q9kBNRsqg
         PHMPzQ35xaNg5efe2eSytZmwHSLYe14EF+lFsufB2IUMyqgeHkTjCqdy37rc7n8Hxdo7
         sJrEZ7qiyB1j7xk3iYGGU2t8VP+Xo4SobmdnhByB2DyNH3jELLsGKmmhIxVj+rWm/6r2
         NuFnFgfHp/wbHI9XyjIq1KlHYiZONwBPV3dYuCGftrNLcbZYxfG2WqBDSmvvlkEE9MJd
         FO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988542; x=1703593342;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bydYSCX5eHzsLJIGwDYljI+FhHkzmfYKJABU0jjK5e4=;
        b=ekTwkOWcCa+Sn7CWusBdLhfIvwM/r0wV/i8c7z9ykUJ0af/P8tS8EzV+IBAARQgv/X
         rDO5ziXKgDCne1FTum0j+OMXXWC/80iCbMIQcJOz/3P6LUXZ8CGDHoNwk5kEpUODEur3
         mJE9C5SA2tJrx0lWB60M6Qhtx/HF+vz2PhMZ3RaaSTMMf0nlxVI8NvXdz7/HWh0GpWTB
         2J1aijHGZ2HUizG3q9FKCPaE/bkdfhCgH0QBe5pkVQtzRKPdPKEvkp90m+5b5dXJQXUf
         muJ36KqLVAQbK5SPiviqpYYg9MJs8PrYQvRwqvPVaDVOaV2zZbahPdxoIn7g83p9uV40
         mvQw==
X-Gm-Message-State: AOJu0YwXt99JAe5cHprqu3PvdV9Qxp+RI7m5wHM2bGCLhwyiUVQGv1a8
	H6y/r/MqaOLJrCf0Y+QwqvYK0VPBUK54eO63lNA8RbIe
X-Google-Smtp-Source: AGHT+IFAF7eA49s8oqLTUDnV7+k6pC7ZwfagYvA1eQWfpgozUXjPS6m5Vy98ABrwzvbIS8azVdbBQg==
X-Received: by 2002:a17:902:e74e:b0:1d0:6d5d:5e4d with SMTP id p14-20020a170902e74e00b001d06d5d5e4dmr8654007plf.59.1702988542090;
        Tue, 19 Dec 2023 04:22:22 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902b19100b001d366f8cfd7sm7719419plr.182.2023.12.19.04.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 04:22:21 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] arm64: qcom: sm8650: add support for USB-C Altmode
Date: Tue, 19 Dec 2023 13:22:11 +0100
Message-Id: <20231219-topic-sm8650-upstream-altmode-v2-0-a608528864a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPOKgWUC/43NQQ6CMBCF4auQWTumLVrBlfcwLJoyhUmANm0lG
 sLdrZzA5fcW/9sgUWRKcK82iLRyYr8UqFMFdjTLQMh9MSihaqlkg9kHtpjmRl8FvkLKkcyMZsq
 z7wlrInmRrrfWOSiNEMnx++g/u+KRU/bxc9yt8rf+W14lCry1QmgtdFtb95h4MdGffRyg2/f9C
 3CCcgjLAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=940;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=CfekqcLq59Az8t88PXdFsOu7qu05LO1LTQZyl9hA14w=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlgYr3piOIQKgjrLEZtzcijK5l3Qo4I31ay8BvLF+I
 pOfZORiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZYGK9wAKCRB33NvayMhJ0Z1CD/
 0SnHZqyTcfadg9WmKDR5m5dI54+9y/6aErfD9lG93i1Zi/hYikCr6Z6ZbEbY1RMaIr8sjuvXm0or/v
 fc6NMcOdeZZpPUkFWibD1nO75jy5wfC5EMJ24f6EGcTRZB9bvE2G9z5o9k7K+MkR2+GntghkucHPcT
 b+T1vMCkCUXtm1Mz4H+WGoM8GmMYdu2CU95Lde6AedDTlC9rlv7y2dd8sz+vcniNl8rsQBTAyAM5Mu
 3LJik151oY2ETyY2flrG0wdkMKcQu8MfodocTbXXcepbykGucDkFoT5zXnJ5M1I6TTGih2nmSwssos
 JvV250LyvzfrEkzn/DOZfDsDYiSOXh8hykWcxivBqMhGZmKsv5HWArW3sSbuZJ6ZxlUWKeeztkCxn4
 hsL0qjexUdkIFAWomgfVncDKvYDEHWMxZFLbn5gNw3QSj9hKF6qOy9Zo7UmhLkdhPdYJISzhcDOwE5
 SlbdEYqyDnQyUeGamtAJX5eI88+gkRYKBWsAGcarlEFuyZ0L/U6KFPCf5fgkZXjuitiZdSdYhNaVep
 RDT8pEkFuhzmKBtvjgD0QPiUQAE9ZUOR4fG43SOlPeHOjkweNcZGEppS3M+iJ5j99MzIUQjG1P6C+6
 OASvsjR2JcZrGg3wAY3MuOhJpdIuo6keEkkjGHSAIg3LzDsLF4y+cajcPWQQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This adds the missing bits to support Display Port external
display over the USB-C Altmode support using the Redriver/Retimer
and WCD939x USBSS Mux/Switch to provide the correct switching.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- replaced "ok" by "okay"
- Link to v1: https://lore.kernel.org/r/20231218-topic-sm8650-upstream-altmode-v1-0-7900660693cf@linaro.org

---
Neil Armstrong (2):
      arm64: dts: qcom: sm8650-qrd: add USB-C Altmode Support
      arm64: defconfig: enable WCD939x USBSS driver as module

 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 104 +++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig            |   1 +
 2 files changed, 103 insertions(+), 2 deletions(-)
---
base-commit: ceb2fe0d438644e1de06b9a6468a1fb8e2199c70
change-id: 20231218-topic-sm8650-upstream-altmode-3ee141fdccff

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


