Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6318178B564
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbjH1QbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbjH1QbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:31:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04DD9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:31:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29636628BB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831F1C433C7;
        Mon, 28 Aug 2023 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693240261;
        bh=weiJMHFx5eMRD9AhhbuNm6su5sz7QLZ8r/gQrlhMV9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9va+rgS+rG6fH7DSgtErUV0sw5beMfJ2ifjjXHCYShpMshq7mQ/PMnpjEa/BLfMe
         5u24POH7EKEjU6IJ44eS2xGre5+MDlcJdL/26doPSnf4I6ck2CSWa50PNvWEckMjbp
         HwEx4TS4Ze3KtUunTQ2N7YVff/SnB/cF+B2n2GkwWnst77b3o9uN9UDCz2C5FZYq9h
         SSoZqia+tz8oQabjqwYRj38sztJJYKfdWvh8SvwEqwJCzy4c56XgNPfWPA4RE5rnS2
         Yn4qYntmYr/ibYr0wIOVjbPjH1CVUvBsxkdGAaRiGIaumupGbxxeeaiyYZlYj1gVI+
         qzKndazyozvRA==
Date:   Mon, 28 Aug 2023 17:30:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        catalin.marinas@arm.com, kernel-team@android.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
Message-ID: <20230828163045.GA27321@willie-the-truck>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
 <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
 <e94ae586-0362-7cc1-60a8-af9ec8059e3e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94ae586-0362-7cc1-60a8-af9ec8059e3e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:11:41AM +0530, Anshuman Khandual wrote:
> 
> 
> On 8/18/23 23:34, Will Deacon wrote:
> > On Thu, 17 Aug 2023 11:24:01 +0530, Anshuman Khandual wrote:
> >> This series enables detection of ACPI based TRBE devices via a stand alone
> >> purpose built representative platform device. But as a pre-requisite this
> >> changes coresight_platform_data structure assignment for the TRBE device.
> >>
> >> This series is based on v6.5-rc5 kernel, is also dependent on the following
> >> EDK2 changes posted earlier by Sami.
> >>
> >> [...]
> > 
> > Applied to will (for-next/perf), thanks!
> > 
> > [1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
> >       https://git.kernel.org/will/c/81e5ee471609
> > [2/4] arm_pmu: acpi: Add a representative platform device for TRBE
> >       https://git.kernel.org/will/c/1aa3d0274a4a
> 
> It seems like the above two changes are still going in for 6.6-rc1 ? I could
> see these in arm64/for-next/core and latest linux-next next-20230825.

Yes, as I said, I only dropped the coresight bits.

Will
