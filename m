Return-Path: <linux-kernel+bounces-7499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B4B81A8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B16D28C98D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134FD4A991;
	Wed, 20 Dec 2023 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM2hF1qN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3409208A5;
	Wed, 20 Dec 2023 22:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c60dfa5bfso2317585e9.0;
        Wed, 20 Dec 2023 14:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703110666; x=1703715466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHyyJwEJsELVXyenxWN25EQbJJCm8HvjgqB6ecbKFBo=;
        b=WM2hF1qNLEkOQ19yG9QT+Dmuxw8GWjc9u9hCEUxhSjoa9qBOM3Zg2y/60Er/klt6EA
         v7Xx/0xaKFwLUt/8C2iluOemb6pFk3y1wNNSl2sY1hfby2F/fHlxCfrtJUJFVSBcG0BH
         /gcs/0FmbjM6WH9otcGwVp+AiC/hPoWW6xf2edLhAmZ0DUBkBktpMoC2xtHjLbRRml5u
         m2ZM12BlcZ+BNjykPA1IAxVw13cs1qiKf/k0pYvIVM83SqdwzFaihlJUG2Q0YQLHdLgZ
         reLQiApXiIjk+JM0qjQ8I9V2ZNmb5hRA8HklD/PXbiW8gOT0bB1qpZtOjD/48+vQEQXN
         /32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703110666; x=1703715466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHyyJwEJsELVXyenxWN25EQbJJCm8HvjgqB6ecbKFBo=;
        b=FhjDYVxn9ZpdztrT94O6V8t4PuA5yhHgkJhd/dU7/LOZnux91dytdxd9+lgWrP7+pX
         U6OpFzX105crkNzI+c1O+Onl9uR8B6GctXwjbZamrQ+GvCfLg74VmqEYFk7S5dJxQuav
         fXJYxPlbPtKqdUC7Re2rD+kfqifnd9LBu1i7JgBBBo9r6YcfyZY7zq7iXOnDueNt3COL
         akA/vjGqRPTShYajhoutKi9zSANrJFHWXuexg9P0qqK19kFJcadQKe6ej4W7nfjXi+T0
         VEcVr4lGKi/FBVDmlcOnuyRqoQIm6yXIQgZS32JHlC0LQ3EBItgHIPJwWB5fgJf5366O
         1WGA==
X-Gm-Message-State: AOJu0YwnHvVAkD2o5OrnceUGCPxDySndQtQo4O/ccP8koSswKsCYkkIp
	1N6wxiJpPrgaaaw1ecFhlAM=
X-Google-Smtp-Source: AGHT+IFw4SnA+/mZ11I2Ol93m6wma7Zi+Othu3tzlLL/CUYJd9aiBIF5JaZbZ5k4ckVYvHoZD+eZaw==
X-Received: by 2002:a1c:6a0b:0:b0:40d:39e9:d3d0 with SMTP id f11-20020a1c6a0b000000b0040d39e9d3d0mr169980wmc.144.1703110665627;
        Wed, 20 Dec 2023 14:17:45 -0800 (PST)
Received: from localhost.localdomain (host-95-250-248-68.retail.telecomitalia.it. [95.250.248.68])
        by smtp.googlemail.com with ESMTPSA id v14-20020a05600c444e00b0040c58e410a3sm8908826wmn.14.2023.12.20.14.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 14:17:45 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v8 0/3] clk: qcom: clk-rcg2: introduce support for multiple conf for same freq
Date: Wed, 20 Dec 2023 23:17:21 +0100
Message-Id: <20231220221724.3822-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series fix a current problem with ipq8074 where the 2 uniphy
port doesn't work in some corner case with some clk configuration. The
port to correctly work require a specific frequency, using the wrong one
results in the port not transmitting data.

With the current code with a requested freq of 125MHz, the frequency is
set to 105MHz. This is caused by the fact that there are 2 different
configuration to set 125MHz and it's always selected the first one that
results in 105MHz.

In the original QSDK code, the frequency configuration selection is
different and the CEIL FLOOR logic is not present. Instead it's used a
BEST approach where the frequency table is checked and then it's checked
if there are duplicate entry.

This proposed implementation is more specific and introduce an entire new
set of ops and a specific freq table to support this special configuration.

A union is introduced in rcg2 struct to not duplicate the struct.
A new set of ops clk_rcg2_fm_ops are introduced to support this new kind
of frequency table.

Changes v8:
- Add Tested-by tag
- Fix typo in commit description
- Address requested fixup for Stephen
Changes v7:
- Improve handling of exit condition on missing parent.
Changes v6:
- Small rework of best_conf selection to mute Sparse warn.
Changes v5:
- Rework selection logic with suggestion from Konrad
- Return -EINVAL and WARN if we fail to find a correct conf
Changes v4:
- Drop suggested but wrong re-search patch
- Move everything to separate ops and struct to not affect current rcg2
  users.
Changes v3:
- Add qcom_find_freq_exact
- Drop re-search on rcg2_set_rate
- Rework multiple conf patch to follow new implementation
Changes v2:
- Out of RFC
- Fix compile warning from buildbot related to F redefinition

Christian Marangi (3):
  clk: qcom: clk-rcg: introduce support for multiple conf for same freq
  clk: qcom: clk-rcg2: add support for rcg2 freq multi ops
  clk: qcom: gcc-ipq8074: rework nss_port5/6 clock to multiple conf

 drivers/clk/qcom/clk-rcg.h     |  24 ++++-
 drivers/clk/qcom/clk-rcg2.c    | 166 +++++++++++++++++++++++++++++++++
 drivers/clk/qcom/common.c      |  18 ++++
 drivers/clk/qcom/common.h      |   2 +
 drivers/clk/qcom/gcc-ipq8074.c | 120 +++++++++++++++---------
 5 files changed, 285 insertions(+), 45 deletions(-)

-- 
2.40.1


