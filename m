Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4170B7BE717
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377356AbjJIQ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377337AbjJIQ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:56:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559CE92;
        Mon,  9 Oct 2023 09:56:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E95C433C7;
        Mon,  9 Oct 2023 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696870610;
        bh=8ycG04wbCqlnptoLLTJF+C5YoZDvUS/8Mrka+S8Q4mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9Ros/+95QAn36f+SI8XTQXHbEgsUsrlPEF7PjU46S/0NMcWdech7qsSi0YjzRFwI
         szIbJ3YGYxN4TTzx0UpmMNqDPXreDwJ0oBW6kwrBZIWx7GaL/wHKTNDMOKDK1mOFjK
         lH9Lrk49oYKlCqngUeUQ6X63AvtvryHhouCjwMFh+MpmgP4VRNExOFEXeHbjkYKAvK
         +0YXOoqJbY3B7speTEgtHzQggK81xR5LycRakzbWDAxZBJ0Ku1Ww1rwtq/9firb1iT
         dgum5t/34F1U2+dO8+tyi1jdzIlqFkV0XdvABy8fIkxi+hnOF8VKIvn0cbzYIXRWg/
         Yn0DmAdRA0Hxg==
From:   Will Deacon <will@kernel.org>
To:     robin.murphy@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
        Besar Wicaksono <bwicaksono@nvidia.com>, mark.rutland@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        jonathanh@nvidia.com, rwiley@nvidia.com,
        linux-arm-kernel@lists.infradead.org, efunsten@nvidia.com,
        linux-kernel@vger.kernel.org, treding@nvidia.com,
        linux-tegra@vger.kernel.org, vsethi@nvidia.com
Subject: Re: [PATCH v6] perf: arm_cspmu: Separate Arm and vendor module
Date:   Mon,  9 Oct 2023 17:56:42 +0100
Message-Id: <169651070763.1133315.8714234562874350620.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230821231608.50911-1-bwicaksono@nvidia.com>
References: <20230821231608.50911-1-bwicaksono@nvidia.com>
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

On Mon, 21 Aug 2023 18:16:08 -0500, Besar Wicaksono wrote:
> Arm Coresight PMU driver consists of main standard code and
> vendor backend code. Both are currently built as a single module.
> This patch adds vendor registration API to separate the two to
> keep things modular. The main driver requests each known backend
> module during initialization and defer device binding process.
> The backend module then registers an init callback to the main
> driver and continue the device driver binding process.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf: arm_cspmu: Separate Arm and vendor module
      https://git.kernel.org/will/c/bfc653aa89cb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
