Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDF380121B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379053AbjLARwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:52:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11392AC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:52:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB320C433C7;
        Fri,  1 Dec 2023 17:52:24 +0000 (UTC)
Date:   Fri, 1 Dec 2023 17:52:22 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 6.7-rc4
Message-ID: <ZWodVqC4gvcASpba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fix below. Thanks.

The following changes since commit c0a8574204054effad6ac83cc75c02576e2985fe:

  arm64: add dependency between vmlinuz.efi and Image (2023-11-23 19:10:29 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to f5259997f3e8d6edfcc2daf5b2c0b34f074d7bc0:

  arm64: Avoid enabling KPTI unnecessarily (2023-11-30 19:07:33 +0000)

----------------------------------------------------------------
Fix a 6.7-rc1 regression where the arm64 KPTI ends up enabled even on
systems that don't need it.

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64: Avoid enabling KPTI unnecessarily

 arch/arm64/kernel/cpufeature.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
Catalin
