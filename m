Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F65811AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379322AbjLMRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379385AbjLMRZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:25:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F9AF3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:25:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CFEC433C8;
        Wed, 13 Dec 2023 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702488333;
        bh=GtbLTnJw5rFoK0rP15arBSE3OgmfBkXPDeM9z0GJ5ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J28pqTwYDp0mBb8bP1o+zNlpRsT0ReB4N8S1dSs/sWF2c0hgsUqyEK8guK2sofO96
         XPPOra6u72Q7Vdg7gMFs9FxWAlHZa+ntotNiHJkARBPtCmzjWo6utPjF/rRhhi+VNT
         MgNUgJ8AlU7lErNPupvGqDc1VRdincBPuxtpaJOMViD/QSTpIYArkPgStDObY2hcd/
         jlKBjsEw/Xp0ch+VNHytq5HQEwhIZ8Tc4ysmtQV2JnSsE4AEjmmDN2Rk+JmRji4wu7
         NUQ1C2Qy5u/tXu1SgWSzfNxURKCdgLnYIWi8+KreaR7hgRTqvV0dCbBSPxkLza/PC+
         p3u2cl0f3WOrw==
From:   Will Deacon <will@kernel.org>
To:     yangyicong@huawei.com, Jonathan.Cameron@huawei.com,
        ilkka@os.amperecomputing.com, robin.murphy@arm.com,
        kaishen@linux.alibaba.com, Shuai Xue <xueshuai@linux.alibaba.com>,
        helgaas@kernel.org, baolin.wang@linux.alibaba.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, renyu.zj@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, mark.rutland@arm.com,
        rdunlap@infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v12 0/5] drivers/perf: add Synopsys DesignWare PCIe PMU driver support
Date:   Wed, 13 Dec 2023 17:25:20 +0000
Message-Id: <170247454282.4025634.10934949931800191482.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 10:56:47 +0800, Shuai Xue wrote:
> Change Log
> ==========
> change sinces v11:
> - Fix uninitialized symbol 'now' (Per Dan and Will)
> - Pick up Reviewed-and-tested-by tag from Ilkka for Patch 4/5
> 
> change sinces v10:
> - Rename to pci_clear_and_set_config_dword() to retain the "config"
>   information and match the other accessors. (Per Bjorn)
> - Align pci_clear_and_set_config_dword() and its call site (Per Bjorn)
> - Polish commit log (Per Bjorn)
> - Simplify dwc_pcie_pmu_time_based_event_enable() with bool value (Per Ilkka)
> - Fix dwc_pcie_register_dev() return value (Per Ilkka)
> - Fix vesc capability discovery by pdev->vendor (Per Ilkka)
> - pick up Acked-by tag from Bjorn for Patch 3/5
> - pick up Tested-by tag from Ilkka for all patch set
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/5] docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
      https://git.kernel.org/will/c/cae40614cdd6
[2/5] PCI: Add Alibaba Vendor ID to linux/pci_ids.h
      https://git.kernel.org/will/c/ad6534c626fe
[3/5] PCI: Move pci_clear_and_set_dword() helper to PCI header
      https://git.kernel.org/will/c/ac16087134b8
[4/5] drivers/perf: add DesignWare PCIe PMU driver
      https://git.kernel.org/will/c/af9597adc2f1
[5/5] MAINTAINERS: add maintainers for DesignWare PCIe PMU driver
      https://git.kernel.org/will/c/f56bb3de66bc

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
