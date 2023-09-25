Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3707ADD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjIYRLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjIYRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:11:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E6116
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:10:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7521C433C8;
        Mon, 25 Sep 2023 17:10:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64/fp: Remove vector length pseudo registers
Date:   Mon, 25 Sep 2023 18:10:51 +0100
Message-Id: <169566184800.219467.13981427295646817430.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230913-arm64-vec-len-cpufeature-v1-0-cc69b0600a8a@kernel.org>
References: <20230913-arm64-vec-len-cpufeature-v1-0-cc69b0600a8a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 15:48:11 +0100, Mark Brown wrote:
> Since the pseudo registers used by the cpufeature code for the maximum
> SVE and SME vector length appear to be unneeded other than as a double
> check of the full vector length enumeration.  As discussed when fixing
> warnings from the pseudo register code let's simplify things by just
> removing those registers and relying entirely on the full enumeration.
> 
> 
> [...]

Applied to arm64 (for-next/sve-remove-pseudo-regs), thanks!

[1/2] arm64/sve: Remove ZCR pseudo register from cpufeature code
      https://git.kernel.org/arm64/c/abef0695f966
[2/2] arm64/sve: Remove SMCR pseudo register from cpufeature code
      https://git.kernel.org/arm64/c/391208485c3a

-- 
Catalin

