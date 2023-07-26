Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B61D763EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjGZSjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjGZSju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:39:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629519BD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:39:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bc02890c1so3254066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690396787; x=1691001587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4MAGrdTQMzdYEj4illUgs9Le/LNfFeFQ/jUoJpzojCI=;
        b=hDpLPL8C+lrAvejTTpF83hA/kj50XSAImbPhvRPGAh/Ta+aUF9a6NO0FiDQRAE3ARG
         cs+s/sPD8T5f4saS0A8cXo74UIQTBSrWtyWe/yr0B96hOX+O4E7QHYfj/Aa+6FvnA8s4
         e+L/7GFNNl6K0Nx5py2rEMOWE/MwIVFXtWDihTHfJtRzdapHUk8B3VDNDgVHoldHQZuY
         Mh7WMlemyQfcTjczQHmhL5I6GgrHKC4VVUiCSqsesJbGnDkG0gkzIny0AE4MqkUqgTG6
         6LciRPYOhP89NuVecgrN+eCdopo13hMgKDZuPlaCqGD1PdTHgrZiFFYG18JNdPMpM8KU
         pb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690396787; x=1691001587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4MAGrdTQMzdYEj4illUgs9Le/LNfFeFQ/jUoJpzojCI=;
        b=mGyKKGCplsyIyzyzbR35a3DmElOI1AtEIBsSJrr5lnTqWxuV+uNWk5V/ZSsX7qBkG5
         qP6eBmAKO2MgEPePPiPsIVu3gMAdaCecs7S/IIMJ/tf1/R6rpQ0OckbEQTKWnpEtrjZH
         C8/53LO3a6zfvPbsjLgda/jqngl+oelbTPCMSUba5jJ+SO8sKsGkOnt4kz7W0+Gtk2FX
         h+CfWLe2rrHacLp3hCdIgPFZlag/ePVOmYTPbg4Lb9vurPA+05EWolTh+q0EHrJb0PPo
         eUF6+q6k8Z1lD5fh0EYoYx9RlKgIwmvlxO8ydliAHB/HrHZRZPvKKLnNAPzPXa8vUBCT
         gbYw==
X-Gm-Message-State: ABy/qLb524dcGpdoQbxPLr4WvBjAjcSHD6tAFFEX2UsQrzwe422yaX4/
        Yrwy+GXiyMe4DIu+Yn7QeRDEVw==
X-Google-Smtp-Source: APBJJlHFlVHnDoYChSG864jT5xg1AbZSe/g0U/jSIJl/WB6hOgWi4F1WhdBqOKbUchvcRn28/tnecw==
X-Received: by 2002:a17:906:854b:b0:99b:c830:cf23 with SMTP id h11-20020a170906854b00b0099bc830cf23mr19050ejy.27.1690396787013;
        Wed, 26 Jul 2023 11:39:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id pk4-20020a170906d7a400b00993004239a4sm9877516ejb.215.2023.07.26.11.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 11:39:46 -0700 (PDT)
Message-ID: <0fc2ba5d-8357-6dfb-4aa4-26de6b497c13@linaro.org>
Date:   Wed, 26 Jul 2023 20:39:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] drivers: misc: adi-axi-tdd: Add new TDD engine driver
Content-Language: en-US
To:     Eliza Balas <eliza.balas@analog.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230726071103.12172-1-eliza.balas@analog.com>
 <20230726071103.12172-2-eliza.balas@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230726071103.12172-2-eliza.balas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 09:11, Eliza Balas wrote:
> This patch introduces the driver for the new ADI TDD engine HDL.
> The generic TDD controller is in essence a waveform generator
> capable of addressing RF applications which require Time Division
> Duplexing, as well as controlling other modules of general
> applications through its dedicated 32 channel outputs.
> 
> The reason of creating the generic TDD controller was to reduce
> the naming confusion around the existing repurposed TDD core
> built for AD9361, as well as expanding its number of output
> channels for systems which require more than six controlling signals.
> 
> Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> ---
>  .../sysfs-bus-platform-drivers-adi-axi-tdd    | 158 ++++
>  MAINTAINERS                                   |   2 +
>  drivers/misc/Kconfig                          |  10 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/adi-axi-tdd.c                    | 753 ++++++++++++++++++
>  5 files changed, 924 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
>  create mode 100644 drivers/misc/adi-axi-tdd.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd b/Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
> new file mode 100644
> index 000000000000..eb5f3db7d0cb
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-platform-drivers-adi-axi-tdd
> @@ -0,0 +1,158 @@
> +What:           /sys/bus/platform/drivers/adi-axi-tdd/*/burst_count
> +Date:           July 2023
> +KernelVersion:  6.5

We are in 6.5 now, so there is no way your driver will be in 6.5. Target
6.6 and use phb crystall ball for next release date (September).

...

> +
> +enum adi_axi_tdd_attribute_id {
> +	ADI_TDD_ATTR_VERSION,
> +	ADI_TDD_ATTR_CORE_ID,
> +	ADI_TDD_ATTR_SCRATCH,
> +	ADI_TDD_ATTR_MAGIC,
> +

...

> +
> +static int adi_axi_tdd_probe(struct platform_device *pdev)
> +{
> +	unsigned int expected_version, version, data;
> +	struct adi_axi_tdd_state *st;
> +	struct clk *aclk;
> +	int ret;
> +
> +	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	st->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(st->base))
> +		return PTR_ERR(st->base);
> +
> +	platform_set_drvdata(pdev, st);
> +
> +	aclk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
> +	if (IS_ERR(aclk))
> +		return PTR_ERR(aclk);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, adi_axi_tdd_clk_disable, aclk);

Looks you have here double disable.

> +	if (ret)
> +		return ret;
> +
> +	st->clk.clk = devm_clk_get(&pdev->dev, "intf_clk");
> +	if (IS_ERR(st->clk.clk))
> +		return PTR_ERR(st->clk.clk);
> +
> +	ret = clk_prepare_enable(st->clk.clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, adi_axi_tdd_clk_disable, st->clk.clk);

Looks you have here double disable.


> +	if (ret)
> +		return ret;
> +
> +	st->clk.rate = clk_get_rate(st->clk.clk);
> +	st->clk.nb.notifier_call = adi_axi_tdd_rate_change;
> +	ret = clk_notifier_register(st->clk.clk, &st->clk.nb);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, adi_axi_tdd_clk_notifier_unreg, st->clk.clk);

Wrap your lines. Limit is 80.

> +	if (ret)
> +		return ret;
> +
> +	st->regs = devm_regmap_init_mmio(&pdev->dev, st->base,
> +					 &adi_axi_tdd_regmap_cfg);
> +	if (IS_ERR(st->regs))
> +		return PTR_ERR(st->regs);
> +
> +	ret = regmap_read(st->regs, ADI_AXI_REG_VERSION, &version);
> +	if (ret)
> +		return ret;
> +



Best regards,
Krzysztof

