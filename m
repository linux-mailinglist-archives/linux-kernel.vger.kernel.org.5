Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1B765BE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjG0TLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjG0TLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:11:05 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0512735;
        Thu, 27 Jul 2023 12:11:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3175f17a7baso1404884f8f.0;
        Thu, 27 Jul 2023 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690485060; x=1691089860;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7zkXhTHvZvOOCcCeSTeuHhsZO3DidrcpdwzgYznxPsY=;
        b=pekMF4x7YAev7j/oPwDgwVLQFf/oPLUMt8SOvqZUQFdx//sDDCKaySmUszJ7CvzrIM
         SjDnFFs+wE08aUOy3tQyJvKZ87NXBiK+wpB+6W2rhbfqXlYA47FsoIoDbhGs1izDMRTn
         Cai/N+tRhbfkSWUbvt3B2xGpriISd3fRsBe55PxtlXaWNuC8GBn3/NYNNG9BfpBA1rN0
         bY1v3460eJZKFSTmq5zAs+LLaV+ipROBz9SdKNVonGLnHklBW3BgcwaCAwU3/sgAb6Er
         3kzZRdTS2FwdZxTT8xL0dZYeAlTLTKn/4RRtYAfznPLUTQ/MQIkv0LAUMvJGuf3uodYh
         giBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485060; x=1691089860;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zkXhTHvZvOOCcCeSTeuHhsZO3DidrcpdwzgYznxPsY=;
        b=lyYwFWjvXG5HMfWLm0QUmQeKb7ZXpDvRyi//lZa164IYbrrvYuj6qhetAnYxHkituy
         xeHGUy8LLkdaT2rXdXsjFmrgA4Mu01Yh+9+lhT7heA+oCEKvtFVz3nQzgLSYg9rZyd10
         XXLzLIQbKgmNKGTpDYam2qQ14bGeZmWhpe1K0AX/QjKWbysXca0BHhy+5v5MnJ8uhcrm
         koDabx5or+xHawzECzOGRovaN7depStgJ3NX6UosxdF3hytI7ObLK6TvFX3z7XueE4rx
         wAn+E9mRNcU9ugmAK7GBEH9hFvNO3UpCcCGfaG4bzURsOeWNrTmi/1lg//eeZKmThRSm
         Yq7w==
X-Gm-Message-State: ABy/qLZ7l5tJa0X0MWMSE7FXkMh9UdmFPyI4zmFt56o3G3DUb3TAJAEv
        AUcG2+TcBkceyZlZtdY/QnLiQoenXESMDQ==
X-Google-Smtp-Source: APBJJlHKPUbLVvNM3gjxxvwdzoZ+s83DYQiDYT3zQK3IEXRl7qDrMoIibO7YNVk9nym5AaysCHGUOA==
X-Received: by 2002:a5d:5004:0:b0:313:ee2e:dae1 with SMTP id e4-20020a5d5004000000b00313ee2edae1mr79532wrt.18.1690485060036;
        Thu, 27 Jul 2023 12:11:00 -0700 (PDT)
Received: from Ansuel-xps. (host-87-19-253-131.retail.telecomitalia.it. [87.19.253.131])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b003063db8f45bsm2804448wrv.23.2023.07.27.12.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 12:10:58 -0700 (PDT)
Message-ID: <64c2c142.5d0a0220.9ae33.deab@mx.google.com>
X-Google-Original-Message-ID: <ZMLBQOagq5+i/lbY@Ansuel-xps.>
Date:   Thu, 27 Jul 2023 21:10:56 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: dsa: qca8k: limit user ports access to
 the first CPU port on setup
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
 <20230726131851.w5ty2mftr7tdl3mi@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726131851.w5ty2mftr7tdl3mi@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:18:51PM +0300, Vladimir Oltean wrote:
> On Mon, Jul 24, 2023 at 05:30:58AM +0200, Christian Marangi wrote:
> > In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
> > the port loop and setup the LOOKUP MEMBER mask for user ports only to
> > the first CPU port.
> > 
> > This is to handle flooding condition where every CPU port is set as
> > target and prevent packet duplication for unknown frames from user ports.
> > 
> > Secondary CPU port LOOKUP MEMBER mask will be setup later when
> > port_change_master will be implemented.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> 
> This is kinda "net.git" material, in the sense that it fixes the current
> driver behavior with device trees from the future, right?

This is not strictly a fix. The secondary CPU (if defined) doesn't have
flood enabled so the switch won't forward packet. It's more of a
cleanup/preparation from my point of view. What do you think?

-- 
	Ansuel
