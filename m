Return-Path: <linux-kernel+bounces-12421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9289981F489
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 05:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A9BF283AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F359A1FAE;
	Thu, 28 Dec 2023 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUYOkLJA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C3137B;
	Thu, 28 Dec 2023 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6dc049c7b58so761796a34.3;
        Wed, 27 Dec 2023 20:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703736757; x=1704341557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIDB5pmbMt1XqUVM4absiYJrqINr+tp7FdZ1i2KQDFY=;
        b=BUYOkLJApiWBuY/tWa/0TY1JtWv2867IHgFWflXXANtoOwcWLkL/HC9z73p7XhyneN
         ESSkJm4IQsjy+diYnmDHoLXfYdPwn1grZoOMBWL8dCukRZw1eRZM2N78yKJOvUM37oBJ
         4hoSGb8uZxoUjvw5HOOuZ7L/2fGNGVi0bTMc8fFHWlADh5B+1LBSq8iabd9TaqnVmJpM
         bX2bNJMxwEsWSbl1znfcXVj1p74eYIQ5ZBHg2vekJKft8yMSiZiYFs740xp+w3lHi44E
         +L/GCWpEePOiyvVeEltNQhabFzMuSFXjvXMitmf41b3/h/0I1vCGx3ZkGYly76Prmx+Q
         VbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703736757; x=1704341557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIDB5pmbMt1XqUVM4absiYJrqINr+tp7FdZ1i2KQDFY=;
        b=o4CCMCtAYAWc502VawL9bCChc7A/XrPNFFu0b9yh85QbKz7tBGPSw+Z3C5517Fbono
         V6rEWS7xX3kFPLwe6AEoNq7ao/kuxunDhKPzBpVP+hAmfayGJvqzVG4G9UiVGAvz2cfb
         KAT8q33tezQTRUhnypLO7j2WO6Z/5IOe+QfujQCZUkemHjwp3seOTk+DiX86yK43Nmt+
         0NE8k5pce79VPov3uMTtrMnODCdJ+1c+fipOXtE5QEuVrSikV0K/KoQ1iRYiwnblN8nP
         TQ3dwbcZKDrjx5S/5zP6gZRCce3AfmHss8kGSIWkmIfj7ycceVDZ2zhCFWFuKk3+ZsPD
         b2dA==
X-Gm-Message-State: AOJu0YxlXSwRWaaE8175abHXg5NxxwC15eNhQe2VWA8ZnVFlDivRXqCB
	FgO/n3nz/S40uA6LtdnOEyolMPE4+Xk9rZgWLJU=
X-Google-Smtp-Source: AGHT+IEPWmJ5aWsQegJvn7MpL85gkKgsj48i09+iA217dPtnUCI4Rzv7DiL2DsPNRR9xuntq6Tatez2xlPjqH/Ntiuo=
X-Received: by 2002:a05:6871:b0c:b0:203:a7fa:5931 with SMTP id
 fq12-20020a0568710b0c00b00203a7fa5931mr11360524oab.30.1703736756517; Wed, 27
 Dec 2023 20:12:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-4-qiujingbao.dlmu@gmail.com> <20231226123743bd2d3f0d@mail.local>
 <CAJRtX8TYP4NUsrWejVywgLpkPk1rMyNVf8xZGZWSTn6dqJJjwA@mail.gmail.com> <202312271350242a208426@mail.local>
In-Reply-To: <202312271350242a208426@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Thu, 28 Dec 2023 12:12:25 +0800
Message-ID: <CAJRtX8Qehq-E+Z9T+fc6r36dtF8ZMNwyqxF3WGOQAmwHZHgLkw@mail.gmail.com>
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

On Wed, Dec 27, 2023 at 9:50=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 27/12/2023 16:03:56+0800, Jingbao Qiu wrote:
> > On Tue, Dec 26, 2023 at 8:37=E2=80=AFPM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > Hello,
> > >
> > > please run checkpatch.pl --strict, there are a few issues.
> > >
> > > On 26/12/2023 18:04:30+0800, Jingbao Qiu wrote:
> > > > +struct cv1800_rtc_priv {
> > > > +     struct rtc_device *rtc_dev;
> > > > +     struct device *dev;
> > > > +     struct regmap *rtc_map;
> > > > +     struct clk *clk;
> > > > +     spinlock_t rtc_lock;
> > >
> > > This lock seems unnecessary, please check
> > >
> >
> > you are right. I will fix it.
> >
> > > > +     int irq;
> > > > +};
> > > > +
> > > > +static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigne=
d int enabled)
> > > > +{
> > > > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > > > +
> > > > +     if (enabled)
> > > > +             regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_=
FUN);
> > > > +     else
> > > > +             regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE=
_FUN);
> > > > +
> > >
> > > This could be:
> > >         regmap_write(info->rtc_map, ALARM_ENABLE, enabled);
> >
> > you are right, i will fix it.
> >
> > >
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wka=
lrm *alrm)
> > > > +{
> > > > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > > > +     unsigned long alarm_time;
> > > > +
> > > > +     alarm_time =3D rtc_tm_to_time64(&alrm->time);
> > > > +
> > > > +     if (alarm_time > SEC_MAX_VAL)
> > > > +             return -EINVAL;
> > >
> > > The core is already checking fr this.
> >
> > Thanks, I will remove it.
> >
> > >
> > > > +
> > > > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> > > > +
> > > > +     udelay(DEALY_TIME_PREPARE);
> > >
> > > Why is this needed?
> >
> > This doesn't seem to require waiting, I will check it.
> >
> > >
> > > > +
> > > > +     regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
> > > > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);
> > >
> > > You must follow alrm->enabled instead of unconditionally enabling the
> > > alarm.
> >
> > ok,i will fix it.
> >
> > >
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > >
> > >
> > > > +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv =
*info)
> > >
> > > Please explain those two calibration functions. I don't think you can
> > > achieve what you want to do.
> >
> > The goal of these two calibration functions is to achieve calibration
> > of RTC time.
> > The code is written according to the data manual.
> >
> > The calibration circuit uses 25MHz crystal clock to sample 32KHz
> > clock. In coarse
> > tune mode, the 25MHz crystal clock samples one 32KHz clock cycle period=
 and
> > report the counting results.
> >
> > the datasheet link:
> > Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV=
1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> > page:195
>
>
> I'm really curious as to why this is calibrated using a 25MHz crystal as
> it may be as imprecise as the 32kHz one. I'm asking because we have an
> interface to get calibration done properly so you can use a precise clock
> like GPS, NTP or PTP. This is what you should probably implement
> instead or on top of it.
>

Thanks, I will communicate with the IC designers later.

> > >
> > > > +}
> > > > +
> > > > +static int cv1800_rtc_read_time(struct device *dev, struct rtc_tim=
e *tm)
> > > > +{
> > > > +     struct cv1800_rtc_priv *info =3D dev_get_drvdata(dev);
> > > > +     unsigned int sec;
> > > > +     unsigned int sec_ro_t;
> > > > +     unsigned long flag;
> > > > +
> > > > +     spin_lock_irqsave(&info->rtc_lock, flag);
> > > > +
> > > > +     regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
> > > > +     regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
> > > > +
> > > > +     if (sec_ro_t > (SET_SEC_CNTR_VAL_UPDATE)) {
> > > > +             sec =3D sec_ro_t;
> > > > +             regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> > > > +             regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_EN=
ABLE_FUN);
> > >
> > > What does this do?
> >
> > the sec_ro_t be considered to have high accuracy after calibration.
> > So every time read the time, update the RTC time.
>
> So why don't you always use sec_ro_t instead of sec?
> Also, why is this done conditionally on a arbitrary value? As it stands,
> it will happen if the date is after 1995-07-09T16:12:48 for no good
> reason.
> This is awful because the alarm is matching SEC_CNTR_VAL with ALARM_TIME
> so if this means the calibration doesn't affect SEC_CNTR_VAL (which I
> seriously doubt), the alarm will end up being imprecise anyway
>

Thanks, I will communicate with the IC designers later.

> > > > +static int cv1800_rtc_probe(struct platform_device *pdev)
> > > > +{
> > > > +     struct cv1800_rtc_priv *rtc;
> > > > +     uint32_t ctrl_val;
> > > > +     int ret;
> > > > +
> > > > +     rtc =3D devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_pri=
v),
> > > > +                        GFP_KERNEL);
> > > > +     if (!rtc)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     rtc->dev =3D &pdev->dev;
> > > > +
> > > > +     rtc->rtc_map =3D syscon_node_to_regmap(rtc->dev->of_node->par=
ent);
> > > > +     if (IS_ERR(rtc->rtc_map))
> > > > +             return PTR_ERR(rtc->rtc_map);
> > > > +
> > > > +     rtc->irq =3D platform_get_irq(pdev, 0);
> > > > +     if (rtc->irq < 0)
> > > > +             return rtc->irq;
> > > > +
> > > > +     ret =3D devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq=
_handler,
> > > > +                            IRQF_TRIGGER_HIGH, "alarm", &pdev->dev=
);
> > > > +     if (ret)
> > > > +             return dev_err_probe(&pdev->dev, ret,
> > > > +                                  "cannot register interrupt handl=
er\n");
> > > > +
> > > > +     rtc->clk =3D devm_clk_get(rtc->dev, NULL);
> > > > +     if (IS_ERR(rtc->clk))
> > > > +             return PTR_ERR(rtc->clk);
> > > > +
> > >
> > > You are going to leak rtc->clk after the next call.
> >
> > I will release him at the appropriate time. And add the remove
> > function to release.
> >
> > >
> > > > +     rtc->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);
> > > > +     if (IS_ERR(rtc->clk))
> > > > +             return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> > > > +                                  "clk not found\n");
> > > > +
> > > > +     platform_set_drvdata(pdev, rtc);
> > > > +
> > > > +     spin_lock_init(&rtc->rtc_lock);
> > > > +
> > > > +     rtc->rtc_dev =3D devm_rtc_device_register(&pdev->dev,
> > > > +                                                             dev_n=
ame(&pdev->dev),
> > > > +                                                             &cv80=
0b_rtc_ops,
> > > > +                                                             THIS_=
MODULE);
> > > > +     if (IS_ERR(rtc->rtc_dev))
> > > > +             return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_dev=
),
> > > > +                                  "can't register rtc device\n");
> > >
> > > Please use devm_rtc_allocate_device and devm_rtc_register_device
> >
> > ok,I will use it.
>
> Also you have to set the RTC range properly.

Thanks,I will fix it.

Best regards,
Jingbao Qiu

>
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

