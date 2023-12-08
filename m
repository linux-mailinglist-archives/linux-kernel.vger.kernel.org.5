Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1763F80A49E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjLHNnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjLHNnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:43:14 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58CE1706
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:43:19 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f58040770so11153385a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042999; x=1702647799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aDtOWyPfn3w5tEvf3D6QXjzQ1IFO5OBYuP3/lTcT5U=;
        b=buHJY8oh4o30WT7yJj3SYmfBZOvDI5bJAtBVecTIrLoPix3EQS6TLd1gXN01teIcio
         NCjQFIfykBI1s51YxHg6OmEETgYnJX3Aoju7zvI4WH6d3Ux3tcvZDOqSKQ7Qp5Q8YKPE
         7Ogn9ZGGJ/EWuJcZ4mF0QQg32oJ8eqqhzG5tXyqos+MtDrPIGCwCla7vPR5r1/ADaw+2
         QZRhhCnlNj44IUbA3v9//jeXhlje0UmmgZCWqOCo4nVFWOrCfSsjhBKC7hXVV323YUiw
         Ru1ZjQAYklygru4p0k3i83VP+T0PszDF8Puc+CiZmzEntbA6ER2Exsf7fvyxki938iHK
         iH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042999; x=1702647799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aDtOWyPfn3w5tEvf3D6QXjzQ1IFO5OBYuP3/lTcT5U=;
        b=l7Oywm8liyJWNxaWODhyzE9EGz3t1K6bQUwgXp8nNjkkFiNIU00dMsuqdTL0pQ6z3a
         SlxvLoXRjZ+UU/i+zETndXZiKYArlHI+R26jn/H02+/+Yv1RO/POooeKHdV3zbEdvMER
         F8jeTpSUlP3hA6RY9KyOhelSzuMft3hmkjVbcNxXs8FRm09Uz6cUP0S6wIxjvti9mr0H
         w76uvC1weBseQ07OjJm1kddsKsJBVqTR3+wxp2zC/Gdw+n1xb74NK62RmPxewOcU2Zu4
         FeFQgVT2YhT/E1D77UgV+dl0IoEDnYKoCd3gFU5EGANllcf04sv0Wkeds9g3i/cHzOFJ
         UzKg==
X-Gm-Message-State: AOJu0Yyb75lPnizqiTr5iDYD3DLilFjT22sZ+XtaL96c4nt7JN0DbxLx
        iPynXlJDd227UobQ7aaYdZcifA==
X-Google-Smtp-Source: AGHT+IHv12Tb/0Ej5uN/WlXa3rS44BxBF06RODHchs+ChcBQjqI7N5TgNevBZ3fMHu6sl89MwDK8fg==
X-Received: by 2002:a05:6214:e87:b0:67a:a721:b1be with SMTP id hf7-20020a0562140e8700b0067aa721b1bemr5609000qvb.121.1702042998853;
        Fri, 08 Dec 2023 05:43:18 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id a19-20020a0cefd3000000b0067abb3f1ad0sm804745qvt.92.2023.12.08.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:43:18 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rBb8P-00C89F-TH;
        Fri, 08 Dec 2023 09:43:17 -0400
Date:   Fri, 8 Dec 2023 09:43:17 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Message-ID: <20231208134317.GX1489931@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231201142427.GJ1394392@ziepe.ca>
 <46c80b4e-9f05-4fb2-a31d-7386a41c895a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46c80b4e-9f05-4fb2-a31d-7386a41c895a@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 01:57:26PM +0800, Baolu Lu wrote:
> On 12/1/23 10:24 PM, Jason Gunthorpe wrote:
> > On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> > > Hi folks,
> > > 
> > > This series implements the functionality of delivering IO page faults to
> > > user space through the IOMMUFD framework for nested translation. Nested
> > > translation is a hardware feature that supports two-stage translation
> > > tables for IOMMU. The second-stage translation table is managed by the
> > > host VMM, while the first-stage translation table is owned by user
> > > space. This allows user space to control the IOMMU mappings for its
> > > devices.
> > > 
> > > When an IO page fault occurs on the first-stage translation table, the
> > > IOMMU hardware can deliver the page fault to user space through the
> > > IOMMUFD framework. User space can then handle the page fault and respond
> > > to the device top-down through the IOMMUFD. This allows user space to
> > > implement its own IO page fault handling policies.
> > > 
> > > User space indicates its capability of handling IO page faults by
> > > setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> > > hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> > > for page fault delivery. On a successful return of HWPT allocation, the
> > > user can retrieve and respond to page faults by reading and writing to
> > > the file descriptor (FD) returned in out_fault_fd.
> > 
> > This is probably backwards, userspace should allocate the FD with a
> > dedicated ioctl and provide it during domain allocation.
> 
> Introducing a dedicated fault FD for fault handling seems promising. It
> decouples the fault handling from any specific domain. I suppose we need
> different fault fd for recoverable faults (a.k.a. IO page fault) and
> unrecoverable faults. Do I understand you correctly?

I haven't thought that far ahead :) Once you have a generic fault FD
concept it can be sliced in different ways. If there is a technical
need to seperate recoverable/unrecoverable then the FD flavour should
be specified during FD creation. Otherwise just let userspace do
whatever it wants.

Jason
