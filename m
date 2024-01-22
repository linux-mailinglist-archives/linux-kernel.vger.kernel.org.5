Return-Path: <linux-kernel+bounces-32617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D68C835E05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5EB1C240C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAC339AC5;
	Mon, 22 Jan 2024 09:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/6YQVNy"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29A439850;
	Mon, 22 Jan 2024 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915424; cv=none; b=QbpjI8VyMQNPn0b8orz+1kOj7RZ4wY9rATAYL2McrNeWiYR4a+6JXXqD9G5eqL2g/5vR+Ee8s8adJdXk+FEkBwyRIPeERd3MKyt0nge7Rfug0QCRV6v4hzwgJpzFMST8GjTrfsy2wJFjtCx+gxWIHrVQ71a45K2JzvQT5nPkfRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915424; c=relaxed/simple;
	bh=An//1jmJkagxoPM0+8oyaFGToL9WWNmj+iNkfY5Xwm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQ5rvyiBRPJeXFZJq1lW8Ylp4HAP6AXXAegnBbZz6voF5pp1Ws1bC6qRVjLOLDhWZscCs5X6BQTXpA1Rrm6YJHwc2tx/wcRLFQ5dstiWVSPQmnFXPMnejz7Wl1ETgD86omIEHU5ey2bAO7+zAT3AI3zHB7XleLMuscMF+OsxN+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/6YQVNy; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dddfdc3244so2271158a34.1;
        Mon, 22 Jan 2024 01:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705915421; x=1706520221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An//1jmJkagxoPM0+8oyaFGToL9WWNmj+iNkfY5Xwm0=;
        b=H/6YQVNyKnWoA1koyzHECkqgVnoEJLMx5uRLhoqtb80jRWG3yLSXJpiJzXenicoPpg
         nldS1NXSXvLT4Riu9btPkaWCwuWiKWG5SBM6vtEEvy21UPx0HJlxCaoBe4+1+PWrXFVM
         jQYUKT4Nr82xbWwOCUHVy4QO7Fv8kXBt1S7Kyvg18Sc5l8o2DOm2Cx4p3ffEr8YTI8d2
         ynWQ+PiZPEWO2G+qVAMG8rGS4MgnhHsPHtoneAWgTFY224CBvap8tTcS3rrzcmEKR+gU
         UGvnji4HGz1xF4sh98j/WIJt09Fx2ARY8naOrlwh+H6OdnPu4zVDKE4P1/WBa3Fk6KD4
         77Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705915421; x=1706520221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=An//1jmJkagxoPM0+8oyaFGToL9WWNmj+iNkfY5Xwm0=;
        b=gIsnAepcafxVq5tVZlesysryneg3yKFT+J8NHLRn3HDBJm1iYLcTxQxIa0LOOhHSlL
         kgRC7nSqXIPjr1FKQvakkQAe6Osz83vDyphYyzkcB4sGKOoRtuETTkNNJIE0Ok22Gqql
         n9IJrBCsAeZfpYcWvexCvJe8eexVO6qhBeNv+qcMh0Z729UFTvBZ9cwItq5r5JZQUHZR
         DStYvQ3JYFNj5Qf4LtcMN4PTHGvhDBIgglpHf+JVfJxnJ5yY0ZsHD7qlgSUB4K0vh60W
         PVDmzrsu9wNTQEk5nYP27CSLP8HC2Y1e37+qS+ewCxE14HfzV5rikfTqEs+xlfIv1YLp
         Wo8Q==
X-Gm-Message-State: AOJu0YwR6q6h8U8CTr8YxBZjjL0Xxnp6PjhFEzVe2LQexdSYn9wzrktU
	XdZHP7rzL5qrHLvJWoFJaGiGta6ofa60/UyupBmvqLiX2KKlP+cZclhODclq2geW2DPkFSsLftB
	qoCXTYzQeBtJrmFYDdlJp6o3F34o=
X-Google-Smtp-Source: AGHT+IFBYRPl1ryahxuI8r5+ViUmrqkH8rztXRFhCsnMTpg9NzQJdrag3MCpRtAvV5rdD6ReR16lH3SbseV5iIBy8jk=
X-Received: by 2002:a05:6870:c14a:b0:204:c37:85bf with SMTP id
 g10-20020a056870c14a00b002040c3785bfmr3196999oad.74.1705915421104; Mon, 22
 Jan 2024 01:23:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
 <20240122081722868bdda5@mail.local> <CAJRtX8QU8iHY1oQJ1uDN3YOmCeN7SH+vPC8nD29WS5+2DT1oKQ@mail.gmail.com>
 <2024012209151130867663@mail.local>
In-Reply-To: <2024012209151130867663@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 22 Jan 2024 17:23:30 +0800
Message-ID: <CAJRtX8RZZb1Rq1y-QSheimWgJf0W_bnhe=dGmAeqGNYy+jx6KQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 5:15=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 22/01/2024 16:34:00+0800, Jingbao Qiu wrote:
> > On Mon, Jan 22, 2024 at 4:17=E2=80=AFPM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > On 22/01/2024 16:06:30+0800, Jingbao Qiu wrote:
> > > > Implement the RTC driver for CV1800, which able to provide time ala=
rm
> > > > and calibrate functionality.
> > > >
> > > > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > > > ---
> > > >
> > > > Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB=
6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/
> > >
> > > What is the dependency?
> > >
> >
> > Thank you, this driver requires support from the CLK driver.
> > I will add an explanation in the next version.
> >
> > >
> > > Also, please fix the checkpatch.pl --strict warnings
> >
> > I will use the -- strict option for testing.
> >
> > >
> > > > +/**
> > > > + * cv1800_rtc_32k_coarse_val_calib() - Using an external
> > > > + * clock to coarse calibrate the crystal oscillator
> > > > + * @info: the device of calibrated
> > > > + *
> > > > + * @return 0 on success, or -1 on fail
> > > > + *
> > > > + * This RTC has an independent 32KHz oscillator. However,
> > > > + * the accuracy of this oscillator is easily affected by
> > > > + * external environmental interference,resulting in lower
> > > > + * accuracy than the internal oscillator.Therefore, a 25M
> > > > + * crystal oscillator is used as a reference source to
> > > > + * calibrate the RTC and improve its accuracy.Calibration
> > > > + * is completed through two steps, namely rough calibration
> > > > + * and fine calibration.
> > > > + */
> > > > +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv =
*info)
> > >
> > > This is still not working as well as you think it is. You should
> > > Implement the offset callbacks instead.
> > >
> > I'm sorry, I don't quite understand offset callbacks.
> > Do you mean that this function needs to be executed periodically.
>
> I mean implement read_offset and set_offset here:
> https://elixir.bootlin.com/linux/v6.7/source/include/linux/rtc.h#L67
>

Thank you for your patient reply.
I will do that.

Best regards,
Jingbao Qiu

