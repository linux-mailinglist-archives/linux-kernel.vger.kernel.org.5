Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3BD7AB5DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjIVQ10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjIVQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:27:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E218139
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:27:17 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-41517088479so19017201cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695400036; x=1696004836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIMfIRUyRo38QcWwN/NLrw49quL7mRXAZqALVytIzPA=;
        b=i5nSn9YKR26ODxmE/+hLi9NnHD5k20TgFkHbLUnw45XIIYxTDXA8hy/YNkczH5OWa+
         3ZdHVBIfsQ3IzIpiPIZlcd6zprpfYvZZ00i1N+QjFr0JDFFJg4rWe9Qefsyj6Jek0qIC
         uUbfsNltA3ebzxd9l3tGPSoxHn8Vu9lphqObRDDtwuoqd33R4sYEXVi3JviQnQq1Gq/6
         8YiESc76SZpXX4iRK4Kd/rsav2alq3S7Qo42neEgaAColsyc2XzeRt/0pHQN4zSUOGYC
         z8QZgFhqgnVep4MMk9toz0+58iqLQW+ArYoqIUh6jbXQXkssQHvsWnIBCqMqcbS1Q9OW
         J0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400036; x=1696004836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIMfIRUyRo38QcWwN/NLrw49quL7mRXAZqALVytIzPA=;
        b=ZQk4VFtSyPVbL5VrsealhFzRvXA64kmA0dftmABEBCBf41hQ3CziSCfvEYEikWH707
         h0h1U7KHplxbz1kEO1/lis6G0CEoTxidqSibCEKL5BSMTfYspEG1NQeAqiOHaSD+nZkO
         eeXlLI2YDJtkfILJ7nfv0kKsdr7THoEP7nrdh4jDqX41FyekYNlmpkQmX+EKMcOjHgGX
         V6/xkR3Md4ALa2XAjYApOlxoBDChLf9v6AI3h92KkvxCyqjK8TYsPWmAQ3wGnvMynIry
         j5U31FTQtwXNqeYJ/x/Qu+9ujDmRpEpCPwpwB3+au3tLvLPyh8fQUSUU5htPKDi5M7X/
         XO9Q==
X-Gm-Message-State: AOJu0Yy4nPu7mIWUi3y2JYkYW/s3P9MpPvgVzyqoS9medCnAwxO8JWTy
        8juSE4iD8VuZKl0OBY2FQzBHpz5HizuPOFX86ec=
X-Google-Smtp-Source: AGHT+IHrRpYZK6H4zhpjDINCwImDGLSpKzbih7um8bbAruvRPEQN9Wtq+nGMybIYZj0RAXnHk3iVYg==
X-Received: by 2002:ac8:7c56:0:b0:403:a662:a3c1 with SMTP id o22-20020ac87c56000000b00403a662a3c1mr3995742qtv.29.1695400036252;
        Fri, 22 Sep 2023 09:27:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id gb6-20020a05622a598600b004108bebd1fcsm1560682qtb.24.2023.09.22.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:27:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjizq-000aGI-UW;
        Fri, 22 Sep 2023 13:27:14 -0300
Date:   Fri, 22 Sep 2023 13:27:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922162714.GH13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
 <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 02:13:18PM +0100, Robin Murphy wrote:
> On 22/09/2023 1:41 pm, Jason Gunthorpe wrote:
> > On Fri, Sep 22, 2023 at 08:57:19AM +0100, Jean-Philippe Brucker wrote:
> > > > > They're not strictly equivalent: this check works around a temporary issue
> > > > > with the IOMMU core, which calls map/unmap before the domain is
> > > > > finalized.
> > > > 
> > > > Where? The above points to iommu_create_device_direct_mappings() but
> > > > it doesn't because the pgsize_bitmap == 0:
> > > 
> > > __iommu_domain_alloc() sets pgsize_bitmap in this case:
> > > 
> > >          /*
> > >           * If not already set, assume all sizes by default; the driver
> > >           * may override this later
> > >           */
> > >          if (!domain->pgsize_bitmap)
> > >                  domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> > 
> > Dirver's shouldn't do that.
> > 
> > The core code was fixed to try again with mapping reserved regions to
> > support these kinds of drivers.
> 
> This is still the "normal" code path, really; I think it's only AMD that
> started initialising the domain bitmap "early" and warranted making it
> conditional.

My main point was that iommu_create_device_direct_mappings() should
fail for unfinalized domains, setting pgsize_bitmap to allow it to
succeed is not a nice hack, and not necessary now.

What do you think about something like this to replace
iommu_create_device_direct_mappings(), that does enforce things
properly?


static int resv_cmp(void *priv, const struct list_head *llhs,
		    const struct list_head *lrhs)
{
	struct iommu_resv_region *lhs = list_entry(llhs, struct iommu_resv_region, list);
	struct iommu_resv_region *rhs = list_entry(lrhs, struct iommu_resv_region, list);

	if (lhs->start == rhs->start)
		return 0;
	if (lhs->start < rhs->start)
		return -1;
	return 1;
}

static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
					       struct device *dev)
{
	struct iommu_resv_region *entry;
	struct iommu_resv_region *tmp;
	struct list_head mappings;
	struct list_head direct;
	phys_addr_t cur = 0;
	int ret = 0;

	INIT_LIST_HEAD(&mappings);
	INIT_LIST_HEAD(&direct);

	iommu_get_resv_regions(dev, &mappings);

	list_for_each_entry_safe(entry, tmp, &mappings, list) {
		if (entry->type == IOMMU_RESV_DIRECT)
			dev->iommu->require_direct = 1;

		if ((domain->type & __IOMMU_DOMAIN_PAGING) &&
		    (entry->type == IOMMU_RESV_DIRECT ||
		     entry->type == IOMMU_RESV_DIRECT_RELAXABLE)) {
			if (domain->geometry.aperture_start > entry->start ||
			    domain->geometry.aperture_end == 0 ||
			    (domain->geometry.aperture_end - 1) <
				    (entry->start + entry->length - 1)) {
				ret = -EINVAL;
				goto out;
			}
			list_move(&entry->list, &direct);
		}
	}

	if (list_empty(&direct))
		goto out;

	/*
	 * FW can have overlapping ranges, sort the list by start address
	 * and map any duplicated IOVA only once.
	 */
	list_sort(NULL, &direct, resv_cmp);
	list_for_each_entry(entry, &direct, list) {
		phys_addr_t start_pfn = entry->start / PAGE_SIZE;
		phys_addr_t last_pfn =
			(entry->length - 1 + entry->start) / PAGE_SIZE;

		if (start_pfn < cur)
			start_pfn = cur;

		if (start_pfn <= last_pfn) {
			ret = iommu_map(domain, start_pfn * PAGE_SIZE,
					start_pfn * PAGE_SIZE,
					(last_pfn - start_pfn + 1) * PAGE_SIZE,
					entry->prot, GFP_KERNEL);
			if (ret)
				goto out;
			cur = last_pfn + 1;
		}
	}

out:
	list_splice(&direct, &mappings);
	iommu_put_resv_regions(dev, &mappings);

	return ret;
}
