Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4665D7D90A9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235075AbjJ0IFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbjJ0IFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:05:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED72198A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:05:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942DCC433C8;
        Fri, 27 Oct 2023 08:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698393922;
        bh=ewMMbWlU4/Nmrn6PiahmId3D6QqeOBzMX4RkRLmIpts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nyJ0lzbzs+ehaAxhV2/IAt+pUoqzE3PbDed8ZvcJxLHnXqOvv20eNkKEhQyRjJuFE
         1Vpgq/mJoXh/mhdSnxpLg0qzytIcDgFCWrbxAGSawpd5E2iZeayuAwI6IutWxTAxL6
         ENY0Otl7XJl8s7JORRn11hEp04WIcDQT9ra3uUx6hb8aSQKeRloB8b2ool9b3Bvn0W
         aAcKPlhHBiSzUPqZI1jfZafQ7z6j74nfzQC0gXAoc24enuR8enG4DBgdkbNVyw4vEQ
         MgRXxKVNVUcfHuGTfbejozQCh9wq6SLtEo21KABoA47JtKFsq/0ICrbbvfXZ3wc9/x
         pKOAx0rfokmyw==
Message-ID: <dc0852dc-8207-4195-a6ad-41792357aeda@kernel.org>
Date:   Fri, 27 Oct 2023 10:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drivers: misc: Add support for TPS65224 pfsm
 driver
Content-Language: en-US
To:     Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>,
        linux-kernel@vger.kernel.org
Cc:     lee@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org
References: <20231026133226.290040-1-sirisha.gairuboina@Ltts.com>
 <20231026133226.290040-4-sirisha.gairuboina@Ltts.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231026133226.290040-4-sirisha.gairuboina@Ltts.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 15:32, Gairuboina Sirisha wrote:
> From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> 
> Added support for pmic nvm set FSM_I2C_TRIGGER functions driver,
> state control driver, Makefile and Kconfig
> 

...

> +
> +static int tps65224_pfsm_probe(struct platform_device *pdev)
> +{
> +	struct tps65224_pfsm *pfsm;
> +	struct tps65224 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	int irq;
> +	int ret;
> +	int i;
> +
> +	pfsm = devm_kzalloc(dev, sizeof(struct tps65224_pfsm), GFP_KERNEL);

sizeof(*)

> +	if (!pfsm)
> +		return -ENOMEM;
> +
> +	pfsm->regmap = tps->regmap;
> +
> +	pfsm->miscdev.minor = MISC_DYNAMIC_MINOR;
> +	pfsm->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "pfsm-%ld-0x%02x",
> +						tps->chip_id, tps->reg);
> +	pfsm->miscdev.fops = &tps65224_pfsm_fops;
> +	pfsm->miscdev.parent = dev->parent;
> +
> +	for (i = 0 ; i < pdev->num_resources ; i++) {
> +		irq = platform_get_irq_byname(pdev, pdev->resource[i].name);
> +		if (irq < 0)
> +			return dev_err_probe(dev, irq, "Failed to get %s irq\n",
> +						 pdev->resource[i].name);
> +
> +		ret = devm_request_threaded_irq(dev, irq, NULL,
> +						tps65224_pfsm_isr, IRQF_ONESHOT,
> +						pdev->resource[i].name, pdev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to request irq\n");
> +	}
> +
> +	platform_set_drvdata(pdev, pfsm);
> +
> +	return misc_register(&pfsm->miscdev);
> +}
> +
> +static void tps65224_pfsm_remove(struct platform_device *pdev)
> +{
> +	struct tps65224_pfsm *pfsm = platform_get_drvdata(pdev);
> +
> +	misc_deregister(&pfsm->miscdev);
> +}
> +
> +static struct platform_driver tps65224_pfsm_driver = {
> +	.driver	= {
> +		.name = "tps65224-pfsm",
> +	},
> +	.probe = tps65224_pfsm_probe,
> +	.remove_new = tps65224_pfsm_remove,
> +};
> +
> +module_platform_driver(tps65224_pfsm_driver);
> +
> +MODULE_ALIAS("platform:tps65224-pfsm");

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong.


> +MODULE_AUTHOR("Gairuboina Sirisha <sirisha.gairuboina@ltts.com>");
> +MODULE_DESCRIPTION("TPS65224 Pre-configurable Finite State Machine Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/tps65224_pfsm.h b/include/uapi/linux/tps65224_pfsm.h
> new file mode 100644
> index 000000000000..c0a135903b5d
> --- /dev/null
> +++ b/include/uapi/linux/tps65224_pfsm.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace ABI for TPS65224 PMIC Pre-configurable Finite State Machine
> + *
> + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
> + */

Best regards,
Krzysztof

