Return-Path: <linux-kernel+bounces-106235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF087EB2F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C7D28287C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C6B4EB32;
	Mon, 18 Mar 2024 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLIqyO0N"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136E4E1B5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772807; cv=none; b=pxOtJKJ80S0U9hTtl4WJwIK/b76eVdtqi6YoQyndhDwzh/q1LQJlT67mOjlwP2Kr9FebLsCWv+3nscEKAaOPqcdggmA05h+tPMmHbgdGW5KWFx1rdoFUgt4BwhOt3biLMM1wleZTtT6tpNP9r9/v4IzJkuA4TGu6z2+mml1Mfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772807; c=relaxed/simple;
	bh=IlAC/UAQd5MXYjl273/a718EIOUzFR+4LkQzxMq+JaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4Xh3TjA7CKJI2rBRUwDuYLfmlORHcYGsu1avDCz+dWMoPv+xQhCm9VHF+VcW8MgvkBR7/gOsEdMUrdw9hSS3LHT6CZzepyPLB1QO+TLrxS8k+593yOAD+yWGgSReCDDtAwcYumYUtnp8uWDBSdx6Yi0KGaXasIRNQ4dp05d0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GLIqyO0N; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3584850276.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710772804; x=1711377604; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMlNnEWOpYXUGBNsiFKWdAeOcGOvC9+fZTDj9HH/epI=;
        b=GLIqyO0NvbL6PtO9o/EISigaWGlmuZL/GrUApo/Dx7ucAbvJe+w+REXvhJXsxRSPQs
         fPsrG7uRLH8+IX+ZfOKzlfFLlZx4So4e9j5nEWAc2ResSzjzwunIBEquRsPHIiG2Au/E
         4jV0ZfNpT785PnMtjuyLDshMr9dMymP5sbqeePy2rRcqCDGzew63xaDk9CAgbdb/Kczg
         BgIoNO+DqNv6ow7HCc7t2vqHqfHsbTZRb85SQMoTf4IxiRpOwtUF9TMWLrD3+KxdX4AE
         brJXb/8xsmh6W7VxzOGR+eG3tneKsgHasgdOp0BefistIY+anu8TNQGHOZin5ZqffUyj
         WxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772804; x=1711377604;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMlNnEWOpYXUGBNsiFKWdAeOcGOvC9+fZTDj9HH/epI=;
        b=vySyoZDjFyFE2+J3AbHz6xwBhx/Z/jHkJwt+h7s8O7Vzb5M8P2uhgW54lZjig9AiC/
         QxkEwb1qlQi1MeIZZ14T+iSXsxhEt2uHo34O+90MmVp4J8YC2y7GRpuxjDkmwK/HttY3
         R9X9OgOtwvxg0GZUKxjMrJEQvoTB5DlLevv6c4cWZdIP8YNdzu/0J80rNJ4ZvA6OMT+z
         w32u29LWWTH9ay/XVOiszSNZJyFEEmfevFSziY30MFm35haUCI3jXM4aIRXljtiyJGgg
         6Ldqvn5t4K92h7rJT8ls/HA/MDE9dLe0bmHzzPWuXKZ0CQC1iiWqbIZA6R4gOGQ4ysX7
         iQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4GiwqKt0uhf/ks3OYo3dhgCPLHvp+bgsLJeYWdVn8tZ4UqsgKZjtBZ20cKT6i85IeXZAbVqqCA9Ptc2cZGVvp2jGgkX9CsSM2lzbx
X-Gm-Message-State: AOJu0YzVQvAloBRpUPBN/iSW0FOP7DD0nco3mfWUgWzRI0WsCsoFwPcE
	Xks6MriTqA9rM3Cc8hYsfhsxlPKIVmExT8KKYUj/g2RPEfCMzeBt3+9UMIDD/U+2oCmsoFoJpnP
	lx2irssjo9i3ln59LuvC93aefA/jLTZEAuhsKGtlPlBOXKi/Z
X-Google-Smtp-Source: AGHT+IEThwYsQiTWbzhJyLQT2bhri6zZ5h4WE+yPw/QIQxHFbJAdyafw0GpF8nLkJuL6ZdTQ3mAeQhmXFW/TggAVm3M=
X-Received: by 2002:a05:6902:100a:b0:dd9:20d6:fd2 with SMTP id
 w10-20020a056902100a00b00dd920d60fd2mr2336963ybt.27.1710772804148; Mon, 18
 Mar 2024 07:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315111046.22136-1-quic_jkona@quicinc.com>
In-Reply-To: <20240315111046.22136-1-quic_jkona@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Mar 2024 15:39:27 +0100
Message-ID: <CAPDyKFpOobCrmeeTaFhnwMMhoWGKC6qz9851VjVoDP2fBZEUzA@mail.gmail.com>
Subject: Re: [PATCH V5 0/5] PM: domains: Add control for switching back and
 forth to HW control
To: Jagadeesh Kona <quic_jkona@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc list

On Fri, 15 Mar 2024 at 12:11, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>
> This series adds support for dev_pm_genpd_set_hwmode() and dev_pm_genpd_get_hwmode() APIs
> and support in gdsc provider drivers to register respective callbacks and venus consumer
> driver example using above API to switch the power domain(GDSC) to HW/SW modes dynamically
> at runtime.
>
> Changes in V5:
> - Updated 1st patch as per V4 review comments to synchronize the initial HW mode state by
>   invoking ->get_hwmode_dev()callback in genpd_add_device()
> - With above change, SW cached hwmode will contain correct value initially, and it will be
>   updated everytime mode is changed in set_hwmode, hence updated dev_pm_genpd_get_hwmode()
>   to just return SW cached hwmode in 1st patch
> - Updated commit text for 1st, 3rd, 4th and 5th patches
> - Updated 3rd and 5th patches as per review comments received on V4 series
> - Added R-By tags received in older series to 1st and 2nd patches
>
> Previous series:
> V4: https://lore.kernel.org/all/20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org/
> V3: https://lore.kernel.org/lkml/20230823114528.3677667-1-abel.vesa@linaro.org/
> V2: https://lore.kernel.org/lkml/20230816145741.1472721-1-abel.vesa@linaro.org/
> V1: https://lore.kernel.org/all/20230628105652.1670316-1-abel.vesa@linaro.org/
>
> Abel Vesa (1):
>   PM: domains: Add the domain HW-managed mode to the summary
>
> Jagadeesh Kona (3):
>   clk: qcom: gdsc: Add set and get hwmode callbacks to switch GDSC mode
>   clk: qcom: Use HW_CTRL_TRIGGER flag to switch video GDSC to HW mode
>   venus: pm_helpers: Use dev_pm_genpd_set_hwmode to switch GDSC mode on
>     V6
>
> Ulf Hansson (1):
>   PM: domains: Allow devices attached to genpd to be managed by HW
>
>  drivers/clk/qcom/gdsc.c                       | 37 +++++++++
>  drivers/clk/qcom/gdsc.h                       |  1 +
>  drivers/clk/qcom/videocc-sc7280.c             |  2 +-
>  drivers/clk/qcom/videocc-sm8250.c             |  4 +-
>  .../media/platform/qcom/venus/pm_helpers.c    | 39 ++++++----
>  drivers/pmdomain/core.c                       | 78 ++++++++++++++++++-
>  include/linux/pm_domain.h                     | 17 ++++
>  7 files changed, 157 insertions(+), 21 deletions(-)
>

This looks good to me! I can help to funnel the series through my
pmdomain tree, if that's the preferred route? Bjorn/Konrad, please let
me know.

Kind regards
Uffe

