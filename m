Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBB5805335
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345211AbjLELlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345204AbjLELlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:41:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5787A9A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:41:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D8C433C8;
        Tue,  5 Dec 2023 11:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701776483;
        bh=39hIynYLxtwl/O23npHEkHvKhoLwLy7fzyGPOOqty9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMJov2tcJS/7wL/pPXe3meTv6r3DI2KkeFBdH68DYYQ6tOUabE33M0QM7VH7HVNV7
         p94elf+S/c5ZZTQ6sC4/qdAYFoJGrTmztWs/T2rak7Zi5FH2riyTetSCXQ8QTMIx12
         BOWXOXEHXX6oJXKOKUMtTOt5d9hXGsTAL7rBfXBF/0qNEoRGiLtIM1qNQE0zBikHpX
         zOSQY2ZM7dH24M+d+GMc5hb6VtdvRM9UU5yAgUfvyYvNcpzcwO7pHEkzQye9fAXDyd
         0C0QHbw+lBZVRSsehi1ZgvBuBjZDx12acKI5T8BS+Fq5ugVe3WcPnjd2HRJHMcKtNi
         MuP18QxZfnWCA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rAToU-0008Ud-2D;
        Tue, 05 Dec 2023 12:42:06 +0100
Date:   Tue, 5 Dec 2023 12:42:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qrb5165-rb5: add a pin function
 for BT enable GPIO
Message-ID: <ZW8Mjp9whA9rxam9@hovoldconsulting.com>
References: <20231205112311.16391-1-brgl@bgdev.pl>
 <20231205112311.16391-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205112311.16391-2-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:23:10PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Set up the pin function for the Bluetooth enable GPIO.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> index ce6ae0771d34..ead0c45ba60c 100644
> --- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
> @@ -1264,6 +1264,17 @@ &tlmm {
>  		"HST_WLAN_UART_TX",
>  		"HST_WLAN_UART_RX";
>  
> +	bt_en_state: bt-default-state {
> +		bt-en {
> +			pins = "gpio21";
> +			function = "gpio";
> +
> +			drive-strength = <16>;
> +			output-low;
> +			bias-pull-up;
> +		};
> +	};
> +
>  	lt9611_irq_pin: lt9611-irq-state {
>  		pins = "gpio63";
>  		function = "gpio";

This makes no sense as a separate patch and should be squashed with the
final patch enabling bluetooth. Same for the first patch.

Johan
