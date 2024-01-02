Return-Path: <linux-kernel+bounces-14282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D80821ACE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F95C1C2012C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96852DF57;
	Tue,  2 Jan 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tz32HQYQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5AEDDBA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ef7c6f4cfcso24040637b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 03:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704194393; x=1704799193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RoCKJmLNypuO4iV/d5JKlLOsOW1MONyGLn7Yes5k0vo=;
        b=tz32HQYQVbZ2HN3UzqvYXbOK0zZi2Z3DXTWybMhheUxmbYx1KStvWRQwLwFxROwxHQ
         vGhTcbpbckGF8UonS12mCk4GZ3RvUVcZ7ejavo906iJLrLyz5Ey6LqzCgh+j26M2oArT
         C7xdS0Y0B0KT/p/Rrdzn0nqJM84KOCC81qYX0jKAYqenKKgf6oUPXevzOzlKLf40R0Kb
         zp1RbnbRD5yjquSc3pIwtU6PnqXKBvWk8lQSA6ct3PDoIPKZp56T/p21j7cVXRukxWru
         NL+g/v/jNTY6zBw1QSgPG+2UiK2whREekej1W7+qvnkwZviag41NwT/ajOuZOWf9sXHR
         B/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704194393; x=1704799193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RoCKJmLNypuO4iV/d5JKlLOsOW1MONyGLn7Yes5k0vo=;
        b=V+gSS0QrbdloyJmPBgDgsu11cTDIvisdbGrkOAobRSLKD9LjiMIGp2XiDYl6GA1A/p
         AMAWY9+057pYGhXoTvgdzAvGIH5B3qxg9cEQ4EelunKoJWbuzU8lJuwAbGsuDucAYAIL
         N2L4Mk8pUX3oAUd/usDV/vWYMR+ukyytpnBA/lse5gDrw9DPuEFgdnx6B6ZhE9yXIZvT
         vC3dMQNrONMvirxejwpi71CZqDNQZic4bbPlHBsvYjBWJoEGsdQWoxjonrWSNoXqMiZa
         5fx9huEXLxJLIviScS+zVTDTCJ0TMXvRAMB9V2QtDfve1NG+TqXicLDwaZm2EYch5yc0
         5tqA==
X-Gm-Message-State: AOJu0YziBM/o9g4gj8sd6FtsHVNEvxwgBByOqXc0EGZpboFRZ631jZw8
	dpzugjlIlaNAN+xqoXw6EK5YWVOZ0UDBei8V/Thdrcdxh+fOQw==
X-Google-Smtp-Source: AGHT+IFrAuQNhlzlRQsyHyk5pUdcHgqhtVaR49+5kjXKeJirtWfRLQHeIOnR8NY/b/Nj/rCyLUP0Qobi4YuaFwRqXoI=
X-Received: by 2002:a81:5fc1:0:b0:5d3:66ad:f8f6 with SMTP id
 t184-20020a815fc1000000b005d366adf8f6mr11600270ywb.24.1704194393450; Tue, 02
 Jan 2024 03:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229121504.3479594-1-himanshu.bhavani@siliconsignals.io>
In-Reply-To: <20231229121504.3479594-1-himanshu.bhavani@siliconsignals.io>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Jan 2024 13:19:42 +0200
Message-ID: <CAA8EJpp7XOxk3xuUzzuF+omMaQXUeeL_gm7ipFEwv+bfHdONMA@mail.gmail.com>
Subject: Re: [PATCH] media: venus: use div64_u64() instead of do_div()
To: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc: stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, 
	agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mchehab@kernel.org, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Dec 2023 at 14:16, Himanshu Bhavani
<himanshu.bhavani@siliconsignals.io> wrote:
>
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
>
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
>
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 44b13696cf82..81853eb2993a 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -409,13 +409,13 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
>         out->capability = V4L2_CAP_TIMEPERFRAME;
>
>         us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
> -       do_div(us_per_frame, timeperframe->denominator);
> +       div64_u64(us_per_frame, timeperframe->denominator);

NAK! This is completely incorrect. do_div() is a macro and it changes
the first argument. div64_u64 is a function, which returns the result
instead of changing the first argument.

Please consider checking the code before sending a patch.

>
>         if (!us_per_frame)
>                 return -EINVAL;
>
>         fps = (u64)USEC_PER_SEC;
> -       do_div(fps, us_per_frame);
> +       div64_u64(fps, us_per_frame);
>
>         inst->timeperframe = *timeperframe;
>         inst->fps = fps;
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

