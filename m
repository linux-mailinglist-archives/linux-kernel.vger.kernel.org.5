Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FB475270B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjGMP36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjGMP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9762710
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0DF061931
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B10BC433C7;
        Thu, 13 Jul 2023 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689262142;
        bh=hD5A9KtFlLR+u3V9GZuQAXXRwB1AIo3vauLDZN8H9Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HeRNVn+YVE4MKNNO19DWpmzAu3Y4q860LbFLe52oiot7Uxjmin42HAzr/9C/iRX7G
         UZI0jx058lq4Mn/Av3JBowfvm3LofLP3NrFEp6qYyZn5wN1k0ZeVvHihbjeyJe6CcJ
         zVT2kp8f0FChN8bPvp0zrkhtEM3Q05DLCQkWbQxao3Ee7K1xxm+S/a/inb1iIyeArs
         CvVx/BDaG5+3Yz+dfQafk+/Wj2znMpAMCTuaWgm8PPvNhcmk49w9iKADc7dOt7slWI
         CpoNeKtBRgMmidZiNqin6Rx9QoUorPvHuXyQhUB8OdA8QiI/ZgS+7DMJwFQYS5F79W
         cWc+DbFrjL/lA==
Date:   Thu, 13 Jul 2023 16:28:58 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Update to use maple tree register cache
Message-ID: <20230713152858.GC968624@google.com>
References: <20230712-mfd-axp20x-maple-v1-1-4df3749107a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712-mfd-axp20x-maple-v1-1-4df3749107a6@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023, Mark Brown wrote:

> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache. In
> v6.5 it has also acquired the ability to generate multi-register writes in
> sync operations, bringing performance up to parity with the rbtree cache
> there.
> 
> Update the axp20x driver to use the more modern data structure, really it
> should have been fine even without the most recent round of updates.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> 
> Signed-off-by: Mark

Lolz!

> ---
>  drivers/mfd/axp20x.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
