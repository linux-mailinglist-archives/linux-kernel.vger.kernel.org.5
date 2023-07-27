Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4877653A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjG0MXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjG0MXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:23:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95E030CF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:22:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 822A561E4D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6B8C433C8;
        Thu, 27 Jul 2023 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460570;
        bh=uSHZMCS+QdpVlEWEJJ1yUZRXGFVv1aUKyHo12anpqX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMvrzPtQ64+Ve8hWB2uyr6/FPm8m1IEExQv0vrlTMOB3B5TEQp2gfEe+wH2lLvWfU
         emIk32NXM4QqOMxBdnCNEOqJfBM86wHDSnT4wu2da4UAzWe1yirluz4UPAkNj6Jpyp
         fwIS441C6An9H4BysC54OLVJPSfvAT6tIfmM2j2lz6Kpia+hcKogxQROweAOI/ITK7
         fY2icnNmrlsjSqGj6z6MEBsYvGKc94zDfBdak0R3w+9ofp9s5XF1+8FW3xPuSgArUr
         VTzumb5OkpUdHZCHpSieVIpfnKXEUTIy7Xh/6dXcWLEJ8DbaCulU88WkijhXFuEhFt
         h5Z7MElsIiN5A==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpufeature: Use ARM64_CPUID_FIELD() to match EVT
Date:   Thu, 27 Jul 2023 13:22:29 +0100
Message-Id: <169045289831.2141149.3361543964043977724.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230718-arm64-evt-cpuid-helper-v1-1-68375d1e6b92@kernel.org>
References: <20230718-arm64-evt-cpuid-helper-v1-1-68375d1e6b92@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 20:45:44 +0100, Mark Brown wrote:
> The recently added Enhanced Virtualization Traps cpufeature does not use
> the ARM64_CPUID_FIELDS() helper, convert it to do so. No functional
> change.
> 
> 

Applied to arm64 (for-next/cpufeature), thanks!

[1/1] arm64/cpufeature: Use ARM64_CPUID_FIELD() to match EVT
      https://git.kernel.org/arm64/c/ce33cea5d833

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
