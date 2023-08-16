Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E577E8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345510AbjHPS0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345559AbjHPSZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072DC1FE9;
        Wed, 16 Aug 2023 11:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E20F608CC;
        Wed, 16 Aug 2023 18:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7371FC433C7;
        Wed, 16 Aug 2023 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692210342;
        bh=PGLvjTPGnQm+GROAgyXYshu3/VEJnLo1CpFsWMm5OQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1ePwHAKuvO39X60Ic9NYicW9DGdSAWc3HSsZZPLLLwS/o3NB+keVCGwvhIbSy3yP
         nonlABvnnxyalZrL0LfyoQ2MnC8kCLKTP6itI4d7FRJGmBpIi6BX/Hir5Suf2OTES5
         C01ATOtVAOgSWvVfl/BsaA8NhVeB2LvNyR/vFGdkMvUsShbnbNZ3Jt4/QAnjV/6H81
         XjSgqfKJRaIthMdZG5gwVVEibkYFpYZnw8qNLA39XDA+H0vG+8L0Xg8JSZL1j7D/to
         zfltabRF5CU7Ufy97t+gLJGnfH256UIY4dW0PrfAJxCNE8xGIBxvH5Ycy7DHhbDJQI
         JgPlYD5Ql0z3w==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] arm64/sysreg: refactor deprecated strncpy
Date:   Wed, 16 Aug 2023 19:25:26 +0100
Message-Id: <169219745619.1953789.14665350088563020811.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com>
References: <20230811-strncpy-arch-arm64-v2-1-ba84eabffadb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 16:33:51 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1]. Which seems to be the case here due to the forceful setting of `buf`'s
> tail to 0.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on its destination buffer argument which is
> _not_ the case for `strncpy`!
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/sysreg: refactor deprecated strncpy
      https://git.kernel.org/arm64/c/d232606773a0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
