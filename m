Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A0E751122
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjGLTYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGLTYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:24:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEF91FC1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O16k4ERFhKKBwUEBI7XcEyTdhUjgEwm/QTrfI/pamUE=; b=eUDq5XQTO9lRKZbSyieaL+36WO
        w/WxepjZ6f4zvhD7UgIQ0aOrMhjuHihrgfNRcWZYNTvUiY21JQAUwWIm6xmJAeEd6ioBloO33La6Q
        tI85cz/rOmfh+PJh5+7JdtpcAu/nlLorCmVoSzT5SjjpXruEuTbXXfNMmVgIdKMaIQ+O6xQMO/DBr
        5b4ryxSDVd6VsgeeqVRKy0sCoO8E1Gh1d3PxoIdHbuYxcx825DlG2el8RhXWewXO5/lRMtQkznes9
        fxnK+U+KAA8eEwTKXXt07aOBNPdsNkW5+U/n76cvArGWWzQxiDObF6xbp4y2wzj5tOmNYHaqLiVbU
        7I6tqIew==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44032)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qJfRo-0004P0-0d;
        Wed, 12 Jul 2023 20:24:24 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qJfRl-0005Kz-El; Wed, 12 Jul 2023 20:24:21 +0100
Date:   Wed, 12 Jul 2023 20:24:21 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     shijie001@208suo.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mm: Fix warnings in context.c
Message-ID: <ZK795eVoadj/wARO@shell.armlinux.org.uk>
References: <tencent_B7B25B0AACAECB0523A2B09F270CF97BFF07@qq.com>
 <60fb2068b0ee6ce2a67333c81ccd2f6b@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60fb2068b0ee6ce2a67333c81ccd2f6b@208suo.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 05:06:32PM +0800, shijie001@208suo.com wrote:
> The following checkpatch warning is removed:
> WARNING: Use #include <linux/mmu_context.h> instead of <asm/mmu_context.h>
> 
> Signed-off-by: Jie Shi <shijie001@208suo.com>
> ---
>  arch/arm/mm/context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
> index 4204ffa2d104..c84ad6c786e7 100644
> --- a/arch/arm/mm/context.c
> +++ b/arch/arm/mm/context.c
> @@ -13,7 +13,7 @@
>  #include <linux/smp.h>
>  #include <linux/percpu.h>
> 
> -#include <asm/mmu_context.h>
> +#include <linux/mmu_context.h>
>  #include <asm/smp_plat.h>
>  #include <asm/thread_notify.h>
>  #include <asm/tlbflush.h>
> 

Probably haven't noticed, but linux/ includes are all grouped together,
and asm/ includes are all grouped together. Please keep that.

Also, is it really a necessary change, when arch/arm/mm/context.c is
only implementing the interfaces provided by asm/mmu_context.h? I think
the warning is wrong in this case and should never be fixed as things
currently stand.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
