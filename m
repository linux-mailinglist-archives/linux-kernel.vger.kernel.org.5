Return-Path: <linux-kernel+bounces-155375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9C28AE982
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2423C281DF4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CED913C3C7;
	Tue, 23 Apr 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnGPfWC+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7813BACF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882670; cv=none; b=qdS3MmyEDYaz8SsEC8kPgTTIdiLq/MQLSbaE+MwS9YmyAPVQgx0vPW5Ee4YiNj50h1EOpR9RikOBE/CD7LhMZN/1aur58VwZidCNz6ulBAtCCTwIsbGCBqLERVygHEy7a80bH3z6myfuIGzA+L10KhiHXFcIbr2GpHp5450qC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882670; c=relaxed/simple;
	bh=+YH2zKNvfrQqZ4esdPy7vnvlXDgMvu54ag6LcGuFPeM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RDX1lkGNsWihdU3lHan84Gs9M9tacLQ9XoqBadw1u+b3jg/Z0gxQxy0E0d1ggGubHgEoHe/D8xW/AfzYCmsrw9GPLSmPWmZq5OUpIF9ttxKL/bz4jXbdPelcoggHs3wA9jxNW1KfjshN0kj4dfx/onSoGg/10ShgqrrNRiV96q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnGPfWC+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so6720196a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713882667; x=1714487467; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XN7XhWrqCld2WJI0opNRnIm5kxokt1XlrZPOr6Jx6ao=;
        b=YnGPfWC+2NdbGvd4mVAJkhLCmOljC/PanI2UqKNrEGphf6/XHH3u9OtJlD6zPb0Dbd
         B5Y9R1Sacn/HjpsvjXyGQGp6T55Piei4zm/d9Elnpfdn51kRsbSM8h8cmIN6yE9jSD65
         6JeTgAhUhWf+LXMhGnsNzTZkl2O1/Qxr4+M7lhvJJ3HinU/bPPPa7XfssMRkLB8MCRy7
         jsq9DgeIu4vAIGKnG9FXJZGc45ddk1jFUakrKWDbCJ7Dh/5UheXSYaGEHpe0hGtG0bXD
         ld2r35Sg+rZkRHESWVlOTr3e/qFWtjZ8NVbmWQxjyiomdzwswA9eTYkffFXe3F5V4n4+
         1K6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713882667; x=1714487467;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XN7XhWrqCld2WJI0opNRnIm5kxokt1XlrZPOr6Jx6ao=;
        b=EFhohHk770rg+cGEDyqtWgeUkJ6nLiXX8AA8k3Z9SuzCIrFp8Hm+fqPXx8GerwBRDS
         jHU7BUEzwvHQ3s7HV2/jlTZg4x5o1WJtOOIHotJB3UXDSk12vwtX5Eg1xzhwcEnhJXg1
         i9vzPVjy6sjr8PCgeLbIkY2vfZfM5HHj9F1xdMqc/r0uAzQ5F92rWrWSlPD6ozFq17K+
         ua+mh7Ds225Zs3W9jC8F9m2dBuwmwoY8LA0GokMWhRsRPAu8ZiaaG85SSWCaMv7Z0C4d
         FdOMDTds3bSuft5haohDDbnIos3LHvhJYHnHXPw3eCaigPGRFgYN84aDXBAC6IJuPWEf
         Sfkg==
X-Forwarded-Encrypted: i=1; AJvYcCWwwVxpzLsrAA19XaY6ZpYjZwZRvac+L3s8VrdUybyeBIlUTGKntiiJvN59XTLXtLLJFcJq8nbWKBHksY76rE3KIFWuTRscBbq9zWpH
X-Gm-Message-State: AOJu0YwpuxoTJv+zG1H5e+alA9NQI5tD2sMW3A5bxnutwG79TSH/3iYv
	DxtE28Kxxn6c7cuNv76yfbl0JevEo5NR+eKPbc6dZVRAggORz24TJQwOd37f+ko=
X-Google-Smtp-Source: AGHT+IFkVnrNX1IDHUGi9HUaySI3oc05M9oUsQt/QaI7SlEvCuUbmasv5YX0v5fmV1NffjKybeOPCQ==
X-Received: by 2002:a50:9ec1:0:b0:571:b9ac:ff2e with SMTP id a59-20020a509ec1000000b00571b9acff2emr8291625edf.26.1713882667324;
        Tue, 23 Apr 2024 07:31:07 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005704957a968sm6708099edb.13.2024.04.23.07.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 07:31:07 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] HSI0 support for Google Tensor gs101
Date: Tue, 23 Apr 2024 15:31:02 +0100
Message-Id: <20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACbGJ2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNj3YziTAPd9GJDA0PdxERzcwtjM8OktMREJaCGgqLUtMwKsGHRsbW
 1APtqc6pcAAAA
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

This patch series enable thes HSI0 (high speed interface 0) for gs101. It
feeds the USB block and is a prerequisite to get USB working.

The parts added here have been verified to work OK without the
clk_ignore_unused kernel command line option.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      dt-bindings: clock: google,gs101-clock: add HSI0 clock management unit
      arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller
      clk: samsung: clk-gs101: add cmu_hsi0

 .../bindings/clock/google,gs101-clock.yaml         |  29 +-
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  14 +
 drivers/clk/samsung/clk-gs101.c                    | 468 +++++++++++++++++++++
 include/dt-bindings/clock/google,gs101.h           |  54 +++
 4 files changed, 563 insertions(+), 2 deletions(-)
---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240423-hsi0-gs101-aa778361bfaa

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


