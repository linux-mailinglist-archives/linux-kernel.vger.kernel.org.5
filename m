Return-Path: <linux-kernel+bounces-151451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6469B8AAF1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31062822C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A9686634;
	Fri, 19 Apr 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmnJbJSd"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB228565E;
	Fri, 19 Apr 2024 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532416; cv=none; b=fugZd+Vdj8numwfdtbwUtC2tLghU5DGGDvDtFjDS7FR8POGBNT+hnsDWuM9wEZ+stMUz9UDv3kkuId4LAG+JizX1PsMW8kEtcVUv4gb5xHehYVCR1rDMpAt0LjdXeX5f7Xp0OB+U1+r7AbeMGYbFpxOwEhN9RXqAwsFtpqPsv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532416; c=relaxed/simple;
	bh=MJ73iTnDL63VDAaoVci/EpuuDDKiIcZS/XQoD41BgO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftLssyOfUmH/zA2RPwYFExzToJGKiRcwedM81dzx28Cw0MGsSaIvmGTv1AdvwzzwXStFEGjMKeCX/KI9GpGVWVj+RiLG5AxjNWQNtssjs3dzeh8JAti9gbnxe4bhn1iKNmJNJDwv+/N/TrsQmJql/TRF5NV/PkpJoZGekiLKt58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmnJbJSd; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2da01cb187cso35517161fa.0;
        Fri, 19 Apr 2024 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713532412; x=1714137212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ73iTnDL63VDAaoVci/EpuuDDKiIcZS/XQoD41BgO0=;
        b=SmnJbJSdI6v9/yvTO3CRSdD6LwFaQFxfHv8Dy2Xdu1o29KV9FpLE0F/m0WT6Ilqyha
         TT0xYCk6tDb3kZ993xljOVqLmV+JyKIlPEl9S0MCMrAnlvxpFB7l/ihxu5dCnixzXnf9
         uIvRF1AFCv1fE9xhDr+sIwoPQW5uBhOLOh258zpg1hzZMOFEDKVoFvCmyL865HR/3wC6
         O42ObIe4WtFDxcXRAguuArf+y2250GnSUr/xj8RrDdEvzeHk8EHuidcyAgZIAxZKmpkj
         V9hd1RsQiWvIz7ukwkWWlc09Gl7idkBaOxH5FpTLl7LoJUT4NXEM3F40ZtGDfyXsybC6
         /3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713532412; x=1714137212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ73iTnDL63VDAaoVci/EpuuDDKiIcZS/XQoD41BgO0=;
        b=ZWz+mR8/R9Fbc88JLuCexcJ+YYWAbdfwfWg7WROX2gCxLfjqPCqqDsoFjRCOLoLIyQ
         abbfmZAX0LhLtvFulLQlSnHbjcFBfygn3r6+SBK20/i44+l3Hz3DMBViWC+0i9c/zlUr
         08t4X/TaZnDWQrDuW4MOPNbaW7FJZzbSj3Do9aKEaX3y7KTHKbmck6BjdW03K+oI5tp6
         f8VEBVFBL4IEXrd2mRx6Z1D8BPAfnafFbwEjMtfKmBs5aZpfBmEBBPwv/223v1Ubhxob
         sTwt0MbruXfS/mLPxroF+PQwzIJJaukn/KXqM74AWvS74aKa0UFnanoXX37Q0yqzHqMF
         9LVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtWXw9aqb3Yc5ol0KPo5zX3qCMxH2XLLPnYVQ67e/uaUQzH0oPhskV7XJQ7mU36Do0oVtot2AUP30BRzH6gYdSgS5HmB90dgPnqniT0nuepO47v3TSqOFa58E1409bEOxSMTwABHd5Sg==
X-Gm-Message-State: AOJu0YxffBp6oE6uSId5fGODi5kiMl26yGALcTfSOBgHCxZglBaYi3Ub
	zBLNGidJUnwwPHTl9DRCYsgf03z+YSBAv4kJA6GZPPMPdceyKiBSAdYZtlkk2IlDRLLUIQnr6vM
	YopgvGj9ofpZ85Jr/TIcyYEdbiHtaaaVC
X-Google-Smtp-Source: AGHT+IG7gfxPubAP9gSOnIjknhFnPUEiFEDKljcZeaFawdJsO8HX2BiSv3dGeybyWDrlIggO9Zs8TBAZwl9Lc6qL9ik=
X-Received: by 2002:a05:651c:a12:b0:2db:817d:834 with SMTP id
 k18-20020a05651c0a1200b002db817d0834mr2198605ljq.10.1713532412340; Fri, 19
 Apr 2024 06:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
In-Reply-To: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 19 Apr 2024 16:12:55 +0300
Message-ID: <CAHp75Ve=TUqba0Ga23QCiP7uM==VzY6kL=3A-5k5WNJAz4gGuA@mail.gmail.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:07=E2=80=AFAM Aapo Vienamo
<aapo.vienamo@linux.intel.com> wrote:
>
> This driver provides a basic GPIO driver for the Intel Granite Rapids-D
> virtual GPIOs. On SoCs with limited physical pins on the package, the
> physical pins controlled by this driver would be exposed on an external
> device such as a BMC or CPLD.
>
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Hmm... How did this happen?

--=20
With Best Regards,
Andy Shevchenko

