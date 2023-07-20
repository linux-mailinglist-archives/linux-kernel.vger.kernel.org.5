Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57C675AE07
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjGTMOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGTMOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:14:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D637F211F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 05:13:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5846761A44
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:13:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EA7C433CA;
        Thu, 20 Jul 2023 12:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689855233;
        bh=a4GPLMYyVzS5y8TygrO3q2wgNRTfQbvJNGpftM161B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e0lj1F5exYr7W+a4Pg+cJY/U7sJLnj+aKJtHXgzOjlvPR7RSbrD9p+2xXU1cbPmEx
         mJR0zbbAiGMJBmSvgsV0H/2STv6RqozhJSBQ9KEjY3SFdtDrLbk4KsLy4kXQ6Ch9qE
         jXxU+iDSvlMlgZSdcxOLxV0VgMU1jz4ez8x2tqeC9tiYmVGufniJHteJn/yuXMhONf
         6maCaaBXrQnlPwZsc8favuBqO+H2pD511hX0Ha909c5Wo9+hsTSHaWQaRnmThE3C0o
         98Epqjt53Pde6e3eADZ6EK/6dlIy5uo8HPfQbX3UL3L2qJDErPlK8s0C0NIvUGfkOr
         K1JTVPPnogBsg==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: vdso: Clear common make C=2 warnings
Date:   Thu, 20 Jul 2023 13:13:47 +0100
Message-Id: <168985010702.750748.12045685703267985757.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230713115831.777-1-thunder.leizhen@huawei.com>
References: <20230713115831.777-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 19:58:31 +0800, Zhen Lei wrote:
> make C=2 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- xxx.o
> 
> When I use the command above to do a 'make C=2' check on any object file,
> the following warnings are always output:
> 
>   CHECK   arch/arm64/kernel/vdso/vgettimeofday.c
> arch/arm64/kernel/vdso/vgettimeofday.c:9:5: warning:
>  symbol '__kernel_clock_gettime' was not declared. Should it be static?
> arch/arm64/kernel/vdso/vgettimeofday.c:15:5: warning:
>  symbol '__kernel_gettimeofday' was not declared. Should it be static?
> arch/arm64/kernel/vdso/vgettimeofday.c:21:5: warning:
>  symbol '__kernel_clock_getres' was not declared. Should it be static?
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: vdso: Clear common make C=2 warnings
      https://git.kernel.org/arm64/c/71e06e1acecb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
