Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AEE77CFFC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbjHOQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjHOQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:14:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128398;
        Tue, 15 Aug 2023 09:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C50F65901;
        Tue, 15 Aug 2023 16:14:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA68C433C8;
        Tue, 15 Aug 2023 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692116071;
        bh=ZA+SlCsBMcnj/rlUUuHXJT4uMLI0+8HJJCCwjUgVjFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jiXjZ/81Cq1PNFPGEq8fDFH9sKNNd9snIxjKN94/udALhDGffa5XO8k6sSggzXt7Q
         dUTHTmc2oD4jtfaMh9mnRRGjNKR5iHe8gNc8aTryVXvvGCcJozWt5Q0b9V9rNyZA4c
         Pzov2uJeQ6YfHGRKAEdQLgX5fhdbUozgnsYv8BEJEahk3Tn+9Qb13ZpKhqtTZKPiQi
         ffpGYM8muRKPD7U+I5NDrSY/B00x46Y0uMX8Kdj2ORT4CDGVzQeMQAyK38mRTKPS1H
         /0Im8Y0PCxOgrIjQSWs8AEfdEr7+sMjc5vSJgvrCpI+VIMAG9J98mqqYFvMoQvdCQ6
         bV6JU3T2nLmLw==
Date:   Tue, 15 Aug 2023 09:17:15 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Anjelique Melendez <quic_amelende@quicinc.com>
Cc:     pavel@ucw.cz, lee@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, agross@kernel.org, luca.weiss@fairphone.com,
        konrad.dybcio@linaro.org, u.kleine-koenig@pengutronix.de,
        quic_subbaram@quicinc.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v3 6/7] leds: rgb: leds-qcom-lpg: Support two-nvmem PPG
 Scheme
Message-ID: <ho2oldc5dgwc274tc7unxuw6dymaz4i6amssfnkaauxhgzmjqx@in7yjuhyezm6>
References: <20230814235918.10396-1-quic_amelende@quicinc.com>
 <20230814235918.10396-7-quic_amelende@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814235918.10396-7-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:59:17PM -0700, Anjelique Melendez wrote:
> On PMICs such as PM8350C, the lookup table containing the pattern data
> is stored in a separate nvmem device from the one where the per-channel

I think it would be better to say "separate SDAM" instead of "separate
nvmem device", to make it clearer to the reader what's being done.

> data is stored.
> 
> Add support for two separate nvmems to handle this case while maintaining

You're only adding the support for the dedicated LUT SDAM, not "for two
separate nvmems".

> backward compatibility for those targets that use only a single nvmem
> device.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>

If Guru was the first to sign off the change, then he must have authored
the patch. Or add a Co-developed-by if that's appropriate.

> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
> ---
>  drivers/leds/rgb/leds-qcom-lpg.c | 112 ++++++++++++++++++++++++-------
>  1 file changed, 89 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
> index 822c7bff00df..f3f83925ab41 100644
> --- a/drivers/leds/rgb/leds-qcom-lpg.c
> +++ b/drivers/leds/rgb/leds-qcom-lpg.c
> @@ -60,6 +60,7 @@
>  #define RAMP_STEP_DURATION(x)		(((x) * 1000 / DEFAULT_TICK_DURATION_US) & 0xff)
>  
>  /* LPG common config settings for PPG */
> +#define SDAM_START_BASE			0x40

I really wish that we hid this offset in the SDAM nvmem driver - but
that ship has sailed...

>  #define SDAM_REG_RAMP_STEP_DURATION		0x47
>  #define SDAM_LUT_COUNT_MAX			64
>  
> @@ -69,6 +70,8 @@
>  #define SDAM_END_INDEX_OFFSET			0x3
>  #define SDAM_START_INDEX_OFFSET		0x4
>  #define SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET	0x6
> +#define SDAM_PAUSE_HI_MULTIPLIER_OFFSET	0x8
> +#define SDAM_PAUSE_LO_MULTIPLIER_OFFSET	0x9
>  
>  struct lpg_channel;
>  struct lpg_data;
> @@ -85,7 +88,9 @@ struct lpg_data;
>   * @lut_bitmap:	allocation bitmap for LUT entries
>   * @pbs_dev:	PBS device
>   * @lpg_chan_nvmem:	LPG nvmem peripheral device
> + * @lut_nvmem:	LUT nvmem peripheral device
>   * @pbs_en_bitmap:	bitmap for tracking PBS triggers
> + * @nvmem_count:	number of nvmems used for LUT and PPG config

I find the concept of "how many nvmem do we have" slightly unclear.
Perhaps we could split this that into two separate boolean properties,
something like use_sdam and use_sdam_lut?


On the other hand, use_sdam and use_sdam_lut should afaict always be
equal to lpg_chan_nvmem != NULL and lut_nvmem != NULL. So you could use
these directly instead.

>   * @lut_sdam_base:	offset where LUT pattern begins in nvmem
>   * @ppg_en:	Flag indicating whether PPG is enabled/used
>   * @triled_base:	base address of the TRILED block (optional)
> @@ -111,7 +116,9 @@ struct lpg {
>  
>  	struct pbs_dev *pbs_dev;
>  	struct nvmem_device *lpg_chan_nvmem;
> +	struct nvmem_device *lut_nvmem;
>  	unsigned long pbs_en_bitmap;
> +	unsigned int nvmem_count;
>  	u32 lut_sdam_base;
>  	bool ppg_en;
>  
> @@ -261,6 +268,8 @@ static int lpg_sdam_write(struct lpg *lpg, u16 addr, u8 val)
>  }
>  
>  #define SDAM_REG_PBS_SEQ_EN		0x42
> +#define SDAM_PBS_TRIG_SET		0xe5
> +#define SDAM_PBS_TRIG_CLR		0xe6

Please add these at the top, like requested in the previous patch.

>  #define PBS_SW_TRIG_BIT		BIT(0)
>  
[..]
>  static void lpg_sdam_apply_lut_control(struct lpg_channel *chan)
>  {
>  	u8 val, conf = 0;
> +	unsigned int hi_pause, lo_pause;
>  	struct lpg *lpg = chan->lpg;
>  
> +	hi_pause = DIV_ROUND_UP(chan->ramp_hi_pause_ms, chan->ramp_tick_ms);
> +	lo_pause = DIV_ROUND_UP(chan->ramp_lo_pause_ms, chan->ramp_tick_ms);
> +
>  	if (!chan->ramp_oneshot)
>  		conf |= LPG_PATTERN_CONFIG_REPEAT;
> +	if (chan->ramp_hi_pause_ms && lpg->nvmem_count != 1)
> +		conf |= LPG_PATTERN_CONFIG_PAUSE_HI;
> +	if (chan->ramp_lo_pause_ms && lpg->nvmem_count != 1)
> +		conf |= LPG_PATTERN_CONFIG_PAUSE_LO;
>  
>  	lpg_sdam_write(lpg, SDAM_PBS_SCRATCH_LUT_COUNTER_OFFSET + chan->sdam_offset, 0);
>  	lpg_sdam_write(lpg, SDAM_PATTERN_CONFIG_OFFSET + chan->sdam_offset, conf);
>  
> -	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset, chan->pattern_hi_idx);
> -	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset, chan->pattern_lo_idx);
> +	val = lpg_get_sdam_lut_idx(chan, chan->pattern_hi_idx);

I'd suggest adding a local variable "lut_offset" to the values here,
instead of calling out to a separate function to perhaps adjust the
values.

> +	lpg_sdam_write(lpg, SDAM_END_INDEX_OFFSET + chan->sdam_offset, val);
> +
> +	val = lpg_get_sdam_lut_idx(chan, chan->pattern_lo_idx);
> +	lpg_sdam_write(lpg, SDAM_START_INDEX_OFFSET + chan->sdam_offset, val);
>  
>  	val = RAMP_STEP_DURATION(chan->ramp_tick_ms);
>  	if (val > 0)
>  		val--;
>  	lpg_sdam_write(lpg, SDAM_REG_RAMP_STEP_DURATION, val);
> +
> +	if (lpg->nvmem_count != 1) {
> +		lpg_sdam_write(lpg, SDAM_PAUSE_HI_MULTIPLIER_OFFSET + chan->sdam_offset, hi_pause);
> +		lpg_sdam_write(lpg, SDAM_PAUSE_LO_MULTIPLIER_OFFSET + chan->sdam_offset, lo_pause);
> +	}
> +
>  }
>  
>  static void lpg_apply_lut_control(struct lpg_channel *chan)
> @@ -1000,8 +1050,8 @@ static int lpg_pattern_set(struct lpg_led *led, struct led_pattern *led_pattern,
>  	 * enabled. In this scenario the delta_t of the middle entry (i.e. the
>  	 * last in the programmed pattern) determines the "high pause".
>  	 *
> -	 * NVMEM devices supporting LUT do not support "low pause", "high pause"
> -	 * or "ping pong"
> +	 * All NVMEM devices supporting LUT do not support "ping pong"
> +	 * Single NVMEM devices supporting LUT do not support "low pause" and "high pause"

How about: "SDAM-based devices does not support "ping pong", and only
supports "low pause" and "high pause" with dedicated SDAM LUT." ?

>  	 */
>  
>  	/* Detect palindromes and use "ping pong" to reduce LUT usage */
[..]
> @@ -1509,29 +1559,45 @@ static int lpg_parse_sdam(struct lpg *lpg)
>  {
>  	int rc = 0;
>  
> -	if (lpg->data->nvmem_count == 0)
> +	lpg->nvmem_count = lpg->data->nvmem_count;
> +	if (lpg->nvmem_count == 0)
>  		return 0;
>  
> -	/* get the nvmem device for LPG/LUT config */
> +	if (lpg->nvmem_count > 2)
> +		return -EINVAL;
> +
> +	/* get the 1st nvmem device for LPG/LUT config */
>  	lpg->lpg_chan_nvmem = devm_nvmem_device_get(lpg->dev, "lpg_chan_sdam");
>  	if (IS_ERR(lpg->lpg_chan_nvmem)) {
>  		rc = PTR_ERR(lpg->lpg_chan_nvmem);
> -		if (rc != -EPROBE_DEFER)
> -			dev_err(lpg->dev, "Failed to get nvmem device, rc=%d\n", rc);
> -		return rc;
> +		goto err;
>  	}
>  
> -	lpg->pbs_dev = get_pbs_client_device(lpg->dev);
> -	if (IS_ERR(lpg->pbs_dev)) {
> -		rc = PTR_ERR(lpg->pbs_dev);
> -		if (rc != -EPROBE_DEFER)
> -			dev_err(lpg->dev, "Failed to get PBS client device, rc=%d\n", rc);
> -		return rc;
> +	if (lpg->nvmem_count == 1) {
> +		/* get PBS device node if single NVMEM device */
> +		lpg->pbs_dev = get_pbs_client_device(lpg->dev);
> +		if (IS_ERR(lpg->pbs_dev)) {
> +			rc = PTR_ERR(lpg->pbs_dev);
> +			if (rc != -EPROBE_DEFER)
> +				dev_err(lpg->dev, "Failed to get PBS client device, rc=%d\n", rc);
> +			return rc;

return dev_err_probe() please.

> +		}
> +	} else if (lpg->nvmem_count == 2) {
> +		/* get the 2nd nvmem device for LUT pattern */
> +		lpg->lut_nvmem = devm_nvmem_device_get(lpg->dev, "lut_sdam");
> +		if (IS_ERR(lpg->lut_nvmem)) {
> +			rc = PTR_ERR(lpg->lut_nvmem);
> +			goto err;
> +		}
>  	}
>  
>  	lpg->ppg_en = true;
>  
>  	return rc;

rc is still 0 here.

> +err:
> +	if (rc != -EPROBE_DEFER)
> +		dev_err(lpg->dev, "Failed to get nvmem device, rc=%d\n", rc);

The idiomatic usage of goto is to share error handling, and release
resources in a reverse order that they where acquired. It's therefor
going to confuse future readers when you do:

if (error)
  goto err;

if (error2)
  return rc;

if (error3)
  goto err;


But more importantly, this error message gives no indication about which
nvmem device the driver failed to find. If you move the error print up,
and use dev_err_probe() the code will be easier to follow and you can
afford making the error message more helpful.

Regards,
Bjorn
