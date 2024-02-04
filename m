Return-Path: <linux-kernel+bounces-51571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD8D848CA4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F25D91F22490
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020B41B59A;
	Sun,  4 Feb 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="kHvUHURc"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B21B597;
	Sun,  4 Feb 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707040989; cv=none; b=ndFkoRW7pO0j8ZS/CnM9vgZoJb/dQJKs3hW3iwLqkTYKC9w5bXESO72PDk9iVURFwejhQ7IIu7YxshV/BBVR0Zv/ZNNDhY91edlxP+mdD7ekRLxQld93lQB79hUEBKb+ZfvWepEuC+pvSq26zqs5sxLMtxtnv2v8E8m37Np0T1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707040989; c=relaxed/simple;
	bh=VXDlElR0KzkiHuC+u/icBzFgcRGQR3tyOWptVOl4tHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t73z58s7s3eMNZMTKraTPvR+z1AIYhpYFziY7VhI01Q7UJ+l0vYw/eMCC1e70AoqlC4QkkTbWv/nof82kqrrGABqtQxZgXTFGkgYTofPNw9zJk57pJQ5bMOQYTlf+hH1L6xxorXIyJosyiyeCkgb5IeOlT6dILDCK/gICniGRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=kHvUHURc; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1707040961; x=1707645761; i=wahrenst@gmx.net;
	bh=VXDlElR0KzkiHuC+u/icBzFgcRGQR3tyOWptVOl4tHE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=kHvUHURcndsJZ6FDYlQcfkxxbIWoooj5fuaZG399K9P2zZFzKWUQaUdrL6H+zCij
	 26Nq8FEdMU9ruaFzBW8Z+Y5m+H5EfuU0ldDQ1ze9zBl6jgFVW/HyNoAlzdyoojloG
	 swH/2/82jwtLHLoZsIBdFKKrtM/ITmFoIJmZ2m0ZxaNNr7Wa6F574Tklzwkl6NEno
	 RiaA48Wmw79/+iBAS6Y7fq2YgfBgoaE1ROAoUxvXl3QF6sK5tcn9seQCnmFBkWTGW
	 Ew+EK031PftXufGmlodv9fDhn142eJUTH/7m5unIzvXMs0YT7q92WtVFqfm/azEoh
	 +o27pIvN3ze9vs4BfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mplc7-1qgjOe1OMH-00qBLl; Sun, 04
 Feb 2024 11:02:41 +0100
Message-ID: <d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net>
Date: Sun, 4 Feb 2024 11:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pwm: imx27: workaround of the pwm output bug
To: pratikmanvar09@gmail.com
Cc: festevam@gmail.com, jun.li@nxp.com, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, lkp@intel.com,
 oe-kbuild-all@lists.linux.dev, pratik.manvar@ifm.com,
 s.hauer@pengutronix.de, shawnguo@kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, xiaoning.wang@nxp.com
References: <9b5f9e1b-645a-4b44-a30c-fe93e7bf3532@gmx.net>
 <65bf307d.170a0220.4d544.f32b@mx.google.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <65bf307d.170a0220.4d544.f32b@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ciETa2nOAf5BvE00g5Ju4E5qleglufbR4qXli47bRkOJPaGR0yZ
 BSgzrCb4uip1npd8S7yc4hmOvtpO/bcAuBxYLb/Gwk2zqbFBlQs8St65DEnhKR6YfFuu4G7
 epubRoY6BNO/I8tj8aTAWiTDdq6hST1hO+XcEWeZgwU9jpGafeagjRI7s+ooR1wS/0f3Ylg
 QFNh8fUHZab7M1G/genIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NrX9tcNxRuA=;FEiFVHCqlT5c1r9lowG0JXYzonN
 Z6oe4Cxhx9vWA3IHxbepZxYu5+iqR8YzynjUH48BMdKrpLeQKN33Ic5e3raUSxgsT9d9hqiNF
 ox9mbICYK/paNi4qvZQ65F/S/i1/qPywGcY74ABX2rlvtwFjNKuH1ViZ5crUGLalpVtN3zu7W
 ZbYvv67t/7BQ6Dco2smDlljIc9+0uz6mUL489rITW4k9u7UGfs/ECKnWSUGOoPiMcEWx+/eEl
 gmhmagkvPmJTkHnWuj6rtaDJ8OugmD/00hYSQMaF/mYdZnSpwGKCyBvHR1Swig2kJlR1EuwEW
 veM2V7lSsU5g8zzg69LbV9xkYt+HxxmWjFe9bWekChvPVrVjqeTLcGbbEiqwMkyc1Nfgw25eP
 iB91Ky+1h7OC9PKtB3/B7cI+Wee9oQZiKOdenkkVMuxIiZDt/x4WfhoUBjTZrzXdBuJ1c3FKH
 unJlkOTVvA0B71VUhqWIPeZdZ0OxTAD4Wtc71N3/JYDH/caR2FAob0SB7S5SgyH+6ooHlJZRi
 eV8yVBXRN846bpHce0j4hFIGy4qjIH8g7ZJtxdT6WjY3N41bMvjOgJSN+4EdW3vfe5B+oW/4d
 gzVaZ307GDbUQIXSwMXJUq71DIVUGo32gtKVmsmm+5uW2U0oI1kpLVkxg+w0480TLckBMFWqH
 pucQfU+I6IyZSNwjWDvmAn5hYd/uwrSaTg0Q06hzNPCOz5OyaAs0UYuqkZviOVr0nXr7TV2fr
 i5K9T0srlZbVk8n8jY4zUyWlH9wxM6tSl+4C+0Lav7g8XHr4jyAtWi8z6RTCrFjE81TPTCKat
 GnqUPT+fISK9MjTtj8BEy3I8ViE9N7Q6WzGEgkZFPMQhg=

Hi Pratik,

Am 04.02.24 um 07:36 schrieb pratikmanvar09@gmail.com:
> Hi Stefan,
>
> Thanks for your review.
> Please see my reply below inline.
>
>>> From: Clark Wang <xiaoning.wang@nxp.com>
>>>
>>> This fixes the pwm output bug when decrease the duty cycle.
>>> This is a limited workaround for the PWM IP issue TKT0577206.
>> this looks like a patch from the vendor tree.
> [Pratik]: Yes, this is the patch from NXP. Please see original link of t=
he patch https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba=
0e5a479990507816317
>
>> Could you please provide a link to the origin or at least to the
>> document which describes TKT0577206?
> [Pratik]: Please refer i.MX8MN errata #ERR051198 in https://www.nxp.com/=
docs/en/errata/IMX8MN_0N14Y.pdf.
Thanks, i think this ERR... reference is better than TKT... because it's
links to the errata documents and other Freescale/NXP drivers use them
too. So having this code in a comment would be great.
>
>> As a i.MX6ULL user i couldn't find this issue in the chip errata. So ar=
e
>> you sure that every PWM IP handled by this driver is affected?
> [Pratik]: Yes, looks like this issue is on all platforms which uses this=
 PWM IP.
>
>>> Root cause:
>>> When the SAR FIFO is empty, the new write value will be directly appli=
ed
>>> to SAR even the current period is not over.
>>> If the new SAR value is less than the old one, and the counter is
>>> greater than the new SAR value, the current period will not filp the
>> s/filp/flip/ ?
>>> level. This will result in a pulse with a duty cycle of 100%.
>>>
>>> Workaround:
>>> Add an old value SAR write before updating the new duty cycle to SAR.
>>> This will keep the new value is always in a not empty fifo, and can be
>>> wait to update after a period finished.
>>>
>>> Limitation:
>>> This workaround can only solve this issue when the PWM period is longe=
r
>>> than 2us(or <500KHz).
>>>
>>> Reviewed-by: Jun Li <jun.li@nxp.com>
>>> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
>>> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbab=
a0e5a479990507816317
>>> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>
>>> ---
>>>    V1 -> V2: fix sparse warnings reported-by: kernel test robot <lkp@i=
ntel.com>
>>>              Closes: https://lore.kernel.org/oe-kbuild-all/20231230090=
7.RGtYsKxb-lkp@intel.com/
>>>
>>>    drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++=
=2D--
>>>    1 file changed, 62 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>>> index 7d9bc43f12b0..1e500a5bf564 100644
>>> --- a/drivers/pwm/pwm-imx27.c
>>> +++ b/drivers/pwm/pwm-imx27.c
>>> @@ -21,11 +21,13 @@
>>>    #include <linux/platform_device.h>
>>>    #include <linux/pwm.h>
>>>    #include <linux/slab.h>
>>> +#include <linux/spinlock.h>
>>>
>>>    #define MX3_PWMCR			0x00    /* PWM Control Register */
>>>    #define MX3_PWMSR			0x04    /* PWM Status Register */
>>>    #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
>>>    #define MX3_PWMPR			0x10    /* PWM Period Register */
>>> +#define MX3_PWMCNR			0x14    /* PWM Counter Register */
>>>
>>>    #define MX3_PWMCR_FWM			GENMASK(27, 26)
>>>    #define MX3_PWMCR_STOPEN		BIT(25)
>>> @@ -91,6 +93,7 @@ struct pwm_imx27_chip {
>>>    	 * value to return in that case.
>>>    	 */
>>>    	unsigned int duty_cycle;
>>> +	spinlock_t lock;
>>>    };
>>>
>>>    #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27=
_chip, chip)
>>> @@ -203,10 +206,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_=
chip *chip,
>>>
>>>    	sr =3D readl(imx->mmio_base + MX3_PWMSR);
>>>    	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
>>> -	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
>>> +	if (fifoav >=3D MX3_PWMSR_FIFOAV_3WORDS) {
>>>    		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),
>>>    					 NSEC_PER_MSEC);
>>> -		msleep(period_ms);
>>> +		msleep(period_ms * (fifoav - 2));
>> This touches a different workaround ("pwm: imx: Avoid sample FIFO
>> overflow for i.MX PWM version2") without any explanation.
> [Pratik]: Sure, I will look into this. Thanks!
>>>    		sr =3D readl(imx->mmio_base + MX3_PWMSR);
>>>    		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))
>>> @@ -217,13 +220,15 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_=
chip *chip,
>>>    static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device=
 *pwm,
>>>    			   const struct pwm_state *state)
>>>    {
>>> -	unsigned long period_cycles, duty_cycles, prescale;
>>> +	unsigned long period_cycles, duty_cycles, prescale, counter_check, f=
lags;
>>>    	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
>>> +	void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;
>>> +	__force u32 sar_last, sar_current;
>>>    	struct pwm_state cstate;
>>>    	unsigned long long c;
>>>    	unsigned long long clkrate;
>>>    	int ret;
>>> -	u32 cr;
>>> +	u32 cr, timeout =3D 1000;
>>>
>>>    	pwm_get_state(pwm, &cstate);
>>>
>>> @@ -264,7 +269,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip,=
 struct pwm_device *pwm,
>>>    		pwm_imx27_sw_reset(chip);
>>>    	}
>>>
>>> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>> +	/*
>>> +	 * This is a limited workaround. When the SAR FIFO is empty, the new
>>> +	 * write value will be directly applied to SAR even the current peri=
od
>>> +	 * is not over.
>>> +	 * If the new SAR value is less than the old one, and the counter is
>>> +	 * greater than the new SAR value, the current period will not filp
>> The same typo as in the commit message.
>>> +	 * the level. This will result in a pulse with a duty cycle of 100%.
>>> +	 * So, writing the current value of the SAR to SAR here before updat=
ing
>>> +	 * the new SAR value can avoid this issue.
>>> +	 *
>>> +	 * Add a spin lock and turn off the interrupt to ensure that the
>>> +	 * real-time performance can be guaranteed as much as possible when
>>> +	 * operating the following operations.
>>> +	 *
>>> +	 * 1. Add a threshold of 1.5us. If the time T between the read curre=
nt
>>> +	 * count value CNR and the end of the cycle is less than 1.5us, wait
>>> +	 * for T to be longer than 1.5us before updating the SAR register.
>>> +	 * This is to avoid the situation that when the first SAR is written=
,
>>> +	 * the current cycle just ends and the SAR FIFO that just be written
>>> +	 * is emptied again.
>>> +	 *
>>> +	 * 2. Use __raw_writel() to minimize the interval between two writes=
 to
>>> +	 * the SAR register to increase the fastest pwm frequency supported.
>>> +	 *
>>> +	 * When the PWM period is longer than 2us(or <500KHz), this workarou=
nd
>>> +	 * can solve this problem.
>>> +	 */
>>> +	if (duty_cycles < imx->duty_cycle) {
>>> +		c =3D clkrate * 1500;
>>> +		do_div(c, NSEC_PER_SEC);
>>> +		counter_check =3D c;
>>> +		sar_last =3D (__force u32) cpu_to_le32(imx->duty_cycle);
>>> +		sar_current =3D (__force u32) cpu_to_le32(duty_cycles);
>>> +
>>> +		spin_lock_irqsave(&imx->lock, flags);
>>> +		if (state->period >=3D 2000) {
>>> +			while ((period_cycles -
>>> +				readl_relaxed(imx->mmio_base + MX3_PWMCNR))
>>> +				< counter_check) {
>>> +				if (!--timeout)
>>> +					break;
>>> +			};
>>> +		}
>>> +		if (!(MX3_PWMSR_FIFOAV &
>>> +		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
>>> +			__raw_writel(sar_last, reg_sar);
>>> +		__raw_writel(sar_current, reg_sar);
>>> +		spin_unlock_irqrestore(&imx->lock, flags);
>>> +	} else
>>> +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
>>> +
>> This is hard to believe that checkpatch.pl is fine with this patch.
>> Please use it before submission.
> [Pratik]: I used the checkpatch.pl in this patch and that runs without a=
ny warnings/errors!
Okay, AFAIR the coding style suggests braces for the else case.
>
>>>    	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>>>
>>>    	/*
>>> @@ -324,6 +379,8 @@ static int pwm_imx27_probe(struct platform_device =
*pdev)
>>>    		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
>>>    				     "failed to get peripheral clock\n");
>>>
>>> +	spin_lock_init(&imx->lock);
>>> +	imx->duty_cycle =3D 0;
>> This line looks unrelated and unnecessary.
> [Pratik]: Right. I will remove this line in next patch version.
Could you also please look at Uwe's comments [1]?

Thanks

[1] -
https://lore.kernel.org/all/20211220105555.zwq22vip7onafrck@pengutronix.de=
/
>
>> Best regards
>>>    	imx->chip.ops =3D &pwm_imx27_ops;
>>>    	imx->chip.dev =3D &pdev->dev;
>>>    	imx->chip.npwm =3D 1;


