Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2D377A099
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjHLPB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjHLPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:01:27 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC95171B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:01:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3669E1C0003;
        Sat, 12 Aug 2023 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691852489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xD46QLLKqYAZpIv8Zm3OD9Uy8ErPx2FduFRoqZTMThQ=;
        b=P6c6sq5fgBzYqVs4xo3vUBCzii+yAtAYXTv/7IQrNuZyMwdQfeDyWUMpQW/rIL6/y9gWxy
        UI6H2S3nWWD5LTK9OWbB7L1vHE358sziZ582vA7uBjgBW0h6xlGTVr1AYarkKUsOErWQAh
        9sYrZDu4Hfo+v96TGct+rOp4Z4p09FNzLJD6Hikl19c9HDeuTG4eOIRDTyzr7XIC9dExxU
        IhBtHCcMQ7t1kMCY4NdwklC6nUx1h6EZdPQgHvKJB7jnrYXbvlSF30AWdmi4Jg01BkvU5A
        mqMqliZwzFlofLsZERsTtQw6ZMAQWLjQTxyqM8s5USa/DuiDP/xQ5sR++UgkkQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Rob Herring <robh@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dove: Drop unused includes
In-Reply-To: <20230717225645.3214989-1-robh@kernel.org>
References: <20230717225645.3214989-1-robh@kernel.org>
Date:   Sat, 12 Aug 2023 17:01:29 +0200
Message-ID: <87sf8otid2.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> writes:

> Several includes are not needed, so drop them.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied on mvebu/arm

Thanks,

Gregory
> ---
>  arch/arm/mach-dove/common.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
> index cd4ae7e4768d..3aea90bbb41a 100644
> --- a/arch/arm/mach-dove/common.c
> +++ b/arch/arm/mach-dove/common.c
> @@ -9,8 +9,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_data/dma-mv_xor.h>
>  #include <linux/platform_data/usb-ehci-orion.h>
>  #include <linux/platform_device.h>
> -- 
> 2.40.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
