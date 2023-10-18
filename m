Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282D77CEB90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjJRXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJRXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F148114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697670259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gu5mPYKh9dQbGLd+i7tjPbhn1ktXDSWeNhUmcltWWxk=;
        b=bprOxscrAaeydKok1D/1nj00ya0qkpoCU+BXWukgS8oXso6fyCDvAP1RbnIpo4CusVw/j/
        sxg7ZEg8OR0xE1IXqD6lXQbhPdosgkB/Kenu5Gcn6XF9+GFezKPPtvk5dolMYvuEj79uXy
        gb3mBIG3FyjdXVTBfmLQbDpblZhs0UI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-2clCXvV1PtW2BXZoIwPgVg-1; Wed, 18 Oct 2023 19:04:08 -0400
X-MC-Unique: 2clCXvV1PtW2BXZoIwPgVg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-66d12cd3591so65885646d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 16:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670247; x=1698275047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gu5mPYKh9dQbGLd+i7tjPbhn1ktXDSWeNhUmcltWWxk=;
        b=LvOgsnkciFQKlC8MuorhR//3tKoEVCjdj6MYp/x4bDgEJzVn0BhNJPjvKruF/38shC
         00oPtALNudrkv3iIT6QEa1qWPvDiQAyGw9DBObp4QxxT10rsiVVMEhBY5y4Q3hbeUR3r
         CUNyhecclQ+b1x3jh8Y7lQzzFdb2q0Bobg/SOUQflVEYiWV0cz0zqZcXyuDcArIM0/75
         MOoQoZu6KzcZscBu/8ZmPJ3Nn/op2lr3b+gJnqCKOjV0EEnbpC9Yw5apD7aAE69vXCUF
         QdY0ngngu1Hqm6UxRlmn2AImoFiOLB6zKVlQ8ZSLSKC9zzczHj7J+apTsZUpCyHQ2j7v
         HrJA==
X-Gm-Message-State: AOJu0YxfrAers8/UiJgMzdcDODxhPepPGO0hn2h0ZRcVlLfxudckumzI
        lTUTSB6ACpm9/uC8PdpTew0Wi1wR3884RrPdiYPlpppQX35he7d+TREAaLpW38DIh6G0KsXV0Tg
        wshljSKTaIeewHieqNME2xPHrnse3nZLz
X-Received: by 2002:a05:6214:27e8:b0:66d:5ee5:8158 with SMTP id jt8-20020a05621427e800b0066d5ee58158mr601917qvb.55.1697670247594;
        Wed, 18 Oct 2023 16:04:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjeoen4qzTFqffIe4D5jlsyPICKPQ7WSnlA+MDwTRET3suu1ar7hxsRqdxsOSwRRrxd4vQGg==
X-Received: by 2002:a05:6214:27e8:b0:66d:5ee5:8158 with SMTP id jt8-20020a05621427e800b0066d5ee58158mr601903qvb.55.1697670247356;
        Wed, 18 Oct 2023 16:04:07 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ff8-20020a0562140bc800b0064f4e0b2089sm310951qvb.33.2023.10.18.16.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:04:06 -0700 (PDT)
Date:   Wed, 18 Oct 2023 16:04:05 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] iommu: Factor out some helpers
Message-ID: <j42ztri57qkw345hkiwvw64xe36qsxbbayhihfjpmt2qykaowa@kn6uwjio66ou>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <72c599ef84ac29c9759c7f0ecc7bd69fa9aaf5c1.1697047261.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c599ef84ac29c9759c7f0ecc7bd69fa9aaf5c1.1697047261.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:14:48PM +0100, Robin Murphy wrote:
> The pattern for picking the first device out of the group list is
> repeated a few times now, so it's clearly worth factoring out, which
> also helps hide the iommu_group_dev detail from places that don't need
> to know. Similarly, the safety check for dev_iommu_ops() at certain
> public interfaces starts looking a bit repetitive, and might not be
> completely obvious at first glance, so let's factor that out for clarity
> as well, in preparation for more uses of both.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v3: Rename dev_iommu_ops_valid() to reflect what it's actually checking,
>     rather than an implied consequence.
> v4: Rebase, also catch the sneaky one in iommu_get_group_resv_regions()
>     which wasn't the full pattern (but really should be since it guards
>     the dev_iommu_ops() invocation in iommu_get_resv_regions()).
> ---


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

