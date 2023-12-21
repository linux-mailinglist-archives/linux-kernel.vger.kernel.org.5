Return-Path: <linux-kernel+bounces-8872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED181BD77
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447FB1F26686
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E4627F4;
	Thu, 21 Dec 2023 17:43:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECE5990A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rGN4L-0005G0-4R; Thu, 21 Dec 2023 18:42:49 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rGN4H-000ZrS-DK; Thu, 21 Dec 2023 18:42:46 +0100
Received: from ore by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rGN4I-008Aa1-DK; Thu, 21 Dec 2023 18:42:46 +0100
Date: Thu, 21 Dec 2023 18:42:46 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH net-next v2 8/8] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231221174246.GI1697233@pengutronix.de>
References: <20231201-feature_poe-v2-8-56d8cac607fa@bootlin.com>
 <20231204225956.GG981228@pengutronix.de>
 <20231205064527.GJ981228@pengutronix.de>
 <4b96b8c8-7def-46e5-9c85-d9e925fb9251@sirena.org.uk>
 <20231205140203.GK981228@pengutronix.de>
 <88ed0c94-d052-4564-be0c-79a0f502eda8@sirena.org.uk>
 <20231221163610.47038996@kmaincent-XPS-13-7390>
 <ffda1003-b752-402e-8e51-e2e24a840cff@sirena.org.uk>
 <20231221171000.45310167@kmaincent-XPS-13-7390>
 <501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <501f671d-4e03-490b-a9d6-e1f39bb99115@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2023 at 04:20:10PM +0000, Mark Brown wrote:
> On Thu, Dec 21, 2023 at 05:10:00PM +0100, Köry Maincent wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Dec 21, 2023 at 04:36:10PM +0100, Köry Maincent wrote:
> > > > Mark Brown <broonie@kernel.org> wrote:  
> 
> > > > > OK...  I mean, if they're not using the regulator framework I'm not sure
> > > > > it has much impact - there are plenty of internal regulators in devices
> > > > > already so it wouldn't be *too* unusual other than the fact that AFAICT
> > > > > this is somewhat split between devices within the subsystem?  Neither of
> > > > > the messages was super clear.  
> 
> > > > PSE Power Interface (which is kind of the RJ45 in PSE world) have similar
> > > > functionalities as regulators. We wondered if registering a regulator for
> > > > each PSE PI (RJ45 ports) is a good idea. The point is that the PSE
> > > > controller driver will be its own regulator consumer.
> > > > I can't find any example in Linux with such a case of a driver being a
> > > > provider and a consumer of its own regulator. This idea of a regulator
> > > > biting its own tail seems weird to me. Maybe it is better to implement the
> > > > PSE functionalities even if they are like the regulator functionalities.  
> 
> > > Is it at all plausible that a system (perhaps an embedded one) might use
> > > something other than PSE?
> 
> > Do you mean to supply power to a RJ45 port?
> 
> Whatever it is that PSE does.
> 
> > This can be done with a simple regulator. In that case we use the pse_regulator
> > driver which is a regulator consumer.
> > I don't know about other cases. Oleksij do you?
> 
> In that case it sounds like you need the split to allow people to
> substitute in a non-PSE supply, and everything ought to be doing the
> consumer thing?

I decided and suggested to use regulator framework for following
reasons:
- The PSE is never a standalone controller. It is part of the system
  which includes Power Supply, which is providing power to the SoC and
  PSE.
- One system may contain multiple PSEs, we need to use some framework
  outside of PSE to regulate consumer priorities based on available
  power budget.
- a complex design may contain multiple hot swappable power supplies, we need
  to manage them and regulate power budget between multiple PSEs.
- in many cases PSE is kind of PMIC with multiple channels and some
  extras: prioritization, classification of attached devices. I suggest
  to represent every channel as a regulator, since it allow us to reuse
  existing diagnostic interfaces.

Since everything power related on a embedded system we already handle
with regulator framework, so why not use it within PSE too?

Here is an example of more or less complex system:

  +----------------------------------------------------------------+
  |                        Ethernet Switch                         |
  |                                                                |
  |  +-----------------+  +-----------------+  +-----------------+ |
  |  | Power Supply 1  |  | Power Supply 2  |  | removed Supply 3| |
  |  +--------+--------+  +--------+--------+  +--------+--------+ |
  |           |                    |-------------------.           |
  |  +--------v--------+  +--------v--------+  +--------v--------+ |
  |  | PSE Controller  |  | PSE Controller  |  | PSE Controller  | |
  |  |       #1        |  |       #2        |  |       #3        | |
  |  +----+++++--------+  +--------+--------+  +--------+--------+ |
  |       |||||                    |                    |          |
  +-------|||||--------------------|--------------------|----------+
          |||||                    |                    |            
          |||||                    |                    |            
  +-------....v--------------------v--------------------v---------+
  |                         Powered Devices                       |
  |                                                               |
  |  +--------+  +--------+  +--------+         +--------+  +-----+
  |  | Sensor |  | Sensor |  | Sensor |  ...    | Motor  |  | ... |
  |  +--------+  +--------+  +--------+         +--------+  +-----+
  |                                                               |
  +---------------------------------------------------------------+

How a PD reserves/communicates power budget on PSE PI (Power Interfaces)?

There are 3 ways to reserve power budget for PD:
- Level 1 classification. Done by PSE in cooperation with PD by firmware or
  can be done by Linux. Linux variant is currently not implemented.
- Done over Link Layer Discovery Protocol (LLDP). In this case some user
  space application (lldp daemon) will tell kernel to reserve power on some
  specific port (PSE PI).
- Set by user if all other ways fail or not implemented

PD side may have similar kind of challenges. For example, if PSE
notifies PD about reducing power budge for PD, PD may decide to reduce
consumption by keeping system alive - turn of the motor, but keep
sensors enabled. 

The main question is - how to represent a remote consumer (Powered
Device)? It looks for me like having a dummy regulator consumer for each
(PSE PI) withing the PSE framework is the simplest thing to do. User
should enable this dummy consumer from user space by using already
existing interface in case of PoDL - ETHTOOL_A_PODL_PSE_ADMIN_CONTROL
or new interface for Clause 33 PSE.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

