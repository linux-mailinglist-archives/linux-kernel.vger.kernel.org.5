Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5251E752412
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjGMNlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjGMNlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:41:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01E173B;
        Thu, 13 Jul 2023 06:41:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E00B5612FC;
        Thu, 13 Jul 2023 13:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6342C433C7;
        Thu, 13 Jul 2023 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255694;
        bh=8Ot7D/Ueg2Zj0abBjyFlVTgcPMEBuvL2hmZIQcytkd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=chj4FQk3oC3GzqwAA5u8pzxm+Lu1dekSyLQ6igB3JLH+CHi20cNY1SvUPtwWtEImj
         9IcnixaoxcVBA0h599emjrW1a/y5eAFBhdUY7oERsK1lNLjcFaV7D0C4MwjrLF1mnV
         sjMGjSiwgkSIRMqQQqI2ed9VMRUIP3UYUZwSa9arZ6MvvG6DNORSmE4UsI5pkscpao
         IgUps4Uwn87xH/Rn/EucoHOBNVrdzNmocCRow4iY0mt3Ok7k+tlJ1+IlzkMdlS4YjH
         UQbAZx5IF4xrHokU+Nk7b2Oyc2RHH2oeuQJUhNZVXFq5iOua5lRwMo1du1nUPpQqJZ
         +ojArZ//G9M9w==
Date:   Thu, 13 Jul 2023 14:41:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mfd: omap-usb-host: Convert to
 devm_platform_ioremap_resource()
Message-ID: <20230713134129.GA10768@google.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
 <20230706113939.1178-5-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706113939.1178-5-frank.li@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023, Yangtao Li wrote:

> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mfd/omap-usb-host.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
