Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4C7FCB49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjK2AZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjK2AZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:25:39 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B5B19A6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-549070a04baso8221898a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701217542; x=1701822342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=ZyFGy8xp8qD5QI9QwPDb+IhsSZRWf8AzRGUswbI12YDGc1xvIH0g+wLgQbCQ0MgByE
         7JaxlJ6LDrvTwD5v2u1BaaPpBH5R5YUNgb5xQN5Swj0XVMeLoAtP4ZQrlwUAhmY6b1f4
         lo4P74/huqLxXg4rQSkXW1y86RBYbZxCN4heVivo9RjTVn5xV88cmdZGNrBjexsDtvSV
         5HnfHukhNDWtzilONZrFm5fU8R7ZF8dU9NcWUXLUD8PtyHJZZPAj804uzq7F30DAe528
         xZNvGBU8xFyPrK3MZMejmdtbek7u0XA2xivLK10lXoEkODunFDDID+jqCIfmSYQFelmQ
         DpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217542; x=1701822342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s79KKQuQOw+McryaEibHTjOFNeepmOvGc+6XuFBzp3c=;
        b=E7RU2kr77IIX/mHEOzqDIKITy9xX2wpOhpBNsxwj4gWF43YzDSzoQ9yBWk3lCAxitg
         vs86xUfb9fr+DfTl/P4g7aayy5yDOAN3EtZcdruQEyMNmw2RQKnRB9HQLx5w+6JkYRuH
         kvCIU9a5RjODWlQr3KIaAFrbCTnRjFrYuIPSE0olhiFAh/9P73h3d0qDGFFuKK0845hC
         BonWDNELd4Ay/o871hcC/dQC8LPp9NG8PXHH4qwvEEaJDrc4+JExoUV/LtGS+CDRexPR
         se/wigP7CTganqX2qMlEsbDQfQB+4EJwsx/1dXx+UkM0JAsUN/yIUnmVH6NVBcXj/fyC
         t2fg==
X-Gm-Message-State: AOJu0YzQzA/Horr/eNF9eTuqzeiOuNAQJ8rwUSOy/jBZC9LG6ADK419v
        Fu6lMea4M1hq9fWpWGj+kPN5cRSF/LliAcfSrl0UOw==
X-Google-Smtp-Source: AGHT+IFhvJD8pcFDSUkXj7rCXo1krioxrjZU+Fh9ydxhF7LIckb5ecLVgf1lGuB42STpvzRSm1nEjeoSzXAsfJKhmOQ=
X-Received: by 2002:a17:906:1091:b0:a0c:c09f:65fe with SMTP id
 u17-20020a170906109100b00a0cc09f65femr7312731eju.38.1701217542589; Tue, 28
 Nov 2023 16:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com> <20231128235214.GD1312390@ziepe.ca>
In-Reply-To: <20231128235214.GD1312390@ziepe.ca>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 28 Nov 2023 16:25:03 -0800
Message-ID: <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
Subject: Re: [PATCH 00/16] IOMMU memory observability
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        akpm@linux-foundation.org, alex.williamson@redhat.com,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 3:52=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Nov 28, 2023 at 03:03:30PM -0800, Yosry Ahmed wrote:
> > > Yes, another counter for KVM could be added. On the other hand KVM
> > > only can be computed by subtracting one from another as there are onl=
y
> > > two types of secondary page tables, KVM and IOMMU:
> > >
> > > /sys/devices/system/node/node0/meminfo
> > > Node 0 SecPageTables:    422204 kB
> > >
> > >  /sys/devices/system/node/nodeN/vmstat
> > > nr_iommu_pages 105555
> > >
> > > KVM only =3D SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024
> > >
> >
> > Right, but as I mention above, if userspace starts depending on this
> > equation, we won't be able to add any more classes of "secondary" page
> > tables to SecPageTables. I'd like to avoid that if possible. We can do
> > the subtraction in the kernel.
>
> What Sean had suggested was that SecPageTables was always intended to
> account all the non-primary mmu memory used by page tables. If this is
> the case we shouldn't be trying to break it apart into finer
> counters. These are big picture counters, not detailed allocation by
> owner counters.

Right, I agree with that, but if SecPageTables includes page tables
from multiple sources, and it is observed to be suspiciously high, the
logical next step is to try to find the culprit, right?

>
> Jason
