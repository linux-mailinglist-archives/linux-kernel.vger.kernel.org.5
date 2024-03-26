Return-Path: <linux-kernel+bounces-119017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792D588C2B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3449D2C7D69
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4270CC2;
	Tue, 26 Mar 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXQyvHt+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8664A9F;
	Tue, 26 Mar 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711457869; cv=none; b=AdH8w7nCvs4atvi3i/NeHDMhXQRGfx48Pl/Yp3JOh4doMcrUDU58bjgdHWUh9cUiLHakbKF71otxC03pr+suQlM4gg9lj+h7Fz7zh2IamkDTPYDCG6K5p8OkWGBc5XHKuWB9rDGtUVoRuzp9wBQaC2ugDwlLETAFfhroEC9IC8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711457869; c=relaxed/simple;
	bh=sqD6EqXFvd/enjPcnY7ANK43uQDDtwncQvACChQ1Uj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CIfarMdGksuKBdA0HgZGTPRmmVw3BGWtzMcdREgzJTz5+0ZWmn9CuqxJXmn/En/o+4v2uIvYcbmHO9Yqvgo5Ar3Xts1EsepYbRkQf0+BTA9pi9Tc9oaPiT1isb75PGtLbsweK6n3jjYwSDwK3Bbo+EKnh79bkDL7MS5rKIRoNJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXQyvHt+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c2b4850d2so701946a12.2;
        Tue, 26 Mar 2024 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711457866; x=1712062666; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+z5xlEnY753ogoUGgfV6dsl7xTQJ2IF4qKaWrruJE8=;
        b=VXQyvHt+hu8m+Gcojobs3/ZLSadOkdbZn75aODA6k4xygwBsLPPctCSNIH/ijMbLsn
         77K6FBUWKelYL/26QJavkdCkV312WoCsJni2bTS3E9t97vsFxTZoWsB7ZaWzSzb2kuUJ
         vxhccSWZLSBFNrbCDM5HaL/DBp0tnFpG0OAJEQScp3R2Y4Fi/wA44ef36YYB7NBJj2Kx
         R/eW6xz99PTXsPJPnBjRnfN4r3vu1B/tdwzlP5+oXxLovzhq2WLqyD+yrQ7SqE9UEejI
         WXqzkJSaYQRHpeAIdZFnxPZAD20OF2fpmmiVBLgsMgk7aEH7BE4uaajDAGrx2GhQaIoy
         S3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711457866; x=1712062666;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+z5xlEnY753ogoUGgfV6dsl7xTQJ2IF4qKaWrruJE8=;
        b=lxilMu+SNKo7tbcKVDHmHHqTu0K0I015fDiOxyFgXNBorALxfYtteUu7sJYeG6deYj
         r+ewaKXa0Ed89ZKb5Rtz+hEFlfzZJv2sSutHR3c+4Ron6aFdxzxKTqBmHo4nRPCPtNkW
         1ykTUt85kz2g867igds93INExKVz49cpBvCW0tkcPjzB8a/jJrZ31DvKBtlJY51auEHQ
         Ayba2aoaZ+cWDNqyTyNqWh+eqwFij+O1SILQgIVUKn6AuG6laIuWEV9tDkoTG0t3X4rz
         8PLiplBtOXRCM/K3G1Ukff/StsIUP9XZ/TY4FgR3ivni4GWfjmp/YFV+DtRbQ4dmk7Yw
         ls6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCmRn1kN8aUsruLDWRvXorVGaXjAyNQkwNIvwEJzQmh/q4VUjE6eUyGNG5aY22M+EfYgCfR+RAsgntkWMMSxHBADduHiB0Rutv/6+X1YI2mlOlvTZYkxc5og4t8K6bG/6F0YHT7HxP
X-Gm-Message-State: AOJu0YzbolcuvTt8nradxnJ1hKCqk1k+6/9+Pglx1itsE3qPKkFqgYgC
	BDA1FfxNO+vVdqUdmpxJwekJ1mLMy1GnWUjLF96bjmSysysDCcUpEXY6Xt2K
X-Google-Smtp-Source: AGHT+IGga7RkoTlf92nxVW8fYxB97cuLl9KTN8U8WFz72JkGq8V2/AxJMP3h4upSKcT2dlH4i0+0tQ==
X-Received: by 2002:a50:950e:0:b0:56c:4e2:5a4e with SMTP id u14-20020a50950e000000b0056c04e25a4emr2075634eda.1.1711457865977;
        Tue, 26 Mar 2024 05:57:45 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id n1-20020aa7c781000000b0056bb65f4a1esm4101413eds.94.2024.03.26.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:57:45 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Subject: [PATCH v3 0/5] clk: qcom: apss-ipq-pll: various cleanups
Date: Tue, 26 Mar 2024 13:57:37 +0100
Message-Id: <20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHGAmYC/3XNTQrCMBCG4auUrB1ppgk2rryHuAj5aQNpGxMNS
 undTQtCF7p8P5hnZpJMdCaRczWTaLJLbhpLNIeKqF6OnQGnSxOskdUN5SBDSuDCHYL3oLyR4zO
 ApEYIaYVuOSPlNERj3Wtjr7fSvUuPKb63L5mu6xdsf4OZQg0c7UlwhkJzfekG6fxRTQNZwYw7B
 OkfBAuCNbWNKpDVbI8sy/IBNZorH/0AAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

This series contains a few patches to perform some cleanup in the
apss-ipq-pll driver.

The set is based on v6.9-rc1 and it depends on the following patches:
  - "clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018 to fix boot failure"
     Link: https://lore.kernel.org/r/20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com
  - "clk: qcom: clk-alpha-pll: Stromer register cleanup"
     Link: https://lore.kernel.org/r/20240311-alpha-pll-stromer-cleanup-v1-0-f7c0c5607cca@gmail.com

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v3:
  - rebase on top of v6.9-rc1
  - change patch 3 to use private values for pll_type instead of removing the 
    field of struct apss_pll_data
  - collect Reviewed-by tags
  - Link to v2: https://lore.kernel.org/r/20240321-apss-ipq-pll-cleanup-v2-0-201f3cf79fd4@gmail.com

Changes in v2:
  - add a new patch at the end to remove the 'cbf_pll_regs' register map
    from clk-cbf-8996.c
  - change patch 2 to move huayra register map to clk-alpha-pll.c
  - collect Reviewed-by tags
  - Link to v1: https://lore.kernel.org/r/20240318-apss-ipq-pll-cleanup-v1-0-52f795429d5d@gmail.com

---
Gabor Juhos (5):
      clk: qcom: apss-ipq-pll: reuse Stromer reg offsets from 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: move Huayra register map to 'clk_alpha_pll_regs'
      clk: qcom: apss-ipq-pll: constify match data structures
      clk: qcom: apss-ipq-pll: constify clk_init_data structures
      clk: qcom: clk-cbf-8996: use HUAYRA_APPS register map for cbf_pll

 drivers/clk/qcom/apss-ipq-pll.c  | 56 ++++++++++------------------------------
 drivers/clk/qcom/clk-alpha-pll.c | 10 +++++++
 drivers/clk/qcom/clk-alpha-pll.h |  1 +
 drivers/clk/qcom/clk-cbf-8996.c  | 13 +---------
 4 files changed, 25 insertions(+), 55 deletions(-)
---
base-commit: 9755120255d6e7b6480509e753e9aecd6171e04a
change-id: 20240315-apss-ipq-pll-cleanup-a1e99af9d854

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


