Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FAA7A83CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbjITNru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjITNrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:47:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD1DAD;
        Wed, 20 Sep 2023 06:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8C71200A3;
        Wed, 20 Sep 2023 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695217657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/snCuZpEV/rtAoiDV8eTkiFsU9tul7/5xeWIzs69P4=;
        b=SieMIAkivNWy3EVUvOjPG5/PORQlkKhXDFby+/Llv1MT4g5OqJjZL+SnRmLeRk5vzysjdf
        wg8/6w1A5jKCofvAFHe8UMJaBGMF4YlAWwKFVeAWKQZtcUNErEikKd/i0mpm6rl3gF5NU4
        waD4aVwTbnXNUjHh/k0mM5kmMD99RRM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B50D71333E;
        Wed, 20 Sep 2023 13:47:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p93hKfn3CmVNCwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 20 Sep 2023 13:47:37 +0000
Date:   Wed, 20 Sep 2023 15:47:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <ZQr3+YfcBM2Er6F7@dhcp22.suse.cz>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <101987a1-b1ab-429d-af03-b6bdf6216474@linux.microsoft.com>
 <ZQrSXh+riB7NnZuE@dhcp22.suse.cz>
 <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eb47d6a-b127-4aad-af30-896c3b9505b4@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-09-23 15:25:23, Jeremi Piotrowski wrote:
> On 9/20/2023 1:07 PM, Michal Hocko wrote:
[...]
> > I mean, normally I would be just fine reverting this API change because
> > it is disruptive but the only way to have the file available and not
> > break somebody is to revert 58056f77502f ("memcg, kmem: further
> > deprecate kmem.limit_in_bytes") as well. Or to ignore any value written
> > there but that sounds rather dubious. Although one could argue this
> > would mimic nokmem kernel option.
> > 
> 
> I just want to make sure we don't introduce yet another new behavior in this legacy
> system. I have not seen breakage due to 58056f77502f. Mimicing nokmem sounds good but
> does this mean "don't enforce limits" (that should be fine) or "ignore writes to the limit"
> (=don't event store the written limit). The latter might have unintended consequences.

Yes it would mean that the limit is never enforced. Bad as it is the
thing is that the hard limit on kernel memory is broken by design and
unfixable.  This causes all sorts of unexpected kernel allocation
failures that this is simply unsafe to use.

All that being said I can see the following options
1) keep the current upstream status and not export the file
2) revert both 58056f77502f and 86327e8eb94 and make it clear
   that kmem.limit_in_bytes is unsupported so failures or misbehavior
   as a result of the limit being hit are likely not going to be
   investigated or fixed.
3) reverting like in 2) but never inforce the limit (so basically nokmem
   semantic)

Shakeel, Johannes, Roman, Muchun Song what do you think?
-- 
Michal Hocko
SUSE Labs
