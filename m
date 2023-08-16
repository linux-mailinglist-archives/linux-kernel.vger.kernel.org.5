Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3F77E8A5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbjHPS0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbjHPSZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FF010C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E92064BEC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 18:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAEFC433C9;
        Wed, 16 Aug 2023 18:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210344;
        bh=DJ9yu5ye0vD8Z+3A9KM6d52IQi769IRpEDvJol43U0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwQ/zgn6Ju8dXSzStCVffNaP+brRNto+YD81cUxwnQfBe2Ybw9ZAZvB0/wNjccxYg
         j99A3B+mXVeJKvCvR6h7qtOIRjwmYpZzrUtZ6KDcZ0AKW2hfph321dafwGp7f36Ua+
         Hko7EHq6CWN5ynR5c2MMGBdGLeCr2mlsebd/6oLHyWHouBubQpB1enee/1DavQT5ii
         Z+hozl+Av+acqE5maGMEZOk2G8np8h04iErZTkn3bo9nr5gim4+yfG2ldoNlEoqqIn
         hAWjl4E4m5Z+EFNfzy6uG6dfhAaQn+2YmLkJrWx1ckIAFKV0oRv3pZTT3a5UIF3bLp
         drffeZBX+I+mQ==
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] perf/arm-dmc620: Fix dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
Date:   Wed, 16 Aug 2023 19:25:27 +0100
Message-Id: <169219176343.1943871.17852741864277810991.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230812235549.494174-1-longman@redhat.com>
References: <20230812235549.494174-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Aug 2023 19:55:49 -0400, Waiman Long wrote:
> The following circular locking dependency was reported when running
> cpus online/offline test on an arm64 system.
> 
> [   84.195923] Chain exists of:
>                  dmc620_pmu_irqs_lock --> cpu_hotplug_lock --> cpuhp_state-down
> 
> [   84.207305]  Possible unsafe locking scenario:
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-dmc620: Fix dmc620_pmu_irqs_lock/cpu_hotplug_lock circular lock dependency
      https://git.kernel.org/will/c/4c1d2f56d685

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
