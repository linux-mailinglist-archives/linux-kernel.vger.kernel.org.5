Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B038F7A7A36
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjITLPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjITLPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:15:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE66B4;
        Wed, 20 Sep 2023 04:15:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC11C433C7;
        Wed, 20 Sep 2023 11:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695208516;
        bh=ien7KJ6XrEwO+Bq1GOg+pQVFCdR0bSGZcnV8VgcfewU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=CsrbLcn0B04q8yzKIGWnAmLze/wJn2L3uZ5janCCQPzqPJVzIZMj0qrIRzfMwsaH4
         VDt3AhmEL7/0BjRbm5ksl5MC5S4n1OjDWwtfm3LlqIQcEzk/KckODpRWoOZtugs2J6
         Ci3S8owHmJp8Ka0ju5sHhJbidqzjPy3HPnzKL1bssN9xLyHgLROH8S8VdQAvcamCk9
         YyeIj88LjkjeiTJTsGSwU+uosSamxtbz2EqN7/ZFrMpxCkeeYRZiG/dCId8/dkb0ng
         TNHW+7duY3URUS74lLEmB3lsIs27y+w6dZY7CCQq7aIfmmHV2YQMjnTp1U9bNCKM7f
         TatzLJmdWmlwQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: brcmfmac: firmware: Annotate struct
 brcmf_fw_request
 with __counted_by
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230915200552.never.642-kees@kernel.org>
References: <20230915200552.never.642-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Hector Martin <marcan@marcan.st>,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169520851058.991705.15337054707712499896.kvalo@kernel.org>
Date:   Wed, 20 Sep 2023 11:15:12 +0000 (UTC)
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
> As found with Coccinelle[1], add __counted_by for struct brcmf_fw_request.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>

Patch applied to wireless-next.git, thanks.

45aec443bbb0 wifi: brcmfmac: firmware: Annotate struct brcmf_fw_request with __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230915200552.never.642-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

