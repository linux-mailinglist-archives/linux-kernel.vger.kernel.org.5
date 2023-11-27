Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059AC7FA18F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjK0Nyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjK0NyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:54:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36201735
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:54:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2B7C433C8;
        Mon, 27 Nov 2023 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701093260;
        bh=oDW0HUte73CGTj6ucIxHY1GvItq32GGhO5CvsULBL18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UCRachjwHH8u5UQpXm/o6+3Wf1F8cFZ5Ek+ILYDbWoirmVvKfzyIlAVFKX8g2YgwA
         HodXj5nCajqiwUj+yaKtKN5+giy6XGR8Cyk3Vj89Z3VjCZ+k50H4stdbCKI3wP2AJy
         k02yXrLSXRKnzd7km1wYwyv1uUhDKrJkUPg+GVoc=
Date:   Mon, 27 Nov 2023 13:36:54 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <2023112702-postal-rumbling-003f@gregkh>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121070619.9836-3-saeed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:06:16PM -0800, Saeed Mahameed wrote:
> +config MLX5CTL
> +	tristate "mlx5 ConnectX control misc driver"
> +	depends on MLX5_CORE
> +	help
> +	  MLX5CTL provides interface for the user process to access the debug and
> +          configuration registers of the ConnectX hardware family
> +          (NICs, PCI switches and SmartNIC SoCs).
> +          This will allow configuration and debug tools to work out of the box on
> +          mainstream kernel.

Did you run checkpatch.pl on this?  You lost the tabs :(

> --- /dev/null
> +++ b/drivers/misc/mlx5ctl/main.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0

Why is this dual licensed?  Again, you are using a GPL-only api for this
driver, how would that even be possible to make this code be BSD?

I thought we already discussed this, AND I talked to someone who
discussed this with a nvidia lawyer already and I thought this was going
to get changed.  What happened to that?

thanks,

greg k-h
