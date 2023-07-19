Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22F2758CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGSEgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjGSEgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E91B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:36:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CC7F60DC4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7320C433C8;
        Wed, 19 Jul 2023 04:35:58 +0000 (UTC)
Message-ID: <06c741c3-3df7-7354-d607-1148a2f99a79@linux-m68k.org>
Date:   Wed, 19 Jul 2023 14:35:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] m68k: coldfire: dma_timer: ERROR: "foo __init bar" should
 be "foo __init bar"
To:     hexingwei001@208suo.com, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20230713081656.77057-1-panzhiai@cdjrlc.com>
 <0ed701a0d75f07e83f4a85617b2e33ae@208suo.com>
Content-Language: en-US
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <0ed701a0d75f07e83f4a85617b2e33ae@208suo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xingwei He,

On 13/7/23 18:39, hexingwei001@208suo.com wrote:
> Fix one occurrences of the checkpatch.pl error:
> ERROR: "foo __init  bar" should be "foo __init bar"
> 
> Signed-off-by: Xingwei He <hexingwei001@208suo.com>

Thanks. Applied to m68knommu git tree, for-next branch.

Regards
Greg



> ---
>   arch/m68k/coldfire/dma_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/dma_timer.c b/arch/m68k/coldfire/dma_timer.c
> index cbb289439606..91e6728f51ed 100644
> --- a/arch/m68k/coldfire/dma_timer.c
> +++ b/arch/m68k/coldfire/dma_timer.c
> @@ -48,7 +48,7 @@ static struct clocksource clocksource_cf_dt = {
>       .flags        = CLOCK_SOURCE_IS_CONTINUOUS,
>   };
> 
> -static int __init  init_cf_dt_clocksource(void)
> +static int __init init_cf_dt_clocksource(void)
>   {
>       /*
>        * We setup DMA timer 0 in free run mode. This incrementing counter is
