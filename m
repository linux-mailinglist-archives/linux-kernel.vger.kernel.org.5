Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D368780E03
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377513AbjHRO1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377773AbjHRO12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:27:28 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334743AA4;
        Fri, 18 Aug 2023 07:27:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ba0f27a4c2so14398021fa.2;
        Fri, 18 Aug 2023 07:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692368845; x=1692973645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nICDKRwKMQkqe3HwAbJtM6Bw2V+q3zLOKjsFDW01ra4=;
        b=AU47LW5+I/EbL8MV01rBcH3Ob7wkYjXFsx/cRI9MJQxbuDOxjgSr/c0XTuVeglogzU
         JvPZS94xQNLsLcUf1a1VOJ96d7064ckBmJxicT1/wgcIi7RHBS8byjqD18s6HTHOKR8O
         0BbJ2zOYojrvqizOvhFns4fBJVRdpF5rJvhsSJC3VUhFrHooLmjiJTzAS7ycoHiFVHVk
         OSMbeZCNaJIDKj1L4CRLDKuE9/sOd8ATROWpNpN+LTc/giS525+5tHGQiNkdxJfkBJ47
         2VLr8SX4rackx22R7DYZrt5UoE5O5UPAHir1GRDfQ6Gw6W043YuZTuP0nqDBgxzEcq6p
         lPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692368845; x=1692973645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nICDKRwKMQkqe3HwAbJtM6Bw2V+q3zLOKjsFDW01ra4=;
        b=Lr6zOifY5O0ER5zyLCDzrK0xeg561MS/xp5LJcnwhyJfsgX+vEbFHLgEVU5TkC1Gjj
         p9Mroe+Bqk0PvYtCfGt8RvpdXGFuJpMbtZFN3SHUB55No7QEsvsbMuzzdMA8kU95t4rD
         pWzFSY0r+mlpBj12bd1Px1J1JsryMilESlTaIF/R7LVVAhOYUmel2bUYEQN+sAEHMPhV
         DSkfwKAX7vH5TlVXM65ZnGByKo8//zGoA0UmZqp55UCSug7RvEBu0nlVAXF3ZG62ALqO
         314lSe5L4392v5OcZdS8uEU8amIgm9ldNjguoUdE6pbJ0wi35gdmoajGxaKhJsE8tytF
         vixg==
X-Gm-Message-State: AOJu0YzRH9vUEO9QiBBUW9E41j47tcuAUYGE4itZV8lTq9HbxJP9Jltc
        Qkzeug0TR9cJUf6Sfwos7w4=
X-Google-Smtp-Source: AGHT+IE1rMg1r5m+sggiJZoK18DpySxLsUpndg9+6FcuR87MfeypkypRS62hRUnz7MG1A1vtPWuK6w==
X-Received: by 2002:a2e:3304:0:b0:2b9:e40a:30bc with SMTP id d4-20020a2e3304000000b002b9e40a30bcmr1959890ljc.19.1692368845278;
        Fri, 18 Aug 2023 07:27:25 -0700 (PDT)
Received: from mobilestation ([93.157.254.210])
        by smtp.gmail.com with ESMTPSA id n13-20020a2e720d000000b002b9e0aeff68sm453953ljc.95.2023.08.18.07.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 07:27:24 -0700 (PDT)
Date:   Fri, 18 Aug 2023 17:27:22 +0300
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
Subject: Re: [PATCH net] net: phy: Fix deadlocking in phy_error() invocation
Message-ID: <mk5yter5d6pvdyahfhfruszwp54immvfb3bb7a7chofyhauksb@7vkgyxevt2yv>
References: <20230818125449.32061-1-fancer.lancer@gmail.com>
 <6e52f88e-73ad-4e2a-90ca-ada471f30b9d@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e52f88e-73ad-4e2a-90ca-ada471f30b9d@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 03:07:49PM +0200, Andrew Lunn wrote:
> On Fri, Aug 18, 2023 at 03:54:45PM +0300, Serge Semin wrote:
> >  static void phy_process_error(struct phy_device *phydev)
> >  {
> > -	mutex_lock(&phydev->lock);
> > +	/* phydev->lock must be held for the state change to be safe */
> > +	if (!mutex_is_locked(&phydev->lock))
> > +		phydev_err(phydev, "PHY-device data unsafe context\n");
> > +
> >  	phydev->state = PHY_ERROR;
> > -	mutex_unlock(&phydev->lock);
> >  
> >  	phy_trigger_machine(phydev);
> >  }
> 
> Thanks for the patch Serge. It looks like a good implementation of
> what i suggested. But thinking about it further, if the error ever
> appears in somebodies kernel log, there is probably not enough
> information to actually fix it. There is no call path. So i think it
> should actually use WARN_ON_ONCE() so we get a stack trace.

A trace is already printed by means of WARN()/WARN_ON()
in the phy_process_error() method callers:
phy_error_precise()
and
phy_error()
Wouldn't it be too much to print it twice in a row?

We can redefine phy_error_precise() and phy_process_error() functions
to something like this:

static void phy_process_error(struct phy_device *phydev,
			      const void *func, int err)
{
	if (__ONCE_LITE_IF(!mutex_is_locked(&phydev->lock)))
		WARN(1, "PHY-device data unsafe context\n");
	else if (func)
		WARN(1, "%pS: returned: %d\n", func, err);
	else
		WARN_ON(1);

	phydev->state = PHY_ERROR;

	phy_trigger_machine(phydev);
}

static void phy_error_precise(struct phy_device *phydev,
			      const void *func, int err)
{
        mutex_lock(&phydev->lock);
        phy_process_error(phydev, func, err);
        mutex_unlock(&phydev->lock);
}

void phy_error(struct phy_device *phydev)
{
	phy_process_error(phydev, NULL, 0);
}
EXPORT_SYMBOL(phy_error);

Though in such implementation phy_error_precise() looks redundant. We
can freely move its body to the single user - phy_state_machine()
function.

Note a positive side effect of this implementation is that potentially
phy_error() can be converted to accepting a function pointer caused
the error (phy_read(), phy_write(), etc). Alternatively if the
conversion would look too bulky, phy_error_preciseI() could be just
EXPORT_SYMBOL()-ed with the PHY-device mutex locking being moved to
phy_state_machine().

> 
> Sorry for changing my mind.

No worries.

-Serge(y)

> 
>     Andrew
> 
> ---
> pw-bot: cr
