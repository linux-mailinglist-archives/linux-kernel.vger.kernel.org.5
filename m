Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB327F251E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjKUFNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUFNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:13:04 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876FE7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:13:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5J3t-0001tH-8h; Tue, 21 Nov 2023 06:12:37 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1r5J3o-00AVcD-KQ; Tue, 21 Nov 2023 06:12:32 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1r5J3o-0034kw-HW; Tue, 21 Nov 2023 06:12:32 +0100
Date:   Tue, 21 Nov 2023 06:12:32 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <20231121051232.GE590719@pengutronix.de>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
 <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
 <20231120110944.66938859@kmaincent-XPS-13-7390>
 <20231120111008.GC590719@pengutronix.de>
 <2539b109-72ad-470a-9dae-9f53de4f64ec@lunn.ch>
 <20231120204221.GD590719@pengutronix.de>
 <887dbafe-def1-443f-8df2-b20b5ddc4db7@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <887dbafe-def1-443f-8df2-b20b5ddc4db7@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:14:32PM +0100, Andrew Lunn wrote:
> > > However, everything not PoDL PSE seems to be clause 33. So how about:
> > > 
> > > 	enum ethtool_podl_pse_admin_state podl_admin_control;
> > > 	enum ethtool_c33_pse_admin_state c33_admin_control;  
> > > 
> > > At least inside the kernel we use c22, c45, c37 etc. I'm not sure they
> > > are visible to userspace, but if we don't have a better name, maybe we
> > > have to use c33 in userspace as well.
> > > 
> > > I do think naming like this makes it clear we are talking about two
> > > parallel technologies, not a generic layer and then extensions for
> > > podl.
> > > 
> > > What do you think?
> > 
> > I'm OK with it.
> 
> Great.
> 
> > 
> > Köry, can you please include some kernel documentation in your patches?
> > Something like this. I hope it will help to clarify things :) :
> 
> This is good. I'm just wondering where to put it. Ideally we want to
> cross reference to it in both this header file, and in the netlink
> UAPI.

Documentation/networking/pse-pd/introduction.rst ?

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
