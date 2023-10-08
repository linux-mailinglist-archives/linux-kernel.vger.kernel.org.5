Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91847BD0DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344843AbjJHWYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHWYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:24:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D214A6;
        Sun,  8 Oct 2023 15:24:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772DFC433C8;
        Sun,  8 Oct 2023 22:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696803856;
        bh=ic0lnfoCXKD3WDMoscE8ipyqDiOvCXq/LX99KO34oK0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TE0jXDcdB7UBIKU2EpNEJes0q6O6zF3wHeKoiDQTl1ItJ2zZ6vepumKZLbQSHkFae
         sE0Ldo4Lh4B+oMMl7MO0qImf2YT/aW3Rfd4E7LRl7Lc++Gj5NPPq9cjwaVzyvcgfVa
         WOSpbJ+A/05/ASoERqq1zJUGTxmymXTAlLvcBmANicbFuSUE8Tu6SAoJjkzS5PaM8V
         tVIEKr3XVREMiDsBtrgaopCEENmJOLC2UdGO3+CYVqZ8i7ph23zpn//ieTrU41n8BJ
         NoYTXJNHryeQdlTGM/lX7RLvqs6bb/ChaKxxVvc7KcVH8jaxAl8yL61JRkhpulrtjQ
         K3Zi3N+wIsH+w==
Message-ID: <a78b98e7-4261-dd08-8ca7-88a74725c191@kernel.org>
Date:   Mon, 9 Oct 2023 07:24:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 21/26] dt-bindings: devfreq: event: rockchip,dfi: Add
 rk3568 support
Content-Language: en-US
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230704093242.583575-1-s.hauer@pengutronix.de>
 <20230704093242.583575-22-s.hauer@pengutronix.de>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230704093242.583575-22-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 4. 18:32, Sascha Hauer wrote:
> This adds the rockchip,rk3568-dfi compatible to the binding. Make clocks
> optional for this SoC as the RK3568 doesn't have a kernel controllable
> PCLK.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/devfreq/event/rockchip,dfi.yaml      | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> index 7a82f6ae0701e..e8b64494ee8bd 100644
> --- a/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip,dfi.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3399-dfi
> +      - rockchip,rk3568-dfi
>  
>    clocks:
>      maxItems: 1
> @@ -34,11 +35,21 @@ properties:
>  
>  required:
>    - compatible
> -  - clocks
> -  - clock-names
>    - interrupts
>    - reg
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - rockchip,rk3399-dfi
> +
> +then:
> +  required:
> +    - clocks
> +    - clock-names
> +
>  additionalProperties: false
>  
>  examples:

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

