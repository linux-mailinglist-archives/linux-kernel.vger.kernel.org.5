Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4415B7DE0EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 13:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344068AbjKAMgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 08:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344054AbjKAMgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 08:36:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C95122;
        Wed,  1 Nov 2023 05:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=imo3wNryrEjYThOqsNLqw4AyRV1m29tXBY8uvJUJe6w=; b=DxrT5asDfblt1OyyS/zzam+PD3
        D5aoWqH1tLGYiTe47iJnJBaDXJw83wsO1x6Y8YHwGMrBrWr+3x2LDY36vZdNAmC7SjaSbfNtJfSIm
        kXbeG3zmSqDLJlmcYIrydnonpkY7JYLNfnYWUS1alkhrCuVzYUgfg/SOsP5RFnbw1B7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qyAS3-000gT4-Ul; Wed, 01 Nov 2023 13:36:03 +0100
Date:   Wed, 1 Nov 2023 13:36:03 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Gan Yi Fang <yi.fang.gan@intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: check CBS input values
 before configuration
Message-ID: <58132260-81d0-4f0c-90b6-0c97c7a6a2f5@lunn.ch>
References: <20231101061920.401582-1-yi.fang.gan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101061920.401582-1-yi.fang.gan@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 02:19:20PM +0800, Gan Yi Fang wrote:
> From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> 
> Add check for below conditions before proceeding to configuration.
> A message will be prompted if the input value is invalid.
> 
> Idleslope minus sendslope should equal speed_div.
> Idleslope is always a positive value including zero.
> Sendslope is always a negative value including zero.
> Hicredit is always a positive value including zero.
> Locredit is always a negative value including zero.

Which of these conditional are specific to stmmac, and which are
generic to CBS? Anything which is generic to CBS i would expect to be
checked at a higher level, rather than in every driver implementing
CBS.

	Andrew
