Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E27D504A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjJXMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjJXMvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:51:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC96CC
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:51:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB511C433C7;
        Tue, 24 Oct 2023 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698151881;
        bh=TFD1b2WvPJypreIXeQMJonQ4m7/84KK0APffbW1LP18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNQfcMiKjEZOGZGMaMrW/8ht2O09CF0M3SLJeUIz8JQE/BYcZbfoassFYCRkOhRW3
         hFIQda9fSrJHmRzjAt8a8dYSpyDLzItd6RS1tedp9oqZ/Lw0rjXO3BwFYUv3DtFtCw
         gOEcjETB1ReOUkLsO0ohFOCju/jt1pu3lK6fYt1ofi7rehC+hrGbYz4QY+lrtu5umU
         fm3jse2ZqmcaLuIcQJyNQB6t9t2pfBmQm08Lg70kbFoqXQLXChBvlfszeKg28mpknA
         uuh0BM1+bJWw2isybMR137AAtFBi5K3+Ff0UKaKj1+nXMWk10lTmZS5jvTgIll6wWt
         a/qrJcAx2xK1w==
From:   Will Deacon <will@kernel.org>
To:     mark.rutland@arm.com, Yicong Yang <yangyicong@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jonathan.cameron@huawei.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, yangyicong@hisilicon.com,
        prime.zeng@hisilicon.com, linuxarm@huawei.com, hejunhao3@huawei.com
Subject: Re: [PATCH 0/2] Minor fix and cleanup for hisi_pcie_pmu
Date:   Tue, 24 Oct 2023 13:51:12 +0100
Message-Id: <169814704566.2105129.18354462582321267564.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231024092954.42297-1-yangyicong@huawei.com>
References: <20231024092954.42297-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 17:29:52 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This patchset includes 2 minor updates for the hisi_pcie_pmu:
> - fix issue that we may touch others events in some case
> - modify the event->cpu only on the success pmu::event_init()
> 
> Yicong Yang (2):
>   drivers/perf: hisi_pcie: Check the type first in pmu::event_init()
>   drivers/perf: hisi_pcie: Initialize event->cpu only on success
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/2] drivers/perf: hisi_pcie: Check the type first in pmu::event_init()
      https://git.kernel.org/will/c/6d7d51e88e21
[2/2] drivers/perf: hisi_pcie: Initialize event->cpu only on success
      https://git.kernel.org/will/c/868f8a709874

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
