Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B33752416
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjGMNmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbjGMNl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E11992
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B40961539
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2432C433C8;
        Thu, 13 Jul 2023 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255715;
        bh=XQ7GI5seauSP1zdgzOW9xfeQzw1DgF5EQVEBjlhLDx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHgb01g71DiomiYZebiqegzv1Y1Yk77El/q56VCQHGRl9yPyKmrPtMwBcr51beDfZ
         2S6OntPipyVx6evbRLKBP4XyQv+ng2kO1wcKxWUDXj8vfYmqOH9/CzPUTbxk4zFsdz
         2yQbw9S5wzgqxCA7ZwrYUlZkCOAiutpNSuOhVm4oc6T42VnWcPeKEOtHrpO2ciXYsY
         yxaY5rllmTAMaAKgmRh8NE1qe5P0KwYMFyiGVb7UFzjRev+TwCwCGOmm4NclrMGDnR
         K43QKGic+7l0UJ+A8N5sxZ0AbW7nqQceqorA7fXAVBmGGfWMM1tRqjQdK9SWC7c5pg
         cR0C9QTGKuYiw==
Date:   Thu, 13 Jul 2023 14:41:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] mfd: stm32-timers: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230713134150.GB10768@google.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
 <20230706113939.1178-6-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706113939.1178-6-frank.li@vivo.com>
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

> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/mfd/stm32-timers.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
