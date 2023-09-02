Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F11479059F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 08:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351685AbjIBGiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 02:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIBGiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 02:38:09 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE11702
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 23:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693636686;
        bh=ipQTCRzsZP/BOm8ZUDz1C7VfNiNEcjVKR18qDkBh+uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dnXQO0ENNeQIKSOL8cj4+KjwJWL1p+YWdfWcuxpSH4Yqb4Aqx75g4yEEq1I7qHY0w
         GsdrxvTbyAa4OEE45xI1I4YekxRE3eRVW/D/DhwaZ3jEKFAvZVvJH8SE4JhDrfQpRE
         y8MAk4iKrdvU3nnzVnpTvkzq97YPBCO04zpjXWZnzMEFkV3/0BGL+lIT7odjT5XLR/
         94uIDDgeG8D9zw6GcNnkyBKdZRzApVZe5VrVT5/yqN6FWGMmxN0isydJc8sDGxMvTg
         OEDkUMDHcm7fJaVhkyKuG6WWiMQmeakVG6iwxLnJ6ZaU8ujWl5Qe+Gwmvxt9BdLdEL
         iRcxSuKNv9BEw==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 9785724B39E;
        Sat,  2 Sep 2023 13:38:02 +0700 (WIB)
Date:   Sat, 2 Sep 2023 13:37:56 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for
 `memcpy()` and `memmove()`
Message-ID: <ZPLYRENvjAub3wq5@biznet-home.integral.gnuweeb.org>
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
 <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
 <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
 <ZPLR+mO/6/V7wjAJ@biznet-home.integral.gnuweeb.org>
 <20230902062237.GA23141@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902062237.GA23141@1wt.eu>
X-Bpl:  hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 08:22:37AM +0200, Willy Tarreau wrote:
> Note that in this case we simply don't need a special
> version of memcpy(), memmove() is always OK for this,
> so you can simplify this further by starting with:
> 
>   memcpy:
>   memmove:
>        ...

Ok, I'll do that.

-- 
Ammar Faizi

