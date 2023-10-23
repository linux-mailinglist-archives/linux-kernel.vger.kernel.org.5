Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF67D2B27
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjJWHWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjJWHWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:22:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142A5D5B
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:22:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so2253623a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1698045719; x=1698650519; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VyGxX/nUPAcrT1SIX/f6Dp17+DAfApD8LvQppveUPE=;
        b=b/IIa7lCfju7n3jhTiscMKevi+xdKEQ+TY8azqzRMYK/CHO5vxIoSUt9lCEUde7VgF
         q0oWD3QWH83Y2IU7RgGov15AcDdGzGfD0bJiiuWn1xzHa/VDbmt5oF0AqLEi+KBs2DuP
         HYb+oEfMynWuC0TBU3YWpoxqubahAy523zDIU15pdE6o5b5PAnLrRjvchN0JDRq09Gqv
         RSyfLNR9u1d/BBH0rFoBLY7q+N++9xTM7JDbHxe/CdeVxoY7HwXV+NyIHd2/0dnEC4X4
         +QQEYxG329xm5i3uOquFD6V1huE8bMbEvvt1mkzfm+qzIdXXNQz9TanSLrREYYMEe30O
         WO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698045719; x=1698650519;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5VyGxX/nUPAcrT1SIX/f6Dp17+DAfApD8LvQppveUPE=;
        b=AbQHI4BPUj4d5sq6uzi1f2bPMV5YR1rTSNnfnvdWn6B4PWL+1FJbe3ZKF4qGPe0bHW
         WI6jX7ZxSJiNb2vVLaciHSvcaYkEpATUy3q2liG643H2rHWFEVv2Kdua6LtJKb041I6z
         mcrM4Ghqn2UDdtATollcIsTHL1HRac3UmYO0k2KvJ+Gj5fcNUYIXyVYet4q5q2ED+WlQ
         H4ck0WSO41zgVHBG/KcOlZAnhZDB1eAevC68roUOcCLIqtEyYPqVntExn7C7DTbrr9sl
         tVt/iL3JBOdblgaL4bCFZHCRzBY2dgdm6ctlZO+r7pTD+FCUsaTflQc+DKhp1lkr20q/
         qpFg==
X-Gm-Message-State: AOJu0YxhlxQ+BK+j7vnFeGJvsO735IeqQWlgate2Tg3GNw0IYIwEBXli
        NnTVvX7TMbxFtrjEhsCSu3POxQ==
X-Google-Smtp-Source: AGHT+IFy+zSBPx7xNQMEe0P/AMWETMar56A23PZSlTvl6miypptcYwz4TJb4rBP+0sfo8+Nb0E1ydg==
X-Received: by 2002:a05:6402:27ca:b0:53d:e139:64a5 with SMTP id c10-20020a05640227ca00b0053de13964a5mr5522823ede.27.1698045719485;
        Mon, 23 Oct 2023 00:21:59 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id s21-20020a056402037500b0053e0395059csm5766839edw.21.2023.10.23.00.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 00:21:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 23 Oct 2023 09:21:58 +0200
Message-Id: <CWFMYY5X1YDI.1DFA3SWOTWIKR@fairphone.com>
Cc:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <quic_subbaram@quicinc.com>, <quic_gurus@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v6 4/7] leds: rgb: leds-qcom-lpg: Add support for PPG
 through single SDAM
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Anjelique Melendez" <quic_amelende@quicinc.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231020182218.22217-1-quic_amelende@quicinc.com>
 <20231020182218.22217-5-quic_amelende@quicinc.com>
In-Reply-To: <20231020182218.22217-5-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 20, 2023 at 8:22 PM CEST, Anjelique Melendez wrote:
> In some PMICs like pmi632, the pattern look up table (LUT) and LPG
> configuration is stored in a single SDAM module instead of LUT
> peripheral. This feature is called PPG. PPG uses Qualcomm Programmable
> Boot Sequencer (PBS) inorder to trigger pattern sequences for PMICs.

As with PATCH 5/7:

Tested-by: Luca Weiss <luca.weiss@fairphone.com>

>
> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 264 ++++++++++++++++++++++++++++---
>  1 file changed, 242 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qco=
m-lpg.c
> index df469aaa7e6e..0c6d0e593c06 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -8,11 +8,13 @@
>  #include <linux/bitfield.h>
>  #include <linux/led-class-multicolor.h>
>  #include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/pwm.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/soc/qcom/qcom-pbs.h>
> =20
>  #define LPG_SUBTYPE_REG		0x05
>  #define  LPG_SUBTYPE_LPG	0x2
> @@ -39,6 +41,8 @@
>  #define PWM_SEC_ACCESS_REG	0xd0
>  #define PWM_DTEST_REG(x)	(0xe2 + (x) - 1)
> =20
> +#define SDAM_REG_PBS_SEQ_EN		0x42
> +
>  #define TRI_LED_SRC_SEL		0x45
>  #define TRI_LED_EN_CTL		0x46
>  #define TRI_LED_ATC_CTL		0x47
> @@ -48,9 +52,25 @@
> =20
>  #define LPG_RESOLUTION_9BIT	BIT(9)
>  #define LPG_RESOLUTION_15BIT	BIT(15)
> +#define PPG_MAX_LED_BRIGHTNESS	255
> +
>  #define LPG_MAX_M		7
>  #define LPG_MAX_PREDIV		6
> =20
> +#define DEFAULT_TICK_DURATION_US	7800
> +#define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) =
& 0xff)
> +
> +/* LPG common config settings for PPG */
> +#define SDAM_REG_RAMP_STEP_DURATION		0x47
> +#define SDAM_LPG_SDAM_LUT_PATTERN_OFFSET	0x80
> +
> +/* LPG per channel config settings for PPG */
> +#define SDAM_LUT_EN_OFFSET			0x0
> +#define SDAM_PATTERN_CONFIG_OFFSET		0x1
> +#define SDAM_END_INDEX_OFFSET			0x3
> +#define SDAM_START_INDEX_OFFSET		0x4
> +#define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
> +
>  struct lpg_channel;
>  struct lpg_data;
> =20
> @@ -64,6 +84,9 @@ struct lpg_data;
>   * @lut_base:	base address of the LUT block (optional)
>   * @lut_size:	number of entries in the LUT block
>   * @lut_bitmap:	allocation bitmap for LUT entries
> + * @pbs_dev:	PBS device
> + * @lpg_chan_sdam:	LPG SDAM peripheral device
> + * @pbs_en_bitmap:	bitmap for tracking PBS triggers
>   * @triled_base: base address of the TRILED block (optional)
>   * @triled_src:	power-source for the TRILED
>   * @triled_has_atc_ctl:	true if there is TRI_LED_ATC_CTL register
> @@ -85,6 +108,10 @@ struct lpg {
>  	u32 lut_size;
>  	unsigned long *lut_bitmap;
> =20
> +	struct pbs_dev *pbs_dev;
> +	struct nvmem_device *lpg_chan_sdam;
> +	unsigned long pbs_en_bitmap;
> +
>  	u32 triled_base;
>  	u32 triled_src;
>  	bool triled_has_atc_ctl;
> @@ -101,6 +128,7 @@ struct lpg {
>   * @triled_mask: mask in TRILED to enable this channel
>   * @lut_mask:	mask in LUT to start pattern generator for this channel
>   * @subtype:	PMIC hardware block subtype
> + * @sdam_offset:	channel offset in LPG SDAM
>   * @in_use:	channel is exposed to LED framework
>   * @color:	color of the LED attached to this channel
>   * @dtest_line:	DTEST line for output, or 0 if disabled
> @@ -129,6 +157,7 @@ struct lpg_channel {
>  	unsigned int triled_mask;
>  	unsigned int lut_mask;
>  	unsigned int subtype;
> +	u32 sdam_offset;
> =20
>  	bool in_use;
> =20
> @@ -178,10 +207,12 @@ struct lpg_led {
> =20
>  /**
>   * struct lpg_channel_data - per channel initialization data
> + * @sdam_offset:	Channel offset in LPG SDAM
>   * @base:		base address for PWM channel registers
>   * @triled_mask:	bitmask for controlling this channel in TRILED
>   */
>  struct lpg_channel_data {
> +	unsigned int sdam_offset;
>  	unsigned int base;
>  	u8 triled_mask;
>  };
> @@ -206,6 +237,52 @@ struct lpg_data {
>  	const struct lpg_channel_data *channels;
>  };
> =20
> +#define PBS_SW_TRIG_BIT		BIT(0)
> +
> +static int lpg_clear_pbs_trigger(struct lpg *lpg, unsigned int lut_mask)
> +{
> +	u8 val =3D 0;
> +	int rc;
> +
> +	lpg->pbs_en_bitmap &=3D (~lut_mask);
> +	if (!lpg->pbs_en_bitmap) {
> +		rc =3D nvmem_device_write(lpg->lpg_chan_sdam, SDAM_REG_PBS_SEQ_EN, 1, =
&val);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int lpg_set_pbs_trigger(struct lpg *lpg, unsigned int lut_mask)
> +{
> +	u8 val =3D PBS_SW_TRIG_BIT;
> +	int rc;
> +
> +	if (!lpg->pbs_en_bitmap) {
> +		rc =3D nvmem_device_write(lpg->lpg_chan_sdam, SDAM_REG_PBS_SEQ_EN, 1, =
&val);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc =3D qcom_pbs_trigger_event(lpg->pbs_dev, val);
> +		if (rc < 0)
> +			return rc;
> +	}
> +	lpg->pbs_en_bitmap |=3D lut_mask;
> +
> +	return 0;
> +}
> +
> +static int lpg_sdam_configure_triggers(struct lpg_channel *chan, u8 set_=
trig)
> +{
> +	u32 addr =3D SDAM_LUT_EN_OFFSET + chan->sdam_offset;
> +
> +	if (!chan->lpg->lpg_chan_sdam)
> +		return 0;
> +
> +	return nvmem_device_write(chan->lpg->lpg_chan_sdam, addr, 1, &set_trig)=
;
> +}
> +
>  static int triled_set(struct lpg *lpg, unsigned int mask, unsigned int e=
nable)
>  {
>  	/* Skip if we don't have a triled block */
> @@ -216,6 +293,40 @@ static int triled_set(struct lpg *lpg, unsigned int =
mask, unsigned int enable)
>  				  mask, enable);
>  }
> =20
> +static int lpg_lut_store_sdam(struct lpg *lpg, struct led_pattern *patte=
rn,
> +			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
> +{
> +	unsigned int idx;
> +	u8 brightness;
> +	int i, rc;
> +	u16 addr;
> +
> +	if (len > lpg->lut_size) {
> +		dev_err(lpg->dev, "Pattern length (%zu) exceeds maximum pattern length=
 (%d)\n",
> +			len, lpg->lut_size);
> +		return -EINVAL;
> +	}
> +
> +	idx =3D bitmap_find_next_zero_area(lpg->lut_bitmap, lpg->lut_size, 0, l=
en, 0);
> +	if (idx >=3D lpg->lut_size)
> +		return -ENOSPC;
> +
> +	for (i =3D 0; i < len; i++) {
> +		brightness =3D pattern[i].brightness;
> +		addr =3D SDAM_LPG_SDAM_LUT_PATTERN_OFFSET + i + idx;
> +		rc =3D nvmem_device_write(lpg->lpg_chan_sdam, addr, 1, &brightness);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
> +	bitmap_set(lpg->lut_bitmap, idx, len);
> +
> +	*lo_idx =3D idx;
> +	*hi_idx =3D idx + len - 1;
> +
> +	return 0;
> +}
> +
>  static int lpg_lut_store(struct lpg *lpg, struct led_pattern *pattern,
>  			 size_t len, unsigned int *lo_idx, unsigned int *hi_idx)
>  {
> @@ -256,6 +367,9 @@ static void lpg_lut_free(struct lpg *lpg, unsigned in=
t lo_idx, unsigned int hi_i
> =20
>  static int lpg_lut_sync(struct lpg *lpg, unsigned int mask)
>  {
> +	if (!lpg->lut_base)
> +		return 0;
> +
>  	return regmap_write(lpg->map, lpg->lut_base + RAMP_CONTROL_REG, mask);
>  }
> =20
> @@ -462,6 +576,28 @@ static void lpg_apply_pwm_value(struct lpg_channel *=
chan)
>  #define LPG_PATTERN_CONFIG_PAUSE_HI	BIT(1)
>  #define LPG_PATTERN_CONFIG_PAUSE_LO	BIT(0)
> =20
> +static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
> +{
> +	struct nvmem_device *lpg_chan_sdam =3D chan->lpg->lpg_chan_sdam;
> +	unsigned int lo_idx =3D chan->pattern_lo_idx;
> +	unsigned int hi_idx =3D chan->pattern_hi_idx;
> +	u8 val =3D 0, conf =3D 0;
> +
> +	if (!chan->ramp_enabled || chan->pattern_lo_idx =3D=3D chan->pattern_hi=
_idx)
> +		return;
> +
> +	if (!chan->ramp_oneshot)
> +		conf |=3D LPG_PATTERN_CONFIG_REPEAT;
> +
> +	nvmem_device_write(lpg_chan_sdam, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET +=
 chan->sdam_offset, 1, &val);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_PATTERN_CONFIG_OFFSET + chan->sd=
am_offset, 1, &conf);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_END_INDEX_OFFSET + chan->sdam_of=
fset, 1, &hi_idx);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_START_INDEX_OFFSET + chan->sdam_=
offset, 1, &lo_idx);
> +
> +	val =3D RAMP_STEP_DURATION(chan->ramp_tick_ms);
> +	nvmem_device_write(lpg_chan_sdam, SDAM_REG_RAMP_STEP_DURATION, 1, &val)=
;
> +}
> +
>  static void lpg_apply_lut_control(struct lpg_channel *chan)
>  {
>  	struct lpg *lpg =3D chan->lpg;
> @@ -597,7 +733,10 @@ static void lpg_apply(struct lpg_channel *chan)
>  	lpg_apply_pwm_value(chan);
>  	lpg_apply_control(chan);
>  	lpg_apply_sync(chan);
> -	lpg_apply_lut_control(chan);
> +	if (chan->lpg->lpg_chan_sdam)
> +		lpg_sdam_apply_lut_control(chan);
> +	else
> +		lpg_apply_lut_control(chan);
>  	lpg_enable_glitch(chan);
>  }
> =20
> @@ -622,6 +761,7 @@ static void lpg_brightness_set(struct lpg_led *led, s=
truct led_classdev *cdev,
>  			chan->ramp_enabled =3D false;
>  		} else if (chan->pattern_lo_idx !=3D chan->pattern_hi_idx) {
>  			lpg_calc_freq(chan, NSEC_PER_MSEC);
> +			lpg_sdam_configure_triggers(chan, 1);
> =20
>  			chan->enabled =3D true;
>  			chan->ramp_enabled =3D true;
> @@ -649,8 +789,10 @@ static void lpg_brightness_set(struct lpg_led *led, =
struct led_classdev *cdev,
>  		triled_set(lpg, triled_mask, triled_enabled);
> =20
>  	/* Trigger start of ramp generator(s) */
> -	if (lut_mask)
> +	if (lut_mask) {
>  		lpg_lut_sync(lpg, lut_mask);
> +		lpg_set_pbs_trigger(lpg, lut_mask);
> +	}
>  }
> =20
>  static int lpg_brightness_single_set(struct led_classdev *cdev,
> @@ -836,18 +978,23 @@ static int lpg_pattern_set(struct lpg_led *led, str=
uct led_pattern *led_pattern,
>  	 * If the specified pattern is a palindrome the ping pong mode is
>  	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
>  	 * last in the programmed pattern) determines the "high pause".
> +	 *
> +	 * SDAM-based devices do not support "ping-pong", "low pause" or "high =
pause"
>  	 */
> =20
>  	/* Detect palindromes and use "ping pong" to reduce LUT usage */
> -	for (i =3D 0; i < len / 2; i++) {
> -		brightness_a =3D pattern[i].brightness;
> -		brightness_b =3D pattern[len - i - 1].brightness;
> -
> -		if (brightness_a !=3D brightness_b) {
> -			ping_pong =3D false;
> -			break;
> +	if (lpg->lut_base) {
> +		for (i =3D 0; i < len / 2; i++) {
> +			brightness_a =3D pattern[i].brightness;
> +			brightness_b =3D pattern[len - i - 1].brightness;
> +
> +			if (brightness_a !=3D brightness_b) {
> +				ping_pong =3D false;
> +				break;
> +			}
>  		}
> -	}
> +	} else
> +		ping_pong =3D false;
> =20
>  	/* The pattern length to be written to the LUT */
>  	if (ping_pong)
> @@ -875,12 +1022,26 @@ static int lpg_pattern_set(struct lpg_led *led, st=
ruct led_pattern *led_pattern,
>  	if (delta_t >=3D BIT(9))
>  		goto out_free_pattern;
> =20
> -	/* Find "low pause" and "high pause" in the pattern */
> -	lo_pause =3D pattern[0].delta_t;
> -	hi_pause =3D pattern[actual_len - 1].delta_t;
> +	/*
> +	 * Find "low pause" and "high pause" in the pattern in the LUT case.
> +	 * SDAM-based devices require equal duration of all steps
> +	 */
> +	if (lpg->lut_base) {
> +		lo_pause =3D pattern[0].delta_t;
> +		hi_pause =3D pattern[actual_len - 1].delta_t;
> +	} else {
> +		if (delta_t !=3D pattern[0].delta_t || delta_t !=3D pattern[actual_len=
 - 1].delta_t)
> +			goto out_free_pattern;
> +	}
> +
> =20
>  	mutex_lock(&lpg->lock);
> -	ret =3D lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
> +
> +	if (lpg->lut_base)
> +		ret =3D lpg_lut_store(lpg, pattern, actual_len, &lo_idx, &hi_idx);
> +	else
> +		ret =3D lpg_lut_store_sdam(lpg, pattern, actual_len, &lo_idx, &hi_idx)=
;
> +
>  	if (ret < 0)
>  		goto out_unlock;
> =20
> @@ -928,7 +1089,12 @@ static int lpg_pattern_mc_set(struct led_classdev *=
cdev,
>  {
>  	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
>  	struct lpg_led *led =3D container_of(mc, struct lpg_led, mcdev);
> -	int ret;
> +	unsigned int triled_mask =3D 0;
> +	int ret, i;
> +
> +	for (i =3D 0; i < led->num_channels; i++)
> +		triled_mask |=3D led->channels[i]->triled_mask;
> +	triled_set(led->lpg, triled_mask, 0);
> =20
>  	ret =3D lpg_pattern_set(led, pattern, len, repeat);
>  	if (ret < 0)
> @@ -953,6 +1119,8 @@ static int lpg_pattern_clear(struct lpg_led *led)
> =20
>  	for (i =3D 0; i < led->num_channels; i++) {
>  		chan =3D led->channels[i];
> +		lpg_sdam_configure_triggers(chan, 0);
> +		lpg_clear_pbs_trigger(chan->lpg, chan->lut_mask);
>  		chan->pattern_lo_idx =3D 0;
>  		chan->pattern_hi_idx =3D 0;
>  	}
> @@ -1188,8 +1356,8 @@ static int lpg_add_led(struct lpg *lpg, struct devi=
ce_node *np)
>  		cdev->brightness_set_blocking =3D lpg_brightness_mc_set;
>  		cdev->blink_set =3D lpg_blink_mc_set;
> =20
> -		/* Register pattern accessors only if we have a LUT block */
> -		if (lpg->lut_base) {
> +		/* Register pattern accessors if we have a LUT block or when using PPG=
 */
> +		if (lpg->lut_base || lpg->lpg_chan_sdam) {
>  			cdev->pattern_set =3D lpg_pattern_mc_set;
>  			cdev->pattern_clear =3D lpg_pattern_mc_clear;
>  		}
> @@ -1202,15 +1370,19 @@ static int lpg_add_led(struct lpg *lpg, struct de=
vice_node *np)
>  		cdev->brightness_set_blocking =3D lpg_brightness_single_set;
>  		cdev->blink_set =3D lpg_blink_single_set;
> =20
> -		/* Register pattern accessors only if we have a LUT block */
> -		if (lpg->lut_base) {
> +		/* Register pattern accessors if we have a LUT block or when using PPG=
 */
> +		if (lpg->lut_base || lpg->lpg_chan_sdam) {
>  			cdev->pattern_set =3D lpg_pattern_single_set;
>  			cdev->pattern_clear =3D lpg_pattern_single_clear;
>  		}
>  	}
> =20
>  	cdev->default_trigger =3D of_get_property(np, "linux,default-trigger", =
NULL);
> -	cdev->max_brightness =3D LPG_RESOLUTION_9BIT - 1;
> +
> +	if (lpg->lpg_chan_sdam)
> +		cdev->max_brightness =3D PPG_MAX_LED_BRIGHTNESS;
> +	else
> +		cdev->max_brightness =3D LPG_RESOLUTION_9BIT - 1;
> =20
>  	if (!of_property_read_string(np, "default-state", &state) &&
>  	    !strcmp(state, "on"))
> @@ -1251,6 +1423,7 @@ static int lpg_init_channels(struct lpg *lpg)
>  		chan->base =3D data->channels[i].base;
>  		chan->triled_mask =3D data->channels[i].triled_mask;
>  		chan->lut_mask =3D BIT(i);
> +		chan->sdam_offset =3D data->channels[i].sdam_offset;
> =20
>  		regmap_read(lpg->map, chan->base + LPG_SUBTYPE_REG, &chan->subtype);
>  	}
> @@ -1297,11 +1470,12 @@ static int lpg_init_lut(struct lpg *lpg)
>  {
>  	const struct lpg_data *data =3D lpg->data;
> =20
> -	if (!data->lut_base)
> +	if (!data->lut_size)
>  		return 0;
> =20
> -	lpg->lut_base =3D data->lut_base;
>  	lpg->lut_size =3D data->lut_size;
> +	if (data->lut_base)
> +		lpg->lut_base =3D data->lut_base;
> =20
>  	lpg->lut_bitmap =3D devm_bitmap_zalloc(lpg->dev, lpg->lut_size, GFP_KER=
NEL);
>  	if (!lpg->lut_bitmap)
> @@ -1310,6 +1484,48 @@ static int lpg_init_lut(struct lpg *lpg)
>  	return 0;
>  }
> =20
> +static int lpg_init_sdam(struct lpg *lpg)
> +{
> +	int i, sdam_count, rc;
> +	u8 val =3D 0;
> +
> +	sdam_count =3D of_property_count_strings(lpg->dev->of_node, "nvmem-name=
s");
> +	if (sdam_count <=3D 0)
> +		return 0;
> +
> +	/* Get the SDAM device for LPG/LUT config */
> +	lpg->lpg_chan_sdam =3D devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam")=
;
> +	if (IS_ERR(lpg->lpg_chan_sdam))
> +		return dev_err_probe(lpg->dev, PTR_ERR(lpg->lpg_chan_sdam),
> +				"Failed to get LPG chan SDAM device\n");
> +
> +	lpg->pbs_dev =3D get_pbs_client_device(lpg->dev);
> +	if (IS_ERR(lpg->pbs_dev))
> +		return dev_err_probe(lpg->dev, PTR_ERR(lpg->pbs_dev),
> +				"Failed to get PBS client device\n");
> +
> +	for (i =3D 0; i < lpg->num_channels; i++) {
> +		struct lpg_channel *chan =3D &lpg->channels[i];
> +
> +		if (chan->sdam_offset) {
> +			rc =3D nvmem_device_write(lpg->lpg_chan_sdam,
> +				SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 1, &val);
> +			if (rc < 0)
> +				return rc;
> +
> +			rc =3D lpg_sdam_configure_triggers(chan, 0);
> +			if (rc < 0)
> +				return rc;
> +
> +			rc =3D lpg_clear_pbs_trigger(chan->lpg, chan->lut_mask);
> +			if (rc < 0)
> +				return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int lpg_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
> @@ -1346,6 +1562,10 @@ static int lpg_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D lpg_init_sdam(lpg);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret =3D lpg_init_lut(lpg);
>  	if (ret < 0)
>  		return ret;

