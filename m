Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B857F8C4D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjKYQPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 11:15:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjKYQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 11:15:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3B3EA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 08:15:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C29C433C8;
        Sat, 25 Nov 2023 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700928925;
        bh=kfauFDg9XTul9XhggWEJMK5ehWMTcrQkQSMmN0gP4QA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pml8R9aXSofO5GAIws74dWY0B7s0w7d6SZHErOeiCttaFYyUlVJY8qYmGRPkObT1D
         TYXGmA+tB/9xYCnKN9J+3RF20Qra/N9yYRTG+SNZE5f/p4S0nDQVITXMBhyP/EW07D
         P74QV1p6FVZUJ9oshulcJLJENbiWEBM0P+IGiSka4dVIudi7ygcAp7LKPBPiSq6RSc
         b3RNL6LMFXZ3KBGFvTVeabCl3qrNTCrLhpXiQ2Ygciw7vB5wGhjz4aMWo83yI8mplC
         b6esqnzlRUCmoNCOnNSE1B3JIdW0B65Dfoc2iZVI2Ov8F6O2SX7EKidYZDaH1mpnez
         v6Z4uKjpW4AiQ==
Date:   Sat, 25 Nov 2023 16:15:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc:     <paul.cercueil@analog.com>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] MAINTAINERS: Add MAINTAINERS entry for AD7091R
Message-ID: <20231125161517.5a48b215@jic23-huawei>
In-Reply-To: <1a36ac71c6b9fbde68e29ad3dc030cef10e3d252.1700751907.git.marcelo.schmitt1@gmail.com>
References: <cover.1700751907.git.marcelo.schmitt1@gmail.com>
        <1a36ac71c6b9fbde68e29ad3dc030cef10e3d252.1700751907.git.marcelo.schmitt1@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 13:40:48 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The driver for AD7091R was added in
> ca693001: iio: adc: Add support for AD7091R5 ADC
> but no MAINTAINERS file entry was added for it since then.
> Add a proper MAINTAINERS file entry for the AD7091R driver.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo,

Small patch ordering thing.  If I apply the series in order,
at this point you've not 'yet' contributed much to this driver
so it's not obvious that you are in a position to take over maintenance.

Push it to the end of the series then it's fair enough and thanks
for stepping up to look after this one!

Jonathan

> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0a91dc8251..008f0e73bead 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1126,6 +1126,16 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
>  F:	drivers/iio/adc/ad4130.c
>  
> +ANALOG DEVICES INC AD7091R DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	http://ez.analog.com/community/linux-device-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
> +F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
> +
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alexandru Tachici <alexandru.tachici@analog.com>
>  L:	linux-iio@vger.kernel.org

