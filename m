Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF73F78B8A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjH1Tpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233461AbjH1Tp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:45:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25FEBE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 869DF650C0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5FFC433C7;
        Mon, 28 Aug 2023 19:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693251926;
        bh=/TFoJ9iNTO+oLdrfv9gPgJ9S3rhJOk+mYgfZoPHhSFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K5gd5DdoeibNNQzbxTcvO9+A4y1uf74jS8uQBsk7DmwzdJtbGND1qDi1u+7Ik/T0c
         Mjf4sFq1IxGg8wGWa8x45ubR3NzRwfb8VPVYj4eqkfmUi56rAwITPDUPDXdRZTBhoE
         vyEIEbhEm0i0GAd6IzvQkpgAivpv0ULzpPsT7ziW4zAQRo4e1CkGRjdB9L+Igvs4S5
         nkJt5IW1Vb5HJf0qHL8l9teQlseQWJlPpiCHP+Y+KUiWWSkVnlqzu8MbZm+FKua/mn
         tOs+4hVh8BytH2BnJSCK0wfcYZz6aasBvsXCSGgtq1YIIX8cISDLheIjqFv172PUKc
         MLoJNXMf1ULZg==
Date:   Mon, 28 Aug 2023 12:45:24 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     haozhe chang <haozhe.chang@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] wwan: core: Use the bitmap API to
 allocate bitmaps
Message-ID: <20230828124524.5ca4da50@kernel.org>
In-Reply-To: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
References: <20230828131953.3721392-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 16:19:53 +0300 Andy Shevchenko wrote:
> Use bitmap_zalloc() and bitmap_free() instead of hand-writing them.
> It is less verbose and it improves the type checking and semantic.
> 
> While at it, add missing header inclusion (should be bitops.h,
> but with the above change it becomes bitmap.h).

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

