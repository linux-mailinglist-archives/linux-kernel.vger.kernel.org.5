Return-Path: <linux-kernel+bounces-14512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AA0821E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD3E8B21FA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FEE1401B;
	Tue,  2 Jan 2024 14:52:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBB1428C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso9495827b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704207133; x=1704811933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8pjdrgOfn17LwehQh5LTsjEMS1V1KEh0t8kBUAgLKU=;
        b=WnZOI4+inKJ+tuYQy6U4/q+ZH5eQXJaqI2KGlFMGBOkkcChqpNPy5Vmab7z77W5nlS
         atd0JSfX4QrOzyVw4lf1TS70g+pyROLOibHS8EcQkRpdeFME4eAdp20sGQZBze+pXcCx
         uvksnl2JC9zXvhHmrhzt/CO96SP7yQbUtx7ZKiToh2iwL8OezBZZo1Wg8TYeklZH1s7l
         DnaFE8Rc1ilCiDK888AReGwILL/mZBN0OTtMkZGAMsIJrXc1W0quYAaCmuAOxNrefJc0
         Gn6qPtvunwS9HmJq+V7f6qQJEZeFQgYZznzOER6w5gPDfY8ow4VgwXO30Hx+tzCjAQ5y
         2SEw==
X-Gm-Message-State: AOJu0YzUY7D9yF1ozaBAKSXo393SjMVkS8pLoeJeiYYOdpf8x7B5GaLK
	L8JlizcaMHOUp/6fMW2RtZBSAAukcFqh4w==
X-Google-Smtp-Source: AGHT+IG75C7kMGvqnFfGi1KBdK0Dhyis3IGi6nqwf19dl6UWe7MIMbSfaioJ/V488+ItnD2GY1jO3w==
X-Received: by 2002:a81:5b8a:0:b0:5d7:1940:f3e9 with SMTP id p132-20020a815b8a000000b005d71940f3e9mr11915203ywb.81.1704207133589;
        Tue, 02 Jan 2024 06:52:13 -0800 (PST)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id o124-20020a817382000000b005e77ca15d73sm12226003ywc.88.2024.01.02.06.52.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 06:52:13 -0800 (PST)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5f3da7ba2bfso3640367b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:52:13 -0800 (PST)
X-Received: by 2002:a81:a006:0:b0:5e7:bbdf:2eb9 with SMTP id
 x6-20020a81a006000000b005e7bbdf2eb9mr11273308ywg.28.1704207132759; Tue, 02
 Jan 2024 06:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b1bc7f4-f83f-413d-9fa9-3ee68577750d@suswa.mountain>
In-Reply-To: <8b1bc7f4-f83f-413d-9fa9-3ee68577750d@suswa.mountain>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jan 2024 15:52:01 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFBFDj0B+1E1Bj3ZOyftg=mi8uwQt2Z2bs2vZbgn5YRw@mail.gmail.com>
Message-ID: <CAMuHMdVFBFDj0B+1E1Bj3ZOyftg=mi8uwQt2Z2bs2vZbgn5YRw@mail.gmail.com>
Subject: Re: drivers/phy/renesas/phy-rcar-gen3-usb2.c:747 rcar_gen3_phy_usb2_probe()
 warn: missing error code 'ret'
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC Shimoda-san,

On Tue, Jan 2, 2024 at 3:03=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   3bd7d748816927202268cb335921f7f68b3ca723
> commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: Add=
 ARCH_RENESAS kconfig option

Wrong commit

Fixes: 441a681b8843474c ("phy: rcar-gen3-usb2: fix implementation for
runtime PM")

> config: riscv-randconfig-r081-20231216 (https://download.01.org/0day-ci/a=
rchive/20231216/202312161021.gOLDl48K-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git =
4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202312161021.gOLDl48K-lkp@intel.com/
>
> smatch warnings:
> drivers/phy/renesas/phy-rcar-gen3-usb2.c:747 rcar_gen3_phy_usb2_probe() w=
arn: missing error code 'ret'
>
> vim +/ret +747 drivers/phy/renesas/phy-rcar-gen3-usb2.c
>
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  652  static int rcar_gen3_phy_usb2_probe(struct platform_devic=
e *pdev)
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  653  {
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  654       const struct rcar_gen3_phy_drv_data *phy_data;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  655       struct device *dev =3D &pdev->dev;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  656       struct rcar_gen3_chan *channel;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  657       struct phy_provider *provider;
> 08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2020-07-17  658       int ret =3D 0, i;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  659
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  660       if (!dev->of_node) {
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  661               dev_err(dev, "This driver needs device tree\=
n");
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  662               return -EINVAL;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  663       }
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  664
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  665       channel =3D devm_kzalloc(dev, sizeof(*channel), GFP_=
KERNEL);
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  666       if (!channel)
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  667               return -ENOMEM;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  668
> 0b5604affbec02 drivers/phy/renesas/phy-rcar-gen3-usb2.c Chunfeng Yun     =
 2020-11-06  669       channel->base =3D devm_platform_ioremap_resource(pde=
v, 0);
> 801a69c787812f drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-03-03  670       if (IS_ERR(channel->base))
> 801a69c787812f drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-03-03  671               return PTR_ERR(channel->base);
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  672
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  673       channel->obint_enable_bits =3D USB2_OBINT_BITS;
> 08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2020-07-17  674       /* get irq number here and request_irq for OTG in ph=
y_init */
> 08b0ad375ca661 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2020-07-17  675       channel->irq =3D platform_get_irq_optional(pdev, 0);
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  676       channel->dr_mode =3D rcar_gen3_get_dr_mode(dev->of_n=
ode);
> 73801b90a38ff1 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2018-09-21  677       if (channel->dr_mode !=3D USB_DR_MODE_UNKNOWN) {
> 7e0540f41332cb drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2017-10-12  678               int ret;
>
> I would delete this "ret" declaration.

Agreed.

>
> 7e0540f41332cb drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2017-10-12  679
> 979b519c7a1bff drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2018-09-21  680               channel->is_otg_channel =3D true;
> 8dde0008ffc9e2 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2018-09-21  681               channel->uses_otg_pins =3D !of_property_read=
_bool(dev->of_node,
> 8dde0008ffc9e2 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2018-09-21  682                                                       "ren=
esas,no-otg-pins");
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  683               channel->extcon =3D devm_extcon_dev_allocate=
(dev,
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  684                                                       rcar=
_gen3_phy_cable);
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  685               if (IS_ERR(channel->extcon))
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  686                       return PTR_ERR(channel->extcon);
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  687
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  688               ret =3D devm_extcon_dev_register(dev, channe=
l->extcon);
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  689               if (ret < 0) {
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  690                       dev_err(dev, "Failed to register ext=
con\n");
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  691                       return ret;
> 2b38543c8db1c7 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-04-29  692               }
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  693       }
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  694
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  695       /*
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  696        * devm_phy_create() will call pm_runtime_enable(&ph=
y->dev);
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  697        * And then, phy-core will manage runtime pm for thi=
s device.
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  698        */
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  699       pm_runtime_enable(dev);
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  700
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  701       phy_data =3D of_device_get_match_data(dev);
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  702       if (!phy_data) {
> 51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li          =
 2020-11-26  703               ret =3D -EINVAL;
> 51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li          =
 2020-11-26  704               goto error;
> 51e339deab1e51 drivers/phy/renesas/phy-rcar-gen3-usb2.c Wang Li          =
 2020-11-26  705       }
> 5d8042e95fd471 drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2019-04-10  706
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  707       channel->soc_no_adp_ctrl =3D phy_data->no_adp_ctrl;
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  708       if (phy_data->no_adp_ctrl)
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  709               channel->obint_enable_bits =3D USB2_OBINT_ID=
CHG_EN;
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  710
> 5c9dc6379f539c drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-06-10  711       mutex_init(&channel->lock);
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  712       for (i =3D 0; i < NUM_OF_PHYS; i++) {
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  713               channel->rphys[i].phy =3D devm_phy_create(de=
v, NULL,
> b0512a6ec0cd6d drivers/phy/renesas/phy-rcar-gen3-usb2.c Biju Das         =
 2021-07-27  714                                                       phy_=
data->phy_usb2_ops);
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  715               if (IS_ERR(channel->rphys[i].phy)) {
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  716                       dev_err(dev, "Failed to create USB2 =
PHY\n");
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  717                       ret =3D PTR_ERR(channel->rphys[i].ph=
y);
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  718                       goto error;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  719               }
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  720               channel->rphys[i].ch =3D channel;
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  721               channel->rphys[i].int_enable_bits =3D rcar_g=
en3_int_enable[i];
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  722               phy_set_drvdata(channel->rphys[i].phy, &chan=
nel->rphys[i]);
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  723       }
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  724
> 6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-03-03  725       channel->vbus =3D devm_regulator_get_optional(dev, "=
vbus");
> 6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-03-03  726       if (IS_ERR(channel->vbus)) {
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  727               if (PTR_ERR(channel->vbus) =3D=3D -EPROBE_DE=
FER) {
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  728                       ret =3D PTR_ERR(channel->vbus);
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  729                       goto error;
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  730               }
> 6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-03-03  731               channel->vbus =3D NULL;
> 6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-03-03  732       }
> 6dcfd7c300bf35 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-03-03  733
> 9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-11-09  734       platform_set_drvdata(pdev, channel);
> 92fec1c27caa7b drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  735       channel->dev =3D dev;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  736
> 549b6b55b00558 drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2019-04-11  737       provider =3D devm_of_phy_provider_register(dev, rcar=
_gen3_phy_usb2_xlate);
> 9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-11-09  738       if (IS_ERR(provider)) {
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  739               dev_err(dev, "Failed to register PHY provide=
r\n");
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  740               ret =3D PTR_ERR(provider);
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  741               goto error;
> 979b519c7a1bff drivers/phy/renesas/phy-rcar-gen3-usb2.c Yoshihiro Shimoda=
 2018-09-21  742       } else if (channel->is_otg_channel) {
> 9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-11-09  743               int ret;
>
> Shadow ret declaration.
>
> 9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-11-09  744
> 9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-11-09  745               ret =3D device_create_file(dev, &dev_attr_ro=
le);
> 9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-11-09  746               if (ret < 0)
>
> The "ret" here is the shadow ret so we end up returning success.

Oops...

>
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14 @747                       goto error;
> 9bb86777fb71ee drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2016-11-09  748       }
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  749
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  750       return 0;
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  751
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  752  error:
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  753       pm_runtime_disable(dev);
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  754
> 441a681b884347 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2017-03-14  755       return ret;
> f3b5a8d9b50d71 drivers/phy/phy-rcar-gen3-usb2.c         Yoshihiro Shimoda=
 2015-11-30  756  }
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

