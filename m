Return-Path: <linux-kernel+bounces-154094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F38AD754
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CBE281B13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E36B20DFC;
	Mon, 22 Apr 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jC0Se1Au"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325C1C287
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825433; cv=none; b=j3U1vlrbNAUWByQBwdkdPILe9ufdnwxR4uDOJzQ7OQU1TdsfFhWA3hRGHza3irNejm6KhktRS5hnN+A+orhLhoAdb7wrqiRgrkFSQ2Zsn+tZKPkqk/WznhYu7XnJFmhyQVz94hIYftqiMZnhuS3LTysiFQjoLnlhSsmFrWBu7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825433; c=relaxed/simple;
	bh=JsxZ38XdkNgp9UD9W21uEmvYgPFSGAp83NClI4k5JWg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EkQtXDanhXY1lKs9S2kmASyQfDoprH/YRiLzA4B2lQkdXrpKz9fOaWVmp456LkO3S5RWxGjP5wzhtsuPJTCfXAejsrwa3cAJzr8TyrupZ2pirmJaDKTq7jedHZioohVoCqMMS+/htpNxF1DgeqbedM2PtZB+dsqvALSxn4tNTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jC0Se1Au; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51aff651083so2589551e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713825430; x=1714430230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ohFmgglIcQlxE3MPNy1+YrogD02CaIJJKPILpDHEK2E=;
        b=jC0Se1AuSIXi6m1zu9rYPo9813c1QcqMMGb1u2IEdG4WNHdlD3rF0J4y1eYFJfC3+z
         rnGv8jhl3ksmyr8TC4W0Teh621nqMfJDBlxZyk5ObPmjALhwGGTNjZALZODb++D7kygW
         dFFp+WSWUGBF6EKM3nMma3jaXgaISJHi58XZY/8iD3/uT117i3PAQSETOUjtiGwDTBMX
         3POqQ39aiPHoOf4pRq4KTd4TsKLIp3UsW51lJn6nfCYHcCLLLT4BsEBiQtsuEXLMvWHr
         QEawIjWvugtYxI/kWgIyDOgZQ338yS5Uj8KZQDIFcphnbnZCOElxuC3vHsRhNjblcITd
         69zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713825430; x=1714430230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ohFmgglIcQlxE3MPNy1+YrogD02CaIJJKPILpDHEK2E=;
        b=OuuqOYv4Jw1WK0hWynjaWLVEHLS7TxrBqIlSksPgi1R3xC5NJdSX4QShP9Y16RCPec
         k45eT2MxD9ukMYtn7SFiHXSwOX0xgh8I9SM680HlBXLg+QCdPT4Urx2CfsPYZl7aWrUo
         3vit8ZwWs+Ak59Gwj5TM29F0y6B0Su8ovIv3qKryRVnsfIyqsDIkRCBQwv+safcVO8KM
         ohNfP5ZC2W/Fa6XjYS4b7ElNOOx8YDjP+CzlNzFo7Lr4Khhx20h4T+wv2vziG0US5dTx
         B/9lrB1gSVYtrcc9uWhexd/ugZniK2tFxQLVByWEiDaw1vJ2xjHqf6/qAB8XLPNVBbkW
         dHiA==
X-Forwarded-Encrypted: i=1; AJvYcCVvtNDywf4HlwDSqcNID5X5e2/YxQiS9L48VrND2HHyQMQmvoTWvqQKka3hozyYKrybEnuPELfwa3za1nG6/rN+SO94TyxXHCVEaiA2
X-Gm-Message-State: AOJu0YwnMybk7VjrGIW8gqtpfABx+fpIDOXTgT04f3v6TWtHBs3a3J0k
	Jq1jaj/5QP0+LmXjUQ3JLV39NMYId/PMlXwm17dXbaokyVwxRsL1FHMF01dCTzs=
X-Google-Smtp-Source: AGHT+IE3m5uOC+ZmUmnZKf0riA6458/IhT/zPbv8SmhhSaid1ucuuBTYN37T3Pzrf8uaJHQYmrV0OA==
X-Received: by 2002:a19:381a:0:b0:515:cfaf:737 with SMTP id f26-20020a19381a000000b00515cfaf0737mr6928150lfa.9.1713825429819;
        Mon, 22 Apr 2024 15:37:09 -0700 (PDT)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r3-20020ac25f83000000b00513c4e41140sm1841271lfe.204.2024.04.22.15.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:37:09 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Remove more useless wrappers
Date: Tue, 23 Apr 2024 00:36:58 +0200
Message-Id: <20240423-topic-msm_cleanup-v1-0-b30f39f43b90@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIvmJmYC/x3MWwqAIBBA0a3EfCfkA4q2EhFpUw3kA60Iwr0nf
 Z6Pe19IGAkT9NULEW9K5F0Brysw++w2ZLQUg2iEapSQ7PSBDLPJTubA2V2BaYmq1aZTnC9QuhB
 xped/DmPOH+Q0mQBjAAAA
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Shaving off some cruft

obj files seem to be identical pre and post cleanup which is always
a good sign

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      drm/msm/dsi: Remove dsi_phy_read/write()
      drm/msm/dsi: Remove dsi_phy_write_[un]delay()

 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h           |   5 -
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c      | 273 +++++++++-----------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c      | 218 ++++++++--------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c      | 109 ++++----
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c      | 305 +++++++++++-----------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c | 205 +++++++--------
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c       | 320 ++++++++++++------------
 7 files changed, 699 insertions(+), 736 deletions(-)
---
base-commit: 33edc5592466996fe9610efc712da0a3539027ae
change-id: 20240423-topic-msm_cleanup-b3e47bc8411d

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


