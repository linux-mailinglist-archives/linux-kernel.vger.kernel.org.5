Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16669751EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGMKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjGMKUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:20:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584BD136
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:20:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD3BB603F7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:20:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D54C433C7;
        Thu, 13 Jul 2023 10:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689243653;
        bh=mqQoOaszIDpT0cnbYgxLjI5udjLAggZu0hslNTcFt/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7z2d/7KIymboPa5q6v4YsQwNAvt2OMaxKKSbSEPTXbPk9s/vOiWvEPRMh/XkzZEn
         zjk3koEuJRuLWHTA8qI+AqVA8C81f+B6wesAnaGus1eO8fIypSc3ode2ot6wqRaRrh
         kYrfsxQl2blSyyMmZqXXG4pdlyhruNpLOkOIomS/jVZz7w+L+ZnggSS88vsPZJ9C+Q
         znhu4tlgr9Thcu6RPCX755IIX8ti86zEZvEGzIRsvYtjFwuQR046SZwCp3anm8OwaN
         iLPpx/Y4XmMgZWMC3azJHwMhAFdG1ClN4D//rbhtSfTwvznrGZMaMmuSJgGm7xjIl8
         +TyREZJOkZe/Q==
Date:   Thu, 13 Jul 2023 11:20:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: ipaq-micro: Use %*ph for printing hexdump of
 a small buffer
Message-ID: <20230713102049.GN10768@google.com>
References: <20230703140923.2840-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230703140923.2840-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2023, Andy Shevchenko wrote:

> The kernel already has a helper to print a hexdump of a small
> buffer via pointer extension. Use that instead of open coded
> variant.
> 
> In long term it helps to kill pr_cont() or at least narrow down
> its use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: split another change to a separate patch (Lee)
>  drivers/mfd/ipaq-micro.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
