Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE28978A03F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjH0Qrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjH0Qrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:47:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173D9115;
        Sun, 27 Aug 2023 09:47:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8052461505;
        Sun, 27 Aug 2023 16:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967D0C433C7;
        Sun, 27 Aug 2023 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693154849;
        bh=vDhsXRw3WVqEe39LN1DWXuIBT6/LQlWm8E1xNI3unqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjg+7F1GSWyFtE+DXiaCPlKeKcw26jUadcoTS3brl8EMyhipIeakexij739QMZJaU
         7IJqklE3/IHn56kBX8W4wzzPPL0btzpqBrH/Cg9jv1RGfBAGRWZG6a5gBIYWayLFoP
         9IOQ4XJNSL1Tmhymjb5AVnEolL8LZ+SGdJkGntFudRyq68ia2E+mbZHQblPNjFyyK4
         5IIYvtgHuE0Z+g6oFEHTXVSEjhHzpeprl8QTs7sS00AyrNDfJTl+uzq4f4MrohNyLB
         LAgKbmLSDKiQR/t9KRGF/c64Wf/HUrCVw2KT832sInQDcdlrhfCXGrb5+l4KI8nb2z
         lDPFR90KnWjvA==
Date:   Sun, 27 Aug 2023 18:47:13 +0200
From:   Simon Horman <horms@kernel.org>
To:     Mikhail Kobuk <m.kobuk@ispras.ru>
Cc:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: Re: [PATCH] ethernet: tg3: remove unreachable code
Message-ID: <20230827164713.GU3523530@kernel.org>
References: <20230825190443.48375-1-m.kobuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825190443.48375-1-m.kobuk@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:04:41PM +0300, Mikhail Kobuk wrote:
> 'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
> tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
> that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
> last iteration is not used later in it's scope.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 78f90dcf184b ("tg3: Move napi_add calls below tg3_get_invariants")
> Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Simon Horman <horms@kernel.org>

