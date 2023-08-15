Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5675B77C84C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjHOHHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjHOHHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:07:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A6510D2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2CD635AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F48C433C8;
        Tue, 15 Aug 2023 07:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692083227;
        bh=L0E+Jf8ds4KSMC1jMXWy3ZSWVnQ4s+30hFJBjhe745U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pk2WjsSxvBWFYDb4QNIMQD7A/gnUhkxy1awInwPyC0VZ1WPNqKU2MGZDFJChSlfIX
         2l0i0dJIRdYQMmzooAmw0BiyUgfsBtAmisRwoGPwGuXLPlxmbuqKxpWK1IZUYEan0Q
         /FA/FOrBWZCMDEN0MfuL+MloZhO/Movp/IVj8u9HgYVJrijuWcMNqFNsOnByrww9W3
         8AzenrOpI7o+/hpO2KMTzLa7NjAAOvnHkCJCwACJSEPt9z8t/mt5Nm2v7JmcZ8c0DL
         bCoR+0ivt/mNDSQhKOdp6VXNOh3QN7uYPWxAd6bysh5ELcwKhYMg5V2AsoCfyKF6K9
         pHiKL86P4wU5w==
Date:   Tue, 15 Aug 2023 10:07:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] broadcom: b44: Use b44_writephy() return value
Message-ID: <20230815070702.GH22185@unreal>
References: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 12:00:30AM +0300, Artem Chernyshev wrote:
> Return result of b44_writephy() instead of zero to
> deal with possible error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> ---
>  drivers/net/ethernet/broadcom/b44.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
