Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB679F3E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjIMVhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIMVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:37:34 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816AE1724;
        Wed, 13 Sep 2023 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=WgAB9SAfkpGIabHV4CqdvtxhlA1ScpVv8kzv92uGnyM=; b=Hv/YvKQov0SoJ8rTHsgChXNdgZ
        e0bGH6agSkcEtOoEXsZmt0aLiwPIlE4e39u95QoWkZvn9dSNFnaHt/YRPsoZ21wUXrNrazh7Zvois
        vjOSuUv/U/u4GA8evFI10ATj7pLLzu+H1Uc6qcN3E/RjvtyPWRcRL7uDa6wg/B+I2zNk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgXY1-006LK5-8V; Wed, 13 Sep 2023 23:37:21 +0200
Date:   Wed, 13 Sep 2023 23:37:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Justin Lai <justinlai0215@realtek.com>
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/13] net:ethernet:realtek:rtase: Implement
 the .ndo_open function
Message-ID: <a7a4d7b6-84cd-49fc-9fde-1a6a232bf7af@lunn.ch>
References: <20230912091830.338164-1-justinlai0215@realtek.com>
 <20230912091830.338164-3-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912091830.338164-3-justinlai0215@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:18:19PM +0800, Justin Lai wrote:
> Implement the .ndo_open function to set default hardware settings
> and initialize the descriptor ring and interrupts. Among them,
> when requesting irq, because the first group of interrupts needs to
> process more events, the overall structure will be different from
> other groups of interrupts, so it needs to be processed separately.

Please take a look at the page pool code.

       Andrew
