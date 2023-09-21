Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5F7A9A2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjIUShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjIUSgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:36:37 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAD6DC718;
        Thu, 21 Sep 2023 11:34:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34fc96995ddso4109605ab.2;
        Thu, 21 Sep 2023 11:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695321252; x=1695926052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Xqa4yr7yrsXtE2ALcRd+e1TwnuQsGz/pquNeqyhBOM=;
        b=hgfTXbX55QQSaYgVCgSvb77l8tQZysC8MV3eTWdBn4EmAJh7oo0DZk8VvKokGZK/2z
         2xe6Rgekz5J5ujEJAYUKwbFMhCud5mJwlNG6e0MwrrpwcBMeNfz/KOaZjWVgpvR6swMC
         HdPyUONRrr0SNJT2ok224lKfSY/yzEdhTNRaCrfuHKZqb03k6WtB91mExFw/DUBrQ98G
         hnYG7pZsZO1E/c1n6PQEla/lfeKx6p3yofrM8dupMq0+p71QNlYaWTKN+U0Q1Vq65aEO
         n4b7OmCpQLjrNJPbqX2Q44lv6Q4jA513n/hE3sPo9sODS/L8GbaSOjf3ufmjQb/QJY49
         Srog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695321252; x=1695926052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Xqa4yr7yrsXtE2ALcRd+e1TwnuQsGz/pquNeqyhBOM=;
        b=s+mu2vtuGpBLynqZnvI5pDfJx5PWVxFjIsUYlfuxSCUVfDOvvGAiF5a7kNVFeX7ddt
         BqeB9UKWzPTrI3E1+9iuJUQg3McksrrYAzLxv25NHQqxcUCkIL0Qi9J0DpsCs4EOu431
         umQkzXGMKB4i2cQgOwscw9bOa1PyYAtyZMJ3k9O/UgwS/7QCe9jXGli9cA1g4OQNWskK
         T/3JSob/CWGOiKrV7HSJYnkWWBJofr0CHaafIE0jytI19dcaqgOhsnfK5fbuHsQqYv6Y
         AKmTRz1TJ0xI5gI5tASz3h/x1hQYoEF9kh7ns3NA9EkJdHQgKlj76br3GzPwD3N5dldD
         vFSA==
X-Gm-Message-State: AOJu0Yw8TeF4jzslLFscYETA8ZeUsboRdWlGxutX6sJsttVPcoNg8F2b
        kD3GghqJzhzo4G9y7Wzv+As=
X-Google-Smtp-Source: AGHT+IF8jE2OC20tnm/t8jgynrtyfubCOpBW9F5WUr3ayImBT5J2BIGinpNhl9W5IfM+N5gFPP4yTA==
X-Received: by 2002:a92:c26f:0:b0:350:f510:3990 with SMTP id h15-20020a92c26f000000b00350f5103990mr7704043ild.2.1695321252010;
        Thu, 21 Sep 2023 11:34:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fs11-20020a05663865cb00b004313f22611csm498677jab.151.2023.09.21.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:34:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 21 Sep 2023 11:34:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH net-next v5 2/2] net: stmmac: use per-queue 64 bit
 statistics where necessary
Message-ID: <11fce633-4699-470f-a2f3-94b99b3e6da6@roeck-us.net>
References: <20230717160630.1892-1-jszhang@kernel.org>
 <20230717160630.1892-3-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717160630.1892-3-jszhang@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 18, 2023 at 12:06:30AM +0800, Jisheng Zhang wrote:
> Currently, there are two major issues with stmmac driver statistics
> First of all, statistics in stmmac_extra_stats, stmmac_rxq_stats
> and stmmac_txq_stats are 32 bit variables on 32 bit platforms. This
> can cause some stats to overflow after several minutes of
> high traffic, for example rx_pkt_n, tx_pkt_n and so on.
> 
> Secondly, if HW supports multiqueues, there are frequent cacheline
> ping pongs on some driver statistic vars, for example, normal_irq_n,
> tx_pkt_n and so on. What's more, frequent cacheline ping pongs on
> normal_irq_n happens in ISR, this makes the situation worse.
> 
> To improve the driver, we convert those statistics to 64 bit, implement
> ndo_get_stats64 and update .get_ethtool_stats implementation
> accordingly. We also use per-queue statistics where necessary to remove
> the cacheline ping pongs as much as possible to make multiqueue
> operations faster. Those statistics which are not possible to overflow
> and not frequently updated are kept as is.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Your patch results in lockdep splats. This is with the orangepi-pc
emulation in qemu.

[   11.126950] dwmac-sun8i 1c30000.ethernet eth0: PHY [mdio_mux-0.1:01] driver [Generic PHY] (irq=POLL)
[   11.127912] dwmac-sun8i 1c30000.ethernet eth0: No Safety Features support found
[   11.128294] dwmac-sun8i 1c30000.ethernet eth0: No MAC Management Counters available
[   11.128511] dwmac-sun8i 1c30000.ethernet eth0: PTP not supported by HW
[   11.138990] dwmac-sun8i 1c30000.ethernet eth0: configuring for phy/mii link mode
[   11.144387] INFO: trying to register non-static key.
[   11.144483] The code is fine but needs lockdep annotation, or maybe
[   11.144568] you didn't initialize this object before use?
[   11.144640] turning off the locking correctness validator.
[   11.144845] CPU: 2 PID: 688 Comm: ip Tainted: G                 N 6.6.0-rc2 #1
[   11.144956] Hardware name: Allwinner sun8i Family
[   11.145137]  unwind_backtrace from show_stack+0x10/0x14
[   11.145610]  show_stack from dump_stack_lvl+0x68/0x90
[   11.145692]  dump_stack_lvl from register_lock_class+0x99c/0x9b0
[   11.145779]  register_lock_class from __lock_acquire+0x6c/0x2244
[   11.145861]  __lock_acquire from lock_acquire+0x11c/0x368
[   11.145938]  lock_acquire from stmmac_get_stats64+0x350/0x374
[   11.146021]  stmmac_get_stats64 from dev_get_stats+0x3c/0x160
[   11.146101]  dev_get_stats from rtnl_fill_stats+0x30/0x118
[   11.146179]  rtnl_fill_stats from rtnl_fill_ifinfo.constprop.0+0x82c/0x1770
[   11.146273]  rtnl_fill_ifinfo.constprop.0 from rtmsg_ifinfo_build_skb+0xac/0x138
[   11.146370]  rtmsg_ifinfo_build_skb from rtmsg_ifinfo+0x44/0x7c
[   11.146452]  rtmsg_ifinfo from __dev_notify_flags+0xac/0xd8
[   11.146531]  __dev_notify_flags from dev_change_flags+0x48/0x54
[   11.146612]  dev_change_flags from do_setlink+0x244/0xe6c
[   11.146689]  do_setlink from rtnl_newlink+0x514/0x838
[   11.146761]  rtnl_newlink from rtnetlink_rcv_msg+0x170/0x5b0
[   11.146841]  rtnetlink_rcv_msg from netlink_rcv_skb+0xb4/0x10c
[   11.146925]  netlink_rcv_skb from netlink_unicast+0x190/0x254
[   11.147006]  netlink_unicast from netlink_sendmsg+0x1dc/0x460
[   11.147086]  netlink_sendmsg from ____sys_sendmsg+0xa0/0x2a0
[   11.147168]  ____sys_sendmsg from ___sys_sendmsg+0x68/0x94
[   11.147245]  ___sys_sendmsg from sys_sendmsg+0x4c/0x88
[   11.147329]  sys_sendmsg from ret_fast_syscall+0x0/0x1c
[   11.147439] Exception stack(0xf23edfa8 to 0xf23edff0)
[   11.147558] dfa0:                   00000000 00000000 00000003 bef9a8d8 00000000 00000000
[   11.147668] dfc0: 00000000 00000000 ffffffff 00000128 00000001 00000002 bef9af4a bef9af4d
[   11.147769] dfe0: bef9a868 bef9a858 b6f9ddac b6f9d228
[   11.150020] dwmac-sun8i 1c30000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx

My apologies for the noise if this has already been reported.

Guenter
