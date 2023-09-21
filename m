Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1C7A97BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjIUR1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjIUR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:26:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70867358A;
        Thu, 21 Sep 2023 10:03:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D694C32782;
        Thu, 21 Sep 2023 09:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695290096;
        bh=AAkcEZ8SOnbyAVmoBkWR8hTOYh67xx0DW3GiCa+pnsk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a8m2Dv3U6PR5d6/4NRo3l0dnC/OEkxMLBJlKn2U6YDSXQWR8Fvc/uf9KQdMF0JlDX
         /5wg6DVZnHSxPF308rv3bIlxOBQqtogUEfmupzBCPD7EtLqIz0cIke6Td/xtykEX5N
         HyIhHaGimgYJ055R1LqPOQ+M2GE/HTLxFRNce5OMy2Ud+urKOqXSAM+lPb+2wKxIiw
         219RWFkKtbyMvae/++P+jio0zrDhp9w4DCAXCbaKqIVI7spzZ443GJNh4n0W1yS7Dy
         yZ3AqPiFaiyWGlxbFrPPrmVFK5K9P0zc5UQl3oNnaNbNoK66pulup+33yCpwjX48/8
         MshfmXESiBnuw==
Message-ID: <19d2bc5c-2662-6ed8-cc3d-7efb82fd1825@kernel.org>
Date:   Thu, 21 Sep 2023 11:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] dt-bindings: media: imx-jpeg: Assign slot for imx
 jpeg encoder/decoder
To:     Ming Qian <ming.qian@nxp.com>, mirela.rabulea@oss.nxp.com,
        robh+dt@kernel.org, shawnguo@kernel.org
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230921063620.22962-1-ming.qian@nxp.com>
 <20230921063620.22962-2-ming.qian@nxp.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230921063620.22962-2-ming.qian@nxp.com>
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

On 21/09/2023 08:36, Ming Qian wrote:
> There are total 4 slots available in the IP,
> and we only need to use one slot in one os,
> assign a single slot,
> configure interrupt and power domain only for 1 slot,
> not for the all 4 slots.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  .../bindings/media/nxp,imx8-jpeg.yaml         | 40 ++++++++-----------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> index 3d9d1db37040..5f0e2fc1ea9c 100644
> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
> @@ -32,25 +32,27 @@ properties:
>      maxItems: 1
>  
>    interrupts:
> -    description: |
> -      There are 4 slots available in the IP, which the driver may use
> -      If a certain slot is used, it should have an associated interrupt
> -      The interrupt with index i is assumed to be for slot i
> -    minItems: 1               # At least one slot is needed by the driver
> -    maxItems: 4               # The IP has 4 slots available for use
> +    description:
> +      Interrupt number for slot
> +    maxItems: 1
>  
>    power-domains:
>      description:
>        List of phandle and PM domain specifier as documented in
>        Documentation/devicetree/bindings/power/power_domain.txt
> -    minItems: 2               # Wrapper and 1 slot
> -    maxItems: 5               # Wrapper and 4 slots
> +    minItems: 1               # VPUMIX
> +    maxItems: 2               # Wrapper and 1 slot
> +
> +  slot:
> +    description:
> +      Integer number of slot index used. the value range is from 0 to 3

Don't you have here obvious errors reported by testing? Did you test this?

Best regards,
Krzysztof

