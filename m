Return-Path: <linux-kernel+bounces-60677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42885084E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D1A71C20BBB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A059169;
	Sun, 11 Feb 2024 09:33:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C35915A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707644014; cv=none; b=ZVwvRIj8Vb6pNwlsG6TQWng3sJmtKqezkvksTeWDS5EA8mE6j8g4rqcgRH996mRLzZpajpJR1JIii1++BBl6uyp3a/2BOqtpT7SqlvMCxldkfVAlWHFw3dMT3CHPAwSW2LYaeZ1gFkRNg0NZIVnjw9UQoG/iDtREhQUcDf5iOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707644014; c=relaxed/simple;
	bh=BPuUABTTAGyo0kD9LjEBkbMgFFFEB6Wv7K9ZPZmRtyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPpjbU8iY8sateu1QlAr3JkZF8wYa5I11SlgK5XsrfPhAp7v6DkIvAxKuYTmwiwG6EovIfiqnHN7A7pfnu9wewkD1eKruezBggyfR1qJf9K4nlSbE7BmEVViZLJp7LgruLUKRxmEDtJPuZDw3LxYi/UuSBK/ABbKpkN5/WYAtPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rZ6Cl-0005cL-GU; Sun, 11 Feb 2024 10:32:55 +0100
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rZ6Cg-0004CL-LZ; Sun, 11 Feb 2024 10:32:50 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rZ6Cg-0044e9-1o;
	Sun, 11 Feb 2024 10:32:50 +0100
Date: Sun, 11 Feb 2024 10:32:50 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Rob Herring <robh@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
	Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 14/17] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <ZciUQqjM4Z8Tc6Db@pengutronix.de>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
 <20240208-feature_poe-v3-14-531d2674469e@bootlin.com>
 <20240209145727.GA3702230-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209145727.GA3702230-robh@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Feb 09, 2024 at 02:57:27PM +0000, Rob Herring wrote:
> On Thu, Feb 08, 2024 at 02:08:51PM +0100, Kory Maincent wrote:
> > Add the PD692x0 I2C Power Sourcing Equipment controller device tree
> > bindings documentation.
> > 
> > Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > 
> > Changes in v2:
> > - Enhance ports-matrix description.
> > - Replace additionalProperties by unevaluatedProperties.
> > - Drop i2c suffix.
> > 
> > Changes in v3:
> > - Remove ports-matrix parameter.
> > - Add description of all physical ports and managers.
> > - Add pse_pis subnode moving to the API of pse-controller binding.
> > - Remove the MAINTAINERS section for this driver as I will be maintaining
> >   all pse-pd subsystem.
> > ---
> >  .../bindings/net/pse-pd/microchip,pd692x0.yaml     | 157 +++++++++++++++++++++
> >  1 file changed, 157 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> > new file mode 100644
> > index 000000000000..57ba5365157c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/pse-pd/microchip,pd692x0.yaml
> > @@ -0,0 +1,157 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/pse-pd/microchip,pd692x0.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip PD692x0 Power Sourcing Equipment controller
> > +
> > +maintainers:
> > +  - Kory Maincent <kory.maincent@bootlin.com>
> > +
> > +allOf:
> > +  - $ref: pse-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,pd69200
> > +      - microchip,pd69210
> > +      - microchip,pd69220
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  managers:
> > +    $ref: "#/$defs/managers"
> > +    description:
> > +      List of the PD69208T4/PD69204T4/PD69208M PSE managers. Each manager
> > +      have 4 or 8 physical ports according to the chip version. No need to
> > +      specify the SPI chip select as it is automatically detected by the
> > +      PD692x0 PSE controller. The PSE managers have to be described from
> > +      the lowest chip select to the greatest one, which is the detection
> > +      behavior of the PD692x0 PSE controller. The PD692x0 support up to
> > +      12 PSE managers which can expose up to 96 physical ports. All
> > +      physical ports available on a manager have to be described in the
> > +      incremental order even if they are not used.
> 
> Looks to me like you just need 3 PSE cells: <manager> <port> <A|B>
> 
> Really, no need for each piece of data to its own cell, so it could be 
> merged into 1 or 2 cells.
> 
> But cell data is generally supposed to be meaningful to the provider and 
> opaque to the consumer. It's not clear to me who needs to know 
> alternative A vs. B. That seems more like a property of the PHY than the 
> power provider? 

This is a bit complex question, so I decided to answer it with freshly
created documentation which should be included to this patch set:

PSE Power Interface (PSE PI) Documentation
==========================================

The Power Sourcing Equipment Power Interface (PSE PI) plays a pivotal role in
the architecture of Power over Ethernet (PoE) systems. It is essentially a
blueprint that outlines how one or multiple power sources are connected to the
eight-pin modular jack, commonly known as the Ethernet RJ45 port. This
connection scheme is crucial for enabling the delivery of power alongside data
over Ethernet cables.

Documentation and Standards
---------------------------

The IEEE 802.3 standard provides detailed documentation on the PSE PI.
Specifically:

- Section "33.2.3 PI pin assignments" covers the pin assignments for PoE
  systems that utilize two pairs for power delivery.
- Section "145.2.4 PSE PI" addresses the configuration for PoE systems that
  deliver power over all four pairs of an Ethernet cable.

PSE PI and Single Pair Ethernet
-------------------------------

Single Pair Ethernet (SPE) represents a different approach to Ethernet
connectivity, utilizing just one pair of conductors for both data and power
transmission. Unlike the configurations detailed in the PSE PI for standard
Ethernet, which can involve multiple power sourcing arrangements across four or
two pairs of wires, SPE operates on a simpler model due to its single-pair
design. As a result, the complexities of choosing between alternative pin
assignments for power delivery, as described in the PSE PI for multi-pair
Ethernet, are not applicable to SPE.

Understanding PSE PI
--------------------

The Power Sourcing Equipment Power Interface (PSE PI) is a framework defining
how Power Sourcing Equipment (PSE) delivers power to Powered Devices (PDs) over
Ethernet cables. It details two main configurations for power delivery, known
as Alternative A and Alternative B, which are distinguished not only by their
method of power transmission but also by the implications for polarity and data
transmission direction.

Alternative A and B Overview
----------------------------

- **Alternative A:** Utilizes the data-carrying pairs for power transmission in
  10/100BaseT networks. The power delivery's polarity in this alternative can
  vary based on the MDI (Medium Dependent Interface) or MDI-X (Medium Dependent
  Interface Crossover) configuration.

- **Alternative B:** Delivers power over the spare pairs not used for data in
  10/100BaseT networks. Unlike Alternative A, Alternative B's method separates
  power from data lines within the cable. Though it is less influenced by data
  transmission direction, Alternative B includes two configurations with
  different polarities, known as variant X and variant S, to accommodate
  different network requirements and device specifications.

Table 145–3—PSE Pinout Alternatives
-----------------------------------

The following table outlines the pin configurations for both Alternative A and
Alternative B.

+------------+-------------------+-----------------+-----------------+-----------------+
| Conductor  | Alternative A     | Alternative A   | Alternative B   | Alternative B   |
|            |    (MDI-X)        |      (MDI)      |        (X)      |        (S)      |
+============+===================+=================+=================+=================+
| 1          | Negative V        | Positive V      | -               | -               |
+------------+-------------------+-----------------+-----------------+-----------------+
| 2          | Negative V        | Positive V      | -               | -               |
+------------+-------------------+-----------------+-----------------+-----------------+
| 3          | Positive V        | Negative V      | -               | -               |
+------------+-------------------+-----------------+-----------------+-----------------+
| 4          | -                 | -               | Negative V      | Positive V      |
+------------+-------------------+-----------------+-----------------+-----------------+
| 5          | -                 | -               | Negative V      | Positive V      |
+------------+-------------------+-----------------+-----------------+-----------------+
| 6          | Positive V        | Negative V      | -               | -               |
+------------+-------------------+-----------------+-----------------+-----------------+
| 7          | -                 | -               | Positive V      | Negative V      |
+------------+-------------------+-----------------+-----------------+-----------------+
| 8          | -                 | -               | Positive V      | Negative V      |
+------------+-------------------+-----------------+-----------------+-----------------+

. note::
    - "Positive V" and "Negative V" indicate the voltage polarity for each pin.
    - "-" indicates that the pin is not used for power delivery in that
      specific configuration.

PSE Power Interface (PSE PI) Connection Diagram
------------------------------------------------

The diagram below illustrates the connection architecture between the RJ45
port, the Ethernet PHY (Physical Layer), and the PSE PI (Power Sourcing
Equipment Power Interface), demonstrating how power and data are delivered
simultaneously through an Ethernet cable. The RJ45 port serves as the physical
interface for these connections, with each of its eight pins connected to both
the Ethernet PHY for data transmission and the PSE PI for power delivery.

. code-block::

    +--------------------------+
    |                          |
    |          RJ45 Port       |
    |                          |
    +--+--+--+--+--+--+--+--+--+                +-------------+
      1| 2| 3| 4| 5| 6| 7| 8|                   |             |
       |  |  |  |  |  |  |  o-------------------+             |
       |  |  |  |  |  |  o--|-------------------+             +<--- PSE 1
       |  |  |  |  |  o--|--|-------------------+             |
       |  |  |  |  o--|--|--|-------------------+             |
       |  |  |  o--|--|--|--|-------------------+  PSE PI     |
       |  |  o--|--|--|--|--|-------------------+             |
       |  o--|--|--|--|--|--|-------------------+             +<--- PSE 2 (optional)
       o--|--|--|--|--|--|--|-------------------+             |
       |  |  |  |  |  |  |  |                   |             |
    +--+--+--+--+--+--+--+--+--+                +-------------+
    |                          |
    |       Ethernet PHY       |
    |                          |
    +--------------------------+

Simple PSE PI Configuration for Alternative A
---------------------------------------------

The diagram below illustrates a straightforward PSE PI (Power Sourcing
Equipment Power Interface) configuration designed to support the Alternative A
setup for Power over Ethernet (PoE). This implementation is tailored to provide
power delivery through the data-carrying pairs of an Ethernet cable, suitable
for either MDI or MDI-X configurations, albeit supporting one variation at a
time.

. code-block::

         +-------------+
         |    PSE PI   |
 8  -----+                             +-------------+
 7  -----+                    Rail 1   |             
 6  -----+------+----------------------+             
 5  -----+      |                      |             
 4  -----+     /              Rail 2   |  PSE 1       
 3  -----+----´          +-------------+             
 2  -----+----+---------´              |             
 1  -----+---´                         +-------------+
         |                                           
         +-------------+                            

In this configuration:

- Pins 1 and 2, as well as pins 3 and 6, are utilized for power delivery in
  addition to data transmission. This aligns with the standard wiring for
  10/100BaseT Ethernet networks where these pairs are used for data.
- Rail 1 and Rail 2 represent the positive and negative voltage rails, with
  Rail 1 connected to pins 1 and 2, and Rail 2 connected to pins 3 and 6.
  More advanced PSE PI configurations may include integrated or external
  switches to change the polarity of the voltage rails, allowing for
  compatibility with both MDI and MDI-X configurations.

More complex PSE PI configurations may include additional components, to support
Alternative B, or to provide additional features such as power management, or
additional power delivery capabilities such as 2-pair or 4-pair power delivery.

. code-block::

         +-------------+
         |    PSE PI   |
         |        +---+
 8  -----+--------+   |                 +-------------+
 7  -----+--------+   |       Rail 1   |             
 6  -----+--------+   +-----------------+             
 5  -----+--------+   |                |             
 4  -----+--------+   |       Rail 2   |  PSE 1       
 3  -----+--------+   +----------------+             
 2  -----+--------+   |                |             
 1  -----+--------+   |                 +-------------+
         |        +---+                               
         +-------------+                            

Device Tree Configuration: Describing PSE PI Configurations
------------------------------------------------------------

The necessity for a separate PSE PI node in the device tree is influenced by
the intricacy of the Power over Ethernet (PoE) system's setup. Here are
descriptions of both simple and complex PSE PI configurations to illustrate
this decision-making process:

**Simple PSE PI Configuration:**
In a straightforward scenario, the PSE PI setup involves a direct, one-to-one
connection between a single PSE controller and an Ethernet port. This setup
typically supports basic PoE functionality without the need for dynamic
configuration or management of multiple power delivery modes. For such simple
configurations, detailing the PSE PI within the existing PSE controller's node
may suffice, as the system does not encompass additional complexity that
warrants a separate node. The primary focus here is on the clear and direct
association of power delivery to a specific Ethernet port.

**Complex PSE PI Configuration:**
Contrastingly, a complex PSE PI setup may encompass multiple PSE controllers or
auxiliary circuits that collectively manage power delivery to one Ethernet
port. Such configurations might support a range of PoE standards and require
the capability to dynamically configure power delivery based on the operational
mode (e.g., PoE2 versus PoE4) or specific requirements of connected devices. In
these instances, a dedicated PSE PI node becomes essential for accurately
documenting the system architecture. This node would serve to detail the
interactions between different PSE controllers, the support for various PoE
modes, and any additional logic required to coordinate power delivery across
the network infrastructure.

**Guidance:**

For simple PSE setups, including PSE PI information in the PSE controller node
might suffice due to the straightforward nature of these systems. However,
complex configurations, involving multiple components or advanced PoE features,
benefit from a dedicated PSE PI node. This method adheres to IEEE 802.3
specifications, improving documentation clarity and ensuring accurate
representation of the PoE system's complexity.

PSE PI Node: Essential Information
----------------------------------

The PSE PI (Power Sourcing Equipment Power Interface) node in a device tree can
include several key pieces of information critical for defining the power
delivery capabilities and configurations of a PoE (Power over Ethernet) system.
Below is a list of such information, along with explanations for their
necessity and reasons why they might not be found within a PSE controller node:

1. **Powered Pairs Configuration**
   - *Description:* Identifies the pairs used for power delivery in the
     Ethernet cable.
   - *Necessity:* Essential to ensure the correct pairs are powered according
     to the board's design.
   - *PSE Controller Node:* Typically lacks details on physical pair usage,
     focusing on power regulation.

2. **Polarity of Powered Pairs**
   - *Description:* Specifies the polarity (positive or negative) for each
     powered pair.
   - *Necessity:* Critical for safe and effective power transmission to PDs.
   - *PSE Controller Node:* Polarity management may exceed the standard
     functionalities of PSE controllers.

3. **PSE Cells Association**
   - *Description:* Details the association of PSE cells with Ethernet ports or
     pairs in multi-cell configurations.
   - *Necessity:* Allows for optimized power resource allocation in complex
     systems.
   - *PSE Controller Node:* Controllers may not manage cell associations
     directly, focusing instead on power flow regulation.

4. **Support for PoE Standards**
   - *Description:* Lists the PoE standards and configurations supported by the
     system.
   - *Necessity:* Ensures system compatibility with various PDs and adherence
     to industry standards.
   - *PSE Controller Node:* Specific capabilities may depend on the overall PSE
     PI design rather than the controller alone. Multiple PSE cells per PI
     do not necessarily imply support for multiple PoE standards.

5. **Protection Mechanisms**
   - *Description:* Outlines additional protection mechanisms, such as
     overcurrent protection and thermal management.
   - *Necessity:* Provides extra safety and stability, complementing PSE
     controller protections.
   - *PSE Controller Node:* Some protections may be implemented via
     board-specific hardware or algorithms external to the controller.


Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

