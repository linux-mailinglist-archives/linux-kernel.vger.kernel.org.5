Return-Path: <linux-kernel+bounces-91997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEC871986
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85F128193D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FDD52F81;
	Tue,  5 Mar 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHImajwr"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB250272;
	Tue,  5 Mar 2024 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630684; cv=none; b=u8lauUEldPa7q61MADobxRanFGB116TRX/58ssU39g8C5Z85Fn3IMXS2MtRxIGehd2/yE+4kHEZBq9oAFTfLIYKIAwGh9NDWdz+Zv6wNObp5VQwTGm7yqdbVC4hCpdDvKvE72JwhDuimhvKT1/u7SuC7QKNAP2Km1RBuUFWHVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630684; c=relaxed/simple;
	bh=tPfQYkjbgATtz+kEhN3abAcfDDsv0QHzHdZUDzvbn1s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NTneupFy0tnApcUlJjJ+GIGP6W5ZY42BKLYCCShdXY3khDgWs1PzG9kb128r1y0UBnG0KrX/Ty5UjHMVzBm/jyd7+e3s/84YblYOjFfqm4TDDjyI5WOBqBxRczRVw/if4n8GmRr9oHRX+kq9nefZ4KOphw/NY5OhPVMzzzx5QRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHImajwr; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4b34f2455so2961472a34.2;
        Tue, 05 Mar 2024 01:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709630682; x=1710235482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2n6XxnRJcK3S7HaVQoAKao47crHz+00Pci1WifCRN34=;
        b=IHImajwr3tDZAeDJSS59h9INfwOrvNmxSrX0JJKXrkk4EZFNJC+VVRvYyM/C15B+CV
         DK2DiTy7J88ETFUMaitJx9A8EPWX9MoKx7RxclO+5RPfhadT7T2PUL7L58TByZh/h0nc
         rB0iB4gmwUM75le4UFJPnn0eq5TTAOOkF9uu0tK7Vm3/UWIvYO5Qk5THTg5Aftgamq79
         uZUOOG6v/ZJjOMFFpC+mWcgI0VsrySNkpJufNTIdPG7R166Lc3R9bKt5T0Np81UIH4mG
         yj1kU5GjNe5bru0F65QzIYZmRUDJmrP/4K9SDNiCvD30MRmOPmwqDu6OFPVDAhnVHBXX
         clNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630682; x=1710235482;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2n6XxnRJcK3S7HaVQoAKao47crHz+00Pci1WifCRN34=;
        b=OrG1f2U8Io9kzJ0nFIMb/zTBaFIZOdsnwp4qgWV6co2+rD9H2EzxU8B1wgxDSNmeQM
         p2nIAaCgkIl0ziCT3IeHkyMToUQgph5h/FuyyARsP3ZzzhWKJ9bAeIfP7CEqghYTUpSH
         trCshXOHLUeR7ClaF6f9VMK8D5VyQD0lyXxWG3BkqqvXTHJWxZ8zZJiDR1fasTfCNZLm
         LAxhOgeTkUhGaAo+Z3Zd6UDi7ZxGbYurNFI71IVXd25Ydr+HhwIoEljgPCeRYJC4TNWJ
         HnYLFhkwJLBcjS+BOmjOOtG68wEuF0WgFEXlJC0G4DPELknFlw5jucNbQrNv6P7WjnJd
         HMvA==
X-Forwarded-Encrypted: i=1; AJvYcCXzUmNTMtVP+nOAVnGZCSP15HPcv402sRpqtHKrbr7R6YB6bcmhOMC7umQjmmAYCI31V9vulGlbiKI88v7ecgdnFE9UKUgnKQ2HsXa7LJ8XVoQBbu16Jll1TqijSegbZpqVahXg4qMK
X-Gm-Message-State: AOJu0YxG9YgOC1L/COTL4e2TEwQ1qwIVFQbse64ew1YTN2yVue6wX4lc
	rDVGBw0FPqGa32r5xf1UmLAxs9teX6epgw8NoXvtph6HiS9pPTnn
X-Google-Smtp-Source: AGHT+IEf3Th5yXrUurmy310rbfGfsm6zvHyKT8USnhxeMIOTIZ0B8RtQzE21FA69Y+hhaHydWopuag==
X-Received: by 2002:a9d:6944:0:b0:6e4:fa1a:dae2 with SMTP id p4-20020a9d6944000000b006e4fa1adae2mr516840oto.2.1709630682163;
        Tue, 05 Mar 2024 01:24:42 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:863:befc:ec5c:8cb:6f1e:1f69])
        by smtp.gmail.com with ESMTPSA id f4-20020a63de04000000b005dc4ce8d2a4sm8717493pgg.58.2024.03.05.01.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 01:24:41 -0800 (PST)
Message-ID: <65e6e4d9.630a0220.8d898.19f4@mx.google.com>
X-Google-Original-Message-ID: <d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net> (raw)
From: pratikmanvar09@gmail.com
To: wahrenst@gmx.net
Cc: festevam@gmail.com,
	jun.li@nxp.com,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	pratik.manvar@ifm.com,
	pratikmanvar09@gmail.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de,
	xiaoning.wang@nxp.com
Subject: Re: [PATCH v2] pwm: imx27: workaround of the pwm output bug
Date: Tue,  5 Mar 2024 14:54:28 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <65bf307d.170a0220.4d544.f32b@mx.google.com>
References: <d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Stefan,=0D
=0D
Sorry for the abysmal delay.=0D
Thanks for your review and suggestions.=0D
=0D
>Hi Pratik,=0D
>=0D
>Am 04.02.24 um 07:36 schrieb pratikmanvar09@gmail.com:=0D
>> Hi Stefan,=0D
>>=0D
>> Thanks for your review.=0D
>> Please see my reply below inline.=0D
>>=0D
>>>> From: Clark Wang <xiaoning.wang@nxp.com>=0D
>>>>=0D
>>>> This fixes the pwm output bug when decrease the duty cycle.=0D
>>>> This is a limited workaround for the PWM IP issue TKT0577206.=0D
>>> this looks like a patch from the vendor tree.=0D
>> [Pratik]: Yes, this is the patch from NXP. Please see original link of t=
he patch https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0=
e5a479990507816317=0D
>>=0D
>>> Could you please provide a link to the origin or at least to the=0D
>>> document which describes TKT0577206?=0D
>> [Pratik]: Please refer i.MX8MN errata #ERR051198 in https://www.nxp.com/=
docs/en/errata/IMX8MN_0N14Y.pdf.=0D
>Thanks, i think this ERR... reference is better than TKT... because it's=0D
>links to the errata documents and other Freescale/NXP drivers use them=0D
>too. So having this code in a comment would be great.=0D
Sure, I will mention this #ERR051198 code in commit message.=0D
>>=0D
>>> As a i.MX6ULL user i couldn't find this issue in the chip errata. So ar=
e=0D
>>> you sure that every PWM IP handled by this driver is affected?=0D
>> [Pratik]: Yes, looks like this issue is on all platforms which uses this=
 PWM IP.=0D
>>=0D
>>>> Root cause:=0D
>>>> When the SAR FIFO is empty, the new write value will be directly appli=
ed=0D
>>>> to SAR even the current period is not over.=0D
>>>> If the new SAR value is less than the old one, and the counter is=0D
>>>> greater than the new SAR value, the current period will not filp the=0D
>>> s/filp/flip/ ?=0D
>>>> level. This will result in a pulse with a duty cycle of 100%.=0D
>>>>=0D
>>>> Workaround:=0D
>>>> Add an old value SAR write before updating the new duty cycle to SAR.=
=0D
>>>> This will keep the new value is always in a not empty fifo, and can be=
=0D
>>>> wait to update after a period finished.=0D
>>>>=0D
>>>> Limitation:=0D
>>>> This workaround can only solve this issue when the PWM period is longe=
r=0D
>>>> than 2us(or <500KHz).=0D
>>>>=0D
>>>> Reviewed-by: Jun Li <jun.li@nxp.com>=0D
>>>> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>=0D
>>>> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbab=
a0e5a479990507816317=0D
>>>> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>=0D
>>>> ---=0D
>>>>    V1 -> V2: fix sparse warnings reported-by: kernel test robot <lkp@i=
ntel.com>=0D
>>>>              Closes: https://lore.kernel.org/oe-kbuild-all/20231230090=
7.RGtYsKxb-lkp@intel.com/=0D
>>>>=0D
>>>>    drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++=
---=0D
>>>>    1 file changed, 62 insertions(+), 5 deletions(-)=0D
>>>>=0D
>>>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c=0D
>>>> index 7d9bc43f12b0..1e500a5bf564 100644=0D
>>>> --- a/drivers/pwm/pwm-imx27.c=0D
>>>> +++ b/drivers/pwm/pwm-imx27.c=0D
>>>> @@ -21,11 +21,13 @@=0D
>>>>    #include <linux/platform_device.h>=0D
>>>>    #include <linux/pwm.h>=0D
>>>>    #include <linux/slab.h>=0D
>>>> +#include <linux/spinlock.h>=0D
>>>>=0D
>>>>    #define MX3_PWMCR			0x00    /* PWM Control Register */=0D
>>>>    #define MX3_PWMSR			0x04    /* PWM Status Register */=0D
>>>>    #define MX3_PWMSAR			0x0C    /* PWM Sample Register */=0D
>>>>    #define MX3_PWMPR			0x10    /* PWM Period Register */=0D
>>>> +#define MX3_PWMCNR			0x14    /* PWM Counter Register */=0D
>>>>=0D
>>>>    #define MX3_PWMCR_FWM			GENMASK(27, 26)=0D
>>>>    #define MX3_PWMCR_STOPEN		BIT(25)=0D
>>>> @@ -91,6 +93,7 @@ struct pwm_imx27_chip {=0D
>>>>    	 * value to return in that case.=0D
>>>>    	 */=0D
>>>>    	unsigned int duty_cycle;=0D
>>>> +	spinlock_t lock;=0D
>>>>    };=0D
>>>>=0D
>>>>    #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27=
_chip, chip)=0D
>>>> @@ -203,10 +206,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_=
chip *chip,=0D
>>>>=0D
>>>>    	sr =3D readl(imx->mmio_base + MX3_PWMSR);=0D
>>>>    	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);=0D
>>>> -	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {=0D
>>>> +	if (fifoav >=3D MX3_PWMSR_FIFOAV_3WORDS) {=0D
>>>>    		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),=0D
>>>>    					 NSEC_PER_MSEC);=0D
>>>> -		msleep(period_ms);=0D
>>>> +		msleep(period_ms * (fifoav - 2));=0D
>>> This touches a different workaround ("pwm: imx: Avoid sample FIFO=0D
>>> overflow for i.MX PWM version2") without any explanation.=0D
>> [Pratik]: Sure, I will look into this. Thanks!=0D
>>>>    		sr =3D readl(imx->mmio_base + MX3_PWMSR);=0D
>>>>    		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))=0D
>>>> @@ -217,13 +220,15 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_=
chip *chip,=0D
>>>>    static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,=0D
>>>>    			   const struct pwm_state *state)=0D
>>>>    {=0D
>>>> -	unsigned long period_cycles, duty_cycles, prescale;=0D
>>>> +	unsigned long period_cycles, duty_cycles, prescale, counter_check, f=
lags;=0D
>>>>    	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);=0D
>>>> +	void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;=0D
>>>> +	__force u32 sar_last, sar_current;=0D
>>>>    	struct pwm_state cstate;=0D
>>>>    	unsigned long long c;=0D
>>>>    	unsigned long long clkrate;=0D
>>>>    	int ret;=0D
>>>> -	u32 cr;=0D
>>>> +	u32 cr, timeout =3D 1000;=0D
>>>>=0D
>>>>    	pwm_get_state(pwm, &cstate);=0D
>>>>=0D
>>>> @@ -264,7 +269,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,=0D
>>>>    		pwm_imx27_sw_reset(chip);=0D
>>>>    	}=0D
>>>>=0D
>>>> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);=0D
>>>> +	/*=0D
>>>> +	 * This is a limited workaround. When the SAR FIFO is empty, the new=
=0D
>>>> +	 * write value will be directly applied to SAR even the current peri=
od=0D
>>>> +	 * is not over.=0D
>>>> +	 * If the new SAR value is less than the old one, and the counter is=
=0D
>>>> +	 * greater than the new SAR value, the current period will not filp=
=0D
>>> The same typo as in the commit message.=0D
>>>> +	 * the level. This will result in a pulse with a duty cycle of 100%.=
=0D
>>>> +	 * So, writing the current value of the SAR to SAR here before updat=
ing=0D
>>>> +	 * the new SAR value can avoid this issue.=0D
>>>> +	 *=0D
>>>> +	 * Add a spin lock and turn off the interrupt to ensure that the=0D
>>>> +	 * real-time performance can be guaranteed as much as possible when=
=0D
>>>> +	 * operating the following operations.=0D
>>>> +	 *=0D
>>>> +	 * 1. Add a threshold of 1.5us. If the time T between the read curre=
nt=0D
>>>> +	 * count value CNR and the end of the cycle is less than 1.5us, wait=
=0D
>>>> +	 * for T to be longer than 1.5us before updating the SAR register.=0D
>>>> +	 * This is to avoid the situation that when the first SAR is written=
,=0D
>>>> +	 * the current cycle just ends and the SAR FIFO that just be written=
=0D
>>>> +	 * is emptied again.=0D
>>>> +	 *=0D
>>>> +	 * 2. Use __raw_writel() to minimize the interval between two writes=
 to=0D
>>>> +	 * the SAR register to increase the fastest pwm frequency supported.=
=0D
>>>> +	 *=0D
>>>> +	 * When the PWM period is longer than 2us(or <500KHz), this workarou=
nd=0D
>>>> +	 * can solve this problem.=0D
>>>> +	 */=0D
>>>> +	if (duty_cycles < imx->duty_cycle) {=0D
>>>> +		c =3D clkrate * 1500;=0D
>>>> +		do_div(c, NSEC_PER_SEC);=0D
>>>> +		counter_check =3D c;=0D
>>>> +		sar_last =3D (__force u32) cpu_to_le32(imx->duty_cycle);=0D
>>>> +		sar_current =3D (__force u32) cpu_to_le32(duty_cycles);=0D
>>>> +=0D
>>>> +		spin_lock_irqsave(&imx->lock, flags);=0D
>>>> +		if (state->period >=3D 2000) {=0D
>>>> +			while ((period_cycles -=0D
>>>> +				readl_relaxed(imx->mmio_base + MX3_PWMCNR))=0D
>>>> +				< counter_check) {=0D
>>>> +				if (!--timeout)=0D
>>>> +					break;=0D
>>>> +			};=0D
>>>> +		}=0D
>>>> +		if (!(MX3_PWMSR_FIFOAV &=0D
>>>> +		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))=0D
>>>> +			__raw_writel(sar_last, reg_sar);=0D
>>>> +		__raw_writel(sar_current, reg_sar);=0D
>>>> +		spin_unlock_irqrestore(&imx->lock, flags);=0D
>>>> +	} else=0D
>>>> +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);=0D
>>>> +=0D
>>> This is hard to believe that checkpatch.pl is fine with this patch.=0D
>>> Please use it before submission.=0D
>> [Pratik]: I used the checkpatch.pl in this patch and that runs without a=
ny warnings/errors!=0D
>Okay, AFAIR the coding style suggests braces for the else case.=0D
>>=0D
>>>>    	writel(period_cycles, imx->mmio_base + MX3_PWMPR);=0D
>>>>=0D
>>>>    	/*=0D
>>>> @@ -324,6 +379,8 @@ static int pwm_imx27_probe(struct platform_device =
*pdev)=0D
>>>>    		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),=0D
>>>>    				     "failed to get peripheral clock\n");=0D
>>>>=0D
>>>> +	spin_lock_init(&imx->lock);=0D
>>>> +	imx->duty_cycle =3D 0;=0D
>>> This line looks unrelated and unnecessary.=0D
>> [Pratik]: Right. I will remove this line in next patch version.=0D
>Could you also please look at Uwe's comments [1]?=0D
>=0D
>Thanks=0D
>=0D
>[1] -=0D
>https://lore.kernel.org/all/20211220105555.zwq22vip7onafrck@pengutronix.de=
/=0D
Actually, I did not get much time to work on this. But, I will look into th=
is now.=0D
>>=0D
>>> Best regards=0D
>>>>    	imx->chip.ops =3D &pwm_imx27_ops;=0D
>>>>    	imx->chip.dev =3D &pdev->dev;=0D
>>>>    	imx->chip.npwm =3D 1;=0D
=0D
Thanks & Regards,=0D
Pratik Manvar=

