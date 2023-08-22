Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC39784BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjHVVA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjHVVAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:00:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9693CCF8;
        Tue, 22 Aug 2023 14:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3403B63358;
        Tue, 22 Aug 2023 21:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872C2C433C8;
        Tue, 22 Aug 2023 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692738021;
        bh=9s7d2BlKpZfct9MmU2wqCDuBw+XrUhkUrnIos303LfA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hvpt+kxzz0ZoaJrECshCxIerc37f8pYNEAIIYQnyWEFxV5w++w+KFfIxVIdGypplB
         uxMHXMnP6hx8Qon2mpG6S4cIjShfEfgg2ZExDqzpU0ymiBzwsfn6UupEaAWhPeG8as
         QguGu470K5zYs6+5hDBfrUOR28VOphNHyxiFhErYEdgA4iNz5rcztlKF1T1USPtj/z
         tryWxDwFuuk/6DDl7EoYHJl0RoA8f2HnmDmD2UaUM1d7c+LdOdpmP7M7qo9GHhNTpx
         QQfbMimFnzV75VOk/0PkrI+p7/v8tRiLt2/oulMiYEOApzN26XC5/+hBi9OYOPaWlU
         YT6RdUhJ4e3rw==
Message-ID: <9c82fe377e9d778d3a5a3de967a3706e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230817202941.never.657-kees@kernel.org>
References: <20230817202941.never.657-kees@kernel.org>
Subject: Re: [PATCH] clk: qcom: clk-spmi-pmic-div: Annotate struct spmi_pmic_div_clk_cc with __counted_by
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
To:     Bjorn Andersson <andersson@kernel.org>,
        Kees Cook <keescook@chromium.org>
Date:   Tue, 22 Aug 2023 14:00:19 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kees Cook (2023-08-17 13:29:42)
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>=20
> As found with Coccinelle[1], add __counted_by for struct spmi_pmic_div_cl=
k_cc.
>=20
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>=20
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Applied to clk-next
