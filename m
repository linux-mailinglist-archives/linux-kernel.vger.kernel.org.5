Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4CE7AA1B1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjIUVFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjIUVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:04:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14527B957;
        Thu, 21 Sep 2023 10:37:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288E2C116AF;
        Thu, 21 Sep 2023 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283781;
        bh=CRChqGGo4RR2euNwhsDyCD/AoeyKktzzjOKjh37j308=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=U6NPZ+8WyNsZOrY2Ac+ioT6/gPDw2ATD5O9tV01TxCmDZ6+hXu1KPDEIz3a3Gtwqx
         tKsvCJSSNEHimX8QPbVZQJ4UTZG4trO9kwulY4CGG1iwMP3qdSH0L3z5X/N9NfDFTs
         2lCfQEvwcgBc8JcV3rpcBvh779jTDhW9ZYVktRfLINCxVbeWSUqjqeqr1H7Y3KaCi9
         5FHGysRq9RRBkxkT+7NXxvkZBnHbVe7pX4kVgVqaQ4ADoRTodYgJTD/8oPWCJZVggu
         hFQIs+fghTAVHf54bge5tZrM34SrNJyWsXFComQWwYojGcRYn9khtN5vaM4m88eMX0
         /wYF0Fl26L6Og==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wcn36xx: Annotate struct wcn36xx_hal_ind_msg with
 __counted_by
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230915200622.never.820-kees@kernel.org>
References: <20230915200622.never.820-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Kees Cook <keescook@chromium.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528377712.1539628.6973937251769266180.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:09:38 +0000 (UTC)
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
> As found with Coccinelle[1], add __counted_by for struct wcn36xx_hal_ind_msg.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Loic Poulain <loic.poulain@linaro.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: wcn36xx@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f8cbbb224b11 wifi: wcn36xx: Annotate struct wcn36xx_hal_ind_msg with __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230915200622.never.820-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

