Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA50763EC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGZSpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjGZSpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A21FF2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:45:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE1DB61C63
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 18:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C323C433C8;
        Wed, 26 Jul 2023 18:45:34 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Set new vector length before reallocating
Date:   Wed, 26 Jul 2023 19:45:31 +0100
Message-Id: <169039710582.703186.12071568238096709534.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230726-arm64-fix-sme-fix-v1-1-7752ec58af27@kernel.org>
References: <20230726-arm64-fix-sme-fix-v1-1-7752ec58af27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 13:12:26 +0100, Mark Brown wrote:
> As part of fixing the allocation of the buffer for SVE state when changing
> SME vector length we introduced an immediate reallocation of the SVE state,
> this is also done when changing the SVE vector length for consistency.
> Unfortunately this reallocation is done prior to writing the new vector
> length to the task struct, meaning the allocation is done with the old
> vector length and can lead to memory corruption due to an undersized buffer
> being used.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/sme: Set new vector length before reallocating
      https://git.kernel.org/arm64/c/05d881b85b48

-- 
Catalin

