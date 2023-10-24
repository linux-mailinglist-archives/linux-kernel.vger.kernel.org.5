Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1210C7D4724
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 07:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbjJXFzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 01:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjJXFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 01:55:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25961139
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:55:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32daeed7771so2726318f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 22:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698126929; x=1698731729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRKAq32kiO8SHEJdnq8IZIE4OyF7eOxyRpbcJQrGcHc=;
        b=foHyIBuzRQxjus4VWScbugguROw596fMtWa7AwrGCwots+9gZ8Gmc2g+yB/lFrCUSY
         nDbKg7CGdZ6Ewo1tetnMMUiYJHRVVHIKnRH9goUwRkqDiOJkN4dqyeHDyXwemUnUcBm3
         zHyYXCBm4Iw3g4UbjAXaIHwSkdKm/XSseYdI/16Pdukbsc7BbVKqc5JGBpDB89jHMF9s
         /pvpTQNYmd8NRG7qSzOglEqexCciYx7+FoPYwD20AyvGfU4hKRjBLqlh9T1tNcpAab2m
         ASEoXN3P345q4opwzITxi0ET2uLlJXM93XyD/PklOxpcGC2Ijs9HsUcj5TYW9bIGMhDo
         v4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698126929; x=1698731729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRKAq32kiO8SHEJdnq8IZIE4OyF7eOxyRpbcJQrGcHc=;
        b=T8eNGATOySF1+QwYhFDrrfWCUn+FDqrm3OjXNV6A/cvNRGuP4OG5ONP72MB2G0T+Tl
         xVFFYtgUlmJipAWjCxHRQBFZj1H1rloD0JPVnZZ/hXv9IHRElA3rf0weuuFnDgVUTlbs
         d2LlpQpP49gnos66T8V7yB9S9JZc3+tx39EwtWuJXECMsL2Xtc5piek/SwR49FXFOV+w
         5XCXdOeavpSb7qFL2lcKf2xnIX0H5l/HMWwxCc5Nqe6FMoYO8oVmrFwaxiUVRGjiiSQs
         AV5GihGIxi40H0DAoRpnwOPrN9rlP8O2FqybYbuG4hOCQEtUrdA3LZcmfiYJCHHujYjU
         4FJw==
X-Gm-Message-State: AOJu0YwIGV5EBfmnCtCBkchmEJ2y9G2noQdnC65a5AtiXC8PZywB7p4h
        MAiCXK1MBf3Vz1cC7NkpPp6Zdw==
X-Google-Smtp-Source: AGHT+IFL+Yalmba6O5qvPo/OHqywkkRoLeTLgboMat0T78uwgR8AaQMIHrMeEb/tY3FwqMKnyi2Dcw==
X-Received: by 2002:adf:e4cc:0:b0:32d:a3c5:ea80 with SMTP id v12-20020adfe4cc000000b0032da3c5ea80mr7126077wrm.51.1698126929400;
        Mon, 23 Oct 2023 22:55:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n15-20020adfe78f000000b003197869bcd7sm9174110wrm.13.2023.10.23.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 22:55:29 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:55:25 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 2/4] ACPI: sysfs: Fix a potential out-of-bound write in
 create_of_modalias()
Message-ID: <df33bc21-4792-4395-bbe0-4c8893818f6b@kadam.mountain>
References: <cover.1698081019.git.christophe.jaillet@wanadoo.fr>
 <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a9aa85dcc37d112443e133c9edfd7624cd47b.1698081019.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 09:33:16PM +0200, Christophe JAILLET wrote:
> The remaining size of the buffer used by snprintf() is not updated after
> the first write, so subsequent write in the 'for' loop a few lines below
> can write some data past the end of the 'modalias' buffer.
> 
> Correctly update the remaining size.
> 
> Note that this pattern is already correctly written in
> create_pnp_modalias().
> 
> Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/acpi/device_sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> index 4deb36dccb73..7ec3142f3eda 100644
> --- a/drivers/acpi/device_sysfs.c
> +++ b/drivers/acpi/device_sysfs.c
> @@ -215,6 +215,8 @@ static int create_of_modalias(const struct acpi_device *acpi_dev, char *modalias
>  	if (len >= size)
>  		return -ENOMEM;
>  
> +	size -= len;
> +

Yeah.  This is a good bugfix but it also shows why the canonical format
is better.  In the canonical format the "size - len" happens as part of
snprintf() instead of on a separate line where it can be forgotten.

	len += snprintf(buf + len, size - len, "string");

Also the user space version of snprintf() can fail but the
kernel space version can't.  This code is more complicated and introduces
a memory corruption bug because it is pretending that we need to check
for negatives.  People (someone) sometimes (once ten years ago) tell me
that checking for negatives is important for security but actually it's
the reverse.

regards,
dan carpenter

