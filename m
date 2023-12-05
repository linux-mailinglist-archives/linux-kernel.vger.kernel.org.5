Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140F5805C15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346844AbjLEPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbjLEPQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:16:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4544D4D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:16:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE85EC433CC;
        Tue,  5 Dec 2023 15:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789417;
        bh=t45Tf9pjrslOXyjLYWNBBfAXjGoL3cs7kS8UutsygGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lq56/nWVtKkYaXFlPjBcw+zNufTw2Tr99CRWVhjBYsn95yup/Dbe2mGqO+lqNFbpG
         QDiAlrRXl26lsvX4KKn/XsHchYLH7cu49Kmwxy0WvGVKr008tnCAcYPNyeu1Nv8C+V
         8AT9ih4lBy1IO4xZF9zMq1EKqNKB/vUJmW9IudSTOsUAwBbWJvB/GJhZ1d5CowgXYf
         PauOnysXwOO7X3G10FTXRJlG272mPDeuagkObickfzTrFqiNJ+I25bSmo9E9eCjUY9
         tnjmhHs3HUVWCy6wX7i2eDDX1yJ/YqZGTASxRXUq1rSv35z0lPxmLB8PA/SwUR0nr8
         KW9rsZ594krNQ==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: vdso32: rename 32-bit debug vdso to vdso32.so.dbg
Date:   Tue,  5 Dec 2023 15:16:32 +0000
Message-Id: <170177699377.3454535.14962966962244524648.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231117125620.1058300-1-masahiroy@kernel.org>
References: <20231117125620.1058300-1-masahiroy@kernel.org>
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

On Fri, 17 Nov 2023 21:56:19 +0900, Masahiro Yamada wrote:
> 'make vdso_install' renames arch/arm64/kernel/vdso32/vdso.so.dbg to
> vdso32.so during installation, which allows 64-bit and 32-bit vdso
> files to be installed in the same directory.
> 
> However, arm64 is the only architecture that requires this renaming.
> 
> To simplify the vdso_install logic, rename the in-tree vdso file so
> its base name matches the installed file name.
> 
> [...]

Applied to arm64 (for-next/kbuild), thanks!

[1/1] arm64: vdso32: rename 32-bit debug vdso to vdso32.so.dbg
      https://git.kernel.org/arm64/c/a099bec7a810

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
