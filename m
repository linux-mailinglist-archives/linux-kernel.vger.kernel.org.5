Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550577B65CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239796AbjJCJrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjJCJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:47:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6438FAB;
        Tue,  3 Oct 2023 02:46:55 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50433d8385cso878664e87.0;
        Tue, 03 Oct 2023 02:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696326413; x=1696931213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pjcnc813AQNriCrzkI748osWJLP9CPteXDrIUaw4UpI=;
        b=Q9rf7tygJX92aFz4FO7hklhFg0b0v6p13iEY+Zy4x1p/cZUb6GMe7OUZZaPxF8JFoy
         m4IKn8fEjcXPbCBd6zu/ZOs+5hmDa+nsnXX7VKMLVaC/R1NslILAxVlxtMf6Hu3lMuLW
         H3XwXpx1KVQpo1qGVcCYA6ja6aw6rd4mMdWx0g5bF7YZ4nWbtpxkpChWIkGrcq2ioQbY
         BcEK9IWqcreJCSP+eOK2BMcamVNKNYf7djiLdP3/APEaSexUmtMCJybehXG67FOdLEnq
         3HId3JL3ix2Yz572KeQPyfBmce7n97j4WzLyZBRuj3m9IGHRkLmg7R399jnwmIQAX8GQ
         zkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696326413; x=1696931213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pjcnc813AQNriCrzkI748osWJLP9CPteXDrIUaw4UpI=;
        b=DjWi1bOV85LCge0+SYQa62uAavVAfBmq6xpEr0uQtEbrl6O3MSTrF/BFNw1Y4xeLR8
         jnhUZTubM3DbB9GNM90LE0EMc+Wv6IwnTTh1TZTsya74FIiYZ6ydRroWGD0zljIf+ehg
         qwY0qcurZVVRJWd8lufIyaSZL3j9QJazg+Rb+2G+7248mvP4NBs0sBZAHli1pUX/owOL
         /iGMSYx3TR25O6ykLfD5CbdwSp/ZYcVdKOHkL8l0XcXhjnvRuFtH9nctDVqlckrPqnOn
         Z2m3g4RSmRgcU+vwY2VtznMUYog05Yf8rLUNHt1zzLCcU7d1J4BNkSDbQugJrGJ1O6gU
         YIqw==
X-Gm-Message-State: AOJu0YzIQyePgkdJEvl3wjyMsbzHU2p0OwP2LcDr8N0VzSwNS7FWPRCU
        SRA5ah88juL7bV+zsxvB+eCzo0TLubc=
X-Google-Smtp-Source: AGHT+IFmixYJy0/vl5++bZej9bmelyUH6l5bptdqRMseLCH6t6Z/KZJOPQQILa9NWs1cuYRByRotLQ==
X-Received: by 2002:ac2:46ee:0:b0:502:bdbd:8442 with SMTP id q14-20020ac246ee000000b00502bdbd8442mr12369581lfo.50.1696326413383;
        Tue, 03 Oct 2023 02:46:53 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::7? (dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::7])
        by smtp.gmail.com with ESMTPSA id w20-20020ac254b4000000b00505656b98adsm129884lfk.245.2023.10.03.02.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 02:46:52 -0700 (PDT)
Message-ID: <e1aca4f0-d705-ba13-c391-ffe251803ef3@gmail.com>
Date:   Tue, 3 Oct 2023 12:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5] tools: iio: iio_generic_buffer ensure alignment
Content-Language: en-US, en-GB
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZRq9lm/C7g9m9zen@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZRq9lm/C7g9m9zen@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 15:54, Matti Vaittinen wrote:
> The iio_generic_buffer can return garbage values when the total size of
> scan data is not a multiple of the largest element in the scan. This can be
> demonstrated by reading a scan, consisting, for example of one 4-byte and
> one 2-byte element, where the 4-byte element is first in the buffer.
> 
> The IIO generic buffer code does not take into account the last two
> padding bytes that are needed to ensure that the 4-byte data for next
> scan is correctly aligned.
> 
> Add the padding bytes required to align the next sample with the scan size.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e58537ccce73 ("staging: iio: update example application.")
> 
> ---
> Revision history
> v4 => v5:
>   - drop unnecessary comment.
>   - drop all other patches as those were already applied.
>   - add Fixes-tag.
> v3 => v4:
>   - drop extra print and TODO coment
>   - add comment clarifying alignment sizes
> ---
>   tools/iio/iio_generic_buffer.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 44bbf80f0cfd..c1c037ee0071 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -54,9 +54,12 @@ enum autochan {
>   static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>   {
>   	unsigned int bytes = 0;
> -	int i = 0;
> +	int i = 0, max = 0;
> +	unsigned int misalignment;
>   
>   	while (i < num_channels) {
> +		if (channels[i].bytes > max)
> +			max = channels[i].bytes;
>   		if (bytes % channels[i].bytes == 0)
>   			channels[i].location = bytes;
>   		else
> @@ -66,6 +69,14 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
>   		bytes = channels[i].location + channels[i].bytes;
>   		i++;
>   	}
> +	/*
> +	 * We wan't the data in next sample to also be properly aligned so

I just realized I didn't fix the typo mentioned by Andy. I can re-spin 
this with wan't => want. Sorry!

> +	 * we'll add padding at the end if needed. Adding padding only
> +	 * works for channel data which size is 2^n bytes.
> +	 */
> +	misalignment = bytes % max;
> +	if (misalignment)
> +		bytes += max - misalignment;
>   
>   	return bytes;
>   }
> 
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

