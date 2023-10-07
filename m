Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E34E7BC6EF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343839AbjJGKu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343792AbjJGKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:50:54 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6A89E;
        Sat,  7 Oct 2023 03:50:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qp4t1-0005zZ-Dj; Sat, 07 Oct 2023 12:50:19 +0200
Date:   Sat, 7 Oct 2023 12:50:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     George Guo <dongtai.guo@linux.dev>
Cc:     edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH] tcp: fix secure_{tcp, tcpv6}_ts_off call parameter order
 mistake
Message-ID: <20231007105019.GA20662@breakpoint.cc>
References: <20231007092337.1540036-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007092337.1540036-1-dongtai.guo@linux.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

George Guo <dongtai.guo@linux.dev> wrote:
> From: George Guo <guodongtai@kylinos.cn>
> 
> Fix secure_tcp_ts_off and secure_tcpv6_ts_off call parameter order mistake

Could you please send a v2, targetting net-next, that clearly
says that this is a cleanup?

[ It doesn't matter if we pass "saddr, daddr" or
  "daddr, saddr" as long as both "init" and "check"
  functions agree on the ordering ]
