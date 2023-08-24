Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB317878BF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243314AbjHXTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbjHXTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:38:20 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AA51FF3;
        Thu, 24 Aug 2023 12:38:17 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64f3ad95ec0so1189746d6.1;
        Thu, 24 Aug 2023 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692905896; x=1693510696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0pNXjP4YD8YCbiS4F9wDMpxOWm98T3b5y8pHcO+RMEw=;
        b=aahapvrFGY7P6jqXJOpOx+C9sAW9Vu6MYSSFTrntNwzYb+FEXcarBvbGHSeqmQafH3
         fV+PPkYD9JOESfaqruDxJbB4VWFt+QtmqXSHXU2x6VKre33BTWf/M/p2YwaM/TCuoeNy
         HNoHdLEjctfyellA9KJ+0iksjrqzjOTlhJH3H2NnGDWv/G9VHFPMOBVRk78HjGx7t3Yj
         B/FprvMvK44VcT0tIG9fej8QQ64wJBiBrKkvIzsb1n7bj+rL7UPEOWW3SVJe7yNkds99
         K0222QbCaigc50CnjTIvQ+1X5jkycH7mspmIgb91YRX2aphkgn1eNHyEFo/a8FCBwSzV
         O+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692905896; x=1693510696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pNXjP4YD8YCbiS4F9wDMpxOWm98T3b5y8pHcO+RMEw=;
        b=KMFzT3WZiZ7+oMds7IaNf8vTfDUtVL371QjkE7Cq2/QEsSwQS5tjV0LvrPv9SXFmvX
         wXwkxBmNHLqfZfnSQewd+juXmglpk2M21Sz8aXql9f7HJhgNjvHXzhLBSD9KasxhiHgw
         MkNfh0JC2VuM1hWVgidYYoHuN+BcwuiHU0H0qeFCnEOpjmmouU6+XK3fqcKwFtSIm5/Y
         7BF2KVQBtTbczbxWzi3JWiQ1oVW5RY4mFKmBW0m2hVrI62SDNwwTK5N31NKvyXPoD49H
         zVbsaLqRVGPi4/A6kzOZ4GYeL8EQDCYtE07m5OZ4NMZ5sOHVhqNvgjglN3/capTGsAmI
         eJVQ==
X-Gm-Message-State: AOJu0YzrnY2M6QSah/Xu4bxF/UpsXB1qmX0D6aQyFxSBOCpDnXrGwZQh
        NhIcgezGUP8kOIEC4AMtr1s=
X-Google-Smtp-Source: AGHT+IE8OWrIs6aQAelJ+psBoQwdK3wLaMcSWjWlfzt4Vh7kCM73sDWvJgjlNpdtPkJ6hN1BfStoFw==
X-Received: by 2002:a0c:e7cc:0:b0:63d:281d:d9cf with SMTP id c12-20020a0ce7cc000000b0063d281dd9cfmr15224559qvo.64.1692905896206;
        Thu, 24 Aug 2023 12:38:16 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id u25-20020a0cb699000000b0064f5e7728bcsm17490qvd.138.2023.08.24.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 12:38:15 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:38:13 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: ltc2309: switch to new .probe()
Message-ID: <20230824193813.GC3659959@shaak>
References: <20230824-ltc2309-v1-0-b87b4eb8030c@gmail.com>
 <20230824-ltc2309-v1-2-b87b4eb8030c@gmail.com>
 <f935f35f-e00b-4ebe-2071-de9d8f2f6512@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f935f35f-e00b-4ebe-2071-de9d8f2f6512@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 08:01:01PM +0200, Krzysztof Kozlowski wrote:
> On 24/08/2023 18:55, Liam Beguin wrote:
> > Recent changes to the I2C subsystem removed the id parameter of the
> > probe function. Update driver to use the new prototype, and keep this as
> > an independent commit to facilitate backporting.
> > 
> > Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> > ---
> >  drivers/iio/adc/ltc2309.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> > index ee1fd9b82e2a..d26bbd70b0ff 100644
> > --- a/drivers/iio/adc/ltc2309.c
> > +++ b/drivers/iio/adc/ltc2309.c
> > @@ -158,8 +158,7 @@ static const struct iio_info ltc2309_info = {
> >  	.read_raw = ltc2309_read_raw,
> >  };
> >  
> > -static int ltc2309_probe(struct i2c_client *client,
> > -			 const struct i2c_device_id *id)
> > +static int ltc2309_probe(struct i2c_client *client)
> 
> This patch does not make sense. Do not send patch (1/3) which does not
> compile and is buggy, just to immediately fix it. We do not add known
> wrong code.

Sorry about that! You're right, I missed that 1/3 doesn't build without
this change. I might've pressed send too quickly here..

> Best regards,
> Krzysztof
> 

Thanks,
Liam
