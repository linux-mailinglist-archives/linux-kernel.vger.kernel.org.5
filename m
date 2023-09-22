Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E177AB25B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjIVMnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjIVMnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:43:12 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F394C2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:43:06 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77063481352so166490985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695386585; x=1695991385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJYX5wUywumkDIjBBuCsh0129IAPGx0MBB+MpKbn2U4=;
        b=S/+WhR0EEnJ8PYQjfLxvP/f8zSmaS2TJz8yqoHYbn5vdHZaiYYf26Ob1MkfvPAyqs8
         oFSKekKBQ/mU3IC/CGv2bNtSuI0E2q2cIsp9cQMsQ6VMRcQAOibLdgBphE1cx7ezNubB
         gG5g4o2UxEbb/Rn23c+zj+9JWLw3kA0ubjdblJlIT/+oc+8ECUap29TaOlyzH4Hn59GL
         qBm58FEiOltgDH71IGtrO3xTlLHtMs1e6vZ4PURnJMPpz11XC+hofEdZzWHlu/vmh3oe
         2uIsmQr71MkMohuReFCgLi+L+q+hBH+Zxeh/DwVCHDBlPDWizLecyMlkCZYohhU+cYZS
         K2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695386585; x=1695991385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJYX5wUywumkDIjBBuCsh0129IAPGx0MBB+MpKbn2U4=;
        b=M0O5G45d7EnXmHUZisB6aM6WO0sbkMyGis35Z3ucHMXiI+kaVgXT9NcVbN/R3DFplf
         yb/rteVdeATXCRtpqEX2n8LOgP+7YRJ+7rzFe/tz2sLn3B2mJbcXMM0ogM5Jyxhyve2A
         1wBNiDKJdXWz2uhASFVuhfkyV7UEcdwVbOkCgWQhTBkZMm05hhriBu4Go/rYyzaOzE4M
         BAoYvMSVSjdJ7xUJ0ovzhJYEe5JJuMIrcVK783x8MXaf29OLdWi6dHJsaQBhUNV9no09
         awF1xOMNGPS+ubn77rTNVkoFmmA/pSoH83in/4xvRxtcseqRSkh5E8qHNijZLD2FOOdz
         2nLg==
X-Gm-Message-State: AOJu0YzTBjgye8N5b3Zei3t5YDu7LseXiaCLhXm9TDm5maeK5oufAomh
        WGlt3xvqQ278HmBttWvgaC0pyA==
X-Google-Smtp-Source: AGHT+IHm/qwy9v94zwoSSNba4IDdrqDeA5MFzZIlrmmRnzEbwpTUWaYrkAhTSt+q/0yib09m0ubygQ==
X-Received: by 2002:ad4:5de7:0:b0:656:519c:5a07 with SMTP id jn7-20020ad45de7000000b00656519c5a07mr3118747qvb.25.1695386585198;
        Fri, 22 Sep 2023 05:43:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t15-20020a0cde0f000000b006588f418323sm1396225qvk.64.2023.09.22.05.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:43:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjfUt-000Y5A-VB;
        Fri, 22 Sep 2023 09:43:03 -0300
Date:   Fri, 22 Sep 2023 09:43:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Liu, Jingqi" <jingqi.liu@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] iommu: Make iommu_queue_iopf() more generic
Message-ID: <20230922124303.GE13795@ziepe.ca>
References: <20230914085638.17307-1-baolu.lu@linux.intel.com>
 <20230914085638.17307-10-baolu.lu@linux.intel.com>
 <f20b9e78-3a63-ca3e-6c04-1d80ec857898@intel.com>
 <20230921233402.GC13795@ziepe.ca>
 <e7c773f6-969c-0097-1bca-24d276e8a8f6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e7c773f6-969c-0097-1bca-24d276e8a8f6@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:44:45AM +0800, Baolu Lu wrote:

> > > > @@ -112,6 +110,7 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
> > > >    {
> > > >    	int ret;
> > > >    	struct iopf_group *group;
> > > > +	struct iommu_domain *domain;
> > > >    	struct iopf_fault *iopf, *next;
> > > >    	struct iommu_fault_param *iopf_param;
> > > >    	struct dev_iommu *param = dev->iommu;
> > > > @@ -143,6 +142,19 @@ int iommu_queue_iopf(struct iommu_fault *fault, struct device *dev)
> > > >    		return 0;
> > > >    	}
> > > > +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
> > > > +		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
> > > > +	else
> > > > +		domain = iommu_get_domain_for_dev(dev);
> > > > +
> > > > +	if (!domain || !domain->iopf_handler) {
> > > 
> > > Does it need to check if 'domain' is error ?  Like below:
> > > 
> > >           if (!domain || IS_ERR(domain) || !domain->iopf_handler)
> > 
> > Urk, yes, but not like that
> > 
> > The IF needs to be moved into the else block as each individual
> > function has its own return convention.
> 
> iommu_get_domain_for_dev_pasid() returns an ERR_PTR only if the matching
> domain type is specified (non-zero).
> 
> Adding IS_ERR(domain) in the else block will make the code more
> readable. Alternatively we can put a comment around above code to
> explain that ERR_PTR is not a case here.

You should check it because you'll probably get a static tool
complaint otherwise

Jason
