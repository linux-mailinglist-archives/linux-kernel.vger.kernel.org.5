Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FCC7F2BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjKULel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:34:39 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D51319C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:34:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C139EFEC;
        Tue, 21 Nov 2023 03:35:21 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CD303F7A6;
        Tue, 21 Nov 2023 03:34:33 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Junhao He <hejunhao3@huawei.com>, james.clark@arm.com
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org, prime.zeng@hisilicon.com,
        jonathan.cameron@huawei.com, u.kleine-koenig@pengutronix.de,
        yangyicong@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v3 0/4] Fixed some issues and cleanup of ultrasoc-smb
Date:   Tue, 21 Nov 2023 11:34:25 +0000
Message-Id: <170056635762.1849067.1328149375461591438.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114133346.30489-1-hejunhao3@huawei.com>
References: <20231114133346.30489-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 21:33:42 +0800, Junhao He wrote:
> Fix the Three issues listed below and use guards to cleanup
> a) Fixed the BUG of atomic-sleep
> b) Fixed uninitialized before use buf_hw_base
> c) Fixed use unreset SMB buffer
> 
> Changes since V2:
>  * Ignore the return value of smb_config_inport()
> 
> [...]

Applied, first 3 patches to fixes

[1/4] coresight: ultrasoc-smb: Fix sleep while close preempt in enable_smb
      https://git.kernel.org/coresight/c/b8411287aef4
[2/4] coresight: ultrasoc-smb: Config SMB buffer before register sink
      https://git.kernel.org/coresight/c/830a7f54db10
[3/4] coresight: ultrasoc-smb: Fix uninitialized before use buf_hw_base
      https://git.kernel.org/coresight/c/862c135bde8b

And the last one to next branch

[4/4] coresight: ultrasoc-smb: Use guards to cleanup
      https://git.kernel.org/coresight/c/60e5f23dc5d6

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
