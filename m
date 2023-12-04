Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD0D8034CF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbjLDN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjLDN1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:27:11 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F582D72
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:25:07 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-423c28db22eso46151451cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701696304; x=1702301104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0moGbGhejv/srhz8+960qzSk1YcwHQBWsgkAUS7flGY=;
        b=gmdWcg1veFs8vXQmgFlJ4QA3G8cOdi20cJXOCqhGzy7ZalmFtPrTL16qQd+jdiHupi
         IVWrLWpuDIL6oiPNk9PSFe0tWVqyolLea3ll1rOMx/Lw45YgWj9yC4ZO9e2dT5dXM3Bu
         ntqX7ThIkzCYsUEw6JF/6DtnWwL/x66/UeWMsfaDW3cmMmMvQYarTQgmNbVbqJAMXKuQ
         1IxHvnuLKIYs1ICDqN6B/q9u4SD+rlvO+0tE0nAkr/9m7uhafdmEB0BVmfE1wx4D0KIY
         1pf+MxBZ7AxC6K9QeEIeaO4inmOMsjQdG6rlxzic9uTM+AG4kZ7nm9hTSrYM16eVBBuP
         G4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701696304; x=1702301104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0moGbGhejv/srhz8+960qzSk1YcwHQBWsgkAUS7flGY=;
        b=fFuZZayKdgzbYGnZJhN5dSSy3G2A9QbV8YT6btvTVFNy/4KdQk/ordRc7GbHM+BNSg
         Pu0V6TPHTXrFoLkubv6SGQMrMT4R+NxKZSVYnNwVN8kffZfhd7dAUyOlQexhKbStBIyj
         FOm6HBpqHHadMg/UYwnz0gmPBNOEm6XjAUthaZbXMSL1kbMcbHA9g9qdlLV0y2sOxhnR
         pMmWMc9zUC7yPa052YEptPRClCFBTRhLnTO29RcG7Wlx+ib4LPvNIlZ/NRvy8tdbe37P
         EgFnM0cZcSrwMUatWLmMR7YLfLJzQspuazSYhTz7KSMGrQk/uG7zm0S8ZDOWDDv+Tmqd
         L8qQ==
X-Gm-Message-State: AOJu0Yw2C+rYHr7w3hGyhDN4GyI76869FEGYY708JOatKd/3Vs4zrWhm
        sPbtvbxGxLMwv4jNBVAr8eXtBA==
X-Google-Smtp-Source: AGHT+IEuBtJDX6k91V+YITPMzc6IBzL+YpnMZews0QwJR4BifvUjKKT5gSJ3XU5n/QvsTf6dQHmbjA==
X-Received: by 2002:ac8:5b8b:0:b0:410:9668:530a with SMTP id a11-20020ac85b8b000000b004109668530amr6178889qta.21.1701696304412;
        Mon, 04 Dec 2023 05:25:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id jg5-20020a05622a728500b004252255144csm2544679qtb.15.2023.12.04.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 05:25:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rA8wZ-00AsHw-7d;
        Mon, 04 Dec 2023 09:25:03 -0400
Date:   Mon, 4 Dec 2023 09:25:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 12/12] iommu: Improve iopf_queue_flush_dev()
Message-ID: <20231204132503.GL1489931@ziepe.ca>
References: <20231115030226.16700-1-baolu.lu@linux.intel.com>
 <20231115030226.16700-13-baolu.lu@linux.intel.com>
 <20231201203536.GG1489931@ziepe.ca>
 <a0ef3a4f-88fc-40fe-9891-495d1b6b365b@linux.intel.com>
 <20231203141414.GJ1489931@ziepe.ca>
 <2354dd69-0179-4689-bc35-f4bf4ea5a886@linux.intel.com>
 <BN9PR11MB5276999D29A133F33C3C4FEA8C86A@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276999D29A133F33C3C4FEA8C86A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 05:37:13AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Monday, December 4, 2023 9:33 AM
> > 
> > On 12/3/23 10:14 PM, Jason Gunthorpe wrote:
> > > On Sun, Dec 03, 2023 at 04:53:08PM +0800, Baolu Lu wrote:
> > >> Even if atomic replacement were to be implemented,
> > >> it would be necessary to ensure that all translation requests,
> > >> translated requests, page requests and responses for the old domain are
> > >> drained before switching to the new domain.
> > >
> > > Again, no it isn't required.
> > >
> > > Requests simply have to continue to be acked, it doesn't matter if
> > > they are acked against the wrong domain because the device will simply
> > > re-issue them..
> > 
> > Ah! I start to get your point now.
> > 
> > Even a page fault response is postponed to a new address space, which
> > possibly be another address space or hardware blocking state, the
> > hardware just retries.
> 
> if blocking then the device shouldn't retry.

It does retry.

The device is waiting on a PRI, it gets back an completion. It issues
a new ATS (this is the rety) and the new-domain responds back with a
failure indication.

If the new domain had a present page it would respond with a
translation

If the new domain has a non-present page then we get a new PRI.

The point is from a device perspective it is always doing something
correct.

> btw if a stale request targets an virtual address which is outside of the
> valid VMA's of the new address space then visible side-effect will
> be incurred in handle_mm_fault() on the new space. Is it desired?

The whole thing is racy, if someone is radically changing the
underlying mappings while DMA is ongoing then there is no way to
synchronize 'before' and 'after' against a concurrent external device.

So who cares?

What we care about is that the ATC is coherent and never has stale
data. The invalidation after changing the translation ensures this
regardless of any outstanding un-acked PRI.

> Or if a pending response carries an error code (Invalid Request) from
> the old address space is received by the device when the new address
> space is already activated, the hardware will report an error even
> though there might be a valid mapping in the new space.

Again, all racy. If a DMA is ongoing at the same instant things are
changed there is no definitive way to say if it resolved before or
after.

The only thing we care about is that dmas that are completed before
see the before translation and dmas that are started after see the
after translation.

DMAs that cross choose one at random.

> I don't think atomic replace is the main usage for this draining 
> requirement. Instead I'm more interested in the basic popular usage: 
> attach-detach-attach and not convinced that no draining is required
> between iommu/device to avoid interference between activities
> from old/new address space.

Something like IDXD needs to halt DMAs on the PASID and flush all
outstanding DMA to get to a state where the PASID is quiet from the
device perspective. This is the only way to stop interference.

If the device is still issuing DMA after the domain changes then it is
never going to work right.

If *IDXD* needs some help to flush PRIs after it halts DMAs (because
it can't do it on its own for some reason) then IDXD should have an
explicit call to do that, after suspending new DMA.

We don't know what things devices will need to do here, devices that
are able to wait for PRIs to complete may want a cancelling flush to
speed that up, and that shouldn't be part of the translation change.

IOW the act of halting DMA and the act of changing the translation
really should be different things. Then we get into interesting
questions like what sequence is required for a successful FLR. :\

Jason

