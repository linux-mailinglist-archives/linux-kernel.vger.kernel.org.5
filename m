Return-Path: <linux-kernel+bounces-5703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD567818E54
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5314A1F26900
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB58B374E7;
	Tue, 19 Dec 2023 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Q/2bEyvg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B1431747
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3469B3F2C1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703007598;
	bh=5lC8up460sffE6lEtHTKhMldznfJD/U8bnCN2AOssbw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Q/2bEyvgF5s94CKiZDa8SvGYclCMz/j2EuXkk4C6Z7l2OdvFVUNAUuGiNH8D+rlEz
	 2xAg9ZS4kFFfYMIvnZ/NoV8VYK+ddmyONWjvkvAZoORR3fsCflka4T+el4uqvOnUxA
	 5vU/Bip0Pu7zpIw9jBQWkFXtP5oOnwNso4N8nlagWVXj0OZQZz21G6FP4HjQW1M0wa
	 v7zCC+xVZi6uHMb4m0SiIGsV4Uw8KVGQorSQGvjUMxVFVeqbQq35yyyW0b6NcUynUG
	 TYMvumnuc6V0cbHC3WRRonV4BSvVH0kM4oc58RmyL0ocf+OkChadFnTguPLAkQ379K
	 rpgRCw+0lCn5A==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42780de6a7eso4106671cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007595; x=1703612395;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5lC8up460sffE6lEtHTKhMldznfJD/U8bnCN2AOssbw=;
        b=iY98MYloyrFi9HuKN2MYjAw94bKxFqoRxtg/RmyXRWWQs4174BqAZ5FxSmSH4O0hz/
         TrB12XAKDKuisatqnuHHJAHoc4zwjNjd/uTy/Wp1skdecZFondSAa85C25le4taW1RUp
         GSbH3eEEnqcMAMXmPjnJDy4cJlIZeQb2CDJuWeXmbTlw3Gby+XkR090RDroZsn3cPGlV
         9YxJNzeukaYQUyL/zkhdJOddd+Vi4Pc4a2CzuKMe9IInRjkiyHx3LO5I1HrVO/P7mGt0
         ja647TpNA4K5qGvggwKa8SNXz9M5oARfhLkX/JhGgufvSbohhF9hZczAp0YwTh8amBqd
         zOdQ==
X-Gm-Message-State: AOJu0YxYGkYX3NNSrpHAr7U+o5ml+GD7LcQsu+WH82CY8rHPRbLrYIEm
	snrh58qtQjosXS1J4zzr199dR0DHfha3VMz9P8TVatPAgjH4qUwdu5B/N/uflsm8ByzXKLVn/AI
	btYGzKFnM3GnKdWQHFDEXzqsxTrx7X5Zeu+4xa0QbNgwd/f1rTJAwJ/bkMg==
X-Received: by 2002:a05:622a:19a9:b0:425:a117:90ec with SMTP id u41-20020a05622a19a900b00425a11790ecmr23114927qtc.66.1703007595438;
        Tue, 19 Dec 2023 09:39:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDTi89p4XgTEJbjNfwK+23dRywS9hQShScl1IpS3D4x4FXvIT3lk//qypTp5LCDwvH0SoDqu6Meoi8IDWfUkI=
X-Received: by 2002:a05:622a:19a9:b0:425:a117:90ec with SMTP id
 u41-20020a05622a19a900b00425a11790ecmr23114920qtc.66.1703007595184; Tue, 19
 Dec 2023 09:39:55 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Dec 2023 12:39:54 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <d35d3cf480064c69b1125ba07d615446@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-7-jeeheng.sia@starfivetech.com> <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
 <9ae86c6786bc4ac7b93c971ba00084a6@EXMBX066.cuchost.com> <CAJM55Z9GVFGuwqe=zLXQvBwDfVSz4eA2EXDd4sqWVCKJF2J+fg@mail.gmail.com>
 <d35d3cf480064c69b1125ba07d615446@EXMBX066.cuchost.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue, 19 Dec 2023 12:39:54 -0500
Message-ID: <CAJM55Z_XZVBKr05X4QeCeDO_iMZh-FbKsikcNsDPK7iKuVEodw@mail.gmail.com>
Subject: RE: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator driver
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, "kernel@esmil.dk" <kernel@esmil.dk>, 
	"conor@kernel.org" <conor@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, 
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "mturquette@baylibre.com" <mturquette@baylibre.com>, 
	"sboyd@kernel.org" <sboyd@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, 
	Hal Feng <hal.feng@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Leyfoon Tan <leyfoon.tan@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"

JeeHeng Sia wrote:
>
>
> > -----Original Message-----
> > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > Sent: Wednesday, December 13, 2023 7:57 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>; Emil Renner Berthing <emil.renner.berthing@canonical.com>; kernel@esmil.dk;
> > conor@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; paul.walmsley@sifive.com; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; mturquette@baylibre.com; sboyd@kernel.org; p.zabel@pengutronix.de; Hal Feng
> > <hal.feng@starfivetech.com>; Xingyu Wu <xingyu.wu@starfivetech.com>
> > Cc: linux-riscv@lists.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org; Leyfoon Tan
> > <leyfoon.tan@starfivetech.com>
> > Subject: RE: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator driver
> >
> > JeeHeng Sia wrote:
> > > > -----Original Message-----
> > > > From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> > > > Sent: Saturday, December 9, 2023 12:25 AM
> > > > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>; kernel@esmil.dk; conor@kernel.org; robh+dt@kernel.org;
> > > > krzysztof.kozlowski+dt@linaro.org; paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu;
> > > > mturquette@baylibre.com; sboyd@kernel.org; p.zabel@pengutronix.de; emil.renner.berthing@canonical.com; Hal Feng
> > > > <hal.feng@starfivetech.com>; Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > Cc: linux-riscv@lists.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org; Leyfoon
> > Tan
> > > > <leyfoon.tan@starfivetech.com>
> > > > Subject: Re: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator driver
> > > >
> > > > Sia Jee Heng wrote:
> > > > > Add support for JH8100 System clock generator.
> > > > >
> > > > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > > > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > > > > ---
> > > > >  MAINTAINERS                                   |   8 +
> > > > >  drivers/clk/starfive/Kconfig                  |   9 +
> > > > >  drivers/clk/starfive/Makefile                 |   1 +
> > > > >  drivers/clk/starfive/clk-starfive-common.h    |   9 +-
> > > > >  drivers/clk/starfive/jh8100/Makefile          |   3 +
> > > > >  .../clk/starfive/jh8100/clk-starfive-jh8100.h |  11 +
> > > > >  drivers/clk/starfive/jh8100/clk-sys.c         | 455 ++++++++++++++++++
> > > > >  7 files changed, 495 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 drivers/clk/starfive/jh8100/Makefile
> > > > >  create mode 100644 drivers/clk/starfive/jh8100/clk-starfive-jh8100.h
> > > > >  create mode 100644 drivers/clk/starfive/jh8100/clk-sys.c
> > ...
> > > > > diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> > > > > index 012f7ee83f8e..6cb3ce823330 100644
> > > > > --- a/drivers/clk/starfive/Makefile
> > > > > +++ b/drivers/clk/starfive/Makefile
> > > > > @@ -10,3 +10,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_AON)	+= clk-starfive-jh7110-aon.o
> > > > >  obj-$(CONFIG_CLK_STARFIVE_JH7110_STG)	+= clk-starfive-jh7110-stg.o
> > > > >  obj-$(CONFIG_CLK_STARFIVE_JH7110_ISP)	+= clk-starfive-jh7110-isp.o
> > > > >  obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
> > > > > +obj-$(CONFIG_CLK_STARFIVE_JH8100_SYS)	+= jh8100/
> > > >
> > > > I don't really see why do you need a special subdirectory for the JH8100? The
> > > > JH7110 drivers do fine without it.
> > > Each subfolder can represent a different platform, making it easier to
> > > locate and maintain platform-specific code. Since the code is expected
> > > to grow in the future, let's start organizing it in a folder-based structure
> > > for easier maintenance at a later stage.
> >
> > Yes, but that's not what you're doing here. You're making just one of the 3
> > almost identical drivers be different for no good reason.
> I will restructure it for the other 2 platforms.

That would be less bad, but you still haven't explained why you need to move
everything around like that:
https://lore.kernel.org/linux-riscv/CAJM55Z_3Mty2LftPVkQC1wbwtGeznMMAk9mAjH_GoNuL7CKtaQ@mail.gmail.com/

I don't think just "too many files" is a very good argument here. Just look at
drivers/clk/sunxi

/Emil

