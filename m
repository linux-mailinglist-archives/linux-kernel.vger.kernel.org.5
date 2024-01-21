Return-Path: <linux-kernel+bounces-32158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49683576A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A51B21131
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 19:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D73839E;
	Sun, 21 Jan 2024 19:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFb512zS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEB4374EB;
	Sun, 21 Jan 2024 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705866281; cv=none; b=LcTGM/wp8GeDtbjC64ahVk+eqDVQZo2Lj32cbvYbfxbcgjpCHRKWzH6os3viPGxHZf6msIZ1G5ojj8gofQfcRYjeHEv8/jQJDLxn0Hd8cuNRMaPxNmTRxMzMIgR4m0xzD2lwz2MBWQ5004OGc2k78q02HSC8YMQ94YWMwDETvpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705866281; c=relaxed/simple;
	bh=FgERju/0//bdfNQmRwUlS2ZC4bK0PMzYrsC31E28Ofo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BxGOO4eOI65CB/EeK9kFXa/DEpF0HFizmQGcIcfTMdh+NSDZzlOWG+fmW31zGpW/Om799Bd6o1fV+hCxxrWyVplqcRNjF5kP7wArc3s8JqNTAfF2n229F0yGX+DTjm7svRXBXfSrmV/UvsJ/4TqjinEktlNNnwj+82893A4jKgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFb512zS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so417324366b.1;
        Sun, 21 Jan 2024 11:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705866278; x=1706471078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b7qx5rqlh0FWuE9XG787u8jZCcutzKDjwwsd5hGee8k=;
        b=WFb512zSiu4vLUolHSfo/dQPOAgXNkDXlDiJoPj5l5EIYVx1xPClJ5QEI3PJmdJA+P
         6AHhFsS/oUrDGknMkWPgjmqgy0XKD72X2z0Sv76zjM90g80Q/fJv3ZGxoJmxXD1x7Iti
         CG8eZ2OE49GUQ/lzwclctK5bHwwFEYMcQJ0neJJ+LHPQiscOUYZ8k/2RA+HUGmgACGne
         7SBdjX1NsaCyGaj8HESqkF1re9i2f/l+iXNyysRoKh6Zpb1vpc9fcF+0DQLKQsEUmst0
         HkFnmEBnTl46WwpVYAo0nodbxok/vX/JNsE8MT9suWU3wkoK/BrHGa3zUrZs8oFisHsx
         yGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705866278; x=1706471078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7qx5rqlh0FWuE9XG787u8jZCcutzKDjwwsd5hGee8k=;
        b=qENdKixN8xJLWGKCOYSu40MRD9RL8PmBgnutW+aatiRg5+UKchsioWGhvMTfZ1pI9K
         RERD0dRwrMqcFwAS+DAYQjYnuinYBQSZkJxhwsGfJIJGCi4st3H8xmeN1g5Anwbd2yYJ
         xVhmdSSL5xLTmHPpxwRRkjZnWUzyUfpCRgMnt7iAe2WCeFTnaWYIC0khiLH+Nq72CGYB
         M4Nx12ajjVcMnQYoxxspz48iWaOQRZbcJ5quZSx+pxzBsF14WhLeHvxO8RPN3ckDwP0j
         dtyBVhuylCwUx5EXdOp28fsriW46PoAWeWCTARq7FQkhHjccv4+FzhLVOm6wLbiD8cbM
         BRzw==
X-Gm-Message-State: AOJu0YxaILFm7WWCdRmAQL4cQYUOvw6q9jtYh0d+KWUjQGoj1BOsQrHo
	IrAuz/5lEOxbo+P4jASlHCrGFe0lmCC5y7RFFx1MhwqlyJIrhNhat3xXYW2AnmE=
X-Google-Smtp-Source: AGHT+IEUIwjgDLvSlIepivXTVds4fmOThAhEeE2VQdGUMP1Ux128ZnPqqT0eEiqb7+oRPEbs1BTjsg==
X-Received: by 2002:a17:906:70d6:b0:a2d:468c:3845 with SMTP id g22-20020a17090670d600b00a2d468c3845mr3183703ejk.35.1705866278086;
        Sun, 21 Jan 2024 11:44:38 -0800 (PST)
Received: from localhost.localdomain (byv51.neoplus.adsl.tpnet.pl. [83.30.41.51])
        by smtp.gmail.com with ESMTPSA id k6-20020a170906128600b00a2b0b0fc80esm12547134ejb.193.2024.01.21.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 11:44:37 -0800 (PST)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] MSM8976 MDSS/GPU/WCNSS support
Date: Sun, 21 Jan 2024 20:40:58 +0100
Message-Id: <20240121194221.13513-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series provide support for display subsystem, gpu
and also adds wireless connectivity subsystem support.

Adam Skladowski (8):
  arm64: dts: qcom: msm8976: Add IOMMU nodes
  dt-bindings: dsi-controller-main: Document missing msm8976 compatible
  dt-bindings: msm: qcom,mdss: Include ommited fam-b compatible
  arm64: dts: qcom: msm8976: Add MDSS nodes
  dt-bindings: drm/msm/gpu: Document AON clock for A506/A510
  arm64: dts: qcom: msm8976: Add Adreno GPU
  arm64: dts: qcom: msm8976: Declare and wire SDC pins
  arm64: dts: qcom: msm8976: Add WCNSS node

 .../display/msm/dsi-controller-main.yaml      |   2 +
 .../devicetree/bindings/display/msm/gpu.yaml  |   6 +-
 .../bindings/display/msm/qcom,mdss.yaml       |   1 +
 arch/arm64/boot/dts/qcom/msm8976.dtsi         | 610 +++++++++++++++++-
 4 files changed, 613 insertions(+), 6 deletions(-)

-- 
2.43.0


