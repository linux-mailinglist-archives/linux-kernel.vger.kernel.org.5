Return-Path: <linux-kernel+bounces-12040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3969981EF41
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95A4B2240D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD64501B;
	Wed, 27 Dec 2023 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EbVbkrWh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C1A44C94;
	Wed, 27 Dec 2023 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7DFC01C0002;
	Wed, 27 Dec 2023 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703685027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AogwvIp/TPDnH6K7tDIn6R4ADqS/CwUQt8C+g0y0TLQ=;
	b=EbVbkrWhL7RWv6AsHin0RZoRrBHxtzNNg20eiYIXPT5vVbihMCHfSCCrtQfON8ewrVKEtY
	9NUyFk7Y4nooe5/7a9klPHJYIb7EytnqWl3L9WzfEQdlZGUpMIU1/EdXgjxiC+CPWtF/yL
	2GIwm5Ln2srlnld1cDlawQxSY+Y2i8RLXn24LiiVXK4L9qZ7VcrhPSMEfUmc9pvTpkBXk/
	16yXl7mJgRD3fCyuaYdbtO7Es+DK50pLkOjPhuZxhsu2NmsghFKSHKSrWoAu/GysVv1evb
	/ED759PhiuLkm5NYtY0sQFS0bXB6sxFxAZ677sWADu1VUxgVyq9eXNA10W/JKA==
Date: Wed, 27 Dec 2023 14:50:24 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
	conor+dt@kernel.org, chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org,
	inochiama@outlook.com
Subject: Re: [PATCH v3 3/4] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Message-ID: <202312271350242a208426@mail.local>
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-4-qiujingbao.dlmu@gmail.com>
 <20231226123743bd2d3f0d@mail.local>
 <CAJRtX8TYP4NUsrWejVywgLpkPk1rMyNVf8xZGZWSTn6dqJJjwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJRtX8TYP4NUsrWejVywgLpkPk1rMyNVf8xZGZWSTn6dqJJjwA@mail.gmail.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 27/12/2023 16:03:56+0800, Jingbao Qiu wrote:
> On Tue, Dec 26, 2023 at 8:37 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > Hello,
> >
> > please run checkpatch.pl --strict, there are a few issues.
> >
> > On 26/12/2023 18:04:30+0800, Jingbao Qiu wrote:
> > > +struct cv1800_rtc_priv {
> > > +     struct rtc_device *rtc_dev;
> > > +     struct device *dev;
> > > +     struct regmap *rtc_map;
> > > +     struct clk *clk;
> > > +     spinlock_t rtc_lock;
> >
> > This lock seems unnecessary, please check
> >
> 
> you are right. I will fix it.
> 
> > > +     int irq;
> > > +};
> > > +
> > > +static int cv1800_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +
> > > +     if (enabled)
> > > +             regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);
> > > +     else
> > > +             regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> > > +
> >
> > This could be:
> >         regmap_write(info->rtc_map, ALARM_ENABLE, enabled);
> 
> you are right, i will fix it.
> 
> >
> > > +     return 0;
> > > +}
> > > +
> > > +static int cv1800_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +     unsigned long alarm_time;
> > > +
> > > +     alarm_time = rtc_tm_to_time64(&alrm->time);
> > > +
> > > +     if (alarm_time > SEC_MAX_VAL)
> > > +             return -EINVAL;
> >
> > The core is already checking fr this.
> 
> Thanks, I will remove it.
> 
> >
> > > +
> > > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_DISABLE_FUN);
> > > +
> > > +     udelay(DEALY_TIME_PREPARE);
> >
> > Why is this needed?
> 
> This doesn't seem to require waiting, I will check it.
> 
> >
> > > +
> > > +     regmap_write(info->rtc_map, ALARM_TIME, alarm_time);
> > > +     regmap_write(info->rtc_map, ALARM_ENABLE, REG_ENABLE_FUN);
> >
> > You must follow alrm->enabled instead of unconditionally enabling the
> > alarm.
> 
> ok,i will fix it.
> 
> >
> > > +
> > > +     return 0;
> > > +}
> > > +
> >
> >
> > > +static int cv1800_rtc_32k_coarse_val_calib(struct cv1800_rtc_priv *info)
> >
> > Please explain those two calibration functions. I don't think you can
> > achieve what you want to do.
> 
> The goal of these two calibration functions is to achieve calibration
> of RTC time.
> The code is written according to the data manual.
> 
> The calibration circuit uses 25MHz crystal clock to sample 32KHz
> clock. In coarse
> tune mode, the 25MHz crystal clock samples one 32KHz clock cycle period and
> report the counting results.
> 
> the datasheet link:
> Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> page:195


I'm really curious as to why this is calibrated using a 25MHz crystal as
it may be as imprecise as the 32kHz one. I'm asking because we have an
interface to get calibration done properly so you can use a precise clock
like GPS, NTP or PTP. This is what you should probably implement
instead or on top of it.

> >
> > > +}
> > > +
> > > +static int cv1800_rtc_read_time(struct device *dev, struct rtc_time *tm)
> > > +{
> > > +     struct cv1800_rtc_priv *info = dev_get_drvdata(dev);
> > > +     unsigned int sec;
> > > +     unsigned int sec_ro_t;
> > > +     unsigned long flag;
> > > +
> > > +     spin_lock_irqsave(&info->rtc_lock, flag);
> > > +
> > > +     regmap_read(info->rtc_map, SEC_CNTR_VAL, &sec);
> > > +     regmap_read(info->rtc_map, MACRO_RO_T, &sec_ro_t);
> > > +
> > > +     if (sec_ro_t > (SET_SEC_CNTR_VAL_UPDATE)) {
> > > +             sec = sec_ro_t;
> > > +             regmap_write(info->rtc_map, SET_SEC_CNTR_VAL, sec);
> > > +             regmap_write(info->rtc_map, SET_SEC_CNTR_TRIG, REG_ENABLE_FUN);
> >
> > What does this do?
> 
> the sec_ro_t be considered to have high accuracy after calibration.
> So every time read the time, update the RTC time.

So why don't you always use sec_ro_t instead of sec?
Also, why is this done conditionally on a arbitrary value? As it stands,
it will happen if the date is after 1995-07-09T16:12:48 for no good
reason.
This is awful because the alarm is matching SEC_CNTR_VAL with ALARM_TIME
so if this means the calibration doesn't affect SEC_CNTR_VAL (which I
seriously doubt), the alarm will end up being imprecise anyway

> > > +static int cv1800_rtc_probe(struct platform_device *pdev)
> > > +{
> > > +     struct cv1800_rtc_priv *rtc;
> > > +     uint32_t ctrl_val;
> > > +     int ret;
> > > +
> > > +     rtc = devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_priv),
> > > +                        GFP_KERNEL);
> > > +     if (!rtc)
> > > +             return -ENOMEM;
> > > +
> > > +     rtc->dev = &pdev->dev;
> > > +
> > > +     rtc->rtc_map = syscon_node_to_regmap(rtc->dev->of_node->parent);
> > > +     if (IS_ERR(rtc->rtc_map))
> > > +             return PTR_ERR(rtc->rtc_map);
> > > +
> > > +     rtc->irq = platform_get_irq(pdev, 0);
> > > +     if (rtc->irq < 0)
> > > +             return rtc->irq;
> > > +
> > > +     ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
> > > +                            IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
> > > +     if (ret)
> > > +             return dev_err_probe(&pdev->dev, ret,
> > > +                                  "cannot register interrupt handler\n");
> > > +
> > > +     rtc->clk = devm_clk_get(rtc->dev, NULL);
> > > +     if (IS_ERR(rtc->clk))
> > > +             return PTR_ERR(rtc->clk);
> > > +
> >
> > You are going to leak rtc->clk after the next call.
> 
> I will release him at the appropriate time. And add the remove
> function to release.
> 
> >
> > > +     rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > > +     if (IS_ERR(rtc->clk))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> > > +                                  "clk not found\n");
> > > +
> > > +     platform_set_drvdata(pdev, rtc);
> > > +
> > > +     spin_lock_init(&rtc->rtc_lock);
> > > +
> > > +     rtc->rtc_dev = devm_rtc_device_register(&pdev->dev,
> > > +                                                             dev_name(&pdev->dev),
> > > +                                                             &cv800b_rtc_ops,
> > > +                                                             THIS_MODULE);
> > > +     if (IS_ERR(rtc->rtc_dev))
> > > +             return dev_err_probe(&pdev->dev, PTR_ERR(rtc->rtc_dev),
> > > +                                  "can't register rtc device\n");
> >
> > Please use devm_rtc_allocate_device and devm_rtc_register_device
> 
> ok,I will use it.

Also you have to set the RTC range properly.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

