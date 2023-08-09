Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F2D776B52
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjHIV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjHIV66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:58:58 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B22103;
        Wed,  9 Aug 2023 14:58:56 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qTrCY-0002Gf-QW; Wed, 09 Aug 2023 23:58:46 +0200
Date:   Wed, 9 Aug 2023 23:58:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
Message-ID: <20230809215846.GE3325@breakpoint.cc>
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
 <20230809-net-netfilter-v2-1-5847d707ec0a@google.com>
 <20230809201926.GA3325@breakpoint.cc>
 <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8oNsGEAmSYs4H3ppm1t2DrD8Br5wwg+VuNtwfoOA_-64A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Stitt <justinstitt@google.com> wrote:
> On Wed, Aug 9, 2023 at 1:19 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Justin Stitt <justinstitt@google.com> wrote:
> > > Use `strscpy_pad` instead of `strncpy`.
> >
> > I don't think that any of these need zero-padding.
> It's a more consistent change with the rest of the series and I don't
> believe it has much different behavior to `strncpy` (other than
> NUL-termination) as that will continue to pad to `n` as well.
> 
> Do you think the `_pad` for 1/7, 6/7 and 7/7 should be changed back to
> `strscpy` in a v3? I really am shooting in the dark as it is quite
> hard to tell whether or not a buffer is expected to be NUL-padded or
> not.

No, you can keep it as-is.  Which tree are you targetting with this?
