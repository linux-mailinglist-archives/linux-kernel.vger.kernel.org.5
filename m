Return-Path: <linux-kernel+bounces-109739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBC7885517
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0AF1C21149
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5CA5820D;
	Thu, 21 Mar 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEDZBoRy"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09EA41E4E;
	Thu, 21 Mar 2024 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007411; cv=none; b=a92rIZFM7E7++IEeJJ6CIlc/151nt1UxgdxyLGbJMvK/RXA2UOEz6wiI12TRqjdwIDCZi3BMgiCgkzeWw9fRB5TqfAKw2qNLrnyiOAp4VrfNRaQE+wS8S4maOeOCw+f6tk+Z2efSYyNBExM70GIIKB/Bjl2xJWYyOGEtFq561tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007411; c=relaxed/simple;
	bh=FNRcqeDJ23ezcSIiELqF9WTGRyuefiXNZGwjyBGo8MY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L2CGSzlmGGaj18XSdoAAEDXum9C9SAGdJMOnHmqiJpOBiMgh5hHXi053mrUJzXMRnhmIBrW9nXHJj4ZI+NN/Ru6wioMvnEOmS8LUJTQuaF/1fGKPxXKv3Ctw2P4de8CZD/zOg+QD/HW9HY37+zZ6Xzx2Uk6+PeY6bco4Pwyid6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEDZBoRy; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so9082791fa.2;
        Thu, 21 Mar 2024 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711007408; x=1711612208; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGccOu1VKuavIsm40qKIEGM+Cd72GKkJnR7gjFgC8Ik=;
        b=NEDZBoRy18rx6bRSGZgrVVxToMZqMfhuNtzr+kINetHN9KW6EGkkXHqjpEchsvh4Xd
         JweEIG2ViguGiuHLHCzsnuC/KwhmwIhhYUBSg5Vbx0V40Nh5pbzIMqmA2X7Smiq9+/kK
         7J19d3psDhNTh+sbxvfxQ+9QTMlIguWr8SJ1R3CMMXIzdQE6QTzaZboL9l8KwHx20Aox
         g0ODFbhxQEd6eYqMxa2Q6KU4Mmjrdx+8lVsS5wAams85HtFtKOxZ0mSj4YyVQRQdk95M
         rQnn3mfpdU1QjccD6cSJsZh8nPmXRYLlqe+SSAYwyEK/jLRjoKMC/rpfYb2bZq1M69j+
         ThPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711007408; x=1711612208;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGccOu1VKuavIsm40qKIEGM+Cd72GKkJnR7gjFgC8Ik=;
        b=N/uJShz2dJxoGIXbcbi+YX+MbaUkli3GBngh+HtFKjHV+Sm5SjmP7wdYs5zUaP8nfQ
         twTM7+okhAnvLg8RRnXdkLbpJa2pKRTy+XrJG8zk7mtvZnqEVM/5Vtwg7x0HKMFD+qQh
         UcvYeCYfOxvmRFQa/4FHs84aq67VLGfPgKdCR06dlgT08fD6Ylbs/18wfM4e/JSkdtIU
         bkONlJBDqV9GNsg0tqPX+im9uMb1rSDoa0keubP1p46NdI24s6LS+of+HxYQtX2V2yqJ
         DG2q15dlnqk1LtvDT/5mzL5pRGLA2aLhMaTRgQm4cN9/F8m45rihjg2pwcveqdCoiUzI
         hF7A==
X-Forwarded-Encrypted: i=1; AJvYcCUB3+DEJEoCsQWcS/EcEvuTd40moMxUmv6yewYap+23nZGDA0HtuvY3QqhATlZoKdOIaHVCVQGy2ZrNZLS9OTmcDOnYERC8HDtCGyNdOIbcLGzSeKdvuhX1g6eu5A0mnLviAIootspg
X-Gm-Message-State: AOJu0YyWMybtsd7zpGYuE0sgb/Hf/1Mf9q4HDjJYAuhUKlINH4YHnJHo
	Gd4CN3X01Yyxkg7uZHrxPuOn25yHF0cRkOZfigDttVZiK0dufahfBul6QlL8
X-Google-Smtp-Source: AGHT+IEt9imL380eotJY058uuV666FxWnZeZZusAy2pnyp+RzhoWy/fZoP9F/ziYDELJF14X6PG7wg==
X-Received: by 2002:a2e:7004:0:b0:2d4:93d3:11ab with SMTP id l4-20020a2e7004000000b002d493d311abmr10057315ljc.6.1711007407579;
        Thu, 21 Mar 2024 00:50:07 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id p1-20020a05600c1d8100b004146bda6c32sm4637096wms.9.2024.03.21.00.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 00:50:07 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v2 0/6] clk: qcom: apss-ipq-pll: various cleanups
Date: Thu, 21 Mar 2024 08:49:53 +0100
Message-Id: <20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKHm+2UC/22NQQ6CMBBFr0Jm7Zi20khdeQ/DoqFTmKRAbZVoC
 He3krhz+V7y318hU2LKcKlWSLRw5nkqoA4VdIOdekJ2hUEJVYuT1GhjzsjxjjEE7ALZ6RnRSjL
 GeuMaXUOZxkSeX3v21hYeOD/m9N5fFvm1v2DzP7hIFKiVPxtdK+O0u/aj5XDs5hHabds+kfQWN
 7gAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

This series contains a few patches to perform some cleanup in the
apss-ipq-pll driver.

The set is based on v6.8 and it depends on the following patches:
  - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
     Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
  - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
     Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - add a new patch at the end to remove the 'cbf_pll_regs' register map
    from clk-cbf-8996.c
  - change patch 2 to move huayra register map to clk-alpha-pll.c
  - collect Reviewed-by tags
  - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com

---
Gabor Juhos (6):
      clk: qcom: apss-ipq-pll: reuse Stromer reg offsets from 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: move Huayra register map to 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: remove 'pll_type' field from struct 'apss_pll_data'
      clk: qcom: apss-ipq-pll: constify match data structures
      clk: qcom: apss-ipq-pll: constify clk_init_data structures
      clk: qcom: clk-cbf-8996: use HUAYRA_APPS register map for cbf_pll

 drivers/clk/qcom/apss-ipq-pll.c  | 68 ++++++++++------------------------------
 drivers/clk/qcom/clk-alpha-pll.c | 10 ++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 drivers/clk/qcom/clk-cbf-8996.c  | 13 +-------
 4 files changed, 28 insertions(+), 64 deletions(-)
---
base-commit: 9b65bf93985e8bd5bc5476beef59ba56f3f99697
change-id: 20240315-apss-ipq-pll-cleanup-a1e99af9d854

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


