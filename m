Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB02778842
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHKHeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjHKHeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:34:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4BB12B;
        Fri, 11 Aug 2023 00:33:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9cb0bb04bso5098231fa.0;
        Fri, 11 Aug 2023 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739238; x=1692344038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFxZyU+YuSdMoAGYYjHCOfwZzeQyE0WaONH/xe4/I0k=;
        b=M/42eodRHM+N8MCKgcGaJ9ALh5WlfFg7U7t+0Tc2YUP55i6mQlc14DKpHUayo78rhY
         bspnyASWZ67Ca+tunATyEb3UKgHybEmtDA65psHtGcBtf1WXaeitCjiiTo1dqHLYRfcU
         6cNJE4U7MX6F0t+7cGLIheptglNhSwtlKUBYwUe65xCgn1mwASR+R4WPWk1SQc08AgQp
         QPC5tq9mtd8LuXQwWaZVLYomQqC5YOKscFv+dIBC9JRdIZrLcCu6KpzLNXrONlMMZU1r
         2tmEX2CRHPHJq+MjL/gkpYlP1x9Mz288hrrWB5Qnm3e9WcFXjAirl6b3wJ1lUrHqzaeW
         oJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739238; x=1692344038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFxZyU+YuSdMoAGYYjHCOfwZzeQyE0WaONH/xe4/I0k=;
        b=fOaun5D0YAzHoO+ahybQ8CQfbliBFi9CHTUHH/qlDWroTuEaMy88R8VBhCDkHltfS7
         JZ63GPzoyyZ9Jd2OZEPc5zXVpvF4JT9gIBO7vecNKhs1OVigsRhEyTIvbX71ooWlTcVJ
         hYhe6bYQKdSiS+paRhKpsAPv5r1KDkowuX4MD8spdaV7kslFzhXax4kmr7J0hwyo6eGs
         gfeuLT5PfRnIR/P0iBSoar/C74VxBVFjzUjzhSxJIIQZ/cNjhbCQ2TIo217En+FXMW4n
         VI3cA5ldG5KLo40NV2xWCl4QQQ+BKPgE7zJma0JNTg/XjBGMvTEZAwB67W41gs05IMVA
         z3YQ==
X-Gm-Message-State: AOJu0YzUyHcqHGHS+whO6VIGn/zxD11gwlX4xOyrirHxHvLXwDLWHA+Q
        l54NqbawQgLVrdQIxtQb1FI=
X-Google-Smtp-Source: AGHT+IF0/9MElVCILaSdmWCYD2qFCjWGcBdRq1v5RjUQOQRapMn9K9ehEmXdAmV4MMT/fn3SUcya/A==
X-Received: by 2002:a2e:b6ca:0:b0:2b9:7035:6e72 with SMTP id m10-20020a2eb6ca000000b002b970356e72mr907835ljo.3.1691739237910;
        Fri, 11 Aug 2023 00:33:57 -0700 (PDT)
Received: from [192.168.10.215] ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id t25-20020a1c7719000000b003fe4ca8decdsm7188328wmi.31.2023.08.11.00.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 00:33:57 -0700 (PDT)
Message-ID: <7a945f1e-51d1-ec90-d98f-adcd58ad1991@gmail.com>
Date:   Fri, 11 Aug 2023 11:33:55 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] fpga: fpga-mgr: make fpga_mgr_class a static const
 structure
Content-Language: en-US
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
 <20230811073043.52808-2-ivan.orlov0322@gmail.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230811073043.52808-2-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 11:30, Ivan Orlov wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the fpga_mgr_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>   drivers/fpga/fpga-mgr.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index eb583f86a0b9..06651389c592 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -19,7 +19,7 @@
>   #include <linux/highmem.h>
>   
>   static DEFINE_IDA(fpga_mgr_ida);
> -static struct class *fpga_mgr_class;
> +static const struct class fpga_mgr_class;
>   
>   struct fpga_mgr_devres {
>   	struct fpga_manager *mgr;
> @@ -693,7 +693,7 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
>    */
>   struct fpga_manager *fpga_mgr_get(struct device *dev)
>   {
> -	struct device *mgr_dev = class_find_device(fpga_mgr_class, NULL, dev,
> +	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
>   						   fpga_mgr_dev_match);
>   	if (!mgr_dev)
>   		return ERR_PTR(-ENODEV);
> @@ -713,7 +713,7 @@ struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
>   {
>   	struct device *dev;
>   
> -	dev = class_find_device_by_of_node(fpga_mgr_class, node);
> +	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
>   	if (!dev)
>   		return ERR_PTR(-ENODEV);
>   
> @@ -809,7 +809,7 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
>   	mgr->priv = info->priv;
>   	mgr->compat_id = info->compat_id;
>   
> -	mgr->dev.class = fpga_mgr_class;
> +	mgr->dev.class = &fpga_mgr_class;
>   	mgr->dev.groups = mops->groups;
>   	mgr->dev.parent = parent;
>   	mgr->dev.of_node = parent->of_node;
> @@ -967,23 +967,22 @@ static void fpga_mgr_dev_release(struct device *dev)
>   	kfree(mgr);
>   }
>   
> +static const struct class fpga_mgr_class = {
> +	.name = "fpga_manager",
> +	.dev_groups = fpga_mgr_groups,
> +	.dev_release = fpga_mgr_dev_release,
> +};
> +
>   static int __init fpga_mgr_class_init(void)
>   {
>   	pr_info("FPGA manager framework\n");
>   
> -	fpga_mgr_class = class_create("fpga_manager");
> -	if (IS_ERR(fpga_mgr_class))
> -		return PTR_ERR(fpga_mgr_class);
> -
> -	fpga_mgr_class->dev_groups = fpga_mgr_groups;
> -	fpga_mgr_class->dev_release = fpga_mgr_dev_release;
> -
> -	return 0;
> +	return class_register(&fpga_mgr_class);
>   }
>   
>   static void __exit fpga_mgr_class_exit(void)
>   {
> -	class_destroy(fpga_mgr_class);
> +	class_unregister(&fpga_mgr_class);
>   	ida_destroy(&fpga_mgr_ida);
>   }
>   
And I forgot the changelog here.

V1 -> V2:
- Add forward declaration of fpga_mgr_class
- Move definition of fpga_mgr_class to more logical place
