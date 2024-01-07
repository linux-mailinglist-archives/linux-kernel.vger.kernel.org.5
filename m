Return-Path: <linux-kernel+bounces-18969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 442698265D5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D696F1F2142B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A452111AA;
	Sun,  7 Jan 2024 19:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxQVZ7lE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60511193
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7831f567100so48463085a.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 11:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704656821; x=1705261621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bgw6P5LZhwAlCIvVPfp2eYZqWEaTiqAWQo/dlHlVaXI=;
        b=BxQVZ7lEndiAHfiLse42mznMDyJC3NIey3+yBfNeqavKNKfSEkf/FI0j21yJParchK
         L8Rl+zu1YqmeT5PswMvnRm2BDOSNE2HLtK2KnBrDK7lWqDgN9YWBWlLuDhGlKelSLF9b
         ICGMN9Bu5SO0Y8ja2812JCFQTyf7eUFByBa79HEw/SbbokjJMIU4Qb8eTWxJR23k0F6n
         90NkP+3IbGB0/G32nOP70+Aqere5CsWKoLGhmIecS5pzYtFuQD4eDphR1spQ7ERMfQt6
         NB59ib7nTuxoLad821AJwGpPMkVRSrhHhKvA1Er9CVguVQVX/zqiLk7Xv9PjvHf6Ldn5
         h93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704656821; x=1705261621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bgw6P5LZhwAlCIvVPfp2eYZqWEaTiqAWQo/dlHlVaXI=;
        b=tUyzkbeGKRncubty2RfwthawhLFD6SgY7DQ6p//pUfyUZzHu3/mkQ4YraYLUOJHgbs
         MGXZNq0Hgc8I9u9KsV77abGpoyzoXO268k5cyea2+GEiqFYssSqxXBPdf2P2JTLkxTCP
         bOlZ8M/WVQpOx0ld3oycYVNmupv78RtJLwvS51A19x35OZTJ7i7bwGJ94D/yuI657Uok
         w+tSKwwlzToIQpxJOsMMy2hlHwy1UpXdV+cgbox0KiRZ0no+5N/qz0f2oKClVtk/H82Q
         ExxNaMXgwDhqauFpCJ9xg172G+ihC5S+vE1laUvmvZrGufeJTTK2e7WdFWM3QokUyH4f
         v2Lw==
X-Gm-Message-State: AOJu0YxebzT1GtPWyF6gFNTK+rz/1FxwBJ9Zbnat9x1SH3Z2Jd3TD2Cr
	rFs5fiHy7E9k6bnPNsWrTIomhzDDe/1XqgwV79M=
X-Google-Smtp-Source: AGHT+IGcTlPUiVIo4ImmPte03fF77QlSaouekvVBUc7VviYy4OCu8x8Y2c+1mJTb0YRoNxHun78P8T2uiOmCPPq6Uig=
X-Received: by 2002:a05:6214:2a8e:b0:67f:3991:ef38 with SMTP id
 jr14-20020a0562142a8e00b0067f3991ef38mr4009781qvb.122.1704656821115; Sun, 07
 Jan 2024 11:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401070901.68H00NFa-lkp@intel.com> <CAGb2v64zGvceVXy_F7pVTrFYY7-eLQktoWZB4Xcb1MQtFu=1Ww@mail.gmail.com>
In-Reply-To: <CAGb2v64zGvceVXy_F7pVTrFYY7-eLQktoWZB4Xcb1MQtFu=1Ww@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 7 Jan 2024 21:46:24 +0200
Message-ID: <CAHp75VfiTCCa+Rjn4JavxvSziNmjBTXEgUq-UT+PHkD8__5dhw@mail.gmail.com>
Subject: Re: drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
To: wens@csie.org
Cc: kernel test robot <lkp@intel.com>, Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 7:37=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote:
> On Sun, Jan 7, 2024 at 9:30=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:

...

> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
> >    drivers/iio/adc/axp20x_adc.c:577:26: sparse: sparse: dubious: x & !y
>
> This looks like a false positive. The code is doing exactly what we want:
> val =3D val ? 1 : 0, but in a shorter format.

Yes, but the problem is that FIELD_PREP() is a macro.
You can replace these by ternary (here and in other cases) to satisfy
sparse. Compiler will optimize that anyway, so no branch is expected
in the generated code.

--=20
With Best Regards,
Andy Shevchenko

