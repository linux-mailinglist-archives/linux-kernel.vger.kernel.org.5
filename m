Return-Path: <linux-kernel+bounces-60387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C364F85044D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F871C222E1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 11:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9A3D55E;
	Sat, 10 Feb 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eD49aTLr"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8993D54F
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 11:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707565914; cv=none; b=bvYUfcFAgv3LnSqBhvA3BHUsdh0i9NUC/1OTNB9XJfrXO6u8+Zw+89UeMMxYWAb9tDuoFTjycQG2W/d5+RYVAKovvz8KdwK/bll/JOUK6B9X+XUDCeDJsmjCh3KKUSShOiFKMIMN+7uJWI2/M+cWAl3l8ghLusn7CKX0UIkFh/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707565914; c=relaxed/simple;
	bh=7rc3pZKZQ3h12KuocOBjke7RPf57CY1ulO+EwZZN21A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtfhtYNe/ZyLrmT11vnvS2zsGhG0iL6kAIuC/V9N5053PoMkRmaVGc1KJ/r1kQK+sYKTPUKPNRzFfibv+qfOBUFlRwNBim3MjV0IPAgjm0KIac1c+3iLtLZvUWFOvvirizw+iEcEsKu4pI8o1MEzmqZkk62hlICxPCqqTP0fwGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eD49aTLr; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc6e08fde11so1921093276.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 03:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707565911; x=1708170711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/RWQV9SF+U2wQY2whqhrKlZUzNhMlpaeidneMuAvWr8=;
        b=eD49aTLrjo1zBpbcKWa8Lp0I4bGsaRtsLcf4Amke/MSnEmX5dR9p6Ll52L7u0pu1yh
         yswivvSj4gKsx3pI/BVfbRTk7zkeLofnZUAiEDj0gf60H9Txjf92qhNygA3bV4kTHjgm
         JUuBr42exz9qGl/I5sGty/5dMkKSNpbC1JeMNmcComR7mzRV39jcnZ8ol2Z4RJGSvtwS
         S6eME+fCDoOonXv7vPj1xEuHnpphETVNaV+uAMDrJ6rBiYHOsPn6Yk371DKg2w4xAVsm
         JmJWW1576y9qoms7OGT9DvGRPUx+5UIh/dByFapO/BOMyMlgeR21Y9nonWRrfzyRzznt
         OfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707565911; x=1708170711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RWQV9SF+U2wQY2whqhrKlZUzNhMlpaeidneMuAvWr8=;
        b=Qvv2Gnkc14Jaq26sqdTtPX3l6VgMFgPKGr/120MMIS8vntvZMCfNUDbFyfVVpJytof
         nq9SUBlmvJS6hp8/KS0Vhq9sbFHQl4VU8REDkFHPTLbWnBZXUjfXzvEGUXnHxnh8nZlb
         F44FQ5sMGLfL4ZzMNtrN1/uotqaUO8Uc+jfEAeWZuZ6PP/nODLk+XjQAaJzoTDqNZpPR
         E7Yn3ush4/79KXgVjG3yHi3rpG48AFx2Jo6eAkVb92yQjbrlm0qmqIOl5oSfYesSwrh6
         CJ6tvZ6CDkb+yfwY9KWOa6xahUn82AbqpV1KjokpDa9bZ2eJYuNoE6rPNg3jczPgsfkQ
         QI2g==
X-Gm-Message-State: AOJu0Yz/3cEwellG2wcbMZziVgSeXQ1d5Sm/RuzQWJeSLrSd9iTQsSFf
	TfOx6nTGVl6ih1twBMm2pa1TaN78vN0WLeHtUGE7ToaFweh5o0SnTQoTaNn1VeH+vmAI9mHXhqN
	TazkaoqAHdxfwEZ6JOAZ9zc5jzAw81AOKOXUp8g==
X-Google-Smtp-Source: AGHT+IHFyIHD774MV2fP+SnSwgZs21+HYOwYBlaQnlLEfF4zRO80UDtJtaZAZIQJ+wWMOfEhJRsDBXclS9ily9CzMOU=
X-Received: by 2002:a25:bf8c:0:b0:dbd:2b6:6cfd with SMTP id
 l12-20020a25bf8c000000b00dbd02b66cfdmr1415270ybk.2.1707565910913; Sat, 10 Feb
 2024 03:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240210070934.2549994-1-swboyd@chromium.org> <20240210070934.2549994-21-swboyd@chromium.org>
In-Reply-To: <20240210070934.2549994-21-swboyd@chromium.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 10 Feb 2024 13:51:40 +0200
Message-ID: <CAA8EJpoS3+NJCMnR3HhGrh73W39ivz9O6PX3Fov_an3cY+sLLw@mail.gmail.com>
Subject: Re: [PATCH 20/22] arm64: dts: qcom: sc7180: pazquel: Add missing
 comment header
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Douglas Anderson <dianders@chromium.org>, Pin-yen Lin <treapking@chromium.org>, 
	cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Feb 2024 at 09:16, Stephen Boyd <swboyd@chromium.org> wrote:
>
> We put a header before modifying pinctrl nodes defined in
> sc7180-trogdor.dtsi in every other file. Add one here so we know that
> this section is for pinctrl modifications.
>
> Cc: <cros-qcom-dts-watchers@chromium.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: <linux-arm-msm@vger.kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: Pin-yen Lin <treapking@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

