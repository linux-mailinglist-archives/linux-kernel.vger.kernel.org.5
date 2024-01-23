Return-Path: <linux-kernel+bounces-35278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6D838EF1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0276A287866
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5A95F54A;
	Tue, 23 Jan 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="miusm1XE"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF229604B7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014435; cv=none; b=GsSheGZVJpGjnq+Qz+yfXsiWJ/j21IOS+rV8ArMF0ar7MFjPY+tRBHNO/Q7375k3p+Gxl704UOYAwnFpuB+5tsEr7koce0/nBGdKUhjXE80XxrVRniXE4D12GYK3NHUMaOhRjVVdoQFFEhprIEooYXY4rirN7/NumZ+uuVuCjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014435; c=relaxed/simple;
	bh=SrubDBE5WcpcfK7f3xovnFiXn5W/MQUApTBY96p2ZzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxiXfUeHcIQtMnRZ5WqtMCV//+Smy0DbLR9m6mnu2Xepf3UEetXyXmD2CW//UhOdj/U4bjF+A8ZpLSW0SsxtkoycTt93u99pBCYyTAkTYhuVkrjYLKMRYcaTTpIAH7JlKPszRq59emh9rQbj2CILOHtEKYOt9cE/zP4vmWaJJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=miusm1XE; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-600094c5703so17267697b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 04:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706014433; x=1706619233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+asE/AToOCsan6HoT4XnPwjdlU0T+m2L6pRIK9YYNg=;
        b=miusm1XEW4kveUW39ihoH7X2eavQf30EvZ5jgVfQWWY/zt/IWT22Rm+4iDYPEIVkki
         2TLNjczpT94D4VDDycDi6L03wipZAqwwisLsWa/xIxepIGeqP0cVZxjK0dXzHL6K+jgc
         M8ApoJ1YNlZXrp7Q80rdHzUeWd5/seBUnP06WpRchKAb4aYecJLRtYbmICvX+KWaukaP
         TRmKIJ4zm2CDeoHgCsRBkPfphfQdDdtcJIjGzzmXmj/Q7BNpjvM2fdD/606BivVFpJxb
         Gbu/LHx9nlo6APz1V7Hb4mJO8/IK2RmitPxp+HlO7Y8mIKJ6w+Kvjs4dXOzx1TXdAz4p
         Stww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706014433; x=1706619233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+asE/AToOCsan6HoT4XnPwjdlU0T+m2L6pRIK9YYNg=;
        b=MgIWHOvXM39XFQ7VVt6+WofBH+CyIAmbtfvQWq1lOhTIsAyShlQUTWCDKZ6IPASvx9
         +ZvcpjXGFQ9iZZVMUYhxo1/C92e/7/JMd7i4zTF5s+3hzJKQi/eMNp4Anpmwtn2KPqvx
         lV0nYl6ljC1J0jfNqSGgpXdIPz4DyzPVKAEEGYTB7JTjgG0q8MRXFpwuJuN1E/CyLZyq
         NBEi7blDHRsWmceuyqagSrMWgfXXF2o0jiSAmCQugVz6lsaw2MKKkiXgbQ7E7dUVHERl
         hBPP/29grTYuN3rPZ3f++DlA5vdnJRIl+mArh7cE5OW48u9WhBU5H+ta/dU/Pl32AIfd
         BweA==
X-Gm-Message-State: AOJu0YzdMWchb1hiD3U6tN6t0PEJYrZtp/n0H/JdE7LWwC5zigyDEoO/
	t5w86lmxsr/QsWbeXeZ+obusgF+TbAbLki4+PkZ7VFJt6m1ccw8Gd2UMYwNq3WpzjhXTT5kUlN6
	a5xyFP+K/BPNEpNHcZc+nOxF5+XH/Tx3AIFDX3A==
X-Google-Smtp-Source: AGHT+IF0zt7gwjJbmvCQYkLw24rgqNSfBdkANuOxWkItD7WSZEKNeUhd5CZMquNm3DCcAVEY1T/CrJcgJ5At/Eh1vmI=
X-Received: by 2002:a81:9113:0:b0:5e3:320b:7c with SMTP id i19-20020a819113000000b005e3320b007cmr4912440ywg.37.1706014432844;
 Tue, 23 Jan 2024 04:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-gdsc-hwctrl-v4-0-9061e8a7aa07@linaro.org> <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
In-Reply-To: <20240122-gdsc-hwctrl-v4-1-9061e8a7aa07@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 23 Jan 2024 13:53:17 +0100
Message-ID: <CAPDyKFp3F16iQnR9jw6_AJStWvGv2u8CHsF4YJCZSxJj-8p0LA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] PM: domains: Allow devices attached to genpd to be
 managed by HW
To: Abel Vesa <abel.vesa@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[...]

> +
> +/**
> + * dev_pm_genpd_get_hwmode - Get the HW mode setting for the device.
> + *
> + * @dev: Device for which the current HW-mode setting should be fetched.
> + *
> + * This helper function allows consumer drivers to fetch the current HW mode
> + * setting of its the device.
> + *
> + * It is assumed that the users guarantee that the genpd wouldn't be detached
> + * while this routine is getting called.
> + */
> +bool dev_pm_genpd_get_hwmode(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (!genpd)
> +               return false;
> +
> +       if (genpd->get_hwmode_dev)
> +               return genpd->get_hwmode_dev(genpd, dev);

Not sure why I haven't spotted this before - but we should probably
assign dev_gpd_data(dev)->hw_mode here, rather than returning the
result from the callback directly.

> +
> +       return dev_gpd_data(dev)->hw_mode;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_hwmode);

[...]

Kind regards
Uffe

