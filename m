Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A27977FE36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354627AbjHQSyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239507AbjHQSyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:54:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3E9E48
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE4F767764
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F98C433C7;
        Thu, 17 Aug 2023 18:54:39 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Spickett <David.Spickett@arm.com>
Subject: Re: [PATCH v2] arm64/ptrace: Ensure that the task sees ZT writes on first use
Date:   Thu, 17 Aug 2023 19:54:37 +0100
Message-Id: <169229846428.1184154.5773484111290413905.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816-arm64-zt-ptrace-first-use-v2-1-00aa82847e28@kernel.org>
References: <20230816-arm64-zt-ptrace-first-use-v2-1-00aa82847e28@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 19:40:07 +0100, Mark Brown wrote:
> When the value of ZT is set via ptrace we don't disable traps for SME.
> This means that when a the task has never used SME before then the value
> set via ptrace will never be seen by the target task since it will
> trigger a SME access trap which will flush the register state.
> 
> Disable SME traps when setting ZT, this means we also need to allocate
> storage for SVE if it is not already allocated, for the benefit of
> streaming SVE.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/ptrace: Ensure that the task sees ZT writes on first use
      https://git.kernel.org/arm64/c/2f43f549cd0b

-- 
Catalin

