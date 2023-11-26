Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1401B7F94DC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 19:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjKZSYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 13:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZSYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 13:24:37 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D862AB;
        Sun, 26 Nov 2023 10:24:43 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50ba71356ddso2440961e87.1;
        Sun, 26 Nov 2023 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701023081; x=1701627881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C/uGlnxuMuDdUxZ9ryOoDdOefWXlIx4ao2wXZbsquH8=;
        b=IWZtQvt/3Dl8UBfv4nhKnaoiLeO8NpSi2EODxXKz4xD/iC5+imqA8641kmAvqypCOK
         mGK0Fu1/6ua95pZW5YFDoPc/chERefdopYSo+UwMSKB05qggMpu5/31g3+1wB3W5r4Eo
         tYoWsOWkz52qalwpSRh1yHuMFOXSSPyWwbc2jnx/5lmsMp34ldaDAcR4ccdwsU7Y6xXc
         Anexfhn5NWOBBP9nMBFaj029LmE4PkjOPmzYZ1chxI4IGHzOFZxh9wznbEtb0jnk1/SZ
         QWU0d/FqIgeaKRHCnR1fpDHFvZnyahFGAB4sPi0ejIgW2mHWY14wBrbtZUGLAs8o1FPv
         UhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701023081; x=1701627881;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/uGlnxuMuDdUxZ9ryOoDdOefWXlIx4ao2wXZbsquH8=;
        b=JqrEh93L0sdM3/cJoi64EixWjrN/n+t1nfsn3Cd8ZH6UMkA9qnBq7T5UIVGAjqYznl
         hmQarsIFljhSVnC3zOOZvVscPs3J5iAltWWV3N3BPFrfJxkVi0em+9+STzeP0GJrTsDc
         7HGzfdgDtKvKqOUMveLm+ctMZtxxhWAVZ47LLqF+hTTO0B8fWROtRHpF77+z62QmvSqh
         9/nsZynQiGC+ECyTqX98KXMoNdL4U26fFTOwWIsjDM4/fKeLx5ZuDxjH+0YoPw/wmNAs
         lqVGR89PnydFzM1ELnijkaG9HHI5+LAaoYgOFuuCqKOXLYhwnnuV0CzNTK5kis9aYAUl
         2Ofw==
X-Gm-Message-State: AOJu0YzXGIOEbZPZvOaVhKrsJBNYjLk9+S9F7n2zhraObAwFaXl2+Id9
        +ZHsH68g+glEiJQSFmipmR4=
X-Google-Smtp-Source: AGHT+IFPCeMhwmw31Abui8AUK80VuhrsAEUNtqykwcBuZq5m77KV6axZwO71Mo72oWKCBWCl5Gj46w==
X-Received: by 2002:a05:6512:41b:b0:50b:aa9b:c9ca with SMTP id u27-20020a056512041b00b0050baa9bc9camr2872922lfk.57.1701023080883;
        Sun, 26 Nov 2023 10:24:40 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id ay20-20020a05600c1e1400b0040b42df75fcsm2980792wmb.39.2023.11.26.10.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 10:24:40 -0800 (PST)
Message-ID: <65638d68.050a0220.17be1.86fe@mx.google.com>
X-Google-Original-Message-ID: <ZWONZeChrhxyT_E3@Ansuel-xps.>
Date:   Sun, 26 Nov 2023 19:24:37 +0100
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
Subject: Re: [net-next PATCH 3/3] net: phy: add support for PHY package MMD
 read/write
References: <20231126003748.9600-1-ansuelsmth@gmail.com>
 <20231126003748.9600-3-ansuelsmth@gmail.com>
 <4166bb2a-66ef-4757-b05b-7d5d7a415c67@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4166bb2a-66ef-4757-b05b-7d5d7a415c67@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 07:14:52PM +0100, Andrew Lunn wrote:
> On Sun, Nov 26, 2023 at 01:37:48AM +0100, Christian Marangi wrote:
> > Some PHY in PHY package may require to read/write MMD regs to correctly
> > configure the PHY package.
> > 
> > Add support for these additional required function in both lock and no
> > lock variant.
> 
> You are assuming the PHY only supports C45 over C22. But what about
> those PHYs which have native C45? And maybe don't have C22 at all?
> 
> You should refactor the code of __phy_read_mmd() into a helper and use
> it here.
>

Have to be honest here and chose the ""easy"" way. Was a little scared
by all the complexity with mmd with C45 and C22... The idea was to add
C22 support for now and if used by others extend the function. But I
guess with the generic approach we are taking it's better to handle it
now. Will update this in v2.

-- 
	Ansuel
