Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62C80C88D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjLKLlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjLKLkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:40:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2AACB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:40:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC12C433C8;
        Mon, 11 Dec 2023 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702294857;
        bh=5I0PYKVYM7syKP7JCpCzQG2R4ozPV4d953nCGoVm7Qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHY8QewYlY5P5h7xtAty4w70caY2eAemqXWDaem4ihpf0udcp1AGjQ8CJd+0P2Z+H
         6dFyezMHK0Q5fKGDuoRBXC0LNOxWXG+pbx2C8zRxOTGdfSiK/xCn38jxa4KAIjx0pu
         FnbuzBKl0Gtar/m4aOQhIY19VB8gtYkrrTjwV/1QQYHakllRcgnXvqbmmmfnzca65j
         ec0bxle9JdPn42qF8uCK62vdAuDzGpMQocyMpb50gn58+jlbCQPUK6j49NH97yHqlF
         hbS+mG4Oj0ZbQt/bb8n5zqqLeCyYsoJT6AoeSE/cJTg1Pwd0tMWAlws4RXU5uwQHo4
         E6LydrTH76M3Q==
Date:   Mon, 11 Dec 2023 17:10:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     liu kaiwei <liukaiwei086@gmail.com>
Cc:     Kaiwei Liu <kaiwei.liu@unisoc.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
Message-ID: <ZXb1RWaFWHVDx1wV@matsya>
References: <20231102121623.31924-1-kaiwei.liu@unisoc.com>
 <ZWCg9hmfvexyn7xK@matsya>
 <CAOgAA6FzZ4q=rdmh8ySJRhojkGCgyV4PVjT6JAOUix+CF9PFtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOgAA6FzZ4q=rdmh8ySJRhojkGCgyV4PVjT6JAOUix+CF9PFtw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-12-23, 17:32, liu kaiwei wrote:
> On Fri, Nov 24, 2023 at 9:11 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 02-11-23, 20:16, Kaiwei Liu wrote:
> > > From: "kaiwei.liu" <kaiwei.liu@unisoc.com>
> >
> > Typo is subject line
> >
> > >
> > > In the probe of dma, it will allocate device memory and do some
> > > initalization settings. All operations are only at the software
> > > level and don't need the DMA hardware power on. It doesn't need
> > > to resume the device and set the device active as well. here
> > > delete unnecessary operation.
> >
> > Don't you need to read or write to the device? Without enable that wont
> > work right?
> >
> 
> Yes, it doesn't need to read or write to the device in the probe of DMA.
> We will enable the DMA when allocating the DMA channel.

So you will probe even if device is not present! I think it makes sense
to access device registers in probe!

-- 
~Vinod
