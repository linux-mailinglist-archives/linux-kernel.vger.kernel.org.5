Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7257F754A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGOQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGOQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:59:00 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD62211F;
        Sat, 15 Jul 2023 09:58:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so2035122b3a.0;
        Sat, 15 Jul 2023 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689440338; x=1692032338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pU7ac+9pDZ4Mqla5h1KE9SHucYdisyawSiO9AoaaMOY=;
        b=YPyf3URfcAVoWfNhouyN06BfQSeWKGhVshmAFjprQgqP0aVjYzlHsKAuWbQ6M408er
         ozqNNU4EBQ0pU+u1mwGpkirEbHIuMaecgkwmwkaZb+va43pCHQZ9l5KsVl7G0stqurd8
         604OsGM1zO9mZ/YD7aHP4wipGR6db0OsRlg4T3FAVqqdHESwa/Nn/fqglQilg7hniTOj
         lXB8TAGkJ4P3Os7+aVLgI9DFQESLd9TklIjRXaEZCmjpY764FYbb/JmE52C1igdJKFf+
         4V48OKsjkVRpcI13S789vjHwz88m3QkINZm+5rIWt3OgbZDwiEAJdq15lCTnA9phFav3
         WEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689440338; x=1692032338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pU7ac+9pDZ4Mqla5h1KE9SHucYdisyawSiO9AoaaMOY=;
        b=hTmeFJRzcEtKLg/+GbHePq58YtiwNRwcpRf4gV1TdEomN+TQ3ZeJnThmYGiBghGDGP
         Tw1up0UuEHPHxVVIKs+RpYxIqdL1sL+pgTKmSLJp4uzejMT3ki6bYBFJHAv8zdMKSXqB
         77ISc8ezSrw86FdXR7yM5dFC5MvZcXC7Ap/Ef/IQ1DeVmrLvdA0FXKLfdfFqT3SckDti
         JH47jFOVquCZFDPX4z2xBg3zBvGxY7lbt7q8d2lvLHl/qsPxftS/D5e50e/PJlNpTYMr
         2XPcv0Rb0BCM3eskZ6RkYHZoZFOoI4dWDbmenNiTaJHd1ciVmu0FG3ZMpshCOqtqpn/U
         IuNg==
X-Gm-Message-State: ABy/qLYkc2hh8JbnR5Q7nYwh4NOAQfzKfc/KTnVPFI8mLShDbPzWgiFn
        BcBrfUe+ZfTgC7pYTQsd4oo=
X-Google-Smtp-Source: APBJJlFhMaVLXopI1t7xBtWfMwS6HNPY/DVNEZC5AjOCySjMncZRNjzaYJJTicjtzpQh5n7vXXhB2g==
X-Received: by 2002:a05:6a00:23c2:b0:680:fa5f:4ed6 with SMTP id g2-20020a056a0023c200b00680fa5f4ed6mr8781186pfc.27.1689440338466;
        Sat, 15 Jul 2023 09:58:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m17-20020a637111000000b0051b8172fa68sm9521718pgc.38.2023.07.15.09.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:58:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 15 Jul 2023 09:58:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH] hwmon: (dimmtemp) Support more than 32 DIMMs
Message-ID: <16080951-743c-4f3c-bec2-153ff38d922f@roeck-us.net>
References: <20230711152144.755177-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711152144.755177-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 05:21:43PM +0200, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> This patch introduces support for handling more than 32 DIMMs by
> utilizing bitmap operations. The changes ensure that the driver can
> handle a higher number of DIMMs efficiently.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>

Applied to hwmon-next.

Note: I got multiple versions of this patch. In the future
please version your patches and provide change logs.

Thanks,
Guenter

> ---
>  drivers/hwmon/peci/dimmtemp.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 4dbbaf8fbdbd13adc80731b2452257857e4c2d8b
> 
> diff --git a/drivers/hwmon/peci/dimmtemp.c b/drivers/hwmon/peci/dimmtemp.c
> index ed968401f93c..ce89da3937a0 100644
> --- a/drivers/hwmon/peci/dimmtemp.c
> +++ b/drivers/hwmon/peci/dimmtemp.c
> @@ -219,19 +219,21 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
>  {
>  	int chan_rank_max = priv->gen_info->chan_rank_max;
>  	int dimm_idx_max = priv->gen_info->dimm_idx_max;
> -	u32 chan_rank_empty = 0;
> -	u32 dimm_mask = 0;
> -	int chan_rank, dimm_idx, ret;
> +	DECLARE_BITMAP(dimm_mask, DIMM_NUMS_MAX);
> +	DECLARE_BITMAP(chan_rank_empty, CHAN_RANK_MAX);
> +
> +	int chan_rank, dimm_idx, ret, i;
>  	u32 pcs;
>  
> -	BUILD_BUG_ON(BITS_PER_TYPE(chan_rank_empty) < CHAN_RANK_MAX);
> -	BUILD_BUG_ON(BITS_PER_TYPE(dimm_mask) < DIMM_NUMS_MAX);
>  	if (chan_rank_max * dimm_idx_max > DIMM_NUMS_MAX) {
>  		WARN_ONCE(1, "Unsupported number of DIMMs - chan_rank_max: %d, dimm_idx_max: %d",
>  			  chan_rank_max, dimm_idx_max);
>  		return -EINVAL;
>  	}
>  
> +	bitmap_zero(dimm_mask, DIMM_NUMS_MAX);
> +	bitmap_zero(chan_rank_empty, CHAN_RANK_MAX);
> +
>  	for (chan_rank = 0; chan_rank < chan_rank_max; chan_rank++) {
>  		ret = peci_pcs_read(priv->peci_dev, PECI_PCS_DDR_DIMM_TEMP, chan_rank, &pcs);
>  		if (ret) {
> @@ -242,7 +244,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
>  			 * detection to be performed at a later point in time.
>  			 */
>  			if (ret == -EINVAL) {
> -				chan_rank_empty |= BIT(chan_rank);
> +				bitmap_set(chan_rank_empty, chan_rank, 1);
>  				continue;
>  			}
>  
> @@ -251,7 +253,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
>  
>  		for (dimm_idx = 0; dimm_idx < dimm_idx_max; dimm_idx++)
>  			if (__dimm_temp(pcs, dimm_idx))
> -				dimm_mask |= BIT(chan_rank * dimm_idx_max + dimm_idx);
> +				bitmap_set(dimm_mask, chan_rank * dimm_idx_max + dimm_idx, 1);
>  	}
>  
>  	/*
> @@ -260,7 +262,7 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
>  	 * host platform boot. Retrying a couple of times lets us make sure
>  	 * that the state is persistent.
>  	 */
> -	if (chan_rank_empty == GENMASK(chan_rank_max - 1, 0)) {
> +	if (bitmap_full(chan_rank_empty, chan_rank_max)) {
>  		if (priv->no_dimm_retry_count < NO_DIMM_RETRY_COUNT_MAX) {
>  			priv->no_dimm_retry_count++;
>  
> @@ -274,14 +276,16 @@ static int check_populated_dimms(struct peci_dimmtemp *priv)
>  	 * It's possible that memory training is not done yet. In this case we
>  	 * defer the detection to be performed at a later point in time.
>  	 */
> -	if (!dimm_mask) {
> +	if (bitmap_empty(dimm_mask, DIMM_NUMS_MAX)) {
>  		priv->no_dimm_retry_count = 0;
>  		return -EAGAIN;
>  	}
>  
> -	dev_dbg(priv->dev, "Scanned populated DIMMs: %#x\n", dimm_mask);
> +	for_each_set_bit(i, dimm_mask, DIMM_NUMS_MAX) {
> +		dev_dbg(priv->dev, "Found DIMM%#x\n", i);
> +	}
>  
> -	bitmap_from_arr32(priv->dimm_mask, &dimm_mask, DIMM_NUMS_MAX);
> +	bitmap_copy(priv->dimm_mask, dimm_mask, DIMM_NUMS_MAX);
>  
>  	return 0;
>  }
