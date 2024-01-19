Return-Path: <linux-kernel+bounces-31237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F32832AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A61CD1C20B30
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E053815;
	Fri, 19 Jan 2024 14:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDevurz7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797CF537F8;
	Fri, 19 Jan 2024 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705673273; cv=none; b=X85vx5FHMOXLEzPZqtARaZ3elqnx9ILqvRSB5cE/1dZlzS4F5W1cqTa5qjZQ3t2c0EMPDHzPRjPDFAqBq72sYiY/WWYm5AyQTogaGttsbjci8ftsxkfPqLpZEhSU1hrRbZDNNOecvga+vCnnpN7gqcuWUbCxeFshzwpj0ZhkvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705673273; c=relaxed/simple;
	bh=9gWt20bJrYzN8KUJ3FLlC9ALjS6WuHIP3vCqrGPDA24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcK6WQPVxw24gkqxJTNH5QuJMgrqs7fobtUcEE+GyJdK+IyoR0TJjjm1AzM52KJWCl2JlnLfpdnJ8vrnFol2p1XmCMMZmzWG28/4RKEVrDmhJFy8Kz9gw+bsqcYpRFmA+FIeQYUjLAejjJifgwH6f2iwzYIa4znvSZ20beo8h0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDevurz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC3FC433F1;
	Fri, 19 Jan 2024 14:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705673273;
	bh=9gWt20bJrYzN8KUJ3FLlC9ALjS6WuHIP3vCqrGPDA24=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QDevurz73QpNeCT5uLWPhdRmxJLDNaENLyR4YMoW7Af83PoKClv/8Ce9TecrVLJcG
	 ipiR2tGDMFOi+119skzB89fTgjaLujQXa0c7k4BRhp1QSPWOYoTf3gin6oStYvmK06
	 LS6W/fOzTaZESJ/4wG2XU16tM7itl3oyn5Pe/uzX4Jmn09wbPFZZXufWCZs8QlRNu0
	 zSLyZj6PblCVJDU+khdaCEMYOm3b4zqAytVMvedOiu6ZQR2Fsn0KidSnZ6a1CRXuJK
	 SeDIKnW7GYS09WHXEaLntYogGV5SPH3bvnl3F8BYQba88vUFZ3keXKLvVn2HIvbLwD
	 T1RmnSRKhph6A==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e4e3323a6so2073019e87.0;
        Fri, 19 Jan 2024 06:07:52 -0800 (PST)
X-Gm-Message-State: AOJu0YxHQRnJhDzsir67qf2Tbxr1vXrGlwuizggE4rS6DnqmZ37Rud+R
	mUglJ5WCWa//DT7KShwWDjS2VnkZJfj+BSoKSvW/C1HmEu2yAPGthvIUQTw77vY0luaCi9p+FJ2
	Kx63jwDhr4i+h4KOMQ5e809Y4Uw==
X-Google-Smtp-Source: AGHT+IFM+LBRxDVA1L2DbmI4tWCfgPIDKugjYb0C66a28GKBvSwHPbqRRJcdXjcn8wNjD6mv8KVGjp1WforYWUXcIpo=
X-Received: by 2002:a05:6512:313a:b0:50e:765b:1ea3 with SMTP id
 p26-20020a056512313a00b0050e765b1ea3mr758065lfd.22.1705673271160; Fri, 19 Jan
 2024 06:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211160510.0aef871b@canb.auug.org.au> <20240119115843.5556189a@canb.auug.org.au>
In-Reply-To: <20240119115843.5556189a@canb.auug.org.au>
From: Rob Herring <robh@kernel.org>
Date: Fri, 19 Jan 2024 08:07:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTx9k2Nq130PB9y--dv=Spjs3ELVttTwB4=Tf1s1moCg@mail.gmail.com>
Message-ID: <CAL_JsqLTx9k2Nq130PB9y--dv=Spjs3ELVttTwB4=Tf1s1moCg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the devicetree tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Gross <agross@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 6:58=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
>
> Hi all,
>
> On Mon, 11 Dec 2023 16:05:10 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the devicetree tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/clk/qcom/gcc-x1e80100.c:6786:15: error: variable 'gcc_x1e80100_=
driver' has initializer but incomplete type
> >  6786 | static struct platform_driver gcc_x1e80100_driver =3D {
> >       |               ^~~~~~~~~~~~~~~
> > drivers/clk/qcom/gcc-x1e80100.c:6787:10: error: 'struct platform_driver=
' has no member named 'probe'
> >  6787 |         .probe =3D gcc_x1e80100_probe,
> >       |          ^~~~~
> > drivers/clk/qcom/gcc-x1e80100.c:6787:18: warning: excess elements in st=
ruct initializer
> >  6787 |         .probe =3D gcc_x1e80100_probe,
> >       |                  ^~~~~~~~~~~~~~~~~~
> > drivers/clk/qcom/gcc-x1e80100.c:6787:18: note: (near initialization for=
 'gcc_x1e80100_driver')
> > drivers/clk/qcom/gcc-x1e80100.c:6788:10: error: 'struct platform_driver=
' has no member named 'driver'
> >  6788 |         .driver =3D {
> >       |          ^~~~~~
> > drivers/clk/qcom/gcc-x1e80100.c:6788:19: error: extra brace group at en=
d of initializer
> >  6788 |         .driver =3D {
> >       |                   ^
> > drivers/clk/qcom/gcc-x1e80100.c:6788:19: note: (near initialization for=
 'gcc_x1e80100_driver')
> > drivers/clk/qcom/gcc-x1e80100.c:6788:19: warning: excess elements in st=
ruct initializer
> > drivers/clk/qcom/gcc-x1e80100.c:6788:19: note: (near initialization for=
 'gcc_x1e80100_driver')
> > drivers/clk/qcom/gcc-x1e80100.c: In function 'gcc_x1e80100_init':
> > drivers/clk/qcom/gcc-x1e80100.c:6796:16: error: implicit declaration of=
 function 'platform_driver_register' [-Werror=3Dimplicit-function-declarati=
on]
> >  6796 |         return platform_driver_register(&gcc_x1e80100_driver);
> >       |                ^~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/clk/qcom/gcc-x1e80100.c: In function 'gcc_x1e80100_exit':
> > drivers/clk/qcom/gcc-x1e80100.c:6802:9: error: implicit declaration of =
function 'platform_driver_unregister'; did you mean 'driver_unregister'? [-=
Werror=3Dimplicit-function-declaration]
> >  6802 |         platform_driver_unregister(&gcc_x1e80100_driver);
> >       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >       |         driver_unregister
> > drivers/clk/qcom/gcc-x1e80100.c: At top level:
> > drivers/clk/qcom/gcc-x1e80100.c:6786:31: error: storage size of 'gcc_x1=
e80100_driver' isn't known
> >  6786 | static struct platform_driver gcc_x1e80100_driver =3D {
> >       |                               ^~~~~~~~~~~~~~~~~~~
> >
> > Caused by commit
> >
> >   0d18bcdebb2f ("of: Stop circularly including of_device.h and of_platf=
orm.h")
> >
> > interacting with commit
> >
> >   161b7c401f4b ("clk: qcom: Add Global Clock controller (GCC) driver fo=
r X1E80100")
> >
> > from the qcom tree.
> >
> > I have applied the following merge resolution patch.  This patch could
> > be applied to the gcom tree.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Mon, 11 Dec 2023 15:47:55 +1100
> > Subject: [PATCH] fix up for "of: Stop circularly including of_device.h =
and of_platform.h"
> >
> > interacting with
> > "clk: qcom: Add Global Clock controller (GCC) driver for X1E80100"
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  drivers/clk/qcom/gcc-x1e80100.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/gcc-x1e80100.c b/drivers/clk/qcom/gcc-x1e=
80100.c
> > index 74db7fef237b..d7182d6e9783 100644
> > --- a/drivers/clk/qcom/gcc-x1e80100.c
> > +++ b/drivers/clk/qcom/gcc-x1e80100.c
> > @@ -4,8 +4,9 @@
> >   */
> >
> >  #include <linux/clk-provider.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > -#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/regmap.h>
> >
> >  #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
> > --
> > 2.40.1
>
> Did this get lost somewhere among the merges?  I am still applying the pa=
tch
> to linux-next.

Thanks for pointing that out. I guess the QCom folks never applied it.
I'm going to send the final patch to Linus today and will add this one
in.

Rob

