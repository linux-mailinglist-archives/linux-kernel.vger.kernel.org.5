Return-Path: <linux-kernel+bounces-15421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14065822BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2231C23246
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A5D18E10;
	Wed,  3 Jan 2024 11:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="JOInMJEL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB818C38;
	Wed,  3 Jan 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1704279656; x=1704884456; i=wahrenst@gmx.net;
	bh=g2Z6MvvMkQ+kJLriOC+XA/VgFBdbSnkP4cIEJgxIfuM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=JOInMJELebW/5734Vs/T26+HvYO4JJlIjgdb2Ky23CC8UUrNwJ4vdFaSMk6u5QyS
	 f5VAWCfGUsQAR4zbrx35VT3stlPhbCutMsbFMkKgs9ooFtlSS3mOwjy0NuQxhNKwq
	 KblhMMB9WF1nTBOFS1ecGedb2jVqurKalKMEco1AMHOLu+tDugc/lVbXmShNA8CRG
	 Oo3wOdFq2V0Z9x4o7Drx+DeiBkCz39af7W5cWQVDmadA1CRf5+1oVkfnfyn1MkOCe
	 1LSSdVdG7c8QUXrYTwuj9BxBdE5VKYq+VNIlVagEIQcAwZ10pBcWx7xD4rwPIrLoV
	 6Pa90Omi+o1YzjROcg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZTqg-1rgRSA1Hwk-00WX63; Wed, 03
 Jan 2024 12:00:56 +0100
Message-ID: <9b5f9e1b-645a-4b44-a30c-fe93e7bf3532@gmx.net>
Date: Wed, 3 Jan 2024 12:00:54 +0100
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
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev, pratik.manvar@ifm.com,
 s.hauer@pengutronix.de, shawnguo@kernel.org, thierry.reding@gmail.com,
 u.kleine-koenig@pengutronix.de, xiaoning.wang@nxp.com, lkp@intel.com
References: <202312300907.RGtYsKxb-lkp@intel.com>
 <20240103063454.1795-1-pratikmanvar09@gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240103063454.1795-1-pratikmanvar09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9fs9dcpWc9nO2pwBLgcP7kEXEe/kAweafeLoW79fow2sCOja2lK
 ear8zCcoJLfSF0VwZPKqCHRi24D1cjsjYTxxnqVitG1C9N6FhBNQtwEekT4hntOhaqg1GjX
 WoZ/5wrxa4flnxkucAz5QmPPzkf21ygXaJEam2L7B2ylB78xZYGQhwyVFLbVx7FGS5Kg0NM
 +09awctNG2qUgW1iTEG1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/vRVwKhM6Yg=;unls2BsqOW2WFrJf5/FEPKWNDPN
 HIoaAmsULXz72wbeI0EPgowjcgV5aEouWUKrsq8kWpse/cxtMKzj76jAas9aGbaZGMP78NG+b
 CuODDoC/n/3WYo3EH+zdRs0Q71QrRhIK8bRVawqfPMhtigRql+31++mUEnNvCll6cP9ztaN82
 TpM/TRM22S4xscsqwjEAt2o/p3+rl/2x19kGZ32Jg/7UalmYG6QcehZFH79QCsd4N2DgtFsSY
 uA41TSG7fqYC7AK56iOuURhnOvwLkYb5MVOyCdb2uOUF62+yny7QKc4+xk1hwuQtZ7dbSSzR5
 8rOwAdW0SnMw9bC7pBno3p47++dmFldINOaM2tlfyg4H2Mdt5vUyRM0OE4Gme9t6lKOt4nVve
 2wzcIU5QBF0/rkd+gr9T1q5TQLWoL8cBgtN7kojNvxd6JdBWebaZEGYOc8e5eH+LpEhiP/APA
 ewXh2IM0yGqRPWpLSMPUgMRC1Wp51ZibC+lWXWCPCHHi2yD5YOWHzOAZnlhn29dASTVgCvrlu
 N2gYgFfnxgcOclGmimh9ZTyEX/Mlt4+GbDAPcpEn/KFzLoXX+MkBcJG1ZHNZIsOPGbkLnBpqc
 4J6aW8WLGOjFCvNI2/hY9l+g18I4TBcXv/SUDjaLmrkYLn4zBJMc+wGOx4qb35bSt9GD+7cIH
 qcS8PUAiwVePleaQv60I6JjGLL3TZoalC8d3WtI6G+8aCFd7ku4kYC+d5b34XYb3NV4RVgmHj
 3Qrc3BCN+wIglBsg/CXi6BAM4hC04oPwfjeoGaKiogMDUF8YgP0mpdn2SwUQpKJhE+agMl/x0
 +1smuAQVf8XsK2hk87DdVOqB+UKewHr/rRsIUxWa40p9am0kHigTGZVuMLZyT4T1z6BpE0a28
 ah4A+DrxF+HtFir49gaUIEn/ujm/YowVtr7rL2UBseEY6USZxf9oCIkdrBEBDUEsvJB1Df4BG
 vcPNhsxvSTqNpfrUpWle/6VpfM8=

Hi Pratik,

Am 03.01.24 um 07:34 schrieb pratikmanvar09@gmail.com:
> From: Clark Wang <xiaoning.wang@nxp.com>
>
> This fixes the pwm output bug when decrease the duty cycle.
> This is a limited workaround for the PWM IP issue TKT0577206.
this looks like a patch from the vendor tree.

Could you please provide a link to the origin or at least to the
document which describes TKT0577206?

As a i.MX6ULL user i couldn't find this issue in the chip errata. So are
you sure that every PWM IP handled by this driver is affected?
>
> Root cause:
> When the SAR FIFO is empty, the new write value will be directly applied
> to SAR even the current period is not over.
> If the new SAR value is less than the old one, and the counter is
> greater than the new SAR value, the current period will not filp the
s/filp/flip/ ?
> level. This will result in a pulse with a duty cycle of 100%.
>
> Workaround:
> Add an old value SAR write before updating the new duty cycle to SAR.
> This will keep the new value is always in a not empty fifo, and can be
> wait to update after a period finished.
>
> Limitation:
> This workaround can only solve this issue when the PWM period is longer
> than 2us(or <500KHz).
>
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Link: https://github.com/nxp-imx/linux-imx/commit/16181cc4eee61d87cbaba0=
e5a479990507816317
> Tested-by: Pratik Manvar <pratik.manvar@ifm.com>
> ---
>   V1 -> V2: fix sparse warnings reported-by: kernel test robot <lkp@inte=
l.com>
>             Closes: https://lore.kernel.org/oe-kbuild-all/202312300907.R=
GtYsKxb-lkp@intel.com/
>
>   drivers/pwm/pwm-imx27.c | 67 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 62 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 7d9bc43f12b0..1e500a5bf564 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -21,11 +21,13 @@
>   #include <linux/platform_device.h>
>   #include <linux/pwm.h>
>   #include <linux/slab.h>
> +#include <linux/spinlock.h>
>
>   #define MX3_PWMCR			0x00    /* PWM Control Register */
>   #define MX3_PWMSR			0x04    /* PWM Status Register */
>   #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
>   #define MX3_PWMPR			0x10    /* PWM Period Register */
> +#define MX3_PWMCNR			0x14    /* PWM Counter Register */
>
>   #define MX3_PWMCR_FWM			GENMASK(27, 26)
>   #define MX3_PWMCR_STOPEN		BIT(25)
> @@ -91,6 +93,7 @@ struct pwm_imx27_chip {
>   	 * value to return in that case.
>   	 */
>   	unsigned int duty_cycle;
> +	spinlock_t lock;
>   };
>
>   #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_ch=
ip, chip)
> @@ -203,10 +206,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_ch=
ip *chip,
>
>   	sr =3D readl(imx->mmio_base + MX3_PWMSR);
>   	fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
> -	if (fifoav =3D=3D MX3_PWMSR_FIFOAV_4WORDS) {
> +	if (fifoav >=3D MX3_PWMSR_FIFOAV_3WORDS) {
>   		period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm),
>   					 NSEC_PER_MSEC);
> -		msleep(period_ms);
> +		msleep(period_ms * (fifoav - 2));
This touches a different workaround ("pwm: imx: Avoid sample FIFO
overflow for i.MX PWM version2") without any explanation.
>
>   		sr =3D readl(imx->mmio_base + MX3_PWMSR);
>   		if (fifoav =3D=3D FIELD_GET(MX3_PWMSR_FIFOAV, sr))
> @@ -217,13 +220,15 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_ch=
ip *chip,
>   static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *p=
wm,
>   			   const struct pwm_state *state)
>   {
> -	unsigned long period_cycles, duty_cycles, prescale;
> +	unsigned long period_cycles, duty_cycles, prescale, counter_check, fla=
gs;
>   	struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
> +	void __iomem *reg_sar =3D imx->mmio_base + MX3_PWMSAR;
> +	__force u32 sar_last, sar_current;
>   	struct pwm_state cstate;
>   	unsigned long long c;
>   	unsigned long long clkrate;
>   	int ret;
> -	u32 cr;
> +	u32 cr, timeout =3D 1000;
>
>   	pwm_get_state(pwm, &cstate);
>
> @@ -264,7 +269,57 @@ static int pwm_imx27_apply(struct pwm_chip *chip, s=
truct pwm_device *pwm,
>   		pwm_imx27_sw_reset(chip);
>   	}
>
> -	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +	/*
> +	 * This is a limited workaround. When the SAR FIFO is empty, the new
> +	 * write value will be directly applied to SAR even the current period
> +	 * is not over.
> +	 * If the new SAR value is less than the old one, and the counter is
> +	 * greater than the new SAR value, the current period will not filp
The same typo as in the commit message.
> +	 * the level. This will result in a pulse with a duty cycle of 100%.
> +	 * So, writing the current value of the SAR to SAR here before updatin=
g
> +	 * the new SAR value can avoid this issue.
> +	 *
> +	 * Add a spin lock and turn off the interrupt to ensure that the
> +	 * real-time performance can be guaranteed as much as possible when
> +	 * operating the following operations.
> +	 *
> +	 * 1. Add a threshold of 1.5us. If the time T between the read current
> +	 * count value CNR and the end of the cycle is less than 1.5us, wait
> +	 * for T to be longer than 1.5us before updating the SAR register.
> +	 * This is to avoid the situation that when the first SAR is written,
> +	 * the current cycle just ends and the SAR FIFO that just be written
> +	 * is emptied again.
> +	 *
> +	 * 2. Use __raw_writel() to minimize the interval between two writes t=
o
> +	 * the SAR register to increase the fastest pwm frequency supported.
> +	 *
> +	 * When the PWM period is longer than 2us(or <500KHz), this workaround
> +	 * can solve this problem.
> +	 */
> +	if (duty_cycles < imx->duty_cycle) {
> +		c =3D clkrate * 1500;
> +		do_div(c, NSEC_PER_SEC);
> +		counter_check =3D c;
> +		sar_last =3D (__force u32) cpu_to_le32(imx->duty_cycle);
> +		sar_current =3D (__force u32) cpu_to_le32(duty_cycles);
> +
> +		spin_lock_irqsave(&imx->lock, flags);
> +		if (state->period >=3D 2000) {
> +			while ((period_cycles -
> +				readl_relaxed(imx->mmio_base + MX3_PWMCNR))
> +				< counter_check) {
> +				if (!--timeout)
> +					break;
> +			};
> +		}
> +		if (!(MX3_PWMSR_FIFOAV &
> +		      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
> +			__raw_writel(sar_last, reg_sar);
> +		__raw_writel(sar_current, reg_sar);
> +		spin_unlock_irqrestore(&imx->lock, flags);
> +	} else
> +		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> +
This is hard to believe that checkpatch.pl is fine with this patch.
Please use it before submission.
>   	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
>
>   	/*
> @@ -324,6 +379,8 @@ static int pwm_imx27_probe(struct platform_device *p=
dev)
>   		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
>   				     "failed to get peripheral clock\n");
>
> +	spin_lock_init(&imx->lock);
> +	imx->duty_cycle =3D 0;
This line looks unrelated and unnecessary.

Best regards
>   	imx->chip.ops =3D &pwm_imx27_ops;
>   	imx->chip.dev =3D &pdev->dev;
>   	imx->chip.npwm =3D 1;


