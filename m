Return-Path: <linux-kernel+bounces-92144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74A871BD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6CA1C222A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F95FDBF;
	Tue,  5 Mar 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGa2lGb+"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9B55C19;
	Tue,  5 Mar 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634332; cv=none; b=l+1S8JPC6qMVmrJ4tAAWfM+qWlKoE9EZNG07u8WJYUGFdzWtAGQGr0PSGbEbMIqOndOpM+f6Zrx9pISQcVv2DIh8itn+eLW873p2W23+UyZM4JYM65rVM2Qm5tO0DbKQTQYnV4CewJ/AT/HLfCXJrxzCqfJd6NPxg5hhDiOvAHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634332; c=relaxed/simple;
	bh=SjhADbm31WCgg6St2mXAShFyK7e/J2n4wBaKkO50B5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIp5lypeJw0jC859xKIMWO88OTScD6nBjJOkPCHDetJCJDPfCJxXowBOZxLSqr1N5TUXeLSS79ptGE8vnzmdfwEkCX1whBpRcvmNNVYcgQcSrnZWfhtFFFz1PY5YOrjNcmx7hkIQHROshkVV9AsmzThvuOKUx3kUkoZEVGyjOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGa2lGb+; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e45ef83c54so3962270a34.2;
        Tue, 05 Mar 2024 02:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709634329; x=1710239129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/P6EOld/8atZ8J35jL+Sd94PlRi8u9nRna5twwVcEc=;
        b=PGa2lGb+tSnLK1Z7LpLRppGE4tZfrxf0q3HchLkZMHFilifhwirBo1c9f2biCMMUj7
         ZZkd6rjs8/AZBuEUS/RKkHo/G4p/o9sCDKiqqrM170U4I6jsujU9/d5ZWNLhyE9IVeRR
         4yG2eC5ftOrEKdX925022IHVG793/ULNx7QReq/NONyaFZtjRyaMrigInicke0/jObBp
         qrWAERllq/tV1WhHepVqNgNN2MZSMNaseg/xqost98Paih51f4V+nqFgs6G+9Y/9ECmo
         6QJ5TbvgN/0mFknRPgEcmIkQu306Pdfc6OsbPAEm6We07+qjIBTqqbK2xLCcNjVNsI6D
         CfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634329; x=1710239129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/P6EOld/8atZ8J35jL+Sd94PlRi8u9nRna5twwVcEc=;
        b=nGjq/+3cHW96TfRH0cPdn+trI+C06vV5+HWLFddUdyV1r0vwM6WreK/uOkkcqytN7G
         JDPv1OUs2IOS+1rcm/fS+AB5R3NmN4ETzYQgf1wOUiCMv/IJXze7yE4H1sbbtAiv0EdP
         hSjXE0Q6ji89hP+ANDh22guapv+vQzNDP8VNhsjJjTkA0Ie8vKBatpX9QVZEzADj7MRE
         N6XVB/S2EAbvVZqXRemFA0Z+d/uOtbKl0H4V/gRm4CUIvo5TxGIy1A7uXztW5os+A8cI
         9Mpr4/N0Ip4S2YfPgOGM2gYCWEjcpXmyj2jIl4SckIn+CyVdT8j9r5EcLAN4Of00dHi2
         jO6w==
X-Forwarded-Encrypted: i=1; AJvYcCVDfaeI0y1y15rVstwdp2QZMcb07uEOeHjELOquSeHbweBjyh1olC+hRrHc0e1LLY49iIpSQS7M/FfpDHke4NBsfn+2RqBXce75HPiXiXA9o/qqDA6LHKFcU+1RmSrfJqS5g9OjQzyq/Q==
X-Gm-Message-State: AOJu0YyvCDso99Q/F1UmbTH7cTg+6qLcxJ4tKBtKvSDSR1Wb63TCOrEV
	huhTF2QznB3hcyMq5v9HYL/l4XwxAWi3yxJTlwWrE4S6r8zw0FR8OwGH97ejBc+CPq7IQG9l+sC
	9Pm7na+wWp2AOdRYllyKV7MeJDKs=
X-Google-Smtp-Source: AGHT+IFP6yQfqqNonKf1HAqzStHiDcGqenkCKAwv4Ys0lRcf+bFtyA4/M6FTW5Dd7+RNv7YtgFJUellWwH8pCRB1FCM=
X-Received: by 2002:a9d:7850:0:b0:6e4:e4d3:3035 with SMTP id
 c16-20020a9d7850000000b006e4e4d33035mr1527573otm.5.1709634329536; Tue, 05 Mar
 2024 02:25:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204044143.415915-1-qiujingbao.dlmu@gmail.com> <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
In-Reply-To: <20240204044143.415915-3-qiujingbao.dlmu@gmail.com>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 5 Mar 2024 18:25:18 +0800
Message-ID: <CAJRtX8Tdgid14dh7sAxABFkQm74ymaLdk-dN=VZriUnCHKDkow@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

Gentle ping!

On Sun, Feb 4, 2024 at 12:41=E2=80=AFPM Jingbao Qiu <qiujingbao.dlmu@gmail.=
com> wrote:
>
> Implement the RTC driver for CV1800, which able to provide time alarm.
>
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
>  drivers/rtc/Kconfig      |  10 ++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-cv1800.c | 244 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/rtc/rtc-cv1800.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index e37a4341f442..3c6ed45a3b03 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1128,6 +1128,16 @@ config RTC_DRV_DS2404
>           This driver can also be built as a module. If so, the module
>           will be called rtc-ds2404.
>
> +config RTC_DRV_CV1800
> +       tristate "Sophgo CV1800 RTC"
> +       depends on ARCH_SOPHGO || COMPILE_TEST
> +       help
> +         If you say yes here you get support the RTC driver
> +         for Sophgo CV1800 chip.
> +
> +         This driver can also be built as a module.If so, the
> +         module will be called rtc-cv1800.
> +
>  config RTC_DRV_DA9052
>         tristate "Dialog DA9052/DA9053 RTC"
>         depends on PMIC_DA9052
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index 6efff381c484..4efdd2d1e963 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_RTC_DRV_CADENCE) +=3D rtc-cadence.o
>  obj-$(CONFIG_RTC_DRV_CMOS)     +=3D rtc-cmos.o
>  obj-$(CONFIG_RTC_DRV_CPCAP)    +=3D rtc-cpcap.o
>  obj-$(CONFIG_RTC_DRV_CROS_EC)  +=3D rtc-cros-ec.o
> +obj-$(CONFIG_RTC_DRV_CV1800)   +=3D rtc-cv1800.o
>  obj-$(CONFIG_RTC_DRV_DA9052)   +=3D rtc-da9052.o
>  obj-$(CONFIG_RTC_DRV_DA9055)   +=3D rtc-da9055.o
>  obj-$(CONFIG_RTC_DRV_DA9063)   +=3D rtc-da9063.o
> diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
> new file mode 100644
> index 000000000000..60a7192659f5
> --- /dev/null
> +++ b/drivers/rtc/rtc-cv1800.c
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
> + *
> + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +
> +#define CTRL                   0x08
> +#define ANA_CALIB              0x1000
> +#define SEC_PULSE_GEN          0x1004
> +#define ALARM_TIME             0x1008
> +#define ALARM_ENABLE           0x100C
> +#define SET_SEC_CNTR_VAL       0x1010
> +#define SET_SEC_CNTR_TRIG      0x1014
> +#define SEC_CNTR_VAL           0x1018
> +#define APB_RDATA_SEL          0x103C
> +#define POR_DB_MAGIC_KEY       0x1068
> +#define EN_PWR_WAKEUP          0x10BC
> +
> +/*
> + * When in VDDBKUP domain, this MACRO register
> + * does not power down
> + */
> +#define MACRO_DA_CLEAR_ALL     0x1480
> +#define MACRO_DA_SOC_READY     0x148C
> +#define MACRO_RO_T             0x14A8
> +#define MACRO_RG_SET_T         0x1498
> +
> +#define CTRL_MODE_MASK         BIT(10)
> +#define CTRL_MODE_OSC32K       0x00UL
> +#define CTRL_MODE_XTAL32K      BIT(0)
> +#define REG_ENABLE_FUN         BIT(0)
> +#define REG_DISABLE_FUN        0x00UL
> +#define ALARM_ENABLE_MASK      BIT(0)
> +#define SET_SEC_CNTR_VAL_INIT  (BIT(28) || BIT(29))
> +#define SEC_PULSE_SEL_INNER    BIT(31)
> +#define SEC_PULSE_GEN_SEL_MASK GENMASK(30, 0)
> +#define CALIB_SEL_FTUNE_MASK   GENMASK(30, 0)
> +#define CALIB_SEL_FTUNE_INNER  0x00UL
> +
> +struct cv1800_rtc_priv {
> +       struct rtc_device *rtc_dev;
> +       struct regmap *rtc_map;
> +       struct clk *clk;
> +       int irq;
> +};
> +
> +static const struct regmap_config cv1800_rtc_regmap_config =3D {
> +       .reg_bits =3D 32,
> +       .val_bits =3D 32,
> +       .reg_stride =3D 4,
> +};
> +
> +static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int =
enabled)
> +{
> +       struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> +
> +       regmap_write(info->rtc_map, ALARM_ENABLE, enabled);
> +
> +       return 0;
> +}
> +
> +static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *a=
lrm)
> +{
> +       struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> +       unsigned long alarm_time;
> +
> +       alarm_time =3D rtc_tm_to_time64(&alrm->time);
> +
> +       cv1800_rtc_alarm_irq_enable(dev, REG_DISABLE_FUN);
> +
> +       regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
> +
> +       cv1800_rtc_alarm_irq_enable(dev, alrm->enabled);
> +
> +       return 0;
> +}
> +
> +static int cv1800_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *=
alarm)
> +{
> +       struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> +       u32 enabled;
> +       u32 time;
> +
> +       regmap_read(info->rtc_map, ALARM_ENABLE, &enabled);
> +
> +       alarm->enabled =3D enabled & ALARM_ENABLE_MASK;
> +
> +       regmap_read(info->rtc_map, ALARM_TIME, &time);
> +
> +       rtc_time64_to_tm(time, &alarm->time);
> +
> +       return 0;
> +}
> +
> +static void rtc_enable_sec_counter(struct cv1800_rtc_priv *info)
> +{
> +       u32 sec_ro_t;
> +       u32 sec;
> +
> +       /* select inner sec pulse */
> +       regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
> +                          (u32)(~SEC_PULSE_GEN_SEL_MASK),
> +                          (u32)(~SEC_PULSE_SEL_INNER));
> +
> +       regmap_update_bits(info->rtc_map, ANA_CALIB,
> +                          (u32)(~CALIB_SEL_FTUNE_MASK),
> +                          CALIB_SEL_FTUNE_INNER);
> +
> +       sec =3D SET_SEC_CNTR_VAL_INIT;
> +
> +       /* load from MACRO register */
> +       regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
> +       if (sec_ro_t > (SET_SEC_CNTR_VAL_INIT))
> +               sec =3D sec_ro_t;
> +
> +       regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> +       regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> +}
> +
> +static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> +       u32 sec;
> +
> +       regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
> +
> +       rtc_time64_to_tm(sec, tm);
> +
> +       return 0;
> +}
> +
> +static int cv1800_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +       struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> +       unsigned long sec;
> +
> +       sec =3D rtc_tm_to_time64(tm);
> +
> +       regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> +       regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> +
> +       regmap_write(info->rtc_map, MACRO_RG_SET_T, sec);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
> +{
> +       struct rtc_device *rtc =3D dev_id;
> +
> +       rtc_update_irq(rtc, 1, RTC_IRQF | RTC_AF);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static const struct rtc_class_ops cv1800_rtc_ops =3D {
> +       .read_time =3D cv1800_rtc_read_time,
> +       .set_time =3D cv1800_rtc_set_time,
> +       .read_alarm =3D cv1800_rtc_read_alarm,
> +       .set_alarm =3D cv1800_rtc_set_alarm,
> +       .alarm_irq_enable =3D cv1800_rtc_alarm_irq_enable,
> +};
> +
> +static int cv1800_rtc_probe(struct platform_device *pdev)
> +{
> +       struct cv1800_rtc_priv *rtc;
> +       u32 ctrl_val;
> +       void __iomem *base;
> +       int ret;
> +
> +       rtc =3D devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
> +       if (!rtc)
> +               return -ENOMEM;
> +
> +       base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       rtc->rtc_map =3D devm_regmap_init_mmio(&pdev->dev, base,
> +                                            &cv1800_rtc_regmap_config);
> +       if (IS_ERR(rtc->rtc_map))
> +               return PTR_ERR(rtc->rtc_map);
> +
> +       rtc->irq =3D platform_get_irq(pdev, 0);
> +       if (rtc->irq < 0)
> +               return rtc->irq;
> +
> +       ret =3D devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_han=
dler,
> +                              IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
> +       if (ret)
> +               return dev_err_probe(&pdev->dev, ret,
> +                                    "cannot register interrupt handler\n=
");
> +
> +       rtc->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> +       if (IS_ERR(rtc->clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> +                                    "clk not found\n");
> +
> +       rtc->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
> +       if (IS_ERR(rtc->rtc_dev))
> +               return PTR_ERR(rtc->rtc_dev);
> +
> +       platform_set_drvdata(pdev, rtc);
> +
> +       rtc->rtc_dev->ops =3D &cv1800_rtc_ops;
> +       rtc->rtc_dev->range_max =3D U32_MAX;
> +
> +       regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
> +       ctrl_val &=3D CTRL_MODE_MASK;
> +
> +       if (ctrl_val =3D=3D CTRL_MODE_OSC32K)
> +               rtc_enable_sec_counter(rtc);
> +
> +       return devm_rtc_register_device(rtc->rtc_dev);
> +}
> +
> +static const struct of_device_id cv1800_dt_ids[] =3D {
> +       { .compatible =3D "sophgo,cv1800-rtc" },
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
> +
> +static struct platform_driver cv1800_rtc_driver =3D {
> +       .driver =3D {
> +               .name =3D "sophgo-cv1800-rtc",
> +               .of_match_table =3D cv1800_dt_ids,
> +       },
> +       .probe =3D cv1800_rtc_probe,
> +};
> +
> +module_platform_driver(cv1800_rtc_driver);
> +MODULE_AUTHOR("Jingbao Qiu");
> +MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
>

