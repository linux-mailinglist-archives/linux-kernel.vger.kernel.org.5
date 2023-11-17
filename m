Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69067EF377
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346109AbjKQNIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235193AbjKQNIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:08:12 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E031BFF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:07:59 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789a4c01ddso118112485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700226479; x=1700831279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xYJC7txQg+XVy3povoIneigNeaYf7XjMoOZStClkpv8=;
        b=YCnIb/zdoWijRR3fBUtGj+9sINBW+bSCUYMdffeTqROq5nOPKHdyvZrul7F325K7Ti
         aCr6i1V40IMksINrVanBS1eZv9si197uvyPklyGZRNGJNn9zqqxY/tCKdcZif+18gQ5K
         PuBYN/okm1B3xZlsYgj3cwtjLx9Iyn5U91pjp0cuFmrljACmix3CKyv2yqsYK6p/iSZs
         GtAD4hl3arsikyVUY7Hz+qXeZEd9YwQ3qco4ce1m5wA4d3nwCzIbEVFnce1BMKsbWnzP
         MBZ2qT9yPOSVa3hWv3detpLWo/DWuF54QQ5rQvtqUYb4Kzc0Q7GFztr8Pz9fuAR+FWpa
         S99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700226479; x=1700831279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xYJC7txQg+XVy3povoIneigNeaYf7XjMoOZStClkpv8=;
        b=plJePlocyq8Rk//sPAVvDwWrMm0tYB4pN+iuKChbwlUn6ZerexH06hHO3drGzEBXm0
         3W6MrVhrMj+nUxek7ZCYXxbwzfEIx2nvqTL2F/+1tinJQAiyQ8+QU/3zWD/KAslLLea4
         pRMUP+n+YnKnGSs2i5LxJXgCnYv1pFHKRJxtpLpBB2sg59XBe3RMfGtN1C2wyKzOtxuk
         oYIOXEnahUaD6c37TNH9Y/v2KjLb7w+Opp4G1A9TBxYpswM+TIVCSOwe9OIAmnNjkHYi
         GZGDelvswsiXdHBu6T/w+zlXJ5BxvRXrRHMonbRd8p/+v8PxB6PYyPlvWau5/pFiOekh
         nsaA==
X-Gm-Message-State: AOJu0YwjoFnSOppg3oQZdca+5017+f6Rv8EOauGvfjmH02Bdftefslgt
        koE1R4GkESfDkAQDBiJuvrEoeg==
X-Google-Smtp-Source: AGHT+IHGV9/z04xgmmPRcNGEMI55AbHf/lPg7kWBwBZVnpSAw4YdYeqeoXjjPc5CcSIbzcPMeEbOXQ==
X-Received: by 2002:a05:620a:4104:b0:77a:5493:8a3 with SMTP id j4-20020a05620a410400b0077a549308a3mr14826885qko.11.1700226478437;
        Fri, 17 Nov 2023 05:07:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id az44-20020a05620a172c00b00777611164c5sm577475qkb.106.2023.11.17.05.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 05:07:57 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r3yZg-0001hp-Th;
        Fri, 17 Nov 2023 09:07:56 -0400
Date:   Fri, 17 Nov 2023 09:07:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iommu/vt-d: Introduce dev_to_iommu()
Message-ID: <20231117130756.GA6501@ziepe.ca>
References: <20231116015048.29675-1-baolu.lu@linux.intel.com>
 <20231116015048.29675-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276CF0833BF362C1BE5F2268CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <053e89dd-8de9-43f3-8530-1f65181efd46@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053e89dd-8de9-43f3-8530-1f65181efd46@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:23:56AM +0800, Baolu Lu wrote:
> On 11/16/23 11:19 AM, Tian, Kevin wrote:
> > > From: Lu Baolu <baolu.lu@linux.intel.com>
> > > Sent: Thursday, November 16, 2023 9:51 AM
> > > 
> > > +static inline struct intel_iommu *dev_to_iommu(struct device *dev)
> > > +{
> > > +	/*
> > > +	 * Assume that valid per-device iommu structure must be installed
> > > +	 * if iommu_probe_device() has succeeded. This helper could only
> > > +	 * be used after device is probed.
> > > +	 */
> > > +	return ((struct device_domain_info *)dev_iommu_priv_get(dev))-
> > > > iommu;
> > > +}
> > 
> > Not sure whether this helper is useful. This is only used by 2 out of 5
> > post-probe users. Probably just open-coding in all 5 places is clearer.
> 
> I thought it should get more users in the future development.

The pattern in the SMMUv2 driver is like

  struct device_domain_info *info = dev_iommu_priv_get(dev);
  struct intel_iommu *iommu = info->iommu;

Which really isn't worth the helper, unless you have lots of caes
where info isn't needed at all?

Jason
