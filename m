Return-Path: <linux-kernel+bounces-15489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D0B822CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D39A284DE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2218EB7;
	Wed,  3 Jan 2024 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbE/Jrf9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB0618EA7;
	Wed,  3 Jan 2024 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5451faa3aa7so1790341a12.0;
        Wed, 03 Jan 2024 04:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704283590; x=1704888390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ueRG6BSdXWKUjlFJsTZENszkrZcp/l9zvPLzSkiZ9c=;
        b=WbE/Jrf9WxZlvmNBO0iUEL23iqeSnS8PrL5Ze5YDaQCt9IG4W45dMSkfmd6woDlcLN
         mwXWtjN+prJ/JVs99FPkGJtHQN59oa4iHyVgC/AiavEdPCAM3ESVSwBTOmM8JWSI6z15
         UzoQ0+ILg9vbIfU5IqNoVupwC3f8Iscfk5Wonj/fkx3ASGEVDURW3hHSaKIdd8G/8/XX
         /Gh7aDusnvTXyNQ4L23JMtYfNg53en2lLMSKl6qaFuquZ29H0I8uwEXQHt1FxaT7Pz0l
         njs/1W6+POc+L51bvbzWlBTEc00i2LxlurTOZLdyL3/5E8gevwLkNoruHbezZAOW2Oh4
         sgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704283590; x=1704888390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ueRG6BSdXWKUjlFJsTZENszkrZcp/l9zvPLzSkiZ9c=;
        b=xMeSpduE56lrzZEP+IesJj7NAiVblF7EOkQz2I/0dcvUzfAHnjGML4TPyqGYML7dHe
         0Lo8LOStk3qJwJkV1QbR79ji+bX85RrD1fdL5r2TiYJrYoFLHz2EBdCHNU3b5UCtV65c
         ygYPElgvvuGBJ2TpBuiZgEk+LbJvprP6YAYRyZAHEzmj890kOUHQxGiHj8IcngpPUgQF
         E85g+HD1ok9UehIBOiXxLusXCYy0IebS+goxoKOTN2Nlq5SLDYfkI8twEZNdnE4H4pAD
         SlEBy3g6xwofuHKMpGxArpXhgRJCVjW/31iBttit808YepQL2gEpStC0TFbPwg2+dD+W
         lFuw==
X-Gm-Message-State: AOJu0YywBBGZ25uHAXtukzmLUeUgvMTca3CnR0F1NN/OBmPaafet4SiN
	pf3UdL3PSxC9bfz2pt8GOi70QumFvvx23sTe5Yk=
X-Google-Smtp-Source: AGHT+IGSfPlSHMAx9inskYXFTF2vjqw1N82QCwuFQZp4SY+UlQpbxoKm0+IV2hG+A2/cZB6KYwsx1fx2lrpi4Qeskdo=
X-Received: by 2002:a17:906:2843:b0:a23:30ac:fd13 with SMTP id
 s3-20020a170906284300b00a2330acfd13mr22235099ejc.3.1704283589902; Wed, 03 Jan
 2024 04:06:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230921090027.11136-1-Wenhua.Lin@unisoc.com> <20230921090027.11136-3-Wenhua.Lin@unisoc.com>
 <ZQwn7lEJVfKWtKDx@smile.fi.intel.com>
In-Reply-To: <ZQwn7lEJVfKWtKDx@smile.fi.intel.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Wed, 3 Jan 2024 20:06:18 +0800
Message-ID: <CAB9BWhfa=DZcNibjMCNKLxjbBWnO9qus8+H-AwwX2epjKjDn=w@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] gpio: sprd: Clear interrupt after set the
 interrupt type
To: Andy Shevchenko <andy@kernel.org>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 7:24=E2=80=AFPM Andy Shevchenko <andy@kernel.org> w=
rote:
>
> On Thu, Sep 21, 2023 at 05:00:25PM +0800, Wenhua Lin wrote:
> > The initialization state of the EIC module is a high level trigger.
>
> Here you use EIC, in other places eic. Can you, please, be consistent?

Thank you very much for your review.
I will fix this issue in patch v3.

>
> > If it is currently a high level, the interrupt condition is met at
> > this time, and the EIC interrupt has a latch capability, which will
> > cause an interrupt to occur after booting. To avoid this, When setting
> > the EIC interrupt trigger type, clear the interrupt once.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

