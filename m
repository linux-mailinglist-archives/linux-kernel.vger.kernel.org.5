Return-Path: <linux-kernel+bounces-32535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFDA835CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BDB208D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24B3374C1;
	Mon, 22 Jan 2024 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INj3cZkr"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627737168;
	Mon, 22 Jan 2024 08:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912745; cv=none; b=LtvjE27NEycJvOCdBdjxen7g601HrvKwCtuAz3kQZL6FQym/fK0BhIbB4j3cd5h55IC+iDHp9vf49wo4sQjD4dOA3tnBFWT6oaw1iM+2VxeHjPJi2QcZjlb0aWbf2MByDBghAGPI02+huGPVSvNffEexeM9V5cQgFuDIAwldqVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912745; c=relaxed/simple;
	bh=8s0TCbyHAjFpXwZ0nFLBMCAT9Z5oKNHfYImmbtf0qxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJxES/LaiHLGG3GaJaEkGaV1qNToPJX6SfBhgGkBBhvqAk83tk5KovWpN4fPPnrVEfnYr8rhpNU2F6Gxdb6ag+I38Vl4Zj5oHZFtbRVcn224tdbF7F0x29fVpgawEo31vyXuqSEYbkkVHcq5w1m1xTYP4TNNKyy7fW8f7LGmU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INj3cZkr; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5986cb7bb61so1663148eaf.2;
        Mon, 22 Jan 2024 00:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705912743; x=1706517543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CdVvGiqfYdTCxC7+O9XTEejcr2f6NOrdLyxlbWMCWY=;
        b=INj3cZkr8+FWA1L+Wv6Uk2Vw5JeLrgqRMg+/f2asuXEXEerzdK18H5/ty7kREDHJ/p
         65iZZo6USDYqw5oNwcYb5Ny/ko2+nDKNjGUQO/yUTt1+3BYkouaL3tSGLF9bQWreZIoH
         SfCTqO7LE80MAPG4D+SJBTAlIS2X4oCJQB5xHHD3v/eWvQ+1l++sJyu91gix4hwRVLmi
         qo6oYIulw3D2w40lx5pPxD7bNfcDt9/6MuIIEWXKdbavd/1p2uv993IyL1h0R3xq5Vda
         uVt0PZlpKvfd/7el9teoimYCs5iSHiwYhExv4BUjILyYSrb5wsB2fKYHDpfL+h6gP8MV
         Cyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912743; x=1706517543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8CdVvGiqfYdTCxC7+O9XTEejcr2f6NOrdLyxlbWMCWY=;
        b=l67Z3RK3UtBkndkDIupp3duxT06tpaJkh39FW0i0urrDTWuYkkyMtIHFqbbHktL28n
         NKDDNrf6UbP+7WAIc++GXn72nCtE8jjQlF+dGUIvLAOF9T+P8pXKsVtzv7GJitoGbXkN
         rkIn/SoPoniKGf1UWD0GMxJFzYUfwyAI78XkUclpbcEY1HveBrDC++ck9NeBKjtk5LrG
         CqeoxzMIhsbxlX4N9TQTjqP9z2IUiJapq8BlYwsOyPWmTMXb+5G9GiGjmXGVD7Q7ky6m
         ahdOFS4BWh254Ejfw3am1F1pbCN0LVLLsAAXmoa9jnD4+BbEPZywLjJUexZ6QkxeMYyN
         H4rA==
X-Gm-Message-State: AOJu0YwqSivz7/lz09YbfkKF6yRuvkmSkG+qgUJimTlAs30aGvHcidpz
	2uthToegxwH9fnZUNwKIXB6f9aHpwihA3Qm+xxT9OlBKNQ0p6ctKgkq0SeShLlUBKVZLg3MTz3v
	iQq12dcd7HMzY4LfVYBw8Vt2in+U=
X-Google-Smtp-Source: AGHT+IHSHIMyD+bK3Oc8MHc7OHFPOOY2TwpSZQRqXOls2z9umwLfN1gbC2rc8LCZseXuS1D9LFYzIcR/xEOocK6faz4=
X-Received: by 2002:a4a:a7c9:0:b0:591:b9ce:4f8f with SMTP id
 n9-20020a4aa7c9000000b00591b9ce4f8fmr2290811oom.19.1705912742390; Mon, 22 Jan
 2024 00:39:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com> <90ae0cad-34a8-4e19-a72f-5e497b72b45c@linaro.org>
In-Reply-To: <90ae0cad-34a8-4e19-a72f-5e497b72b45c@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 22 Jan 2024 16:38:51 +0800
Message-ID: <CAJRtX8SWyUJmiR-z108XcVY77kCXhz7E4=sLE0+gmzsXjipW9w@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 4:29=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/01/2024 09:06, Jingbao Qiu wrote:
> > Implement the RTC driver for CV1800, which able to provide time alarm
> > and calibrate functionality.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >
> > Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC1=
8BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/
> >
>
> Why?
>
> How could a RTC driver depend on clock driver or clock bindings? This
> looks wrong and it prevents your driver being merged via easy path.

Thanks,I will fix it.

>
> > diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
> > new file mode 100644
> > index 000000000000..fbf2e575ea94
> > --- /dev/null
> > +++ b/drivers/rtc/rtc-cv1800.c
> > @@ -0,0 +1,406 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
> > + *
> > + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> > +#include <linux/irq.h>
> > +#include <linux/delay.h>
> > +#include <linux/rtc.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/mfd/syscon.h>
>
> Drop

Thanks, I will do that.

>
> > +#include <linux/regmap.h>
> > +#include <linux/of.h>
>
> Keep the includes sorted, prefferably alphabetically.

Thank you for your suggestion.I will do that.

>
> ...
>
> > +
> > +static int cv1800_rtc_probe(struct platform_device *pdev)
> > +{
> > +     struct cv1800_rtc_priv *rtc;
> > +     uint32_t ctrl_val;
> > +     void __iomem *base;
> > +     int ret;
> > +
> > +     rtc =3D devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_priv),
>
> sizeof(*)

I will do that.

>
> > +                        GFP_KERNEL);
> > +     if (!rtc)
> > +             return -ENOMEM;
> > +
> > +     base =3D devm_platform_ioremap_resource(pdev, 0);
> > +     if (IS_ERR(base))
> > +             return PTR_ERR(base);
> > +
> > +     rtc->rtc_map =3D
>
> Unneeded blank line. Don't wrap at =3D.

Thanks, I will do that.

Best regards,
Jingbao QIu

