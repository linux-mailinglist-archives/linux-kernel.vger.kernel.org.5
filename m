Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975C27D7270
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjJYRg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjJYRg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:36:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E9913A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:36:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7EEC433C7;
        Wed, 25 Oct 2023 17:36:52 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: pi: add early_map_kernel prototype
Date:   Wed, 25 Oct 2023 18:36:50 +0100
Message-Id: <169825533063.4037196.14787641414816972640.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231025071942.2879030-1-arnd@kernel.org>
References: <20231025071942.2879030-1-arnd@kernel.org>
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

On Wed, 25 Oct 2023 09:19:31 +0200, Arnd Bergmann wrote:
> The newly added function only has a caller from assembler code, so it
> works without an extern prototype, but we get a warning if it's missing:
> 
> arch/arm64/kernel/pi/map_kernel.c:224:24: error: no previous prototype for 'early_map_kernel' [-Werror=missing-prototypes]
> 
> 

Applied to arm64 (for-next/lpa2-stage1), thanks!

[1/1] arm64: pi: add early_map_kernel prototype
      https://git.kernel.org/arm64/c/8d05e7b6eec9

We are still checking whether the recent CKI reports are caused by this
branch, so I may drop it before the merging window (fully or partially).

-- 
Catalin

