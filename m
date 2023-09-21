Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884B97AA1D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjIUVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjIUVG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:06:58 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27E2AFC0E;
        Thu, 21 Sep 2023 11:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Sw8+a451IMBGfDKWgetevOucJP7Ud/BBjCxYS2ZKzy8=; b=YqqvTGWdAIlFqbk/Xv/ISzV/rv
        Uq8G2YfuZAx+LfyeTGbyi2haKqcSYQtyi+dqqdqQNAddmrQOzbmzFJx3fozgKugDLxdhDPh9InQP6
        RYEcJ2QtobyIwZlQHsVErjFGyfQW3+OPKp0x+aGsDe7CGf1AgcPGu39I8JnEZiiqFnaI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qjJrv-0075fV-QQ; Thu, 21 Sep 2023 15:37:23 +0200
Date:   Thu, 21 Sep 2023 15:37:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, Pekka Varis <p-varis@ti.com>
Subject: Re: [RFC PATCH net-next 3/4] net: ti: icssg-prueth: Add support for
 ICSSG switch firmware on AM654 PG2.0 EVM
Message-ID: <fa86c001-e01e-45b8-b6f4-514e8c507f02@lunn.ch>
References: <20230830110847.1219515-1-danishanwar@ti.com>
 <20230830110847.1219515-4-danishanwar@ti.com>
 <1fb683f4-d762-427b-98b7-8567ca1f797c@lunn.ch>
 <0d70cebf-8fd0-cf04-ccc2-6f240b27ecca@ti.com>
 <12c11462-5449-b100-5f92-f66c775237fa@kernel.org>
 <3fbf9514-8f9f-d362-9006-1fd435540e67@ti.com>
 <09931a97-df62-9803-967f-df6135dc3be7@ti.com>
 <055e781e-f614-4436-9d8d-e60e17fac5c9@lunn.ch>
 <92864bda-3028-f8be-0e27-487024d1a874@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92864bda-3028-f8be-0e27-487024d1a874@ti.com>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for the offline discussion and explanations. As discussed, we can
> not have one combined firmware to do both switch operations and dual
> emac operations. It is required to have two different firmwares.
> Currently which firmware to load is decided by flag 'is_switch_mode'
> which is set / unset by devlink. I will not use devlink here as asked by
> you. Instead, I'll use the approach suggested by you.
> ndo_open() will load the dual mac firmware. I'll swap to switch firmware
> when the second port is added to the same bridge as the first port.
> 
> I will re-work the changes and post v2 soon.

I'm sceptical you can actually make this work correctly, but lets see
what v2 contains.

     Andrew
