Return-Path: <linux-kernel+bounces-159882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DF88B356E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075891C20DF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2079B13F44F;
	Fri, 26 Apr 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPV9dZ0+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0BC8249E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128096; cv=none; b=p05jnOj4anqdXR6O789EN81p/wHH9D5oW4Xd5+2UbHb2VHjPpumcGA6e40vOvwrKGiSEtWBuas2pfm7JyH7XgOJfY8dgCjz7+T82CDrwioWEPyPmQV6FWt4xJdMF1+DOVcCz86WSpce+j8tmnxLlyoKV+Lhs9fznt3Fq9D9hsek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128096; c=relaxed/simple;
	bh=k+SE7keCr6t7cairuP3cKJlPZLAyn4ljzQQefegvSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbCRtWkm3sa+48cR7ulHDVyqC0EytrnEWKmNtRvEXHwIN2X0IlzgLWr78be2hbeM1WOAAUFAkhXI3WaDIhtQWTPf7F7YWanAJfMHudyRxFVPd/FlnKVYhTysshdyFTx5fxJD5qenc2tlvj7HDD5M/Phyc2zuCnjyXlpDWYu6FL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MPV9dZ0+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b5dd5af48so10506075e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714128093; x=1714732893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WV6OPanVmYA5r5EmkQ7/rYqaeYoVyLASpzgyuZ+VcXw=;
        b=MPV9dZ0+poUdSX+eR7WG4ZnciTsyKM5HrFMLK5hsI2gp9eFh7FxXXjpfmbrhjtvelq
         SlD/1wU7l8kypcYULrG7Z0J4oQ4estM5nqpbXWyg9YJC6HrEFv6zf3yj7079D4Z1rgpH
         ZqSsR2HKxebFGmcXoHqcuE0G4PdXBespQhB+t8OWihJy40LNBgSgukER8k77jS4WMZCt
         CObMKPdppXlQn/lx+GH81E/lyA+YZm3go+emrSqD75EKkGhR1VpfF5m1Ha2XEIjH1JHD
         RmEZcPsSmGPVbcMEu1U25T360Y5NNy43okC+8f81/3IkiGAlegVqW4TuhDjpCtTFCp9c
         hW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714128093; x=1714732893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WV6OPanVmYA5r5EmkQ7/rYqaeYoVyLASpzgyuZ+VcXw=;
        b=UcEADOcamIG6/Vs7l5upyG3bZpclRlVqscZVs3HswYd2mKHcHuRIyUZ9BVMeOzugg1
         eeIyEWV54FfyWr8Wkwd7Lpdwo5XlfNLGaeXVAWo1cIYftqaGKu0j2FMKc50lb4t682ew
         Qbu6GtteZFm+ALpIFygblr9J3cl4e5TKp04w5u3J+IgLhMo97cGPPLhr+3AuzYTXZvVn
         Lgl8YzXTwVDxRpQnTJUJSISlJvFrDBQqzPrsdauAB4eK0ulkl7Ub2s3dbESLCMrgaA4m
         gmYL74I6STn0q8A6XgZ0e91gq/TChBXxFOns/8dtZHQWot8afUk/U5koX/T7//PvLkHe
         gpMg==
X-Forwarded-Encrypted: i=1; AJvYcCUjPCq5OKrghMQM8H07dUXmx6J7BRq3rp7MTkpqyponCZVg8G+SgC75oUMfWu5lvi8fKHYSNzQQxNGuZAXaD3Nm9BW7Yszckq5Ryxb8
X-Gm-Message-State: AOJu0Yw5SnJRZqML6sgItJGnKTh9Usj2LGqTzu62DVNP7E0raT23HLkb
	E2Y4hwKlcY4CDr2ufGBl7srLTRVsj8knUqJhXvV0Aj2GloOy21R8zXriBHjNDTc=
X-Google-Smtp-Source: AGHT+IH8wK3JXHy1LCmqDycOo9ehbJoXmdU0TA1d/vl29W7tPUPtsbjGsAEAODalDRLZ2sUl+1cM1Q==
X-Received: by 2002:a05:600c:474a:b0:419:f241:632f with SMTP id w10-20020a05600c474a00b00419f241632fmr1706553wmo.31.1714128093024;
        Fri, 26 Apr 2024 03:41:33 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:63cc:9bae:f542:50e4])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c510e00b00419f572671dsm22035335wms.20.2024.04.26.03.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:41:32 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: vkoul@kernel.org,
	kishon@kernel.org,
	krzysztof.kozlowski@linaro.org
Cc: linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	kernel-team@android.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH RESEND 0/2] phy-samsung-ufs fixes
Date: Fri, 26 Apr 2024 11:41:27 +0100
Message-ID: <20240426104129.2211949-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Vinod,

Two minor fixes for the phy-samsung-ufs driver. These were sent previously
as part of the v2 of the UFS series [1], but I'm re-sending after
splitting the patches out into separate series (clocks, phy, UFS, dts), to
hopefully make things clearer and easier for the relevant maintainers.

These patches were based on feedback received from Andre and Dan on the ML
after the gs101 phy patches were queued [2].

regards,

Peter.

[1] https://lore.kernel.org/linux-kernel/20240424195144.GA360683-robh@kernel.org/T/#m83601bf4230be17669080b8c2ee8b418413ada4e

[2] https://lore.kernel.org/linux-clk/20240404122559.898930-1-peter.griffin@linaro.org/

Peter Griffin (2):
  phy: samsung-ufs: ufs: remove superfluous mfd/syscon.h header
  phy: samsung-ufs: ufs: exit on first reported error

 drivers/phy/samsung/phy-samsung-ufs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


