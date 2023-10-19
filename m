Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958917CF114
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjJSHVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjJSHVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:21:44 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFC812E;
        Thu, 19 Oct 2023 00:21:42 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4083ac51d8aso13927575e9.2;
        Thu, 19 Oct 2023 00:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697700100; x=1698304900;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd+CZoB3ZUKbrf75iwEsiONnc1Z3WWVEgj1SxQ7RWs4=;
        b=cXT6QqGDFOcUfo71vGB11MYzJYHuwphwHXFZcDS+zP1ihK4C503cXTfNlf0WspYyPj
         xvoFpK9Y6vfTKmagux1+5+e5xclqq3TE2vivx6RFle1GFMFNnfdWrZd6sZzM5UvXTvCF
         mukyn0o185ylsdd1yGKJPwZDRcw6Jb5al+H72HgROggvFKSylJI4v3Duwomy7qqJCaVc
         6onQOEJqwDQJ2swOAWCZ3hm6ufCFJlJuy1MIcgsSFIiXOGM6lYzJeATI+namUVjOp519
         sWGsmQ9JwpuVUt953CcdmVWBRi2RivZwqGJddTm6hqaNk2lHQhIk5nxbNvju6M3vYVgB
         kwRA==
X-Gm-Message-State: AOJu0YzvQSrczYGZuNB05JgZxGhv3TDeI/+eGKTRkl6cpc439XeIXSuL
        X6VqAbCyjicukJXNubN1Q9o=
X-Google-Smtp-Source: AGHT+IHY1Z8PJ1keSg0UJBWEGxH64D6kzeBE9qCkMCKICnXexHfCdZlwk7bieKLMonAHTEXzCTKCfA==
X-Received: by 2002:a05:600c:4506:b0:403:7b2:6d8f with SMTP id t6-20020a05600c450600b0040307b26d8fmr1214903wmo.2.1697700100284;
        Thu, 19 Oct 2023 00:21:40 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bca50000000b00405d9a950a2sm3588552wml.28.2023.10.19.00.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 00:21:39 -0700 (PDT)
Message-ID: <83a0f0a0-56b1-4021-a37d-ef68e7fab712@kernel.org>
Date:   Thu, 19 Oct 2023 09:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] i3c: slave: func: add tty driver
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, corbet@lwn.net, joe@perches.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, imx@lists.linux.dev,
        linux-serial@vger.kernel.org
References: <20231018215809.3477437-1-Frank.Li@nxp.com>
 <20231018215809.3477437-5-Frank.Li@nxp.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20231018215809.3477437-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18. 10. 23, 23:58, Frank Li wrote:
> Add tty over I3C slave function driver.

Many of the master review comments apply also here. Please fix here too. 
More below.

> --- /dev/null
> +++ b/drivers/i3c/func/tty.c
> @@ -0,0 +1,548 @@
...
> +static void i3c_slave_tty_rx_complete(struct i3c_request *req)
> +{
> +	struct ttyi3c_port *port = req->context;
> +
> +	if (req->status == I3C_REQUEST_CANCEL) {
> +		i3c_slave_ctrl_free_request(req);
> +		return;
> +	}
> +
> +	for (int i = 0; i < req->actual; i++)
> +		tty_insert_flip_char(&port->port, *(u8 *)(req->buf + i), 0);

Maybe I miss something obvious, but req->buf is void *. So why not 
simple tty_insert_flip_string()?


> +	sport->buffer = (void *)get_zeroed_page(GFP_KERNEL);
> +	if (!sport->buffer)
> +		return -ENOMEM;
> +
> +	sport->xmit.buf = (void *)get_zeroed_page(GFP_KERNEL);

tty_port_alloc_xmit_buf()


> +static int i3c_tty_probe(struct i3c_slave_func *func)
> +{
> +	struct device *dev = &func->dev;
> +	struct ttyi3c_port *port;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->i3cdev = func;
> +	dev_set_drvdata(&func->dev, port);
> +
> +	port->workqueue = alloc_workqueue("%s", 0, 0, dev_name(&func->dev));

Another wq? You'd have to have a strong reason for these. Drop that.

> +	if (!port->workqueue)
> +		return -ENOMEM;
> +
> +	INIT_WORK(&port->work, i3c_slave_tty_i3c_work);
> +
> +	return 0;
> +}
> +
> +static void  i3c_tty_remove(struct i3c_slave_func *func)
> +{
> +	struct ttyi3c_port *port;
> +
> +	port = dev_get_drvdata(&func->dev);

That can be on one line.

> +
> +	destroy_workqueue(port->workqueue);
> +}


> +static int i3c_open(struct tty_struct *tty, struct file *filp)
> +{
> +	struct ttyi3c_port *sport = tty->driver_data;
> +	int ret;
> +
> +	if (!i3c_slave_ctrl_get_addr(sport->i3cdev->ctrl)) {
> +		dev_info(&sport->i3cdev->dev, "No slave addr assigned, try hotjoin");

Should this be a debug print instead?

> +		ret = i3c_slave_ctrl_hotjoin(sport->i3cdev->ctrl);
> +		if (ret) {
> +			dev_err(&sport->i3cdev->dev, "Hotjoin failure, check connection");
> +			return ret;
> +		}
> +	}
> +
> +	return tty_port_open(&sport->port, tty, filp);

regards,
-- 
js
suse labs

