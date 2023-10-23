Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83C17D3143
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjJWLHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjJWLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:07:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39E610C1;
        Mon, 23 Oct 2023 04:07:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so2648323a12.2;
        Mon, 23 Oct 2023 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698059233; x=1698664033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akpOMj5d/8woIMFc1elzm+z11AzbUxl+8mKKF9Y05x4=;
        b=KYUEqtVY0dPFgKH5BW4s4EC5G/rTxAocKASQqCvo1BBxESFRVwdOhowEU1Azo/Vjzv
         BZKgKV/bb7vUS6tl7rNBTvPqIBAoRXUd83u7wUOuEFUuU4TfczBY0ThYmJ0qfCLMDJck
         WXVDs4ER+6ct00RG6SAVlM1YM6lIXNBrT+c5rP3GMS58rpwFxexK9JDb45NrJu7XLzUr
         GOYJMzVTnZif3dsTAb6m01JRFjS4gnNsofKUkhtmUmVw4+6P5MCFiLScVn9FAEj29CS9
         E1f+kmvgCy7NTYBy3oHtkF+ebL6un2XkKJEdBpnYfHxhIIi5c/o3kwsNJ+TVBg2wTqso
         T8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698059233; x=1698664033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akpOMj5d/8woIMFc1elzm+z11AzbUxl+8mKKF9Y05x4=;
        b=aPrNXLygEluvZeYQYuRAOd1Z+Xt5Z238mL2kdXSEWPlW7D1Ml/6qnuUioiVJ1InSLr
         NpOv8U/M2kvWsAJggFc+7ZRODsnYAmk17lXFrhtdN5taAGqgkEVtTDmwy/jl0O4YIvmV
         DHVswszlGtustBqcCLESBuKiKQ/geRovsfQt1g80mILpjLN4Vzoi7+MqWTz7fBkK8cHa
         ox+sZh27Qfp2uwiQLk4j8en2jWW3aglEekwK7ewzRUaYjgKs9UjQKFS4nbPjABPuiB+R
         /4NjJQI1Al6gxaQqsTzhpr8lDlJqOI8IeLbS6sjcHDOJNCzL31ic5ZHZgtGKg85kOnaX
         aelA==
X-Gm-Message-State: AOJu0Yyt2ABoY6W1HQNCAZCDbIzjP3GMZhLG2dPtKigB5NmcIbAWsEhY
        BOBtieXaI1/egXZaumgPD6oEF7kpGHaf+a/HesWluIvE3Tk=
X-Google-Smtp-Source: AGHT+IEZXn3icFVMprpTKAJBq8ZATZ8OjKGw9+gMt9vd6GvtN/HQYPrTH8CbfwUh4K+VheXfRTMbZCDAkYMsEodzgJI=
X-Received: by 2002:a05:6402:518e:b0:53e:7597:77dc with SMTP id
 q14-20020a056402518e00b0053e759777dcmr7109901edd.25.1698059232954; Mon, 23
 Oct 2023 04:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231023081054.617292-1-colin.i.king@gmail.com>
In-Reply-To: <20231023081054.617292-1-colin.i.king@gmail.com>
From:   Jagath Jog J <jagathjog1996@gmail.com>
Date:   Mon, 23 Oct 2023 16:37:01 +0530
Message-ID: <CAM+2EuK2LOL=g=r866c6zwE4XOSL5uZ-rweUjm6svgSi8v9Xkw@mail.gmail.com>
Subject: Re: [PATCH][next] iio: imu: Fix spelling mistake "accelrometer" -> "accelerometer"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 1:40=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There are two spelling mistakes in dev_err messages. Fix them.

Hi Colin,

Thanks for fixing this.
Reviewed-by: Jagath Jog J <jagathjog1996@gmail.com>

>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi32=
3/bmi323_core.c
> index 0bd5dedd9a63..183af482828f 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -545,7 +545,7 @@ static int bmi323_tap_event_en(struct bmi323_data *da=
ta,
>         guard(mutex)(&data->mutex);
>
>         if (data->odrhz[BMI323_ACCEL] < 200) {
> -               dev_err(data->dev, "Invalid accelrometer parameter\n");
> +               dev_err(data->dev, "Invalid accelerometer parameter\n");
>                 return -EINVAL;
>         }
>
> @@ -1453,7 +1453,7 @@ static int bmi323_enable_steps(struct bmi323_data *=
data, int val)
>
>         guard(mutex)(&data->mutex);
>         if (data->odrhz[BMI323_ACCEL] < 200) {
> -               dev_err(data->dev, "Invalid accelrometer parameter\n");
> +               dev_err(data->dev, "Invalid accelerometer parameter\n");
>                 return -EINVAL;
>         }
>
> --
> 2.39.2
>
