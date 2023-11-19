Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7EE7F03C7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 01:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKSAXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 19:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKSAXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 19:23:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02D6131
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 16:23:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA873C433C8;
        Sun, 19 Nov 2023 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700353428;
        bh=V60ZCbQw/VscUoWlSULCrP5V5BNoqEvg6B+bmvnfU+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oATT8xp4EVfNPEIfP0BVmfLN3VIpusAJ274bozQGBStcdQLrlaK6l4he+rzSDAEk8
         29uTWkXIVYeYF44C0egMrO3tjSyvG2Zv4eljYROYTR0YaPu3V7Ittx5Bx2mSduJOxC
         KSUuyxs9MfJUfjLR+N7DcqzOLKy0WpjnQAEtEN+ZVMJkU5KoscdK7eXuNOOs8nvjgJ
         MSdZ6E8mSXLpYieYylUzxh9av24FyJW8TKhLirVa9EON0pVGoDvGrmURr76CIdmbTW
         gE7JXIW96/8jdYAR4hF9Ag8aJKc4GKQQ/0ebBaQSgTdxzOpBJPJWad+zcX9ATCAcwL
         hnOhHWa4UnzLw==
Date:   Sat, 18 Nov 2023 16:23:46 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy
 support
Message-ID: <20231118162346.0c66226a@kernel.org>
In-Reply-To: <20231118062754.2453-4-quic_luoj@quicinc.com>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
        <20231118062754.2453-4-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2023 14:27:51 +0800 Luo Jie wrote:
> +		/* There are two PCSs available for QCA8084, which support the following
> +		 * interface modes.
> +		 *
> +		 * 1. PHY_INTERFACE_MODE_10G_QXGMII utilizes PCS1 for all available 4 ports,
> +		 * which is for all link speeds.
> +		 *
> +		 * 2. PHY_INTERFACE_MODE_2500BASEX utilizes PCS0 for the fourth port,
> +		 * which is only for the link speed 2500M same as QCA8081.
> +		 *
> +		 * 3. PHY_INTERFACE_MODE_SGMII utilizes PCS0 for the fourth port,
> +		 * which is for the link speed 10M, 100M and 1000M same as QCA8081.

Wrap the comments please. 

Please use checkpatch with --max-line-length=80
