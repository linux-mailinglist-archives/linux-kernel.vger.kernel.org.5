Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE11A77F4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350176AbjHQLDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350216AbjHQLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015ED35AB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC9C463A02
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC7CC433C8;
        Thu, 17 Aug 2023 11:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692270116;
        bh=tHd6WSjL4LyL9CByCjiTTTuSNYpimdZQLEBz3iZNt2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyUxzxxYNxNQNDwnXbF9/Rq8eSBxKAAkQiVneNy+rugnUGbJuBq6zjS5QBorTVguD
         sb9FqjjyFKVrkBU2+mcPCq4rtOaNTuUcSRm0v5+JwN6hWd9jWo3uUqWf7+wjBGp1xt
         f4NxxwCt3SjN6Zcm3+vhli+YsednVhYXb9eI48iPGGQggKWH5erXYfuLOejM23tilH
         v+Nq9gkMt4SZuHMXWhcVMcYQIGbRU1Z0Rgo3bdmYpa+598njcTfrH5BVeJksVSLdGO
         jxHdmRLmNRdBEdIwNe+IZpmyXepqVqDSrahY6vx97wDGw3kk7mB1XIXZrhPb1x+gjd
         C4zPDXkIdFvig==
Date:   Thu, 17 Aug 2023 12:01:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Li Zetao <lizetao1@huawei.com>
Cc:     bot@kernelci.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: ipaq-micro: Remove unused variable i in
 micro_rx_msg()
Message-ID: <20230817110151.GI648357@google.com>
References: <20230802092342.970476-1-lizetao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802092342.970476-1-lizetao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023, Li Zetao wrote:

> After the commit "92d82d76c84", the variable i is unused. Remove it

Please use the format:

<short_sha> ("<subject>") when referencing commits.

> to silence the warning.

If you're referring to a warning, please paste it here.

> Reported-by: kernelci.org bot <bot@kernelci.org>
> Closes: https://lore.kernel.org/all/64c8aeac.170a0220.e3234.2745@mx.google.com/
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>  drivers/mfd/ipaq-micro.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mfd/ipaq-micro.c b/drivers/mfd/ipaq-micro.c
> index cddfd2e808f2..c964ea6539aa 100644
> --- a/drivers/mfd/ipaq-micro.c
> +++ b/drivers/mfd/ipaq-micro.c
> @@ -78,8 +78,6 @@ EXPORT_SYMBOL(ipaq_micro_tx_msg);
>  
>  static void micro_rx_msg(struct ipaq_micro *micro, u8 id, int len, u8 *data)
>  {
> -	int i;
> -
>  	dev_dbg(micro->dev, "RX msg: %02x, %d bytes\n", id, len);
>  
>  	spin_lock(&micro->lock);
> -- 
> 2.34.1
> 

-- 
Lee Jones [李琼斯]
