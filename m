Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663727BBB83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjJFPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjJFPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:15:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA04DB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:15:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EABC433C7;
        Fri,  6 Oct 2023 15:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696605304;
        bh=TS2KSpELxN2o4osPlpSr8gudvaRdRIHPG6kMA5e7n4M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vGki2345TOJlMVBvIKwuQI98Wo7ipH7r6becgGbL2D31sx8582WicsnaPLvY8WVrE
         vcgOh5AsDswteKmdvHcMN/CodAGRtD8JKidrMM3DPj+duEGHuYNJUszg8ixYttD0KV
         jANcKtOjW8StTWJDmGjJuuxbn1NoAOIgYLaT4bJPGhcM7PSq4vJ+R4exxz5vXUrVuU
         B9uBl7/x79BPfPonL1VvuxdptQZQJzBB3qp7e9gu9k4jwFo254V4iIKyL4twnaeB7r
         yr2QAtepoKKfjvFsYqV7vgURvf2uxgTmPw1HII30nY/iRHFP/trqD4LeTph+gcnJwj
         yWZLSVI8mgHag==
Message-ID: <ac999bde-d015-42a9-caff-4b0620298d88@kernel.org>
Date:   Sat, 7 Oct 2023 00:15:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] extcon: max77843: add device-tree compatible
 string
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20231006100434.2908243-1-m.szyprowski@samsung.com>
 <CGME20231006100442eucas1p2a51781e74ccd43bbac5c5d0eead6101f@eucas1p2.samsung.com>
 <20231006100434.2908243-2-m.szyprowski@samsung.com>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20231006100434.2908243-2-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 6. 19:04, Marek Szyprowski wrote:
> Add the needed device-tree compatible string to the MAX77843 extcon
> driver, so it can be automatically loaded when compiled as a kernel
> module and given device-tree contains separate 'muic' node under the main
> MAX77843 PMIC node.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max77843.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
> index 1bc0426ce3f1..acb11a54f875 100644
> --- a/drivers/extcon/extcon-max77843.c
> +++ b/drivers/extcon/extcon-max77843.c
> @@ -946,9 +946,16 @@ static const struct platform_device_id max77843_muic_id[] = {
>  };
>  MODULE_DEVICE_TABLE(platform, max77843_muic_id);
>  
> +static const struct of_device_id of_max77843_muic_dt_match[] = {
> +	{ .compatible = "maxim,max77843-muic", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, of_max77843_muic_dt_match);
> +
>  static struct platform_driver max77843_muic_driver = {
>  	.driver		= {
>  		.name		= "max77843-muic",
> +		.of_match_table = of_max77843_muic_dt_match,
>  	},
>  	.probe		= max77843_muic_probe,
>  	.remove		= max77843_muic_remove,

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

