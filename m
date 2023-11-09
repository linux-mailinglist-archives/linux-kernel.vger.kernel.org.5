Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A07E7076
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344754AbjKIRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbjKIRk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:40:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B31BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BB2C433C7;
        Thu,  9 Nov 2023 17:40:21 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2] arm64/syscall: Remove duplicate declaration
Date:   Thu,  9 Nov 2023 17:40:19 +0000
Message-Id: <169955161667.3066721.5021680783111881736.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231109141153.250046-1-kevin.brodsky@arm.com>
References: <20231109141153.250046-1-kevin.brodsky@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Nov 2023 14:11:53 +0000, Kevin Brodsky wrote:
> Commit 6ac19f96515e ("arm64: avoid prototype warnings for syscalls")
> added missing declarations to various syscall wrapper macros. It
> however proved a little too zealous in __SYSCALL_DEFINEx(), as a
> declaration for __arm64_sys##name was already present. A declaration
> is required before the call to ALLOW_ERROR_INJECTION(), so keep
> the original one and remove the new one.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] arm64/syscall: Remove duplicate declaration
      https://git.kernel.org/arm64/c/f86128050d2d

-- 
Catalin

