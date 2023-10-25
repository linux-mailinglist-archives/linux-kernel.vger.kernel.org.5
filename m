Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B8B7D7489
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjJYTlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJYTlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:41:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC5B189;
        Wed, 25 Oct 2023 12:41:02 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca3a54d2c4so388485ad.3;
        Wed, 25 Oct 2023 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698262862; x=1698867662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IdzTaQLvIjWdCW23uUwjApK25y8OzySo8bAMr5Qvrrc=;
        b=G/jmQSvS+vH8+KbuGGYKLBZJFM2R3+8UcQj38qZyeJyGpoJKGQDXP0JaqPe8LjIlx5
         F82OIpd8Q8+OvAPTSZAkCe1P+V31oZT1rr0jEGzSHqqYoNevW9Wx8zh9yPQcb5CvLZbA
         SEAmnIjI579p206cMAPpXP9wfNm8lVk4kIgZd8sl1tnAtjMkY5p5G4gPyNzVG8AL/6kg
         WeFnTfzdu96PrAb9Ay8PIZigZjGRozcg4/KruPiNlyONeY8sgtHg4s/gGe5mEFKoc/+/
         ARxsFgl1odZM0Ha1pSalrFvLDGvaqvVjVSj+WWURYYPaF0rl+bfu98awvDKVix/kU5To
         kgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698262862; x=1698867662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdzTaQLvIjWdCW23uUwjApK25y8OzySo8bAMr5Qvrrc=;
        b=bokGs0hm7WHIfySPIGarj8j+5Dx/+7kbSm7KE5SZqGdR1IQCGwx58oGztfSvlGGSX9
         Th+daC6nIyjhCL34mL0OuO8v1rN96eQhCN8eAAtD7ZFEONtyKIRzajYK3Q9rKXjf0CDd
         ayxMkufCKP0qM2wWlS/JlrK+D6hl1fx3eAhefdpAMgzTMoarW3bqJHEWEJUH1KMog3et
         Oy5PmFd8zPo5uNtUdgGsbKmiG11w7R5kBzPeupR0DHz9chsbFys+ImmSuLtzTAXgSIIF
         ISUcKyav9zBqwwP85UHEzaqf2p6ckFcCUvyDp4apDHxb3Jo4CIU6NoB46cka9ZkKr5Aq
         LZ9A==
X-Gm-Message-State: AOJu0YyPb1KCJJua0jfJ0xodzOpC97lPUBte0D+4g5nLpSQs28XPIUgJ
        +FvTU+9fZEL0699Zg/Xnymc=
X-Google-Smtp-Source: AGHT+IFZyvarEOoRSc9FXYqsMJLGoAA6rpsNiBAXJxTtm56787NJ2q1l4vPNbHRuh+eqs01IQCzXCw==
X-Received: by 2002:a17:903:644:b0:1c9:ca45:f86 with SMTP id kh4-20020a170903064400b001c9ca450f86mr13714334plb.18.1698262861743;
        Wed, 25 Oct 2023 12:41:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902a5cc00b001c74876f032sm9512635plq.162.2023.10.25.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:41:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 25 Oct 2023 12:41:00 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, leonard.anderweit@gmail.com,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (aquacomputer_d5next) Check if temp sensors
 of legacy devices are connected
Message-ID: <ac61decf-8ab7-46c1-83f0-d3f79f737bbf@roeck-us.net>
References: <20231016083559.139341-1-savicaleksa83@gmail.com>
 <20231016083559.139341-2-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016083559.139341-2-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:35:57AM +0200, Aleksa Savic wrote:
> Return -ENODATA if a temp sensor of a legacy device
> does not contain a reading.
> 

Why is the sensor instantiated in the first place ?
Returning -ENODATA for every reading is not desirable.
If this can happen, the is_visible function should check
for it and skip affected sensors.

Guenter

> Originally-from: Leonard Anderweit <leonard.anderweit@gmail.com>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  drivers/hwmon/aquacomputer_d5next.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index 023807859be7..46ff4fd4f87d 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -926,7 +926,10 @@ static int aqc_legacy_read(struct aqc_data *priv)
>  	for (i = 0; i < priv->num_temp_sensors; i++) {
>  		sensor_value = get_unaligned_le16(priv->buffer + priv->temp_sensor_start_offset +
>  						  i * AQC_SENSOR_SIZE);
> -		priv->temp_input[i] = sensor_value * 10;
> +		if (sensor_value == AQC_SENSOR_NA)
> +			priv->temp_input[i] = -ENODATA;
> +		else
> +			priv->temp_input[i] = sensor_value * 10;
>  	}
>  
>  	/* Special-case sensor readings */
