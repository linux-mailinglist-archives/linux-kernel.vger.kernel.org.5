Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427D4761A34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjGYNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGYNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:42:04 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560831BF5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:42:02 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d23473ed5so890856d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1690292521; x=1690897321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5RfSsjXK4ByZNd7tHTQgk6HXFLb12v4XnTPRHADBsMs=;
        b=dU/0Xlzj1ZXwEvgiKBrYAiIHXkPLbRvJbmgtblGLQUHSq3/0n9Zobl0S9fVn2w6lx3
         HlG4zVW3A0BDLKIYbok//z+6IjCLYmwydmTOtS6zCHXtD1LheaImuevrdL7Y/U4nuQsF
         xcC0lxTWhN0nRt45ESdyVJ7p1Bhh+YY23LyiXodGZf8Uq1wnoEGXPTTxiRDbqUSVP5Jp
         b3MuBIuKgyOWyV9xLM0PKuBVvRxGBdS2svng3bfCa2Gl6iL17isNWjZeIX2VYzDoCWvT
         4TWGdgFxbu9HgTqlOf493afmjYfPIRaLuo+jsHhIIgHo47prFQrDSpDyfOImI2lGUfDU
         VJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690292521; x=1690897321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RfSsjXK4ByZNd7tHTQgk6HXFLb12v4XnTPRHADBsMs=;
        b=D32JYdcjsZ1LfEK7CGlAKCmq86/WZrZju8LsmAxSWbza0oCwjXJeyZ4KS4RYALwY4X
         jpgXUaafDO/2rpprEEuQ49N4tpM8Cadsk7fYFiRDQnZ9ox3HazjoKqJZ8LRkDFOpVFe1
         gJRmPBa+yldjFLaNkJVezZbrHSO2YGMhRHcjm1IltBL11WWyGGiO7XZmByGP2W+0S7E+
         ZczAyGTPYD0iEyOJ+RAfd9UgWwA/IyMXaRHo7uRGTno+FrYZNSlevZL23meSM2nwKnTG
         v7yPtG9eWK4SqbdPHfwrW1HI4Z/4x/GGSRAeZL8cisxV3WsOoTVtT1hSxsEDkxTsB8w3
         d18A==
X-Gm-Message-State: ABy/qLbml6i8nmiBwK6tfmgM48+c40TnV+eyWtWHSyCQk1ihs+b3Me4n
        QucvxMkq3pezqEC5TKw6JwEy8A==
X-Google-Smtp-Source: APBJJlG8uNdfNlbx0qebAFCgxbApqWAwrST3D3eG8x3M5HnkyY1GsnSGX+ds5MbujsDUIQwmSs76MQ==
X-Received: by 2002:a05:6214:4509:b0:630:1732:7090 with SMTP id oo9-20020a056214450900b0063017327090mr2880389qvb.55.1690292521199;
        Tue, 25 Jul 2023 06:42:01 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id x17-20020a0cb211000000b00635ef3a34ebsm4394045qvd.48.2023.07.25.06.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:42:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qOIIa-000Rca-00;
        Tue, 25 Jul 2023 10:42:00 -0300
Date:   Tue, 25 Jul 2023 10:41:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dawei Li <set_pte_at@outlook.com>
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Change vmid alloc strategy from
 bitmap to ida
Message-ID: <ZL/RJwoJkB3muoTC@ziepe.ca>
References: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB2323E0C525FF9F94E3B07C7ACA35A@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 12:16:21AM +0800, Dawei Li wrote:
> For current implementation of vmid allocation of arm smmu-v3, a per-smmu
> devide bitmap of 64K bits(8K bytes) is allocated on behalf of possible VMID
> range, which is two pages for some architectures. Besides that, its memory
> consumption is 'static', despite of how many VMIDs are allocated actually.

Is there an actual problem here? Allocating a single 8k page at early
boot doesn't seem like a burden? Are there alot of smmu instances?

> So an IDA based implementation is introduced to address this issue, which
> is capable of self-expanding on the actual need of VMID allocation.

However, I agree IDA is just generally better and generally drivers
shouldn't be open coding it

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
