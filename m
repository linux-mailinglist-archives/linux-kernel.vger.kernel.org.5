Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1562D797C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344311AbjIGSte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbjIGStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:49:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BCFB2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 11:49:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 387InMPg001282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 14:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694112563; bh=mI7/7xJlL+6hYr/y3/VwTCFEef31LhE4C3NkmeStsLU=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=cfNaszBYUoAc9nLgM1K/iTGyHpKU8EDXLyPKXtZpk43jOir1JCmmn+35odpJTLmob
         NYEHlu+rXURrL9tq7WxFwqpwvj+aN2IFHY0aFXAJK3Cfc7udsP/PV4EjofnYIByiE9
         p9bV3zUmrR4Z6h9EXycihociGwX2aJ92mISuqMe1I0u2aEjnJmcWGCp0vInJcqVD0A
         IwyFAN1mldu2ap7H9F/oe2Jz/zLVzQ48iYS6Q2lhviN9zqMOHTL813mCEO0xtB797G
         /ylfobyhHMBUrg2XqwCTLTUV0MtiJerkES3uuowLfjJuc1B7oahBz/Wvh01P1Q2C04
         Hil+nrnu6AKgg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 09BB715C023F; Thu,  7 Sep 2023 14:49:22 -0400 (EDT)
Date:   Thu, 7 Sep 2023 14:49:22 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jon Maser <jonmaser8@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: would a linux kernel news group benefit the linux kernel?
Message-ID: <20230907184922.GD701295@mit.edu>
References: <CAF=mWJPsrWvVVoDqRtZwC48cMKx+5x0bBt5NBLOQemKva9ef9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF=mWJPsrWvVVoDqRtZwC48cMKx+5x0bBt5NBLOQemKva9ef9A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:56:08AM -0700, Jon Maser wrote:
> under the guise that it would be used, it would allow discussion, file
> sharing (down to distribution isos) and it should not be hosted on the
> typical charge for use nntp servers on the internet, which hold
> questionable media.
> 
> the problem is it would cost money to host all the files and deal with
> all the traffic and internet noise, so im just throiwng that out there
> incase the linux developer world would like, news.linuxfoundation.org
> to host files like that.
> 
> and yeah, all youd need to do is download a news client such as pan,
> enter in server info and read/download/post
> 
> just a novelty, but could be useful

It is already possible to read LKML using an NNTP client[1].  See [2]
and [3] for more details.  It's a read-only mirror, so you can't post
from your NNTP client, and it means all of the message size
limitations of vger.kernel.org still apply.  So it really depends on
what your goals are for having something like this.

[1] nntp://nntp.lore.kernel.org/org.kernel.vger.linux-kernel
[2] https://lore.kernel.org/lkml/_/text/help/
[3] https://brennan.io/2021/05/05/kernel-mailing-lists-thunderbird-nntp/

Furthermore, we already have a way for to share files via
www.kernel.org.  It requires a kernel.org account, but that can be
considered a feature, since the last thing you want is the KGB or the
Ministry of State Security to post a "distribution iso" that is trojan
horsed to a fare-thee-well.  So having good accountability of who can
share files is a good thing, and the free-for-all "what,
authentication, me worry?" philosophy of Usenet is a time that I
recall with fondness back in the 1980's, but it's not clear it's well
suited for the security requirements of today.

Cheers,

						- Ted
