Return-Path: <linux-kernel+bounces-154100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5FD8AD763
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EED31C21CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC86376E2;
	Mon, 22 Apr 2024 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRxJP2c7"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329A20DFC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825708; cv=none; b=cO7Hm1MVgkOcis5mXHU+Li+iIHJqq1ECmcO3l1n9L8F5qNswzRewtW0WR7YjWDNlHnyLVXnm0l0g2B2DJZQBLrPO1r45vbG0BWIcmId00KvA/qCWigYvIJIvHtFKHlu0gR79jxLbkckg5wanKpjAQIZCgHPQUnuqS5rE+SitQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825708; c=relaxed/simple;
	bh=E1iwmM0FXgYbo46qhYHRdRdON63UkH8CUKrkRsWHf2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=bQYv8sH7nATJHjD9hCaLcY5zRjEFeuqAv+ujPVyVf6TLZjOzbzhjupMV3QgP06ltX0CZh8sm/nY0LlA0N47Z+jW2/lAzoKwp4fPvNrw//9n5TOGxWiaIFn1GITcFnXtQQT6Uz2sYYXLxuj/5Lg5Jb2C4MpuMx85Rw7pNCtSOkzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QRxJP2c7; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516ef30b16eso6191157e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713825705; x=1714430505; darn=vger.kernel.org;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+ofb9yeBHMXTTM8HZhz0uxLNlsEbRIYmj7t5bvxO5E=;
        b=QRxJP2c720fcc8Qxfbdk6mb03aOCip6n4ZVg4mtdk87C4Wy288+rcSu4KOKrRKMRN6
         SVQa9t8GbYGvzNkLokMysvkGUfd8jvc5FyKnFMWjDUhhyIg3REi776dze2xZz9H02eX1
         FHFTig5EL6jFOuw7xoOsqa93+1TzeAc8sO4nVqyECrBGnWA5w7mrLFmVgx9pwMRg7o69
         eJQvuFhcZVMhjmtanGPJPOfBaRGyeJ3z2XDwSIlnGp8XI9Ra6meaEccblTLJb0IiYBN+
         ZGY+/9ON+Zzm7Y7UZzz1mZHilpj20dwECgWHZNdFmx67FOb2l8OHGFkQHkuGtK7PYXpA
         ZVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713825705; x=1714430505;
        h=to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+ofb9yeBHMXTTM8HZhz0uxLNlsEbRIYmj7t5bvxO5E=;
        b=V80p4VZQPeFb1Uw649IdTm3RePrKc9Cy7whRadlk4thJlLsDWtrWQfez9VAi0nd8bj
         nHtmA1Az2hCVUph7D+8sK8erD9EaaY5Gbgz+GRccVzTgBLTyOVRKdFverWJOv+6/3Z/R
         am+8tHfswDMYG6N7sfkcE2AbmODC7ILBixkhI0Bz/Z0Xzu0SIt3oeVuyj9jWuf4ss+fP
         ZsQwfvLxUo58QmPz1BEFExFgY4absFqoGzCZmqrymL53VSQe7ENDBHzVPAsLVh0/7mUs
         fL3yO2e/8cHymUnoiwbX1jviTXDCuDMVWnHLFPCCHfrKLzPRbCvpF3fqILxKafiiMfSz
         h1nA==
X-Gm-Message-State: AOJu0Yw9P557rtW/IjwQuEzkvMC1pv+Vyw5ngEEFwiIGk+EN3ITpo53F
	w95wwh/JPPQy44dF5sm8VjUDhO6c5EGn2qAnKKAvdU9ZV1OoehR0TMnE8V5oQsQ=
X-Google-Smtp-Source: AGHT+IHJl52CbBsoQwwYJGF6GCqOPh3Oe4dbvdnkcYh/qdeaIyffE0Yg8xHbVPmxRz9QXOaiw9MepA==
X-Received: by 2002:a05:6512:1595:b0:518:ddc3:b3a8 with SMTP id bp21-20020a056512159500b00518ddc3b3a8mr8412323lfb.61.1713825705222;
        Mon, 22 Apr 2024 15:41:45 -0700 (PDT)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q24-20020ac246f8000000b005130ece9099sm1829517lfo.277.2024.04.22.15.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:41:44 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 23 Apr 2024 00:41:32 +0200
Subject: [PATCH 2/2] MAINTAINERS: Add Konrad Dybcio as a reviewer for the
 Adreno driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240423-topic-adreno_maintainers-v1-2-21e1adac2c13@linaro.org>
References: <20240423-topic-adreno_maintainers-v1-0-21e1adac2c13@linaro.org>
In-Reply-To: <20240423-topic-adreno_maintainers-v1-0-21e1adac2c13@linaro.org>
To: linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Add myself as a reviewer for Adreno driver changes.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 179f989a1e4b..80aa006f10bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6888,6 +6888,7 @@ F:	drivers/gpu/drm/tiny/panel-mipi-dbi.c
 DRM DRIVER for Qualcomm Adreno GPUs
 M:	Rob Clark <robdclark@gmail.com>
 R:	Sean Paul <sean@poorly.run>
+R:	Konrad Dybcio <konrad.dybcio@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
 L:	dri-devel@lists.freedesktop.org
 L:	freedreno@lists.freedesktop.org

-- 
2.40.1


