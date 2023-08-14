Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970F877C2A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjHNVpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjHNVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:45:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A4AE4;
        Mon, 14 Aug 2023 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ZtiLIxUxettw/9WPmtk9jiRQnxhuPfVkvX66bN2dsfc=; b=n9xT7/JPtATflackQJVEhyYLmk
        baUOEc4jwag8znz8+ttPq98EHFVtB7IVXV9ZvA39id95TgczEAu347l0fxvZBkzUbxTGqnZ40z2lA
        0fp8nLyCXwOMRqCB2Zy4H5LYL8fQ3R0PPA8qDVsFR0uIDEL77JAzGeajW5R8bE/J84bo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVfNF-0045vH-Tw; Mon, 14 Aug 2023 23:45:17 +0200
Date:   Mon, 14 Aug 2023 23:45:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Graeme Smecher <gsmecher@threespeedlogic.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Shay Agroskin <shayagr@amazon.com>,
        Rob Herring <robh@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marek Majtyka <alardam@gmail.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ti/cpsw_new: Expose the same module parameters as
 ti/cpsw.
Message-ID: <e53ac28b-c896-4f8d-a8b0-371f92c4ad5a@lunn.ch>
References: <20230814211323.3272487-1-gsmecher@threespeedlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814211323.3272487-1-gsmecher@threespeedlogic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 02:13:21PM -0700, Graeme Smecher wrote:
> The "old" CPSW driver (cpsw.c) exports the following module parameters:
> 
> 	- ti_cpsw.debug_level
> 	- ti_cpsw.ale_ageout
> 	- ti_cpsw.rx_packet_max
> 	- ti_cpsw.descs_pool_size
> 
> This patch exposes the same parameters for the "new" CPSW driver:
> 
> 	- ti_cpsw_new.debug_level
> 	- ti_cpsw_new.ale_ageout
> 	- ti_cpsw_new.rx_packet_max
> 	- ti_cpsw_new.descs_pool_size
> 
> It seems like consistency between the two drivers is a reasonable goal.

The new driver was written because the old driver had a lot of bad
practices. module parameters are bad practices, there are better APIs
to use. So that is why they are not present.

ethtool has an API to set debug_level. descs_pool_size sounds a lot
like ethtool --set-ring. I don't know what the other two do, but look
to see if ethtool has an option to set them.

    Andrew

---
pw-bot: cr
