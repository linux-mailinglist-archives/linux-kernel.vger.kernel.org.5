Return-Path: <linux-kernel+bounces-119260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFFC88C647
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF531C3B57A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D6513C801;
	Tue, 26 Mar 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdAyhnSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79E9762F7;
	Tue, 26 Mar 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465602; cv=none; b=B+QI5kmLZHfmME6fIzS61wB/WgIFQ2chK0Pbo565H5evuIdca+Dw3E4bCRsRshP4sdoPa0pimxObZRUw4qizw0p2XimgyLM2+JA5g4LDF+QbO7TVZKxBg0zM7M7olNy3cWYGAJnRkglGUJLIbVOnSR74G1/ULhV9sgVmNx3H4ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465602; c=relaxed/simple;
	bh=WmNiMtGDvNIqOuw0hY+smIdzoUtjfSFeYRQC6xh4Hz8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d6C/Da/XMot3CXEjn9DmXMP3s/uClsg80VHfdZGsRCpjvzMpUQVd3fRPn+TL+Ja3ZIl0uH8vUWw3BZGKZZyx3vfSHeBIBPtInd+ypoGQTRNjinL9K7J7QXeSR+P4//zkX+dER1rPlDbHfjvK3aGoFMzj63OhYRZJ/fmtX0DuECM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdAyhnSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93676C433F1;
	Tue, 26 Mar 2024 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465602;
	bh=WmNiMtGDvNIqOuw0hY+smIdzoUtjfSFeYRQC6xh4Hz8=;
	h=From:Subject:Date:To:Cc:From;
	b=YdAyhnSI2E95pDDtosE2XKa4KlrVw6uB9EdAlNc5LweIuC4wkSVPFig1ZELG4Omjj
	 SZ7qNrQs9LK1I9jwWbwdqGicy+zZzeXFAZ5Ys9A2iwxfIgEMzMGEkJhhez34mBaeo1
	 2YVuRy8FMO46v3VzYvS77tpchP+lTeTl5vnEe43AaukHkfzSclYMKldyTQ9ie05+Ni
	 gdtZgDJZdurPPDbc+WdfNYKduJ9xr38xtWjYiPdxywxiYeic49/6k/gOQ1TAT17BBi
	 G1SNfIw6Mr/e3+7ibl7wCd37v2uUyKufF3YWxOe3VL5/4n/3UmWwn/OZZm/0mQ8gyn
	 bCr4daqBwTdsQ==
From: Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 0/6] drm/msm/dp: Spring cleaning
Date: Tue, 26 Mar 2024 08:11:28 -0700
Message-Id: <20240326-msm-dp-cleanup-v1-0-e775556ecec0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKDlAmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyNj3dziXN2UAt3knNTEvNIC3TSLpERjozQzo7QkSyWgpoKi1LTMCrC
 B0bG1tQCcAFK9YAAAAA==
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Bjorn Andersson <quic_bjorande@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1577;
 i=quic_bjorande@quicinc.com; h=from:subject:message-id;
 bh=WmNiMtGDvNIqOuw0hY+smIdzoUtjfSFeYRQC6xh4Hz8=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBmAuWiYj3RLwGpOhxIEW7T2SOQ84wLGP58ADzl7
 pJz4nX1ygyJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCZgLlohUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcVd9g/8C0cZzaUvCibCedahgHhwt1L8hzPUs0r/axyvoML
 z+JT4IKVfaXPJrsiUDa1/zKu8kVC7Z5nYWMGUaLRFXVNuP3Fciug8/8f7ClWtpgSxuNunDuJdjj
 XtAe63xUiCNji1Ag9XIwat2u8i/RJbVex3XviTuF8QmJzWqBOTAR+Rf1Su/tN9xDdbZENmMF0QU
 i8fcQ3Y07pirEkiDIOU5NFAthxTfvEKFXhJf82DNDCfb4CNe80hytj8HpyRxwXsQ2p2g+fhpBBO
 R8HLZhQCrnH9VrYhRYGTfHtDsyPbpi6Nl4OkzhPYYdSgbktU78GpwQpg8WHOGfws/fGpNT3I8rz
 23zDBocNGgEN/oWqlnuIRA3HD2ctoxIO2uaRcjA3cRSv9eRwKK5vfWgCZGEotaDRYjFdUozlK3V
 G3VUbFHbdDbVS1yg2UpRlU+8nBFHU6DNA3lTXuuCmal89f/E7BKc6CMR1afomVYn+Ze7OElxC7b
 Dmx3VMciv8gFK8YjWYeUjGwkUKWvgcTC1V9zA6Bh9AxP1dPP/SKLJhQk6Qvesrr1RL5GByx0xGo
 ovPVkLHPbKpFXjWyDtoZd+SAt9mByJOr6G0DQXaMMi9TUV6Fe44V+P9rx1q0QUjmTXxarO6R3+n
 O4K+UQmsV/PRSIreRQgPso3Woec8RpKkpTNKeQXvC9ks=
X-Developer-Key: i=quic_bjorande@quicinc.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5

Spring is in the air, clean out some dust that has accumulated in the
Qualcomm DP driver.

Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
---
Bjorn Andersson (6):
      drm/msm/dp: Drop unused dp_debug struct
      drm/msm/dp: Removed fixed nvid "support"
      drm/msm/dp: Remove unused defines and members
      drm/msm/dp: Use function arguments for aux writes
      drm/msm/dp: Use function arguments for timing configuration
      drm/msm/dp: Use function arguments for audio operations

 drivers/gpu/drm/msm/dp/dp_audio.c   | 25 +++------------
 drivers/gpu/drm/msm/dp/dp_aux.c     |  9 ++----
 drivers/gpu/drm/msm/dp/dp_catalog.c | 64 ++++++++++++++-----------------------
 drivers/gpu/drm/msm/dp/dp_catalog.h | 49 +++++++++-------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 17 +---------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 -
 drivers/gpu/drm/msm/dp/dp_debug.c   | 38 ++++++----------------
 drivers/gpu/drm/msm/dp/dp_debug.h   | 38 +++++++---------------
 drivers/gpu/drm/msm/dp/dp_display.c | 15 ++-------
 drivers/gpu/drm/msm/dp/dp_display.h |  3 --
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 --
 drivers/gpu/drm/msm/dp/dp_link.c    |  4 ---
 drivers/gpu/drm/msm/dp/dp_link.h    |  1 -
 drivers/gpu/drm/msm/dp/dp_panel.c   | 14 +++++---
 drivers/gpu/drm/msm/dp/dp_panel.h   |  3 --
 15 files changed, 80 insertions(+), 203 deletions(-)
---
base-commit: 084c8e315db34b59d38d06e684b1a0dd07d30287
change-id: 20240323-msm-dp-cleanup-f8ba32f62fb9

Best regards,
-- 
Bjorn Andersson <quic_bjorande@quicinc.com>


