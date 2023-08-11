Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E312C778843
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 09:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjHKHeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 03:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjHKHeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:34:20 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6E512B;
        Fri, 11 Aug 2023 00:34:19 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fc03d990daso3314025e9.1;
        Fri, 11 Aug 2023 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691739258; x=1692344058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wiYN2PEDq5cWw7YTqGcnJYN2z14jWQDrmm2DF0dnOdE=;
        b=pq+cUd0NsvywcT3VRD6fQ35IYIOm/Ur0D5+R8DB6V+r80+WqEYp7PhbcXmk0UaEKt/
         SAKPSAHdKyyYAH8uAJTEc3Bt30pn2qlfCKFIehIrsjVRTC32n5fY9cv7mBoL9CyHwqMt
         QI25lnqRBG8AlWfp80cR/S8oH6XUoHdJ8RdgkYIHf4Bu5ff+0fFPfuhY7fHLrZD9I9l4
         3OMPFevDRxa+wkBIcJSwRCiIZfVxz/Jk+FqpKLZ9wutUSatxd2gv30ZjKqTJaZNIPl1I
         2Aarvr9i4RZLojNGIiNVT6pny9ZbJCWaFXtBerovpAyNv/FtDsnit1Rz5/V+yyh4/oCW
         396Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739258; x=1692344058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiYN2PEDq5cWw7YTqGcnJYN2z14jWQDrmm2DF0dnOdE=;
        b=lYhepkHK7qUBxSBJqFe3e0dUnlfw8ScyGm5f1tKhpPhyd6LwkwVHm46iJBY84x/Tfd
         /3S5TYRN+q0LEIXpf8d7iU9gKhd7zBw6bKkPbZjGe8GJshMAGKVdgCkfiC1V0fV7FeJv
         taN0vXXytdN6knmLwVmDydHSCw15tavnoGxZCDauNq06+Gg1bQzbDpRMBGAvqPET8Ye5
         MqNOgWTUMXMKWEddcq/KZTcPbFLrVsldUdZUityF/EXwBsoN547PCXpCCgo+NM21eerw
         oe+7AZJgsJ6LLXPCsogkz2xekrS4dtYOnoKv5WVM3FxnsNEffr3hykH6wvWEfk3mCcEq
         xxNA==
X-Gm-Message-State: AOJu0YzMt7oPc2/9CsihecqiftDUuhkGKU2VvL7v+p8HqTogeziFhkto
        eX3KwbZOmLuViYHeg6vlGUc=
X-Google-Smtp-Source: AGHT+IGwzdyqCosuY2CaA2yl4jw5Lml/5hAq7peGP4Wh8PrvLgoT7XBW35f/ZagpyaG+UR4iqfsv1w==
X-Received: by 2002:a05:600c:1c07:b0:3f7:fb5d:6e7a with SMTP id j7-20020a05600c1c0700b003f7fb5d6e7amr1242908wms.0.1691739257487;
        Fri, 11 Aug 2023 00:34:17 -0700 (PDT)
Received: from [192.168.10.215] ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id y9-20020a7bcd89000000b003fba6a0c881sm7191557wmj.43.2023.08.11.00.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 00:34:17 -0700 (PDT)
Message-ID: <05e5efda-b465-e4e7-d7b2-022e5203fc85@gmail.com>
Date:   Fri, 11 Aug 2023 11:34:14 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/3] fpga: region: make fpga_region_class a static
 const structure
Content-Language: en-US
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
 <20230811073043.52808-3-ivan.orlov0322@gmail.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230811073043.52808-3-ivan.orlov0322@gmail.com>
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
> memory, move the fpga_region_class structure to be declared at build
> time placing it into read-only memory, instead of having to be
> dynamically allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>   drivers/fpga/fpga-region.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index ccf6fdab1360..6abd8a154047 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -16,7 +16,7 @@
>   #include <linux/spinlock.h>
>   
>   static DEFINE_IDA(fpga_region_ida);
> -static struct class *fpga_region_class;
> +static const struct class fpga_region_class;
>   
>   struct fpga_region *
>   fpga_region_class_find(struct device *start, const void *data,
> @@ -24,7 +24,7 @@ fpga_region_class_find(struct device *start, const void *data,
>   {
>   	struct device *dev;
>   
> -	dev = class_find_device(fpga_region_class, start, data, match);
> +	dev = class_find_device(&fpga_region_class, start, data, match);
>   	if (!dev)
>   		return NULL;
>   
> @@ -216,7 +216,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
>   	mutex_init(&region->mutex);
>   	INIT_LIST_HEAD(&region->bridge_list);
>   
> -	region->dev.class = fpga_region_class;
> +	region->dev.class = &fpga_region_class;
>   	region->dev.parent = parent;
>   	region->dev.of_node = parent->of_node;
>   	region->dev.id = id;
> @@ -287,25 +287,24 @@ static void fpga_region_dev_release(struct device *dev)
>   	kfree(region);
>   }
>   
> +static const struct class fpga_region_class = {
> +	.name = "fpga_region",
> +	.dev_groups = fpga_region_groups,
> +	.dev_release = fpga_region_dev_release,
> +};
> +
>   /**
>    * fpga_region_init - init function for fpga_region class
>    * Creates the fpga_region class and registers a reconfig notifier.
>    */
>   static int __init fpga_region_init(void)
>   {
> -	fpga_region_class = class_create("fpga_region");
> -	if (IS_ERR(fpga_region_class))
> -		return PTR_ERR(fpga_region_class);
> -
> -	fpga_region_class->dev_groups = fpga_region_groups;
> -	fpga_region_class->dev_release = fpga_region_dev_release;
> -
> -	return 0;
> +	return class_register(&fpga_region_class);
>   }
>   
>   static void __exit fpga_region_exit(void)
>   {
> -	class_destroy(fpga_region_class);
> +	class_unregister(&fpga_region_class);
>   	ida_destroy(&fpga_region_ida);
>   }
>   
And I forgot the changelog here.

V1 -> V2:
- Add forward declaration of fpga_region_class
- Move definition of fpga_region_class to more logical place
