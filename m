Return-Path: <linux-kernel+bounces-79573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0C0862460
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B357F283480
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64994249F8;
	Sat, 24 Feb 2024 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq9OSPFa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3096210E8;
	Sat, 24 Feb 2024 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708772417; cv=none; b=NOaPQNba6EnSgsgqSENrvl6gNxwD3WvX0CV9/NNIVUJRkKMT5NYYURXvgDnLFFEjBKFq2Tg5TTfSF9ib+Ox0AsFoFfe1qiKl0KQssx0wiQ4OfjddL59V5k/FY/VUflHvknrVHkqVnSBoySo8IpnOyC2EtpNtK8jVL0kysJDvSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708772417; c=relaxed/simple;
	bh=w5pzkyIMyfU2MrnKa0byUlT2BlWcojtMcCfL8S+V39c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fujO5aj2fBJ9j+Ee7Uw3lHKIQ162zHQ947GrVZi7+4eCusc7Kc90eMg9iUiPXuZFjsZI8KC5fniUE1SVFcUKWpG84l0GaQs7JTZ4tMl4dwvtmwxXny6ZMyx7D7x0gmA7E5kwEXpd9yMWYnmt1kfOsRD1DAunBXZrdgAEoEPqL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cq9OSPFa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565a2c4cc1aso512317a12.2;
        Sat, 24 Feb 2024 03:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708772414; x=1709377214; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpCYimJwr5zoZeSIU9wIfV1GVTrvKCGvd8RWW61PZrM=;
        b=cq9OSPFas+UH3KE5QCnxnQ0q6UAPp43Dw3q/jH0Fje0m0aSKraOl5lmU3mJwTjZGOU
         9elEN1INyJGnXw0GswR8sKs4LW0bQCtdcSpN8COai/9tPS+6zfh5pHcAV49yAul/SbB7
         8L78DPMdR3lRwcFM7zk3z0c1FYbmLtfBS6IvUpmxnjqeR8HaNrjc+qfID2lRD0Le8ZgS
         lSm0NJPXq/5nFGwKHybiNiTyxCC9Q50rHBgjcZ1WqzwXE8uU8WtC+k4sIiA0zyNLIEWa
         PGYc26sf23ZjmX0MH3+7eWnWka23lDCIrjsOal78vxRNV9t0InEvvhqtiDvuOjDFtID+
         khQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708772414; x=1709377214;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpCYimJwr5zoZeSIU9wIfV1GVTrvKCGvd8RWW61PZrM=;
        b=NUhLacldUKItBSGZBIPfmtq0eMvSLEsyL1LCeY/AG+kmwuHmpjSQSr2uj+WlPj8fWY
         Uf2q63R0c4HY2byGtfCfa/+/BMH2KxpAGkUQKgM+q8eJ3uVspOjVeeq5+bkRRXXnfJXh
         v5xvyBuMyY9OViVpJA7MT+FnuFxwW6mPLRIpyMtk9g7IAa8+MjIFFancm0SI4vGTeMPj
         rGHHhLiVKBnVqgTAW8AOztKLOzya/6Ba0+FLgaR6w6Kox5ukjOq10rk3vhVlv3J/5Zlb
         6gSKZyLVYwPA1rZ/BkbtuGpo+nPMFU5ewgsCkSkFb9a4Lxl86hf/SEkj5s0j5fRahaO/
         6xYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIAO3x74aoeX3ZDnqBWn/D4HM6xyYdfMVryNVfsQmNJTemjwraTPeMsz5VB9bEMHDcgK0vqjku7q0xAPbsEHSKMvsJTH1368Y/YBHJgyepewyfdFgEm2UrImP6YgI5hRS6Nkzorake
X-Gm-Message-State: AOJu0YxAGiyDwg+YhH5fUzIDD5qDVCyjFbqA5riDGXURHSSHZs/G8HSX
	R8KcP9zDctnjRdhycPz0/z8rn5MejCn+o/CVArxOU57WE9qTjEzV
X-Google-Smtp-Source: AGHT+IHf1SJSDJh6L11/QSMlEQiuGKaTUG7dy6V88R9amS9YOpXDoX7URQAQgyIzgK7Sm9K0ND/6Dw==
X-Received: by 2002:a05:6402:1a36:b0:565:bbc4:9c88 with SMTP id be22-20020a0564021a3600b00565bbc49c88mr10341edb.20.1708772413776;
        Sat, 24 Feb 2024 03:00:13 -0800 (PST)
Received: from smtpclient.apple (p5dc68d61.dip0.t-ipconnect.de. [93.198.141.97])
        by smtp.gmail.com with ESMTPSA id g11-20020a056402428b00b00563c63e0a13sm438351edc.49.2024.02.24.03.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Feb 2024 03:00:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v3 1/4] pwm: imx27: fix race condition .apply,.get_state
From: Leif Middelschulte <leif.middelschulte@gmail.com>
In-Reply-To: <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
Date: Sat, 24 Feb 2024 12:00:02 +0100
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 NXP Linux Team <linux-imx@nxp.com>,
 Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-pwm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <294551D8-53E1-489E-A043-09714722C4EA@gmail.com>
References: <20230310174517.rb7xxrougkse2lrc@pengutronix.de>
 <20230815104332.55044-1-Leif.Middelschulte@gmail.com>
 <20230906154215.4ikrrbx4xgx2nmu5@pengutronix.de>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-Mailer: Apple Mail (2.3774.400.31)


> Am 06.09.2023 um 17:42 schrieb Uwe Kleine-K=C3=B6nig =
<u.kleine-koenig@pengutronix.de>:
>=20
> On Tue, Aug 15, 2023 at 12:43:29PM +0200, Leif Middelschulte wrote:
>> From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>>=20
>> With CONFIG_PWM_DEBUG=3Dy after writing a value to the PWMSAR
>> register in .apply(), the register is read in .get_state().
>> Unless a period completed in the meantime, this read yields the
>> previously used duty cycle configuration. As the PWM_DEBUG code
>> applies the read out configuration for testing purposes this
>> effectively undoes the intended effect by rewriting the previous
>> hardware state.
>>=20
>> Note that this change merely implements a sensible heuristic.
>> The i.MX has a 4 slot FIFO to configure the duty cycle. This FIFO
>> cannot be read back in its entirety. The "write x then read back
>> x from hw" semantics are therefore not easily applicable.
>> With this change, the .get_state() function tries to wait for some
>> stabilization in the FIFO (empty state). In this state it keeps
>> applying the last value written to the sample register.
>>=20
>> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>> ---
>> drivers/pwm/pwm-imx27.c | 50 =
++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 47 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
>> index 29a3089c534c..32389ca2da3e 100644
>> --- a/drivers/pwm/pwm-imx27.c
>> +++ b/drivers/pwm/pwm-imx27.c
>> @@ -75,6 +75,7 @@
>>   (x)) + 1)
>>=20
>> #define MX3_PWM_SWR_LOOP 5
>> +#define MX3_PWM_FIFOAV_EMPTY_LOOP 4
>>=20
>> /* PWMPR register value of 0xffff has the same effect as 0xfffe */
>> #define MX3_PWMPR_MAX 0xfffe
>> @@ -118,8 +119,28 @@ static void =
pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
>> clk_disable_unprepare(imx->clk_ipg);
>> }
>>=20
>> +static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
>> +     struct pwm_device *pwm)
>> +{
>> + struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
>> + struct device *dev =3D chip->dev;
>> + unsigned int period_ms =3D DIV_ROUND_UP_ULL(pwm_get_period(pwm), =
NSEC_PER_MSEC);
>> + int tries =3D MX3_PWM_FIFOAV_EMPTY_LOOP;
>> + int fifoav;
>> + u32 sr;
>> +
>> + while (tries--) {
>> + sr =3D readl(imx->mmio_base + MX3_PWMSR);
>> + fifoav =3D FIELD_GET(MX3_PWMSR_FIFOAV, sr);
>> + if (fifoav =3D=3D MX3_PWMSR_FIFOAV_EMPTY)
>> + return;
>> + msleep(period_ms);
>> + }
>> + dev_warn(dev, "FIFO has been refilled concurrently\n");
>> +}
>> +
>> static int pwm_imx27_get_state(struct pwm_chip *chip,
>> -       struct pwm_device *pwm, struct pwm_state *state)
>> + struct pwm_device *pwm, struct pwm_state *state)
>=20
> This looks wrong. Aligning at the opening ( was right.

Good catch. That change as unintentional.

>=20
>> {
>> struct pwm_imx27_chip *imx =3D to_pwm_imx27_chip(chip);
>> u32 period, prescaler, pwm_clk, val;
>> @@ -161,10 +182,33 @@ static int pwm_imx27_get_state(struct pwm_chip =
*chip,
>> * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
>> * use the cached value.
>> */
>> - if (state->enabled)
>> + if (state->enabled) {
>> + /*
>> + * =46rom the i.MX PWM reference manual:
>> + * "A read on the sample register yields the current FIFO value that
>> + *  is being used, or will be used, by the PWM for generation on the
>> + *  output signal. Therefore, a write and a subsequent read on the
>> + *  sample register may result in different values being obtained."
>> + * Furthermore:
>> + * "When a new value is written, the duty cycle changes after the
>> + *  current period is over."
>> + * Note "changes" vs. "changes to the given value"!
>> + * Finally:
>> + * "The PWM will run at the last set duty-cycle setting if all the
>> + *  values of the FIFO has been utilized, until the FIFO is reloaded
>> + *  or the PWM is disabled."
>> + * Try to be at least a bit more deterministic about which value is
>> + * read by waiting until the FIFO is empty. In this state the =
last/most
>> + * recently pushed sample (duty cycle) value is continuously =
applied.
>> + * Beware that this approach is still racy, as a new value could =
have
>> + * been supplied and a period expired between the call of the wait
>> + * function and the subsequent readl.
>=20
> this would only happen if there are concurrent calls into the driver,
> wouldn't it? I think it's safe to assume this doesn't happen.

This assessment seems correct at them moment. This comment is supposed =
to be a source of explanation to future developers if - for some reason =
- the driver/subsystem is changed and they trip over this behaviour =
(again), just as I did.

>=20
> Patch 3 of this series improves the function that is only introduced
> here. I suggest to squash these together.

I will provide v4 with the changes squashed into the initial commit, =
that introduced the function.

>=20
> Best regards
> Uwe
>=20
> --=20
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig     =
       |
> Industrial Linux Solutions                 | =
https://www.pengutronix.de/ |

Thank you,

Leif=

