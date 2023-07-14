Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577D1753E56
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjGNPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235958AbjGNPDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:03:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D82D4B;
        Fri, 14 Jul 2023 08:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEB461D44;
        Fri, 14 Jul 2023 15:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77450C433C7;
        Fri, 14 Jul 2023 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689347016;
        bh=/M6rpxZ4WdePzzrxfvLXx66B0T8N+zk54mUpfPJ55ME=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pryQQxY8RibjdCnVtdB5bg1xbQPwTPhCcH4TDXNi2pZAMQNRGSyYbZlSORu/QzGRt
         I/Vl2YFUVLWBhfDZKM+qV3MoueRs0lm+mp+fxYfGclt3Hm3qjDamEQNaa+c3ZtULT+
         83plr7PBETVHHfePuu9PqqncCpINUh5G1LkNNZcQHu+6GXj37OvMltvzszY+TlYoNY
         KEU55pCDM+hXliTJO0LojuI0kaUjyhwnzVx/T9kE0qKmWnx7eMPb/CeH6LOlsujws8
         JOlwr860hn6wbyQSZFzQa1ZLapsVAI/G8Bd0yV3EuBTuTH9GMWmsa5bPhWg2yXriwP
         JNtYqVXR7F2yA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0637ACE0070; Fri, 14 Jul 2023 08:03:36 -0700 (PDT)
Date:   Fri, 14 Jul 2023 08:03:36 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <f8f3ed8c-66c1-4a07-8fe8-f7bb997a7dcf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230714144330.3c0a4074@canb.auug.org.au>
 <6f655ef5-b236-4683-92b0-da8b19e79eca@paulmck-laptop>
 <CAADnVQLF0BP-_Fjxi1S-0Shus38vAVdNbB2JHsBd6_RudYWF0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLF0BP-_Fjxi1S-0Shus38vAVdNbB2JHsBd6_RudYWF0A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 11:04:11PM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 13, 2023 at 9:50 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Fri, Jul 14, 2023 at 02:43:30PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > The following commit is also in net-next tree as a different commit
> > > (but the same patch):
> > >
> > >   a2b38823280d ("rcu: Export rcu_request_urgent_qs_task()")
> > >
> > > This is commit
> > >
> > >   43a89baecfe2 ("rcu: Export rcu_request_urgent_qs_task()")
> > >
> > > in the net-next tree.
> >
> > The net-next tree needs it for BPF, correct?
> 
> yes.
> 
> > So if you guys intend to
> > push it to mainline, I will be happy to drop if from -rcu.
> 
> That's the intent. Please drop it from -rcu.

Very good, it goes on my next rebase later today, Pacific Time.

						Thanx, Paul
