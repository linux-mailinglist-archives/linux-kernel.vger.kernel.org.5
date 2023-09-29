Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425597B3854
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbjI2RGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjI2RGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:06:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2161B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:06:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EBFC433C8;
        Fri, 29 Sep 2023 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696007177;
        bh=YF0X13QE6/aarXhrBx9F3taz/952LBfI7efaxJa16c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E8CqbKgTZNwI+H43LZjmrMQ1Ul2/SqeoOZg8yBFQkJDRtH5yloy1BtLKA0PvZYcb8
         eQ9Iz/mmOKaWIVr/bt56Lily0V1tCq7TRmX6CKOSCCuIAtZ9hbR04WR9nWtATrKhzA
         mBCZFf/aBi89DMIZLV1EtnMJ3umMROqzAj7ZUqHPAY77zo533x6ldgoPuxBjY9Ukb8
         CbkVSNvjlYCeIaPI/pCA/njhBiwmyAjfzofa2ySsu5ICuhYSd8490Y7s32pgyq641O
         rPRDgUBFq2j7llfUnZgOY0Bd9spbUsENRht4vdKyxdn11i59XLyVRfGKO3sl/h+dhD
         M2DuI2O0S5Tfg==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH] perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7
Date:   Fri, 29 Sep 2023 18:06:07 +0100
Message-Id: <169600109998.282953.10575480145954445725.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1695612152-123633-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1695612152-123633-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 11:22:32 +0800, Jing Zhang wrote:
> The register por_dt_pmovsr Bits[7:0] indicates overflow from counters 7
> to 0. But in arm_cmn_handle_irq(), only handled the overflow status of
> Bits[3:0] which results in unhandled overflow status of counters 4 to 7.
> 
> So let the overflow status of DTC counters 4 to 7 to be handled.
> 
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7
      https://git.kernel.org/arm64/c/7f949f6f54ff

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
