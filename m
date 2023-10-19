Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A858E7CFE90
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346319AbjJSPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjJSPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:46:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9D593
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:46:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5BBC433C8;
        Thu, 19 Oct 2023 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697730365;
        bh=KzjZ5YErOy5FJDmS8Z/lp6SvmGsF2RscdqURitIPoVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqm/3hBC4PkRRmJtK5Czgyi5jNdPMvAHGvoa6Ct1URtcFKp7qFQ9FBcC/IZ03KjHa
         zpPdnK63zHNAYuDCyjeQdYG1LfrgPdSuA8T4Rep9gtunFKiZ74ZK2acJ6bKTXHr3OT
         zz5bE+3dUkQrhgMjmr4E60FsJRaxzAIzjLlSyBhNv0RCvJvAtIfZMZeBVWpKF0O3BQ
         X1KR8lp0XlEQAECp6xFyuuyqCzsYnlz2SEPSOwlrvelwMJNl/WtB73YAJnB/dcCX12
         VK7f2x+2YDgo8XebDIGKpY2JYiC4KQQNiUf7+X/qEUtH1BUd7JMtHxgfc96vogrmds
         29APoPhhX235A==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drivers: perf: arm_pmuv3: Read PMMIR_EL1 unconditionally
Date:   Thu, 19 Oct 2023 16:45:58 +0100
Message-Id: <169772970439.4092128.7487260663443173139.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231013024354.1289070-1-anshuman.khandual@arm.com>
References: <20231013024354.1289070-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 08:13:54 +0530, Anshuman Khandual wrote:
> Currently the PMUv3 driver only reads PMMIR_EL1 if the PMU implements
> FEAT_PMUv3p4 and the STALL_SLOT event, but the check for STALL_SLOT event
> isn't necessary and can be removed.
> 
> The check for STALL_SLOT event was introduced with the read of PMMIR_EL1 in
> commit f5be3a61fdb5dd11 ("arm64: perf: Add support caps under sysfs")
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers: perf: arm_pmuv3: Read PMMIR_EL1 unconditionally
      https://git.kernel.org/will/c/58f8fc57b1d3

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
