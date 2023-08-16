Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54AB77EA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345376AbjHPUDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345523AbjHPUDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:03:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAEBE55;
        Wed, 16 Aug 2023 13:03:41 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso10917575e87.1;
        Wed, 16 Aug 2023 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692216219; x=1692821019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Klj3a25YDTvMUoJYI3NAS+v515jVBLG+Elnvjn7Ru8=;
        b=NGP1rVBmHPwdLxCh32cLw8EBletEap3y+Otq/Lpo/JDyhTyNm0oImm1QlZLfpK6OxR
         HL5plmjMqk3fzRENM/xqOjjIxfPOLkNrxiWpfqPmUDbktrwKoWMN/mVnFpoVsF0/ENsj
         5v9ahGKg5ZQORupBJOzCGZXGivOCqtDrZtt0WY+0WUMj6QmG7IM2v3Y6dvWxNFKzpyd3
         UrKBZCZmhNfZUqltwlNI2f8EXePdZTgvM6dQNBCYsxPAyWYSwUXqnJwJDI40nKMpn6jG
         /r6CRhGke2z2WxHmeunzfxB8JPc6any9AvOvsPcr8HfcTlGdE3CBmb815TFytdjCiIll
         ZIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692216219; x=1692821019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Klj3a25YDTvMUoJYI3NAS+v515jVBLG+Elnvjn7Ru8=;
        b=G6DltAl4GhFz8HCtobdee2iXL6EHKrliHutLJfFA+utN8tJMZuyXKYqotlGoTYo9nG
         xgSEO/mnkSn5zToI6xzVS+czJLNm/qrSP4bvdgoknCy5YuuQ66ECUBWbaAQ14xmEku1b
         qBu2nlSNpWxMUaSg5H5F3CoiFwt6Q+3EOOpL4EAqna7pvz1uMA5osllGbDzSE4Ygjk/O
         oxvKKk1P/nqFyErQ+7/QbKMcXBluo9avS7y1pki1xyNq4nqhAc8teChB4URFZWVgPnKp
         B56ZdM5J89HAW8HkTe+F2q+EiwTu7dBUgWulBYPRZ6oQmy3tkpNNC2M+wn4GbnMPuRwV
         evdw==
X-Gm-Message-State: AOJu0Yw7DWX/pe+7V07ymWsHIrB7Qj1b8988hld5oCXrXgFcyQEApM1x
        dqQt81Q+nq25k2A1XzwQuJU=
X-Google-Smtp-Source: AGHT+IH7TWAyqJyPpdtOoYkeATZS/wb8LdqVVOTAQIsGooU38gwRuwsGgxMd27SWBZhLyLVGW9cPdg==
X-Received: by 2002:a19:4f46:0:b0:4fb:91c5:fd38 with SMTP id a6-20020a194f46000000b004fb91c5fd38mr2526138lfk.0.1692216219037;
        Wed, 16 Aug 2023 13:03:39 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id t21-20020ac24c15000000b004fe27229f55sm3057080lfq.216.2023.08.16.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:03:38 -0700 (PDT)
Date:   Wed, 16 Aug 2023 23:03:36 +0300
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
Message-ID: <ksgfr3o6nm4k5qhamsqhyardnpb5fm5xclhr4fwpgldhzjlax6@r5ry4ztkqx5c>
References: <20230816180944.19262-1-fancer.lancer@gmail.com>
 <b5ae4bc5-20cb-470b-988c-86353592f1c9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5ae4bc5-20cb-470b-988c-86353592f1c9@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:35:57PM +0200, Andrew Lunn wrote:
> On Wed, Aug 16, 2023 at 09:09:40PM +0300, Serge Semin wrote:
> > Protecting the phy_driver.drv->handle_interrupt() callback invocation by
> > the phy_device.lock mutex causes all the IRQ-capable PHY drivers to lock
> > the mutex twice thus deadlocking on the next calls thread:
> > IRQ: phy_interrupt()
> >      +-> mutex_lock(&phydev->lock); <-------------+
> >          drv->handle_interrupt()                  | Deadlock due to the
> >          +-> phy_error()                          + nested PHY-device
> >              +-> phy_process_error()              | mutex lock
> >                  +-> mutex_lock(&phydev->lock); <-+
> >                      phydev->state = PHY_ERROR;
> >                      mutex_unlock(&phydev->lock);
> >          mutex_unlock(&phydev->lock);
> > 
> > The problem can be easily reproduced just by calling phy_error() from the
> > any PHY-device interrupt handler.
> 
> https://elixir.bootlin.com/linux/v6.5-rc6/source/drivers/net/phy/phy.c#L1201
> 
> /**
>  * phy_error - enter ERROR state for this PHY device
>  * @phydev: target phy_device struct
>  *
>  * Moves the PHY to the ERROR state in response to a read
>  * or write error, and tells the controller the link is down.
>  * Must not be called from interrupt context, or while the
>  * phydev->lock is held.
>  */
> void phy_error(struct phy_device *phydev)
> {
> 	WARN_ON(1);
> 	phy_process_error(phydev);
> }
> EXPORT_SYMBOL(phy_error);
> 
> It is clearly documented you should not do this.
> 
> [Goes and looks]
> 
> Ah, there are lots of examples of
> 
> micrel.c-	irq_status = phy_read(phydev, LAN8814_INTS);
> micrel.c-	if (irq_status < 0) {
> micrel.c:		phy_error(phydev);
> micrel.c-		return IRQ_NONE;
> micrel.c-	}

It's literally the only pattern where the phy_error() method is utilized but
it can be found in all IRQ-capable network PHY drivers. Seeing how
widespread the function usage is I didn't even dared to think that
the function doc could state it can't be utilized like that or when the
lock is held.

> 
> I actually think phy_error() is broken here. The general pattern is
> that the mutex is locked before calling into the driver. So we
> actually want phy_error() to be safe to use with the lock already
> taken. The exceptions when the lock is not held is stuff outside of
> PHY operation, like HWMON, and suspend and resume, plus probe.
> 
> So i suggest you change phy_process_error() to remove the lock.

This doable.

> Maybe
> add a test to ensure the lock is actually held, and do a phydev_err()
> if not.

This can't be done since phy_state_machine() calls phy_error_precise()
which calls phy_process_error() with no phy_device.lock held. Printing the
error in that case would mean an error in the Networking PHY subsystem
itself.

Do you suggest to take the lock before calling phy_error_precise() then?

> 
> The comment about interrupt context is also probably bogus. phylib
> only uses threaded interrupts, and it is safe to block in this
> context.

Ok.

-Serge(y)

> 
> 	Andrew
