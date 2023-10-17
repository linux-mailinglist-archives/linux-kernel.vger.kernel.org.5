Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67767CBE5B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjJQJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234741AbjJQJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:04:12 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D455F2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date
        :Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=xr93BtMovn5IoQemVdcs8ujKiBxoTrW4iPyMfWFZv7g=; b=DHouHpBZWk4pxV8zUnRbaudLm9
        9NMilUz55D2FjnxDIVC/sDYiGVyv4qxAlWbY0ePY0iYZVKJS+QBzMACAXghsuvY/2ulL7KZ0FhR5t
        urDJo2834PZ2e7f/MJAuEZhucYseI0VHd1B0gekTJ0sbI1mJDyq6uQzSQGbD+ndTQt6f82Poouwxn
        MBKfISVRRtCgSw7sklJSP549jxC3mJ6ttNWmFMqJifMm/N7Zhe5yoc2adbBbo+dYKz7CUlzuJbNjn
        XYEAXHG8FnxPx6FoeX18ySNKdXOyfYmP/IVe02XQmmrPlkApY/5FnrgnjOjMoXBMVVi9OX9ZkEgVg
        2gHwGn7A==;
Received: from [192.168.1.4] (port=10741 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qsfzi-0002Po-35;
        Tue, 17 Oct 2023 11:04:06 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 17 Oct 2023 11:04:06 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <conor@kernel.org>
CC:     <andrew@lunn.ch>, <ante.knezic@helmholz.de>, <conor+dt@kernel.org>,
        <davem@davemloft.net>, <devicetree@vger.kernel.org>,
        <edumazet@google.com>, <f.fainelli@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <marex@denx.de>,
        <netdev@vger.kernel.org>, <olteanv@gmail.com>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <woojung.huh@microchip.com>
Subject: [PATCH net-next v2 2/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
Date:   Tue, 17 Oct 2023 11:04:03 +0200
Message-ID: <20231017090403.18416-1-ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20231017-generous-botanical-28436c5ba13a@spud>
References: <20231017-generous-botanical-28436c5ba13a@spud>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 09:00:15 +0100, Conor Dooley wrote:

> > In both cases (external and internal), the KSZ88X3 is actually providing the
> > RMII reference clock.
> > Difference is only will the clock be routed as external
> > copper track (pin REFCLKO -> pin REFCLKI), or will it be routed internally.
> 
> The switch always provides it's own external reference, wut? Why would
> anyone actually bother doing this instead of just using the internal
> reference?

Thats a good question... Other KSZ chips don't have the ability to route clock
internally, and these two (ksz8863 and ksz8873) are actually by default the
expecting to route it externally. Why this is so is a matter of HW design. 
The KSZ88x3 does not have to provide the reference clock, it can be provided 
externally, by some other device, for example the uC. 
BUT in case when it is provided by the switch we have the option to route the 
internal block that is generating the clock to the clock input externally 
(as a copper track) or internally.
To quote the manual:
"When EN_REFCLKO_3 is high, KSZ8863RLL outputs a 50 MHz in REFCLKO_3. 
Register 198 bit [3] is used to select the internal or external reference clock.
Internal reference clock means that the clock for the RMII of KSZ8863RLL is
provided by KSZ8863RLL internally and the REFCLKI_3 pin is unconnected. For the 
external reference clock, the clock provides to KSZ8863RLL via REFCLKI_3.
If KSZ8863RLL does not provide the reference clock, this 50 MHz reference clock
with divide-by-2 (25 MHz) has to be used in X1 pin instead of the 25 MHz 
crystal, since the clock skew of these two clock sources impacts the RMII timing
before Rev A3 part. The Rev A3 part can connect the external 50 MHz reference 
clock to X1 pin and SMTXC3/REFCLKI_3 pins directly with strap pins of pin 17 
SMTXD33/EN_REFCLKO_3 and pin 18 SMTXD32 to be pulled down."

> > So, this should not affect the clock relation between the uC and the switch
> > device?
> 
> > This property has no effect if KSZ88X3 is not providing the reference clock.

> This appears to contradict with the above, unless I am misunderstanding
> something.

There are actually 5 RMII clock configuration modes depending on the
setting of the EN_REFCLKO_3, register 0xC6 and SMTXD32 pin (which affects
the expected clock, 25 or 50 Mhz), but the patch covers the case in which
the switch is generating the reference clock (outputing it to REFCLKO_3), 
because EN_REFCLK0_3 is pulled up. By clearing/setting the 0xC6 bit 3 we can 
choose whether to connect the REFCLKO to REFCLKI externally, or internally.

If reference clock is being provided to the ksz88x3 by some other device,
then there is no point in setting the 0xC6 bit 3 because other device is 
providing the clock to REFCLKI_3 and REFCLKO should not be connected and 
should not generate the clock (as EN_REFCLKI is pulled down).

> What I would have expected to see is that when the reference clock is
> provided externally that there would be a clocks property in the DT
> node, pointing at that external clock & when there was not, then
> no property. Likely that ship has already said, as I don't see clocks
> present in the current binding. How does the driver get the frequency of
> the RMII reference clock when an external reference is provided?

In case when ksz88x3 is generating the reference clock the devices rmii 
interface should be configured to external clock usage, for example something
like rmii-clock-ext for TI cpsw. This should be true regardles of whether
the ksz88x3 node has "microchip,rmii-clk-internal" set or not.

