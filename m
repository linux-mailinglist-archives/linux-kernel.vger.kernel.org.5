Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311B1790BA7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbjICLnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjICLnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEEDF3;
        Sun,  3 Sep 2023 04:43:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07B7560C26;
        Sun,  3 Sep 2023 11:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7CDC433C8;
        Sun,  3 Sep 2023 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693741395;
        bh=6Nqr5gw8uCnA8rg+G6Bui+BU1I6puGFeo5IqC4ON170=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LrsnYnE7FdIFvQjVAcYGXu9awE7Z8YCZkQxUgcNfzCrglEKuoAgcx0iiktcCPEtcF
         QOKASvyxSwfSZx1r44F9cbSxnCqu1Qhu6C5Oc8UB5YHSzR0/krAZ+p0L6cGu83Ss+E
         ocKGpsBpSEK8wxZKpY9bu6jFYmw/FG6BQTRV17+PpZzsoHEDLdKIFaEdPyVEx5+du4
         PVqt6mlTHKhzROWRVU0NrQsx8PWo4su+uBuGTMwk1Sq4iRa5HvOBhjzXoWlopI3nLq
         q1tGA/dIGYxiVMNwRWaF07epqAa2tIzOjcrQf9hcfYU90CAv49wxYHDd2nka8iiAsm
         BQyYtT1j5bevg==
Date:   Sun, 3 Sep 2023 12:43:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add ltc2309 support
Message-ID: <20230903124341.360c95fe@jic23-huawei>
In-Reply-To: <20230828-ltc2309-v3-2-338b3a8fab8b@gmail.com>
References: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
        <20230828-ltc2309-v3-2-338b3a8fab8b@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 22:41:35 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> 
> This implements support for all single-ended and differential channels,
> in unipolar mode only.
> 
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Hi Liam,

A few really small editorial bits in here.  I'll fix them whilst applying.
Series applied to the togreg branch of iio.git

Note I will be rebasing the tree on rc1 once available and in the meantime
this will only be pushed out as testing.

Thanks,

Jonathan



> +/**
> + * struct ltc2309 - internal device data structure
> + * @dev:	Device reference
> + * @client:	I2C reference
> + * @vref:	External reference source
> + * @lock:	Lock to serialize data access
> + * @vref_mv	Internal voltage reference

Missing : which is what the bot picked up on.

> + */
> +struct ltc2309 {
> +	struct device		*dev;
> +	struct i2c_client	*client;
> +	struct regulator	*vref;
> +	struct mutex		lock; /* serialize data access */
> +	int			vref_mv;
> +};

> +
> +void ltc2309_regulator_disable(void *regulator)
> +{
> +	struct regulator *r = (struct regulator *)regulator;

Never any need to explicitly cast from a void * to any other pointer type.
(C spec says it is always fine to do this :)

Given type is obvious from use, can just do
	regulator_disable(regulator);
and lose the local variable.

> +
> +	regulator_disable(r);
> +}

..
> +
> +static const struct of_device_id ltc2309_of_match[] = {
> +	{ .compatible = "lltc,ltc2309" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ltc2309_of_match);
> +
> +static const struct i2c_device_id ltc2309_id[] = {
> +	{ "ltc2309" },
> +	{}

Trivial but space between { and } for consistency.


