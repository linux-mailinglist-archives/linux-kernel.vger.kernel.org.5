Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D013F781065
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378654AbjHRQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378692AbjHRQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:30:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FBB2421B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:30:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55868D75;
        Fri, 18 Aug 2023 09:31:02 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C1813F762;
        Fri, 18 Aug 2023 09:30:19 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Junhao He <hejunhao3@huawei.com>, anshuman.khandual@arm.com,
        james.clark@arm.com, mike.leach@linaro.org
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, linuxarm@huawei.com,
        prime.zeng@hisilicon.com, yangyicong@huawei.com,
        jonathan.cameron@huawei.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] coresight: trbe: Fix TRBE potential sleep in atomic context
Date:   Fri, 18 Aug 2023 17:30:09 +0100
Message-Id: <169237411247.697015.1763852652455357854.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818084052.10116-1-hejunhao3@huawei.com>
References: <20230818084052.10116-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 16:40:52 +0800, Junhao He wrote:
> smp_call_function_single() will allocate an IPI interrupt vector to
> the target processor and send a function call request to the interrupt
> vector. After the target processor receives the IPI interrupt, it will
> execute arm_trbe_remove_coresight_cpu() call request in the interrupt
> handler.
> 
> According to the device_unregister() stack information, if other process
> is useing the device, the down_write() may sleep, and trigger deadlocks
> or unexpected errors.
> 
> [...]

Applied, thanks!

[1/1] coresight: trbe: Fix TRBE potential sleep in atomic context
      https://git.kernel.org/coresight/c/c0a232f1e19e3

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
