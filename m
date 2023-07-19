Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E2759243
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjGSKCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjGSKB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:01:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D24B32D74
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:01:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05DBF2F4;
        Wed, 19 Jul 2023 03:01:56 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9976C3F67D;
        Wed, 19 Jul 2023 03:01:11 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH] firmware: smccc: Fix use of uninitialised results structure
Date:   Wed, 19 Jul 2023 11:01:09 +0100
Message-ID: <168976048961.3011073.14153994207646624148.b4-ty@arm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717171702.424253-1-punit.agrawal@bytedance.com>
References: <20230717171702.424253-1-punit.agrawal@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 18:17:02 +0100, Punit Agrawal wrote:
> Commit 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum
> T241-FABRIC-4") moved the initialisation of the SoC version to
> arm_smccc_version_init() but forgot to update the results structure
> and it's usage.
>
> Fix the use of the uninitialised results structure and update the
> error strings.
>
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: smccc: Fix use of uninitialised results structure
      https://git.kernel.org/sudeep.holla/c/d05799d7b4a3
--
Regards,
Sudeep

