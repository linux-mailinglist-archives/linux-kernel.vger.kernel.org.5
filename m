Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DC7FC137
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbjK1OfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbjK1OfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:35:04 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA08A18D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:35:10 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b5714439b3so2695687b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701182110; x=1701786910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mU0p6xbpFTkyXWGjYVAfm5sm2ySxTisEI49QmB0GvUc=;
        b=hOiGLRDcgVEooWxK05RJriPyfNoByBeF07a8RKbWpZe46og4WdCniAs5qyauKOastH
         Kc2sZK/fFSbjiJsptKX/Mo2R9lB3vJKvY09pRGscOzGt5zEkjJvYBjWgcvFsV4IgqpGs
         I5AsOW92WvGKwHH5kCCi7ZGXBCFphPZHdOPd7ZPHsOPaXxVkhxFAm92krtLkaWJeJJ5R
         ZUtN+shGqMLRdCmGoULJ9/nMl+UWzebtwH2ApQNSSE5JdvtmApirb9ScGRK4eEiU6Ci5
         0XnoFdb30qMNOU41TfOiURRoY03RaAUnuzHUHPw6eB///W0vab9tR1D4cS/o22/U7ah5
         Ofng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701182110; x=1701786910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU0p6xbpFTkyXWGjYVAfm5sm2ySxTisEI49QmB0GvUc=;
        b=RTQpsM5stFZkR+OLnp8f5srJZLlujZkJ+9uR8fdPxJxMAan812thbYQsOepx52qg6S
         bAQoCZhvtYTRDBUHUMnQKufBeSIF1xCa0zQMCy4XmVZ4vlsHrYn5p7ikhbsApTij+0qM
         jfSWWiXr17PJj9HlpKD07qfuc8PLjhATB7h7B40Mgx/4Bl98Ejvj2Ed8MJGklwP1qcoT
         +8DFcdtcXiZnBC0JyXQe4/kK6GdRtbU/jwNFfr7YlXIh0Q8q2diEBsA5WbALs0miwh5+
         K/RpLqDi/yikR6RxcZ861LzD7ujYxYKCFnGWHH8oFDFMss6P2nhoeTkx6mIUsyORQMYe
         vHDg==
X-Gm-Message-State: AOJu0YwMgCZ7OBYr4q5S8KXEzMYMcCJqusSzxvMsNtFMYLaaVmsqU4EG
        RISLgMNX/DjyRauKNAtcIV1XAA==
X-Google-Smtp-Source: AGHT+IFm85sCZM9GYbWWTfuyl1YQC+tIFaoEBfBmtndKobcL5DQyqd+aQPTs84SPfYUybfqBkHyxrg==
X-Received: by 2002:a05:6870:be8b:b0:1ea:2447:5181 with SMTP id nx11-20020a056870be8b00b001ea24475181mr18982913oab.9.1701182110147;
        Tue, 28 Nov 2023 06:35:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id sc14-20020a056871220e00b001fa8e52eb41sm111367oab.25.2023.11.28.06.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 06:35:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r7zB6-00506g-UN;
        Tue, 28 Nov 2023 10:35:08 -0400
Date:   Tue, 28 Nov 2023 10:35:08 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, kevin.tian@intel.com, will@kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommufd/selftest: Use normal IOMMU registration
Message-ID: <20231128143508.GG432016@ziepe.ca>
References: <cover.1701165201.git.robin.murphy@arm.com>
 <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ee6854da69e86b208f49752f60a4c18205c32a.1701165201.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 10:42:12AM +0000, Robin Murphy wrote:
> The IOMMU core now supports coexistence of fwspec-based drivers, which
> the mock driver now is, so let's bring the mock bus into iommu_buses,
> drop the special interface, and use the normal registration flow. The
> one concession we have to make is to ensure that the mock bus is
> registered early enough so that bus_for_each_dev() doesn't error out
> for other IOMMU drivers registering before iommufd_test_init() runs.

This makes iommufd non-modular which becomes a total PITA for development :(

Jason
