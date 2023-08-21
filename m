Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5AF7829A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjHUM5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbjHUM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:57:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B242B1;
        Mon, 21 Aug 2023 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bkpIHgJ72JldiWUel9wVfgGF2ysEoVcz7b0lE+gT6jg=; b=KQ5ekz5vxHnK1vYsygUx286252
        wC/k81Uz0vXgbfMXfbYd7VEJ+FI/9GEX2VVAdfdEALcbJUc+CBei90d2g5U4kRXMoG5Ob1qkcUWSu
        R5GkY6BHiP/gBoTaARanxeNcZlIq97x4IW+46JrXCoI242sxhLQKXXoYZt1MJK4hp+g25ZQBsjEuE
        hVpq2u4TRwZkSxi9Xmf60gv+Kg9LzK8HndFeTog/7l7Rl0wxPi4qVMPK3NOBTo2hTBczoXn8+axfF
        mPe5a0lCNTzriPNwDFxsknbOIviTDiyLQ931aoKOZk+awBJLPg3a8Kh0pRVYC0W9KcDugFaZLz7eY
        I5+DtpMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY4T2-00AIWb-Jt; Mon, 21 Aug 2023 12:57:12 +0000
Date:   Mon, 21 Aug 2023 13:57:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag
 to give credits to who sponsored the patch
Message-ID: <ZONfKKwFaDQpuZ9w@casper.infradead.org>
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
 <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
 <20230817232348.GC1175@pendragon.ideasonboard.com>
 <ZN65iiRiSLmXz89k@casper.infradead.org>
 <87ttss7q8o.fsf@intel.com>
 <ZONTiijMLWbt6naQ@casper.infradead.org>
 <87o7j07frk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7j07frk.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 03:15:43PM +0300, Jani Nikula wrote:
> On Mon, 21 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
> > On Mon, Aug 21, 2023 at 11:29:27AM +0300, Jani Nikula wrote:
> >> On Fri, 18 Aug 2023, Matthew Wilcox <willy@infradead.org> wrote:
> >> > but you might have (eg)
> >> >
> >> > Laurent Pinchard (Coca-Cola) <laurent.pinchart@ideasonboard.com>
> >> >
> >> > and then when working for another sponsor:
> >> >
> >> > Laurent Pinchard (Ford) <laurent.pinchart@ideasonboard.com>
> >> 
> >> Just an observation, git shortlog -s/-se groups/distinguishes,
> >> respectively, the author and sponsor in Laurent's approach. Not so with
> >> Matthew's approach.
> >
> > Hm?
> >
> > $ git shortlog -s next-20230817..
> >      1  Matthew Wilcox (Novartis)
> >     25  Matthew Wilcox (Oracle)
> >
> > $ git shortlog -se next-20230817..
> >      1  Matthew Wilcox (Novartis) <willy@infradead.org>
> >     25  Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> $ git shortlog v6.4.. -s --author="Laurent Pinchart"
>     12  Laurent Pinchart
> 
> $ git shortlog v6.4.. -se --author="Laurent Pinchart"
>      2  Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>     10  Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I must not be understanding your point correctly.

$ git shortlog v6.4.. -s --author="Matthew Wilcox"
     7  Matthew Wilcox
     1  Matthew Wilcox (Novartis)
   123  Matthew Wilcox (Oracle)

That seems to me like it successfully distinguishes my fake commit on
behalf of Novartis (who I haven't actually worked for since 1997) from
my real commits on behalf of Oracle.  It also shows a few places where
my commits weren't attributed to Oracle (I think this happens when I
send patches using mutt instead of git-send-email)
