Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9E7911F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241683AbjIDHUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbjIDHUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:20:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9523E129;
        Mon,  4 Sep 2023 00:20:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3CDFFB80DB5;
        Mon,  4 Sep 2023 07:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E62C433C8;
        Mon,  4 Sep 2023 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693812028;
        bh=LvTb4kJl3GXs12/BrT1PJX0uNGbEH7dpzz3v5s4wpE4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pzh9eUzDM0Qduf59lq/gg9D16GlVEyPrWTiHiBtBMoYaRlOPKZqb0lqWWZp/iRin6
         xc9D0wzFppz70QK9s8Sh4y8sy5B2tQZHx2+kSVh4CGOfWQQLetU0Hn9fhJgLEMelQk
         i57TkArDlqOGidGICqFT/syXGIduBK5pWU3KbztuORQgNq58HTwlQp9NEsTfqkMG0K
         Y3KxlMQCg8zbEc7Peyn2Eff0z2OCpsnmH3qpVnqwNe90txuXVcOnxJpdv/l5OtcGXU
         vxmbULCEhLgL4WtoMgqX97VDt+I4Uowm2b/gtaYctwiLb7v+IoMNhP0oVHfdAREUIp
         4YIeaRHgJhvNQ==
Message-ID: <03aab2bc-5fd2-956b-23ef-3359ed92db88@kernel.org>
Date:   Mon, 4 Sep 2023 09:20:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 3/3] dts: ti: k3-am625-beagleplay: Add beaglecc1352
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
 <20230902182845.1840620-4-ayushdevel1325@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230902182845.1840620-4-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2023 20:28, Ayush Singh wrote:
> The BeaglePlay board by BeagleBoard.org has a CC1352 co-processor. This
> co-processor is connected to the main AM62 (running Linux) over UART. The
> CC1352 can run Zephyr and other embedded OS. This commit adds support for
> the CC1352 in the Linux kernel DTS. This allows Linux platform drivers to
> identify the device and communicate with it.
> 
> This UART is used by gb-beagleplay, an upcoming Greybus driver for
> BeaglePlay.

upcoming? So not present in this patchset?

> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> index 7cfdf562b53b..10abbb8feda5 100644
> --- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> @@ -870,6 +870,10 @@ &main_uart6 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&wifi_debug_uart_pins_default>;
>  	status = "okay";
> +
> +	beaglecc1352 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check W=1` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Best regards,
Krzysztof

