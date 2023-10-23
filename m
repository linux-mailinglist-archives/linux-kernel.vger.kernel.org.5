Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A797D3987
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjJWOkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjJWOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:40:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5180783
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:40:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11863C433C8;
        Mon, 23 Oct 2023 14:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698072003;
        bh=xT2ID74qaEhNp/ttE9wQABT3gOGXaJKhoUu9fwd9NNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEuh/iLsyS6qJV9zZNpq3bF0nXspNIyIzvK/0xFDpVJPeVgjz4YlAp87+JJtTAn97
         msjZ+6l+Omizckgj7SOYazAe3pVqRcVjpHdNhj/dxkl5GEr+JAJYaiEbwhzdq1vf/4
         r+M7jatXT1+QEXOX87tYJdhNWh5U4VBSJvW1UCA9TN3p8Xg8uyhv9EAF706vPH9bDx
         x6OStgfzQojsIMmYcOEFFJTCHNqkii56B2EzzYNvgBeO3XLh9e/ydO8epQIk/ygGIu
         nfleK8bShEyE9WA8SODJBE+CjvDCIvbCKSctEnEdp9WOi/zyOWRotedQBOfjdVN093
         2OBfXPy9e+5PQ==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, jeremy.linton@arm.com,
        mark.rutland@arm.com, ilkka@os.amperecomputing.com,
        linux-arm-kernel@lists.infradead.org, renyu.zj@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] perf/arm-cmn: Multi-DTC improvements
Date:   Mon, 23 Oct 2023 15:39:57 +0100
Message-Id: <169806514284.32210.14406040382129422487.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1697824215.git.robin.murphy@arm.com>
References: <cover.1697824215.git.robin.murphy@arm.com>
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

On Fri, 20 Oct 2023 18:51:24 +0100, Robin Murphy wrote:
> On larger CMN configurations with multiple Debug & Trace Controllers,
> we've so far ignored the notion of DTC domains, mostly since they were
> not software-discoverable in the original CMN-600 design. However this
> means that if the user wants to monitor lots of individual nodes across
> the whole mesh, we end up multiplexing events which could otherwise
> happily run in parallel if we allocated DTC counters per-domain. This
> mini-series finally bites the bullet to do that.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] perf/arm-cmn: Fix DTC domain detection
      https://git.kernel.org/will/c/e3e73f511c49
[2/3] perf/arm-cmn: Rework DTC counters (again)
      https://git.kernel.org/will/c/7633ec2c262f
[3/3] perf/arm-cmn: Enable per-DTC counter allocation
      https://git.kernel.org/will/c/ab33c66fd8f1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
