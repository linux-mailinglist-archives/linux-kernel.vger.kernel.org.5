Return-Path: <linux-kernel+bounces-24022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E6682B586
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5032928591C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8504156768;
	Thu, 11 Jan 2024 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J/IQDl44"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E4515AFB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33761e291c1so3386248f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705003023; x=1705607823; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+i0UK44yHq8YceaKYIY5mCgJVLZEaoVhm3Uocx3mJfQ=;
        b=J/IQDl448F7PGdWVBsfIz8ng50+zyAMLCgJRzLbqXeaCOZABEarrDxmXFYIpWDdBoT
         Xryo4kDCLWtPfoviGIeNjLAWmN84OvODZi4oQtevSdn37fj77ehjX0b0aTLEhlxH3j3x
         YtzEvh9TLpmGyzH3Gk3jw0Fhs6Tf1HPXmulRqVLbZX4F1jIshjGbiK1AvlSUaEFSCdRx
         G03tp81Kqsd3+RlXWQ4FgS9UNl8rc+obNf4NQguDseVQBD7IhzSFDDuxes2/2LxUKv3m
         WA8Y5gOA2JZprQw20H0cbZEYGqhAEXBGzIydYeRim0tb1P9OuesU8RlEtjqWB3Icho1i
         SPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705003023; x=1705607823;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+i0UK44yHq8YceaKYIY5mCgJVLZEaoVhm3Uocx3mJfQ=;
        b=ZWfPSSixRteC4oaWg6tqxJ7+7UVkYlH+u9W7RARqOBf9Zh336hrORBYp8hO/Ah3K/2
         hVhrlc1JX3BlKxYzwJFgZG5rffJX6AMOuNsacfKfFS4QFztJwKsrVA4wnQ98/VEqJs1e
         +nt5eYEvVNt52f9ITTSqDrUL7jsKTOC4j5nfwpt/w7Po0GU/LaMYu2p5bWb26DdX5jTr
         g2OjA9ZtxBCS/tUmRfOfj4SHAVltxoPFDBDh97RiUsaBNLnykl//+56YcsI9dH7z7neC
         sLN9l3Z6MTewoajU1IopNjRORpbHEkjTPXY2jMQQ3z7qjNBRt4G/mLPXeN5SxlQbJtjR
         2Mnw==
X-Gm-Message-State: AOJu0Yw+Ei6ISnygi44KY7kppgpzcsC3jxJFjaokAFCo9qDNvl7NFYS1
	6FmQehevMu+iMHn+LShTg69J9uJJC+deQQ==
X-Google-Smtp-Source: AGHT+IFSIopE3QuOoLdzTjt0bkELntb0Mh5UkExonm953hmNSzSLxpZxpYk3qTp+vJmkETZ57p+eQw==
X-Received: by 2002:a05:600c:448a:b0:40e:478c:e864 with SMTP id e10-20020a05600c448a00b0040e478ce864mr206154wmo.74.1705003023479;
        Thu, 11 Jan 2024 11:57:03 -0800 (PST)
Received: from [127.0.1.1] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id b7-20020adfe647000000b0033763a9ea2dsm1955382wrn.63.2024.01.11.11.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 11:57:03 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/5] media: qcom: camss: Add sc8280xp support
Date: Thu, 11 Jan 2024 19:57:01 +0000
Message-Id: <20240111-linux-next-24-01-09-sc8280xp-camss-changes-v1-0-b92a650121ba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA1IoGUC/yWN0QrCMAwAf2Xk2UBShnT+ivgw01QDWkfjpDD27
 xZ9vIe728C1mjqchg2qfsztVTrwYQC5z+WmaKkzBAojMTM+rKwNi7Y3hhGJkSZ0iSFSW1Dmpzv
 +RccoOVzzlCWlI/TgUjVb+83Ol33/AkKs3gh8AAAA
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-4e032

A minimal set of patches to switch on sc8280xp support in CAMSS
upstream. Most of the SoC dependencies are either merged - CAMCC or very
close to being merged - CAMSS/CCI dtsi.

Alot of prior work means we have far less interventions to make in this
driver to support this new SoC.

Most of this series is already reviewed however it is gated on merge of
the CAMSS compat string here =>

Link: https://lore.kernel.org/linux-arm-msm/20240111-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v4-2-cdd5c57ff1dc@linaro.org/
Link: https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-24-01-09-sc8280xp-camss-changes

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
Bryan O'Donoghue (5):
      media: qcom: camss: csiphy-3ph: Add Gen2 v1.1 two-phase MIPI CSI-2 DPHY init
      media: qcom: camss: Add CAMSS_SC8280XP enum
      media: qcom: camss: Add sc8280xp resources
      media: qcom: camss: Add sc8280xp support
      media: qcom: camss: vfe-17x: Rename camss-vfe-170 to camss-vfe-17x

 drivers/media/platform/qcom/camss/Makefile         |   2 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 108 +++++++-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   1 +
 .../camss/{camss-vfe-170.c => camss-vfe-17x.c}     |   0
 drivers/media/platform/qcom/camss/camss-vfe.c      |  25 +-
 drivers/media/platform/qcom/camss/camss-video.c    |   1 +
 drivers/media/platform/qcom/camss/camss.c          | 307 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 8 files changed, 436 insertions(+), 9 deletions(-)
---
base-commit: cae3c85e8e3896c2a7db983290ca25933713cd0e
change-id: 20240111-linux-next-24-01-09-sc8280xp-camss-changes-8cf2bf9fcdd6

Best regards,
-- 
Bryan O'Donoghue <bryan.odonoghue@linaro.org>


