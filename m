Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874D67FCB54
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 01:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376667AbjK2A2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjK2A2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:28:23 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE219AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:28:28 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-586ae6edf77so2986419eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701217708; x=1701822508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMYRcf/Kii/rrCclUYaD6+8KP9DIOITQj8zQjAaRv7g=;
        b=ALKPjAL3lOry8fwYbpJHky8GgQ0MSZvFzN8DpJvZqjrkqWcU4j33cmecA63TgcUYm1
         JtXL2Xx9YC+I11VP5eUfMVq2eUMG0raeGBc4uDkPAOhAJOY7DdFlFWdi3Gd2z99Zdt+q
         mO0BnEXRt7GJ5NyamNl0Vwu+aaDMYzR5Z42g4gijs/miS/qbfjhEqSdQPSBIEOmU5swj
         tAJrcHCJwHTs+toLULmt+kBfefL8BhazL+UnrocJZjmhN8FSiiDGktv9qlh5sQSvwFXx
         EvHCsa7/DRM04V5MnzHL5XACLFyClNCUrGccDLdhqEjshcAZ1tgIKs0ovMkvEAIawCqQ
         U4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701217708; x=1701822508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMYRcf/Kii/rrCclUYaD6+8KP9DIOITQj8zQjAaRv7g=;
        b=B9fFdss2O++4seRV2JJ8Vt28kOXv5AxB7OKK6WxOUC4o1qmzkDK5x9bdcXUzz85Hyo
         1IzVWpaGsEFgKX2Jtq7Y9kRg3ZUq6XM4klJtjflc/Oy4ZiqXbPwqr/fFUYwCQQNOw470
         O4YcTW19pLxkDjls5Q5R6/z4J422wEWarjdN9o9BHKDEkvG17y98+Vu2onBboPZ7pWHQ
         JmXfK3cxi6pAPicnMnlLwNS+U+4E+hZBRy1at4HZSAxsmqREi7zid2tPfoTxYpnmONJH
         r7uzb3v0stbSnZxQwFBdl4QGtDOPrXo3keLZiWC7bI+oFaAeF8A//s3jlte2ZAD2Srsm
         DuSA==
X-Gm-Message-State: AOJu0Yyia/6uy1uPNruEV9XksoA3mmdEJ6M6l3ViTFOd2uX9vN7RMn/x
        1/3TCHFGuNGIbDG5eZc0H+XXpQ==
X-Google-Smtp-Source: AGHT+IHxOFYr1Wu9Fd6OY7DYtdTti5/c4rkTAyn2SfjWCS9pDJNiXdB/2NGtfvjIa+mQCcwPiiU58Q==
X-Received: by 2002:a05:6820:1504:b0:58d:97fb:cce9 with SMTP id ay4-20020a056820150400b0058d97fbcce9mr7193926oob.0.1701217707699;
        Tue, 28 Nov 2023 16:28:27 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id l5-20020a4ac605000000b00581e090fd1fsm682626ooq.8.2023.11.28.16.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 16:28:27 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r88RG-005k2k-DG;
        Tue, 28 Nov 2023 20:28:26 -0400
Date:   Tue, 28 Nov 2023 20:28:26 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yosry Ahmed <yosryahmed@google.com>
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
Subject: Re: [PATCH 00/16] IOMMU memory observability
Message-ID: <20231129002826.GG1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>
 <20231128235214.GD1312390@ziepe.ca>
 <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbbq6bHtPn7yE3wSS693OSthh1eBDvF-_MWZfDMXDYPKw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 04:25:03PM -0800, Yosry Ahmed wrote:

> > > Right, but as I mention above, if userspace starts depending on this
> > > equation, we won't be able to add any more classes of "secondary" page
> > > tables to SecPageTables. I'd like to avoid that if possible. We can do
> > > the subtraction in the kernel.
> >
> > What Sean had suggested was that SecPageTables was always intended to
> > account all the non-primary mmu memory used by page tables. If this is
> > the case we shouldn't be trying to break it apart into finer
> > counters. These are big picture counters, not detailed allocation by
> > owner counters.
> 
> Right, I agree with that, but if SecPageTables includes page tables
> from multiple sources, and it is observed to be suspiciously high, the
> logical next step is to try to find the culprit, right?

You can make that case already, if it is high wouldn't you want to
find the exact VMM process that was making it high?

It is a sign of fire, not a detailed debug tool.

Jason
