Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD667D7D68
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 09:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbjJZHKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 03:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjJZHKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 03:10:37 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1237C18F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 00:10:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvuVl-0006p3-17; Thu, 26 Oct 2023 09:10:33 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvuVk-004Lmo-CY; Thu, 26 Oct 2023 09:10:32 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvuVk-00GPNi-9w; Thu, 26 Oct 2023 09:10:32 +0200
Date:   Thu, 26 Oct 2023 09:10:32 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 4/7] regulator: dt-bindings: whitelist
 system-critical-regulator property for fixed-regulator
Message-ID: <20231026071032.GI3803936@pengutronix.de>
References: <20231025084614.3092295-1-o.rempel@pengutronix.de>
 <20231025084614.3092295-5-o.rempel@pengutronix.de>
 <e2ae68a5-b6fc-4b0f-b198-e635435c33ce@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2ae68a5-b6fc-4b0f-b198-e635435c33ce@sirena.org.uk>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 01:41:45PM +0100, Mark Brown wrote:
> On Wed, Oct 25, 2023 at 10:46:11AM +0200, Oleksij Rempel wrote:
> > Allow fixed-regulator to be marked as system-critical by whitelisting
> > the 'system-critical-regulator' property.
> > 
> > This property indicating that the fixed-regulator is critical to system
> > stability or functionality, aligning with the recent changes in the
> > regulator core handling of under-voltage events for system-critical
> > regulators.
> 
> Why would this need to be something we explicitly enable for a given
> regulator?  Surely this is a property of the creativity of hardware
> engineers rather than the regulator itself.

:)

> Also please avoid the use of the outdated terms whitelist and blacklist,
> pass and block lists are often a good alternative.

ack

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
