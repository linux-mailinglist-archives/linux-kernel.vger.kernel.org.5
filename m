Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27833753F39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbjGNPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjGNPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:44:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378EA3A82;
        Fri, 14 Jul 2023 08:44:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB35261D1A;
        Fri, 14 Jul 2023 15:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4324C433C8;
        Fri, 14 Jul 2023 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689349464;
        bh=gIEirEVNj2eZrnvQMBk6eeqLsF9YpgAI2QODQB8o9KM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jCGKYGB/ySKGSIY3DFVkZr6AEKTeBe4dWS1D2LMlvynTsQmZAeDdventQJbKuI7GR
         0FiaIuqY4NoCh2bGenNVFUnd8jMO/f76qgp9jBactaQr457I+1kQ9Ezn9t/28GTi7L
         MHbBs66Hrj2xigwse2mEpC6iO8rRwWaSrjBt+pu325OYAQQ6TKHe1nST6f7Xf2rX+i
         BdHW5GIOUItZFO+swsNQfXqsIemwnO+LKx6u8+p3PPM3QUG/jRA8UojvY3uVvY5xIN
         4Y+/1H5MKyefWC4lA1KURJ7cEp0hmeF1vVzO4agb5PjEfJK57cznRYtRg7MtMbdcgo
         x4pDZOYclak7w==
Date:   Fri, 14 Jul 2023 08:44:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH docs] docs: maintainers: suggest including lore link for
 conflicts known to linux-next
Message-ID: <20230714084422.107fca7a@kernel.org>
In-Reply-To: <20230714031624.GA3736130@mit.edu>
References: <20230713230417.1504773-1-kuba@kernel.org>
        <CAHk-=wiyGEZKpb1h=OTYzxaam_g0ek4GKyCPCvVz4fOh+BzCEA@mail.gmail.com>
        <20230714031624.GA3736130@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 23:16:24 -0400 Theodore Ts'o wrote:
> On Thu, Jul 13, 2023 at 05:47:18PM -0700, Linus Torvalds wrote:
> > 
> > You can point to the email that Stephen sent (using lore), or you can
> > quote his resolution (or your own, if you do a test-merge, like many
> > people do) if you want.  It's not a requirement.  
> 
> Yeah, I normally do my own test merge.  I might check to see if it's
> the same as the one which is in linux-next, but the more importantly,
> I then run a full set of regression tests and make sure there are no
> new test failures caused by the merge resolution.

Alright, I guess we all end up intuiting in a similar way :)
In this case let's ditch the patch, it may do more harm than good.
Someone may read it as "if Stephen posted something - just point 
at it without thinking".
