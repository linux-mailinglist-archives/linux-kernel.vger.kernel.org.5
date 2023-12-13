Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC96F8112A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379187AbjLMNT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:19:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379161AbjLMNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:19:58 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442EEDB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:20:01 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-67efcd76510so2519666d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702473600; x=1703078400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pL0YocGPkvVGqiCu9lyP3UNNLSGUFRW6Fi4cZBlmelc=;
        b=Ty6/fWwakmjqjEpHQqfxB2Mq73EW/81SImG5hqSm7b2MVN9dGFCTCR6N35x3yKTjs6
         jF6k7nGuq1DMl3MJ7m6x7EyJpah0606ssKN07cUva+m+rm7b+NThYjSQvvJggsv/NoIf
         xMcdpEaRMZbyWPJcCnsiyI2eSH+id2ui+7ROPoQ8gvOy35ceIl9MbL807GadMJDWnOr5
         zizOgEjwM9U8GnzPjCQMhu0ySduBGarEEDbzim00Z1jlZf5p/XfDE0IxNMqFb65BrfbA
         Hq2w6VrlMNaSCJb7wCxInbrO9cd4AKleGXExKgyg95unz8ymM5lC5gU5jTJ9M2tCBgFV
         KBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702473600; x=1703078400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL0YocGPkvVGqiCu9lyP3UNNLSGUFRW6Fi4cZBlmelc=;
        b=lvnCENBQ423/ujAoGm+gQPPvn8TMIZqjAAml7gFnbZehM13+LEVlw6pSlXWJkBkxZI
         BEQpO5f5qBEFwQQ3zpfHHu/LJ6DQ75NG5Q0gAu6PyeyHn+NKwdB+70QHFdpLUI189QNs
         gzfxXNeVmD09sWe0LqBCMiNU36lcgeGwf695XYLI364qIW/xau1QFkhcEWtdAlVWfH8t
         w1k6F1CDMKdVTu0hKVZwEDKaO/O5Nmrfp9zTR7ZIYb+9kyknyUh3KxBKO8TmRYaQu6jm
         WjyyuLCO4gbthou0fbg4PvPn/6itLr+jQwAj5hQJ5T8dczCOwTpEATGyWNBA0SJJLTUM
         W2vw==
X-Gm-Message-State: AOJu0YyiNej2i/Wt+twRvdRsbhD47BQ+S4HZI9AuMr4eFzv+VwnH1D0+
        So0pLRmvJlX8KLx/CQ146VWWBA==
X-Google-Smtp-Source: AGHT+IHBRIb2molU2pUmRSk3m8apIaaHB6x4+xMRVsRdDRSbKUM6I3jsw6DfyySmptvv5fd5r5efyw==
X-Received: by 2002:a05:6214:9d3:b0:67e:f7f2:2ba5 with SMTP id dp19-20020a05621409d300b0067ef7f22ba5mr1223954qvb.85.1702473600381;
        Wed, 13 Dec 2023 05:20:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id ov11-20020a05620a628b00b0077d7e9a134bsm4481925qkn.129.2023.12.13.05.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 05:19:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rDP9a-00Dftf-PX;
        Wed, 13 Dec 2023 09:19:58 -0400
Date:   Wed, 13 Dec 2023 09:19:58 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joel Granados <j.granados@samsung.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Message-ID: <20231213131958.GF3013885@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
 <20231212141208.GA3013885@ziepe.ca>
 <276597d0-9947-44f1-a6b9-16d245394b22@linux.intel.com>
 <BN9PR11MB52761698732F1899E65DE5A38C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52761698732F1899E65DE5A38C8DA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 02:15:28AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, December 13, 2023 10:05 AM
> > >
> > >> 2. This is not intended to work only with idxd and uacce. right?
> > > It should work everywhere, I suspect Intel Team didn't hit this
> > > because they are testing IDXD SIOV?
> > 
> > Yes.
> > 
> > > Can you guys also test it as a PF
> > > assignment?
> > 
> > For PF assignment, probably the driver (vfio-pci) needs to enable iopf.
> > 
> 
> We haven't merged anything for SIOV yet.
> 
> so the base of this series should be PCI functions (PF or VF) and vfio-pci
> has to be extended with whatever required to support iopf.

Right. I suggest you target full idxd device assignment to a guest
with working PRI/etc as a validation.

Jason
