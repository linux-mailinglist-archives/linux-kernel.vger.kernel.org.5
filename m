Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9F778E11
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbjHKLpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235462AbjHKLpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8E0FA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1C6B67064
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB23C433CC;
        Fri, 11 Aug 2023 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691754309;
        bh=/19kLQzk3e8nwz3P9BU6eSzy1lY4GmblwpCPrLRiBmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhiGAQKcJNLX6VMrh+qGpnI+pRu0mCl/Z8fkXvt+QJE6FGVcrdS924pWYUyJ8IsE+
         z51ovhdQKjvPjr7ZuPIydUP47ot1kgXgIlNnYpgxNWPdVEo157h7q8usca/8NFHNFc
         rfOLvdpQg9X3Qyoxy7tXSU/IcU/JrsZoGaSavxi/aRoPcEqMZ76B4yZ2LsxalLUgKI
         5VU4SInhbyr0otkcTseaIKu6z9bBQgLGR/kohHfXGa4SgMaOMerMzNi6cT55pQACUv
         YEzze21kd7Fjo2a8Mej2w7wzhNOF4GnqSb9KapFQ8k58lAxoEukCMT3iSiqW0YYimB
         oShm78h7IwvMw==
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>, Mark Brown <broonie@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/fpsimd: Only provide the length to cpufeature for xCR registers
Date:   Fri, 11 Aug 2023 12:44:53 +0100
Message-Id: <169165967155.2189311.11595342536402277516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
References: <20230731-arm64-sme-fa64-hotplug-v2-1-7714c00dd902@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 14:58:48 +0100, Mark Brown wrote:
> For both SVE and SME we abuse the generic register field comparison
> support in the cpufeature code as part of our detection of unsupported
> variations in the vector lengths available to PEs, reporting the maximum
> vector lengths via ZCR_EL1.LEN and SMCR_EL1.LEN.  Since these are
> configuration registers rather than identification registers the
> assumptions the cpufeature code makes about how unknown bitfields behave
> are invalid, leading to warnings when SME features like FA64 are enabled
> and we hotplug a CPU:
> 
> [...]

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/fpsimd: Only provide the length to cpufeature for xCR registers
      https://git.kernel.org/arm64/c/01948b09edc3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
