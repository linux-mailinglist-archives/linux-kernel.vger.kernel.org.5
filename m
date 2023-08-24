Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6178781A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbjHXSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbjHXShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:37:19 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCA21FCA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:37:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so427142a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692902223; x=1693507023;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvkwv2oqTP+pO4hYA4rG3ApU1P4yvVukZ5H0zf1EQAk=;
        b=cA7+UHVVECJqrEE6p/VJbSOVeYpIYp/36VZMxoyg6KWGWNmGA+KGFC13OC5EvJU3ib
         t04RKuHyl2uH08pv+mR1Jg3WejFg0hcPL3n+eix5+gWC6p6/fGBHT6bwUvy2Ill2lMWo
         6X/gdaLNCDWxwjN7VzeHbffd6yQYd6D/sKs24xITfEpB0Mj47e+Orizs35wLrXeZ0vnQ
         JO+2+ZfivJGKFlKkiWj1qdqWfRzonaDgPqoO45pg7/IKrYqQKVZfxW7Qb+nqxUFsQWpl
         Unwfsz6SyxpjgCZRZjHmFC+y9pdxE/pF3iDJ3nxewpNsyz+TR+bd9hwwIvzA7wmQEz7h
         HuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902223; x=1693507023;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvkwv2oqTP+pO4hYA4rG3ApU1P4yvVukZ5H0zf1EQAk=;
        b=bYxMVIE9bl/DbrE4C7sXxp2L82IlytXArOPJzKxI3dkIa0sPtTFGNLHmSmPQRu3f1c
         NaKA/23sfwb/JzSw6ga1f04yBwwgowRXSnCSj9AdEZazrPhAzYgAJPoaPvcH6Lq4hnC6
         R/NlUYI9W3uMyY2R54zwzhSlfj8l7b3WYcqdTb4jlHMzoy4CGo9rooYdAtd0+CTbMmZu
         w3qCa3Y5CLa3zQj41hCeoGkEF6lUZFljniylUYKeFfzT3XKiuaU6g2znhkgfkwWl3KCt
         I+in0nkUECsmo7l9q7tsmRrM6xudRDprtbpcFnJjt7sIKveoanqPmhc5QynbdBfr8GWR
         lQGA==
X-Gm-Message-State: AOJu0YwUUw/OME0vVqXH7NFUYcNI1jlniCyVJkuUkZRkWPA2xXjcGWbE
        w3DMpRmjRUcilq9fow8mTwZtYQ==
X-Google-Smtp-Source: AGHT+IFH0SjCZSGrn7Os/RP0/GeyRTvMpzBP69ReY9cPwGMFt6KWOEV/ME/DCBYhsKqHrUz2iRxPKg==
X-Received: by 2002:aa7:d502:0:b0:525:b29d:8dc8 with SMTP id y2-20020aa7d502000000b00525b29d8dc8mr20912857edq.5.1692902223431;
        Thu, 24 Aug 2023 11:37:03 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0052228721f84sm44909eds.77.2023.08.24.11.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:37:03 -0700 (PDT)
Message-ID: <41581c90-3ee0-c969-2b54-ee512d637788@linaro.org>
Date:   Thu, 24 Aug 2023 20:37:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 09/11] firmware: imx: enclave-fw: add handling for
 save/restore IMEM region
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-10-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823073330.1712721-10-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 09:33, Pankaj Gupta wrote:
> Some IMEM region is lost during kernel power down. Due to this,
> firmware's functionaity cannot work correctly.
> 
> Saving encrypted IMEM region in kernel memory during power down,
> and restore IMEM region on resume.
> 
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>


> @@ -959,6 +962,17 @@ static int se_probe_cleanup(struct platform_device *pdev)
>  		priv->flags &= (~RESERVED_DMA_POOL);
>  	}
>  
> +	/* free the buffer in ele-mu remove, previously allocated
> +	 * in ele-mu probe to store encrypted IMEM
> +	 */

Use Linux coding style comments.

> +	if (priv->imem.buf) {
> +		dmam_free_coherent(&pdev->dev,
> +				   ELE_IMEM_SIZE,
> +				   priv->imem.buf,
> +				   priv->imem.phyaddr);
> +		priv->imem.buf = NULL;
> +	}
> +
>  	if (priv->ctxs) {
>  		for (i = 0; i < priv->max_dev_ctx; i++) {
>  			if (priv->ctxs[i])
> @@ -1160,6 +1174,19 @@ static int se_fw_probe(struct platform_device *pdev)
>  			dev_err(dev, "Failed to init ele-trng\n");
>  	}
>  
> +	if (info->imem_mgmt) {
> +		/* allocate buffer where ELE store encrypted IMEM */
> +		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
> +						     &priv->imem.phyaddr,
> +						     GFP_KERNEL);
> +		if (!priv->imem.buf) {
> +			dev_err(dev,
> +				"dmam-alloc-failed: To store encr-IMEM.\n");
> +			ret = -ENOMEM;
> +			goto exit;
> +		}
> +	}
> +
>  	pr_info("i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",
>  		info->se_name,
>  		priv->ele_mu_id);
> @@ -1196,17 +1223,31 @@ static int se_fw_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int se_fw_suspend(struct device *dev)
>  {
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);

No.

> +	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
> +						: NULL;
> +
> +	if (info && info->imem_mgmt)
> +		priv->imem.size = save_imem(dev);
> +
>  	return 0;
>  }
>  
>  static int se_fw_resume(struct device *dev)
>  {
>  	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);

Why do you keep matching device every time? Don't.

> +	struct imx_info *info = (of_id != NULL) ? (struct imx_info *)of_id->data
> +						: NULL;
>  	int i;
>  
>  	for (i = 0; i < priv->max_dev_ctx; i++)
>  		wake_up_interruptible(&priv->ctxs[i]->wq);
>  
> +	if (info && info->imem_mgmt)
> +		restore_imem(dev, info->pool_name);
> +
>  	return 0;
>  }
>  #endif
> diff --git a/drivers/firmware/imx/se_fw.h b/drivers/firmware/imx/se_fw.h
> index b3502affbc85..acb967f2357c 100644
> --- a/drivers/firmware/imx/se_fw.h
> +++ b/drivers/firmware/imx/se_fw.h
> @@ -165,4 +165,12 @@ struct ele_mu_priv {
>  	struct ele_imem_buf imem;
>  };
>  
> +phys_addr_t get_phy_buf_mem_pool(struct device *dev,
> +				 char *mem_pool_name,
> +				 u32 **buf,
> +				 uint32_t size);
> +void free_phybuf_mem_pool(struct device *dev,
> +			  char *mem_pool_name,
> +			  u32 *buf,
> +			  uint32_t size);
>  #endif
> diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
> index 8a5c385210fc..6fbea7a8d7c9 100644
> --- a/include/linux/firmware/imx/ele_base_msg.h
> +++ b/include/linux/firmware/imx/ele_base_msg.h
> @@ -37,12 +37,23 @@
>  #define ELE_GET_TRNG_STATE_RETRY_COUNT	0x5
>  #define CSAL_TRNG_STATE_MASK		0x0000ffff
>  
> +#define ELE_SERVICE_SWAP_REQ		0xDF
> +#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x03
> +#define ELE_IMEM_SIZE			0x10000
> +#define ELE_IMEM_STATE_OK		0xCA
> +#define ELE_IMEM_STATE_BAD		0xFE
> +#define ELE_IMEM_STATE_WORD		0x27
> +#define ELE_IMEM_STATE_MASK		0x00ff0000
> +#define ELE_IMEM_EXPORT			0x1
> +#define ELE_IMEM_IMPORT			0x2
> +
>  #define ELE_BASE_API_VERSION		0x6
> -#define ELE_SUCCESS_IND			0xD6
> -#define ELE_FAILURE_IND			0x29

No, you just added them. Don't add wrong code to remove it in next patch.

Best regards,
Krzysztof

