Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDAD7DEAC1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348262AbjKBCg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbjKBCg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:36:26 -0400
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5B2101
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:36:20 -0700 (PDT)
Date:   Wed, 1 Nov 2023 22:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698892578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7hk7EDHXwmKrezCFMkFGV4WjYpzJvbn/keLuYpStMdE=;
        b=UtZGHQRY+qB8l04fJ40M75jfaW8vulKmHtYnJCL8y6KLIcKQgYi/tw5KP07AXiy/xVbn+h
        KgdBhUBHkAhXeDB+opLuuCfnMO4bsEpMa+7Px7dhDJTOFwxPI3bDI513iTLsZsq5V7ORZ2
        af+5O2J9mxAF8ifmk4fLUWAQlQHN9Is=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 22/32] vfs: inode cache conversion to hash-bl
Message-ID: <20231102023615.jsv2ffe4rbivgsja@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-23-kent.overstreet@linux.dev>
 <20230523-zujubeln-heizsysteme-f756eefe663e@brauner>
 <20231019153040.lj3anuescvdprcq7@f>
 <20231019155958.7ek7oyljs6y44ah7@f>
 <ZTJmnsAxGDnks2aj@dread.disaster.area>
 <CAGudoHHqpk+1b6KqeFr6ptnm-578A_72Ng3H848WZP0GoyUQbw@mail.gmail.com>
 <ZTYAUyiTYsX43O9F@dread.disaster.area>
 <CAGudoHGzX2H4pUuDNYzYOf8s-HaZuAi7Dttpg_SqtXAgTw8tiw@mail.gmail.com>
 <20231031-proviant-anrollen-d2245037ce97@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-proviant-anrollen-d2245037ce97@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 12:02:47PM +0100, Christian Brauner wrote:
> > The follow up including a statement about "being arsed" once more was
> > to Christian, not you and was rather "tongue in cheek".
> 
> Fyi, I can't be arsed to be talked to like that.
> 
> > Whether the patch is ready for reviews and whatnot is your call to
> > make as the author.
> 
> This is basically why that patch never staid in -next. Dave said this
> patch is meaningless without his other patchs and I had no reason to
> doubt that claim nor currently the cycles to benchmark and disprove it.

It was a big benefit to bcachefs performance, and I've had it in my tree
for quite some time. Was there any other holdup?
