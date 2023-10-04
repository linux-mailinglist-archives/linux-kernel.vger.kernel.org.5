Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8F37B7886
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241493AbjJDHTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJDHTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:19:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA97CAB;
        Wed,  4 Oct 2023 00:18:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF7C433C8;
        Wed,  4 Oct 2023 07:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696403938;
        bh=8bZfjHBVUvb/Wl7uG7Uwj/fc/hoDrcF4sN+aBtnDong=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XntmGuuWL5fmFoR3Lrr0s/mXf5L03xYPMppcKrdCaYlP/4jGzQBIuU8DhUUSvOAq7
         7yAlVTTSaI0jO9lzQtX2rTKGhyIbMNvZ/16ZGPGfKVcpGC97FWLxWjkZhEtUk7pgdm
         3L72+ewaSKd9cdYg7KPnPGtAlhTc4G+HFEgw5EA1ITKbo8L4NxidwxcHTp+jgtwtrD
         jCIT9l3ZJdnNV68BfC75eD8vIFnShetOZTIeAbGw2+hUXuv2OS+CM7e82tRoovNGMP
         OqXRaKbwZbj3HeVBML19fnq5pUIXKqoiiUfaPqgO8HJZ+8tkeWlP88B6G2sLUDJeMJ
         3KGJGHdQsXJuQ==
Date:   Wed, 4 Oct 2023 12:48:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [EXT] Re: linux-next: build failure after merge of the dmaengine
 tree
Message-ID: <ZR0R3rM1G0nOL3jM@matsya>
References: <20230929131324.6bb84292@canb.auug.org.au>
 <ZRrrToewRnOYGOD3@matsya>
 <AM6PR04MB48382B21C39B68B933E9A38B88C5A@AM6PR04MB4838.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR04MB48382B21C39B68B933E9A38B88C5A@AM6PR04MB4838.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frank,

On 02-10-23, 16:26, Frank Li wrote:
> > On 29-09-23, 13:13, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > After merging the dmaengine tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this:
> > >
> > > ld: warning: discarding dynamic section .glink
> > > ld: warning: discarding dynamic section .plt
> > > ld: linkage table error against `ioread64'
> > > ld: stubs don't match calculated size
> > > ld: can not build stubs: bad value
> > > ld: fs/debugfs/file.o: in function `debugfs_print_regs':
> > > file.c:(.text+0xee8): undefined reference to `ioread64be'
> > > ld: file.c:(.text+0xf50): undefined reference to `ioread64'
> > >
> > > Caused by commit
> > >
> > >   09289d0ad122 ("debugfs_create_regset32() support 8/16/64 bit width
> > registers")
> > >
> > > I have used the dmaengine tree from next-20230928 for today.
> > 
> > Thanks for report, I have dropped offending commits for now.
> 
> Fixed patch already post at
> https://lore.kernel.org/dmaengine/20231002145737.538934-1-Frank.Li@nxp.com/T/#u

I am not sure of this fix, someone has to pick this. let this get fixed
first and we can always pick back these patches.

My tree was broken meanwhile impacting others, so it was better to drop
for now.

Thanks for you understanding

-- 
~Vinod
