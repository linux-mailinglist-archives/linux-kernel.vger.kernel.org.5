Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED83977F1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348670AbjHQIA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348683AbjHQIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:00:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9E8E48
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 01:00:47 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qWXvb-0001Bu-7D; Thu, 17 Aug 2023 10:00:23 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qWXvZ-0003sk-Mt; Thu, 17 Aug 2023 10:00:21 +0200
Date:   Thu, 17 Aug 2023 10:00:21 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, andreas@fatal.se,
        jun.li@nxp.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] usb: typec: tcpci: clear the fault status bit
Message-ID: <20230817080021.iz5mot24ojgkieem@pengutronix.de>
References: <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-0-3889b1b2050c@pengutronix.de>
 <20230504-b4-v6-3-topic-boards-imx8mp-evk-dual-role-usb-v2-3-3889b1b2050c@pengutronix.de>
 <6a894ff0-3232-4ef0-5e26-95471cc33ed9@roeck-us.net>
 <20230504142708.l4xo4sbl7wzsrbql@pengutronix.de>
 <CAOMZO5CCpeQLOhxvOCHjuip_DkVeZokGH_WgewxqyE+L40dvgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CCpeQLOhxvOCHjuip_DkVeZokGH_WgewxqyE+L40dvgw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-16, Fabio Estevam wrote:
> Hi Marco,
> 
> On Thu, May 4, 2023 at 11:27 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> 
> > > Also, why not just write the bit unconditionally, similar
> > > to TCPC_ALERT ?
> >
> > Thought about this too.. I will change it in the v3.
> 
> Was there ever a v3 for this patch?

Nope, thanks for sending it separate :)

Regards,
  Marco
