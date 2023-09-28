Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EAA7B1D80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjI1NTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjI1NTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:19:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA10F198
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 06:19:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09001C433C7;
        Thu, 28 Sep 2023 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695907143;
        bh=8l855paMpisQ8BnFgqzn2BgtFvGKMSSqtjp/a+DoKxU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=O3vMiUmhJ7819yHIL0nzq4Rv2vjPxgb/Koexs7YvoV6IpB3qyhDFAfMZthbiSSWwM
         bdesJ+F0nR4Jce+s18QMncmTmm1hMQIyI5wSHK4B97mbn2kKXOfw1ll+YIWSD+RTO8
         O6SV4swKZuYonJW5n0djQBU3xtjVIE6i1lfNe0eWbLqfsmZ4ToesncGn8J4Lhi/hxW
         5FXPkc5EaUM9Pwew3WXQN1Hef+dzM6uqVZT7QguVdIOq52jQ67xyB4rws5KUVCYTs8
         6XJRh3Zl8/tzSGJFYslkmz0Gfu00fK4TV/UOm8hWzPX7egmwzehy/uFb76SicWsoMs
         itQgBc0LIb/ew==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
In-Reply-To: <20230922175337.work.150-kees@kernel.org>
References: <20230922175337.work.150-kees@kernel.org>
Subject: Re: (subset) [PATCH] mfd: iqs62x: Annotate struct iqs62x_fw_blk
 with __counted_by
Message-Id: <169590714175.1589941.812131543584091523.b4-ty@kernel.org>
Date:   Thu, 28 Sep 2023 14:19:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2023 10:53:38 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct iqs62x_fw_blk.
> 
> [...]

Applied, thanks!

[1/1] mfd: iqs62x: Annotate struct iqs62x_fw_blk with __counted_by
      commit: d25fad59146b4fb24f690bc0bedd32a299bc1541

--
Lee Jones [李琼斯]

