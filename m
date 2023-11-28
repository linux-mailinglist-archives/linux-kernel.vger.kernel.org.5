Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4619A7FCB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376643AbjK1Xwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Xwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:52:49 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06AA1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:52:55 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-58d9dcdf201so1231722eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215575; x=1701820375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXv094b88Raz91Cnddakeh7QBolGZXMUWA5anR7QIWc=;
        b=mpXYFuU4JH5uv2ToJdR8tL9q3V4UBnyTsaSbD/ac6lWLVN7oG3NSZbviGpxx4y8SS9
         MEa4a5zONmQN/byoJMD69sq6nnKVHbAUb1C+4gxmraDMUI7tSvJIIY/hJU+VRhLKZK4K
         cTeGqYb9wYTX516LDTj17A8IukCXZ+HNWJaQZpM6C+auxyuMmGuzARr5qBib477uoNmO
         lXFIYd6Lh+0X8QdWU59IIhBk4ygTbpk+Rwipd5x832MuC5TY+Nxfu5QyjqhNiR8AMmWt
         LTi3SdhJn7+yz3v2UFD5NQrCexZDo95PlZdaUkihE9yNWZum3LBy+S8skBqATgCVa7IQ
         GKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215575; x=1701820375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXv094b88Raz91Cnddakeh7QBolGZXMUWA5anR7QIWc=;
        b=D19qShKh9Dh1EENoF+8M7wGpZwtDTDaqpdSg0oXllV2+9UUd8XKvaCXcPLPjmvhQAr
         B6iD74JaGTMLnpZhvzVfdDrDpIkMfljtUuo2Uxq1jVfyh9jYC2jSjQoRdwtvET4djY0Q
         D7E/FvDkgD65Gv7IAEVlypNPDzxmHQJpssAMuHAJUpzMnWN27wBq5MiAX2Vj94Sg5Gei
         yiccBhV3FXNGre4/TSeOdOoHgnM8+QrLzyPjOgMHDGIuJhJM72t+xvSWpAnx887DdmaQ
         MBVHX/MucKbTFET56ep6wlcAxoZwUhW7CpZIWA5ileyAHTBavYSVjLBOPlLb+w5QmfWb
         ZYHA==
X-Gm-Message-State: AOJu0Yyv/7nIdL73v4b/3sDmdXtNvRRWNMz/KJ1SvVHkFg9gh9TuAOVs
        qmjH/QWNovRQsrAR5UCvvYekNQ==
X-Google-Smtp-Source: AGHT+IGTztmrmgvPYpbtvzl17b62XmnK8+OH49tY+wjVCnGNXRfv5SNHBNwBBGUuA+R8HKGpsMl7yw==
X-Received: by 2002:a05:6870:5d93:b0:1f0:656b:5b99 with SMTP id fu19-20020a0568705d9300b001f0656b5b99mr24892940oab.11.1701215575150;
        Tue, 28 Nov 2023 15:52:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z23-20020a9d62d7000000b006ce2fce83cbsm1060465otk.25.2023.11.28.15.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:52:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r87ss-005jIP-2h;
        Tue, 28 Nov 2023 19:52:54 -0400
Date:   Tue, 28 Nov 2023 19:52:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
        samuel@sholland.org, suravee.suthikulpanit@amd.com,
        sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
        tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
        virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
        yu-cheng.yu@intel.com
Subject: Re: [PATCH 09/16] iommu/iommufd: use page allocation function
 provided by iommu-pages.h
Message-ID: <20231128235254.GE1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-10-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128204938.1453583-10-pasha.tatashin@soleen.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:49:31PM +0000, Pasha Tatashin wrote:
> Convert iommu/iommufd/* files to use the new page allocation functions
> provided in iommu-pages.h.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/iommu/iommufd/iova_bitmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This is a short term allocation, it should not be counted, that is why
it is already not using GFP_KERNEL_ACCOUNT.

Jason
