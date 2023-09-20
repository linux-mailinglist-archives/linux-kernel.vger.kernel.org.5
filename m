Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3737A7A15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjITLI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITLIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:08:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30203B4;
        Wed, 20 Sep 2023 04:08:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E23C421E57;
        Wed, 20 Sep 2023 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695208124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HntuIlTbkpDFGdE0m0Da4W+O+36Tjt/wGk7ZN0YkbpI=;
        b=RXBUdJUu1WGCQtvQTAr7pAXX963WmqAO1JzdqL0IonpZbqyJvlUcJ5FJzYnD1NfI8IuUe1
        3tCp8cblgtTmM2vY2FWVfjqoD8+IWvV1mNUlNs0Nxk0Epv1Eb2K/hagi9yZoTEfjE9lkIm
        vB+O72Zx2Qrpm+JRj7MvzE7jMLyRwwU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8358B132C7;
        Wed, 20 Sep 2023 11:08:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0EIXHbzSCmWnLgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 20 Sep 2023 11:08:44 +0000
Date:   Wed, 20 Sep 2023 13:08:43 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
        mathieu.tortuyaux@gmail.com
Subject: Re: [REGRESSION] Re: [PATCH 6.1 033/219] memcg: drop
 kmem.limit_in_bytes
Message-ID: <ZQrSu8lfwkk/nNxi@dhcp22.suse.cz>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <2023092032-applied-gave-0bff@gregkh>
 <76525b1a-6857-434d-86ee-3c2ff4db0e4c@linux.microsoft.com>
 <2023092044-porthole-impeding-e539@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023092044-porthole-impeding-e539@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-09-23 12:45:08, Greg KH wrote:
[...]
> Ok, then we should revert this, I'll go drop it in the stable trees, it
> should also be reverted in Linus's tree too.

A simple revert would break other users as noted in other response so
wait with sending reverts to Linus before we agreen on the least painful
solution.

-- 
Michal Hocko
SUSE Labs
