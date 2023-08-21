Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54657827E5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjHUL3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHUL27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57669DF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E43AD6314C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B371CC433C8;
        Mon, 21 Aug 2023 11:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692617337;
        bh=iuyg705BGv3auBKvZ+6LTDZ3PTXoNd9b5WxISw0eqqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mz4lFm9OVTkqS17lxzLMvYUav0OHn96Kzz2/+graSRfcrLXu97rBsaS5KeK0lWezx
         kCw3GgTPK6dSXhkCOfiKpbcv2LB03I0+w4nf18wGGatmqv/rqiKHTX307erV0Y0zsu
         yWGQDYgqJ6jK9KAdo1Se1hPIGTpV+nRCVXEEANgUDX3io4m8aELLBp3kA+MOEB08aD
         axt6JVOEqZjcc2Fzi5YCFUmT7bJmw+b4uJfFXfURZ3XF91HKyM97sbzWBEmL0IEDGe
         tdVHuWTinqsL5qev8PkXC9dibDyqgNE05/Fqn36o3VlXc33MmT9ALrLDD7qPcClSd6
         w4fbgOxG9SQJg==
Date:   Mon, 21 Aug 2023 12:28:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        kernel-team@android.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
Message-ID: <20230821112851.GC19469@willie-the-truck>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
 <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
 <f8f13510-ec6a-b18b-d9ff-9247b250bc03@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f13510-ec6a-b18b-d9ff-9247b250bc03@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 08:36:28AM +0100, Suzuki K Poulose wrote:
> On 18/08/2023 19:04, Will Deacon wrote:
> > On Thu, 17 Aug 2023 11:24:01 +0530, Anshuman Khandual wrote:
> > > This series enables detection of ACPI based TRBE devices via a stand alone
> > > purpose built representative platform device. But as a pre-requisite this
> > > changes coresight_platform_data structure assignment for the TRBE device.
> > > 
> > > This series is based on v6.5-rc5 kernel, is also dependent on the following
> > > EDK2 changes posted earlier by Sami.
> > > 
> > > [...]
> > 
> > Applied to will (for-next/perf), thanks!
> > 
> > [1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
> >        https://git.kernel.org/will/c/81e5ee471609
> > [2/4] arm_pmu: acpi: Add a representative platform device for TRBE
> >        https://git.kernel.org/will/c/1aa3d0274a4a
> > [3/4] coresight: trbe: Add a representative coresight_platform_data for TRBE
> >        https://git.kernel.org/will/c/e926b8e9eb40
> 
> This will conflict with what I have (already) sent to Greg for
> coresight/next. Please let me know how you would like handle it

Hmm, the rationale behind your change to make the pdata allocation
per-device in ("coresight: trbe: Allocate platform data per device")
confuses me: with Anshuman's change to allocate the pdata using
devm_kzalloc(), there shouldn't be any connections for the coresight
core to trip over, should there?

It would've been nice to know about the conflict earlier, but since I
think you're away this week and we're likely to hit the merge window
next week, I'm going to drop the coresight patches for now.

Will
