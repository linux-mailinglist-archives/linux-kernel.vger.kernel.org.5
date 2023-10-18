Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265557CD8F0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjJRKPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjJRKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:15:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFDF7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:15:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9603C433C7;
        Wed, 18 Oct 2023 10:15:29 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: Remove system_uses_lse_atomics()
Date:   Wed, 18 Oct 2023 11:15:27 +0100
Message-Id: <169762410088.3624197.11478109539988963164.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017005036.334067-1-gshan@redhat.com>
References: <20231017005036.334067-1-gshan@redhat.com>
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

On Tue, 17 Oct 2023 10:50:36 +1000, Gavin Shan wrote:
> There are two variants of system_uses_lse_atomics(), depending on
> CONFIG_ARM64_LSE_ATOMICS. The function isn't called anywhere when
> CONFIG_ARM64_LSE_ATOMICS is disabled. It can be directly replaced
> by alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS) when the kernel
> option is enabled.
> 
> No need to keep system_uses_lse_atomics() and just remove it.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: Remove system_uses_lse_atomics()
      https://git.kernel.org/arm64/c/0899a6278a86

-- 
Catalin

