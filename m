Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20288075FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442671AbjLFRC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjLFRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:02:24 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFC710C3;
        Wed,  6 Dec 2023 09:02:26 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 2FECB100090;
        Wed,  6 Dec 2023 20:02:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2FECB100090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1701882145;
        bh=fj1spA/7Ui2NDhe2nHqht/pr8SxF0h7lUNYu0J33Vio=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=u3gzp63k7pQcmXP/RXPol0YfqjT7aVRi/UB8MOdi3XQbk9meyUgVXnGJ4u+qIiMKf
         3z+5GsYYJINNrDXlkFleip8DICpc6xxhlHiC0G4BxNcOXRsLyPDSI+vu89kyr8h0rr
         wg0sK1k6DeQrPIK5SyTTeAclu8VzgGSdfy/9djNWrtjg6bosNLCUabzwAmuk5YkMLm
         0HUJPINYfrFGcXAckb0zBN8nDo3slzUAGdFWJe9v/eAClY53qEhRn676DqQ51pG4mf
         Otf/Hhg5Ev3PNJ12KkSvzmqE6FGZOFX2hRQ3ZmuNSKsJrMoVLMhsZPCRYsisc946Gu
         iA8/jL2Gc+OuA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed,  6 Dec 2023 20:02:25 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 20:02:24 +0300
Date:   Wed, 6 Dec 2023 20:02:24 +0300
From:   Dmitry Rokosov <ddrokosov@salutedevices.com>
To:     Lee Jones <lee@kernel.org>
CC:     <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v5 00/11] leds: aw200xx: several driver updates
Message-ID: <20231206170224.u3du6b7ganimzft2@CAB-WSD-L081021>
References: <20231125200519.1750-1-ddrokosov@salutedevices.com>
 <170142898612.3365188.2222761548333694548.b4-ty@kernel.org>
 <20231206112958.xlzrzorkzzexwpwe@CAB-WSD-L081021>
 <20231206131134.GA3375667@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231206131134.GA3375667@google.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181915 [Dec 06 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 5 0.3.5 98d108ddd984cca1d7e65e595eac546a62b0144b, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2;salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/06 15:44:00 #22621111
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:11:34PM +0000, Lee Jones wrote:
> On Wed, 06 Dec 2023, Dmitry Rokosov wrote:
> 
> > Hello Lee,
> > 
> > On Fri, Dec 01, 2023 at 11:09:46AM +0000, Lee Jones wrote:
> > > On Sat, 25 Nov 2023 23:05:08 +0300, Dmitry Rokosov wrote:
> > > > The following patch series includes several updates for the AW200XX LED
> > > > driver:
> > > >     - some small fixes and optimizations to the driver implementation:
> > > >       delays, autodimming calculation, disable_locking regmap flag,
> > > >       display_rows calculation in runtime;
> > > >     - fix LED device tree node pattern to accept LED names counting not
> > > >       only from 0 to f;
> > > >     - add missing reg constraints;
> > > >     - support HWEN hardware control, which allows enabling or disabling
> > > >       AW200XX RTL logic from the main SoC using a GPIO pin;
> > > >     - introduce the new AW20108 LED controller, the datasheet for this
> > > >       controller can be found at [1].
> > > > 
> > > > [...]
> > > 
> > > Applied, thanks!
> > > 
> > > [01/11] leds: aw200xx: fix write to DIM parameter
> > >         commit: 785fec3a8daff2957fd55e49cbdfe0a50866fdb7
> > > [02/11] leds: aw200xx: support HWEN hardware control
> > >         commit: eabe8239022cf3c75b90d9ee07dcfbbe4e50bcac
> > > [03/11] dt-bindings: leds: aw200xx: introduce optional enable-gpios property
> > >         commit: e91899ea3759d04e185721153a036e1a25e315b7
> > > [04/11] leds: aw200xx: calculate dts property display_rows in the driver
> > >         commit: 4ccd392c3ea7ceefbee58622e634d4997ef46acc
> > > [05/11] dt-bindings: leds: aw200xx: remove property "awinic,display-rows"
> > >         commit: 66d078f105837670c52bb31da29e26ad13bc2923
> > > [06/11] leds: aw200xx: add delay after software reset
> > >         commit: aac13e5630d6e081a9f6c5a57e5e6fc1152acca8
> > > [07/11] leds: aw200xx: enable disable_locking flag in regmap config
> > >         commit: 851fa70b9b162bbf5b5f5f92fc450633e6b21a3a
> > > [08/11] leds: aw200xx: improve autodim calculation method
> > >         commit: 5fcc24b92b43f012cbf430244f0698ff588ec9fc
> > > [09/11] leds: aw200xx: add support for aw20108 device
> > >         commit: abc74724d5e714bb3359124f3576d5318828a83e
> > > [10/11] dt-bindings: leds: awinic,aw200xx: add AW20108 device
> > >         commit: d6bbe677add2c560ae4aa2f9dab7a19c287e2193
> > > [11/11] dt-bindings: leds: aw200xx: fix led pattern and add reg constraints
> > >         commit: 5707a06e5391a4eeaf0c2705f973336537a41c79
> > 
> > Thank you for applying the patch series!
> > 
> > Could you please advise where I can find the above commits? I've tried
> > looking in the 'lee/leds' branch, but I couldn't find anything. I want
> 
> They there now and should be in -next by tomorrow.
> 

Thank you, got it!

> > to cherry-pick the commits that you applied to my internal branch, which
> > I sync with the upstream periodically.
> 
> I suggest that a rebase might be a better approach.

Of course, you are absolutely correct! We regularly perform rebases on
our mainline mirror. However, the patches that we are preparing for the
upstream are managed through our internal Gerrit system. When the
maintainer merges these patches into their tree, we also merge them on
the Gerrit side. Therefore, I would like to inquire about the current
status of these patches.

-- 
Thank you,
Dmitry
