Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DA27BCCC5
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344462AbjJHGkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 02:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbjJHGkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 02:40:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62383D8
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 23:40:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D7CC433C7;
        Sun,  8 Oct 2023 06:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696747208;
        bh=R6mQg6prLrJ0m6GBgEDiRQvu5zEafQC98sSv/4bu6ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dl+5pfH3SrfEOCg1RmQ3a3aQ1U/mhG+RDEYSobo/Ua9xmEVkwepK+hI6N0o6qt3vA
         egMhKPT72B7zls4Q6iW0Y8yrr1EyYOwfoJHzwu9y2w2pEIMiojGFytINotMdRdz9Vq
         6iN3jDLDt2MY4woPrQi/GZa/DTvOwuxVq6p+Qam8=
Date:   Sun, 8 Oct 2023 08:40:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: make vduse_class constant
Message-ID: <2023100823-absurd-imitation-092d@gregkh>
References: <2023100643-tricolor-citizen-6c2d@gregkh>
 <20231008022022-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231008022022-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 02:20:52AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 04:30:44PM +0200, Greg Kroah-Hartman wrote:
> > Now that the driver core allows for struct class to be in read-only
> > memory, we should make all 'class' structures declared at build time
> > placing them into read-only memory, instead of having to be dynamically
> > allocated at runtime.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: Xie Yongji <xieyongji@bytedance.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Greg should I merge it or do you intend to merge all these patches?

"all"?  There's loads of them for all sorts of subsystems, so feel free
to take it through your subsystem tree if you want.  I usually scoop up
the ones that no one picks after a release and take them through my
tree, to pick up the stragglers.

So it's your call, whatever is easier for you is fine for me.

thanks,

greg k-h
