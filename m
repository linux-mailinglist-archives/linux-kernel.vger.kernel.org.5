Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8D7EF751
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 19:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjKQSIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 13:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKQSID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 13:08:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE34D5B;
        Fri, 17 Nov 2023 10:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CAyZaE4H4axmPE1h/br32nT1ap4ua7ua6LSLoIIXfxY=; b=u7K5xTvVRb73ZYsyfGIaz4AbGc
        RL2x5yzAFXGn5pJx7SZNKZi+yUT+cd97InufnHM/33KIwuv19UZE6NATItGdT+HF8yjkNdd828VS+
        2cTDuTPIpFPcWPevds2DwK5IRrGnNAI2Ns+HVeTR435sR33NqWIvJPNzQA7cG1b51jV+7rFgTZ+wQ
        zLUerwWnq2O5avaRy+os/EEivfUpQtGE5/G5ONcGDN8K1Q9ktmzdyvi+huH+00xogKODWIwSdSnLP
        q5OsJq+zSR7pTEQe9oFPReeHIKPNakGE7QTYA1M9vJiUHZ+DNPBdCmIV6yAesO1pY6IwFZjgDzh3x
        Vchk5yLg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r43G2-0074QE-0F;
        Fri, 17 Nov 2023 18:07:58 +0000
Message-ID: <b478e572-3188-459d-9fa2-1de9ff8a8699@infradead.org>
Date:   Fri, 17 Nov 2023 10:07:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: fix recursion typo in kernel doc
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231117171628.20139-1-johan+linaro@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231117171628.20139-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/23 09:16, Johan Hovold wrote:
> Fix a typo in the kernel doc for the of_platform_depopulate() functions,
> which remove children "recursively".
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  drivers/of/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 126d265aa7d8..2293059758d1 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -668,7 +668,7 @@ EXPORT_SYMBOL_GPL(of_platform_device_destroy);
>   * @parent: device which children will be removed
>   *
>   * Complementary to of_platform_populate(), this function removes children
> - * of the given device (and, recurrently, their children) that have been
> + * of the given device (and, recursively, their children) that have been
>   * created from their respective device tree nodes (and only those,
>   * leaving others - eg. manually created - unharmed).
>   */
> @@ -737,7 +737,7 @@ static int devm_of_platform_match(struct device *dev, void *res, void *data)
>   * @dev: device that requested to depopulate from device tree data
>   *
>   * Complementary to devm_of_platform_populate(), this function removes children
> - * of the given device (and, recurrently, their children) that have been
> + * of the given device (and, recursively, their children) that have been
>   * created from their respective device tree nodes (and only those,
>   * leaving others - eg. manually created - unharmed).
>   */

-- 
~Randy
