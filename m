Return-Path: <linux-kernel+bounces-17412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A87E9824CD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA762873C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED50220E4;
	Fri,  5 Jan 2024 02:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meesLQzg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6011FC8;
	Fri,  5 Jan 2024 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbcebaf9a9so624325a34.3;
        Thu, 04 Jan 2024 18:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704421108; x=1705025908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mN6w+8+DWyXHBYft4EobIXEk7P3kgWhHSa+U1c5/Seo=;
        b=meesLQzgDTQtoNDkaWnRs6NEP7BxTT2xsho8AcIFsEIK5Gi4adtXHlEZ+O71londoA
         vyDE5lkT4kC+MgZgAU+cq+SCc67XAOZq1GZLj/kXRnrgEJNMHxV8+yuKjMLM/d5+T4s3
         rB7qcwqfWyufGOZUgC/W7/LdeGre+RmWy/ynYOnqp19VEZ0nh0RkqXPqfInAcdhRiYnk
         7ANcEJ2Qj7cYgEWwi1SV6/ySjIaRUQh4qw9722SMmfKfLb1akYckSefD17nCJWx0NKPH
         FVso7HHhDtse0FqKzVzuMrxXN4Ryo5w54GvzczcFUrI0Cq/NFCbYpKjsY+JRrDXnoyg1
         +7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704421108; x=1705025908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mN6w+8+DWyXHBYft4EobIXEk7P3kgWhHSa+U1c5/Seo=;
        b=HRnwTw4/XAtDIVjfC5VwvcaTbqMvz59iuIYZvdHAPPO3SG8L07jckWA1pa3dIA62YW
         newCewdL+mGS89Fm8nnTYlb8DL/XwUAj2ummHgwyqKixWNEjdyS0qYbwPRhvrbP28AMx
         HWOtoHOjSyIXZS5Zw2+J5uIYTTKIOVnMUJ5s0FBtcAcVZIXlL/gXl4vZmYqpqcQQkc6C
         cCmGW50yDxUVkBZpn8KKt4w3QewoTEZ/JGaNKBIaVXAC643BPsV1XaQpJKhUSI8Pn//d
         vxULJxTIzCBSQUPhH4sM9uUJX4CaVAB2CjmGFK2MsNLyaHoTwohGQoVkKi9kbIN02Yg1
         SGaA==
X-Gm-Message-State: AOJu0YwPxEIzZ2Gxtdll4Cgff8s5BzIIRxDl/19/bGvOEhlJdiDbWcsf
	iZnjqk8uCaGk2J9ekoI/Vrweaz5txYO8KP6kJHg=
X-Google-Smtp-Source: AGHT+IHJWyf9r5TJpkP0a3FqDaitg0kAQkv3KrqV9Gl/WO04HN84jPbuL3lIVyelTrT5iPvr+v7LrY0bCDaV8vklQrw=
X-Received: by 2002:a05:6870:d99:b0:203:9533:1a26 with SMTP id
 mj25-20020a0568700d9900b0020395331a26mr1552372oab.93.1704421107921; Thu, 04
 Jan 2024 18:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-2-Wenhua.Lin@unisoc.com>
 <CAHp75VfdCHnPovC+LJyVsh=SGTLXDoDowd+0z+0J-wDF2_yjCQ@mail.gmail.com> <CAB9BWhc0WyvMMudKcpuOw3=hqiWrC4e47fri6ywqYojULHnAdQ@mail.gmail.com>
In-Reply-To: <CAB9BWhc0WyvMMudKcpuOw3=hqiWrC4e47fri6ywqYojULHnAdQ@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 5 Jan 2024 10:17:50 +0800
Message-ID: <CAAfSe-t3mj7ngwL_EZkp=YNWVdb1HhHjY6OY_xFWXieBp0vmOQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] gpio: eic-sprd: Keep the clock rtc_1k on
To: wenhua lin <wenhua.lin1994@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Wenhua Lin <Wenhua.Lin@unisoc.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jan 2024 at 10:11, wenhua lin <wenhua.lin1994@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 9:00=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, Jan 4, 2024 at 4:43=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.co=
m> wrote:
> > >
> > > The eic debounce does not have a clock of rtc_1k in the sleep state,
> > > but the eic debounce will be used to wake up the system, therefore th=
e
> > > clock of rtc_1k needs to be kept open.
> >
> > ...
> >
> > > +#define SPRD_EIC_DBNC_FORCE_CLK                0x8000
> >
> > BIT(15) ?
> >
>
> Yes, writing 1 to bit15 of the register can ensure that the clock of
> rtc_1k remains normally on.

Andy's comment means that you should use BIT(15) instead of 0x8000.

>
> > --
> > With Best Regards,
> > Andy Shevchenko

