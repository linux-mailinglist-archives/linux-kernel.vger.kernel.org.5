Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3EF78FF04
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349976AbjIAO0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjIAO0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:26:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F18810EC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 07:26:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68a56401c12so1686000b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693578400; x=1694183200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OIjtyLHq79VQ/5r2FFEDeS8KAjlFgkhGZiLhwOfElgI=;
        b=IwS+U3qRgpdbb9lpi7C5p4oz8bwOdyfqPgVUexXMd1xfxC9wNA3JAfIh13ZQjsWve+
         pxfj9BDhFciyg7xO5YcNQValJ5O5GdqdmTYCXt72rbklpS0c0MAivZB3hU22Tc398/AB
         pt0ynHpHxzYvICpRKk19ymhYh0WRq9zoIjL6IZr6pErt5fNPfe/n6LHxzv/jXGF79mR+
         6GF1LxTvUY3aTd14Ui+5jRoWVf/wb05UGtQIMIyh8xQmphGvYU7ZdxH8Remj43zyjb2e
         I7fUbKZE/3F4FzzkN9VfTlfiAHcIErlaUNwza8x8W5Gdij/ZG045nyIWw3fdzcHhKUvf
         oQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693578400; x=1694183200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIjtyLHq79VQ/5r2FFEDeS8KAjlFgkhGZiLhwOfElgI=;
        b=CE2H8ahqQqVF4wiaFAfvpsracmFNUjA6r8qBPbO9x7EeZdWzwQQ4aDQ9I2f//x5c1m
         7Xr7kYA/62CpPGpolslJNaIiTx4hOa/TrbjtPZkkvCBT4L1+nVvuBAnXMeXIRoct7p2N
         AkPR3sOAoE2O+N5/coa+MkgzNmV1H9AGHHhFk3rTjNMG8rWVwyvpJoIAGEx5MMbp8F0I
         c7L8pXk4diSAWp4vgwjjDbR+Wk40i2ZcfY/VNuCoZVz83D0WO/owpSC/kLcGJ3DtnAwK
         HnJlXWnfGAQWtpmR+H08QxQfvzqLXhXfJ3AjC3cIcafZRVQBUY1hLFd+zMd7u9IgHknq
         emxA==
X-Gm-Message-State: AOJu0YzHNM2wVNKsl/ss4GwAAzTRWZ9zBW1iv2gIl8U3LiQnMYTkQFkK
        OHGEkXPblmUa/PmvlF7hPChYkQ==
X-Google-Smtp-Source: AGHT+IHPsYhe8Nmk9uWjMLuOWHJ8zGuVcKlfSoIXtHKELkiGxjjYs/IEhG4MFhwheaNap4ykm85/iA==
X-Received: by 2002:a05:6a00:1807:b0:68a:582b:44c4 with SMTP id y7-20020a056a00180700b0068a582b44c4mr3399164pfa.3.1693578399601;
        Fri, 01 Sep 2023 07:26:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id c10-20020a62e80a000000b0064fde7ae1ffsm3010466pfi.38.2023.09.01.07.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 07:26:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qc56b-000WTO-8v;
        Fri, 01 Sep 2023 11:26:37 -0300
Date:   Fri, 1 Sep 2023 11:26:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Anle Pan <anle.pan@nxp.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, hui.fang@nxp.com
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
Message-ID: <ZPH0nZ+j639oZGK1@ziepe.ca>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
 <20230829150442.GA3929@lst.de>
 <CAAFQd5CiHXvsJugSi+hXY9ESsmxUzBzmbhF6G48iVsOcL5eMtQ@mail.gmail.com>
 <20230830143341.GA25574@lst.de>
 <ZO9xzf727b/YvZB/@ziepe.ca>
 <20230831123532.GA11156@lst.de>
 <ZPCylmcRD0hwluZf@ziepe.ca>
 <20230901061014.GA32166@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901061014.GA32166@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 08:10:14AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 31, 2023 at 12:32:38PM -0300, Jason Gunthorpe wrote:
> > The entry is variable sized, so it depends on what is stuffed in
> > it. For alot of common use cases, especially RDMA page lists, it will
> > be able to use an 8 byte entry. This is pretty much the most space
> > efficient it could be.
> 
> How do you get away with a 8 byte entry for addr+len?

It's a compression. The basic base/length/flags has alot of zero bits
in common cases.

I was drafting:

 2 bits for 'encoding == 8 bytes'
 2 bits for flags
 28 bits for length
 32 bits for address >> 12

So if the range has zero bits in the right places then it fits in
8 bytes.

Otherwise the compressor will choose a 16 byte entry:

 2 bits for 'encoding == 16 bytes'
 2 bits for flags
 36 bits for length
 64 bits for address
 24 bits for offset

And a 24 byte entry with 36 bits of flags and no limitations.

So we can store anything, but common cases of page lists will use only
8 bytes/entry.

This is a classical compression trade off, better space efficiency for
long term storage, worse iteration efficiency.

> > With your direction I felt we could safely keep bio as it is and
> > cheaply make a fast DMA mapper for it. Provide something like this as
> > the 'kitchen sink' version for dmabuf/rdma/etc that are a little
> > different.
> 
> So for the first version I see no need to change the bio_vec
> representation as part of this project, 

Right

> but at the same time the bio_vec representation causes problems for
> other reasons.  So I want to change it anyway.

I don't feel competent in this area, so I'm not sure what this will be.

I was hoping to come with some data and benchmarks and we consider
options. The appeal of smaller long term memory footprint for the RDMA
use case is interesting enough to look at it.

Jason
