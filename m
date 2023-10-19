Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D015F7CFE91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346349AbjJSPqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345977AbjJSPqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:46:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C91CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:46:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC51C433CA;
        Thu, 19 Oct 2023 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697730368;
        bh=uZrzAXC9wdYwjcMPlXwv/0QqbQrPq59DeA2BiUMwKU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EOiTi+a4vHVdsctj3eTf4roAB5ppZH82lmIe2eRm0FlA1xhPU7oavTbDuF+JNjPMN
         TTkeLLelVquOhbhW3WUvCRKVAKIymzbXPsQ9aLF72BND3AtxFs/5XrDWaS3MkX1KOo
         LwqrM6gYG1Ppxu/VwZHtveE2/unjbNserpWTLjBwbxVpQkCAx75UvrLxnkD4+MPKxR
         TzPeROpifbAmDzYjmAhDLBSmGGN+4sVfR1/mqLtUFBFckzm54dSG8ZsCOsqDafKdTp
         dOL6FdWJspJrccQfEyJ+BVEtqOoCQeLQ3NLgVbUhzorEiY3XITtDSusBijPK+DevJO
         K+WHtOB6JDEYQ==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V3] drivers: perf: arm_pmuv3: Drop some unused arguments from armv8_pmu_init()
Date:   Thu, 19 Oct 2023 16:45:59 +0100
Message-Id: <169772976856.4092328.7100225925505842373.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231016025436.1368945-1-anshuman.khandual@arm.com>
References: <20231016025436.1368945-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 08:24:36 +0530, Anshuman Khandual wrote:
> All the PMU init functions want the default sysfs attribute groups, and so
> these all call armv8_pmu_init_nogroups() helper, with none of them calling
> armv8_pmu_init() directly. When we introduced armv8_pmu_init_nogroups() in
> the commit e424b1798526 ("arm64: perf: Refactor PMU init callbacks")
> 
>  ... we thought that we might need custom attribute groups in future, but
> as we evidently haven't, we can remove the option.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers: perf: arm_pmuv3: Drop some unused arguments from armv8_pmu_init()
      https://git.kernel.org/will/c/3b9a22d345ff

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
