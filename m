Return-Path: <linux-kernel+bounces-71316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFCF85A370
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98102B23C24
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B1436129;
	Mon, 19 Feb 2024 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aEfkFnJw"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C453612C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345857; cv=none; b=nKfuj7HItoJvYnwH2Fc7n7v8GIV4L/7E1bpCk+5jDJeubw/vDUQR2nUc2UuvsiMqV8dJyEH/5AUkEdADjXTnmGTOMuh2qYggxwWe1tlKNyFQ94I7eUQVEU50495MCwyXHHXC2UskTeoEqilz2kWB+5Lu66NdtIBG8Ch7EheQQrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345857; c=relaxed/simple;
	bh=HJLsuQ/pmzf06Y+BQsmCZTQ3R4vOv9LHvZSzf3q5pGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBFtC7GgzsicTF3nephem+HKei7RbTRyscRmrSyd9YSCjRgXirMSvOEh+FLTvLcGNXOJtlCWo7brUNz5xCi9zrleMYZwbJd4pPIiWLTJ9nScmPUxWgLBSU14UhTMD9vVrqGw8+Xz9avAvga3RlQJIH07r8upAR6xp1ANh0L12Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aEfkFnJw; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512b85d03daso438107e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345854; x=1708950654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVcz4T5lUX/p2dpLrBnJfdqrXGy/EYfTfCTW6sdiHL0=;
        b=aEfkFnJwUwcxYoDJUXyI73ePv6Zv9TnTF31lM9l+Kdo44cLc0yzogczJf7atLl6rn8
         55ayhFuE1OY15+A/I3WHKMOb7oIhIOzhLM+mFlnz9rT9cgGBO6M+i56BmoPlVyOc67bF
         ViaS8+IuN8RbtfaPCHCxq9jLtJH7JrlSpuH+tTi4FaBIC5nZAVQxq9tHXOlnw6oSA9kV
         FJaXSBnII1p6LgfAAS6NUn+laofH1uZXL2EcgU5Zqwt0j/ae65j6xjdmWBnlevTd8eAr
         YSJv4pC6Ut2aWMDcgGjTwdnWETaYEYliCXxa1uhxNPTCyCDtePBaxKqangfVCwi93nLR
         We6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345854; x=1708950654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVcz4T5lUX/p2dpLrBnJfdqrXGy/EYfTfCTW6sdiHL0=;
        b=ak2DfJUC2EPVM3vGDT1fEfNpTvU9M+2VjOqzTrREsraivsVn26MlVC9+HZ2TMgd2+4
         5JCixE8/YD7NSBeBmH9p00t53KuteFB2X1vohqVBlSX4GSzsE4MY/TkIgXKuX6OcpAIZ
         Nf5ebkhCgYxKspnyffCywH6af9Z2S9NquRtyQso/G3+O0tj35WRofrvrGC1Zk7Jznzbx
         ittPUE/rD2Mogn0pH+CLXnBba9Lo7zrY4wccm+MfgP9aeZ3fVKFE2SevLJhPRckkJIyh
         cvvSup22OUZA/FuaVmUHeiDWLdUsQwaQRnseklVWMxx9AvJvnZq3phTSbq+8HUgDsUTW
         hGww==
X-Forwarded-Encrypted: i=1; AJvYcCU5xiLQjPkTxStS3o51qCpbf3EZiMils5iqkM9eQ1rxiWSPqgEEhiIkehEqVpkzvADWv1KGjVmsm+jcJhRg2YuaeHhqRZuLj3zpZ7SI
X-Gm-Message-State: AOJu0YwFqTD+h7MITLg7sLkQvKRw2RIByV+0TEhLVBshpFwlOtYV6cNq
	LgA/y3XgV3eVvNeBvA/hU0fdGSoD3Vr4x2SL0YPg0Zhjd+z+shivVdWoU4FPskw=
X-Google-Smtp-Source: AGHT+IEPbgwbriAHQa/3aZrBt+n+k4H+sVUGdpUdH32pyxMo7FQlMDDN6LMaGZPj9i2Wa5EUvNTXvQ==
X-Received: by 2002:a05:6512:3b1e:b0:512:bccf:eb03 with SMTP id f30-20020a0565123b1e00b00512bccfeb03mr498859lfv.26.1708345853805;
        Mon, 19 Feb 2024 04:30:53 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id i6-20020ac25226000000b00512bde4cddfsm90466lfl.148.2024.02.19.04.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:30:53 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	robdclark@gmail.com,
	sean@poorly.run,
	swboyd@chromium.org,
	dianders@chromium.org,
	vkoul@kernel.org,
	daniel@ffwll.ch,
	airlied@gmail.com,
	agross@kernel.org,
	andersson@kernel.org,
	Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: quic_abhinavk@quicinc.com,
	quic_jesszhan@quicinc.com,
	quic_sbillaka@quicinc.com,
	marijn.suijten@somainline.org,
	freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] drm/msm/dpu: improve DSC allocation
Date: Mon, 19 Feb 2024 14:30:42 +0200
Message-Id: <170834569499.2610898.923684601788968526.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1702580172-30606-1-git-send-email-quic_khsieh@quicinc.com>
References: <1702580172-30606-1-git-send-email-quic_khsieh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Dec 2023 10:56:12 -0800, Kuogee Hsieh wrote:
> At DSC V1.1 DCE (Display Compression Engine) contains a DSC encoder.
> However, at DSC V1.2 DCE consists of two DSC encoders, one has an odd
> index and another one has an even index. Each encoder can work
> independently. But only two DSC encoders from same DCE can be paired
> to work together to support DSC merge mode at DSC V1.2. For DSC V1.1
> two consecutive DSC encoders (start with even index) have to be paired
> to support DSC merge mode.  In addition, the DSC with even index have
> to be mapped to even PINGPONG index and DSC with odd index have to be
> mapped to odd PINGPONG index at its data path in regardless of DSC
> V1.1 or V1.2. This patch improves DSC allocation mechanism with
> consideration of those factors.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: improve DSC allocation
      https://gitlab.freedesktop.org/lumag/msm/-/commit/858ddb64f1ff

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

