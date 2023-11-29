Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2850E7FD2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjK2Jiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjK2Jir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:38:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50AE19BF;
        Wed, 29 Nov 2023 01:38:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b4734b975so24232135e9.2;
        Wed, 29 Nov 2023 01:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701250732; x=1701855532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5mI0HKn/vKiy/xcbZAPm3s6kn7GxTAZode1MtAhmUiQ=;
        b=iv/8bIZLXhCu5V8I172eo4iGnF9MSRVIL4N9F2OyS0pHY9nuQKz4SvOJ84SeVdX3UB
         dSD69zwhV+ab/vLE4ohJF4aJDJWpGV0hPv/FGQ7zD35cY+2L1szNNrebrIx1UbnFZqGz
         SAtolFjqXLB+wBxl2Kj4zMTpQ+ogFZHEQlk6W2xv6zOlQYgZ61aXJ9MBilCky5OHaUWl
         /D1mITQ46vNiz9jBchPILQKSuLEX/96IFXm/Em/uWklj/6oOUKwVf/22Fuv0Lzvofyig
         UlvRJLXhB/IlSHKoSvrR7KzKFmBHl7NElUXub43ZYayRGGGCMueUNyOtwTvG+FZxwYBs
         TOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701250732; x=1701855532;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mI0HKn/vKiy/xcbZAPm3s6kn7GxTAZode1MtAhmUiQ=;
        b=rK2ZV5o3HGWK3s3qHt3xPBOXzwA42RnH8E66MWUjkO9bb67E7eBHDnFAH+hWBOxOVO
         MbgMRm2NYh+LFawakNVREog4ljOQZEIJCVWIkU5pkaevmoS+Ronu/dLWfc0uDkVtL6oP
         x0D9OzM/Xdl4N0ObVS+SizSkJcY3TdE4X/1IhLvH7uEZ61NYO/YQno/z1Ty7ZBMzDzlu
         W7/84wVUGNEuPqY0u+bg62B3d7MQjGOtQDmyYceH8FRc1qUX/Vlry5WVjkjqodW5S85p
         0pXik8CgFp98Qt/VxevS+V9rXpQa9qXAuZQWa9rgSgrjxhiC6NF/wKCUP/O6AQHJVudQ
         BGcw==
X-Gm-Message-State: AOJu0YxSwoAZKMrNqBjgB5unUEZRPmhnfsmaqRUud8cfU39c/YWOWjEw
        GhR9JesalEH6Ox21Bg/KRCs=
X-Google-Smtp-Source: AGHT+IHNRKGGLP6IM7UfsUbO/Hc7cpE4nb5vtqw5mPYUNmLJZxSivHAsuubTEUAraKQjDR933efJPw==
X-Received: by 2002:a05:600c:4fc5:b0:402:ea96:c09a with SMTP id o5-20020a05600c4fc500b00402ea96c09amr13676520wmq.16.1701250732124;
        Wed, 29 Nov 2023 01:38:52 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id y17-20020a05600c20d100b00405c33a9a12sm586974wmm.0.2023.11.29.01.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 01:38:51 -0800 (PST)
Message-ID: <656706ab.050a0220.dafe7.1925@mx.google.com>
X-Google-Original-Message-ID: <ZWcGqZMC9OcYNGaN@Ansuel-xps.>
Date:   Wed, 29 Nov 2023 10:38:49 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 04/14] net: phy: at803x: move qca83xx stats out
 of generic at803x_priv struct
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-5-ansuelsmth@gmail.com>
 <ZWcEdDFFCs17T5ha@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWcEdDFFCs17T5ha@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:29:24AM +0000, Russell King (Oracle) wrote:
> On Wed, Nov 29, 2023 at 03:12:09AM +0100, Christian Marangi wrote:
> > +struct qca83xx_priv {
> > +	u64 stats[ARRAY_SIZE(qca83xx_hw_stats)];
> > +};
> 
> If QCA83xx is going to use an entirely separate private data structure,
> then it's clearly a separate driver, and it should be separated from
> this driver. Having two incompatible private data structures in
> phydev->priv in the same driver is a recipe for future errors, where
> functions that expect one private data structure may be called when
> the other private data structure is stored in phydev->priv.
> 
> So, if we're going to do this, then the QCA83xx support needs to
> _first_ be split from this driver.
> 

As you notice later, it's really to make the split easier by first
separating all the functions and then moving the function in the
separate files.

Idea was to only move them, ok to make the probe and this change when
the PHY driver is detached but I feel it would make even more changes in
that patch. (Instead of simply removing things from 803x.c)

-- 
	Ansuel
