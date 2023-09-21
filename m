Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0E7AA4CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjIUWVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjIUWUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:20:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20FA9F7;
        Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B06C433D9;
        Thu, 21 Sep 2023 06:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695277858;
        bh=T+AarZU1OTWE4tfG5KCNEN7xu+9uCv63xpcrlLBPzs4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=F8spp6f20lSgSPHJDALIiU808mf39UoqBTNdF7qImjbNCJwTFAC3eIT2dM1d9jnJx
         Hz7Ek/XGl4FJw8IyEj87AlnDMKzuVWv2Jyn50UdvQz54g8Pda4wteEZiOpW/e606MW
         aiQ+wR1I9Zzr5RI1fXHVsD6oki6FitbWIfn8AMbAIz0iwUpoQh+fREph4mexqnHQm+
         CDt8pTl83zrSp3k8q50qdg3OsV+ag3dJcCuF0cxmfBx6cbMdcYsav3J3rKJrbW62TD
         ucDYT+V8I9UpkPPQPbR3w1onrFv9hIr47UeFE3OL8c05hPDHSDmJ+be9gmwtjb4mH/
         0Tlelv86F33bQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ipw2x00: Annotate struct libipw_txb with
 __counted_by
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230915200602.never.582-kees@kernel.org>
References: <20230915200602.never.582-kees@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169527785383.1469888.6111719451945571724.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 06:30:55 +0000 (UTC)
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
> As found with Coccinelle[1], add __counted_by for struct libipw_txb.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied to wireless-next.git, thanks.

357be7ebba38 wifi: ipw2x00: Annotate struct libipw_txb with __counted_by

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230915200602.never.582-kees@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

