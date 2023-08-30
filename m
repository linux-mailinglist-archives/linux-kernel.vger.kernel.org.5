Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCF378E0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjH3UiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbjH3UiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:38:01 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A559F7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:37:30 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76d80d35762so7091485a.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693427783; x=1694032583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9olKQHKl7i+BW/Fox3jX2swhAkTGXKGKjmjdi6zQOQ=;
        b=iEbvh5rmlXtRk2WfXULEeyKAIyu1q5dBvl+L//yKJt1lVNRcanTm0Dw0h2H2UZbTu7
         tCe1C3LFAOo6cudhqmkmmYFZ1GaLxs0yM3v+dXQtzLGEHfjMpEudDg4SpiEmMBLrcb0E
         aoaD3msUu86WKs4SyVUeV5TPPnWCP1BYE2KMXNpjDI7+Xmzrwg0YpQekRKFnyg7CYg8l
         Oy+Uj44Zyzo7y61l3+yqPHwoP51paOboY8UECqwmq+/iqae2+B53i88QOAhIHVVVlCPJ
         Mi/uSe0JSrWg481BBXNKaExZoRmAcVB0OmZAB3mENEFeLzfhxzzucOOnRgjqzY6IIKGm
         yYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427783; x=1694032583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9olKQHKl7i+BW/Fox3jX2swhAkTGXKGKjmjdi6zQOQ=;
        b=gUQyUuF9OyXiYs1m0e0og1AED//FmiVNX1UNgTb2vbp7EnmVY3gwlAQj5TdKzkZBnN
         dH7VQvscZLXAE4jUPE9UgxZFzcXUjP9ViHFDk0PZ6FzFU+58bMXJmoaYwBbv0gSlyXuA
         1qxEmhlunBfVn61fXCKWuworQGWDg+htNQIztEt+BzgMtfb7jm0iYsEZR4s9oDRItXvw
         K2RwXg2w91MXMzK53Y4mAmL+lq2Uk0Hqp2z3bzy+OhfqTpxtlj5bzGfJBGz+8AX4U/7q
         3O0M2wtcWJhxfY3p1xiLeTmnaw4P9MrtJ5ti0rEHux3AC3gPmrc0y3WOG97UGoKsWSbA
         /XsA==
X-Gm-Message-State: AOJu0Yx5psCFwBHtgGy52rjsmFfWSHqNWZPy2PZx/Jdjbz7hePTDRVdg
        2ymDi4/Myj9+JYcA2cUIoHUQKg==
X-Google-Smtp-Source: AGHT+IGF4MU0rD+iQwT0aCopRevdjBpeHCOTE0yYV5wWvsuXnz48NfHVfNaBhCyzBhEFTczQi1j9zA==
X-Received: by 2002:a05:620a:3727:b0:768:1572:e9af with SMTP id de39-20020a05620a372700b007681572e9afmr1073374qkb.8.1693427783197;
        Wed, 30 Aug 2023 13:36:23 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id pj37-20020a05620a1da500b0076da620166bsm3998312qkn.103.2023.08.30.13.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:36:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qbRvI-000DB0-Qb;
        Wed, 30 Aug 2023 17:36:20 -0300
Date:   Wed, 30 Aug 2023 17:36:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vasant Hegde <vasant.hegde@amd.com>
Cc:     Tina Zhang <tina.zhang@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Message-ID: <ZO+oRPOf9jyNG2+B@ziepe.ca>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:02:52PM +0530, Vasant Hegde wrote:

> I am not sure whether I understood the flow completely. Just wondering why you
> are not freeing pasid in iommu_sva_unbind_device().
> I mean once iommu_mm->sva_domains becomes free shouldn't we free the
> iommu_mm->pasid?

No, for Intel use cases that PASID permanently becomes part of the
ENQCMD MSR and cannot be revoked once it has been set
 
> Also in this function (mm_pasid_drop()), should we check/free sva domains?

No, the driver must support a SVA domain with an empty mm_struct, eg
by hooking release.

Jason
