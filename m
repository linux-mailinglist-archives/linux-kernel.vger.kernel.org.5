Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB68A7BCE50
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 14:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjJHMTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 08:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjJHMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 08:19:38 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D50B9;
        Sun,  8 Oct 2023 05:19:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qpSkW-0002mQ-QP; Sun, 08 Oct 2023 14:19:08 +0200
Date:   Sun, 8 Oct 2023 14:19:08 +0200
From:   Florian Westphal <fw@strlen.de>
To:     xiaolinkui <xiaolinkui@126.com>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        David Miller <davem@davemloft.net>, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, justinstitt@google.com,
        kuniyu@amazon.com, coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH] netfilter: ipset: wait for xt_recseq on all cpus
Message-ID: <20231008121908.GA29696@breakpoint.cc>
References: <20231005115022.12902-1-xiaolinkui@126.com>
 <20231005123107.GB9350@breakpoint.cc>
 <2c9efd36-f1f6-b77b-d4eb-f65932cfaba@netfilter.org>
 <6ed069d2-0201-a2c0-de92-bd6fc8f33ed7@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed069d2-0201-a2c0-de92-bd6fc8f33ed7@126.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xiaolinkui <xiaolinkui@126.com> wrote:
> crash> struct seqcount_t ffff8003fff3bf88
> struct seqcount_t {
>   sequence = 804411271
> }
> 
> The seqcount of CPU7 is odd, xt_replace_table should have waited, but it
> didn't.

Likely missing backport of
175e476b8cdf ("netfilter: x_tables: Use correct memory barriers.")?
