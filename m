Return-Path: <linux-kernel+bounces-17410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC64824CCF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7144CB22DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF81FD9;
	Fri,  5 Jan 2024 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtzIKr3+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF183C2C;
	Fri,  5 Jan 2024 02:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5451faa3aa7so304416a12.0;
        Thu, 04 Jan 2024 18:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704420846; x=1705025646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIhc/XiXTFib4YoSd7gnfHZK2aRrIl/0V0Y6XDlyDD0=;
        b=WtzIKr3+/ug2feyHKw9bmCZ6HurbvcWIMR/wAbLQXdKjjdxsAZRM9zpd5RU/3AZvUs
         Rvy8CddAgasFn0s0n9Dwpl3cW1/iHoU7TppJKBJCm7s6/aJ0+EHUyHUQEXdv8nvJXzk5
         qiDcGFhoKKgl5J3ZxLTWDSWIItJFDFF4ixp99dhNeEYf125iQopYS1XPZ61JwXKnk7FJ
         CDuP9gUIdu1TTAKF3/UHMaTuKghxX8+h6ie9pVX3tx+5ltnd++qQkbYe9tCt6Mam2+ST
         23blI/xqmcNfLEqytwn6TrfX70tnS/Q4RJw/+6zyc2DVACOSBsY/asYM9n5E8cosF/SD
         rLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704420846; x=1705025646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIhc/XiXTFib4YoSd7gnfHZK2aRrIl/0V0Y6XDlyDD0=;
        b=A7ngn/Kpp0syNeWq5/A30RF08yeoMy7svesM55ZdBtoLx+v+JwkFJaqK51O7c8aOSb
         TQrN5gvBznkj4NPyOfwgaSOhMp5YiJkLEubInDcoview9Hgw4x1IlBT88o5cOfhTkCb2
         Csg08XWSe1qm8CiymLZCouJCMuf0U3XalCR3O0KfTrlNfU200l6bJ8w5eshUdix0mhv7
         CAEU/4jlJV/qSxxITgUTUm9jwOOim0T6O+UwoeblUNNTPsHPpyeoe0nJhtxH/2fH18ix
         eBvRigIn91BZEnagrsEWg07gzDaAi10x4RK0cciWZ9aVAkcuvxCDTQ8d5LbPf4zqQUMz
         q2Aw==
X-Gm-Message-State: AOJu0Yx1UMoeCybFwxuYGmRyGzqmAKu1EW/SLuECEQAMg9mmcTx2UqHf
	c/OXEPbEViHPZn9on7SlwQeK+rwmzGlUjPkof/M=
X-Google-Smtp-Source: AGHT+IHZ/vZn6VylOFCLQfKmmztIP/YvCY8H1OYGyActwuYIw30o6YoGNPqiYAt1sMSVmyCWicnxPUMCOWnh7Z6Ucl4=
X-Received: by 2002:a50:a6d0:0:b0:556:e2b7:c0d9 with SMTP id
 f16-20020a50a6d0000000b00556e2b7c0d9mr1949673edc.2.1704420846473; Thu, 04 Jan
 2024 18:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104024244.12163-1-Wenhua.Lin@unisoc.com> <20240104024244.12163-4-Wenhua.Lin@unisoc.com>
 <CAHp75VcUU-FUYJKN40dzMbe5KmmAR7--0JV00qdgnbNwHqFjQg@mail.gmail.com>
In-Reply-To: <CAHp75VcUU-FUYJKN40dzMbe5KmmAR7--0JV00qdgnbNwHqFjQg@mail.gmail.com>
From: wenhua lin <wenhua.lin1994@gmail.com>
Date: Fri, 5 Jan 2024 10:13:55 +0800
Message-ID: <CAB9BWhdN2V7B8vOqrGr_Gy1q3iu93X27dTvqa2RwnwMQwtotag@mail.gmail.com>
Subject: Re: [PATCH V3 3/4] gpio: eic-sprd: Modify the calculation method of
 eic number
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wenhua Lin <Wenhua.Lin@unisoc.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:01=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Jan 4, 2024 at 4:43=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.com>=
 wrote:
> >
> > When the soc changes, the corresponding gpio-eic-sprd.c
>
> SoC
>

Thank you very much for your review.
I will fix this issue in patch v4.

> > code needs to be modified, and the corresponding
> > Document must also be modified, which is quite troublesome.
> > To avoid modifying the driver file, the number of eics
> > is automatically calculated by matching dts nodes.
>
> --
> With Best Regards,
> Andy Shevchenko

