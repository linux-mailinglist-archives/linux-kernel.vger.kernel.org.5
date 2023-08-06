Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB1477135F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 05:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHFDYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 23:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFDYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 23:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328671FE1;
        Sat,  5 Aug 2023 20:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B64F360C57;
        Sun,  6 Aug 2023 03:24:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDBFC433C7;
        Sun,  6 Aug 2023 03:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691292244;
        bh=BjWcmlyyIUwTPcPHpo5ZIMu+WGz/CBBzwml6MBeHlXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXeRkT3A4mcnCOmmPze0XP+JkA0kGl/HYT3aaw8jcTYSDyCGIKefxQGUygELVeN0c
         C8Aoslyf2RBrDgq1611nulhk/WdOWUn1rMtKgL/2bLqu66c25gFT24mf7Us16+tqE7
         UvGbrPV4frPPYqyVPSaVTZGVZrwYMAO0Tl5aB5+zhMagY5e/Fnz8KdLFmVGrTBENsZ
         STeX8E+GJC4BZOr/rWX6C2dCAsuDb3stkwyY3klbcUc8GNwYcIEGKTCO6Rayt9PHci
         Xq59IW9hqGNu1Brj0/HRqmJnHb0E3ufLTXlFTiAbqHvM8h96/AQHBLIfPgfEcEYOH4
         7kP3owMNWgPQw==
Date:   Sun, 6 Aug 2023 11:23:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Abel Vesa <abelvesa@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] ARM: imx25: print silicon revision at startup
Message-ID: <20230806032353.GX151430@dragon>
References: <20220602080344.208702-1-martin@kaiser.cx>
 <20230730163928.70637-1-martin@kaiser.cx>
 <e0acf791831bcfed56d56c97f6867a89.sboyd@kernel.org>
 <20230802183849.2gzlglkskvzkgiwa@viti.kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802183849.2gzlglkskvzkgiwa@viti.kaiser.cx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:38:49PM +0200, Martin Kaiser wrote:
> Stephen Boyd (sboyd@kernel.org) wrote:
> 
> > You need to Cc linux-imx@nxp.com on imx clk patches. I think Abel has
> > some filter that looks for linux-clk@vger and linux-imx.
> 
> > Also, please don't send series replies to previous rounds. It buries the
> > patches deep in my MUA and my scripts don't work well to apply patches
> > when they're sent like that.
> 
> > I presume that Abel will pick the patches up? Or do you want to land
> > them through Arnd's tree? Either way feel free to add my acked-by
> 
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
> 
> Thanks for responding, Stephen.
> 
> Ok, understood. I'll resend with Cc linux-imx@nxp.com and without the
> reply to previous versions.
> 
> Arnd, are you ok with taking these patches through your tree as
> suggested by Stephen?

I prefer to have Abel apply the patches through clk tree rather than
arm-soc tree, unless there is a good reason for them to go via the
latter.

Shawn
