Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9B680894E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441964AbjLGNg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441825AbjLGNg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:36:27 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45846123
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:36:33 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b8903f7192so618414b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701956192; x=1702560992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KwDkkPUreM+kT7f1DugxhqlPlB5ZMWRT1cx42MxAk4I=;
        b=oKnSWm50XyXVjOUDdOeL6MUIyhnylxm0OjgqQD2hCUWdRAOX7sewv6onLTENMUjBQL
         C0C0zoneBNq2X4+VEBTwE0BKtidHUqieDWOOmJg9XAMI3/OwAaQFJfI3oyETZxXSdIld
         0R4bVILx2ME80eni5noDCjZYNMlYICktWQtZIZe03FXc1Ielg6Pt5Za1+pelw3SckCpo
         XhOx+FGEIzxB1Yoip8KPD2WEVn/23zqgAl263TAkwXVTlin9uMxMOznrTv0RLp62Eq0+
         ydPJ+cLM/xf8IlWgie2cSMwE5II+uQEPFDfvXs3tov/THjZfREQiMvzTOEjIdJ+qelMe
         wdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956192; x=1702560992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KwDkkPUreM+kT7f1DugxhqlPlB5ZMWRT1cx42MxAk4I=;
        b=Zc+RRLtmIbaNAGvIHyT4X9xd7wFOezgzX0MogDL9+xxCcc1hNcZToAtc3ICe5Nyniz
         OLwsdeIpBKEmGPpcAgvD/SWIks5joNW4+03jxn1aTQq4L1P9UNoicjd7PF94Y8fys4JK
         DuQYGWZLZhaaXWkIjC+oalCTeDQE5s6ICuvD4grosaIPMV3MXlUYvrJ5kBYj9aWrKwy2
         /uXT9aYOwWotNw0tGQgN0qxuJTsRqtPQis2ni9lOIK75RvX3GNTYxKhB1qICb2TVaS8R
         DtlYTmA7Cyeb8rCdX+i+sj+j1jev/e2GKT1AwGTJSb8EUDTCfEHiT8bjYQVRsl2kEwDT
         rQHA==
X-Gm-Message-State: AOJu0YwTmKgt/gt4o0pUYUro5wOYpPb32SeAlqPUQLDoe3h0LsbIESvZ
        6+kVUCIMXO1Zq/pbkTcIpccaVg==
X-Google-Smtp-Source: AGHT+IH6fAbj16DTLfT8u3PbyCwETOojac9pGddUrlBYHcgsySGBqjGqZwT8hQo4ADzlc4325nrSLg==
X-Received: by 2002:a05:6808:df2:b0:3b8:b063:6675 with SMTP id g50-20020a0568080df200b003b8b0636675mr2155128oic.108.1701956191899;
        Thu, 07 Dec 2023 05:36:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id d2-20020ac851c2000000b0041aff9339a2sm481604qtn.22.2023.12.07.05.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:36:31 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rBEYI-00Bzlz-II;
        Thu, 07 Dec 2023 09:36:30 -0400
Date:   Thu, 7 Dec 2023 09:36:30 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu: Set owner token to sva and nested domains
Message-ID: <20231207133630.GS1489931@ziepe.ca>
References: <20231207021938.306738-1-baolu.lu@linux.intel.com>
 <f1c473f7-ba40-454e-bd3e-a47f6d58513e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1c473f7-ba40-454e-bd3e-a47f6d58513e@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 09:56:10AM +0000, Robin Murphy wrote:
> On 2023-12-07 2:19 am, Lu Baolu wrote:
> > Commit a9c362db3920 ("iommu: Validate that devices match domains") added
> > an owner token to an iommu_domain. This token is checked during domain
> > attachment to RID or PASID through the generic iommu interfaces.
> > 
> > The sva and nested domains are attached to device or PASID through the
> > generic iommu interfaces. Therefore, they require the owner token to be
> > set during allocation. Otherwise, they fail to attach.
> 
> Oops, I missed that iommu_sva_domain_alloc() is a thing - when did we get
> such a confusing proliferation of domain allocation paths? Sigh...

We have alot of different kinds of domains now, APIs that are giant
multiplexers are not good.

What I've been wanting to do for a while is to have the drivers call a
helper to allocate their domain struct and the helper would initialize
the common iommu_domain instead of doing this after the op
returns. This is more typical kernel pattern and avoids some of the
confusion about when struct members are valid or not (notice some of
driver code needs iommu_domain stuff set earlier and we confusingly
initialize things twice :()

> I think we should set the owner generically there, since presumably it's
> being missed for SMMUv3/AMD/etc. SVA domains as well. Nested domains are
> supposed to be OK since both ->domain_alloc_user callsites are covered, or
> is there some other sneaky path I've also missed?

Indeed, I also think the first hunk is not needed, the second hunk was
missed.

Jason
