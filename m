Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8697D3F54
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjJWSfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjJWSff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:35:35 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD99B7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:35:29 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b2f4a5ccebso2533732b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698086128; x=1698690928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IIoRI2ARPSz8WtQUlc5itQT0gMoQCkpLJtTDznyytSc=;
        b=hCCbONk9aeS3MscLtPA1VLgVMXvUWrQ1ohu9W3XXuT6+KjK/QXVNPCIMNPG09W2MCW
         TsOfEVCohg4FmVYJwXu8D4DTGqpVIyVIFy+lfBywKl0XRHEpZOrlahyM4RVPZVjcr3Hd
         PonBM4simvyuMYbArJwX/8HHFxhnB/eLbKvQIgAtFd7KsE7/JfYknP+HPDfhjE07D9U1
         J1Ot2I450c7zleH8zZcRKt+lhyxw9yxsZHY2re+Sxg1e6rrCpkPBthM69MMg0x4Hu0Up
         X1LHnkcaqokwnxcellEI1Uk0AnakrTGR8nG+tR4jl/5ad7HtG+3WjTWDmSS29dKKiP/U
         OmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086128; x=1698690928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIoRI2ARPSz8WtQUlc5itQT0gMoQCkpLJtTDznyytSc=;
        b=WnRJ67vImqo7xOaWVQDskfOZoArkShPFA2DWUD1m+xfbNNCZ50j+bO+XYd1/frA/0T
         ctHh52XQH/PSez7oozyAAIfWOyUUlGml4w5JoqdMyOyOxt7tTle/LJ4OThhj2s4YZSGP
         457T43tQIWgMkx9xi7+Bb8lSB2kd6zCYh/Umkd+WLeFpUzzQxrnvSnzR+Nn2U4kScvgI
         uWNzjPox0EadHhu2U3iXnQe3EQVy2GiHDUPYpu202eJOQ1VcYw2phwwcW9o37z5k8DGh
         qxHTBiKvtdh3NfPQ2o1Cyd1hm9eotAULUXNXp++3+E7Xw8IOZff+zaLxdc7HTSz4YZWr
         NdUw==
X-Gm-Message-State: AOJu0Yz8yk7R+JLhDdW/lvdw6SaP+KTp4veRruyeB8HYmj9OKynBs2zn
        T6GJaynF5neUOZxZWFRXLZCREA==
X-Google-Smtp-Source: AGHT+IF87A5sAEPwDGGscH4VZHk76YpcDJFB/PbHnNeeeYrEYuSNJeTyvaSasLb7bG0Tzfme5ZXN0A==
X-Received: by 2002:a05:6808:158c:b0:3af:9848:1590 with SMTP id t12-20020a056808158c00b003af98481590mr12228373oiw.6.1698086128598;
        Mon, 23 Oct 2023 11:35:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id bj6-20020a056808198600b003adcaf28f61sm1593859oib.41.2023.10.23.11.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:35:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1quzlv-003jZ6-6w;
        Mon, 23 Oct 2023 15:35:27 -0300
Date:   Mon, 23 Oct 2023 15:35:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [RFC PATCH 06/12] iommu: Add mmu_notifier to sva domain
Message-ID: <20231023183527.GM691768@ziepe.ca>
References: <20231017032045.114868-1-tina.zhang@intel.com>
 <20231017032045.114868-8-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017032045.114868-8-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Oct 17, 2023 at 11:20:39AM +0800, Tina Zhang wrote:
> Devices attached to shared virtual addressing (SVA) domain are allowed to
> use the same virtual addresses with processor, and this functionality is
> called shared virtual memory. When shared virtual memory is being used,
> it's the sva domain's responsibility to keep device TLB cache and the CPU
> cache in sync. Hence add mmu_notifier to sva domain.
> 
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/iommu.h | 2 ++
>  1 file changed, 2 insertions(+)

You should look at how arm smmuv3 ended up after I went over it to
make similar changes, I think you should take this patch

https://lore.kernel.org/linux-iommu/20-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com/

into this series (maybe drop the arm part)

And copy the same basic structure for how the mmu notifier works.

It would also be nice if alot of the 'if_sva' tests could be avoided,
smmu didn't end up with those..

In the guts of the pasid handling sva shouldn't be special beyond a
different source for the pgd.

Jason
