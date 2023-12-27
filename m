Return-Path: <linux-kernel+bounces-11896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8033981ED20
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE051F2154A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E329B6134;
	Wed, 27 Dec 2023 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFgkyij8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C495680;
	Wed, 27 Dec 2023 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso2195958276.2;
        Wed, 27 Dec 2023 00:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703664247; x=1704269047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7jgnPn3gNG+2IVxyySbgGHtMxlnYyIEv6uOX0IRx+M=;
        b=iFgkyij8Qoxb7lHXRu5sewLXybyqhoTQtdAjXQzF0DfHuNQehqIPFEw5NxwgACHnpQ
         gk/FAU+sniSsFgHIljVhT0gm6ACmVZL0SsjIdgcg8jzPfT3NQKWxy1OAN7BGXZSWOJhH
         4XkN0XtucqgVLNY5322eaXWZFlOwAS60xzwsUfYOFzYsYiN7fc/NXMCCrwBYRwul7rvu
         ZfHLgRHv8EkjSHpOyfifyXoyt+rvyP0tfdL1pOW0MN7VGL8bMOB6c16tVuS0Ja1PMtFd
         LWGp9kXkbnl3akk2TgyBrJvm55IkLQXxXZaDwdIH2aJZkMHNTY67NzOpbhqeXYsOMIl3
         AMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703664247; x=1704269047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7jgnPn3gNG+2IVxyySbgGHtMxlnYyIEv6uOX0IRx+M=;
        b=BV6nikTkDcosbFvsUiAQcHkzkFghkb2rjbm2wqGC6PtlpKvCnX8pKpHWV79tNf++vW
         nkxETQn1cxKR9Ty966O92NIn+xkcF2m4/h3hwLPslFPId6oxMLtz4Z/wAuUZFY41Xtar
         AP6MA1ryj1P75ZRRio046OPv53UtU+CqS4gIwqxjrqGIabd9L8ra8wHEWF/Vt9AE834Y
         IJ5+crrw72o1vJ7QywKyGyA+vc77Z4lio+yRpcW3rNwTksccfUBEE0USk7ZehCiPVpQo
         cbBXZIhBZxl584mdYtYG9yMw6Yv/m49+KZfaEq9jVcSzA3+29a38iOgUrwNJXEbBEz75
         2NTg==
X-Gm-Message-State: AOJu0YzyjVuVas+hcBeWQlgV4m8NZcvc4zojpHD1bKYZpyZVrNS5sHdL
	x8T8Cl36zLiN65z9UsQZUbS1MTsHd1DiMbohzZM=
X-Google-Smtp-Source: AGHT+IHgo1R7XTPY4jNGXR2s3oAhhZVYZUlV6X9wu4bt/GXoDFXlmJ+XY8sQpW/z7bxNZcIzeyrPG2AUEmIhodFYRcY=
X-Received: by 2002:a25:8d90:0:b0:dbd:b8a7:af0a with SMTP id
 o16-20020a258d90000000b00dbdb8a7af0amr2251127ybl.8.1703664247093; Wed, 27 Dec
 2023 00:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-4-qiujingbao.dlmu@gmail.com> <20231226123743bd2d3f0d@mail.local>
In-Reply-To: <20231226123743bd2d3f0d@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 27 Dec 2023 16:03:56 +0800
Message-ID: <CAJRtX8TYP4NUsrWejVywgLpkPk1rMyNVf8xZGZWSTn6dqJJjwA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, conor+dt@kernel.org, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dlan@gentoo.org, 
	inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 8:37=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> please run checkpatch.pl --strict, there are a few issues.
>
> On 26/12/2023 18:04:30+0800, Jingbao Qiu wrote:
> > +struct cv1800_rtc_priv {
> > +     struct rtc_device *rtc_dev;
> > +     struct device *dev;
> > +     struct regmap *rtc_map;
> > +     struct clk *clk;
> > +     spinlock_t rtc_lock;
>
> This lock seems unnecessary, please check
>

you are right. I will fix it.

> > +     int irq;
> > +};
> > +
> > +static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned in=
t enabled)
> > +{
> > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > +
> > +     if (enabled)
> > +             regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN)=
;
> > +     else
> > +             regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN=
);
> > +
>
> This could be:
>         regmap_write(info->rtc_map, ALARM_ENABLE, enabled);

you are right, i will fix it.

>
> > +     return 0;
> > +}
> > +
> > +static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm =
*alrm)
> > +{
> > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > +     unsigned long alarm_time;
> > +
> > +     alarm_time =3D rtc_tm_to_time64(&alrm->time);
> > +
> > +     if (alarm_time > SEC_MAX_VAL)
> > +             return -EINVAL;
>
> The core is already checking fr this.

Thanks, I will remove it.

>
> > +
> > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> > +
> > +     udelay(DEALY_TIME_PREPARE);
>
> Why is this needed?

This doesn't seem to require waiting, I will check it.

>
> > +
> > +     regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
> > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);
>
> You must follow alrm->enabled instead of unconditionally enabling the
> alarm.

ok,i will fix it.

>
> > +
> > +     return 0;
> > +}
> > +
>
>
> > +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv *inf=
o)
>
> Please explain those two calibration functions. I don't think you can
> achieve what you want to do.

The goal of these two calibration functions is to achieve calibration
of RTC time.
The code is written according to the data manual.

The calibration circuit uses 25MHz crystal clock to sample 32KHz
clock. In coarse
tune mode, the 25MHz crystal clock samples one 32KHz clock cycle period and
report the counting results.

the datasheet link:
Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800=
B-CV1801B-Preliminary-Datasheet-full-en.pdf
page:195

>
> > +{
> > +     uint32_t calib_val =3D 0;
> > +     uint32_t coarse_val =3D 0;
> > +     uint32_t time_now =3D 0;
> > +     uint32_t time_next =3D 0;
> > +     uint32_t offset =3D CALIB_OFFSET_INIT;
> > +     uint32_t coarse_timeout =3D REG_INIT_TIMEOUT;
> > +     uint32_t get_val_timeout =3D 0;
> > +
> > +     regmap_write(info->rtc_map, ANA_CALIB, CALIB_INIT_VAL);
> > +
> > +     udelay(DEALY_TIME_PREPARE);
> > +
> > +     /* Select 32K OSC tuning val source from rtc_sys */
> > +     regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
> > +                        (unsigned int)(~SEC_PULSE_GEN_SEL_MASK),
> > +                        (unsigned int)(~SEC_PULSE_SEL_INNER));
> > +
> > +     regmap_read(info->rtc_map, ANA_CALIB, &calib_val);
> > +
> > +     regmap_write(info->rtc_map, FC_COARSE_EN, REG_ENABLE_FUN);
> > +
> > +     while (--coarse_timeout) {
> > +             regmap_read(info->rtc_map, FC_COARSE_CAL, &time_now);
> > +             time_now >>=3D FC_COARSE_CAL_TIME_SHIFT;
> > +
> > +             get_val_timeout =3D REG_INIT_TIMEOUT;
> > +
> > +             while (time_next <=3D time_now &&
> > +                    --get_val_timeout) {
> > +                     regmap_read(info->rtc_map, FC_COARSE_CAL,
> > +                                 &time_next);
> > +                     time_next >>=3D FC_COARSE_CAL_TIME_SHIFT;
> > +                     udelay(DEALY_TIME_LOOP);
> > +             }
> > +
> > +             if (!get_val_timeout)
> > +                     return -1;
> > +
> > +             udelay(DEALY_TIME_PREPARE);
> > +
> > +             regmap_read(info->rtc_map, FC_COARSE_CAL, &coarse_val);
> > +             coarse_val &=3D FC_COARSE_CAL_VAL_MASK;
> > +
> > +             if (coarse_val > CALIB_FC_COARSE_PLUS_OFFSET) {
> > +                     calib_val +=3D offset;
> > +                     offset >>=3D CALIB_OFFSET_SHIFT;
> > +                     regmap_write(info->rtc_map, ANA_CALIB,
> > +                                  calib_val);
> > +             } else if (coarse_val < CALIB_FC_COARSE_SUB_OFFSET) {
> > +                     calib_val -=3D offset;
> > +                     offset >>=3D CALIB_OFFSET_SHIFT;
> > +                     regmap_write(info->rtc_map, ANA_CALIB,
> > +                                  calib_val);
> > +             } else {
> > +                     regmap_write(info->rtc_map, FC_COARSE_EN,
> > +                                  REG_DISABLE_FUN);
> > +                     break;
> > +             }
> > +
> > +             if (offset =3D=3D 0)
> > +                     return -1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int cv1800_rtc_32k_fine_val_calib(struct cv1800_rtc_priv *info)
> > +{
> > +     uint32_t val;
> > +     uint64_t freq =3D CALIB_FREQ;
> > +     uint32_t sec_cnt;
> > +     uint32_t timeout =3D REG_INIT_TIMEOUT;
> > +     uint32_t time_now =3D 0;
> > +     uint32_t time_next =3D 0;
> > +
> > +     regmap_write(info->rtc_map, FC_FINE_EN, REG_ENABLE_FUN);
> > +
> > +     regmap_read(info->rtc_map, FC_FINE_CAL, &time_now);
> > +     time_now >>=3D FC_FINE_CAL_TIME_SHIFT;
> > +
> > +     while (time_next <=3D time_now && --timeout) {
> > +             regmap_read(info->rtc_map, FC_FINE_CAL, &time_next);
> > +             time_next >>=3D FC_FINE_CAL_TIME_SHIFT;
> > +             udelay(DEALY_TIME_LOOP);
> > +     }
> > +
> > +     if (!timeout)
> > +             return -1;
> > +
> > +     regmap_read(info->rtc_map, FC_FINE_CAL, &val);
> > +     val &=3D FC_FINE_CAL_VAL_MASK;
> > +
> > +     do_div(freq, CALIB_FREQ_NS);
> > +     freq =3D freq * CALIB_FRAC_EXT;
> > +     do_div(freq, val);
> > +
> > +     sec_cnt =3D ((do_div(freq, CALIB_FRAC_EXT) * CALIB_FREQ_MULT) /
> > +                        CALIB_FRAC_EXT &
> > +                SEC_PULSE_GEN_INT_MASK) +
> > +               (freq << SEC_PULSE_GEN_FRAC_SHIFT);
> > +
> > +     regmap_write(info->rtc_map, SEC_PULSE_GEN, sec_cnt);
> > +     regmap_write(info->rtc_map, FC_FINE_EN, REG_DISABLE_FUN);
> > +
> > +     return 0;
> > +}
> > +
> > +static void rtc_enable_sec_counter(struct cv1800_rtc_priv *info)
> > +{
> > +     /* select inner sec pulse and select reg set calibration val */
> > +     regmap_update_bits(info->rtc_map, SEC_PULSE_GEN,
> > +                        (unsigned int)(~SEC_PULSE_GEN_SEL_MASK),
> > +                        (unsigned int)(~SEC_PULSE_SEL_INNER));
> > +
> > +     regmap_update_bits(info->rtc_map, ANA_CALIB,
> > +                        (unsigned int)(~CALIB_SEL_FTUNE_MASK),
> > +                        CALIB_SEL_FTUNE_INNER);
> > +
> > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
>
> Don't disable alarms on probe.

thanks,I will fix it.

>
> > +}
> > +
> > +static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *t=
m)
> > +{
> > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > +     unsigned int sec;
> > +     unsigned int sec_ro_t;
> > +     unsigned long flag;
> > +
> > +     spin_lock_irqsave(&info->rtc_lock, flag);
> > +
> > +     regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
> > +     regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
> > +
> > +     if (sec_ro_t > (SET_SEC_CNTR_VAL_UPDATE)) {
> > +             sec =3D sec_ro_t;
> > +             regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> > +             regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE=
_FUN);
>
> What does this do?

the sec_ro_t be considered to have high accuracy after calibration.
So every time read the time, update the RTC time.

>
> > +     }
> > +
> > +     spin_unlock_irqrestore(&info->rtc_lock, flag);
> > +
> > +     rtc_time64_to_tm(sec, tm);
> > +
> > +     return 0;
> > +}
> > +
> > +static int cv1800_rtc_set_time(struct device *dev, struct rtc_time *tm=
)
> > +{
> > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > +     unsigned long sec;
> > +     int ret;
> > +     unsigned long flag;
> > +
> > +     ret =3D rtc_valid_tm(tm);
>
> This is useless, tm will always be valid

ok,i will fix it.

>
> > +     if (ret)
> > +             return ret;
> > +
> > +     sec =3D rtc_tm_to_time64(tm);
> > +
> > +     spin_lock_irqsave(&info->rtc_lock, flag);
> > +
> > +     regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> > +     regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> > +
> > +     regmap_write(info->rtc_map, MACRO_RG_SET_T, sec);
> > +
> > +     spin_unlock_irqrestore(&info->rtc_lock, flag);
> > +
> > +     return 0;
> > +}
> > +
> > +static irqreturn_t cv1800_rtc_irq_handler(int irq, void *dev_id)
> > +{
> > +     struct device *dev =3D dev_id;
> > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > +     struct rtc_wkalrm alrm;
> > +
> > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> > +
> > +     rtc_read_alarm(info->rtc_dev, &alrm);
> > +     alrm.enabled =3D 0;
> > +     rtc_set_alarm(info->rtc_dev, &alrm);
>
> I don't get what you are doing here, you should call rtc_update_irq, not
> mess with alarms that have been set.

Thanks,I will fix it.

>
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static const struct rtc_class_ops cv800b_rtc_ops =3D {
> > +     .read_time =3D cv1800_rtc_read_time,
> > +     .set_time =3D cv1800_rtc_set_time,
> > +     .read_alarm =3D cv1800_rtc_read_alarm,
> > +     .set_alarm =3D cv1800_rtc_set_alarm,
> > +     .alarm_irq_enable =3D cv1800_rtc_alarm_irq_enable,
> > +};
> > +
> > +static int cv1800_rtc_probe(struct platform_device *pdev)
> > +{
> > +     struct cv1800_rtc_priv *rtc;
> > +     uint32_t ctrl_val;
> > +     int ret;
> > +
> > +     rtc =3D devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_priv),
> > +                        GFP_KERNEL);
> > +     if (!rtc)
> > +             return -ENOMEM;
> > +
> > +     rtc->dev =3D &pdev->dev;
> > +
> > +     rtc->rtc_map =3D syscon_node_to_regmap(rtc->dev->of_node->parent)=
;
> > +     if (IS_ERR(rtc->rtc_map))
> > +             return PTR_ERR(rtc->rtc_map);
> > +
> > +     rtc->irq =3D platform_get_irq(pdev, 0);
> > +     if (rtc->irq < 0)
> > +             return rtc->irq;
> > +
> > +     ret =3D devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_han=
dler,
> > +                            IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
> > +     if (ret)
> > +             return dev_err_probe(&pdev->dev, ret,
> > +                                  "cannot register interrupt handler\n=
");
> > +
> > +     rtc->clk =3D devm_clk_get(rtc->dev, NULL);
> > +     if (IS_ERR(rtc->clk))
> > +             return PTR_ERR(rtc->clk);
> > +
>
> You are going to leak rtc->clk after the next call.

I will release him at the appropriate time. And add the remove
function to release.

>
> > +     rtc->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > +     if (IS_ERR(rtc->clk))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> > +                                  "clk not found\n");
> > +
> > +     platform_set_drvdata(pdev, rtc);
> > +
> > +     spin_lock_init(&rtc->rtc_lock);
> > +
> > +     rtc->rtc_dev =3D devm_rtc_device_register(&pdev->dev,
> > +                                                             dev_name(=
&pdev->dev),
> > +                                                             &cv800b_r=
tc_ops,
> > +                                                             THIS_MODU=
LE);
> > +     if (IS_ERR(rtc->rtc_dev))
> > +             return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_dev),
> > +                                  "can't register rtc device\n");
>
> Please use devm_rtc_allocate_device and devm_rtc_register_device

ok,I will use it.

>
> > +
> > +     /* if use internal clk,so coarse calibrate rtc */
> > +     regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
> > +     ctrl_val &=3D CTRL_MODE_MASK;
> > +
> > +     if (ctrl_val =3D=3D CTRL_MODE_OSC32K) {
> > +             ret =3D cv1800_rtc_32k_coarse_val_calib(rtc);
> > +             if (ret)
> > +                     dev_err(&pdev->dev, "failed to coarse RTC val !\n=
");
> > +
> > +             ret =3D cv1800_rtc_32k_fine_val_calib(rtc);
> > +             if (ret)
> > +                     dev_err(&pdev->dev, "failed to fine RTC val !\n")=
;
> > +     }
> > +
> > +     rtc_enable_sec_counter(rtc);
>
> I'm pretty sure you don't want to do that on every probe.

you are right,i will fix it.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id cv1800_dt_ids[] =3D {
> > +     { .compatible =3D "sophgo,cv1800b-rtc" },
> > +     { /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, cv1800_dt_ids);
> > +
> > +static struct platform_driver cv1800_rtc_driver =3D {
> > +     .driver =3D {
> > +                     .name =3D "sophgo-cv800b-rtc",
> > +                     .of_match_table =3D cv1800_dt_ids,
> > +             },
> > +     .probe =3D cv1800_rtc_probe,
> > +};
> > +
> > +module_platform_driver(cv1800_rtc_driver);
> > +MODULE_AUTHOR("Jingbao Qiu");
> > +MODULE_DESCRIPTION("Sophgo cv1800 RTC Driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
> >
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Best regards,
Jingbao Qiu

