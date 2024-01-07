Return-Path: <linux-kernel+bounces-18787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF36182630B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 06:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1770AB2150A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 05:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F7D125B3;
	Sun,  7 Jan 2024 05:37:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E5125A8
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 05:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28cec7ae594so767604a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 21:37:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704605862; x=1705210662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/Ikl/wsBruZZnJgrPfryZ7WZjdWW20BEXg4XALLfsg=;
        b=r/zz5IkSuTyY7CFM1WXSBnU6wNOZsXTNKdcWUDAFbPOazijWc+CeLTXSnhXalKdPYT
         dwNjKPUz8f2YMMh0m+TmX13JxioJ76+d5d3pcoQ8dbyVqbWYWHnVQ2PNaDaCtSj0jjs/
         dPC5AEHFGpXjSX7RpXwDNPTHY2f+14iFVmYRIKiop0wflVFsJfztWbcAo7VXoqXnuoRw
         xPVav/7+ly7CZ5BzvR6L7q8l4oebpG6gsGjoWZ3SQOnSVG6YQTqGDFIbOpU6hnl/BzdX
         /1aWESoYQhT55xljGEKwkS4mviLuj+8b0tLZL5p/+H34yn9qAMHLhM46z9ejDym9SiVe
         z19Q==
X-Gm-Message-State: AOJu0YyNmk/iSQE+4G3R4oq3jfeTo/QmkGrlaDeXgHDNBcmKIJA22Ng5
	15ED5BbTYmMuADsaHOgk/mWa2jZsE6Y=
X-Google-Smtp-Source: AGHT+IFx5iar9FgEcblVDhKz0xe8PwOxuf92NPEQ+EKmb1C6T70cC1DtqtJfQWum0++GWc92/2I2cQ==
X-Received: by 2002:a05:6a20:4a21:b0:194:f56a:dd96 with SMTP id fr33-20020a056a204a2100b00194f56add96mr1725939pzb.124.1704605861936;
        Sat, 06 Jan 2024 21:37:41 -0800 (PST)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com. [209.85.210.173])
        by smtp.gmail.com with ESMTPSA id z22-20020a62d116000000b006d9cf4b56edsm4094282pfg.175.2024.01.06.21.37.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 21:37:41 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d99980b2e0so745888b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jan 2024 21:37:41 -0800 (PST)
X-Received: by 2002:aa7:9205:0:b0:6da:23d7:3786 with SMTP id
 5-20020aa79205000000b006da23d73786mr1718281pfo.21.1704605861547; Sat, 06 Jan
 2024 21:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401070901.68H00NFa-lkp@intel.com>
In-Reply-To: <202401070901.68H00NFa-lkp@intel.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 7 Jan 2024 13:37:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v64zGvceVXy_F7pVTrFYY7-eLQktoWZB4Xcb1MQtFu=1Ww@mail.gmail.com>
Message-ID: <CAGb2v64zGvceVXy_F7pVTrFYY7-eLQktoWZB4Xcb1MQtFu=1Ww@mail.gmail.com>
Subject: Re: drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
To: kernel test robot <lkp@intel.com>
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 9:30=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   52b1853b080a082ec3749c3a9577f6c71b1d4a90
> commit: 8957e5344353e9cd3f6b1e3004942e35449fa0e8 iio: adc: axp20x_adc: Mi=
nor code cleanups
> date:   10 months ago
> config: x86_64-randconfig-121-20240106 (https://download.01.org/0day-ci/a=
rchive/20240107/202401070901.68H00NFa-lkp@intel.com/config)
> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/l=
lvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240107/202401070901.68H00NFa-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401070901.68H00NFa-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iio/adc/axp20x_adc.c:572:26: sparse: sparse: dubious: x & !y
>    drivers/iio/adc/axp20x_adc.c:577:26: sparse: sparse: dubious: x & !y

This looks like a false positive. The code is doing exactly what we want:
val =3D val ? 1 : 0, but in a shorter format.

ChenYu

>
> vim +572 drivers/iio/adc/axp20x_adc.c
>
>    551
>    552  static int axp20x_write_raw(struct iio_dev *indio_dev,
>    553                              struct iio_chan_spec const *chan, int=
 val, int val2,
>    554                              long mask)
>    555  {
>    556          struct axp20x_adc_iio *info =3D iio_priv(indio_dev);
>    557          unsigned int regmask, regval;
>    558
>    559          /*
>    560           * The AXP20X PMIC allows the user to choose between 0V a=
nd 0.7V offsets
>    561           * for (independently) GPIO0 and GPIO1 when in ADC mode.
>    562           */
>    563          if (mask !=3D IIO_CHAN_INFO_OFFSET)
>    564                  return -EINVAL;
>    565
>    566          if (val !=3D 0 && val !=3D 700000)
>    567                  return -EINVAL;
>    568
>    569          switch (chan->channel) {
>    570          case AXP20X_GPIO0_V:
>    571                  regmask =3D AXP20X_GPIO10_IN_RANGE_GPIO0;
>  > 572                  regval =3D FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO=
0, !!val);
>    573                  break;
>    574
>    575          case AXP20X_GPIO1_V:
>    576                  regmask =3D AXP20X_GPIO10_IN_RANGE_GPIO1;
>    577                  regval =3D FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO=
1, !!val);
>    578                  break;
>    579
>    580          default:
>    581                  return -EINVAL;
>    582          }
>    583
>    584          return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_=
RANGE, regmask, regval);
>    585  }
>    586
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

