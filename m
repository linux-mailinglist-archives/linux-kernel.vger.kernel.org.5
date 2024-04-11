Return-Path: <linux-kernel+bounces-140025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA38A0A90
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AA1B2881C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E496113EFF6;
	Thu, 11 Apr 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1H4B7mv"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEDF13DB87;
	Thu, 11 Apr 2024 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821850; cv=none; b=f0aL+nSsKT16jbuMLzK9ty6hj6GzjkvhonOjVhB2007l704l5sypb5a+RwOBZpcl2AtkVQnIhLe7hubyctJYthNUR+d6KKk+I5VqFM9iLMflTOUCac/fGzlDJpqQZoDDL4zTytoq2oEnxQm59pwsIYE2Lql2xoi5bUuYn0QHgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821850; c=relaxed/simple;
	bh=pdVktPD1yKhN7I+JfwoX3bAIkQMjWyw/MGQ3Z5ejs0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDtr7UZUIjwKZ4F3BQ09IYxt52xqLTBszl/IuV/DS0/n5GRip3dglTNcL9Pv+StE2dM4xM8ipClnee2q4whDOsVfI+jHeLoX2vnS435UdR46cZ/13ft3OFd3hSn/FsC+wkDXBoMuQ70U4QdhcADMrOWGNUMxw3yfIbpMMzraWeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1H4B7mv; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22ed075a629so3253233fac.3;
        Thu, 11 Apr 2024 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712821848; x=1713426648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K1N7MYojLeI98ykv2u1nfElF4/8RvWc4Po+NQoLUVVw=;
        b=T1H4B7mvIDxtqf4VkJ1Mte1y7oUYnYJYEiS0X9glaAu96OtwNgbgmW4aloG19Lx2/F
         NemZR9KJAPu2o7qchLc78Sb+rb7JHOUFrt1sEB0q5P0ltRY935eiOt0PH23o4fdZeQvb
         ZXkLoQwqNd7Tw2S8o/GYP1AvBRg2UTX9Xqza4SZHrY1JDlSK3d3jxqyBByaqz4dHwwh/
         XljgzlIwV6OBuYQ1miia92kcx0ppOMY8tLCnX6rfWNnI1ZGcn2bakzJxhg38+mHy/RxW
         zSTL/uOjqdN1knpo1YewAkS15R27p8BqkliVTKjohnzIQgdmGsRMxu/O0tcAZ4EpFd28
         81bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712821848; x=1713426648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1N7MYojLeI98ykv2u1nfElF4/8RvWc4Po+NQoLUVVw=;
        b=msJe2TicDQ+xnSrhLXfInYbwUyIG+quAfCHXbgmqxELjDeaLUQ48jyczgnDxyWJulz
         7D9N3Z1oNt0eoYnszIPzA2EMX+jwjf+PjWnJebAj5eZyqt0hNPgGp4GgIcbo3O2Gx4l1
         bVzl8ehI82PS6dBDbycsK3zFMdIT8AW6vYNXfPM/V2YIDs0Pbt5roZ8Lq3W1Unz6nX1J
         DYZ6OLV+96yBQn720mae0nHuAeBedFc3NNzseuTgP6vafCc56yPlZZGBalOPXKTjbu2H
         UpMT/MvuMUONpIwXvgTewtUW2ttyXpz3mEGc73zDm4CvGrlH8x01XvgZPLJoaNPRJ7Pr
         dB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUajGbBZCrNuqEBeiA+T2L0eevhIYUwkesdVx5URA6f1yb+eLeuDm1pljLCbBHYHPgl+wpV98YhIsq6htOID0IrgoafDEbwHmwbjTd2dJcN50A20VrPFTcEv7fcXuAuXw8FaGUZ+iJzvIauIVKfbMvN5zTXJ8nrRf2SUTbEcEt+v1Qg/M+dTEMzgq8=
X-Gm-Message-State: AOJu0Yw5bMswWCqR0a5aoX78ggGYIQqUQyUe1CGpwMsJ3GJyo3+X3EUv
	2qMSduy3q1EagQSp/Gy8R0igU67ohJYoHGWDGg2ESk5LjHQ4BCJdZPS5LtQE5mFs93y0WdoIg1e
	WyyIbO0gifzWmxbZgeITD7v9C4j4=
X-Google-Smtp-Source: AGHT+IGMkAAJtDvRmLGqE3O84KzubcqbUdORj7yi/0mwOx+0/MYwJB+MptRR3G6k5wFtj6uNdbUybb4yeh+d+N1r+EE=
X-Received: by 2002:a05:6870:f6a5:b0:233:3085:e55c with SMTP id
 el37-20020a056870f6a500b002333085e55cmr3215251oab.53.1712821847796; Thu, 11
 Apr 2024 00:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404071350.4242-1-linux.amoon@gmail.com> <20240404071350.4242-7-linux.amoon@gmail.com>
 <20240409015352.ocpjbgxrx636jmk4@synopsys.com> <CANAwSgQtfOG9FSygNMsNfgdmxsr-HyvyqaYr=UXE2UC_mxKJQA@mail.gmail.com>
 <20240410232623.6gaupt6t725hhype@synopsys.com>
In-Reply-To: <20240410232623.6gaupt6t725hhype@synopsys.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 11 Apr 2024 13:20:31 +0530
Message-ID: <CANAwSgS-oD86obNUHcjAwfD+3v6VyWidTezwtihJBOC8VWHPjg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] usb: dwc3: exynos: Switch from CONFIG_PM_SLEEP
 guards to pm_sleep_ptr()
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Johan Hovold <johan@kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Thinh,

On Thu, 11 Apr 2024 at 04:56, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
>
> On Wed, Apr 10, 2024, Anand Moon wrote:
> > Hi Thinh,
> >
> > On Tue, 9 Apr 2024 at 07:24, Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> > >
> > > On Thu, Apr 04, 2024, Anand Moon wrote:
> > > > Use the new PM macros for the suspend and resume functions to be
> > > > automatically dropped by the compiler when CONFIG_PM_SLEEP are disabled,
> > > > without having to use #ifdef guards. If CONFIG_PM_SLEEP unused,
> > > > they will simply be discarded by the compiler.
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v2: add __maybe_unused to suspend/resume functions in case CONFIG_PM is
> > > >    disabled.
> > >
> > > The compiler discards the code, yet we still need __maybe_unused?
> > >
> > Earlier version had not added this since but I removed the
> > guard.CONFIG_PM_SLEEP.
> > added __maybe_unused just to safeguard the function.
> >
> > I have tried to build with config by disabling CONFIG_PM and CONFIG_PM_SLEEP
> > but could get the warning compilation by adding flag W=1
> > -Werror=unused-function.
> >
>
> <snip>
>
> >
> > But since these CONFIG_PM and CONFIG_PM_SLEEP cannot be disabled,
> > I am not getting any warning related to these functions.
> >
> > Do you want me to remove __maybe_unused ?
> >
>
> The warning was there as expected. You should to use it along with
> DEFINE_SIMPLE_DEV_PM_OPS(). Let me know if you still see the same
> warning.
>

But the warnings are related to the following macros

#define PTR_IF(cond, ptr) ((cond) ? (ptr) : NULL)

#define pm_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM), (_ptr))
#define pm_sleep_ptr(_ptr) PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), (_ptr))

So if we can disable CONFIG_PM and CONFIG_PM_SLEEP options
the relevant function with the above macro will be set to NULL.
in this case, the compiler will discard the function in SET_SYSTEM_SLEEP_PM_OPS

> BR,
> Thinh

Thanks
-Anand

