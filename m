Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7B7EE5B6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjKPRM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKPRM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:12:57 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82600101;
        Thu, 16 Nov 2023 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=AR8tidW07BWvnPd6hH5WrFB2sCe8sD6k6E4/XZ64rcg=; b=fcIY5YqmtbOWCIcw+n57lx5crF
        6XlX4opbD49iBF3QArCUltjCMWZotExrqacZIC26KVjnJRkAJXI4y8TGhBP8/CRVrDq59kz4ABLCE
        c8LKmNd48yccc+V2TM6lFtvTipCvgY4QB1agJya1v+TUvrZg5RGQTkDb5mAx8AKwn/B0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1r3fv3-000NHs-Ky; Thu, 16 Nov 2023 18:12:45 +0100
Date:   Thu, 16 Nov 2023 18:12:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jie Luo <quic_luoj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        robert.marko@sartura.hr, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Message-ID: <be36ecb8-8bd7-4756-927e-fa5f266510da@lunn.ch>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
 <2ca3c6eb-93da-4e44-aa6b-c426b8baecb9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca3c6eb-93da-4e44-aa6b-c426b8baecb9@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 06:47:08PM +0800, Jie Luo wrote:
> 
> 
> On 11/16/2023 12:20 AM, Andrew Lunn wrote:
> > On Wed, Nov 15, 2023 at 11:25:14AM +0800, Luo Jie wrote:
> > > The PHY & PCS clocks need to be enabled and the reset
> > > sequence needs to be completed to make qca8084 PHY
> > > probeable by MDIO bus.
> > 
> > Is all this guaranteed to be the same between different boards? Can
> > the board be wired differently and need a different configuration?
> > 
> >      Andrew
> 
> Hi Andrew,
> This configuration sequence is specified to the qca8084 chip,
> not related with the platform(such as ipq5332).
> 
> All these configured registers are located in qca8084 chip, we need
> to complete these configurations to make MDIO bus being able to
> scan the qca8084 PHY(PHY registers can be accessed).

So nothing here has anything to do with the actual PHYs on the bus?
The only clock exposed here is MDC, and that runs at the standard
2.5MHz? All the clock tree configuration is completely internal to the
SOC?

What we don't want is some hard coded configuration which only works
for one specific reference design.

	Andrew
