Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBEF7A7A32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjITLOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjITLOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:14:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CB7B4;
        Wed, 20 Sep 2023 04:14:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11D0C433C8;
        Wed, 20 Sep 2023 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695208468;
        bh=4ohIM+PR0LkQKum0byuzz3ycyYgyXeMylliHgM3EBoQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ijaRBULS666AbH3P/pJ1eLSNRJVlcFLP2EhIlkqKmf67PK3VEk0FGPCGvEuEQDmS7
         j1aCPJ66Nitqle4/qWtja+jVqxH2qBTrvVvTWPAMlK74IvnTkUNAzuSIhvdakto8VV
         7NNJCtv0QZLkosnal/BdrOVmbQAIvb2TGVVOUd3E6oZbxU8+oSwwktwz/Io2brXEQE
         e1vd39tAiQkcBu2zMneGhhamjGIlwU57BCfvYreadbW3zg6RkfMXtR5oQSzsh/ikRx
         bLfGnluPZKjQ2kpMKSOdr4HuUgpvLexkddvsXwOf5eIQsaHg4WOa2UXIUHSAdebaxJ
         IojSj22oBbFBw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: Annotate struct brcmf_gscan_config with
 __counted_by
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230915200542.never.417-kees@kernel.org>
References: <20230915200542.never.417-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Ryohei Kondo <ryohei.kondo@cypress.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169520846255.991705.4120611293307630241.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 11:14:24 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct brcmf_gscan_config.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Ryohei Kondo <ryohei.kondo@cypress.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

cf74cdc6e581 wifi: brcmfmac: Annotate struct brcmf_gscan_config with __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230915200542.never.417-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

