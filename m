Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85C7F94D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjKZSXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjKZSXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:23:02 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A02FD;
        Sun, 26 Nov 2023 10:23:08 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b399f0b6fso16491675e9.2;
        Sun, 26 Nov 2023 10:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701022987; x=1701627787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=32Kgy65GMsLf8XkL6oIJi/kljWOhMibn0l/BgxaxYfg=;
        b=iQ3weeMiyOByU/xAk7krzclFicNwnnfeFv6kSr/vwbo1RpY8cbRTRY+6typAvVMaYE
         qfGXnhYdf6Rv8ywe+nMYE330PhCNWk6GgYUeK7QcvdOgKNDPcpGZ8jFCOHguQfN7ta6A
         BlB1ImxW1zHzPll+hJXK9Gyh4GlqU5Mp16loLSxvxEWrs9dkZL/V0h24KDafKJRbi6x1
         cKnjqNd6H8UUs3bg8DRIVHKPqeZKM8CtKDKFC+isMbjEzck7tAq8F1AYjv6uN8lParIl
         IDG65OVU5AVpflCVTfIQo6jzrxcVjbEBFrZMOGqTqa/cHSUXrNdjoTSLu8EpNenR7oUr
         GNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701022987; x=1701627787;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32Kgy65GMsLf8XkL6oIJi/kljWOhMibn0l/BgxaxYfg=;
        b=I+J8jr5YUAgv1iMdfOUZx4JbvGDswqKCyZCsSVTP/m5/U0WoD1Ge4GHJzDKwYDaKTM
         ycmTLmf3Qrs8/81ObJXmOMnTmhwl5zA5oCssqjHt7DfvpJJ0hkyBdkfemDRB79EfFdf2
         dAXOcpHfUVv63BlbeGQF8T0qMvWuImPE3bhkFJ5jWneFGJNRC1XhR/diL7iTpAnDy3tF
         VY5MSXg/dk6FuuE+eBXYDokZBFRktQ2TbqVgkUepOvwCo/Dgnjf+w0ahWWhGrpYqaGpV
         qJCOIHCR1/wpw8hM5Z9PWh3NzTO4v/15nTlyFY/Dw9NLv5l+ehB6Rwf42uk8qx+T+SmF
         k2zQ==
X-Gm-Message-State: AOJu0YwSjdYBl2rm3yci06Gb6rusAfIlDcZjxoehQoFJRXEAnfv/Y7RC
        ++iJ6LMTgT+gW5mHxEkaVzU=
X-Google-Smtp-Source: AGHT+IHRvE+6eFmJy/4vwogqK0ingSN47ZqaKs3YY3XiIy/Nno+ryOBiUPKhRr233n5jAFOika+PEQ==
X-Received: by 2002:a05:600c:3507:b0:40b:3849:4df6 with SMTP id h7-20020a05600c350700b0040b38494df6mr6264480wmq.36.1701022986978;
        Sun, 26 Nov 2023 10:23:06 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c138c00b004063c9f68f2sm11044991wmf.26.2023.11.26.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 10:23:06 -0800 (PST)
Message-ID: <65638d0a.050a0220.5d4fd.3082@mx.google.com>
X-Google-Original-Message-ID: <ZWONB23Wv-jStf9m@Ansuel-xps.>
Date:   Sun, 26 Nov 2023 19:23:03 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        David Epping <david.epping@missinglinkelectronics.com>,
        Harini Katakam <harini.katakam@amd.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/3] net: phy: extend PHY package API to support
 multiple global address
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <cc37984c-13b1-4116-99f8-1a65546c477a@lunn.ch>
 <65638967.5d0a0220.28475.43b3@mx.google.com>
 <240c0d9a-38d9-44fc-a56d-cdd88d9144a9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240c0d9a-38d9-44fc-a56d-cdd88d9144a9@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 07:19:16PM +0100, Andrew Lunn wrote:
> > > static inline int phy_package_read(struct phy_device *phydev,
> > > 				   unsigned int addr_offset, u32 regnum)
> > > {
> > > 	struct phy_package_shared *shared = phydev->shared;
> > > 	int addr = shared->base_addr + addr_offset;
> > 
> > Isn't this problematic if shared is NULL?
> 
> Duh! Yes, it is. But why should shared be NULL? The driver is doing a
> read on the package before the package is created. That is a bug. So
> an Opps is O.K, it helps find the bug. So i would drop the test for
> !shared.

Well yes I think we should assume those API to be called only in
config_once context or in package context. But is it Panic ok? I would
at least use something like BUG() to give descriptive warning instead of
NULL pointer exception. What do you think?

-- 
	Ansuel
