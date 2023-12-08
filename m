Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666A980A48E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjLHNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbjLHNkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:40:21 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBEB1734
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:40:27 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-67a959e3afaso11609436d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 05:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702042826; x=1702647626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n8e2o0WXAr4ymK3d3VhrPB5sSWDppvhuD0Mr+xQ4HHM=;
        b=nTWe5gl1PBw9JZvp/It9oXA862ulMpFet1/o6nGotv7Vwo0jhcyZylqOx1M77LSGWO
         gvUoPVCDVaLEgE2RuIHt0256V66DkEB4IMAVjBCdRnmaCnSsW3y7lc9toDPUx2jZ/E0J
         rZ4FFOalTQaj650GVO+9eiybqbil+was+v/4pcvqCFHZaD1oosB0bc0UJttgZBFfUGp4
         vMT7I2e0ozkSiLhTUgbUJ3grSFZH6+7xGhivgneDPawuRgECzmo7IkRpCZPcUDJICTLj
         DzcZ5bL8mn3x4Jg8fs3RkZaODAcv6u9fPo4ICsqylKHOENk5BBK3ENI0+LQCLywoZZoR
         o/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702042826; x=1702647626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8e2o0WXAr4ymK3d3VhrPB5sSWDppvhuD0Mr+xQ4HHM=;
        b=mMCIgWf3ZaPKTkLaVUuvNMnloWSmBWQF4RGGUxFSypiMuFhol0OM355UKO+SpZq4hK
         sHo6Tr4La3E6JIskwDkGWT0SdmTm83q/Xw7QcQNvbdnX9ghAuSq4qLfuaw66l1paTglg
         wqiOphlmNv2nGb6vUaIoovUO+DQEWLq80dmz+zXS6eWbltZfREau1fPQuxYmxjAX1BGO
         Ht9m4bO3ckhubpfOj128Yf7c5aL4+PjtbEmjsDeGw9HlGHA0mzUKRPb2FWKiAfIOjxwq
         G7rT/NT/eCpvQg3s3aWoUpMXZzEFCz9M3mQB4HZ0nclEqXLvx4ZzK9IV2HQmSCoW8AoD
         KSwQ==
X-Gm-Message-State: AOJu0Yxq7ZUARkahCdtWVWAqCmBnBUyB7LUEcbRntUkyEl571GWmi9R+
        IELLthlGsISfEcbuSChySsQaMA==
X-Google-Smtp-Source: AGHT+IG+42h3wSDDnzyiUdmBDnnmwEZgxwWvJKW+1f6Wnxx1cI9jSsHp0wxIJsybMJwE+p1mPdNlxw==
X-Received: by 2002:ad4:57ac:0:b0:67a:9d24:5e95 with SMTP id g12-20020ad457ac000000b0067a9d245e95mr3820818qvx.31.1702042826613;
        Fri, 08 Dec 2023 05:40:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id lf10-20020a0562142cca00b0067c4b7ca239sm805168qvb.22.2023.12.08.05.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 05:40:25 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rBb5c-00C888-Tx;
        Fri, 08 Dec 2023 09:40:24 -0400
Date:   Fri, 8 Dec 2023 09:40:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: Set owner token to SVA domain
Message-ID: <20231208134024.GV1489931@ziepe.ca>
References: <20231208015314.320663-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208015314.320663-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:53:14AM +0800, Lu Baolu wrote:
> Commit a9c362db3920 ("iommu: Validate that devices match domains") added
> an owner token to the iommu_domain. This token is checked during domain
> attachment to RID or PASID through the generic iommu interfaces.
> 
> The SVA domains are attached to PASIDs through those iommu interfaces.
> Therefore, they require the owner token to be set during allocation.
> Otherwise, they fail to attach.
> 
> Set the owner token for SVA domains.
> 
> Fixes: a9c362db3920 ("iommu: Validate that devices match domains")
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
