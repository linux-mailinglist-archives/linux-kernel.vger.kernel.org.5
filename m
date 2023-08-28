Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689D178B337
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjH1Ofg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjH1OfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:35:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C4C9;
        Mon, 28 Aug 2023 07:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83FB0649C7;
        Mon, 28 Aug 2023 14:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17738C433C8;
        Mon, 28 Aug 2023 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693233302;
        bh=xvcD4T141QWQdLnTpjwFsaRzVQbDz33pxGbpyYMH39s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nsftVUsYbfugJ2EsSq4/XYJZ4RiwxXGDBsQIyj0SW4IaLjyUIJdvCIoE0qjgnujA/
         BiWFMgKTVf3TEjJWy1fI4t8H5tDWLyaX9vsE4H/BR4WBSMeuCf7olL7XZ2ZfDK2A7o
         lTjG8i7jq6+jrrYuzOEGFa3p/YPxFjtxuS75MBCKLBTH4FKQ9006ovnbbRqBcXZK9J
         BfWh9A0cs1IgJAjC67SvPFk45bp6/40icq/pcEyZPHWrSJUE8arhwK5dvvGyggzCyR
         VFiN0vJfvtzJjjv/Sy2x0dGtLwzNrp44VTm1rP+WD2kOVTeu/sMFTFJOQ+8MqW3ZIm
         sQP2IIMl0o0uw==
Date:   Mon, 28 Aug 2023 15:35:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ana-Maria Cusco <ana-maria.cusco@analog.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: amplifiers: hmc425a: Add Support HMC540S 4-bit
 Attenuator
Message-ID: <20230828153522.754cb7ff@jic23-huawei>
In-Reply-To: <20230816110906.144540-1-ana-maria.cusco@analog.com>
References: <20230816110906.144540-1-ana-maria.cusco@analog.com>
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

On Wed, 16 Aug 2023 14:09:05 +0300
Ana-Maria Cusco <ana-maria.cusco@analog.com> wrote:

> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This adds support for the Analog Devices HMC540s 1 dB LSB
> Silicon MMIC 4-Bit Digital Positive Control Attenuator, 0.1 - 8 GHz
> 
> Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>

Hi Ana-Maria

Generally for all but single patch series, I'd prefer a cover letter.
For new drivers, just put a short description of the device in there.
There are various reasons, but the simplest one is that it provides
a place where people can offer Reviewed-by etc for the whole series
in a form that the b4 tool I (and lots of other maintainers) use can
pick it up automatically.

Anyhow, actual patches look great to me.

Applied to the togreg branch of iio.git and pushed out as testing for now.
I will be rebasing on 5.6-rc1 once it's available after which these should
get picked up by linux-next.

Thanks,

Jonathan

> ---
>  drivers/iio/amplifiers/hmc425a.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/hmc425a.c
> index 108f0f1685ef..e87d35d50a95 100644
> --- a/drivers/iio/amplifiers/hmc425a.c
> +++ b/drivers/iio/amplifiers/hmc425a.c
> @@ -21,6 +21,7 @@
>  
>  enum hmc425a_type {
>  	ID_HMC425A,
> +	ID_HMC540S,
>  };
>  
>  struct hmc425a_chip_info {
> @@ -70,6 +71,9 @@ static int hmc425a_read_raw(struct iio_dev *indio_dev,
>  		case ID_HMC425A:
>  			gain = ~code * -500;
>  			break;
> +		case ID_HMC540S:
> +			gain = ~code * -1000;
> +			break;
>  		}
>  
>  		*val = gain / 1000;
> @@ -106,6 +110,9 @@ static int hmc425a_write_raw(struct iio_dev *indio_dev,
>  	case ID_HMC425A:
>  		code = ~((abs(gain) / 500) & 0x3F);
>  		break;
> +	case ID_HMC540S:
> +		code = ~((abs(gain) / 1000) & 0xF);
> +		break;
>  	}
>  
>  	mutex_lock(&st->lock);
> @@ -157,6 +164,7 @@ static const struct iio_chan_spec hmc425a_channels[] = {
>  /* Match table for of_platform binding */
>  static const struct of_device_id hmc425a_of_match[] = {
>  	{ .compatible = "adi,hmc425a", .data = (void *)ID_HMC425A },
> +	{ .compatible = "adi,hmc540s", .data = (void *)ID_HMC540S },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, hmc425a_of_match);
> @@ -171,6 +179,15 @@ static struct hmc425a_chip_info hmc425a_chip_info_tbl[] = {
>  		.gain_max = 0,
>  		.default_gain = -0x40, /* set default gain -31.5db*/
>  	},
> +	[ID_HMC540S] = {
> +		.name = "hmc540s",
> +		.channels = hmc425a_channels,
> +		.num_channels = ARRAY_SIZE(hmc425a_channels),
> +		.num_gpios = 4,
> +		.gain_min = -15000,
> +		.gain_max = 0,
> +		.default_gain = -0x10, /* set default gain -15.0db*/
> +	},
>  };
>  
>  static int hmc425a_probe(struct platform_device *pdev)

