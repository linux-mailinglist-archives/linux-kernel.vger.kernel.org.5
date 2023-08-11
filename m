Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D1A778A94
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjHKKDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjHKKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:03:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A16E3;
        Fri, 11 Aug 2023 03:03:12 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52307552b03so2315984a12.0;
        Fri, 11 Aug 2023 03:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691748191; x=1692352991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ttMKk9rqBt+1WGSIXymjZZbSeEZephzk63+VZ9udyhk=;
        b=bPu6sMY1k+9VJFEa3lLJW4SaCenfmZ2fqfZqSFuSEhUF8gy+ejOhjLjj31X5bRIHPD
         Itf7pyP3cRTFRXjieeYyq5ymEmWQ+7R2sRTbpqPu+V7LCLeo2G6lHfeFpPlDyamWh2cl
         Qb65XLfBBlfktmox+II5+BrbxhLamsrUBD/T7a+y7814FiS1upfk2rntYvLgPz22taoH
         Zqzg3QAij62O1mK0tR8ZbeZitjsJddIwAlbFSfX1kTpx1idHNcaj2jZziK7AAhLMufVm
         gxjD9fmIQC/cgmv/kP/i7aM+cOOfk25VdR4EK4qH2xK1HI6Xxvvb5j3T/p2of+lMAjTV
         cLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691748191; x=1692352991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttMKk9rqBt+1WGSIXymjZZbSeEZephzk63+VZ9udyhk=;
        b=Ml69nZf9oa7TcMMTXAHF+zXotEow1BKWsao/55hC27IZc+9xSep9BoyN1yyFjl5H/e
         i8taQ9chebQIOFRgHgzvEEjD/LNTzbpiIxAh8C12D1w5lTe1Gdy7Lb/ECoPfHaWThLGZ
         JkoELVqOxw047i9JHdKu9PlHHs8NgWAkTJzijcVubXmCxqgzSPbrN4bTpSjrDZN0RqQe
         pzRVeHTpGMJex3FTtu0WFgtMCkBy2gdvBVLUpLJD87STAq4X8hbMePPvfhUl8Z9CwAND
         fCxq5UTeyGU9jE5rBoxuPxH4VWROA2FLUeppYIUiCTxs/T1ATSjM3J64yv3CovgeG609
         mjGA==
X-Gm-Message-State: AOJu0YxGRVvzLZFl7AWk2XP5MdMjvkXLB+CSQyfGn8/tZO0AKFb49FqD
        qFyT677V/zKdkWBvo9B6KyQ=
X-Google-Smtp-Source: AGHT+IGg+Y9cCLRcyJm+vZcVDXWFml9c31ZRvLQ0lBTxNYkMofs5i6LsSOtor5FePGm2gTOxCgwGlw==
X-Received: by 2002:a05:6402:2031:b0:523:d1ab:b2ec with SMTP id ay17-20020a056402203100b00523d1abb2ecmr718246edb.35.1691748190324;
        Fri, 11 Aug 2023 03:03:10 -0700 (PDT)
Received: from skbuf ([188.27.184.232])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d98e000000b005231e3d89efsm1869472eds.31.2023.08.11.03.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 03:03:10 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:03:07 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     alexis.lothore@bootlin.com
Cc:     =?utf-8?Q?Cl=C3=A9ment?= Leger <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH net-next v5 2/3] net: dsa: rzn1-a5psw: add support for
 .port_bridge_flags
Message-ID: <20230811100307.ocqkijjj5f6hi3q2@skbuf>
References: <20230810093651.102509-1-alexis.lothore@bootlin.com>
 <20230810093651.102509-3-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810093651.102509-3-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexis,

On Thu, Aug 10, 2023 at 11:36:50AM +0200, alexis.lothore@bootlin.com wrote:
> +	if (flags.mask & BR_FLOOD) {
> +		val = flags.val & BR_FLOOD ? BIT(port) : 0;
> +		a5psw_reg_rmw(a5psw, A5PSW_UCAST_DEF_MASK, BIT(port), val);
> +	}
> +
> +	if (flags.mask & BR_MCAST_FLOOD) {
> +		val = flags.val & BR_MCAST_FLOOD ? BIT(port) : 0;
> +		a5psw_reg_rmw(a5psw, A5PSW_MCAST_DEF_MASK, BIT(port), val);
> +	}
> +
> +	if (flags.mask & BR_BCAST_FLOOD) {
> +		val = flags.val & BR_BCAST_FLOOD ? BIT(port) : 0;
> +		a5psw_reg_rmw(a5psw, A5PSW_BCAST_DEF_MASK, BIT(port), val);
> +	}

These 3 port masks will only do what you expect while the bridge has
vlan_filtering=0, correct? When vlan_filtering=1, packets classified to
a VLAN which don't hit any FDB entry will be always flooded to all ports
in that VLAN, correct?

Maybe you could restrict transitions to flooding disabled on ports with
vlan_filtering 1, and restrict transitions to vlan_filtering 1 on ports
with flooding disabled. Or at least add some comments about the
limitations. I wouldn't want subtle incompatibilities between the
hardware design and Linux' expectations to go under the radar like this.
