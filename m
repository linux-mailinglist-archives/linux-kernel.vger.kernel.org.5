Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCB6800D17
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379165AbjLAOYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbjLAOYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:24:23 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844B910F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 06:24:29 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77dccb3e4baso116421185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 06:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701440668; x=1702045468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBsvr3M7y7nivS2i0Ob2cINhbfVirpoyS0qfXlH/VdM=;
        b=lJrLG8qLCH75Njz6LiPzicDKXddlkerBMgdC1KrdE9grFXInDpr2+DLjkvWUgJ2pxh
         GT+OPqP4nP3gdWevqj9qqIaOySE05d2E9+ZODJu7GmTkUoX/y4SSH1Lp9OzSO7IgRCTn
         DLtWXmYG5Xa4YFTCs29BHVwHfmpyTbhn2CeeAT0I2ApXkDbmaDET4CI4pI6NLZMQ2A0a
         qvd9XiYEZm64jpHSegtX/Qasj6/xwasATwBmPF3mdUj5IjNLDgyJOrxLh+TOt9w68btU
         aCxchV+OPYXQZM9t6+AL2+SSTBjdpUpIKCcwOqjF6sxmesX35PLoxyq9yz8+r1vYr5kW
         J8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701440668; x=1702045468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBsvr3M7y7nivS2i0Ob2cINhbfVirpoyS0qfXlH/VdM=;
        b=kp5RDNTXW4hqiAIdDxlG7h29oJqN3AeiAzWtf1V5z0vK+bRhIICSglmr+ntRI/UHl1
         lDGFJAth2P2wAlOhYPW8QQI2qqjkP7hvLhxh8fJXl8/GAzAOd2yr6V+6UsrjYh+Ajdw5
         bM6H8r8mcjo1vNPTQE3uwMqpUdo30rgLHdH/BsewVqW+6Cx7ZWgZzrZxk+al4VrRbJSQ
         BMMbw9HkAPQo9d0ibhAoUsm2cJf5V26AWyBZZQbLFdUYE7//3XSL0lOsKlZ7xbOXsdHe
         wABVvSstrvo7aNoK0CKnqZKcsu796QLR8PllY/qq9IZFhwUJQJOsImHX3VcRoNU3xAW5
         BZ1Q==
X-Gm-Message-State: AOJu0YwaD61kvpV2aKri7ePIknFB5/I4Tzhv1DQ10ds+yepzZq7V6nMe
        a8qGdeiuqC0arZurQC4nhAYHWdaJDnKm2plVtoA=
X-Google-Smtp-Source: AGHT+IFhbf0pnfqRmkrdAgeW6divQjwDnNZXsygeLqQa4cWucFhgEwsEVMG94jE+nlw/p5nE/n3K4A==
X-Received: by 2002:a05:620a:1daa:b0:779:deb9:72c6 with SMTP id pj42-20020a05620a1daa00b00779deb972c6mr24340270qkn.14.1701440668556;
        Fri, 01 Dec 2023 06:24:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a122f00b0077d606bec92sm1519643qkj.108.2023.12.01.06.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:24:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r94RP-006FTp-4e;
        Fri, 01 Dec 2023 10:24:27 -0400
Date:   Fri, 1 Dec 2023 10:24:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
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
Message-ID: <20231201142427.GJ1394392@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026024930.382898-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
> Hi folks,
> 
> This series implements the functionality of delivering IO page faults to
> user space through the IOMMUFD framework for nested translation. Nested
> translation is a hardware feature that supports two-stage translation
> tables for IOMMU. The second-stage translation table is managed by the
> host VMM, while the first-stage translation table is owned by user
> space. This allows user space to control the IOMMU mappings for its
> devices.
> 
> When an IO page fault occurs on the first-stage translation table, the
> IOMMU hardware can deliver the page fault to user space through the
> IOMMUFD framework. User space can then handle the page fault and respond
> to the device top-down through the IOMMUFD. This allows user space to
> implement its own IO page fault handling policies.
> 
> User space indicates its capability of handling IO page faults by
> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
> for page fault delivery. On a successful return of HWPT allocation, the
> user can retrieve and respond to page faults by reading and writing to
> the file descriptor (FD) returned in out_fault_fd.

This is probably backwards, userspace should allocate the FD with a
dedicated ioctl and provide it during domain allocation.

If the userspace wants a fd per domain then it should do that. If it
wants to share fds between domains that should work too.

Jason
