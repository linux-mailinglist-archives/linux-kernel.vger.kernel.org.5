Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19E7A7A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjITLQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjITLQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:16:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F1C2;
        Wed, 20 Sep 2023 04:16:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAEDC433C7;
        Wed, 20 Sep 2023 11:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695208564;
        bh=lnb0O1ksQMJ7rJw1NAKO+dUYTXlWkz3GfIFHZ4hjhYw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRpFtbRooXyjFa0r5RNeNmIgeYTw6ZeBzweQfv2VXCt+CXluRcoGptjDCBFLqGNQE
         rI+uyvPzuwHnB+vjJow0Oh53grNRxT8JIvmHwWR1+UR7lH/XBoMhaL/M67wMqmAUSo
         ruPUpZGkpO0u7KjxmPUYyEZFa/aVb7nxkoxappq4=
Date:   Wed, 20 Sep 2023 13:16:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Hocko <mhocko@suse.com>
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
Message-ID: <2023092016-shield-confused-0e12@gregkh>
References: <20230917191040.964416434@linuxfoundation.org>
 <20230917191042.204185566@linuxfoundation.org>
 <20230920081101.GA12096@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZQqwzK/fDm+GLiKM@dhcp22.suse.cz>
 <2023092032-applied-gave-0bff@gregkh>
 <76525b1a-6857-434d-86ee-3c2ff4db0e4c@linux.microsoft.com>
 <2023092044-porthole-impeding-e539@gregkh>
 <ZQrSu8lfwkk/nNxi@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQrSu8lfwkk/nNxi@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:08:43PM +0200, Michal Hocko wrote:
> On Wed 20-09-23 12:45:08, Greg KH wrote:
> [...]
> > Ok, then we should revert this, I'll go drop it in the stable trees, it
> > should also be reverted in Linus's tree too.
> 
> A simple revert would break other users as noted in other response so
> wait with sending reverts to Linus before we agreen on the least painful
> solution.

A revert should cause the systems that stopped working to start working
again, so I'll keep the revert in the stable trees and wait for you to
work out the real solution in Linus's tree and then backport all of them
as needed.

thanks,

greg k-h
