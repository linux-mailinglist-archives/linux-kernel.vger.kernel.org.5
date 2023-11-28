Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C807FCA06
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 23:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjK1Wzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 17:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1Wzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 17:55:39 -0500
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7503C1A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:55:44 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58cec5943c1so3248157eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 14:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701212144; x=1701816944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wfgEOy2prfurtAfhJK/0Guihsou0dTaccer75iSoWso=;
        b=AZLqdM4x2Ov+Gtc2vniBfPL9kpW6zs9zKUkDKEfyXSOcwBfZPtK83z5HUXWvJNpFnS
         RYecGLTKbNkC9p6lTUjCmMS2mxypxaoIzP5FA2kW0/nYyZOrSi//Flk+BPnWi2hRsYwp
         bH2m2+0gyeOEmsBRpkCmMFUvuGQNzZ5MTeGb830pINMnNUvztmJn48jfIjWXAh2fqcFU
         eCwfIcAIpdzOI1r/3CPP6PsxzMxaOhs/E/kzfI6++l+YMRbEcfxvWt6nVoiKyoDKzxvl
         o5F4CHamlAW2pbzLTvV8RWfLc020m/YvE3HVhcPuxs7XzATl57IuY4q56qxpDLQTQCHk
         Y4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701212144; x=1701816944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfgEOy2prfurtAfhJK/0Guihsou0dTaccer75iSoWso=;
        b=SixDcWlcOcRsI3Lp1wE1rV2TaS4frthd/V5mzMTYYloIKh4P5f9wsCL4oEZEXSGrmz
         /SHtm3CgLmsVT5RVgHir2YkjduZB+4qlQ6gZn9WrTDPVCFYSwEbzA2V+uHhDQ2NF68E1
         HMggpIWwO/IPY6X0z6oNhfUggjEQ0eDNkoBn4nktHbviUW/YjEN3fCTEwHSdrMc0Zpez
         uA1VtKaDkceAMTH0tKnmAewpRMF6CRoRf84//ffYWCVyqMpl+80PZyxpJHBA8/DY4Mlh
         hzhr7hTNd1j8EQpvjOi0U6Jj4xFAkUSMClVJ/ULr/3HfFcsLvoUBMJrCrFbvW8zWQPC7
         Ukig==
X-Gm-Message-State: AOJu0YzI2nJ7HOge56BTs1GDBHITTFgDAkQDEdI31iGCoVz49tCBUQQL
        gcnzNvkxJOZkPB55bltDjyapNgEwCf6OsUF+1WYV2w==
X-Google-Smtp-Source: AGHT+IHisXYdh3pxH8NCFygwpTk8sa04O8TeLdxM3oMX+99Z92ajNHfOBhWjaeIXy0J8F2P4nyXD+nsTEaXIGG5EBsc=
X-Received: by 2002:a05:6358:724c:b0:16d:fb29:d78 with SMTP id
 i12-20020a056358724c00b0016dfb290d78mr15947280rwa.2.1701212143714; Tue, 28
 Nov 2023 14:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-6-pasha.tatashin@soleen.com> <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
In-Reply-To: <8e1961c9-0359-4450-82d8-2b2fcb2c5557@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 28 Nov 2023 17:55:07 -0500
Message-ID: <CA+CK2bDFAi1+397fd4cYetUgmHxqE2hUG4fa2m9Fi3weykQdpA@mail.gmail.com>
Subject: Re: [PATCH 05/16] iommu/io-pgtable-arm-v7s: use page allocation
 function provided by iommu-pages.h
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >               kmem_cache_free(data->l2_tables, table);

We only account page allocations, not subpages, however, this is
something I was surprised about this particular architecture of why do
we allocate l2 using kmem ? Are the second level tables on arm v7s
really sub-page in size?

Pasha
