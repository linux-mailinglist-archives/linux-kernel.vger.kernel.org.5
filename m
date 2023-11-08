Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298607E59B9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjKHPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjKHPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:10:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD901BEB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBCC4C433C8;
        Wed,  8 Nov 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699456224;
        bh=XbGlPv0b5SBtEHY5S7d59XMF5q67mjyCN580ztwB5g0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=doeTyDK4syh9T3j7FPWKQIetDfn7fnuG4nN7/SG2rDekGh8OSN1jrkWo2nVi0gx67
         hPjS/DkmIWSesyRgnDW7i+YKIM7ymlI80hlfWg8Bpl7KlXckULmzlKkKhvHpGZLQaZ
         1H4BQ+VYLkUUoil281vfOEIEbI3YzGKR1YX1pAw2Ejjl4fSwM+7Bq8szxavREhinbk
         2NiwyOVj1UfaARh/0oOv8TAc9DsjZPT55Uej5elzIen6JwSLXzTKt+YL3OWZQzQCOX
         Ih4KHTdYNco32SlWUGbiS+6+OTmeDxi/cJu2g4aOb4VMVAPMRX3L9R3wyEH7JLqw/u
         d3YVNYWslH7fw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1522E00086;
        Wed,  8 Nov 2023 15:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/3] riscv: Add remaining module relocations and tests
From:   patchwork-bot+linux-riscv@kernel.org
Message-Id: <169945622385.21527.15015500547019936050.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Nov 2023 15:10:23 +0000
References: <20231101-module_relocations-v9-0-8dfa3483c400@rivosinc.com>
In-Reply-To: <20231101-module_relocations-v9-0-8dfa3483c400@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
Cc:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        keescook@chromium.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, schwab@linux-m68k.org,
        emil.renner.berthing@canonical.com, samuel.holland@sifive.com,
        nelson@rivosinc.com, kernel@esmil.dk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 01 Nov 2023 11:32:58 -0700 you wrote:
> A handful of module relocations were missing, this patch includes the
> remaining ones. I also wrote some test cases to ensure that module
> loading works properly. Some relocations cannot be supported in the
> kernel, these include the ones that rely on thread local storage and
> dynamic linking.
> 
> This patch also overhauls the implementation of ADD/SUB/SET/ULEB128
> relocations to handle overflow. "Overflow" is different for ULEB128
> since it is a variable-length encoding that the compiler can be expected
> to generate enough space for. Instead of overflowing, ULEB128 will
> expand into the next 8-bit segment of the location.
> 
> [...]

Here is the summary with links:
  - [v9,1/3] riscv: Avoid unaligned access when relocating modules
    https://git.kernel.org/riscv/c/8cbe0accc4a6
  - [v9,2/3] riscv: Add remaining module relocations
    https://git.kernel.org/riscv/c/8fd6c5142395
  - [v9,3/3] riscv: Add tests for riscv module loading
    https://git.kernel.org/riscv/c/af71bc194916

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


