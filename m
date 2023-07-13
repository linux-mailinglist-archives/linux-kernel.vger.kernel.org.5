Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB937529BA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjGMRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGMRUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:20:32 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B8130F1;
        Thu, 13 Jul 2023 10:19:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6682909acadso656644b3a.3;
        Thu, 13 Jul 2023 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689268791; x=1691860791;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6q3yqHw5lCIHcrpempCEB7KMGH+tCMNgbL7f40MAuY=;
        b=jAgjP/YVQgvUerdQbk9DZmbDd6WW69rrl+Vb0Pmr19zOvs4XWQlfbBzdQvhxY5MMqO
         R/DslgZop0z0Yi+8Tx1oncf+xRJ3F4DrKDY6/DYAvICkGD+6wzo2qqHg5kWaDlzIZtf+
         9k6jp5wJbojL6L0vTZEPAG4uVhXaIbcJCY2BMfmgHjwCeDicSDujoS3Fugf/OcGpLaBZ
         5j5kV0i6Bn2uK77lYaSKpT8bqtaMa/UQ24dEPoB9L2VZyCT6QWmryrl72Q/oe0iZA8qg
         fkXQB3aZ389gHI+QwnBhzDApKC4dJbcHCA1rAbpSs4SW9A+u7NsxunoBeyzADQg354oU
         DoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689268791; x=1691860791;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6q3yqHw5lCIHcrpempCEB7KMGH+tCMNgbL7f40MAuY=;
        b=dSC4YxoaojFdHcomYOCmGh/Qp+J4x43CT/B8eeB26VJLza1CDedut6GnqMiNzyvS2s
         t1EmiyHzWujfX38SjaWWSDF6n/a5l6Ixr6u8LtishrEvSpBA3lCD/ALsVH86pxp+Dj4F
         tFvNypRnMymUf9i6dkC/MTBlZbyrEluod8pDDWuu+uHw3VZqiOAA7nTUuWekpo/4g1ef
         wojVMl8gRXMY1WqbilbX0YwAkqs7Of4/bIrZd7EasAJPvLBhGVaAfN2qJIfFRmLtYqhY
         Ac6Q/8jtGTj2a7kF4omBYQRv9JvRdx4mYistYKtK2Clv37VGzfYtSJL7i06lLGI3ycg7
         F9Lg==
X-Gm-Message-State: ABy/qLZm26ym/EZ7v4SMz4HOGD1+a1KW7ZsNbrSmWZGviebOcNo9LKMl
        zeX/5Bub4FrgIiAQj8uCIl8=
X-Google-Smtp-Source: APBJJlFK+jp89O6Uf/fdu37X+TR0XQ5OdJaVvAJzDHuc3bhgoA7Mcji5vntrlVvyeFSOyq8Sgw4bsQ==
X-Received: by 2002:a05:6a20:12c8:b0:122:8096:7012 with SMTP id v8-20020a056a2012c800b0012280967012mr1796270pzg.3.1689268790647;
        Thu, 13 Jul 2023 10:19:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b001b9de39905asm6180413plg.59.2023.07.13.10.19.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 10:19:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <389c90f7-2df7-5998-068a-40bc8722893b@roeck-us.net>
Date:   Thu, 13 Jul 2023 10:19:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230713095127.1230109-1-huaqian.li@siemens.com>
 <20230713095127.1230109-4-huaqian.li@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
In-Reply-To: <20230713095127.1230109-4-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/23 02:51, huaqian.li@siemens.com wrote:
> From: Li Hua Qian <huaqian.li@siemens.com>
> 
> This patch adds the WDIOF_CARDRESET support for the platform watchdog
> whose hardware does not support this feature, to know if the board
> reboot is due to a watchdog reset.
> 
> This is done via reserved memory(RAM), which indicates if specific
> info saved, triggering the watchdog reset in last boot.
> 
> Signed-off-by: Li Hua Qian <huaqian.li@siemens.com>
> ---
>   drivers/watchdog/rti_wdt.c | 51 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index ce8f18e93aa9..b9435b972cb9 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -18,6 +18,8 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/types.h>
>   #include <linux/watchdog.h>
> +#include <linux/of_address.h>
> +#include <linux/of.h>
>   

This driver so far managed to keep include files in alphabetic order.
Please keep it that way.

>   #define DEFAULT_HEARTBEAT 60
>   
> @@ -52,6 +54,11 @@
>   
>   #define DWDST			BIT(1)
>   
> +#define PON_REASON_SOF_NUM	0xBBBBCCCC
> +#define PON_REASON_MAGIC_NUM	0xDDDDDDDD
> +#define PON_REASON_EOF_NUM	0xCCCCBBBB
> +#define RESERVED_MEM_MIN_SIZE	12
> +
>   static int heartbeat = DEFAULT_HEARTBEAT;
>   
>   /*
> @@ -198,6 +205,11 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   	struct rti_wdt_device *wdt;
>   	struct clk *clk;
>   	u32 last_ping = 0;
> +	struct device_node *node;
> +	u32 reserved_mem_size;
> +	struct resource res;
> +	u32 *vaddr;
> +	u64 paddr;
>   
>   	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
>   	if (!wdt)
> @@ -284,6 +296,45 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	node = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
> +	if (!node) {
> +		dev_dbg(dev, "No memory-region specified.\n");

If you really want that debug message, please keep the action part
first. I personally think it is just noise; the devicetree can always
be looked up if needed.

> +	} else {
> +		ret = of_address_to_resource(node, 0, &res);
> +		if (ret) {
> +			dev_err(dev, "No memory address assigned to the region.\n");
> +			goto err_iomap;
> +		}
> +
> +		/*
> +		 * If reserved memory is defined for watchdog reset cause.
> +		 * Readout the Power-on(PON) reason and pass to bootstatus.
> +		 */
> +		paddr = res.start;
> +		reserved_mem_size = res.end - (res.start - 1);

Please use resource_size().

> +		if (reserved_mem_size < RESERVED_MEM_MIN_SIZE) {
> +			dev_err(dev, "The size of reserved memory is too small.\n");
> +			ret = -EINVAL;
> +			goto err_iomap;
> +		}
> +
> +		vaddr = memremap(paddr, reserved_mem_size, MEMREMAP_WB);
> +		if (vaddr == NULL) {
> +			dev_err(dev, "Failed to map memory-region.\n");
> +			ret = -ENOMEM;
> +			goto err_iomap;
> +		}
> +
> +		if (vaddr[0] == PON_REASON_SOF_NUM &&
> +		    vaddr[1] == PON_REASON_MAGIC_NUM &&
> +		    vaddr[2] == PON_REASON_EOF_NUM) {
> +			dev_dbg(dev, "Watchdog reset cause detected.\n");

Isn't that a bit pointless ? That is obvious when reading the boot status.

> +			wdd->bootstatus |= WDIOF_CARDRESET;
> +		}
> +		memset(vaddr, 0, reserved_mem_size);
> +		memunmap(vaddr);
> +	}
> +
>   	watchdog_init_timeout(wdd, heartbeat, dev);
>   
>   	ret = watchdog_register_device(wdd);

