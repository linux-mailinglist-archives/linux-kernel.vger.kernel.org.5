Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D159793DF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbjIFNob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241198AbjIFNoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:44:30 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B64171D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:44:26 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68cbbff84f6so691453b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694007866; x=1694612666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBTSwwsb/W1c8hHwSDDAKIWq22po1/l3/4/knj00hG0=;
        b=hJzgCk2pPoULmGxAscoXu8C60T+nfjqwyWFUGcTrOlEH+JMeYkjZrnaRc1C2ig+dUg
         dYsajjRSACa4b7wkKj7uxt6D/iOu7oKYvGvwDpoomgaOKTyWf69ClDUfS62WNvkSf0YI
         YLuOPlsR/gwtNTj/bXOcKuI/y+6OPrv4gxZklmM6UKR5BOy46E7tbNfBHG2+2TlKt3MX
         OMvhouBBe902dKxVPNLxepAu+CI76KlohZsO3gh/Tw4TnOG9Pq4Vl1v1OQRX4Xigd7Dc
         c8MB+dTD0ibyAmvBa8Mh6YCwTU+kgSyqjqUrP0i+9/ecoRPkf0AiSrR8A00yc7u+9ZJL
         5gmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007866; x=1694612666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBTSwwsb/W1c8hHwSDDAKIWq22po1/l3/4/knj00hG0=;
        b=jKto9A+XLFoZwwmeBg+JVDJtKs2pSftY6Cv7LSSjwvRTMZy0nlMnrphr6a69hTCQMv
         hNdQRmR0iTQiOJ5a/b4whjhraLrL1y4JP1gQazcUUrCQKSQjsBc0ZkIKUaeIoTM9eV8X
         SOQHRwhKqnYbKZM5vr7N0lirTzKGgVBd6kh3YINW+SchUWCQfCrSbNMzzP8Pyt33RiM2
         cFdAZaHyazXkVNl8gYLMS5XSmjIWOeznEZiov3cciRpRZojChOCNv5pcM/okDAfTA1Sg
         t/tPAt/RAY4cBl3a9AVojPXDGHZYkWeryDzQYaEaWSbcfwVQ3dDIZccQaiF3HtkP0uaa
         wamg==
X-Gm-Message-State: AOJu0Yyj0xssaglcQTPgztup3BYs/UwDXll4QHnyby1hy/ou3FPEitFO
        NXODjgP+AxDBw4FjhJ+mCcu1rov2V8oo0GD02Ss=
X-Google-Smtp-Source: AGHT+IH3auFQXYhq6wffFgeKtTAEUAj64zbzZu/yQwgY50Aarrfn1j2Sjh0CKkMc+Nt5taNEj2Hfpg==
X-Received: by 2002:a05:6a20:2453:b0:13f:b3b4:1986 with SMTP id t19-20020a056a20245300b0013fb3b41986mr18218727pzc.12.1694007865927;
        Wed, 06 Sep 2023 06:44:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id w12-20020a637b0c000000b005651c9351e1sm11055496pgc.64.2023.09.06.06.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:44:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qdspR-000yKq-GK;
        Wed, 06 Sep 2023 10:44:21 -0300
Date:   Wed, 6 Sep 2023 10:44:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jingqi Liu <Jingqi.liu@intel.com>
Cc:     iommu@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: debugfs: Fix race with iommu unmap when
 traversing
Message-ID: <ZPiCNTbGp64MRfhQ@ziepe.ca>
References: <20230903144050.11277-1-Jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903144050.11277-1-Jingqi.liu@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 10:40:50PM +0800, Jingqi Liu wrote:
> When traversing page table, it may race with iommu unmap.
> 
> For the page table page pointed to by a PDPE/PDE, there are three
> scenarios in the iommu unmap path.
> 
>   1) The page has been freed.
> 
>      If the page has a refcount of zero, it has been freed. The
>      debugfs should avoid to traverse it.
> 
>      In the debugfs, the refcount of a page table page is checked
>      before traversing it. If its refcount is zero, the page will not
>      be traversed. If the refcount is not zero, increment its refcount
>      before traversal and decrement its refcount after traversal.

No, you can't do this - the page can have been reallocated already.

A sane design would be to RCU free the page table entries and have
this walker be RCU protected. I think I said that already once..

There is some infrastructure we should build to make this sensible,
but it is the right direction.

Jason
