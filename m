Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9257C91A5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjJNAD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNADY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:03:24 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B71AD
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:03:23 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-66d03491a1eso13922326d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1697241802; x=1697846602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1pu4GPKVHdVAz2d7eDY4KT/eGDlYfuZ16MfTjdAOYmw=;
        b=C4tk+3Zii0YpapRtGo1cZgPTYyZud3uH9HR7h10Zvn7Obo+1zSxvuetQJXpfutG9r5
         utFM0hyROaue+L6PTixZzZ/0j6PzZK2MZixaccysy08aTrTdEy7435rpOXIgX2jijKVK
         Jv9eBYprSBqygSwxp1oRwtR6RVtGIpsCcusTWdbe5VXju6h8KUeY8lB7jAd502JcRQPo
         mHEbtqQPGHV2UA6RMPXwsosFkHO/DjCdanQZyG+wvVrIAsLA2pPY0GE7CPFWCArGUvg/
         UFB3R5qkuCC0q8dgBuLesj09NhWKrmsODiJzjUfZo5+9iExxeAUJQ2mJ5O179vy4CNy7
         NLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697241802; x=1697846602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pu4GPKVHdVAz2d7eDY4KT/eGDlYfuZ16MfTjdAOYmw=;
        b=UQ9XNqkwnT4GvLXhhfe2TYMHbCQUFSB3Qs9H4cdr5q9kvRZ2mpRBberD/Dg2pVNgAn
         9OQcJfoMNQCsj+AOTUS9VX5EMrtii/2TCUV+waBKKVv8DnvDp6IzTZWvdEO4tGnLe6TZ
         12xpbJ/1thUBI8f/52ZL76C7/28bQ03AzyucWebsgEdTjr5b/7jjnMffnGsuzMDp8KlM
         4V2wtcZaYQ55LVqCjv1835hH2XjrTP3EOpsllFy8HfeJB/oaiH3FI79DvYmKiwNZ+o3f
         1ck5tCqEvwzfj62pLB/jQwxXycG8EwmCBSI3L1bDnOxHa+wKNMFNUnFTy3jQ8NG5+Dnh
         /XUA==
X-Gm-Message-State: AOJu0YytZ8eBR75QzblgXJRVLuET+V/BX25JOHLXd/9qfDAtUM2e5YuS
        pCGDH7DpMylYbd6zD9U9R/elxIcJHEf+qBOPadE=
X-Google-Smtp-Source: AGHT+IFXKpnhZIF3r+jb1/NGjuk/3ZXchiBGhzijmn+1NKrsV3KuT4ItUUZVh6nhRwWutOErHx+78Q==
X-Received: by 2002:a05:6214:cae:b0:66d:1d92:c694 with SMTP id s14-20020a0562140cae00b0066d1d92c694mr6175065qvs.58.1697241802137;
        Fri, 13 Oct 2023 17:03:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a001c00b007756d233fbdsm1058544qki.37.2023.10.13.17.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 17:03:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qrS7k-001Xz2-S8;
        Fri, 13 Oct 2023 21:03:20 -0300
Date:   Fri, 13 Oct 2023 21:03:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <20231014000320.GC282036@ziepe.ca>
References: <20231012030112.82270-1-tina.zhang@intel.com>
 <20231012030112.82270-5-tina.zhang@intel.com>
 <20231012134310.GI55194@ziepe.ca>
 <MW5PR11MB5881ECF6757B0211A18B208C89D2A@MW5PR11MB5881.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5881ECF6757B0211A18B208C89D2A@MW5PR11MB5881.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:57:30AM +0000, Zhang, Tina wrote:
> Hi,
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Thursday, October 12, 2023 9:43 PM
> > To: Zhang, Tina <tina.zhang@intel.com>
> > Cc: Tian, Kevin <kevin.tian@intel.com>; Lu Baolu <baolu.lu@linux.intel.com>;
> > Michael Shavit <mshavit@google.com>; Vasant Hegde
> > <vasant.hegde@amd.com>; Nicolin Chen ^C-cc=iommu @ lists . linux . dev
> > <nicolinc@nvidia.com>; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v7 4/5] iommu: Support mm PASID 1:n with sva domains
> > 
> > On Thu, Oct 12, 2023 at 11:01:11AM +0800, Tina Zhang wrote:
> > 
> > > @@ -1188,15 +1193,26 @@ static inline bool
> > > tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream  #ifdef
> > > CONFIG_IOMMU_SVA  static inline void mm_pasid_init(struct mm_struct
> > > *mm)  {
> > > -	mm->pasid = IOMMU_PASID_INVALID;
> > > +	/*
> > > +	 * During dup_mm(), a new mm will be memcpy'd from an old one
> > and that makes
> > > +	 * the new mm and the old one point to a same iommu_mm
> > instance. When either
> > > +	 * one of the two mms gets released, the iommu_mm instance is
> > freed, leaving
> > > +	 * the other mm running into a use-after-free/double-free problem.
> > To avoid
> > > +	 * the problem, zeroing the iommu_mm pointer of a new mm is
> > needed here.
> > > +	 */
> > > +	mm->iommu_mm = NULL;
> > >  }
> > 
> > newlines after all the }, between functions doesn't checkpatch complain?
> Checked with checkpatch but didn't see any complaining.
> 
> > 
> > IMHO this hunk should be moved to the prior patch.
> In this patch, we switch to use mm->iommu_mm. That's why the iommu_mm initialization is put in this patch.
> 
> I think I met some problem about my mailbox when I was sending this
> new version. It didn't cc iommu@lists.linux.dev. Should I resend
> this version again or reply to the patches with
> iommu@lists.linux.dev cc'd?

Tidy the nits and resend a v8 if addresses got missed

Jason
