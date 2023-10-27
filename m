Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77467D935E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbjJ0JTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0JTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:19:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4810C0;
        Fri, 27 Oct 2023 02:19:47 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9c5a1b87bso14768975ad.3;
        Fri, 27 Oct 2023 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698398387; x=1699003187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lgS/jv4cYftJ2VLUevuTOfk+YPF/Cr+9ApUFZyAn5kY=;
        b=E9Kr8zGzE1teTKllp+omg0ouqFAcCURJePI/9VSGJ+Y65S2mFrydD9z3NzGdke4YUj
         fziuA4OTc/LWg7fGUgS4iQ1N4MB+SG9gJlvcmsX8FdHzS2/M82nJkmJTxSKs1KhVWwFF
         WCM5WEdOfEEBgjawi24l/po6cMLKszuiNhW4aRtuktd+jBkulnv9Ev2k0XquHnAR9DnE
         HgVRstd9MOYFbHTRFZCSLY0yfvszwEba2AZ6Q4nHMX6eQB0IYE7kBioN+h+G/icLsw+q
         vzo33ZRXlk3OVVOFPkBSUh9saUHmJ7d2ZONbXy8Sruie/mGz7Swm08TKy8ywYDOIrUAs
         O2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698398387; x=1699003187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgS/jv4cYftJ2VLUevuTOfk+YPF/Cr+9ApUFZyAn5kY=;
        b=rsx4mnljWs2zL1I7O4NyiY8ZnpISgKqywI/ktvUkhAL89UPnJTIU1o/0gHSUZJvPWc
         RYgs6jnXxcDDR1dDJPrh0D6CKr+wYcIOzQym5xjMPyeEWTZLTgg97i1DRjVAv5Dinx6h
         m2y+T15snaB8ivU8FRoUlA77PEKiNz1mb/0ntRJB8fCZFgtehmmHcnk3jHHk21XO9DNY
         KjJoRpp/p38HoySIFzOCwaq66O7uWdxFSmJ00a5EqbkewoK8uRNcnq2u0P/fLuyAeSaT
         U2l7FCS2GqNa27pw4ODJBQZKuVjrw0XmfB+Izx2mv5fmM1Wb4aFkkqyMbmUeW004bzQy
         0eqw==
X-Gm-Message-State: AOJu0YxlDPrnV3eqq9INJuWp8mSZdFBYBcnQ2jZMi8Xi6B9qv91LQijw
        RVnjwmQ88ft9Sgrz9iMrJFa0534LOKw=
X-Google-Smtp-Source: AGHT+IFyLx0K5l+UJCFp4j2n94XOj6IorEXPbv6ik/fLme4I9EoaFoND6iGxyz1U1qz/lqHAnlOSaA==
X-Received: by 2002:a17:902:e2d1:b0:1cc:2a23:cbb4 with SMTP id l17-20020a170902e2d100b001cc2a23cbb4mr50155plc.35.1698398387235;
        Fri, 27 Oct 2023 02:19:47 -0700 (PDT)
Received: from ?IPV6:2409:40f4:13:48d5:c971:7c89:5be7:c8a2? ([2409:40f4:13:48d5:c971:7c89:5be7:c8a2])
        by smtp.gmail.com with ESMTPSA id j8-20020a170902da8800b001b392bf9192sm1081387plx.145.2023.10.27.02.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 02:19:46 -0700 (PDT)
Message-ID: <641f90da-332a-4021-869e-fdbcff435d90@gmail.com>
Date:   Fri, 27 Oct 2023 14:49:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio/imu: inv_icm42600: Use max() helper macros
To:     Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231025113544.4954-1-bragathemanick0908@gmail.com>
 <FR3P281MB1757821128DD28BD9F2742A6CEDCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <FR3P281MB1757821128DD28BD9F2742A6CEDCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/10/23 14:24, Jean-Baptiste Maneyrol wrote:
> Hello,
>
> thanks for this patch.
>
> The same computation is also done inside inv_icm42600_gyro. Can you do a patch that is updating both files to use max?
>
> Thanks a lot,
> JB
Hi Jean,

Same computation can be included in both inv_icm42600_gyro and 
inv_icm42600_buffer.
Will make those changes and send a new patch.

Thanks,
Bragathe
>
> From: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> Sent: Wednesday, October 25, 2023 13:35
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>
> Cc: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: [PATCH] iio/imu: inv_icm42600: Use max() helper macros
>   
> Use the standard max() helper macros instead of direct variable comparison using if/else blocks or ternary operator. Change identified using minmax. cocci Coccinelle semantic patch. Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@ gmail. com>
> ZjQcmQRYFpfptBannerStart
> This Message Is From an Untrusted Sender
> You have not previously corresponded with this sender.
>   
> ZjQcmQRYFpfptBannerEnd
> Use the standard max() helper macros instead of direct
> variable comparison using if/else blocks or ternary
> operator. Change identified using minmax.cocci
> Coccinelle semantic patch.
>
> Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
> ---
>   drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> index b1e4fde27d25..f67bd5a39beb 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> @@ -137,10 +137,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
>   out_unlock:
>   	mutex_unlock(&st->lock);
>   	/* sleep maximum required time */
> -	if (sleep_accel > sleep_temp)
> -		sleep = sleep_accel;
> -	else
> -		sleep = sleep_temp;
> +	sleep = max(sleep_accel, sleep_temp);
>   	if (sleep)
>   		msleep(sleep);
>   	return ret;
