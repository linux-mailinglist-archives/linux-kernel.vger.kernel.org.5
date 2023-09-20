Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C1A7A8363
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbjITN3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235292AbjITN3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:29:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E28DCE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:28:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9aa2c6f0806so898354966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695216535; x=1695821335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKKE8RPYAnWlMmqVMLxDoN9viEYmRbfdJ1ZPSe1owbM=;
        b=mkjtQWNOYZE3Z/NEYSqYX08XnqIq8jkkLKlKtXEIskCUgEpKf2Gyh/TKkbvdER2ydU
         SZT6xzJn6SN2TVt9NY9Gws3ZdQi/fPHczmcDBiT3fJTL9uhM8uVP3Z6/xb7wjXALB//o
         EphpyGHbyFWHC1UVpVjL7jaDPfqc3bhh4AynArEWd8U9kW0WZxesyXMlepbgT9voY4go
         F1RLl0j0+43szoYRfl1etPh1qAF9kZez8qdI5dogTO5lM8kqGwdE6COGBkuj6v2pJum+
         P9omN2WYKjbfKCvdjKfTi6AB3zW/e2pWl+TxaHIGNgHf+vg4sQ1iuNf8mCDnF+UiFxDj
         asqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216535; x=1695821335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKKE8RPYAnWlMmqVMLxDoN9viEYmRbfdJ1ZPSe1owbM=;
        b=jdY4MkZ2OraPNLkqKWihMnZZloCt152cd2sZM2Wb5k2f1wQAdJKGTQKQznqNIAmVGs
         oQLdPO5gkJw1VyXvDQHeztk+jkbZoi/Og750hzTYJtJD5ZnUK7bM8SnUobjJ74ZFKP3p
         oM23uTbwU3aelIMvqigndoMkOpZWI964UdQIghXfT2NKMajTNyI5W+3lzYaaLC8UBisZ
         dBBrNVIhJpbr+XlSa2epHFdX2jZTNWJwowZFKstT0As5W0JQuUS9GBlnfstldnbpaOWV
         vk8ujAtxV81wVAsKXstSbu0PmBSxcoHDPt3e9fOBTath0jXnZyczOmbK6AK0ON6h6D5/
         4Yyg==
X-Gm-Message-State: AOJu0Yzwxknke19j5yoPqjJSBlv/um9PoyU7GdfsQAoz2q3T9QWjTQ5/
        pvzq7xrtcl22BquzSy6yAXbthQ==
X-Google-Smtp-Source: AGHT+IEMb0ZK8g7jPPFXjiWmXny/RUobbu8OKSNXezHxqkqePH36qIeLezlT4sN2iWm9Y9gneehnUw==
X-Received: by 2002:a17:906:23e9:b0:9aa:209f:20c3 with SMTP id j9-20020a17090623e900b009aa209f20c3mr2062185ejg.68.1695216535584;
        Wed, 20 Sep 2023 06:28:55 -0700 (PDT)
Received: from p14s (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906560a00b0099d0c0bb92bsm9237058ejq.80.2023.09.20.06.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:28:55 -0700 (PDT)
Date:   Wed, 20 Sep 2023 07:28:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, wenst@chromium.org,
        laura.nao@collabora.com, tinghan.shen@mediatek.com
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        tinghan.shen@mediatek.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        kernel@collabora.com
Subject: Re: [PATCH] remoteproc: mediatek: Refactor single core check and fix
 retrocompatibility
Message-ID: <ZQrzlcVpvYUY11G5@p14s>
References: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:23:36AM +0200, AngeloGioacchino Del Regno wrote:
> In older devicetrees we had the ChromeOS EC in a node called "cros-ec"
> instead of the newer "cros-ec-rpmsg", but this driver is now checking
> only for the latter, breaking compatibility with those.
> 
> Besides, we can check if the SCP is single or dual core by simply
> walking through the children of the main SCP node and checking if
> if there's more than one "mediatek,scp-core" compatible node.
> 
> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 

I find this patch to be the most appropriate to fix this problem.  Laura,
Chen-Yu and Tinghan, please test the patch and reply public with your Testeb-by
tags.

Thanks,
Mathieu

> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index ea227b566c54..a35409eda0cf 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -1144,29 +1144,25 @@ static int scp_add_multi_core(struct platform_device *pdev,
>  	return ret;
>  }
>  
> -static int scp_is_single_core(struct platform_device *pdev)
> +static bool scp_is_single_core(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev_of_node(dev);
>  	struct device_node *child;
> +	int num_cores = 0;
>  
> -	child = of_get_next_available_child(np, NULL);
> -	if (!child)
> -		return dev_err_probe(dev, -ENODEV, "No child node\n");
> +	for_each_child_of_node(np, child)
> +		if (of_device_is_compatible(child, "mediatek,scp-core"))
> +			num_cores++;
>  
> -	of_node_put(child);
> -	return of_node_name_eq(child, "cros-ec-rpmsg");
> +	return num_cores < 2;
>  }
>  
>  static int scp_cluster_init(struct platform_device *pdev, struct mtk_scp_of_cluster *scp_cluster)
>  {
>  	int ret;
>  
> -	ret = scp_is_single_core(pdev);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret)
> +	if (scp_is_single_core(pdev))
>  		ret = scp_add_single_core(pdev, scp_cluster);
>  	else
>  		ret = scp_add_multi_core(pdev, scp_cluster);
> -- 
> 2.42.0
> 
