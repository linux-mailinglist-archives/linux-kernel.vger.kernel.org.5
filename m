Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F95752409
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbjGMNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjGMNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:39:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFABFE68
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:39:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E26060A70
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E95C433C8;
        Thu, 13 Jul 2023 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255564;
        bh=7bYzmhFlyjZWsAnu8qmPfFUF9Uj+90tvvAN0wCJ9z28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nw5IzhiOjCBoenNX8d6+I26HwGelx+orU4eAorQ+ixmFgjm1QOUTstUUjyPRqaNG5
         5H1TwGs7NTkM/+MHp5mQ3w1wTCHbWd488gjZsRqsNk+NIOAHhoaKW/Fc3DP0rfeCNy
         FReX1RvwByC/Sh3HbRV+Abd/GKhGRwpV7CrGodxoKOmt55U2rpp0u5S7U14cEzPNL7
         RLkfelfPvPqM/P7HwvL35KKJatuBPM2dw4zqIOUlRE7LEH1ZY/owPEW638Cxto54ZV
         r46G5lG+4I95dt1GPeki+vKPxzH4BeZTjqkjPrEVPqsqPWE9SBK08dAN1/1aISRRZX
         pdRz+wXwvd2Xw==
Date:   Thu, 13 Jul 2023 14:39:19 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mfd: atmel-hlcdc: Convert to
 devm_platform_ioremap_resource()
Message-ID: <20230713133919.GW10768@google.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706113939.1178-1-frank.li@vivo.com>
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
>  drivers/mfd/atmel-hlcdc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
