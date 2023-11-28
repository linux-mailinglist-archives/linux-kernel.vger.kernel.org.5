Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFCD7FC51F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345064AbjK1USL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1USK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:18:10 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700010F4;
        Tue, 28 Nov 2023 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2CeW/Odz8x9jn8UzcgIPzzytCgTSCiS8MoreUC+k6Jk=; b=wOk0Xk/UT372hSMBw+y2JAh6Xn
        Iu/krV12bSqcynrLXBJOcfiaHZeCuL0njz4I4W4dIQL+dWDnMuNv9VqgywtxIRuaOAkacvTBEE5VI
        esQZTDCJer/7tKXAyBK4rrqzjOcRPLTGpGb2Kh6C1RwZjIyyrO2GbdgJMYTbm+MKdPbY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r84Wu-001UMY-Gf; Tue, 28 Nov 2023 21:18:00 +0100
Date:   Tue, 28 Nov 2023 21:18:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH net-next] net: phy: adin: allow control of Fast Link Down
Message-ID: <452f1e1c-1afd-4a36-bf60-11b7de291d2f@lunn.ch>
References: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:31:39PM +0100, Vincent Whitchurch wrote:
> Add support to allow Fast Link Down (aka "Enhanced link detection") to
> be controlled via the ETHTOOL_PHY_FAST_LINK_DOWN tunable.  These PHYs
> have this feature enabled by default.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Is there anything in the datasheet about how fast it is? It would be
nice to return the number of milliseconds, if its known.

    Andrew
