Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A783177FC43
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353703AbjHQQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352313AbjHQQku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1812D50
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692290398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OM71pDKm3gUMSnzcjBWfpHVt999F5DyS5/mU42PgQHk=;
        b=Cl1xU9giPShyy/fQWa5ev5SiY5GCC1Ht9/RKXQmRWop888wcWLIhSLlbqx+rsHUNUD9MeN
        JeKvk8wPJaiFnvTL1QdT/kJ0dC/uP8QA+pjts9Idt78/TCU7IWXsdBLCrQSkY7mmA5X4TW
        kx1fJaZ8/H5LPuKSY57KxoJm6re6ZHo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-2AGiK6jUNnCbG8P83TsXSw-1; Thu, 17 Aug 2023 12:39:57 -0400
X-MC-Unique: 2AGiK6jUNnCbG8P83TsXSw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cd1ea05d7so9966856d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:39:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692290396; x=1692895196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM71pDKm3gUMSnzcjBWfpHVt999F5DyS5/mU42PgQHk=;
        b=P5r3++qnoQ6YW9E416fgrrzPGB2JHP5GhpxXaK2lGHKpcVQ8WZXe9kOHpuMBBJ74nC
         QnZ9RHudR+MUd/YU9KttKhBDkcUubghoDWi1KNl7tvIbhvXqqVgvKVWgWPm+BXTMGlzu
         ZHpifAPNvzwWiMqOk5FYzKE+1v4X+6DnoDCcv5m6MEP1PXzcqJUezBsvXlK8VJQReMkT
         zL7y7cRjIEZn9Ua8xEFwqLGti0fjMmpxkePHp0FGMb7FMVtBc3j1LQSg6CiLwNQP1sMn
         xKBI4wWxEwvF9xVzTO4kwNWalMo8S+snzl+q15m6hmGUb2ILoctCtlrA3+EFQzFQgeiO
         Yzkw==
X-Gm-Message-State: AOJu0YzZLIsINV6xDVoAGp5lDfeNYzx7KRTQN2cccDXq9UgheWAgmcRq
        aRu3qwCN7RltjxDIqbyCKq8+/6iytjYca8yjAtL4hhKoJVfQ/F8rSALva7IwmpBxByxqxeQXQUQ
        STkP1u2RqfGshEkNoOG3aeF+C2gSJRL6w
X-Received: by 2002:a0c:cb92:0:b0:62d:f04b:b51 with SMTP id p18-20020a0ccb92000000b0062df04b0b51mr4116755qvk.29.1692290396324;
        Thu, 17 Aug 2023 09:39:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rGMZwPKCKJSH1ZDrAWfDCPAs9BnwaKyJVZAo1qe/UyCfHW0hud9nYbZTP9JZIRVv6URdXw==
X-Received: by 2002:a0c:cb92:0:b0:62d:f04b:b51 with SMTP id p18-20020a0ccb92000000b0062df04b0b51mr4116728qvk.29.1692290396061;
        Thu, 17 Aug 2023 09:39:56 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id y3-20020a0cd983000000b0062ffbf23c22sm5772806qvj.131.2023.08.17.09.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 09:39:55 -0700 (PDT)
Date:   Thu, 17 Aug 2023 09:39:54 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, john.g.garry@oracle.com,
        zhangzekun11@huawei.com
Subject: Re: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
Message-ID: <ychdxbopmzkdpebjeyyegkq2xmhknmggtwppc7adman5qxxdn2@kgv4fiok4p2j>
References: <cover.1692033783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692033783.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 06:53:32PM +0100, Robin Murphy wrote:
> Hi all,
> 
> Prompted by [1], which reminded me I started this a while ago, I've now
> finished off my own attempt at sorting out the horrid lack of rcache
> scalability. It's become quite clear that given the vast range of system
> sizes and workloads there is no right size for a fixed depot array, so I
> reckon we're better off not having one at all.
> 
> Note that the reclaim threshold and rate are chosen fairly arbitrarily -
> it's enough of a challenge to get my 4-core dev board with spinning disk
> and gigabit ethernet to push anything into a depot at all :)
> 
> Thanks,
> Robin.
> 
> [1] https://lore.kernel.org/linux-iommu/20230811130246.42719-1-zhangzekun11@huawei.com
> 
> 
> Robin Murphy (2):
>   iommu/iova: Make the rcache depot scale better
>   iommu/iova: Manage the depot list size
> 
>  drivers/iommu/iova.c | 94 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 65 insertions(+), 29 deletions(-)
> 
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

I'm trying to hunt down a system where we've seen some issues before,
but most of them have involved systems with nvme drives. Commit
3710e2b056cb ("nvme-pci: clamp max_hw_sectors based on DMA optimized
limitation") has helped those cases. I ran the patches overnight with
IOVA_DEPOT_DELAY fixed up on a couple of Genoa based systems (384
cores) without issue.

Regards,
Jerry

