Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7459A7A47D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbjIRLF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbjIRLFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:05:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B832B8F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:05:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D3FC433C7;
        Mon, 18 Sep 2023 11:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695035138;
        bh=OusBitTXja26g2/1PNjAYWaMy6mzH0kGjNXfgu3Dk9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n7Doio/67bK4HMntfPKGwYvvvT5BlncmNWBKLngz2TpBlzhK8pQA30qNttjJu1324
         1XoJ9Jq+Nn9Z2Zvw70mB5rPxCo3Npbm6OZDHaKii+IQXU0S2e4B7uCqcwzUPpHw/3i
         NxawQ8mepmHNAbv7rjnFVyrZ93lsfLH7cE7oOSHZpvebuNln8O0n5sYVsc1ukEjI07
         KgQgPTRs4jegWUWIRLY8LZd2q3d+h3l/NPG+4sF7PSkRhCWSsHPUSOHmCtiwFxWO9S
         ZOd3eGBEh7E7NlqBYdNVqqvRePj+kxa0TfxsKbIpOZH0WHIEqRVZIOGOncKwGqhl62
         mC3EyIJFO6zQQ==
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] arm64: Add some missing userspace ABI documentation
Date:   Mon, 18 Sep 2023 12:05:15 +0100
Message-Id: <169503047379.1328612.6715103972434171186.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
References: <20230914-arm64-feat-hbc-doc-v1-0-797d25f06897@kernel.org>
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

On Thu, 14 Sep 2023 11:09:28 +0100, Mark Brown wrote:
> I noticed that we've added HWCAP2_HBC without updating the
> documentation, and in the process also noticed that some user visible
> fields in ID_AA64ISAR2_EL1 are not documented.  Fix these issues.
> 
> Given the lack of any automatic generation or auditing there's almost
> certainly more fields that are broken in cpu-feature-registers.rst, I
> didn't check any other registers.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64/hbc: Document HWCAP2_HBC
      https://git.kernel.org/arm64/c/5ad361f42fe4
[2/2] arm64: Document missing userspace visible fields in ID_AA64ISAR2_EL1
      https://git.kernel.org/arm64/c/44a5b6b5c7fe

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
