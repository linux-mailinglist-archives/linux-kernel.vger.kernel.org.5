Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4FF75EACA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjGXFTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGXFTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:19:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEC3FF;
        Sun, 23 Jul 2023 22:19:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b89cfb4571so32042115ad.3;
        Sun, 23 Jul 2023 22:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690175973; x=1690780773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XchQfCc8vwc9g5aVS6c1iv5AIZrWiDeyheJfWmsaZ5g=;
        b=hEadg+R2hRZcmJahArai3mONGkoCgTIPCehtJvjDQWsXnhAHIi2GjVWMUlBLGECdFU
         uK8n1kjvLfr0Op6oSpdoaZu0ZJFQ0gKo8NMEexpsE7xlupBKQJAKCRv/241sAOHDreSx
         JFFseUBL1g+REK8CtcJctHf7cbBVm5pqzSSuQJXPQQ5EEPfPn1rCnhPTr9kLZjIY9SJl
         lSznuqYkOsPaLAjyVh/nB6QeZLambf+u+YZX52aSi66KUIiXGPvz0zEHLFFjM9zFVz0t
         ByxP9JgMBJk8LeInDZ5TYFUMspaQnoHjm55cD872QmScwQeiFOYv9EVn1NuIu51RqgI9
         e4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690175973; x=1690780773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XchQfCc8vwc9g5aVS6c1iv5AIZrWiDeyheJfWmsaZ5g=;
        b=ClULzxnm4yAIZ/9sQ9Ir1T8i2BjXnRjfY97E1BI9/VlSTaJyDhTWhcX8JVJucEMplU
         JcCuxgjLsDKfOKJnvj5iscDzVTASGuj39qoCJWEG2AiWBJ6Tv46TjAoNmcdF4chu+Jz7
         PYSQ8oTs37x/ggRxTrwlTQnEaCEgJz+ok8W/iAqefTg1rWl/iawyCcGYpfaM68U2rODq
         0CdD+qFbi8KvxFYBaGkwTe8eRio0fSCDDoiJhqqYcspkDDh8wT0Gq3zT9sw+pYgpqe+W
         br/KvtWm6p+kPMFDV28wQeNQPwX83LaAyMpmlsuQLoyXim3HaUS59Jz9M6blirn22wHk
         Y3Dg==
X-Gm-Message-State: ABy/qLbfGyZx5djKINesVG4zjQlVwBrEOlUQwkiSQTWHFor+sDqOyuy4
        0is0jbnJ23GbfcNqS0rsOAE=
X-Google-Smtp-Source: APBJJlHDcT5WQ+azJs8k6vZTCEIaNYPdK7dt7OMMUcNWTWUtvkIXLyitNH72+074zLiJQ8Ygaj5u1g==
X-Received: by 2002:a17:902:a507:b0:1bb:809d:ae6a with SMTP id s7-20020a170902a50700b001bb809dae6amr6752493plq.7.1690175973306;
        Sun, 23 Jul 2023 22:19:33 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id j1-20020a170902da8100b001bba3650448sm1233850plx.258.2023.07.23.22.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:19:32 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:19:30 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] Input: qt2160 - convert to use devm_* api
Message-ID: <ZL4J4h3JJLh1UQnQ@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
 <20230714080611.81302-7-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-7-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Fri, Jul 14, 2023 at 04:06:10PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/input/keyboard/qt2160.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
> index 599ea85cfd30..218ef92b8c2b 100644
> --- a/drivers/input/keyboard/qt2160.c
> +++ b/drivers/input/keyboard/qt2160.c
> @@ -340,6 +340,7 @@ static bool qt2160_identify(struct i2c_client *client)
>  
>  static int qt2160_probe(struct i2c_client *client)
>  {
> +	struct device *dev = &client->dev;

You create a temporary, but half of the code does not use it. Please if
you introduce a temporary make sure everything is using it.

>  	struct qt2160_data *qt2160;
>  	struct input_dev *input;
>  	int i;
> @@ -358,12 +359,11 @@ static int qt2160_probe(struct i2c_client *client)
>  		return -ENODEV;
>  
>  	/* Chip is valid and active. Allocate structure */
> -	qt2160 = kzalloc(sizeof(struct qt2160_data), GFP_KERNEL);
> -	input = input_allocate_device();
> +	qt2160 = devm_kzalloc(dev, sizeof(struct qt2160_data), GFP_KERNEL);
> +	input = devm_input_allocate_device(dev);
>  	if (!qt2160 || !input) {

This double check was a cheat when resources did not free automatically,
it makes no sense to carry with devm.

>  		dev_err(&client->dev, "insufficient memory\n");
> -		error = -ENOMEM;
> -		goto err_free_mem;
> +		return -ENOMEM;
>  	}
>  
>  	qt2160->client = client;
> @@ -389,23 +389,23 @@ static int qt2160_probe(struct i2c_client *client)
>  	error = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
>  	if (error) {
>  		dev_err(&client->dev, "failed to calibrate device\n");
> -		goto err_free_mem;
> +		return error;
>  	}
>  
>  	if (client->irq) {
> -		error = request_irq(client->irq, qt2160_irq,
> -				    IRQF_TRIGGER_FALLING, "qt2160", qt2160);
> +		error = devm_request_irq(dev, client->irq, qt2160_irq,
> +					 IRQF_TRIGGER_FALLING, "qt2160", qt2160);
>  		if (error) {
>  			dev_err(&client->dev,
>  				"failed to allocate irq %d\n", client->irq);
> -			goto err_free_mem;
> +			return error;
>  		}
>  	}
>  
>  	error = qt2160_register_leds(qt2160);
>  	if (error) {
>  		dev_err(&client->dev, "Failed to register leds\n");
> -		goto err_free_irq;
> +		return error;
>  	}
>  
>  	error = input_register_device(qt2160->input);
> @@ -422,29 +422,21 @@ static int qt2160_probe(struct i2c_client *client)
>  
>  err_unregister_leds:
>  	qt2160_unregister_leds(qt2160);

LEDs can also be registered with devm.

> -err_free_irq:
> -	if (client->irq)
> -		free_irq(client->irq, qt2160);
> -err_free_mem:
> -	input_free_device(input);
> -	kfree(qt2160);
>  	return error;
>  }
>  
>  static void qt2160_remove(struct i2c_client *client)
>  {
>  	struct qt2160_data *qt2160 = i2c_get_clientdata(client);
> +	struct device *dev = &client->dev;
>  
>  	qt2160_unregister_leds(qt2160);
>  
>  	/* Release IRQ so no queue will be scheduled */
>  	if (client->irq)
> -		free_irq(client->irq, qt2160);
> +		devm_free_irq(dev, client->irq, qt2160);
>  
>  	cancel_delayed_work_sync(&qt2160->dwork);

It is not great that we are left with non-empty qt2160_remove(). The
driver should be converted away from using work item, and then entirety
of qt2160_remove() can be deleted.

I posted a series that cleans up the driver and incorporates an updated
version of your patch.

Thanks.

-- 
Dmitry
