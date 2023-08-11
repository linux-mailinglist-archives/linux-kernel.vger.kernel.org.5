Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD877883E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjHKHdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjHKHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:33:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0DC196;
        Fri, 11 Aug 2023 00:33:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so2929395e9.0;
        Fri, 11 Aug 2023 00:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739190; x=1692343990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52RqNsWBGOEDTRChxk5rErDAk2mThr2SZ+FE8VBLvsY=;
        b=QjqXFj12SQOPvXVa1OlJ1F+HNJid76tn2eHsIEgYpJJBxNzUiEjMRV1rFkLq9jZkeR
         4KwspValcFZN5BPeK4ZOjzccxu4+4ZyJaAbm8QosdKXQD5FvcJuUz5A9Z6H6o59XN+jl
         AxuJEAyjwrq7eKrftOyFQIxmiDVe75xcnqvW+Cezui/g1zb1Ml4+UNeVruy8uxvKiCfT
         KOXck1ygLn9QOh0wmY6Fr78H19neHgRnDXDKEwocuUZFT11gxsVxSX6NDP/NwnlOAlgX
         UuHnqTdGU6UFCZZU8THsDDkdOHCyPzCarLv0rELl07ZKTtzNQOyjfUWU084PnWLe4eFk
         SCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739190; x=1692343990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52RqNsWBGOEDTRChxk5rErDAk2mThr2SZ+FE8VBLvsY=;
        b=UOZtyGO/PYsHB2xvT4Cxvj98PQVN9srU5LzX2k4MR6JJmHE6XDFoiBnAYafkMzUMuw
         XBdEa5KXcPnAs7kCv+HfoKwHWfYIL7ItZxkz5Q2LLDglNhwCg9o73b0mVNCr1ejUkyaF
         GfERFq3cNEHTTb7ssoupf5mLTmRbL0fAX9DicvfFDXSlUSKec36fgJsM+IskMNSXk36p
         6tnCGMlZDmMiOxUCbHkRlcKromJ2Y73SdDAYBdO/RsGtTdn90+U9xwCsV9wypqlLf8Le
         dSJkpsqseQs0MurVbJN0vfM5Ekgb24tVOmIb8tuQb31wRu1t6MMuX3H6hvzhq0UxibsD
         8ouw==
X-Gm-Message-State: AOJu0YyvVvXq7SDcy3tYIBKtQyqwohG+Ou4J/yDbHg+d2WgA+7nMOIkt
        BUMinOAMfNhOkhFXLNDJyzmkQdCjzenpcFUI
X-Google-Smtp-Source: AGHT+IEW8aJXrT2zeK3LH70YMnUjablkOYXSCo6g9B0ruLkQH9E+sDHvB2N49sMgrj5xeqMIV7NNWw==
X-Received: by 2002:a05:600c:3509:b0:3fe:21a6:a18 with SMTP id h9-20020a05600c350900b003fe21a60a18mr1125778wmq.3.1691739189566;
        Fri, 11 Aug 2023 00:33:09 -0700 (PDT)
Received: from [192.168.10.215] ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id g5-20020adfe405000000b0031773a8e5c4sm4537740wrm.37.2023.08.11.00.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 00:33:09 -0700 (PDT)
Message-ID: <4d41f54f-806c-9071-de68-6db69c3024da@gmail.com>
Date:   Fri, 11 Aug 2023 11:33:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] fpga: bridge: make fpga_bridge_class a static
 const structure
Content-Language: en-US
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 11:30, Ivan Orlov wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the fpga_bridge_class structure to be declared at build
> time placing it into read-only memory, instead of having to be
> dynamically allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>   drivers/fpga/fpga-bridge.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index a6c25dee9cc1..fe93549d051d 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -14,7 +14,7 @@
>   #include <linux/spinlock.h>
>   
>   static DEFINE_IDA(fpga_bridge_ida);
> -static struct class *fpga_bridge_class;
> +static const struct class fpga_bridge_class;
>   
>   /* Lock for adding/removing bridges to linked lists*/
>   static DEFINE_SPINLOCK(bridge_list_lock);
> @@ -99,7 +99,7 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>   {
>   	struct device *dev;
>   
> -	dev = class_find_device_by_of_node(fpga_bridge_class, np);
> +	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
>   	if (!dev)
>   		return ERR_PTR(-ENODEV);
>   
> @@ -126,7 +126,7 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
>   {
>   	struct device *bridge_dev;
>   
> -	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
> +	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
>   				       fpga_bridge_dev_match);
>   	if (!bridge_dev)
>   		return ERR_PTR(-ENODEV);
> @@ -359,7 +359,7 @@ fpga_bridge_register(struct device *parent, const char *name,
>   	bridge->priv = priv;
>   
>   	bridge->dev.groups = br_ops->groups;
> -	bridge->dev.class = fpga_bridge_class;
> +	bridge->dev.class = &fpga_bridge_class;
>   	bridge->dev.parent = parent;
>   	bridge->dev.of_node = parent->of_node;
>   	bridge->dev.id = id;
> @@ -415,21 +415,20 @@ static void fpga_bridge_dev_release(struct device *dev)
>   	kfree(bridge);
>   }
>   
> +static const struct class fpga_bridge_class = {
> +	.name = "fpga_bridge",
> +	.dev_groups = fpga_bridge_groups,
> +	.dev_release = fpga_bridge_dev_release,
> +};
> +
>   static int __init fpga_bridge_dev_init(void)
>   {
> -	fpga_bridge_class = class_create("fpga_bridge");
> -	if (IS_ERR(fpga_bridge_class))
> -		return PTR_ERR(fpga_bridge_class);
> -
> -	fpga_bridge_class->dev_groups = fpga_bridge_groups;
> -	fpga_bridge_class->dev_release = fpga_bridge_dev_release;
> -
> -	return 0;
> +	return class_register(&fpga_bridge_class);
>   }
>   
>   static void __exit fpga_bridge_dev_exit(void)
>   {
> -	class_destroy(fpga_bridge_class);
> +	class_unregister(&fpga_bridge_class);
>   	ida_destroy(&fpga_bridge_ida);
>   }
>   

And I forgot the changelog here.

V1 -> V2:
- Add forward declaration of fpga_bridge_class
- Move definition of fpga_bridge_class to more logical place
