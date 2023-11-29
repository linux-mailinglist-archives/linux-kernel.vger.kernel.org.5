Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B867FE24B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjK2Vtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2Vtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:49:41 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6BB10CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:49:47 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41cd4cc515fso1517651cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701294586; x=1701899386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cpfJU5sAguyt0/G2iahMIWT2bpNq5anO26/F530wIyY=;
        b=HJAXN7iBuM+uFe3zpc3uYLzvOrZnIW7Rgobqx2d537etXTr6TuiIL3TGjesui2UVtu
         ym9h1km+8brtg4+qvFbTJ/KGkB99nz+J6BlPVefUjP75DT0T/iqdEU+11sUDRcgH3HJ7
         +4Klj115UftA0kmoj7LInHKSZYOWoxkXk74aDAVJeXJYH/g4lbTzhcqpJfAn+0kxnqI6
         6ZIMCtFpmruYQfbTX7FbF8JoNHYNSbkrGeodxLLP4hU6ZiF/yZoFz3lefYVEoGFGYl6I
         zYtXzMAoNccvxhAZjunXzc3FpJAW2TyZSzZiRTwxPfJkj2eXwSkRa9IMyH1vfOM/YI6j
         7icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701294586; x=1701899386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cpfJU5sAguyt0/G2iahMIWT2bpNq5anO26/F530wIyY=;
        b=pctAeDJGqSTBmoQoMQV+4XBZvW1JbeAlLnw1jq6bbnXdOvaxXbh/Xove/1DsQIqI/P
         MIWGr/TGZ1fkzGopPTIB9WHE/4LNzYPKefM7wa72gFtKXFjzQnyrkPiPMCIP63QbCXD8
         UQH8ak/YX6HVQfgGAMd5AZCPuRVFPWNLCs6PyHdI0DpAJ7YToAFqForQgQVMIlT1sUU4
         Cha0fKinGoJCcZcCOPP88/bix1kR7ZTMxPRJEubXa95k0Ec5Q5cNg/xXY6Gl2Jqn46PC
         PeoOQbqYtqzX20oHJFOLChg8yACF/hMPwTRufq0ltQYu0hOqyvAZudGVp20dYGUPOeye
         +JRg==
X-Gm-Message-State: AOJu0YxE5K/hEpo8OEXk4P8SlAOuE62BW2H031J2tFLI3x/H7sSlUrCY
        RHr2iYKaNaFE2k/lSdTRihghJOJougc7Ck/PDd06Bw==
X-Google-Smtp-Source: AGHT+IHQGnPttzbf2bAdb5gwZpT0Nh8amOSeNRZF+eb1/SrYiR5d7rhV+9FkDuUK6ClQ83baR1dhxHx1LVYRiRyKJoI=
X-Received: by 2002:a05:622a:34c:b0:41e:213d:3c8e with SMTP id
 r12-20020a05622a034c00b0041e213d3c8emr22630747qtw.32.1701294586528; Wed, 29
 Nov 2023 13:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <20231128204938.1453583-5-pasha.tatashin@soleen.com> <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
In-Reply-To: <ca7a025d-8154-4509-b8ab-2a17e53ccbef@app.fastmail.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 29 Nov 2023 16:49:10 -0500
Message-ID: <CA+CK2bB-TMCgpjvuXRigNaaA2Zmj=r3PHTQMaqs5W-9FkE3roQ@mail.gmail.com>
Subject: Re: [PATCH 04/16] iommu/io-pgtable-dart: use page allocation function
 provided by iommu-pages.h
To:     Janne Grunau <j@jannau.net>
Cc:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, Lu Baolu <baolu.lu@linux.intel.com>,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, David Woodhouse <dwmw2@infradead.org>,
        hannes@cmpxchg.org, heiko@sntech.de, iommu@lists.linux.dev,
        jasowang@redhat.com, jernej.skrabec@gmail.com, jgg@ziepe.ca,
        jonathanh@nvidia.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        Hector Martin <marcan@marcan.st>, mhiramat@kernel.org,
        mst@redhat.com, m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org,
        Robin Murphy <robin.murphy@arm.com>, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, Sven Peter <sven@svenpeter.dev>,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        Will Deacon <will@kernel.org>, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reviewed-by: Janne Grunau <j@jannau.net>

Thank you,
Pasha
