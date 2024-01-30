Return-Path: <linux-kernel+bounces-44614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0CB842510
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704BC2837A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0266A006;
	Tue, 30 Jan 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bE5+gRNF"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A146A015
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618401; cv=none; b=oy6T23HcJibBjJAIPez1zL7P370dybuFoNy1IQkVfCjvxMzFlBhQRfHVA5lKljWpBc41URHtlO49T8dZuwE8e+ZJjRfjYCuQX1vw79FtOoDtC4Q2ZnDD/f8VW9Ap9RtVLpjvULF5W/SQjlMIaCt7Pm/N9Ztw4u+hc9kAyHhWeg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618401; c=relaxed/simple;
	bh=tcgKXfSjA/csE3BN4HLKBfrOdjWjbCr0UlYlnqxSNI8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X6gEkDYANXgyI9QQdV9vue8FB09BFulOS0d5yMFIb9QQW3oM769b30nhD7kSsaBTysur3qEQrmAkC8cSBqdMZn0JrfzwJYULR3Ena9cWlCF2E46m/WlYbdUg7TeqeEBT5tcs29fhJ0yVazwkoZ+I9jyDCEbDjqi/qnLNjlPCVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bE5+gRNF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51032e62171so3995771e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706618397; x=1707223197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnybARJLss7mVBOuHG/afiK3236KFs31giNm3z5ujsE=;
        b=bE5+gRNF9RximUVTENjWSQjiVlpwQIInr2RJsuTP33xGkuOtdeCJi0V0RH78pT99ka
         aYEOaB1lvx3jr8UV79skUemjEBq4n/dx+7kYtZNrBeqByrztXII8gE8JN0rR3vVr68Cg
         JrUPGqOP8piczhamZtRhfUNX0ksHA5M90t4Ywf+lOVxqqXBwOfdkpm0FxHUEinKLAfZ0
         k348VOiwjXYDZ3LqBRjyOFHlYRzTWUGy7V9k9QtozRjU672drjEV3lLMVCHtmE7ylSBe
         pZr/y216KY43wf7A3kTMCJ2ZCcobb8I8wDhfNxscRSKy4a82Pny9sOBgnapWLUmNYhLq
         N2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618397; x=1707223197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnybARJLss7mVBOuHG/afiK3236KFs31giNm3z5ujsE=;
        b=F7NQ9tMc6hz29rFal2awy6uPOBdAaJLlm+OgX3WlB0Gh6s/ZCzZzW2qloOiLi5CCDB
         K1B8SnjqmTnkw80Oy/fMMZeOkaOw5zTEVB2FHO7IBWLP4Y1p+tw3xPCRuZvpSiTYSU2l
         X7s8TyOljVgU4WkXlX+y3HQ6xI3lxULH7K5k+6x/U+ItTWrsQgPr70GZhfXLuhbwWBqi
         yEMMVs8XJh47pXkdu211x+Kai+naeC5G1jlMHxnxn+R/l47c95nSAnnFFXqmwkRsvuyz
         IK2mjhWUrmOnsmcbvh1JacTt2Jbg0BbsbsrlBoIPhHASknE5IyJPtHTn8BDp/nJkEWSA
         0WEQ==
X-Gm-Message-State: AOJu0YzNtViamsYChTZ8uT/RHHNDCTUmsyOx5GmvMgiY1Q1qGQMh5G7m
	Wrxtj/ug6hYlXAr0KK0RivUKRLTW++rpjcCmBeInKfC4vaKYDNnxzukvsIoiQfQ=
X-Google-Smtp-Source: AGHT+IHV1RHCjL8jBPmq9LSQozfGMcx14bWKfOLZPA4RNlOvtcJpbX8ehq/xhTZM/oA6sXTUCUSPlg==
X-Received: by 2002:a05:6512:3046:b0:50e:e668:767b with SMTP id b6-20020a056512304600b0050ee668767bmr5991210lfb.5.1706618397488;
        Tue, 30 Jan 2024 04:39:57 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id p10-20020a19f00a000000b005111b28f7c2sm200661lfc.36.2024.01.30.04.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:39:57 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
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
Subject: [PATCH v3 0/5] PM: domains: Add helpers for multi PM domains to avoid open-coding
Date: Tue, 30 Jan 2024 13:39:46 +0100
Message-Id: <20240130123951.236243-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rafael, my plan is queue up this series via my pmdomain tree. Please let me know
if you see any issues with that, especially around patch1. 

Updates in v3:
	- Added tested-by, reviewed-by and suggested-by tags. No other changes
	have been made.

Updates in v2:
	- Ccing Daniel Baluta and Iuliana Prodan the NXP remoteproc patches to
	requests help with testing.
	- Fixed NULL pointer bug in patch1, pointed out by Nikunj.
	- Added some tested/reviewed-by tags.

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

 drivers/base/power/common.c                   | 134 +++++++++++++++
 drivers/media/platform/qcom/venus/core.c      |  12 +-
 drivers/media/platform/qcom/venus/core.h      |   7 +-
 .../media/platform/qcom/venus/pm_helpers.c    |  48 ++----
 drivers/remoteproc/imx_dsp_rproc.c            |  82 +--------
 drivers/remoteproc/imx_rproc.c                |  73 +-------
 drivers/remoteproc/qcom_q6v5_adsp.c           | 160 ++++++++----------
 include/linux/pm_domain.h                     |  38 +++++
 8 files changed, 289 insertions(+), 265 deletions(-)

-- 
2.34.1


