Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6B377C76E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjHOGG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjHOGF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:05:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5C01FCE;
        Mon, 14 Aug 2023 23:05:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qVnAk-0003Qz-9Z; Tue, 15 Aug 2023 08:04:54 +0200
Date:   Tue, 15 Aug 2023 08:04:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dong Chenchen <dongchenchen2@huawei.com>,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, fw@strlen.de, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, timo.teras@iki.fi,
        yuehaibing@huawei.com, weiyongjun1@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch net, v2] net: xfrm: skip policies marked as dead while
 reinserting policies
Message-ID: <20230815060454.GA2833@breakpoint.cc>
References: <20230814140013.712001-1-dongchenchen2@huawei.com>
 <20230815060026.GE22185@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060026.GE22185@unreal>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leon Romanovsky <leon@kernel.org> wrote:
> >  		dir = xfrm_policy_id2dir(policy->index);
> > -		if (policy->walk.dead || dir >= XFRM_POLICY_MAX)
> > +		if (dir >= XFRM_POLICY_MAX)
> 
> This change is unnecessary, previous code was perfectly fine.

Are you sure? AFAICS walker struct has no 'index' member.
