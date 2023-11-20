Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF747F1D88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 20:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjKTTr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 14:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKTTrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 14:47:55 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E1A90;
        Mon, 20 Nov 2023 11:47:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32dff08bbdbso3718471f8f.2;
        Mon, 20 Nov 2023 11:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700509670; x=1701114470; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P1NbJyayl7rt6FsfxDThKJ/TN1TC4Aie6KtIaSx0fd0=;
        b=UohU/ulWwsZgcfy2vzEylgnxx5bLU7S0nEwYn6eHTskfeNKQDS8o7N7GedrF6V7ls7
         5v1S233IzX4D6+nWfCwhE+qphRHBHzSzOEinlkkQL2TtSnae6XM4R5aA6zlYbQ2deYV+
         Xz9kRRyJhAzZ2z8cyc1fhN5xd+vZFr/MxNB1pKMw/nYl8KcpBQxNYJ+Qq7gYQA6iVF6v
         yuvo9dOfjfHmeKnM6tmSJQ5v04qNGqIbD1DMhZb6F/zMX1aTENWlE8SsQFT5c9NePJMD
         k0VpJau22ZGhg/+mTP4YCWUN0z32RYIWNjTxvkNLwf9PJ2k9xKudgTa8EtXI88STXJ4d
         NXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700509670; x=1701114470;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1NbJyayl7rt6FsfxDThKJ/TN1TC4Aie6KtIaSx0fd0=;
        b=FcbdBGDGq5LpKd3rDdJvlego2b3JKUYYnXXQxgIQwng87vrbNkL77ZonmRo8R32zx7
         EF1jNKp9lp38Yqd1ZetVn3T/4Jvh2yi+ME7vtcCSjwBBOrcbGxupOjNiu/k+qFSytZkY
         zukpQXIWa9pgobdrQw78U/5hMj+IK9ZH0oC4gNVd/1DqPjQlF7k2lmQnzlKpE2n6dKoY
         8sgn3uxwRx2+y6VbRyBsxm8cA64ned1rc9NU0GXy2aJzNRQWMhNOtd7OVkZ072zJra68
         wrLhDqe3AM+B4xgmam2TdsANUMPZ4aQ36DtxMdko0qT53KUnac4UG+6g6qHq3NAEj1c6
         04ZA==
X-Gm-Message-State: AOJu0YylmryS9vGBBJ1cKZ0QWaR6v0q/zxqtzAFiQuqcX6tzww5HZ486
        xL5tl43nLAlkaPRdVZ8V9t8=
X-Google-Smtp-Source: AGHT+IGZp5cbk3RB9DaON7psg96oftK35YLWF4oXEA7vWSGtTHa8e9is6Ezi61VGpC3AjWNUZujs8g==
X-Received: by 2002:a5d:5305:0:b0:32f:b3a2:c2eb with SMTP id e5-20020a5d5305000000b0032fb3a2c2ebmr4874644wrv.65.1700509670009;
        Mon, 20 Nov 2023 11:47:50 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d6a85000000b0032d9f32b96csm12112207wru.62.2023.11.20.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 11:47:49 -0800 (PST)
Message-ID: <655bb7e5.5d0a0220.59243.9a2c@mx.google.com>
X-Google-Original-Message-ID: <ZVuObZGhckyhPO6t@Ansuel-xps.>
Date:   Mon, 20 Nov 2023 17:50:53 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY
 if defined for PHY
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
 <20231120094234.1aae153e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120094234.1aae153e@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:42:34AM -0800, Jakub Kicinski wrote:
> On Mon, 20 Nov 2023 14:15:40 +0100 Christian Marangi wrote:
> > Luckly nothing was ever added before the soft_reset call so the ret
> > check (in the case where a PHY didn't had soft_reset defined) although
> > wrong, never caused problems as ret was init 0 at the start of
> > phy_init_hw.
> 
> not currently a bug => no Fixes tag, please

I know it's not a bug but still the referenced commit was wrong. Can I
at least use Ref to reference it?

Due to the changes done to this function, it's hard to catch where the
problem arised with a git blame.

-- 
	Ansuel
