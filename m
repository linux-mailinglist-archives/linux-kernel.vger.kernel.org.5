Return-Path: <linux-kernel+bounces-13943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C394A821556
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEEF2818D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF848DF69;
	Mon,  1 Jan 2024 21:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SK2Ffkgf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DDDF4E;
	Mon,  1 Jan 2024 21:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd08f0c12aso4018801fa.0;
        Mon, 01 Jan 2024 13:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704142821; x=1704747621; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tqi/PFlm04D03r/uNnvI0Wh0bkXl0RaxBHMbPg2VEEE=;
        b=SK2FfkgfGMc6kes0mgM5On2pupysxdwEu5PQVAVap0bp7Rl4728a1xbhP31+kn+lPU
         VnXwaaurDyMiuIFuf32TAOxvlvvhGXPhK/IO+DzHtDgyG2WcgA71X4IYAuOcXG8cXLu7
         uq69KmzCTFW5z/YVy6dMnePFEPsqmuIn2g1T7hDdz7A/X1hNEuP7VJL+VZ61+ob0xy+8
         IBclYmRAVNzBmg08KC+WWy/Z31rYbF7VcZg626k6g1UydS47mfnr1ELSMj6zm2nlx5bj
         XSLq6uWsEaiPc//ikRxF21zbYh+21Xo0043+tGUxKNWEBXcQDmW9IDh91oZSdvF5XGuD
         1gYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704142821; x=1704747621;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tqi/PFlm04D03r/uNnvI0Wh0bkXl0RaxBHMbPg2VEEE=;
        b=JmfWuqnmKwQ2D/hyn2k5YhPPwd9joiKHZLoL+EYHdaD3L0dKF3SJiAH5aXvco9/4hy
         QAUmzc3a4cSnbd7dESjhw0iL9J6YukNmK3aaHPhdMgoTCYKdasezu4/NEa3NTVJOa4ex
         oPS5lFhxWINXo9kBguKwclVd+uBmYspe58nw+l+b5oD5Mhjqp0L9Nx7GzO6YUiPD8IBy
         5fJoXRTCNJzEWFz3x515D2kLYNLFK34QeDizQ8E6R0/+XOHUzBUDU3gN6L/JeHEuD0Q7
         o44mzZpjNQFiGny3/gx965Miy98sMEjtRXoqauLuRay5ybhyri7g4XLq/EvrL+05l9DH
         pEUw==
X-Gm-Message-State: AOJu0YyUHy59FknV1YB7F2CQmM+rTCMdd0cn5mRUx30bpkRGfE7NbDSy
	PsBqZnzGIZlMgEIXxqCrMksOUfXGZJ0=
X-Google-Smtp-Source: AGHT+IHdudQvuC/lyGmvDLmISXErlKLgahloCNNddMPoFOYU3xXcQk081H1/xDsa1sPb7po13mCXnQ==
X-Received: by 2002:a05:651c:2213:b0:2cc:d864:124e with SMTP id y19-20020a05651c221300b002ccd864124emr2688835ljq.18.1704142821231;
        Mon, 01 Jan 2024 13:00:21 -0800 (PST)
Received: from hex.my.domain (83.11.207.119.ipv4.supernova.orange.pl. [83.11.207.119])
        by smtp.gmail.com with ESMTPSA id i15-20020a05640200cf00b0055404e08589sm15122045edu.85.2024.01.01.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 13:00:20 -0800 (PST)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH 0/2] Fix panel polarity mixup in S6D7AA0 panel driver and
 Galaxy Tab 3 8.0 DTSI
Date: Mon, 01 Jan 2024 22:00:14 +0100
Message-Id: <20240101-tab3-display-fixes-v1-0-887ba4dbd16b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN4nk2UC/x3LSwqAMAwA0atI1gYaP114FXGRatSAqDQiinh3i
 8vHMA+YRBWDJnsgyqmm25pAeQb9zOskqEMyFK6oHDnCg0OJg9q+8I2jXmLoa/KjC56JCdK4R/l
 D+trufT8/HwxsZAAAAA==
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704142819; l=715;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=SZn5M9Pk6q9VjN++Ee+TessamT4rYBp1C1F4I9mxRN8=;
 b=wBY0KIHnA5bzFetxlwqtDbP103C+pP9HM7SG3H9Q4sCCtzwiy6Erlb8Ux10uWKtZSSei3OiNV
 298Jx2OoZdgCOKOldtWLnCf2PijMgNEORBRuIebIOme6UuYfk2YXNB2
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=

Two small one-line patches to address a mixup in the Samsung S6D7AA0
panel driver and the Samsung Galaxy Tab 3 8.0 board it was initially
added for.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Artur Weber (2):
      ARM: dts: exynos4212-tab3: add samsung,invert-vclk flag to fimd
      drm/panel: samsung-s6d7aa0: drop DRM_BUS_FLAG_DE_HIGH for lsl080al02

 arch/arm/boot/dts/samsung/exynos4212-tab3.dtsi | 1 +
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a
change-id: 20240101-tab3-display-fixes-6516f0b6a1a1

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


