Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5152A7677EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjG1VuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 17:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjG1Vt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 17:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA9123
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690580958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2WhoRj0lwDKacxOziWBDjdJtIWuF0uoNKyCx6NeZN8=;
        b=WKjeCM2T0iPHoUrWgKRg5i1rqwtD2kKhdMR67flpwh0gjBucbhqBQfpOEwQRT7VLonVvS3
        9wrg3+u1k9pql86fvuQ9AMVPzM+j4q/areFd5nV59iyay+HDyDOmlX/Rot1+rOBIKqo9p5
        rsvE+fWQNNOvTYeQ31TaVF+dN/PXVgU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-fzY58KK7O7GVZGM_pUYZrQ-1; Fri, 28 Jul 2023 17:49:17 -0400
X-MC-Unique: fzY58KK7O7GVZGM_pUYZrQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-405512b12f5so4812161cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690580956; x=1691185756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2WhoRj0lwDKacxOziWBDjdJtIWuF0uoNKyCx6NeZN8=;
        b=Y77wgkKihaxL2PMDBmEBvrvD3bNmWe+AN6OLX+VPg0HQHgxCIJue8ICA8241RE1tlT
         EWf8ffGxltQBeDB39dK4eMXEc4y3a96n9XG13ihyhL4gIKARzd7iiRo1hRJE+jiOtvWy
         i28xCkssvgjGrVPplAMJCH2CmM/I+YtLfaBmnczRIIQWCMXKSuYN3WWw1/1tUpx+u+QL
         GuXRIuo78J1ya4jif3PACOmZtqSJI0+Tvfq+dik8IZp8pJJVaAZ6uW1Utsp8tWKqVe71
         QQlb0KlcPUvPvsja1P1K3bl6myUOg0UsbSZknvj/fKQFYW9rfRjNFv69KZ/0RFowlpfw
         /sZQ==
X-Gm-Message-State: ABy/qLYN61QXjlXXkVRllFG7pOemW/qL9LonwTWPe6HTIWhg23yixK/c
        vkeWql9VVFs+g2T6Yw9V7g+JAWvL5IO4nlPIXOWuvRRtM5v1oUIcRjm0H/BNh1CyhqguP5H1+Zk
        Y4I8VHvbPeioWpSaW+FnykLFJ
X-Received: by 2002:a05:622a:1812:b0:400:84a9:a09c with SMTP id t18-20020a05622a181200b0040084a9a09cmr783861qtc.6.1690580956618;
        Fri, 28 Jul 2023 14:49:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEaWEQIKUPtxNLTWiu81nfTINj9tcUnW2EDUXzsCXYaLoFD6amWo5AwOsZTUNB+K0vv0WXo5w==
X-Received: by 2002:a05:622a:1812:b0:400:84a9:a09c with SMTP id t18-20020a05622a181200b0040084a9a09cmr783836qtc.6.1690580956269;
        Fri, 28 Jul 2023 14:49:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id u18-20020a05622a14d200b003f3937c16c4sm1457623qtx.5.2023.07.28.14.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 14:49:15 -0700 (PDT)
Date:   Fri, 28 Jul 2023 17:49:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMQ32RRJlW/aDYAE@x1n>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <ZMQZfn/hUURmfqWN@x1n>
 <CAHk-=wgRiP_9X0rRdZKT8nhemZGNateMtb366t37d8-x7VRs=g@mail.gmail.com>
 <e74b735e-56c8-8e62-976f-f448f7d4370c@redhat.com>
 <CAHk-=wgG1kfPR6vtA2W8DMFOSSVMOhKz1_w5bwUn4_QxyYHnTA@mail.gmail.com>
 <69a5f457-63b6-2d4f-e5c0-4b3de1e6c9f1@redhat.com>
 <ZMQxNzDcYTQRjWNh@x1n>
 <edd9b468-2d60-1df7-a515-22475fd94fe2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <edd9b468-2d60-1df7-a515-22475fd94fe2@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, John,

On Fri, Jul 28, 2023 at 02:32:12PM -0700, John Hubbard wrote:
> On 7/28/23 14:20, Peter Xu wrote:
> > On Fri, Jul 28, 2023 at 11:02:46PM +0200, David Hildenbrand wrote:
> > > Can we get a simple revert in first (without that FOLL_FORCE special casing
> > > and ideally with a better name) to handle stable backports, and I'll
> > > follow-up with more documentation and letting GUP callers pass in that flag
> > > instead?
> > > 
> > > That would help a lot. Then we also have more time to let that "move it to
> > > GUP callers" mature a bit in -next, to see if we find any surprises?
> > 
> > As I raised my concern over the other thread, I still worry numa users can
> > be affected by this change. After all, numa isn't so uncommon to me, at
> > least fedora / rhel as CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y. I highly
> > suspect that's also true to major distros.  Meanwhile all kernel modules
> > use gup..
> > 
> > I'd say we can go ahead and try if we want, but I really don't know why
> > that helps in any form to move it to the callers.. with the risk of
> > breaking someone.
> 
> It's worth the trouble, in order to clear up this historical mess. It's
> helping *future* callers of the API, and future maintenance efforts. Yes
> there is some risk, but it seems very manageable.
> 
> The story of how FOLL_NUMA and FOLL_FORCE became entangled was enlightening,
> by the way, and now that I've read it I don't want to go back. :)

Yeah I fully agree we should hopefully remove the NUMA / FORCE
tangling.. even if we want to revert back to the FOLL_NUMA flag we may want
to not revive that specific part.  I had a feeling that we're all on the
same page there.

It's more about the further step to make FOLL_NUMA opt-in for GUP.

Thanks,

-- 
Peter Xu

