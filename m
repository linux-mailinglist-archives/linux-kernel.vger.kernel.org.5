Return-Path: <linux-kernel+bounces-32977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE78362B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFB298E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391B33B197;
	Mon, 22 Jan 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPtrNM5n"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227BE3B193
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924645; cv=none; b=HFTYpJMVmEQGkx9xs8AHcPbfyo6Vcn9D5+W9L7YcudNihjbZDK5+YxzPhe/XP6ODNg8Zv2zuHDE9Jb9RVl2xPaywhxWFeBrIdujGYfSuyTdIBB7jBfJajI9hM8JnErqC+Vzm4IbgL3BfUdtBzQuy4a7KV8z/IlKaby805iAHMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924645; c=relaxed/simple;
	bh=PbWtnWRE8OdZobvCbQjeCjgGmP9VZZyrNRe7q9wSh4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYRbFLoVhox2xYowHXHc0g6yb+c7zj+wyI9DZxrNwNkfWcn/jgg56L+3NcnlJ0pRW9DNq5zrADSPPgamTeTkb9RUKrU8DwhOAINfOWNq3LuHn/QJuAX6XjOu1rXEWXrfedUEf4D2rvrbOpmb5JmtJBtQ1Ae3wk+7S4giSxrO7+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dPtrNM5n; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2d04888d3dso316700166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705924642; x=1706529442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxydUfSC9eRtB22KvfpOCkXdWNLtx7yPPDJ5CJF/vzw=;
        b=dPtrNM5n4Qcwx28zh6ncbZtaFmYXpEVqzlvLeu9j8FQ5XNnmJnEqzx6ZgXVSeywkHM
         8efj5QNZm88q7iqEdunVLOcAohrYhHeTzXKki7/cj8AcUOZ9RFZagy2TPJ2oM+6JDzBl
         gOiJY4/k0qvMBFNjrwzUWq9uQs9H0FqhHaruVvd0A7mRdb/u1i6zK6yXUvFrjMtJQeD3
         3w/TAxebeI9hpa+BB37l51Xy447THwZEr9/yLInWiVIqVJpdSnujMRs7B9JfDPNGCEEr
         rLrYB2aLls5j4ZZIOGiRSWXWH6AIqlZNP3RXV2GPI5bkL90Xl/5Io/bkd8lOhxv7nGZR
         eXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705924642; x=1706529442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxydUfSC9eRtB22KvfpOCkXdWNLtx7yPPDJ5CJF/vzw=;
        b=GsCNj2KAdXpm2BZHbBJiNcOvyQAjXTFRfZB9HiF7GWRWnX7LFkrAJy72PaGsNetgiL
         lINe19QR0Ogl0IU3YE49FGm8FndQG97JS5z3Rt7g5ktAkfPNieC/jw3cbuv5pHt8g5qx
         FeKMhQVbN1F6yx0m2lbmYXws86ZpXW2Ll+Dob5gI6/nc1jRqv5LWlyub4nFmN2unPwZR
         i5YcEfmS2rldwSkZ+pqzEBQNlvKfYwBqalhQaxWhaG70SGn8KNANxV/KMnXgMOOlS06+
         EzXRCEa+jy/tvdV6JOk6CVB99bMLGEWwAWD1JbrA2zzW/VaGLRJZ2Q1SbqK8mV8T/ncQ
         7UHw==
X-Gm-Message-State: AOJu0YwJYYbUb6x+klHW6waI6EmgxfiOT+kR3i6b0Pxwgs9cuHxD3jg/
	Ns76CtpoeeySaWITKE/3puKZhcri6nnxE9QSScmlbkP/lXsDiUgS8oq63kQqj7I=
X-Google-Smtp-Source: AGHT+IGWRXRVK5jaCEJkqj+YrvZOyht2hZokBTPpzFHbe4kV5s5gsdAWF0hJ71ERxib2JafhkqMu0g==
X-Received: by 2002:a17:906:ae8e:b0:a27:b8e0:ed89 with SMTP id md14-20020a170906ae8e00b00a27b8e0ed89mr1909497ejb.138.1705924642264;
        Mon, 22 Jan 2024 03:57:22 -0800 (PST)
Received: from [10.167.154.1] (178235179218.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.218])
        by smtp.gmail.com with ESMTPSA id k3-20020a170906a38300b00a298d735a1bsm13481349ejz.149.2024.01.22.03.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:57:22 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 22 Jan 2024 12:57:13 +0100
Subject: [PATCH 2/2] arm64: defconfig: Remove QDF24XX pinctrl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240122-topic-qdf_cleanup_pinctrl-v1-2-0c619ea25091@linaro.org>
References: <20240122-topic-qdf_cleanup_pinctrl-v1-0-0c619ea25091@linaro.org>
In-Reply-To: <20240122-topic-qdf_cleanup_pinctrl-v1-0-0c619ea25091@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705924637; l=634;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PbWtnWRE8OdZobvCbQjeCjgGmP9VZZyrNRe7q9wSh4g=;
 b=yh6s7yqzGgsWuTz7YhKO+4IOkHzL8oa8CR/iRQiWeBUz9cTuDqdUiE+z0yQ0FDh0uOgtHLXtv
 jz9RsffyZV0AiAwvmzPQeu2HcaSNGCYa2YbZkm1BZC6JmX3tpC782Jm
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The driver for is has been removed, clean up the config entry.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e6cf3e5d63c3..55b8dab100bd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -588,7 +588,6 @@ CONFIG_PINCTRL_MSM8996=y
 CONFIG_PINCTRL_MSM8998=y
 CONFIG_PINCTRL_QCM2290=y
 CONFIG_PINCTRL_QCS404=y
-CONFIG_PINCTRL_QDF2XXX=y
 CONFIG_PINCTRL_QDU1000=y
 CONFIG_PINCTRL_SA8775P=y
 CONFIG_PINCTRL_SC7180=y

-- 
2.43.0


