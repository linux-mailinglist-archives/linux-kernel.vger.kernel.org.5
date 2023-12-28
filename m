Return-Path: <linux-kernel+bounces-12618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6081981F7CF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931F91C23238
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C720747C;
	Thu, 28 Dec 2023 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZaXJ7p6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A726FC5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2cc7b9281d1so73408531fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703763729; x=1704368529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbh0l/OCUlD5uVSuXEGMcXjE9wl3eO27IjVISScAPlo=;
        b=LZaXJ7p6c9EuH8ElUlfPZf/8XX8OUluDcLEJ4/mQSU1Ie578J8w2yeSnjXmLNPsFbI
         LnI32SjSdYjxYTY3/QxC5HJc9JpG0OAzhBTKV0oDbzyVPlEI5NTl/eWDBdzkjNJxGSbL
         LFOg5VvzKiWTRdT6ItQevwsBEvnLhKbwhicriB8sQoW9uy/GCVjwFZNX3qK96O7ys798
         v8DzstZO+Krr4n0mt2JORu2zmh8opg6XmWhOU7dVsMbHWb2Id7OLKG1QOsuqMtfOtqF+
         8L1QJSXpAPMmyh/+5GQDF+4L+iMPlYl9wjSv04xWNzH2z1aY0VZ6aq8OvLLjKBj+nfQS
         jkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703763729; x=1704368529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbh0l/OCUlD5uVSuXEGMcXjE9wl3eO27IjVISScAPlo=;
        b=EehmrNSARQGV96ZI1VN5BZihkXHsXD/bEmhdRsGpSFfgv0i5PnQruE1nHbcfY9fxj3
         /glH/1YnBlB4YxOrvA11gqPTKm8IpuMWprz1gX4orx/pN/gDbrN0133rvP9zPpzKTauK
         qD/YGVUTPVKy46iUIH8PwmPWkiGzsRbc5P3xS58y/SzaTLohL5wf3PjsEzFCqz5l90rp
         8hip6p/a5H+rSy4eqOLHUaqZY0JLQ5jctWr+NWIjnXt64W6Co9rFXja7bK2ZHCJNGds6
         D66lTCggaoCkc2rct5a4J7LKu7rD2J/4dyeud0U0NpwAjG6YfyWUR1uMIEzrZUrYC4Co
         jvDw==
X-Gm-Message-State: AOJu0YxR7zwp3JVNzYBNYkwVQK66zC+UrZcTBcK4BW2yDGlIfXQEovr2
	zftnRAx2rcPPKZphF5dVnZVlpA17Z6+cdQ==
X-Google-Smtp-Source: AGHT+IHSnOW4rpsICrtsFJGdeaeqXLcYGA//H43gyGrL38Vu+aM+ohhsDrXuAXLflLZoBD6Jm7JHIA==
X-Received: by 2002:a2e:3c02:0:b0:2cc:69f5:de84 with SMTP id j2-20020a2e3c02000000b002cc69f5de84mr4762669lja.100.1703763729234;
        Thu, 28 Dec 2023 03:42:09 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a4-20020a05651c210400b002cc32fbe2e5sm2792867ljq.51.2023.12.28.03.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:42:08 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Kevin Hilman <khilman@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ben Horgan <Ben.Horgan@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH 0/5] PM: domains: Add helpers for multi PM domains to avoid open-coding
Date: Thu, 28 Dec 2023 12:41:52 +0100
Message-Id: <20231228114157.104822-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attaching/detaching of a device to multiple PM domains has started to become a
common operation for many drivers, typically during ->probe() and ->remove().
In most cases, this has lead to lots of boilerplate code in the drivers.

This series adds a pair of helper functions to manage the attach/detach of a
device to its multiple PM domains. Moreover, a couple of drivers have been
converted to use the new helpers as a proof of concept.

Note 1)
The changes in the drivers have only been compile tested, while the helpers
have been tested along with a couple of local dummy drivers that I have hacked
up to model both genpd providers and genpd consumers.

Note 2)
I was struggling to make up mind if we should have a separate helper to attach
all available power-domains described in DT, rather than providing "NULL" to the
dev_pm_domain_attach_list(). I decided not to, but please let me know if you
prefer the other option.

Note 3)
For OPP integration, as a follow up I am striving to make the
dev_pm_opp_attach_genpd() redundant. Instead I think we should move towards
using dev_pm_opp_set_config()->_opp_set_required_devs(), which would allow us to
use the helpers that $subject series is adding.

Kind regards
Ulf Hansson

Ulf Hansson (5):
  PM: domains: Add helper functions to attach/detach multiple PM domains
  remoteproc: imx_dsp_rproc: Convert to
    dev_pm_domain_attach|detach_list()
  remoteproc: imx_rproc: Convert to dev_pm_domain_attach|detach_list()
  remoteproc: qcom_q6v5_adsp: Convert to
    dev_pm_domain_attach|detach_list()
  media: venus: Convert to dev_pm_domain_attach|detach_list() for vcodec

 drivers/base/power/common.c                   | 133 +++++++++++++++
 drivers/media/platform/qcom/venus/core.c      |  12 +-
 drivers/media/platform/qcom/venus/core.h      |   7 +-
 .../media/platform/qcom/venus/pm_helpers.c    |  48 ++----
 drivers/remoteproc/imx_dsp_rproc.c            |  82 +--------
 drivers/remoteproc/imx_rproc.c                |  73 +-------
 drivers/remoteproc/qcom_q6v5_adsp.c           | 160 ++++++++----------
 include/linux/pm_domain.h                     |  38 +++++
 8 files changed, 288 insertions(+), 265 deletions(-)

-- 
2.34.1


