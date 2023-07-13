Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D91775240D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbjGMNkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 09:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjGMNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 09:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7491FD6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 06:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0B756136A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790C9C433C8;
        Thu, 13 Jul 2023 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689255609;
        bh=JS8I8JX+S7zjceO11BgyMYJsPqm5Pj3x/9FPBIQj4tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZCSfoi4wetA4OYtjVWvJNrUQ0e/NNx2jh0h2I8P/IK2xTK91sS+xcqesNQxAx2/84
         qKJs8Vseb/i4I0DN+T2269BD7mN1TM59iPl0rgBhPOENHWMnrvekCYYWEqzdRUrWU1
         G4/qq0wLDM4ESXa/6a0LEOZU14UehFeZRgtJ5KHjLJYkK5XKgn2r0Zisqbaob+fAfe
         klGKm/ejohh5Nf7JEuOvot0pIHSyW1Z1W/AaUzgIaXK3W8rl6z5xfjI6u2WNtTV2IP
         3VlLJay6WOiyr4PF718RHCEtHllTChaMo7qvqoJl0ydvyj2kEhPO6P31N10pWwn5U9
         db9ngeRWkoT0A==
Date:   Thu, 13 Jul 2023 14:40:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] mfd: ti_am335x_tscadc: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20230713134005.GY10768@google.com>
References: <20230706113939.1178-1-frank.li@vivo.com>
 <20230706113939.1178-3-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706113939.1178-3-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
>  drivers/mfd/ti_am335x_tscadc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
