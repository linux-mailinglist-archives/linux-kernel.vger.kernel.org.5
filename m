Return-Path: <linux-kernel+bounces-19522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED9826E43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FF141C22588
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FB840C13;
	Mon,  8 Jan 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="StG9Uh0o"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752450269
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a27e323fdd3so162563866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704717150; x=1705321950; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+LLSoSst0X3WX+FOtX7u0Smzdw3we/Qr2TbV3vNvmY=;
        b=StG9Uh0oy3nKMkLdVnq/TAffu2g4s2sxsdCszU6jiWi2+Ou/L9vDjONT2FPVZsfFar
         G+H2in+5cimNXKwrXHSNkWcr5BpF/Ck+viWlYaZwmvAkE5p3NUq41SusnGwJpVNNyjqQ
         eDkI6w7Mkc5qmdzMAUN3kK+aPLamO64dK9aJmhl7PzFA5ZL8arg5YjGUoh3iyCAyFCbd
         ir7m+8BKT3ZyjeZJe7vCXt3BDIdg6B4bLUTmnUqrx1ekKKCdRghYF7hgSpOI0iranbWk
         hekVEWTHS/Uhx5O0GD3LL+CU0xTsex8zSZbAO4rIb1AgX51tUs4Ubm5bWATamFtWSwvC
         pjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704717150; x=1705321950;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+LLSoSst0X3WX+FOtX7u0Smzdw3we/Qr2TbV3vNvmY=;
        b=iAr/taFGNYArZJGNy442o7qUUUsnHNq9a+1nBf6SbqzoqTAcW8Srg84G17pc1YBucP
         /3QqLtn7+SiQBAq2mlm7F062aoC1X6tsGlqWoHVHO35aMOM2EveUsER7i0Y2/GTvQv3t
         mYGwIOaSqGn+LfbEtN9MFKgnJSxKs6Reon4TeLeYV094DbCQNRUdDfH0rNGQMdsYENK/
         qJzZp9Qc/SV+JrWQuDYkwxaz3zdR34FQj4bAeBCcF0i+5A7/kBMvrFjjG25bhaumwk09
         hO+d8Hy/0i/pUgv0n4TQYJfXZFY1dmsSOnDoniQa22YYc/RmfKaaMiKK6gZPThhCL9+r
         7o8g==
X-Gm-Message-State: AOJu0YxFYfzm8sIYXWZGDQzk1naTzaQTpPOMk0BvqjHfct151rsHaQcf
	eXkUUI91Owua+EndM7cLJYlUa7zhNFz3yHKBQer6qj0pFkQ=
X-Google-Smtp-Source: AGHT+IG923JXhZHNH6bInFxUOJQ8Xb9OhAPPlhZkvZZZPYX5K6RO2so+Jy49/QpyTx/z5+gnHyjQ/A==
X-Received: by 2002:a17:906:1995:b0:a28:aab9:656 with SMTP id g21-20020a170906199500b00a28aab90656mr1427848ejd.94.1704717150591;
        Mon, 08 Jan 2024 04:32:30 -0800 (PST)
Received: from [10.167.154.1] (178235179081.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.81])
        by smtp.gmail.com with ESMTPSA id bs18-20020a170906d1d200b00a2808ee8ab1sm3892978ejb.150.2024.01.08.04.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 04:32:30 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/18] Qualcomm GCC/VIDEOCC reset overhaul for Venus
Date: Mon, 08 Jan 2024 13:32:17 +0100
Message-Id: <20240105-topic-venus_reset-v1-0-981c7a624855@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFHrm2UC/x2NQQqDQAwAvyI5N7Ar2opfKUV2t7EGJEqiUhD/3
 tDjDAxzgpEyGfTVCUoHGy/iEG8VlCnJh5DfzlCHugkxtLgtKxc8SHYblIw2zG1zj3mMKXQP8C4
 nI8yapExeyj7PLlelkb//0fN1XT+j7Lp4eAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704717148; l=2600;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Fc9zrFgHl1OElxmHS3Z3Skji4kyXQuba0Flg4ZyAyLg=;
 b=JTY7Ia3zshIw9jL1LI/wLPRx9NMj5mL/ajINeiy+G14cRsW5nATZZO/LC82pu/dbPWWnBGqAo
 Vg6WRvaiB9ECao1ALNAlwGXX/L3dNvCLqfnkBtzTFtEXXbJlX32hSlL
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some resets associated with venus require a larger delay for the hardware
on the other end to function properly. These seem to fall into three
categories:

- 150us for 8250 and earlier
- 400us for 8350 and friends
- 1000us for >=8450

Make some housecleaning changes and describe these delays in preparation
to moving this data out of the venus driver.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (18):
      clk: qcom: reset: Increase max reset delay
      clk: qcom: reset: Commonize the de/assert functions
      clk: qcom: reset: Ensure write completion on reset de/assertion
      clk: qcom: gcc-sa8775p: Set delay for Venus CLK resets
      clk: qcom: gcc-sc8180x: Set delay for Venus CLK resets
      clk: qcom: gcc-sc8280xp: Set delay for Venus CLK resets
      clk: qcom: gcc-sm4450: Set delay for Venus CLK resets
      clk: qcom: gcc-sm7150: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8250: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8350: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8450: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8550: Set delay for Venus CLK resets
      clk: qcom: gcc-sm8650: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8150: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8250: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8350: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8450: Set delay for Venus CLK resets
      clk: qcom: videocc-sm8550: Set delay for Venus CLK resets

 drivers/clk/qcom/gcc-sa8775p.c    |  4 ++--
 drivers/clk/qcom/gcc-sc8180x.c    |  6 +++---
 drivers/clk/qcom/gcc-sc8280xp.c   |  4 ++--
 drivers/clk/qcom/gcc-sm4450.c     |  4 ++--
 drivers/clk/qcom/gcc-sm7150.c     |  2 +-
 drivers/clk/qcom/gcc-sm8250.c     |  4 ++--
 drivers/clk/qcom/gcc-sm8350.c     |  4 ++--
 drivers/clk/qcom/gcc-sm8450.c     |  4 ++--
 drivers/clk/qcom/gcc-sm8550.c     |  4 ++--
 drivers/clk/qcom/gcc-sm8650.c     |  4 ++--
 drivers/clk/qcom/reset.c          | 27 ++++++++++++++-------------
 drivers/clk/qcom/reset.h          |  2 +-
 drivers/clk/qcom/videocc-sm8150.c |  2 +-
 drivers/clk/qcom/videocc-sm8250.c |  4 ++--
 drivers/clk/qcom/videocc-sm8350.c |  4 ++--
 drivers/clk/qcom/videocc-sm8450.c |  4 ++--
 drivers/clk/qcom/videocc-sm8550.c |  4 ++--
 17 files changed, 44 insertions(+), 43 deletions(-)
---
base-commit: bffdfd2e7e63175ae261131a620f809d946cf9a7
change-id: 20240105-topic-venus_reset-b5461bf1a087

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


