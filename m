Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38F47DEE66
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbjKBIxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjKBIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:53:38 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E2AFB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 01:53:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso1057970a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698915210; x=1699520010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8lUhLQnAKiB5QJAzwL6lpYBjp5gMlELZrTelsM0Z0Ew=;
        b=TZ+8HxogxA1aU/PRyuSij/MNsCIrmOYjBcGZ0B0OtqdYG6N2jTGYqGWSsbMs+ASWry
         RLnXE04Kwl7XklAFbuhCGAog4HDfkiCAt+1eoHVBeHCYh6vtY7bqYxTU2MffuVRFeK7r
         Ul6BVdYaBKUEfS6d9/ZRDzAYcRq4vWb2dUfk4f6q7w2JYPTE2mqiF5cgUtOw2LENg7sJ
         tQGTLkUiPmZYCRJvNSbwfgLSXiVEBnjbLA+AROzBv5Z8Y4RF5bwQPCciwvDn7fWbX+GD
         xHu1zNQ3NFOf0s+hlkqB4rFVzHmVU1pTSJTT2lQjOY1WjgYIPZQbbziCPJ+a9NraW5nm
         RgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698915210; x=1699520010;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lUhLQnAKiB5QJAzwL6lpYBjp5gMlELZrTelsM0Z0Ew=;
        b=w7DJ96bVcy4ggwFpLvQql+zJt7HN5UnWRVdKXSogwzO/uhGLpP7cuBXuS437DzL5Lc
         W8pGKy8KjzVxjRjJ+ooDBOpVshrxbguA4CL1WeldnBAIrVHr/aqXXbLTPEZqlbXwZgZJ
         hJPRJZM4R7gFvSsdgSrpPZ9YtWWwXA+udvxsFX87UxLSJjkPBO/qPnFkbtw02kQC41+8
         p5x9npi+c6NbUDeiSCt+XpJtInTas/2iKnfB4cGyTMZX+go89qoAlDbLFoa2kRrgn9dl
         QYU16fESQS4vk9C6qvANEHGkcrXtGQSTTnghnDwEwPpMMBAJc7Ibe/AfXKo02PUjALBe
         4MQg==
X-Gm-Message-State: AOJu0Yw+1Bs1+UQ96IRwwWUKGcanGLPNIHFhZKdQOrHK1ePqUoN05K3p
        frJjggvTo23uKpK7SSEwCTVXCA==
X-Google-Smtp-Source: AGHT+IHYdcg7cB+6Xu6zxwcjtkQSSr1iXUeDbUcg/TK3ElyuuomUagyug7ZGCR3mEkxOs/JNO69rBw==
X-Received: by 2002:aa7:dac2:0:b0:540:4b90:3dc3 with SMTP id x2-20020aa7dac2000000b005404b903dc3mr14274604eds.14.1698915210547;
        Thu, 02 Nov 2023 01:53:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id cy24-20020a0564021c9800b005432f45bee9sm2018883edb.19.2023.11.02.01.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 01:53:29 -0700 (PDT)
Message-ID: <c08ad574-d067-4557-a50c-802d6d7fe353@linaro.org>
Date:   Thu, 2 Nov 2023 09:53:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org
Cc:     p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com
References: <20231102081514.22945-1-jyanchou@realtek.com>
 <20231102081514.22945-3-jyanchou@realtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231102081514.22945-3-jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 09:15, Jyan Chou wrote:
> We implemented cmdq feature on Synopsys DesignWare mmc driver.
> The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
> register definitions, mmc user flow and the addition of cmdq.
> 
> New version of User Guide had modify mmc driver's usage flow,
> we may need to renew code to precisely follow user guide.
> 
> More over, We added a wait status function to satisfy synopsys
> user guide's description, since this flow might be specific in
> synopsys host driver only.

...

> +	for (i = 0; i < host->dma_nents; i++, sg++) {
> +		dma_len = sg_dma_len(sg);
> +
> +		/* blk_cnt must be the multiple of 512(0x200) */
> +		if (dma_len < SZ_512)
> +			blk_cnt = 1;
> +		else
> +			blk_cnt  = dma_len >> 9;
> +
> +		remain_blk_cnt  = blk_cnt;
> +		dma_addr = sg_dma_address(sg);
> +
> +		while (remain_blk_cnt) {
> +			/* DW_MCI_MAX_SCRIPT_BLK is the max
> +			 * for each descriptor record
> +			 */
> +			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
> +				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
> +			else
> +				cur_blk_cnt = remain_blk_cnt;
> +
> +			/* In Synopsys DesignWare Databook Page 84,

/*
 *

I mentioned it last time. Use Linux coding style. For entire patchset.

> +			 * They mentioned the DMA 128MB restriction
> +			 */
> +			begin = dma_addr / SZ_128M;
> +			end = (dma_addr + cur_blk_cnt * SZ_512) / SZ_128M;
> +
> +			/* If begin and end in the different 128MB memory zone */
> +			if (begin != end)
> +				cur_blk_cnt = (end * SZ_128M - dma_addr) / SZ_512;
> +
> +			if (dma_len < SZ_512)
> +				tmp_val = ((dma_len) << 16) | VALID(0x1) | ACT(0x4);
> +			else
> +				tmp_val = ((cur_blk_cnt & 0x7f) << 25) | VALID(0x1) | ACT(0x4);
> +
> +			/* Last descriptor */
> +			if (i == host->dma_nents - 1 && remain_blk_cnt == cur_blk_cnt)
> +				tmp_val |= END(0x1);
> +
> +			desc_base[0] =  tmp_val;
> +			desc_base[1] =  dma_addr;
> +
> +			dma_addr = dma_addr + (cur_blk_cnt << 9);
> +			remain_blk_cnt -= cur_blk_cnt;
> +			desc_base += 2;
> +		}
> +	}
> +}
> +

...

> +
> +#ifdef CONFIG_OF
> +static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_board *pdata;
> +	struct device *dev = host->dev;
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int ret;
> +	u32 clock_frequency;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* find reset controller when exist */
> +	pdata->rstc = devm_reset_control_get_optional(dev, "reset");

Where is it described in the bindings?

> +	if (IS_ERR(pdata->rstc)) {
> +		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
> +			return ERR_PTR(-EPROBE_DEFER);
> +	}
> +
> +	device_property_read_u32(dev, "card-detect-delay",

Where is it described in the bindings? It's not. This is v5 but, sorry,
but I do not see much improvements. You still send code which clearly is
wrong.


> +				 &pdata->detect_delay_ms);
> +
> +	if (!device_property_read_u32(dev, "clock-frequency", &clock_frequency))
> +		pdata->bus_hz = clock_frequency;

Drop property. I don't think it is needed. MMC and CCF has other ways to
do it.

> +
> +	if (drv_data && drv_data->parse_dt) {
> +		ret = drv_data->parse_dt(host);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	return pdata;
> +}
> +
> +#else /* CONFIG_OF */
> +static struct dw_mci_board *dw_mci_cqe_parse_dt(struct dw_mci *host)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +#endif /* CONFIG_OF */
> +
> +static void dw_mci_cqe_cto_timer(struct timer_list *t)
> +{
> +	struct dw_mci *host = from_timer(host, t, timer);
> +
> +	if (host->int_waiting) {
> +		dev_err(host->dev, "fired, opcode=%d, arg=0x%x, irq status=0x%x, err irq=0x%x, auto err irq=0x%x\n",
> +			host->opcode, host->arg,
> +			host->normal_interrupt, host->error_interrupt,
> +			host->auto_error_interrupt);
> +
> +		dw_mci_clr_signal_int(host);
> +		dw_mci_get_int(host);
> +
> +		complete(host->int_waiting);
> +	}
> +}
> +
> +static void dw_mci_cqhci_init(struct dw_mci *host)
> +{
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		host->cqe = cqhci_pltfm_init(host->pdev);
> +		if (PTR_ERR(host->cqe) == -EINVAL ||
> +		    PTR_ERR(host->cqe) == -ENOMEM ||
> +		    PTR_ERR(host->cqe) == -EBUSY) {
> +			dev_err(host->dev, "Unable to get the cmdq related attribute,err = %ld\n",
> +				PTR_ERR(host->cqe));
> +			host->cqe = 0;
> +			host->pdata->caps2 &= ~(MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD);
> +		} else {
> +			host->cqe->ops = &dw_mci_cqhci_host_ops;
> +			cqhci_init(host->cqe, host->slot->mmc, 0);
> +		}
> +	}
> +}
> +
> +int dw_mci_cqe_probe(struct dw_mci *host)
> +{
> +	const struct dw_mci_drv_data *drv_data = host->drv_data;
> +	int ret = 0;
> +
> +	if (!host->pdata) {
> +		host->pdata = dw_mci_cqe_parse_dt(host);
> +		if (PTR_ERR(host->pdata) == -EPROBE_DEFER) {
> +			return -EPROBE_DEFER;
> +		} else if (IS_ERR(host->pdata)) {
> +			dev_err(host->dev, "platform data not available\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	host->biu_clk = devm_clk_get(host->dev, "biu");
> +	if (IS_ERR(host->biu_clk)) {
> +		dev_dbg(host->dev, "biu clock not available\n");
> +	} else {
> +		ret = clk_prepare_enable(host->biu_clk);
> +		if (ret) {
> +			dev_err(host->dev, "failed to enable biu clock\n");
> +			return ret;
> +		}
> +	}

All this should be probably devm_clk_get_enabled().

> +
> +	host->ciu_clk = devm_clk_get(host->dev, "ciu");
> +	if (IS_ERR(host->ciu_clk)) {
> +		dev_dbg(host->dev, "ciu clock not available\n");
> +		host->bus_hz = host->pdata->bus_hz;
> +	} else {
> +		ret = clk_prepare_enable(host->ciu_clk);
> +		if (ret) {
> +			dev_err(host->dev, "failed to enable ciu clock\n");
> +			goto err_clk_biu;
> +		}
> +
> +		if (host->pdata->bus_hz) {
> +			ret = clk_set_rate(host->ciu_clk, host->pdata->bus_hz);
> +			if (ret)
> +				dev_warn(host->dev,
> +					 "Unable to set bus rate to %uHz\n",
> +					 host->pdata->bus_hz);
> +		}

All this should be probably devm_clk_get_enabled().


> +		host->bus_hz = clk_get_rate(host->ciu_clk);

So this proves that your property clock-frequency is useless.

> +	}
> +
> +	if (!host->bus_hz) {
> +		dev_err(host->dev,
> +			"Platform data must supply bus speed\n");
> +		ret = -ENODEV;
> +		goto err_clk_ciu;
> +	}
> +
> +	if (!IS_ERR(host->pdata->rstc)) {
> +		reset_control_assert(host->pdata->rstc);
> +		usleep_range(10, 50);
> +		reset_control_deassert(host->pdata->rstc);
> +	}
> +
> +	timer_setup(&host->timer, dw_mci_cqe_cto_timer, 0);
> +
> +	spin_lock_init(&host->lock);
> +	spin_lock_init(&host->irq_lock);
> +	init_rwsem(&host->cr_rw_sem);
> +	tasklet_init(&host->tasklet, dw_mci_cqe_tasklet_func, (unsigned long)host);
> +
> +	dw_mci_cqe_setup(host);
> +
> +	dw_mci_cqe_init_dma(host);
> +
> +	host->tuning = 0;
> +	host->current_speed = 0;
> +
> +	if (drv_data && drv_data->init) {
> +		ret = drv_data->init(host);
> +		if (ret) {
> +			dev_err(host->dev,
> +				"implementation specific init failed\n");
> +			goto err_dmaunmap;
> +		}
> +	}
> +
> +	ret = dw_mci_cqe_init_slot(host);
> +	if (ret) {
> +		dev_err(host->dev, "slot 0 init failed\n");
> +		goto err_dmaunmap;
> +	}
> +
> +	ret = devm_request_irq(host->dev, host->irq, dw_mci_cqe_interrupt,
> +			       host->irq_flags, "dw-mci-cqe", host);
> +	if (ret)
> +		goto err_dmaunmap;
> +
> +	dw_mci_cqhci_init(host);
> +
> +	return 0;
> +
> +err_dmaunmap:
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);
> +err_clk_ciu:
> +	clk_disable_unprepare(host->ciu_clk);
> +
> +err_clk_biu:
> +	clk_disable_unprepare(host->biu_clk);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_probe);

EXPORT_SYMBOL_GPL

I should have been more explicit:
EXPORT_SYMBOL_GPL everywhere. In this patchset and all your future
patchsets. For all your current and future code.

> +
> +void dw_mci_cqe_remove(struct dw_mci *host)
> +{
> +	if (host->slot)
> +		dw_mci_cqe_cleanup_slot(host->slot);
> +
> +	if (!IS_ERR(host->pdata->rstc))
> +		reset_control_assert(host->pdata->rstc);
> +
> +	clk_disable_unprepare(host->ciu_clk);
> +	clk_disable_unprepare(host->biu_clk);
> +}
> +EXPORT_SYMBOL(dw_mci_cqe_remove);
> +




Best regards,
Krzysztof

