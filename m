Return-Path: <linux-kernel+bounces-129396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01769896A12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF8BF28CA2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029B06FE12;
	Wed,  3 Apr 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YePQhhbJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5E6EB5A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135472; cv=none; b=Ias5C5Og+B4eHwQOuZ8wDrXFJEY1ss1hqCpf9lqlbzFp8iuP/sGq8eIOf/UvOLrpiD853oGhVKtGFTqRPV/wn1qzPTbIwlmOHzyxp05tvOUYAX+/9cB7cakWSoRlQz7N7PjctzrTWd6SHWb/gxT4Re/0mkZk+67e4oiAxIUy3Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135472; c=relaxed/simple;
	bh=P541NbRWYuqXnx3+bGnLVMbeU44d3fPcyqmzLTRTyXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PfoUk42pi+iQvrLPHqHBZ9CXpvc3XncyBEu9OoXRCQdIG3eYkfWDO3TdwKNaa2UExEeEMusCIQNDn0vfzCgu9Jmo2czsRhSYXLuLDfR/tj5bi5wPLbbd4c8OYPCnsX2IXIcMAjQtxLKfGGVlh4FzbU//phVFXCIkIpUfTtsiFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YePQhhbJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e244c7cbf8so28984875ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712135469; x=1712740269; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/O3Yye4pJUKSqqmi1ztO7+TuENg7PJXngjJtD8dhiA=;
        b=YePQhhbJJgTfKf4awTWBBdsNXa18J+DO2yAvOcfga3kvVsstmG8w1J+rnz0Gneb5fc
         lTcVEzxx8vKY/qlmcg5oIzxxMsHt0GVm8Kx4yluULd5pnyYwkPD+TZzq0mJGI/NEHYdE
         oL4qyem9qOBUt8kaNklhowzGrPxoz5bpx+GQDYPCMtf5v2izkfln7/O9zgEvgIXEWljf
         ljxSqe1o8pSpfgUkUypw1mnRuY+1sxZShNWqSA5UbQy+BjP8tHn2zJ+WfqJ5m7lbq059
         qYxfNTKtT6QK5XGT0Ef7ROp/VwEveDP3b03+OWMlh2S+XG6qQz0GoyhmnCUVfCzmNUi+
         VVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712135469; x=1712740269;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/O3Yye4pJUKSqqmi1ztO7+TuENg7PJXngjJtD8dhiA=;
        b=BbHBTRqb42BOIqO4DLpVGWsoLUvzFf2yeo+ZnGnOR2V7NWQRycJAF/MfILTGUvVeU1
         Gy1mjKJRLRifO0F4jWM5nbsK0hz9fDako/gkFpS8esPPGXEf/QmFvYHierF+4HoDmLNE
         43wOTrZAJLV++4JlMR/7vAh2SB9J6OJfkwHt7pW54YAznkXnybGQDTq1Qg/ZKbl49Gs5
         CWASRHJzcIFf6zqCA1WhKUbcWQxRQnYk8rk+n6GfSrl9EN29BHBeaDKnT65ptVtjIY0o
         ZHUA6r7QAy6yIjc246mZOqoM16HUfN85s2EdLcGqm/Q8337JkCpWae/XzYfgZn6q3tC4
         vcDA==
X-Forwarded-Encrypted: i=1; AJvYcCWk/zK0RI/NCS2J/vShb6udu47pYOf31jcDIRr9lZfuvlaQQiuHAdTRI2orqGu9V+pyazj/0lYxbVMvPc/V/yBy3yHUmQYvtm3lwSeF
X-Gm-Message-State: AOJu0YwvayiTSTn5tBSjnszSJs3DFk48/JRFXKPXh7U9T++jBiPuka4a
	vHGs1/AtrGNwnldV2XccvLeP3/KpakpjC1wbbLmAhJqDq1u0lMB7YXcHjMtYG/35OqOyciWevPj
	UHdBiSw==
X-Google-Smtp-Source: AGHT+IF84q9hRu116oN3GLEOqf7CuYctkPWrAgQCygUpWta5lfkEIwl7OUv7gwt+uy43J5BmH7S/wA==
X-Received: by 2002:a17:903:32ce:b0:1e0:b629:b009 with SMTP id i14-20020a17090332ce00b001e0b629b009mr2303646plr.20.1712135469129;
        Wed, 03 Apr 2024 02:11:09 -0700 (PDT)
Received: from [127.0.1.1] ([112.65.12.66])
        by smtp.gmail.com with ESMTPSA id lo14-20020a170903434e00b001e0aded0ca7sm12688087plb.239.2024.04.03.02.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 02:11:08 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 0/6] Add DSC support to DSI video panel
Date: Wed, 03 Apr 2024 17:10:56 +0800
Message-Id: <20240403-msm-drm-dsc-dsi-video-upstream-v1-0-db5036443545@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAdDWYC/x2NMQ6DMAwAv4I811JMoEO/UnWIsKEeAshuIyTE3
 2t1uOGWuxNcTMXh0Z1g0tR1W0Po1sH0LusiqBwOfeqHNKSM1SuyBT4Fik1ZNvzu/jEpFYnGOxO
 lMmaGiOwmsx7/wRNahtd1/QAmFaGKdAAAAA==
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>, Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712135460; l=1325;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=P541NbRWYuqXnx3+bGnLVMbeU44d3fPcyqmzLTRTyXg=;
 b=HkqQZDXjFiMWF6ZF+Cd0bcaoeJOmDhaXwhg2bFQTfchp7QA89xl1gKuBfqywkMi9u/CrU+Rqg
 N1WZRF987sSDHY46unFNIz4C8AM5wiaqxvqBzLMDMKlkS8wAs1I5cIE
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=

This is follow up update to Jonathan's patch set.

Changes vs V2:
- Rebase to latest mainline.
- Drop the INTF_CFG2_DATA_HCTL_EN change as it is handled in
    latest mainline code.
- Drop the bonded DSI patch as I do not have device to test it.
- Address comments from version 2.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
Jonathan Marek (5):
      drm/msm/dpu: fix video mode DSC for DSI
      drm/msm/dsi: set video mode widebus enable bit when widebus is enabled
      drm/msm/dsi: set VIDEO_COMPRESSION_MODE_CTRL_WC (fix video mode DSC)
      drm/msm/dsi: add a comment to explain pkt_per_line encoding
      drm/msm/dsi: support DSC configurations with slice_per_pkt > 1

Jun Nie (1):
      drm/display: Add slice_per_pkt for dsc

 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |  9 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |  8 +++++
 drivers/gpu/drm/msm/dsi/dsi.xml.h                  |  1 +
 drivers/gpu/drm/msm/dsi/dsi_host.c                 | 42 +++++++++++-----------
 include/drm/display/drm_dsc.h                      |  4 +++
 5 files changed, 44 insertions(+), 20 deletions(-)
---
base-commit: b1e6ec0a0fd0252af046e542f91234cd6c30b2cb
change-id: 20240403-msm-drm-dsc-dsi-video-upstream-1156d110a53d

Best regards,
-- 
Jun Nie <jun.nie@linaro.org>


