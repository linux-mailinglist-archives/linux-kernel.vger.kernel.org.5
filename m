Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4078A14C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 21:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjH0Txq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjH0Txb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 15:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F9BE;
        Sun, 27 Aug 2023 12:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C87E360C81;
        Sun, 27 Aug 2023 19:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11C6C433C8;
        Sun, 27 Aug 2023 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693166008;
        bh=y9yVPCEcriR/n05MjZABboIIo7JC850DcSRHaghnx7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtovuFjDpIERjiLv2YugLZMtEsuWgLiMk9+wmF+eKblmCUf+S2WhOyOqrvqSElWjh
         JDJt3PJqHcY7HI/4eg16UwbWG04t9z/QtpGiJndhYeO1LUi6vKawrmsIotjxo9QOLN
         bkAfJQoTPALMZP2Vw+UrBbiqj7a2M588xV+UCMFNs2a5HyyXLWjtUILW5n4XUfCGF2
         kunGtFxp0iviN49UC9dOCra6mZLehC3F8mEdtNt5NR/eZTN2y2KH+4k8NSjXiGl0h+
         ZLGtHuBzxEeQcMXYn35TM5y0njCnrjf28j9W1tm4cWJgVONBcdxuXL1LaqwoHFRfuF
         xNJdAqYVJ1ZGw==
Date:   Sun, 27 Aug 2023 21:53:08 +0200
From:   Simon Horman <horms@kernel.org>
To:     Michael Chan <michael.chan@broadcom.com>
Cc:     Mikhail Kobuk <m.kobuk@ispras.ru>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
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
Message-ID: <20230827195308.GX3523530@kernel.org>
References: <20230825190443.48375-1-m.kobuk@ispras.ru>
 <20230827165130.GV3523530@kernel.org>
 <CACKFLi=+BL3xZGhEV3_J0pcEu9Xm8QkE6hE0g4RHd9xZqzjD_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLi=+BL3xZGhEV3_J0pcEu9Xm8QkE6hE0g4RHd9xZqzjD_Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 10:29:37AM -0700, Michael Chan wrote:
> On Sun, Aug 27, 2023 at 9:51 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Aug 25, 2023 at 10:04:41PM +0300, Mikhail Kobuk wrote:
> >
> > + Matt Carlson <mcarlson@broadcom.com>
> 
> Matt Carlson is no longer working for Broadcom.

Thanks, got it.

> > > 'tp->irq_max' value is either 1 [L16336] or 5 [L16354], as indicated in
> > > tg3_get_invariants(). Therefore, 'i' can't exceed 4 in tg3_init_one()
> > > that makes (i <= 4) always true. Moreover, 'intmbx' value set at the
> > > last iteration is not used later in it's scope.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > >
> > > Fixes: 78f90dcf184b ("tg3: Move napi_add calls below tg3_get_invariants")
> > > Signed-off-by: Mikhail Kobuk <m.kobuk@ispras.ru>
> > > Reviewed-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> 
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>


