Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765167CB63B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjJPWIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 18:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjJPWIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:08:04 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E226A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1697494079;
        bh=BNnauGvB3NMUSz9CcxKTyRjSwWgxTLcHlHf9pGpnUsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAj/T+6TsTqUwTEPSZ1GphY1HJZ3m4/97j4ohSlkf0GemfE4dcxnHCJejFmokIEj9
         Z7zWF8Fr7J4LoOJ6V2JHR8E4ltFSd4nTNYJb7IS2GQWzBhvI8Bo5aa7/8mzMLOqymx
         7b3CsGACNG16T5o4VAGltakk+FWXed6/bhUwu+YU=
Date:   Tue, 17 Oct 2023 00:03:41 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: add tests for multi-object linkage
Message-ID: <edd7c9f6-32cb-4f5d-920d-7bd6bdb7eea0@t-8ch.de>
References: <ZSea+etQwlxbi+Ok@1wt.eu>
 <bfc17e76-fcbc-4ce6-97a8-c1ed72ed2a67@t-8ch.de>
 <33e9afcd-a1cd-4f67-829b-85c86500a93e@paulmck-laptop>
 <b278a643-3761-4699-bafc-df1b7245b8c2@t-8ch.de>
 <ca67eb2c-3918-4a1f-b3e6-2023fda5d6a3@paulmck-laptop>
 <6b66305f-8172-463e-a50d-324c0c33a6ea@t-8ch.de>
 <a5f1a910-dbac-44d8-b9f6-5725bea948b2@paulmck-laptop>
 <aa77a065-fcc9-4d3a-8531-fd994587c48f@t-8ch.de>
 <0c8446a7-473d-49bc-9413-d1b9176f13b1@paulmck-laptop>
 <246fe818-57a7-4cee-a11b-390df3eee101@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <246fe818-57a7-4cee-a11b-390df3eee101@paulmck-laptop>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-16 09:24:19-0700, Paul E. McKenney wrote:
> On Thu, Oct 12, 2023 at 01:18:18PM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 12, 2023 at 09:34:53PM +0200, Thomas Weißschuh wrote:
> > > On 2023-10-12 12:06:33-0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 12, 2023 at 08:39:14PM +0200, Thomas Weißschuh wrote:
> > > > > On 2023-10-12 11:25:02-0700, Paul E. McKenney wrote:
> > > > > > [..]
> > > 
> > > > > > I have a signed tag urgent/nolibc.2023.10.12a in the -rcu tree, so
> > > > > > please check the lead-in text for sanity.  (Everything after the digital
> > > > > > signature is automatically generated.)
> > > > > 
> > > > > Looks good. But it's only a listing of the commit subjects, correct?
> > > > 
> > > > Pretty close, just a few added words on the last one.
> > > > 
> > > > So the question is whether there is some larger issue that Linus should
> > > > be made aware of.  If these are just simple fixes for simple bugs,
> > > > we should be good, but yes, I do need to ask.  ;-)
> > > 
> > > These are simple fixes for simple bugs.
> > > 
> > > Do you always have to ask specifically or can I just mention it in the
> > > pull request in the future?
> > 
> > I would be extremely happy to simply copy text from the pull request
> > into the signed tags.  ;-)
> > 
> > We would just need to agree on the format.  For example, in this case,
> > there will eventually be two signed tags, one for the urgent pull
> > request early next week and another for the pull request for the upcoming
> > merge window.
> > 
> > Proposals for the format?
> 
> Actually, proposals for the signed-tag text for the urgent commits?
> Left to myself, I would use the same text shown below that I proposed
> last week.

Looks good.

The tags for urgent PRs seem good with one item per patch.
I guess for normal PRs one item per series would be fine.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> tag urgent/nolibc.2023.10.12a
> Tagger: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Oct 12 10:50:08 2023 -0700
> 
> Urgent pull request for nolibc into v6.6
> 
> This pull request contains the following fixes:
> 
> o	tools/nolibc: i386: Fix a stack misalign bug on _start
> 
> o	MAINTAINERS: nolibc: update tree location
> 
> o	tools/nolibc: mark start_c as weak to avoid linker errors

> [..]
