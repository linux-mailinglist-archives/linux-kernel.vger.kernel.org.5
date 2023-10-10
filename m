Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB0A7BF6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjJJJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjJJJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:04:11 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB098A7;
        Tue, 10 Oct 2023 02:04:09 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qq8eW-005TST-2G; Tue, 10 Oct 2023 17:03:45 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 Oct 2023 17:03:48 +0800
Date:   Tue, 10 Oct 2023 17:03:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Ma Ke <make_ruc2021@163.com>, steffen.klassert@secunet.com,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: fix return value check in esp_remove_trailer
Message-ID: <ZSUTdBpSTgNz5CA8@gondor.apana.org.au>
References: <20231007005953.3994960-1-make_ruc2021@163.com>
 <ZSLh0vtpbP81Vh7G@pop-os.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSLh0vtpbP81Vh7G@pop-os.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 10:07:30AM -0700, Cong Wang wrote:
> On Sat, Oct 07, 2023 at 08:59:53AM +0800, Ma Ke wrote:
> > In esp_remove_trailer(), to avoid an unexpected result returned by
> > pskb_trim, we should check the return value of pskb_trim().
> > 
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  net/ipv6/esp6.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> We need the same change for net/ipv4/esp4.c?

Please verify that it can actually fail first.  Note that I'm
busy right now so I haven't looked at it at all.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
