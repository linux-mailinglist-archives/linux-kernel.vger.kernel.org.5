Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0387B5A21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbjJBSbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 14:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbjJBSby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:31:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5C9D8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 11:31:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290E8C433C7;
        Mon,  2 Oct 2023 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696271509;
        bh=FwOWdXcduUEuYueUYb3WKEmK/UO8XkOGezapIcoLank=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nXztEeJMKGNe5w7pRztMXGYK/3RIFockMyii4+e+9IvyivRQTAnvy1vyrvzDeO21f
         iKU2HTcj94fyDABBbgMlwgUC8CTQG89l1KY7S8LVPLMqOt+CDcuW0fQYRISYsaDvos
         HvE6+8vVtjWuISVyQmW2JPpxrzcAI30tx4w0uZ+cgMSVdNgkM8R6uqiKq/uUe2RZra
         Zib9hBL+cex/Ey/T3JkJAGJtMDV/iOr5V67gcACD5HLZKxJvB8rLBuSNxuTlg2qbIX
         NzweXBCSFW9P5Ks5oDRRG/NO7iUyZAV6gyZIboSH+b8a9xVsxeJ0lDMU17k04my2UL
         cqPirDsCOLtXQ==
Date:   Mon, 2 Oct 2023 11:31:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Raju Rangoju <Raju.Rangoju@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Message-ID: <20231002113148.2d6f578b@kernel.org>
In-Reply-To: <202309291240.BC52203CB@keescook>
References: <20230929181042.work.990-kees@kernel.org>
        <202309291240.BC52203CB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2023 12:44:45 -0700 Kees Cook wrote:
> On Fri, Sep 29, 2023 at 11:11:44AM -0700, Kees Cook wrote:
> > Hi,
> > 
> > This annotates several chelsio structures with the coming __counted_by
> > attribute for bounds checking of flexible arrays at run-time. For more details,
> > see commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro").
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > Kees Cook (5):
> >   chelsio/l2t: Annotate struct l2t_data with __counted_by
> >   cxgb4: Annotate struct clip_tbl with __counted_by
> >   cxgb4: Annotate struct cxgb4_tc_u32_table with __counted_by
> >   cxgb4: Annotate struct sched_table with __counted_by
> >   cxgb4: Annotate struct smt_data with __counted_by
> > 
> >  drivers/net/ethernet/chelsio/cxgb3/l2t.h                | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/clip_tbl.h           | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/l2t.c                | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/sched.h              | 2 +-
> >  drivers/net/ethernet/chelsio/cxgb4/smt.h                | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)  
> 
> Hm, it looks like this is not "Supported" any more? I'm getting bounces
> from "Raju Rangoju <rajur@chelsio.com>" ...
> 
> CXGB4 ETHERNET DRIVER (CXGB4)
> M:      Raju Rangoju <rajur@chelsio.com>
> L:      netdev@vger.kernel.org
> S:      Supported
> W:      http://www.chelsio.com
> F:      drivers/net/ethernet/chelsio/cxgb4/

Hi Ayush,

any idea who should be maintaining the Ethernet part of cxgb4 
at this point?
