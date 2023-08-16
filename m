Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1777EAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346112AbjHPUZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346099AbjHPUY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:24:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA32135;
        Wed, 16 Aug 2023 13:24:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe4762173bso11380845e87.3;
        Wed, 16 Aug 2023 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692217496; x=1692822296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvYvmTlBw67pqTM/T/MeNG2dVCDXMrEV8YTwIlKj9dw=;
        b=kM1Floy2sMZplCC4vze7Ged0MeP+RuHg8wKCXt+nWugN3w01AeE7TwCuDqVcVb4fLV
         Vn85WkU8c8ivLwWYYFFgoXbK0sqhSPIIyhOHiSIQyxB93r+cX+8c7AdecN7dzcqiBXdK
         MXGQj2ZvtOH4dbNHEWhKMszR0Oi1PM4458FRqyoo/EFuMcqvvakw9qsRTyfx3TzqAi/w
         8hSBzXq7EstTIj20i3LXBw+kFeZM5Uw0+ZZOXcvKKNO5Gb7X1+PRgPiirXEK4awtS/xg
         m8nFjeWTnbio+Lj6Cbbmj+Rm3sQM2OKLbNutrHmAvKF2DvFSaP10y8LXxcbweD2hNf/W
         i2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692217496; x=1692822296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvYvmTlBw67pqTM/T/MeNG2dVCDXMrEV8YTwIlKj9dw=;
        b=VQ78YHkTYkd5QpySDbm8a31c9ZbSJ7T6kn2WwITSVHOjbCvUhvVm8/0l7SwGO37r1Q
         274CCldIUkHk17e24udEXYiU8TBf8Gz22wQmzcFC4at/20heELdFeUAWxgrmy8bAAvIT
         aIYQ/MUO86ljRsTcdnsCEtogc89cWcLV8VcK40AfkxpNhYLaZ1HiCwLGxXKh52kw2XSa
         OqA4g2FBsKPk8M8KrYrNWNSqKJCTMaXgfA9UK+ejNE/vUogRd6D8SfwxgQ+P4KawukqN
         VxotZkQz8ZvOd/sRclisicMt5JmipbmnFOzRQ5GxtQiHgCYkpoIWCHwTz0NmO02B/AOD
         +tSQ==
X-Gm-Message-State: AOJu0YyxLgjS0NdpA4uq5GGd7/OwxUZ+CPk4sfATml1gyciOWdBdIPYC
        Mjzoxbl4vbdMun8iD1d1zJQ=
X-Google-Smtp-Source: AGHT+IGkln+W5HKIr6pdwkpd9iO3Wp4sWr0uwv+S2F687bdGK6PfhO+19vQtxapeTfIJ9rMZsMRDTQ==
X-Received: by 2002:a05:6512:554:b0:4fb:9129:705b with SMTP id h20-20020a056512055400b004fb9129705bmr2488857lfl.6.1692217496231;
        Wed, 16 Aug 2023 13:24:56 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id r25-20020ac252b9000000b004fe633bfcc7sm3070955lfm.17.2023.08.16.13.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:24:55 -0700 (PDT)
Date:   Wed, 16 Aug 2023 23:24:53 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net] Revert "net: phy: Fix race condition on link status
 change"
Message-ID: <2r3cdvokyuylakhv7d6wjrytatvusdr46grrjuaiohcvnzclyf@ph3hc73wf5gv>
References: <20230816180944.19262-1-fancer.lancer@gmail.com>
 <b5ae4bc5-20cb-470b-988c-86353592f1c9@lunn.ch>
 <ksgfr3o6nm4k5qhamsqhyardnpb5fm5xclhr4fwpgldhzjlax6@r5ry4ztkqx5c>
 <01cf4367-1c2d-4920-a387-3ba38b83dd66@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cf4367-1c2d-4920-a387-3ba38b83dd66@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 10:13:10PM +0200, Andrew Lunn wrote:
> > > So i suggest you change phy_process_error() to remove the lock.
> > 
> > This doable.
> > 
> > > Maybe
> > > add a test to ensure the lock is actually held, and do a phydev_err()
> > > if not.
> > 
> > This can't be done since phy_state_machine() calls phy_error_precise()
> > which calls phy_process_error() with no phy_device.lock held. Printing the
> > error in that case would mean an error in the Networking PHY subsystem
> > itself.
> > 
> > Do you suggest to take the lock before calling phy_error_precise() then?
> 
> Thanks for digging into the details.
> 
> phy_error_precise() is used in exactly one place. So i would actually
> put the lock inside it. And maybe move the comment about not using the
> function with the lock already held here :-)

Ok. I'll resubmit the patch tomorrow with the RFC status dropped.

-Serge(y)

> 
> 	 Andrew
