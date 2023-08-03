Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC2976F0A4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjHCR2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbjHCR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525253C0A;
        Thu,  3 Aug 2023 10:28:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9D1C61E57;
        Thu,  3 Aug 2023 17:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B584CC433C7;
        Thu,  3 Aug 2023 17:28:07 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Clear SME state in the target task when setting the VL
Date:   Thu,  3 Aug 2023 18:28:05 +0100
Message-Id: <169108367979.2495938.18347411845620974052.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803-arm64-fix-ptrace-tif-sme-v1-1-88312fd6fbfd@kernel.org>
References: <20230803-arm64-fix-ptrace-tif-sme-v1-1-88312fd6fbfd@kernel.org>
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

On Thu, 03 Aug 2023 00:46:39 +0100, Mark Brown wrote:
> When setting SME vector lengths we clear TIF_SME to reenable SME traps,
> doing a reallocation of the backing storage on next use. We do this using
> clear_thread_flag() which operates on the current thread, meaning that when
> setting the vector length via ptrace we may both not force traps for the
> target task and force a spurious flush of any SME state that the tracing
> task may have.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/fpsimd: Clear SME state in the target task when setting the VL
      https://git.kernel.org/arm64/c/c9bb40b7f786

-- 
Catalin

