Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F7777AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjHJOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHJOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:41:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144C5E53;
        Thu, 10 Aug 2023 07:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=mwzlrRVAAscIA+kAEhLsLbd8lJPFeF2GaIFj/DPNlUg=; b=CvdSwUdVmV2teaGUwpXH1UQ0O8
        a2ZBj4CYizSPAjivvpCnhPbyE4/2Q6rxRZT5UPCwN59L3VBnrcZ9kCpd1B2z3M2Dj8+rc3viDC1fb
        A9g6yi3QbXz/YACPgw3NpvCJyrhjWzIvavSGqI/yb8SmLddyKecglVkSg002TsP3ByEk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qU6qa-003hdq-P6; Thu, 10 Aug 2023 16:41:08 +0200
Date:   Thu, 10 Aug 2023 16:41:08 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <8746dad6-a6f1-4db0-958b-7b66d9dbd1f5@lunn.ch>
References: <20230810062915.252881-1-justinlai0215@realtek.com>
 <20230810062915.252881-2-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810062915.252881-2-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#include <linux/version.h>
> +#include <linux/ethtool.h>
> +
> +#define RTL_ALLOC_SKB_INTR(napi, length) napi_alloc_skb(&(napi), length)
> +
> +#define NETIF_F_ALL_CSUM NETIF_F_CSUM_MASK
> +
> +#define NETIF_F_HW_VLAN_RX NETIF_F_HW_VLAN_CTAG_RX
> +#define NETIF_F_HW_VLAN_TX NETIF_F_HW_VLAN_CTAG_TX
> +
> +#define CONFIG_SRIOV 1
> +
> +#ifndef NETIF_F_RXALL
> +#define NETIF_F_RXALL 0u
> +#endif
> +
> +#ifndef NETIF_F_RXFCS
> +#define NETIF_F_RXFCS 0u
> +#endif
> +
> +#ifndef SET_NETDEV_DEV
> +#define SET_NETDEV_DEV(net, pdev)
> +#endif
> +
> +#ifndef SET_MODULE_OWNER
> +#define SET_MODULE_OWNER(dev)
> +#endif
> +
> +#ifndef SA_SHIRQ
> +#define SA_SHIRQ IRQF_SHARED
> +#endif
> +
> +#ifndef NETIF_F_GSO
> +#define gso_size tso_size
> +#define gso_segs tso_segs
> +#endif
> +
> +#ifndef dma_mapping_error
> +#define dma_mapping_error(a, b) 0
> +#endif
> +
> +#ifndef netif_err
> +#define netif_err(a, b, c, d)
> +#endif
> +
> +#ifndef FALSE
> +#define FALSE 0
> +#endif
> +
> +#ifndef TRUE
> +#define TRUE 1
> +#endif
> +
> +#ifndef false
> +#define false 0
> +#endif
> +
> +#ifndef true
> +#define true 1
> +#endif

When i see code like this, it just shouts 'vendor crap, don't bother
reviewing'.

Really, truly, get help from an experienced mainline developer to
rewrite this code to mainline quality. Then post version 3.

Just as a hint, you are targeting net-next/main, and only
net-next/main. You can and should use everything which is in
net-next/main, and you should assume it exists. You are not targeting
older kernels, and you should not have 'vendor crap' like this so it
will compile with older kernels.

Spend some time looking at other drivers in mainline. If you are doing
something which other driver don't do, very likely you are doing
something wrong. Do you see other drivers looking to see if
NETIF_F_RXALL exists, and it not setting it to 0?

And please don't just fix this and repost. There is a lot more wrong.
Find a mentor to help you. The community would like to see this driver
in the kernel, but an entity the size of Realtek can easily contract
somebody to help get the code into shape.

    Andrew

---
pw-bot: cr
