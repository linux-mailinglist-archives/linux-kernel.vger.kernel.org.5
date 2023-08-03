Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5076F0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjHCR2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjHCR2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AA3468B;
        Thu,  3 Aug 2023 10:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D844661E59;
        Thu,  3 Aug 2023 17:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70FEC433C7;
        Thu,  3 Aug 2023 17:28:17 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64/ptrace: Flush FP state when setting ZT0
Date:   Thu,  3 Aug 2023 18:28:15 +0100
Message-Id: <169108367979.2495938.10107968359301663426.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803-arm64-fix-ptrace-zt0-flush-v1-1-72e854eaf96e@kernel.org>
References: <20230803-arm64-fix-ptrace-zt0-flush-v1-1-72e854eaf96e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 01:19:06 +0100, Mark Brown wrote:
> When setting ZT0 via ptrace we do not currently force a reload of the
> floating point register state from memory, do that to ensure that the newly
> set value gets loaded into the registers on next task execution.
> 
> The function was templated off the function for FPSIMD which due to our
> providing the option of embedding a FPSIMD regset within the SVE regset
> does not directly include the flush.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/ptrace: Flush FP state when setting ZT0
      https://git.kernel.org/arm64/c/89a65c3f170e

-- 
Catalin

