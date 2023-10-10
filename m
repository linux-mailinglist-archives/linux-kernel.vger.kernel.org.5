Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEE7BF24A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442120AbjJJFhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378127AbjJJFhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:37:16 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58CB0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 22:37:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso4656686b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 22:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696916234; x=1697521034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ObP8Rl/0A7UtCw+rouL6c1lVaOQSySi4DY8/r288Yw=;
        b=uScf4Z7MiDVDaxMarol9s6Rq4hVMRv1MLtepDDn6MsFCZo83w5sAf5w7VFwbkJBcPn
         d36He67K5iiEUqgAaIqmYwx5vlJBZ5wmEFLH/pQ9WFeeV1EISzmot67jFbIepVB6FLD7
         mAj+5tcClLPDVwmiwm9AionirmqambJlFMZqk55HIJugOUVqWaCA8pI9pZsagciCsRDU
         omePqeTAZkCIX+Nk5HJfPXoxvx36IDq3JDZCkTdXv5OEheTzjG4LMrXiV6njIzn4EcJw
         JIsPX/wbv4OIuZPrp5AFQwbO3ZQXZsbLu5V2MPLYmKR+1wicOJt7ZCTsF9jOfMDkNxNG
         wCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696916234; x=1697521034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ObP8Rl/0A7UtCw+rouL6c1lVaOQSySi4DY8/r288Yw=;
        b=Kafb3SLuMFhp/LF6nJg5ne7fvgl9TCrRfEff8PsDlqNWGxpRicbxj3jZChwOleRb4l
         88RdE9u4aQvAUTglJDoIqOjKQF3Kj8LZ5RvhhUeF4R0ptqKyWhCP+HJKoeb555Bc6uQ3
         O3fBsHATI+8LmdbJBK/sZDBy4U+AYQK3NlbbOkNH/1k2av7fK5kRahp7eJfKajXWcr6Z
         hWy5TsSQZA747Ybxt6zKOIH8qoc7bTiZJrRRbCWBx50B0yOGVHcnC61rxPgdJV3fFvoK
         6sc9wKJXj8cNlIQ1M41yFxgT8PXZtu62thDw0mXi5/dkOS1W1G3eF/Sa9708Z7ZtjiFd
         jYcQ==
X-Gm-Message-State: AOJu0Yx+DFjnbn9TttaaItI1VX5FTaCvDIBEnQKm/VNJkSiaWONjZzrA
        Zt74jvewQwMoySWE5s9bUKzlGQ==
X-Google-Smtp-Source: AGHT+IGMSkudMmyUH5z0v+qm/ZiE40Ywte6qNQdIFUX+RygHcF4KxPmMuXrxA1qNnlIMX2Z3ZrdKlQ==
X-Received: by 2002:a05:6a21:6da0:b0:14d:446f:7212 with SMTP id wl32-20020a056a216da000b0014d446f7212mr22228037pzb.46.1696916233943;
        Mon, 09 Oct 2023 22:37:13 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id k2-20020a632402000000b005898e4acf2dsm7456609pgk.49.2023.10.09.22.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 22:37:13 -0700 (PDT)
Date:   Tue, 10 Oct 2023 11:07:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, bbasu@nvidia.com,
        amiettinen@nvidia.com
Subject: Re: [Patch v3 0/2] Improvements to the Tegra CPUFREQ driver
Message-ID: <20231010053710.hrq3ifktt7j4n4ln@vireshk-i7>
References: <20231004140537.1954-1-sumitg@nvidia.com>
 <72e9f769-9cbb-274e-e99d-10c71f84bbe0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e9f769-9cbb-274e-e99d-10c71f84bbe0@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-10-23, 17:06, Sumit Gupta wrote:
> 
> 
> On 04/10/23 19:35, Sumit Gupta wrote:
> > This patch set adds below improvements to the Tegra194 CPUFREQ driver.
> > They are applicable to all the Tegra SoC's supported by the driver.
> > 
> > 1) Patch 1: Avoid making SMP call on every frequency request to reduce
> >     the time for frequency set and get calls.
> > 
> > 2) Patch 2: Use reference clock count based loop instead of udelay()
> >     to improve the accuracy of re-generated CPU frequency.
> > 
> > The patches are not related but have minor conflict. So, need to be
> > applied in order of patch numbers. If 'Patch 2' is to be applied first
> > then will rebase that and send separately.
> > 
> > ---
> > v1[2] -> v3:
> > - Patch 1: used sizeof(*data->cpu_data) in devm_kcalloc().
> > 
> > v1[1] -> v2:
> > - Patch 1: added new patch.
> > - Patch 2: changed subject and patch order.
> > 
> > Sumit Gupta (2):
> >    cpufreq: tegra194: save CPU data to avoid repeated SMP calls
> >    cpufreq: tegra194: use refclk delta based loop instead of udelay
> > 
> >   drivers/cpufreq/tegra194-cpufreq.c | 151 ++++++++++++++++++++---------
> >   1 file changed, 106 insertions(+), 45 deletions(-)
> > 
> > [2] https://lore.kernel.org/lkml/20230901164113.29139-1-sumitg@nvidia.com/
> > [1] https://lore.kernel.org/lkml/20230901152046.25662-1-sumitg@nvidia.com/
> > 
> 
> Hi Viresh,
> 
> If there is no further comment.
> Can we please still apply these patches for 6.7 ?

Applied. Thanks.

FWIW, you should have rebased the other commit (which removes cpu
online mask) over this one. I had to fix the commit manually now.

-- 
viresh
