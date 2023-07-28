Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D247668B7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbjG1JXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbjG1JX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:23:26 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4C59EE;
        Fri, 28 Jul 2023 02:18:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qPJal-0001Mm-8P; Fri, 28 Jul 2023 11:16:59 +0200
Date:   Fri, 28 Jul 2023 11:16:59 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     kadlec@netfilter.org, edumazet@google.com, fw@strlen.de,
        kuba@kernel.org, pabeni@redhat.com, pablo@netfilter.org,
        dsahern@kernel.org, davem@davemloft.net,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 1/5] netfilter: defrag: Add glue hooks for
 enabling/disabling defrag
Message-ID: <20230728091659.GA15474@breakpoint.cc>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
 <f6a8824052441b72afe5285acedbd634bd3384c1.1689970773.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a8824052441b72afe5285acedbd634bd3384c1.1689970773.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Xu <dxu@dxuuu.xyz> wrote:
> We want to be able to enable/disable IP packet defrag from core
> bpf/netfilter code. In other words, execute code from core that could
> possibly be built as a module.
> 
> To help avoid symbol resolution errors, use glue hooks that the modules
> will register callbacks with during module init.

Reviewed-by: Florian Westphal <fw@strlen.de>
