Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84BA7D358B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjJWLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbjJWLt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 07:49:26 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4683DE8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 04:49:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qutQt-0007fH-7U; Mon, 23 Oct 2023 13:49:19 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qutQq-003hJw-Mt; Mon, 23 Oct 2023 13:49:16 +0200
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qutQq-00FvNG-Jo; Mon, 23 Oct 2023 13:49:16 +0200
Date:   Mon, 23 Oct 2023 13:49:16 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Ante Knezic <ante.knezic@helmholz.de>
Cc:     UNGLinuxDriver@microchip.com, andrew@lunn.ch, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, f.fainelli@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, marex@denx.de,
        netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
        robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next v4 2/2] net:dsa:microchip: add property to select
Message-ID: <20231023114916.GC3787187@pengutronix.de>
References: <20231023084150.GB3787187@pengutronix.de>
 <20231023085750.8537-1-ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023085750.8537-1-ante.knezic@helmholz.de>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 10:57:50AM +0200, Ante Knezic wrote:
> On Mon, 23 Oct 2023 10:41:50 +0200, Oleksij Rempel wrote:
> 
> > Here is KSZ8873 as initial reference:
> > https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/00002348A.pdf
> > 3.3.9 RMII INTERFACE OPERATION:
> > "When EN_REFCLKO_3 is high, KSZ8873RLL will output a 50 MHz in REFCLKO_3.
> > Register 198 bit[3] is used to select internal or external reference
> > clock. Internal reference clock means that the clock for the RMII of
> > KSZ8873RLL will be provided by the KSZ8873RLL internally and the
> > REFCLKI_3 pin is unconnected. For the external reference clock, the
> > clock will provide to KSZ8873RLL via REFCLKI_3."
> > 
> > KSZ9897:
> > http://ww1.microchip.com/downloads/en/DeviceDoc/00002330B.pdf
> > 4.11.2 REDUCED MEDIA INDEPENDENT INTERFACE (RMII)
> 
> The upper paragraph refers to the case when switch is acting as a clock
> provider (regardless whether its set as internal or external reference
> clock). You can see this if you look at the next paragraph:
> "If KSZ8863RLL does not provide the reference clock, this 50 MHz reference 
> clock with divide-by-2 (25 MHz) has to be used in X1 pin instead of the 
> 25 MHz crystal, since the ..."
> So rmii-clk-internal property does not select whether switch is acting
> as a clock provider or clock consumer which is what you are refering to
> I believe? The clock provider/consumer is set via strapping pins.
> 
> Real case scenario: I have a board where switch is acting as a clock
> provider, generating output to REFCLKO pin and feeding it to uC. 
> This board does not have externally routed copper track from REFCLKO 
> to REFCLKI, thus making the RMII interface not operable, unless the 
> rmii-clk-internal bit is set.
> If this bit is not set, only way to make it running is to solder a
> jumper wire from REFCLKO to REFCLKI.

In case of KSZ8873 we seems to have something like:

Switch MAC<-.
            |
  PLL -> clk sel -> REFCLKO
            \-----< REFCLKI

Clock select in this case is controlled by Register 198 (0xC6).

In case of KSZ9897 we probably have something like:

Switch MAC<-.
            |
  PLL -> clk sel -> REFCLKO
            \--x--< REFCLKI
	       |
            Gate REFCLKI if REFCLKO is used.

In both cases:
- KSZ8873, Setting bit3 in Register 198 (0xC6) will control use of clk
  select
- KSZ9897, setting bit2 in Register 0xN301, will controll use of clk
  select and probably gate REFCLKI.

So far, it looks very similar to me and it is usually handled by
phy-mode rmii vs revrmii. Correct?

So, the main question is still, do we need this kind of configuration
per port or it is enough to have it per switch?

For some reasons KSZ8863MLL datasheet provides RMII clock select
configuration for two ports (port 1 and 3)
https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/DataSheets/KSZ8863MLL-FLL-RLL-Data-Sheet-00002335C.pdf
May be there are variants with two RMIIs?

Something similar but with multiple RMII interfaces seems to be
supported by KSZ8864CNX:
https://eu.mouser.com/datasheet/2/268/00002229A-1082534.pdf

And all KSZ9xxx series seems to handle it per port as well. 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
