Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16F78043F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357465AbjHRDMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357518AbjHRDL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:11:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01030C4;
        Thu, 17 Aug 2023 20:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D5D562DFD;
        Fri, 18 Aug 2023 03:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CC4C433C8;
        Fri, 18 Aug 2023 03:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692328315;
        bh=P4Cosx7+7ALtZ7wTAuQVVxQlhIJKI8HxF6c2gX8nBE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVVBJnqtGih+C8vOcMa5nwnrOS+L+pjpanoFXhx8SH3k2vLnD/TvTvFtzRVjG2WO1
         qMiGWuJbMjJHE8HlhkyQ0nIlcYa5QpGOREYJzlOzsc9sH5W/wA8KW5MFmFZlE/VQwR
         ua2U/PSgjwrTX+ElR5Uws2Kk0kocuzeLWOHY9W7X5PTtKFhgxnJeWTZIadert3MdQT
         k9gN/qO9qlw5hFDA8nIQXNNLVUvcvJXBhhCfUteIZEdIU1QTGvb8GhDRPBeSVDpznS
         14nRAUv5equ8ut5gRIgYaM6g6bItRSnzBfgo0Mm/Y3Q0Jjw9fYBDuZke9O0lX6A1E3
         z1vxD97SIXNEQ==
Date:   Thu, 17 Aug 2023 20:14:35 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH v4 3/4] clk: qcom: common: add _qcom_cc_really_probe
Message-ID: <2dcu7jjwd2bhjbzxrxbfif566nupznb5n4oadnqha4h45w2n2g@4uy2pxkj5bvj>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-4-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815085205.9868-4-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 04:52:04PM +0800, Luo Jie wrote:
> Add the common function _qcom_cc_really_probe, which takes
> struct device as parameter.

This commit message completely fails to describe the problem/issue the
change is solving. So when we look back in the git history, there will
be no indication of why things looks like they do.

> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/clk/qcom/common.c | 10 ++++++++--
>  drivers/clk/qcom/common.h |  2 ++
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> index 75f09e6e057e..4cbdbfb65606 100644
> --- a/drivers/clk/qcom/common.c
> +++ b/drivers/clk/qcom/common.c
> @@ -234,11 +234,10 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
>  	return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
>  }
>  
> -int qcom_cc_really_probe(struct platform_device *pdev,
> +int _qcom_cc_really_probe(struct device *dev,
>  			 const struct qcom_cc_desc *desc, struct regmap *regmap)
>  {
>  	int i, ret;
> -	struct device *dev = &pdev->dev;
>  	struct qcom_reset_controller *reset;
>  	struct qcom_cc *cc;
>  	struct gdsc_desc *scd;
> @@ -305,6 +304,13 @@ int qcom_cc_really_probe(struct platform_device *pdev,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(_qcom_cc_really_probe);
> +
> +int qcom_cc_really_probe(struct platform_device *pdev,
> +			 const struct qcom_cc_desc *desc, struct regmap *regmap)

Why do we want to keep this wrapper around?


PS. Please give some time before posting v5, I would like to understand
the MDIO regmap operations in patch 4 better before commenting on it.

Regards,
Bjorn

> +{
> +	return _qcom_cc_really_probe(&pdev->dev, desc, regmap);
> +}
>  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
>  
>  int qcom_cc_probe(struct platform_device *pdev, const struct qcom_cc_desc *desc)
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..9710ade9bf15 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -58,6 +58,8 @@ extern int qcom_cc_register_sleep_clk(struct device *dev);
>  
>  extern struct regmap *qcom_cc_map(struct platform_device *pdev,
>  				  const struct qcom_cc_desc *desc);
> +extern int _qcom_cc_really_probe(struct device *dev,
> +			 const struct qcom_cc_desc *desc, struct regmap *regmap);
>  extern int qcom_cc_really_probe(struct platform_device *pdev,
>  				const struct qcom_cc_desc *desc,
>  				struct regmap *regmap);
> -- 
> 2.17.1
> 
