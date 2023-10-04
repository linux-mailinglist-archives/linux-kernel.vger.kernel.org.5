Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104A37B7966
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbjJDIA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbjJDIAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:00:51 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54283B7;
        Wed,  4 Oct 2023 01:00:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qnwo9-0008ME-VA; Wed, 04 Oct 2023 10:00:37 +0200
Date:   Wed, 4 Oct 2023 10:00:37 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Henrik =?iso-8859-15?Q?Lindstr=F6m?= <lindstrom515@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: macvtap performs IP defragmentation, causing MTU problems for
 virtual machines
Message-ID: <20231004080037.GC15013@breakpoint.cc>
References: <CAHkKap3sdN4wZm_euAZEyt3XB4bvr6cV-oAMGtrmrm5Z8biZ_Q@mail.gmail.com>
 <20231002092010.GA30843@breakpoint.cc>
 <2197902.NgBsaNRSFp@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2197902.NgBsaNRSFp@pc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Lindström <lindstrom515@gmail.com> wrote:
> Had to change "return 0" to "return vif" but other than that your changes
> seem to work, even with macvlan defragmentation removed.

Oh, right, that should have been "return vid" indeed.

> I tested it by sending 8K fragmented multicast packets, with 5 macvlans on
> the receiving side. I consistently received 6 copies of the packet (1 from the
> real interface and 1 per macvlan). While doing this i had my VM running with
> a macvtap, and it was receiving fragmented packets as expected.
> 
> Here are the changes i was testing with, first time sending a diff over mail
> so hope it works :-)

Can you submit this formally, with proper changelog and Signed-off-by?
See scripts/checkpatch.pl in the kernel tree.

It might be a good idea to first mail the patch to yourself and see if
you can apply it (sometimes tabs get munged into spaces, long lines get
broken, etc).

You could also mention in changelog that this is ipv4 only because
ipv6 already considers the interface index during reassembly.

Thanks!
