Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CFD76521F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbjG0LV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjG0LVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED37E4C;
        Thu, 27 Jul 2023 04:21:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CBBF61D28;
        Thu, 27 Jul 2023 11:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE40AC433C7;
        Thu, 27 Jul 2023 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690456882;
        bh=YMIkANzVF5IWMvM3TWHa8uTtxzKUrIfXvCCdyJ6K8bM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eN6ABMkjoxXqXSTvVXYoSe9f4LEbwzvyhTvPLAbN/k22Qk+cODWXq3LyccY/t2VmM
         4fDt81rSYsgmZbrkJeF4EbMpWlxI0xk9moYLIBv55B9MQjxHddBEDcXaJ88B+RVmaS
         pxby76c1jVF2C/KZvsznWvnLHa8g48ijpGaHqLV/xDGfhEvPEUnA8Ew3LsM/km8nXR
         DARDhgdwp283fAJqd01I9ZbxlwAGQ75m7nA+mHAaOseOJk5VvYBaAkBPzHr5MJpCe9
         Fke9uc2263jFsdbJ0HnDRtjQyozyiIwYFyPsuFt3MNDpRUWk9lmGVUeY4jDBSyvg7p
         uKvpqyjMRriHQ==
Message-ID: <57ed9bd0-dc90-69ef-31fb-4eb5d821190d@kernel.org>
Date:   Thu, 27 Jul 2023 13:21:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/2] clk: rockchip: rk3588: Adjust the GATE_LINK
 parameter
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        sboyd@kernel.org, kever.yang@rock-chips.com, heiko@sntech.de
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangtao@rock-chips.com
References: <20230727101139.23048-1-zhangqing@rock-chips.com>
 <20230727101139.23048-3-zhangqing@rock-chips.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230727101139.23048-3-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 12:11, Elaine Zhang wrote:
> Using Id instead of name, if use name needs to use __clk_lookup().
> But __clk_lookup() is not exported and is not friendly for GKI.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

>  static void __init rk3588_clk_init(struct device_node *np)
> diff --git a/include/dt-bindings/clock/rockchip,rk3588-cru.h b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> index b5616bca7b44..864a321ab362 100644
> --- a/include/dt-bindings/clock/rockchip,rk3588-cru.h
> +++ b/include/dt-bindings/clock/rockchip,rk3588-cru.h
> @@ -733,8 +733,9 @@
>  #define ACLK_AV1_PRE			718
>  #define PCLK_AV1_PRE			719
>  #define HCLK_SDIO_PRE			720
> +#define PCLK_VO1GRF			721

Bindings are separate patches.

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

