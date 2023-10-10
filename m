Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E714C7BF38F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442393AbjJJG7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442377AbjJJG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:59:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE90A7;
        Mon,  9 Oct 2023 23:59:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62A7C433C8;
        Tue, 10 Oct 2023 06:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696921159;
        bh=skqcEev0ohcJ04D3qIt7SnuKrNsL20U4ViZeiA34x18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qA7GZEKeXdhxkbcs+ZwG2FIUw/6MOXtsXfw2scgq/yrPNc+Am/QajWjA2FCeMCYwa
         GTaME5PAa7PrrKGTQ6t8/L7Pjl4AgDwTwPkNIl/QSs3IIAUptDy2rGC5nknWdNfM2D
         WGtr8aDH4XVuPkXm/9ifXDilvIfZXrl84mowXXVsC/oBw3E6oHuDdIWUrNIU2tauEp
         5mw1z9u5f51jwqA8zKjXi5ivt2LkeIjp6+owD6zMBOqRkQNrzvqKz8tfxh14Y0kstg
         zceiQuYyaSR1g9/1xlRZF9BJfEIs8WtLobH34g8MmkCpWQgCRpSwWvX8xpPNEe1hMY
         Ob/TU4CLXdkQQ==
Date:   Tue, 10 Oct 2023 12:29:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the dmaengine tree
Message-ID: <ZST2Q1khDtCtADBs@matsya>
References: <20231010145412.4a758f9d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010145412.4a758f9d@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-10-23, 14:54, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the dmaengine tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/dma/mmp_tdma.c: In function 'mmp_tdma_probe':
> drivers/dma/mmp_tdma.c:638:36: error: unused variable 'of_id' [-Werror=unused-variable]
>   638 |         const struct of_device_id *of_id;
>       |                                    ^~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   a67ba97dfb30 ("dmaengine: Use device_get_match_data()")
> 
> I have used the dmaengine tree from next-20231009 for today.

Thanks for the report, I have posted the fix:
https://lore.kernel.org/dmaengine/20231010065729.29385-1-vkoul@kernel.org/

-- 
~Vinod
