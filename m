Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13114759727
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjGSNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGSNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:38:28 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB9DE5;
        Wed, 19 Jul 2023 06:38:27 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-57764a6bf8cso71984547b3.3;
        Wed, 19 Jul 2023 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689773907; x=1692365907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4SW8uOZK/M3FIyC+ZihHbXBDgWbo0K+gK3nMprTplwY=;
        b=OJ2XS5hw21iiVMy63Nc6I11QW86QUgpHL5wlTk/SH+hU/RDZUnDmIYj2ia40GFt3Wf
         Ss2ZAPmHwPjFc85dNoO0QxX4BdRV9+5i2urOUcWij/J2HMSLS6KQhXkn1/ow4MCubaPy
         lmuGjiB2JvAgZ/SpACSXNlQr/TxZLq/Z3V24HCBOz8KHGgv5josLFQBIfjFOSmliO7lK
         7YuzFT61K+51rnLT+STGVdi5hUUa4pR0GzWOBARV8x4pj2KP1vN+ejNhpuCnI/QidzYf
         74IUCjUhT4qN1UWq5fSk2TvQpDxAzpGiNedbzwfHQ7HbE7o93WUa0fkY8yIb3d+7eR7H
         mHmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689773907; x=1692365907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SW8uOZK/M3FIyC+ZihHbXBDgWbo0K+gK3nMprTplwY=;
        b=OEiGSbF6d4cHZvQsREe5rqTOiPtxt2Bdd/pcEXbxrdsbKcgDMSyMmrp4FYpYUn6hDA
         iQteu9wPZZqPFUprcXe/ctl/T0WQdez2dBHavuPGOs2sMqepU5PVTHTk6l2lB+jngkYh
         heXpaLTnOMZsdsO/QufVu4xfhaGwR3jQMKpVg6rN2TQRaiK8BgY/ICBuk6/cGhfZsu0l
         Jmlo9NQT2pA0aMR/ZdAASqgRIritFK+RFWj57c30pqm83PvDij3FyM7T5xZFCCV7q3jH
         +I6r2yxLcBnsuBM/VLkIOEUO742vuMtgA6qx3ELIRR66jArfdIGDoMVn6Ewcyvt4GCyg
         m6hw==
X-Gm-Message-State: ABy/qLY3fL+TEOJUkZweCGR3bszx65GM6CPjze/2a3veWH1MEmbwr4JK
        pwNyDRF444UVqQuYZYep3cM=
X-Google-Smtp-Source: APBJJlEdoeXvVWnGoO0/djpd45PCLlunRAhNUFdl/sElIJ5HzMwHIZsHZWQC843xxSynt7KZz1XtlA==
X-Received: by 2002:a81:5f45:0:b0:573:b42b:4e27 with SMTP id t66-20020a815f45000000b00573b42b4e27mr3243372ywb.16.1689773905270;
        Wed, 19 Jul 2023 06:38:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10-20020a0de20a000000b0057a5302e2fesm1022721ywe.5.2023.07.19.06.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 06:38:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8248bfb3-02fb-ec8d-8742-169a393abb6e@roeck-us.net>
Date:   Wed, 19 Jul 2023 06:38:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 3/3] watchdog:rit_wdt: Add support for WDIOF_CARDRESET
Content-Language: en-US
To:     huaqian.li@siemens.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     huaqianlee@gmail.com, nm@ti.com, vigneshr@ti.com,
        kristo@kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jan.kiszka@siemens.com,
        baocheng.su@siemens.com
References: <20230718021007.1338761-1-huaqian.li@siemens.com>
 <20230718021007.1338761-4-huaqian.li@siemens.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230718021007.1338761-4-huaqian.li@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 19:10, huaqian.li@siemens.com wrote:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/rti_wdt.c | 48 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
> index ce8f18e93aa9..901109d979f0 100644
> --- a/drivers/watchdog/rti_wdt.c
> +++ b/drivers/watchdog/rti_wdt.c
> @@ -14,6 +14,8 @@
>   #include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
>   #include <linux/platform_device.h>
>   #include <linux/pm_runtime.h>
>   #include <linux/types.h>
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
> @@ -284,6 +296,42 @@ static int rti_wdt_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> +	node = of_parse_phandle(pdev->dev.of_node, "memory-region", 0);
> +	if (node) {
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
> +		reserved_mem_size = resource_size(&res);
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
> +			wdd->bootstatus |= WDIOF_CARDRESET;
> +		}
> +		memset(vaddr, 0, reserved_mem_size);
> +		memunmap(vaddr);
> +	}
> +
>   	watchdog_init_timeout(wdd, heartbeat, dev);
>   
>   	ret = watchdog_register_device(wdd);

