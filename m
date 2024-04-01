Return-Path: <linux-kernel+bounces-127205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE128947F8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0CE1C2184F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE25957860;
	Mon,  1 Apr 2024 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FBL5QGAa"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7F56B81
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015477; cv=none; b=JNxEesBc2L9w0ckUhlB7jkQ5b9UE8dI+GUPzdPnJwSopp3EZRzY0IGcm5BxT96Nh+cJi8IL0V2PA7nXM8fbuI8C/++L4lzuRw2K6iJwe0N4hBqWA0OmmSJTkTL3mCF35/rxy5RHqdAieeGdvZqZfeLcj9iQcqQM3UA70LkpBykA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015477; c=relaxed/simple;
	bh=AIE+v3isfbEbNJwblsGQEZ9BeAZNLAvQspWBKbN90cg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ce2DriG8uL8XrMvYid+MlNQB9JwdthRHnCXaT8HCRMlMrVyIBZiOLwfo7wxZWfO13/+VwiWaLkGZj8dfqb2pxg2yNho5BY/U30JAB8Qv3Iy6oI9LJY4BgcdrIB2mR6CvNXf4cDsxbnDrnpJtRfbOID9sLsFgtpmeJSEYHiSqj0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FBL5QGAa; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516b324ad69so381743e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 16:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712015474; x=1712620274; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dcSVI3IWYNVdSPmBC0C2QNVAXSUlaGzN8zET/T3Huo=;
        b=FBL5QGAaLE7u1ajTxg4NwD6oRzWF8seTF4S2qA4BOzKBtuekoUDYfPNh9BH+0SIH+6
         NcTX8T3GMeg+YaeZ1b7X064NMkdwpTOW0olKpDpYG9SkO7SdKrYKAa6sTgYj96txzbGN
         /VJBxMAnr12DUelfHQ/OjJgFz8MHcLYd9ysjBmkls6R4uUuzmqKifiRD8CCSngh1C2nv
         eTGO/c70NCiJtq6RWPpWodUBIbsO7iEouCoeEP76DUqiif6u2PyNd+VHlYOhs+u6TGHH
         Lv5bONagqO1T5KzYmkC2llGFlkg/8puyiDJJicSkVzP2K5S1ZBq/DE575Pyx1pD3aMd7
         7yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712015474; x=1712620274;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dcSVI3IWYNVdSPmBC0C2QNVAXSUlaGzN8zET/T3Huo=;
        b=JDiG+B+0AEYlbF3nuhOV4COZahr9hWTweMFOjHD4F2xpoXD8w2+uflP0hzKxTUW0kb
         5tQ3xFh2jAS6z6Tw5dNWetZyuJb6zK6c9Ud8So0D/MpauOEOe2SA4lfMCa1XBMix0NEl
         7fzjVriDcevlluPT/PXus9pGAwPFjQMVjMKR1BPIWpQ93Ho1f2Oi0OHtdtLT7/mcaG8a
         0KzgUOJHZhOnWli7zLPdq6W9H4ZfYBYjMU0+czTrAq0Dxl5n58pPzqOjRTFJ9zJ/d+E0
         UCd1p5ex5C5NyUxMQ8ATJ2TfaDWZfvUwePhzC8qak+8XwyOnAd3X4Yy2OzfFHt0ymnCO
         PgPg==
X-Forwarded-Encrypted: i=1; AJvYcCV490J3QL0qMAPrcPdQ7sXCUjO2uqp24eJaa1VGpli8L9DJFHo/d3JEBqEV/gCj1NyVNXF8YjqSjQLz+J3zdVt83T7WGmO2PpVrPkza
X-Gm-Message-State: AOJu0Yz9lXj0OHEnQoHOlQy5mx+RT8uuuZJLze+cgC2og3KAaFs7hj49
	JlPOaKji8uH4JGIbe+xE8XlD0g6gXSrqegSCggsD/Mnfho+P+iVa0r3hsTyDXXM=
X-Google-Smtp-Source: AGHT+IFYSCeMxGqZ2MbE1waQe/9063olfwjZ1oTGYegt2N0rOdrSyiwLNPjYVdZg1fOsMFVZeGMzIA==
X-Received: by 2002:a19:8c04:0:b0:515:9aba:743a with SMTP id o4-20020a198c04000000b005159aba743amr7163184lfd.59.1712015474106;
        Mon, 01 Apr 2024 16:51:14 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id g28-20020a0565123b9c00b00515d127a399sm1176135lfv.58.2024.04.01.16.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 16:51:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 0/4] drm/panel: add support for LG SW43408 panel
Date: Tue, 02 Apr 2024 02:51:11 +0300
Message-Id: <20240402-lg-sw43408-panel-v3-0-144f17a11a56@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG9IC2YC/4XNTQ7CIBCG4as0sxbDb0pdeQ/jglJoJ2mgAYOap
 neXdudGl++XzDMrZJfQZbg0KyRXMGMMNcSpATuZMDqCQ23glEsqBCXzSPJTCkk1WUxwM+mV4l4
 yZpVwUM+W5Dy+DvJ2rz1hfsT0Pj4Utq8/sMIIJV4pTb3tPB/MdcZgUjzHNMKuFf5P4FXgnTBKt
 6zthf4Stm37AEKhG/vzAAAA
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2055;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=AIE+v3isfbEbNJwblsGQEZ9BeAZNLAvQspWBKbN90cg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmC0hw1zyg3pAwUtnjkm+5F8dYu9r5Jix16Jwgd
 d5XVDHdzF+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgtIcAAKCRCLPIo+Aiko
 1dG3CACR4Oyf2mAyMzZiyD5RWhCiID+SZ5tnwd5Zguqhu+bKP68AWpQ+ckh6dZmUs0A7DslNrAR
 Z3fYeMEIWHk1sWMxedMcymSYfnBb3VoXunNufkBA3HBylB7zGrSuZ7Gr68W/Z7HXftfu6PeacOx
 0ib8+dIrDFXHx7jvzGAIGLIjb7C5Y/qFe/7LsxEeIyNADMoD58iutryQyVrFnGIDLFJFg5nDuFu
 H1j7k9wxHmQnY91jultTOs/37Rx6gkPKOmZPOsSdKpUj7pQzzV1h3e6BSltztv7hEdUn47hMfUr
 3mOnDPjuIRNMF08qnVlteUfwH4NQgTG7uUBocJZvtjX6YbSr
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The LG SW43408 panel is used on Google Pixel3 devices. For a long time
we could not submit the driver, as the panel was not coming up from the
reset. The panel seems to be picky about some of the delays during init
and it also uses non-standard payload for MIPI_DSI_COMPRESSION_MODE.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v3:
- Fixed return type of MIPI DSC functions
- Replaced mipi_dsi_compression_mode_raw() with
  mipi_dsi_compression_mode_ext() (Marijn)
- Link to v2: https://lore.kernel.org/r/20240330-lg-sw43408-panel-v2-0-293a58717b38@linaro.org

Changes in v2:
- Removed formatting char from schema (Krzysztof)
- Moved additionalProperties after required (Krzysztof)
- Added example to the schema (Krzysztof)
- Removed obsolete comment in the commit message (Marijn)
- Moved DSC params to the panel struct (Marijn)
- Changed dsc_en to be an array (Marijn)
- Added comment regiarding slice_width and slice_count (Marijn)
- Link to v1: https://lore.kernel.org/r/20240330-lg-sw43408-panel-v1-0-f5580fc9f2da@linaro.org

---
Dmitry Baryshkov (2):
      drm/mipi-dsi: use correct return type for the DSC functions
      drm/mipi-dsi: add mipi_dsi_compression_mode_ext()

Sumit Semwal (2):
      dt-bindings: panel: Add LG SW43408 MIPI-DSI panel
      drm: panel: Add LG sw43408 panel driver

 .../bindings/display/panel/lg,sw43408.yaml         |  62 ++++
 MAINTAINERS                                        |   8 +
 drivers/gpu/drm/drm_mipi_dsi.c                     |  37 ++-
 drivers/gpu/drm/panel/Kconfig                      |  11 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-lg-sw43408.c           | 326 +++++++++++++++++++++
 include/drm/drm_mipi_dsi.h                         |  15 +-
 7 files changed, 449 insertions(+), 11 deletions(-)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240330-lg-sw43408-panel-b552f411c53e

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


