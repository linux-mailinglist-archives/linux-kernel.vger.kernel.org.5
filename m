Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CD680391A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjLDPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:46:09 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0588B0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:46:15 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77f0e76c948so73314285a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701704775; x=1702309575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8iquwFJQyk71rcAf7xkyhz3akCPnZ/KEnHmlA88vUE=;
        b=GSUQDSm5t8HvtbZvi02K5jNSrBWa7EXWLMTt88RQxn3nfqkKvWqrbMnDPMVh63TSIV
         eChCyvaTYtbgWCaww0/b65ZwY2QcKTK8FQEujdcigBPmRrAKS255b8bOQWrHsA4gAgv6
         8IvPY1jVhq+2DAkbwsZww2RVGkpP/DlkrZPXyWmliGI6Ttc3S+JzxTQGdPu8uCNh7VfL
         r9DWo6SBuvho2npytT0Ps0rLLeUKz+yTMEpHwVTeyC6skSaOa3r/1Hwc1wZh6kMJjisG
         MebYADY5xL32bwjHpUx88YBvBAVX5ZfM0xvDKZK0Hb6AK346EXBNRMKeCEBM19qenGQQ
         dwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704775; x=1702309575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8iquwFJQyk71rcAf7xkyhz3akCPnZ/KEnHmlA88vUE=;
        b=SU7iFQatmNCZoyEMWBi3uWeV6nHgoK3edkj15UAMm7bz3GR/hJ+snxF7iDjGpmCoiW
         LywFKgCddR+6J6D5NZHhyLLc/xeWa9K6QMb3mNsQuWiYWYZgvwmAV1tMZujDER2NDCyg
         g6MaEnYiCT2hYJ/Wb8gKekEdBk4zVT/sbFZTzyh1aVc6WvOQFZvqRI8Jw5yvIzM2TvMl
         +42Bu24gPdAYoJoZOpQBcXRDJM3fy71gaIMd/MlqPFxWXrLOMsLYjdZnvfloMvLq4bN6
         dIuu/DyH/Y/ghPbHmf+9bBrkSPJLFk5QUXCdrNjV6xVWTBcpvhYOlOnbqHajFS3s7+zx
         T6TQ==
X-Gm-Message-State: AOJu0Yy4pEKwlu1UCROsRVghOvpuxWb3erMuggutBGP4kb12y/KgxMCh
        NE7dcSRKwdhh6LgV6wo0a9EMpQ==
X-Google-Smtp-Source: AGHT+IHZ/YjqhcwYOYNjJPJwfMXPr4ZvabEUYITVmxFGu7AYOahIpSZeLYjDRbOsJKMlo5t+5tEaqw==
X-Received: by 2002:ae9:f808:0:b0:77b:d6fe:8412 with SMTP id x8-20020ae9f808000000b0077bd6fe8412mr5286240qkh.38.1701704774948;
        Mon, 04 Dec 2023 07:46:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a159700b0077d749de2a3sm4355611qkk.67.2023.12.04.07.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:46:14 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rAB9C-00B400-1E;
        Mon, 04 Dec 2023 11:46:14 -0400
Date:   Mon, 4 Dec 2023 11:46:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio: account iommu allocations
Message-ID: <20231204154614.GO1489931@ziepe.ca>
References: <20231130200900.2320829-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130200900.2320829-1-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:09:00PM +0000, Pasha Tatashin wrote:
> iommu allocations should be accounted in order to allow admins to
> monitor and limit the amount of iommu memory.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> This patch is spinned of from the series:
>
>https://lore.kernel.org/all/20231128204938.1453583-1-pasha.tatashin@soleen.com

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
