Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4917C6B57
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbjJLKly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjJLKlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:41:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19CE90
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:41:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ED9C433C7;
        Thu, 12 Oct 2023 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697107310;
        bh=mm1VIMvRUJvd4y/Aiz0Pcv18kOerOu+LmWBctdW6pVU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=umdRkqeV+KLN5q6aYzcwAE/uYw13apHghVkvCl5prjaJAuhx41j+6/23LpsU5JnTz
         wi2aQfUt90MpkvKJuGNmrPQfgJx6mw/7Cwm+QTJNqychSMjchc2SdgwGPhtKVyL/NO
         lqZT667fS5xqscOQHrBB0epWVvi6cynGpIYm14QhVre7MeCi51Yxki1ar50aUnktJe
         DR8rcm5FEsqhJ6vreOOlU312F/BKkQ+WbGewHT1l3CymaLqrZHAfuqZBU/5vd9PtMQ
         Rd5qSA25jrFWC3MA+CGUqsbMFh5XQZ+QQGIR6ONlIo0p8/7ZvbkeghwtqWEmPr8kiE
         RXnlcfBWFq9Pw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 187B0CE0868; Thu, 12 Oct 2023 03:41:50 -0700 (PDT)
Date:   Thu, 12 Oct 2023 03:41:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231012-nolibc-linkage-test-v1-1-315e682768b4@weissschuh.net>
 <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:23:29AM +0200, Thomas Weiﬂschuh wrote:
> Hi Willy, Paul,
> 
> On 2023-10-12 09:06:33+0200, Willy Tarreau wrote:
> > On Thu, Oct 12, 2023 at 01:13:37AM +0200, Thomas Weiﬂschuh wrote:
> > > While uncommon, nolibc executables can be linked together from multiple
> > > compilation units.
> > > Add some tests to make sure everything works in that case.
> > (...)
> 
> [..]
> 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > > Note:
> > > 
> > > This depends on path "tools/nolibc: mark start_c as weak".
> > > https://lore.kernel.org/lkml/20231012-nolibc-start_c-multiple-v1-1-fbfc73e0283f@weissschuh.net/
> > 
> > For these two patches: Acked-by: Willy Tarreau <w@1wt.eu>
> 
> Thanks, applied locally.
> 
> I guess the linked patch "tools/nolibc: mark start_c as weak" should
> also go into nolibc/fixes.
> 
> @Paul, would it introduce too much churn for you if I submit another
> nolibc pull with an updated nolibc/fixes?
> (And the rebased nolibc/next with this commit while we are at it)

Not a problem this week!

But after about Wednesday of next week, getting things into the upcoming
merge window is pretty much as fast as sending them quickly to Linus,
if that makes sense.  Unless there is to be a -rc8 this time, but I
have heard no sign of that.

Make sense?

							Thanx, Paul
