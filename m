Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017CB76375C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjGZNS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjGZNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:18:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F22E2;
        Wed, 26 Jul 2023 06:18:55 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-317786befa2so426108f8f.3;
        Wed, 26 Jul 2023 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690377534; x=1690982334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+JB2WhCrTbUAzlxIGEkRSe99y0JXRIvcoWXTj2YW2I=;
        b=A1nkGFOtEts7VHRubiBaFuz4+TQvcJXjIWx2aC3f/RAXjmaqpmKAWCbXpk66ERHyyc
         13pd07XrnXc65UtbMR3Gs+1CKP7fJQxewMyvjJJJpWThOmDQ7rwkkPA2xbgWD5aWbqDC
         astlKWvEEFlxUJBMpbrF9fw/N7bLPGmfT+ML37Isv77roWF/UtfuWYaZyvwfZsWYDfP1
         odvZdEQsW1hEnavpKxnhEOzcqBHheyN9cqpVZ3aHJp162oqV71RJGSxOq10qY4eUpUGE
         AUovx1gyWsebjepcqHJz0jvYs5Hym2WF5DasLtYPXlHEHVEBWnsUn46zvsy4htAXq306
         s9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377534; x=1690982334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+JB2WhCrTbUAzlxIGEkRSe99y0JXRIvcoWXTj2YW2I=;
        b=MP+GNamDCE+mRJpAufDKJi0n7L/SjuDN0W0/mB6I+IkhJF8u/8dD/Kz0INzsn34f1t
         NDSdXpwI8M0Gf6BExr4LVTdwAv6gQpQgdDDm1eWnohq7xoqtXAYPmRH+st8RgpcW6ZHg
         mxAUOr4VHXrm8Gnuz2pgAFGid8k4TQ94h0TZvOS/ThU438a4Ur6ZEglxcJ5GF8jprRjX
         mtglHoxdLMIKgJtDisLcxhdynARh813hQc7V3UFnLcfTMYTPydjd5MrmD6WDbSNQTT9x
         jWRWtZEbxaXPw8M8dDLpDNzKNTF9nh3Hf+xUzz2kReBoWyCeRDN+9ixGpLWJanMfuhzD
         1jYQ==
X-Gm-Message-State: ABy/qLZx0jAWUz/VLb9q3hrTJ4VbN4qNmMVrRUlO2T88T7m7QvcFgMg5
        b/afjgAB9xCOSCwqrwBHxDA=
X-Google-Smtp-Source: APBJJlFuAOPXLuc5Zgi5KE1/D96eCUtnX8M3m+vMn6fz146+Zs2uncJs/fvuhcB5OaALtcl78/2JVw==
X-Received: by 2002:adf:e410:0:b0:317:69c7:98ad with SMTP id g16-20020adfe410000000b0031769c798admr1348837wrm.3.1690377534135;
        Wed, 26 Jul 2023 06:18:54 -0700 (PDT)
Received: from skbuf ([188.25.175.105])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d6b8c000000b003143c6e09ccsm19603862wrx.16.2023.07.26.06.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:18:53 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:18:51 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: dsa: qca8k: limit user ports access to
 the first CPU port on setup
Message-ID: <20230726131851.w5ty2mftr7tdl3mi@skbuf>
References: <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-1-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724033058.16795-3-ansuelsmth@gmail.com>
 <20230724033058.16795-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 05:30:58AM +0200, Christian Marangi wrote:
> In preparation for multi-CPU support, set CPU port LOOKUP MEMBER outside
> the port loop and setup the LOOKUP MEMBER mask for user ports only to
> the first CPU port.
> 
> This is to handle flooding condition where every CPU port is set as
> target and prevent packet duplication for unknown frames from user ports.
> 
> Secondary CPU port LOOKUP MEMBER mask will be setup later when
> port_change_master will be implemented.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

This is kinda "net.git" material, in the sense that it fixes the current
driver behavior with device trees from the future, right?
