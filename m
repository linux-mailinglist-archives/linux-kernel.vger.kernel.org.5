Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCC47FF485
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjK3QSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjK3QSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:18:23 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08971A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:18:29 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d811615efeso689533a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701361109; x=1701965909; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f388p6khdEm9IytyNAUyUPfkbdEEtVluUY0RkvUGVFA=;
        b=eTaeiVmZysR6yrLRPBU30yHIUnTgvmkl5CiZG7FpFI6sK8Zv8aWuw/tB0F1uG3zfcj
         PgME4/fl1Br2X1kDZRVOLsBtzKd7lr4k0z7kyn9h7KVpbl/sJ1GF0b9e5gvaIiX9Java
         YJ6EPeEDIb62eTLiuozVL+G074e6zaShT2NPH3mIr1kD97PujBi3oiT9bmjxEK6UZ+IB
         jzCUsRl48e2qbh0ZjxQh/YrHjuKwLy8VtbrHllQJOmPhNLtX+D3HOHZCdfuSihTkzriE
         er0g0FpCmHAllfRdqH9zMR7TJPymrgfCqN0MpiDGiIhPc14WmHE5KVM5UtoWgYME/neG
         9kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701361109; x=1701965909;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f388p6khdEm9IytyNAUyUPfkbdEEtVluUY0RkvUGVFA=;
        b=u5konQ2u8u+jT9milBtJFgBVlAAANVuA4TEXf8aPQGoXRQiHRw9cJcJfp/4zyXB3rC
         7lhq+zteIKutdTnH0NmPSRlNte9/U6WNqePybJNbvhPdVpobwlZIesfXdvWN/ZiRK0EG
         f5vpGKtETkUylNf1kgfaT7FirLXAt+fwkPqJ7ww/aPVO1T2AawCFQAKSACrt7rQqPzb9
         oA/kROzgvcCjpCxPvmXR69XcDFX+4+Ogsye26N+NbFyIlVnuX1cbmD+6ARRixWBK4VJy
         DcahAyI4sTzuDnx/a6TlmrfSV0p4tqNnhUlBJu8mY5d2ku/jjReE2aO4volSXJjAuUfJ
         alZg==
X-Gm-Message-State: AOJu0Ywnq0s3E5DvGaETl8x3vNxMpJcZXe5KAmECAcpS3NXbPTzvrFsA
        3CEMOQ3Uq94lswiQ6qgRKNzSsQ==
X-Google-Smtp-Source: AGHT+IFv7l0L+LFSF+UpdHaHw4IOgcZudH0HKJZBuut8BXVFTzhAcQqpYJkgimrLs127L26mH3dWPg==
X-Received: by 2002:a05:6830:1653:b0:6d8:4d34:4f1a with SMTP id h19-20020a056830165300b006d84d344f1amr13513otr.13.1701361109112;
        Thu, 30 Nov 2023 08:18:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id r14-20020a056830120e00b006ce29a19dcesm198428otp.26.2023.11.30.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:18:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r8jkB-00624i-My;
        Thu, 30 Nov 2023 12:18:27 -0400
Date:   Thu, 30 Nov 2023 12:18:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Disable PCI ATS in legacy passthrough
 mode
Message-ID: <20231130161827.GD1394392@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-3-baolu.lu@linux.intel.com>
 <20231129201324.GL1312390@ziepe.ca>
 <8186755c-fe80-424c-9b50-06ea213b3b17@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8186755c-fe80-424c-9b50-06ea213b3b17@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 01:44:19PM +0800, Baolu Lu wrote:
> On 2023/11/30 4:13, Jason Gunthorpe wrote:
> > On Tue, Nov 14, 2023 at 09:10:35AM +0800, Lu Baolu wrote:
> > > When IOMMU hardware operates in legacy mode, the TT field of the context
> > > entry determines the translation type, with three supported types (Section
> > > 9.3 Context Entry):
> > > 
> > > - DMA translation without device TLB support
> > > - DMA translation with device TLB support
> > > - Passthrough mode with translated and translation requests blocked
> > > 
> > > Device TLB support is absent when hardware is configured in passthrough
> > > mode.
> > > 
> > > Disable the PCI ATS feature when IOMMU is configured for passthrough
> > > translation type in legacy (non-scalable) mode.
> > Oh.. That is the same horrible outcome that ARM has 🙁
> > 
> > The issue is what to do if the RID translation is in identity but a
> > PASID is attached that should be using ATS - eg do you completely
> > loose SVA support if the RID is set to the optimized identity mode?
> 
> This fix only affects the non-scalable mode that doesn't support PASID
>  features.

Ah, OK so it is OK. I'm glad the new mode supports ATS against
passthrough.

Thanks,
Jason
