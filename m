Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DA780EFED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376641AbjLLPSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376637AbjLLPSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:18:45 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E87F3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:18:51 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77f50307a1fso276246485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702394330; x=1702999130; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J0E2muSgNl3hAqEUv0GBJG6tt73IDHG5CgFbhTFcMw=;
        b=EhSgBEPXUEmUfrqxO2ccPwp8Q7ITnt4Movuvomz99HzoJsC7z1jk1gAosktoqh2qns
         81Hg+XMslyR/+gJ61sxx8Q451lItJDfF3Os1DHM8TGKOFkXmLye6k93bFLWwmu3a58Da
         R4H20bS+qHAkWXx/SP43rq4lA1cuSnR40DZfoZ5kGEx6/uY2tm7M8UEx/TrVdhY/2DCP
         ZzNMom1MtTnYG7ow9VONdRCDAICkG+cWKa6y4SgCVU8hzrYga50M+79iOTGwBmacrbJ9
         hbg7XBhNz+nXaire2bWzxXfoRhTHuTCR2yADV8M8x9Fkc644DbPdoUpEX39T92kDdWKV
         K5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394330; x=1702999130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1J0E2muSgNl3hAqEUv0GBJG6tt73IDHG5CgFbhTFcMw=;
        b=W0/P0NQVcAKPrlEaV5dqiHwD2FpApPpGfrAkMx6cKft2oMDB/gxu9C4lS1b3CxoOr/
         ZKWWrxjTEGsSuxJ2HHwhSTP+Cq3KPjOp4Ftb7oh1+LDi17yRAIxVh+eMYe6GJiull7fk
         uzL1xgx740ChQF+r8dDQQh/681ndyYkfLmRUEj+Dq4DyBdv5kAInzDf2rmdhRhI4+H4B
         yg/TMUiTak0yKt3c2keCyW/aXyLz0SJrFTxkDUr2hCoT5JLbHQrx/6YEC4ZvFBFztCE0
         ZBKtKa2nO9AWpfHOVu40AHBRvTQtuME8J+tIl3GRFG9xRUw7FzfbBfEuP0SQ5Y6lKboL
         +cLg==
X-Gm-Message-State: AOJu0YxcoNpOlMS3R2KFrc3ttLCShUGbh5QOKBvH5G4v3HJe9PBogBl2
        FFPY4n6R4NI7FLWuZoy/AhPASQ==
X-Google-Smtp-Source: AGHT+IFq3Ckq2KVmneMTzmQ2mKKjd0RAxPdbXcCdtNxUscr3KZI+A2xNjS/BTczw0TiEfU7gwIenjQ==
X-Received: by 2002:a05:620a:27c9:b0:77e:fba3:9d05 with SMTP id i9-20020a05620a27c900b0077efba39d05mr7703626qkp.105.1702394330403;
        Tue, 12 Dec 2023 07:18:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a148500b0077d65ef6ca9sm3745656qkj.136.2023.12.12.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:18:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rD4X3-00Ck2z-Fd;
        Tue, 12 Dec 2023 11:18:49 -0400
Date:   Tue, 12 Dec 2023 11:18:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231212151849.GE3013885@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211151235.GA1489931@ziepe.ca>
 <62131360-e270-4ea5-92cb-8dd790be8779@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62131360-e270-4ea5-92cb-8dd790be8779@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:44:14AM +0800, Baolu Lu wrote:
> > @@ -210,7 +211,8 @@ struct iommu_domain {
> >   	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
> >   	struct iommu_domain_geometry geometry;
> >   	struct iommu_dma_cookie *iova_cookie;
> > -	int (*iopf_handler)(struct iopf_group *group);
> > +	int (*iopf_handler)(struct iommu_fault_param *fault_param,
> > +			    struct iopf_group *group);
> 
> How about folding fault_param into iopf_group?
> 
> iopf_group is the central data around a iopf handling. The iopf_group
> holds the reference count of the device's fault parameter structure
> throughout its entire lifecycle.

Yeah, I think that is the right thing to do

Jason
