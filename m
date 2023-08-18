Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9715B78128C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379284AbjHRSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379351AbjHRSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:04:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008AD421D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 916AC60EB6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 18:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5162AC433C8;
        Fri, 18 Aug 2023 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692381857;
        bh=Gf6arIKAY3c3fiE1WH+qDM5bkIL0Lum5VheZeFs8btw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuGZEdSSSyy/lhH5yQegv4brNPtgs72bXwl2fBR+QrUIDdZiwza/2tI0p5bCzBNI/
         5KTK+AbkPhA47YDLp++B0UirskGGSpFjUAlnq2YlqWBQlIjM69U72jtWpAh6leMrVk
         WD8Qp2S2+oSIoJRD6QDkbr/lUtUlSfHqwqJqrMdJ3+3PH0/NfpbWugJ8x0jSYHyNvC
         HE41An0KyTu9O9ikFICUExRhNKUTZcDsz/lEqKmIkB3F3NiWvZbQ6bPCwI+VEk3t3j
         FMqsXqGZimPqB9gYIWal5VwUZMMuRZGEDadZ3C90N/DEz2rncrMg8ugKXDUTmBPFDW
         mJabPqGuoCkTQ==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, yangyicong@huawei.com,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Mujawar <sami.mujawar@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH V5 0/4] coresight: trbe: Enable ACPI based devices
Date:   Fri, 18 Aug 2023 19:04:08 +0100
Message-Id: <169237557557.1402587.14721093106016169238.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230817055405.249630-1-anshuman.khandual@arm.com>
References: <20230817055405.249630-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 11:24:01 +0530, Anshuman Khandual wrote:
> This series enables detection of ACPI based TRBE devices via a stand alone
> purpose built representative platform device. But as a pre-requisite this
> changes coresight_platform_data structure assignment for the TRBE device.
> 
> This series is based on v6.5-rc5 kernel, is also dependent on the following
> EDK2 changes posted earlier by Sami.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/4] arm_pmu: acpi: Refactor arm_spe_acpi_register_device()
      https://git.kernel.org/will/c/81e5ee471609
[2/4] arm_pmu: acpi: Add a representative platform device for TRBE
      https://git.kernel.org/will/c/1aa3d0274a4a
[3/4] coresight: trbe: Add a representative coresight_platform_data for TRBE
      https://git.kernel.org/will/c/e926b8e9eb40
[4/4] coresight: trbe: Enable ACPI based TRBE devices
      https://git.kernel.org/will/c/0fb93c5ede13

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
