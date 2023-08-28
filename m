Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB49C78B6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjH1SAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjH1R7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:59:50 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141CC19B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:59:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso20067405ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693245584; x=1693850384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZlJbdWaIR63MB6+cKGfIWNhhvdxDwDKbDPjEhuXlc8=;
        b=re2vWxTZsJngYqKRFCy6UaCblUfr8fKqPYK+fIVrV60MQdCGt7sP5+DUb8DKQP5DYD
         oLbwVQ3qoS6hb2+KLIYFlDvt8th9hPvi8oo6wPIA4jTY79tQjLzHQrfbXqKZdxl8aDKU
         bq8QoxGbQ4VMUb3+xnBM9SHB6UuUyNevVjww783ppAMD7vrvQqbFKzKvq+ZvsUxA9Gwc
         uIjmhgU2pWeE7++1c6e6XDIDHzDckTTsjg1DKy/1i9TdstvFUKaet6jQw64VTRu+EvGf
         JoXdp6xFNFTuM/kQJFl8wfzNtRLiopfOeys5dZCP4sFVp/eHP1mDh+wN7eHf35Rl71nl
         oXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693245584; x=1693850384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZlJbdWaIR63MB6+cKGfIWNhhvdxDwDKbDPjEhuXlc8=;
        b=Z/OqhDOnc2AzroR/IGsDrNTMEelFn61lk3euhYPpw+AyccwsxMf89mWZpvlMpyI6kD
         FC0C/wwye1FjtHyjXFQdfBQX47ljn7pA8eZsRTmt/JemxLS5xh49ToelZJ1Y65y74u5L
         klJftOUIgyY/yD6sx2U0pbHt4wKHUl/NCA6kDoA22DW/MFCsj4AJecH2gi93AY3CA2lo
         AUHZr3TIwsRo1vPKYHADt8p64FxvUcGiG8tCSDHrVZqGxpaBINTiPAtBZKv9vTaxW1vH
         SA6MNMKEaB/ESOX256/g6lfwdvtzoa8GVZqRfZ18y65DeI5OXxadfeSHZud/jHNwOD9P
         U46A==
X-Gm-Message-State: AOJu0Yz0Oulf9xDJO55rMVbdMVopSINfhdGv7zyi4myOfuSOrb90flcP
        Hx355jf+lyUkgV+k16HFfldYLg==
X-Google-Smtp-Source: AGHT+IHve46vr57tT4L0A+DoFQ2zYJAJtNF3aR+RJ/z+x45b5NMheAll5oulWOektSu43lHp5g9Nsg==
X-Received: by 2002:a17:902:ef96:b0:1c0:bcbc:d5d with SMTP id iz22-20020a170902ef9600b001c0bcbc0d5dmr9540910plb.61.1693245584478;
        Mon, 28 Aug 2023 10:59:44 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:3b:df05:c142:c2ef])
        by smtp.gmail.com with ESMTPSA id jh12-20020a170903328c00b001bf5c12e9fesm7714881plb.125.2023.08.28.10.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 10:59:43 -0700 (PDT)
Date:   Mon, 28 Aug 2023 11:59:41 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v16 08/14] remoteproc: mediatek: Probe SCP cluster on
 multi-core SCP
Message-ID: <ZOzgja8mfNefRqP7@p14s>
References: <20230728023959.12293-1-tinghan.shen@mediatek.com>
 <20230728023959.12293-9-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728023959.12293-9-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tinghan,

On Fri, Jul 28, 2023 at 10:39:53AM +0800, Tinghan Shen wrote:
> The difference of single-core SCP and multi-core SCP device tree is
> the presence of child device nodes described SCP cores. The SCP
> driver populates the platform device and checks the child nodes
> to identify whether it's a single-core SCP or a multi-core SCP.
> 
> Add the remoteproc instances of multi-core SCP to the SCP cluster list.
> When the SCP driver is removed, it cleanup resources by walking
> through the cluster list.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 118 +++++++++++++++++++++++++++++++++--
>  1 file changed, 113 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index d67dcabdab9e..d9242c3eb0d7 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -855,7 +855,8 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
>  }
>  
>  static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
> -				      struct mtk_scp_of_cluster *scp_cluster)
> +				      struct mtk_scp_of_cluster *scp_cluster,
> +				      const struct mtk_scp_of_data *of_data)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
> @@ -878,7 +879,7 @@ static struct mtk_scp *scp_rproc_init(struct platform_device *pdev,
>  	scp = rproc->priv;
>  	scp->rproc = rproc;
>  	scp->dev = dev;
> -	scp->data = of_device_get_match_data(dev);
> +	scp->data = of_data;
>  	scp->cluster = scp_cluster;
>  	platform_set_drvdata(pdev, scp);
>  
> @@ -951,15 +952,15 @@ static void scp_free(struct mtk_scp *scp)
>  	mutex_destroy(&scp->send_lock);
>  }
>  
> -static int scp_cluster_init(struct platform_device *pdev,
> -			    struct mtk_scp_of_cluster *scp_cluster)
> +static int scp_add_single_core(struct platform_device *pdev,
> +			       struct mtk_scp_of_cluster *scp_cluster)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct list_head *scp_list = &scp_cluster->mtk_scp_list;
>  	struct mtk_scp *scp;
>  	int ret;
>  
> -	scp = scp_rproc_init(pdev, scp_cluster);
> +	scp = scp_rproc_init(pdev, scp_cluster, of_device_get_match_data(dev));
>  	if (IS_ERR(scp))
>  		return PTR_ERR(scp);
>  
> @@ -975,6 +976,102 @@ static int scp_cluster_init(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static int scp_add_multi_core(struct platform_device *pdev,
> +			      struct mtk_scp_of_cluster *scp_cluster)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct platform_device *cpdev;
> +	struct device_node *child;
> +	struct list_head *scp_list = &scp_cluster->mtk_scp_list;
> +	const struct mtk_scp_of_data **cluster_of_data;
> +	struct mtk_scp *scp, *temp;
> +	int core_id = 0;
> +	int ret;
> +
> +	cluster_of_data = (const struct mtk_scp_of_data **)of_device_get_match_data(dev);
> +
> +	for_each_available_child_of_node(np, child) {
> +		if (!cluster_of_data[core_id]) {
> +			ret = -EINVAL;
> +			dev_err(dev, "Not support core %d\n", core_id);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		cpdev = of_find_device_by_node(child);
> +		if (!cpdev) {
> +			ret = -ENODEV;
> +			dev_err(dev, "Not found platform device for core %d\n", core_id);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		scp = scp_rproc_init(cpdev, scp_cluster, cluster_of_data[core_id]);
> +		put_device(&cpdev->dev);
> +		if (IS_ERR(scp)) {
> +			ret = PTR_ERR(scp);
> +			dev_err(dev, "Failed to initialize core %d rproc\n", core_id);
> +			of_node_put(child);
> +			goto init_fail;
> +		}
> +
> +		ret = rproc_add(scp->rproc);
> +		if (ret) {
> +			dev_err(dev, "Failed to add rproc of core %d\n", core_id);
> +			of_node_put(child);
> +			scp_free(scp);
> +			goto init_fail;
> +		}
> +
> +		list_add_tail(&scp->elem, scp_list);
> +		core_id++;
> +	}
> +
> +	platform_set_drvdata(pdev, scp);
> +

Here we are setting the platform device for @pdev to the last @scp that was
created, which is needed because (1) scp_rproc_init() is calling
platform_set_drvdata() on the child platform devices and (2) we need a handle to
the cluster list in scp_remove().

Please add a comment with the above just before calling platform_set_drvdata().
Otherwise it will be very difficult for people not familiar with the driver to
understand what is going on.

Otherwise I think we are done.

Thanks,
Mathieu

> +	return 0;
> +
> +init_fail:
> +	list_for_each_entry_safe_reverse(scp, temp, scp_list, elem) {
> +		list_del(&scp->elem);
> +		rproc_del(scp->rproc);
> +		scp_free(scp);
> +	}
> +
> +	return ret;
> +}
> +
> +static int scp_is_single_core(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct device_node *child;
> +
> +	child = of_get_next_available_child(np, NULL);
> +	if (!child)
> +		return dev_err_probe(dev, -ENODEV, "No child node\n");
> +
> +	of_node_put(child);
> +	return of_node_name_eq(child, "cros-ec-rpmsg");
> +}
> +
> +static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_cluster *scp_cluster)
> +{
> +	int ret;
> +
> +	ret = scp_is_single_core(pdev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret)
> +		ret = scp_add_single_core(pdev, scp_cluster);
> +	else
> +		ret = scp_add_multi_core(pdev, scp_cluster);
> +
> +	return ret;
> +}
> +
>  static int scp_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1007,6 +1104,10 @@ static int scp_probe(struct platform_device *pdev)
>  
>  	INIT_LIST_HEAD(&scp_cluster->mtk_scp_list);
>  
> +	ret = devm_of_platform_populate(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to populate platform devices\n");
> +
>  	ret = scp_cluster_init(pdev, scp_cluster);
>  	if (ret)
>  		return ret;
> @@ -1101,12 +1202,19 @@ static const struct mtk_scp_of_data mt8195_of_data_c1 = {
>  	.host_to_scp_int_bit = MT8195_CORE1_HOST_IPC_INT_BIT,
>  };
>  
> +static const struct mtk_scp_of_data *mt8195_of_data_cores[] = {
> +	&mt8195_of_data,
> +	&mt8195_of_data_c1,
> +	NULL
> +};
> +
>  static const struct of_device_id mtk_scp_of_match[] = {
>  	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
>  	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
>  	{ .compatible = "mediatek,mt8188-scp", .data = &mt8188_of_data },
>  	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
>  	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
> +	{ .compatible = "mediatek,mt8195-scp-dual", .data = &mt8195_of_data_cores },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
> -- 
> 2.18.0
> 
