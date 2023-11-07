Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0811C7E41AE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjKGOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbjKGOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:18:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69C1114
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:18:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B973C433CC;
        Tue,  7 Nov 2023 14:18:18 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <linux@armlinux.org.uk>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit registers
Date:   Tue,  7 Nov 2023 14:18:16 +0000
Message-Id: <169936667592.2397489.15353218323570592668.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102183012.1251410-1-ilkka@os.amperecomputing.com>
References: <20231102183012.1251410-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 11:30:12 -0700, Ilkka Koskinen wrote:
> The driver used to truncate several 64-bit registers such as PMCEID[n]
> registers used to describe whether architectural and microarchitectural
> events in range 0x4000-0x401f exist. Due to discarding the bits, the
> driver made the events invisible, even if they existed.
> 
> Moreover, PMCCFILTR and PMCR registers have additional bits in the upper
> 32 bits. This patch makes them available although they aren't currently
> used. Finally, functions handling PMXEVCNTR and PMXEVTYPER registers are
> removed as they not being used at all.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/arm: arm_pmuv3: perf: Don't truncate 64-bit registers
      https://git.kernel.org/arm64/c/403edfa43628

-- 
Catalin

