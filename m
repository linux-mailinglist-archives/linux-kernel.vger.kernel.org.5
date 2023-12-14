Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15462812DDA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443872AbjLNKzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443789AbjLNKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:55:07 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A3F171F;
        Thu, 14 Dec 2023 02:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=i5KEO/4V33LYgutwXb3TRWuNCSS9bJhDrQTPBSGXBKA=; b=0PaMKcTUlPtGE2YpI/zI+HQGYl
        zUUTm7Np6XGNb0bQ5G4kbazHgJR29LuXV1mRIXb6qWT1KvSDtcd2+RtOsPUvBpAgY2nR3XFRNj+B5
        19z89pK/uRQ6MvsDJwjQdu+gVArlZ+FaxkEB63WUHEGbTNHZVjZ5AiS1PzWF8JF49434=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1rDjM1-002uhO-LT; Thu, 14 Dec 2023 11:54:09 +0100
Date:   Thu, 14 Dec 2023 11:54:09 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Luo Jie <quic_luoj@quicinc.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk, corbet@lwn.net,
        p.zabel@pengutronix.de, f.fainelli@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 01/14] net: phy: introduce core support for phy-mode =
 "10g-qxgmii"
Message-ID: <9df4335a-5190-4091-8e14-ed9f5d12d50e@lunn.ch>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
 <20231214094813.24690-2-quic_luoj@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214094813.24690-2-quic_luoj@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 05:48:00PM +0800, Luo Jie wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> 10G-QXGMII is a MAC-to-PHY interface defined by the USXGMII multiport
> specification. It uses the same signaling as USXGMII, but it multiplexes
> 4 ports over the link, resulting in a maximum speed of 2.5G per port.
> 
> Some in-tree SoCs like the NXP LS1028A use "usxgmii" when they mean
> either the single-port USXGMII or the quad-port 10G-QXGMII variant, and
> they could get away just fine with that thus far. But there is a need to
> distinguish between the 2 as far as SerDes drivers are concerned.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
