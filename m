Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD28780F90C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377550AbjLLVTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjLLVTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:19:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A260B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:19:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EFDEC433C7;
        Tue, 12 Dec 2023 21:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702415954;
        bh=UE+yk/wIEl5wqTBJpUbWv1HkRygo21oZdxRRyi/EhrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H/K47aIfEEuRNHrLpUMSyNEnAGQYxLJnM1AMgiIGdbC6hqsgIeVFHeyUXQNw5Wuwh
         5nuZP64+NqcK2CJa/ZC1io3MoXFKJEVVLH22VGqiwImc+Y1NYvL/YIOJd6ih7Hxg8a
         is6tQy4YM0ar068Fqr3zkEzQ9QRijEiR2TbzuSYjREwH+SPYE6aJfl2Z0J8GfaTP3r
         1OfchR4GTjE5wPyWxh49c5+OPajoKOVc3kFH1sWrKfM7MyO0SELHN3ijgk5mBd7glt
         nxCdht3kK2opR3r/d7zRNdCDhG69ccYPBplKxGR2P28lwBCCT092vYjVhnEcucayir
         w93GXlJ6Ag2Yw==
Date:   Tue, 12 Dec 2023 13:19:13 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mlx4: Fix spelling mistake: "mape" -> "map"
Message-ID: <20231212131913.4195bc38@kernel.org>
In-Reply-To: <20231212203043.GF5817@kernel.org>
References: <20231209225135.4055334-1-colin.i.king@gmail.com>
        <20231212203043.GF5817@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 20:30:43 +0000 Simon Horman wrote:
> On Sat, Dec 09, 2023 at 10:51:35PM +0000, Colin Ian King wrote:
> > There is a spelling mistake in a mlx4_err error message. Fix it.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>  
> 
> Hi Colin,
> 
> I am guessing that you are focusing on error messages and other user-facing
> spelling errors (perhaps you told me f2f in the hallway track at Kernel
> Recipes).  But I do wonder if you have plans to address other spelling
> errors in this driver. codespell flags many, including 'segements' in a
> comment in the same file.

It'd be great to fix all the codespell issues with one path, IMO.
-- 
pw-bot: cr
