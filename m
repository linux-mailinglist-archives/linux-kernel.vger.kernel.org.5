Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA277AA12E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjIUU6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjIUU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:58:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551BE83F4A;
        Thu, 21 Sep 2023 10:37:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E5BC116B0;
        Thu, 21 Sep 2023 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283827;
        bh=88AKbaA+AwhS8raz9bZXjzCE7ETgOOVMKBcCNcy1RpE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=r0+lsAVNF5tR0s5cWaq+Pkxc60xpmpbcvJv/SqRxkRG6zHI3C5bg75kBgkOYtOwEe
         Kdxx/8IEtAOZQC3QfQgQa8sRrxzalbw6e8LvhnZ9ovU7CnyML/rrSgfMckxClATarU
         tgAU1TlJrpmc0fUtqqEvDmQPnxdFywznVuEOoL6ELu7m6Lf655hRfLiNTZxwMIrQ/u
         0iiBWjOduJFDq0Sk8sL+iCGrIRielVtykLyfjCufQSxDPfQJet+KWSYWfyD46/5yQT
         hP3xXkryE1hBnssPwK2DsQpuCcjdw+2INnYpP8q1BpReKsb9NP/cfr6+CV1vss7z+A
         xvhdLX9t1m1Fw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath10k: Annotate struct ath10k_ce_ring with
 __counted_by
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230915200636.never.762-kees@kernel.org>
References: <20230915200636.never.762-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528382314.1539628.5873188832117553584.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:10:24 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
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
> As found with Coccinelle[1], add __counted_by for struct ath10k_ce_ring.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

3f856f29551f wifi: ath10k: Annotate struct ath10k_ce_ring with __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230915200636.never.762-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

