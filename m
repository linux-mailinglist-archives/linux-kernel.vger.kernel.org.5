Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE26C7AE0D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjIYVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjIYVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:37:00 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D1E194;
        Mon, 25 Sep 2023 14:36:51 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 294D2C0004;
        Mon, 25 Sep 2023 21:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695677809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zyQR+FXwt/TZA0WIxWRqOGY3Y73PyOWlb1rrHXXeJg8=;
        b=hOsheLCcmIbbRpIhtLk8Tn0xYBPqRaRyuqd5SuV2DUbZiI36ESAPCBmPbP7DtOWE5JJpQb
        mpo2Kz1i+D3Sor48ukixPNGN+YvI5us9uoALnqlhqeLORQsZ1uMOEN7dny8iqnvQ1zjgOG
        n48jUAdmP8o0MtO3GyUYxkIZg5MM47kc6nhyv70VJ75Yu3/hnaWM56Iu9BQsEweUFpZsIB
        EMz8ivgBNg2cj2y2lEtZW/bRS31nBkve1M2W10qo8zbHHLFEJo8bFmzbItI/28BZxdpNrB
        3gUKz5ekq92iVLRe+0cwaLuxseQ6tNqGD0R0+Q60LRYwIyGbjPrykTzPl4FfUw==
Date:   Mon, 25 Sep 2023 23:36:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>, linux-i3c@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matt Johnston <matt@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jack Chen <zenghuchen@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i3c: dw: Annotate struct dw_i3c_xfer with __counted_by
Message-ID: <169567773737.243402.14069734796583624800.b4-ty@bootlin.com>
References: <20230922175011.work.800-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922175011.work.800-kees@kernel.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 22 Sep 2023 10:50:11 -0700, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct dw_i3c_xfer.
> 
> [...]

Applied, thanks!

[1/1] i3c: dw: Annotate struct dw_i3c_xfer with __counted_by
      commit: 014c9a0e6f9ff573099051e1e2ff6efc3470d02d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
