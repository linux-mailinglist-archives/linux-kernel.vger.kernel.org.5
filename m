Return-Path: <linux-kernel+bounces-135251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E03B89BDC8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0349B1F22184
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D264CF2;
	Mon,  8 Apr 2024 11:09:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F733FB81;
	Mon,  8 Apr 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574564; cv=none; b=r162lVlZEb5spTvET81ToOtSAh9hZTW5hfjqFtfg4VHvTqI3ltPRzyhGOa6f8tN3bP5qji/MUid1eDxosl6ely5aVD7Y0CFT8/N+vcvAUbUakOmFFWBJxx8Y+NK5wUxmPCRW2VB3qW7vsg/SauH237YTIqMtjy9WQ8NbqMYcgAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574564; c=relaxed/simple;
	bh=9CeiNUcdm4E9QUyAOhGqsopVTsAAf2iZyW0FuV0/aj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiSC2soF3wbuz0qjJLbvA58Oub9K+eLqXRSJ/Vb65NEbpJpdEYniLF+MKT2oAm+p8MdznCvcxYyYrwl++hjFITsaGcErq5TqpizW7g8V4LDF8ETTG/Hj/NB8ClNbq9m+mLmxZY73iAKXFU6inj5vS8XMFz++v9bIuniGPDzp7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F921DA7;
	Mon,  8 Apr 2024 04:09:52 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97743F766;
	Mon,  8 Apr 2024 04:09:20 -0700 (PDT)
Date: Mon, 8 Apr 2024 12:09:18 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, sudeep.holla@arm.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
Message-ID: <ZhPQXgMP_BahaJ66@pluto>
References: <20240404062347.3219795-1-cristian.marussi@arm.com>
 <20240404062347.3219795-2-cristian.marussi@arm.com>
 <CABb+yY07OQQ8gAOZM2iV7nh_P5sQPWwNPODfwnJNZoPk8MNg2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY07OQQ8gAOZM2iV7nh_P5sQPWwNPODfwnJNZoPk8MNg2w@mail.gmail.com>

On Sun, Apr 07, 2024 at 06:38:52PM -0500, Jassi Brar wrote:
> On Thu, Apr 4, 2024 at 1:25 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Add bindings for the ARM MHUv3 Mailbox controller.
> >

Hi,

> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v2 -> v3
> > - fixed spurious tabs in dt_binding_check
> > v1 -> v2
> > - clarified extension descriptions around configurability and discoverability
> > - removed unused labels from the example
> > - using pattern properties to define interrupt-names
> > - bumped interrupt maxItems to 74 (allowing uo to 8 channels per extension)
> > ---
> >  .../bindings/mailbox/arm,mhuv3.yaml           | 217 ++++++++++++++++++
> >  1 file changed, 217 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> > new file mode 100644
> > index 000000000000..32a8bb711464
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> > @@ -0,0 +1,217 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mailbox/arm,mhuv3.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ARM MHUv3 Mailbox Controller
> > +
> > +maintainers:
> > +  - Sudeep Holla <sudeep.holla@arm.com>
> > +  - Cristian Marussi <cristian.marussi@arm.com>
> > +
> > +description: |
> > +  The Arm Message Handling Unit (MHU) Version 3 is a mailbox controller that
> > +  enables unidirectional communications with remote processors through various
> > +  possible transport protocols.
> > +  The controller can optionally support a varying number of extensions that, in
> > +  turn, enable different kinds of transport to be used for communication.
> > +  Number, type and characteristics of each supported extension can be discovered
> > +  dynamically at runtime.
> > +
> > +  Given the unidirectional nature of the controller, an MHUv3 mailbox controller
> > +  is composed of a MHU Sender (MHUS) containing a PostBox (PBX) block and a MHU
> > +  Receiver (MHUR) containing a MailBox (MBX) block, where
> > +
> > +   PBX is used to
> > +      - Configure the MHU
> > +      - Send Transfers to the Receiver
> > +      - Optionally receive acknowledgment of a Transfer from the Receiver
> > +
> > +   MBX is used to
> > +      - Configure the MHU
> > +      - Receive Transfers from the Sender
> > +      - Optionally acknowledge Transfers sent by the Sender
> > +
> > +  Both PBX and MBX need to be present and defined in the DT description if you
> > +  need to establish a bidirectional communication, since you will have to
> > +  acquire two distinct unidirectional channels, one for each block.
> > +
> > +  As a consequence both blocks needs to be represented separately and specified
> > +  as distinct DT nodes in order to properly describe their resources.
> > +
> > +  Note that, though, thanks to the runtime discoverability, there is no need to
> > +  identify the type of blocks with distinct compatibles.
> > +
> > +  Following are the MHUv3 possible extensions.
> > +
> > +  - Doorbell Extension (DBE): DBE defines a type of channel called a Doorbell
> > +    Channel (DBCH). DBCH enables a single bit Transfer to be sent from the
> > +    Sender to Receiver. The Transfer indicates that an event has occurred.
> > +    When DBE is implemented, the number of DBCHs that an implementation of the
> > +    MHU can support is between 1 and 128, numbered starting from 0 in ascending
> > +    order and discoverable at run-time.
> > +    Each DBCH contains 32 individual fields, referred to as flags, each of which
> > +    can be used independently. It is possible for the Sender to send multiple
> > +    Transfers at once using a single DBCH, so long as each Transfer uses
> > +    a different flag in the DBCH.
> > +    Optionally, data may be transmitted through an out-of-band shared memory
> > +    region, wherein the MHU Doorbell is used strictly as an interrupt generation
> > +    mechanism, but this is out of the scope of these bindings.
> > +
> > +  - FastChannel Extension (FCE): FCE defines a type of channel called a Fast
> > +    Channel (FCH). FCH is intended for lower overhead communication between
> > +    Sender and Receiver at the expense of determinism. An FCH allows the Sender
> > +    to update the channel value at any time, regardless of whether the previous
> > +    value has been seen by the Receiver. When the Receiver reads the channel's
> > +    content it gets the last value written to the channel.
> > +    FCH is considered lossy in nature, and means that the Sender has no way of
> > +    knowing if, or when, the Receiver will act on the Transfer.
> > +    FCHs are expected to behave as RAM which generates interrupts when writes
> > +    occur to the locations within the RAM.
> > +    When FCE is implemented, the number of FCHs that an implementation of the
> > +    MHU can support is between 1-1024, if the FastChannel word-size is 32-bits,
> > +    or between 1-512, when the FastChannel word-size is 64-bits.
> > +    FCHs are numbered from 0 in ascending order.
> > +    Note that the number of FCHs and the word-size are implementation defined,
> > +    not configurable but discoverable at run-time.
> > +    Optionally, data may be transmitted through an out-of-band shared memory
> > +    region, wherein the MHU FastChannel is used as an interrupt generation
> > +    mechanism which carries also a pointer to such out-of-band data, but this
> > +    is out of the scope of these bindings.
> > +
> > +  - FIFO Extension (FE): FE defines a Channel type called a FIFO Channel (FFCH).
> > +    FFCH allows a Sender to send
> > +       - Multiple Transfers to the Receiver without having to wait for the
> > +         previous Transfer to be acknowledged by the Receiver, as long as the
> > +         FIFO has room for the Transfer.
> > +       - Transfers which require the Receiver to provide acknowledgment.
> > +       - Transfers which have in-band payload.
> > +    In all cases, the data is guaranteed to be observed by the Receiver in the
> > +    same order which the Sender sent it.
> > +    When FE is implemented, the number of FFCHs that an implementation of the
> > +    MHU can support is between 1 and 64, numbered starting from 0 in ascending
> > +    order. The number of FFCHs, their depth (same for all implemented FFCHs) and
> > +    the access-granularity are implementation defined, not configurable but
> > +    discoverable at run-time.
> > +    Optionally, additional data may be transmitted through an out-of-band shared
> > +    memory region, wherein the MHU FIFO is used to transmit, in order, a small
> > +    part of the payload (like a header) and a reference to the shared memory
> > +    area holding the remaining, bigger, chunk of the payload, but this is out of
> > +    the scope of these bindings.
> > +
> > +properties:
> > +  compatible:
> > +    const: arm,mhuv3
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 74
> > +
> > +  interrupt-names:
> > +    description: |
> > +      The MHUv3 controller generates a number of events some of which are used
> > +      to generate interrupts; as a consequence it can expose a varying number of
> > +      optional PBX/MBX interrupts, representing the events generated during the
> > +      operation of the various transport protocols associated with different
> > +      extensions. All interrupts of the MHU are level-sensitive.
> > +      Some of these optional interrupts are defined per-channel, where the
> > +      number of channels effectively available is implementation defined and
> > +      run-time discoverable.
> > +      In the following names are enumerated using patterns, with per-channel
> > +      interrupts implicitly capped at the maximum channels allowed by the
> > +      specification for each extension type.
> > +      For the sake of simplicity maxItems is anyway capped to a most plausible
> > +      number, assuming way less channels would be implemented than actually
> > +      possible.
> > +
> > +      The only mandatory interrupts on the MHU are:
> > +        - combined
> > +        - mbx-fch-xfer-<N> but only if mbx-fcgrp-xfer-<N> is not implemented.
> > +
> > +    minItems: 1
> > +    maxItems: 74
> > +    items:
> > +      oneOf:
> > +        - const: combined
> > +          description: PBX/MBX Combined interrupt
> > +        - const: combined-ffch
> > +          description: PBX/MBX FIFO Combined interrupt
> > +        - pattern: '^ffch-low-tide-[0-9]+$'
> > +          description: PBX/MBX FIFO Channel <N> Low Tide interrupt
> > +        - pattern: '^ffch-high-tide-[0-9]+$'
> > +          description: PBX/MBX FIFO Channel <N> High Tide interrupt
> > +        - pattern: '^ffch-flush-[0-9]+$'
> > +          description: PBX/MBX FIFO Channel <N> Flush interrupt
> > +        - pattern: '^mbx-dbch-xfer-[0-9]+$'
> > +          description: MBX Doorbell Channel <N> Transfer interrupt
> > +        - pattern: '^mbx-fch-xfer-[0-9]+$'
> > +          description: MBX FastChannel <N> Transfer interrupt
> > +        - pattern: '^mbx-fchgrp-xfer-[0-9]+$'
> > +          description: MBX FastChannel <N> Group Transfer interrupt
> > +        - pattern: '^mbx-ffch-xfer-[0-9]+$'
> > +          description: MBX FIFO Channel <N> Transfer interrupt
> > +        - pattern: '^pbx-dbch-xfer-ack-[0-9]+$'
> > +          description: PBX Doorbell Channel <N> Transfer Ack interrupt
> > +        - pattern: '^pbx-ffch-xfer-ack-[0-9]+$'
> > +          description: PBX FIFO Channel <N> Transfer Ack interrupt
> > +
> Can we have optional subnodes (with different properties as required)
> for each extension type ?
>

Not sure if I have understood properly you request, but the type of extensions
present in a PBX/MBX block can be discovered at runtime together with their
characteristics (like the number of channels) so the specific DT properties
can be searched (or NOT) based on the features discovered at run-time:
are you asking for subnodes as a means of adding clarity to what can be
defined in a block depending on what it is (PBX vs MBX) and what
extensions it has ?

if that is the reason ... the convoluted names like pbx/mbx-dbch- etc...
was my attempt at thhat :D ... to give a hint at what you can define in a PBX
vs MBX block and what is related to each extensions...

Note that, though, since the PBX/MBX blocks are discoverable at runtime as such,
they are not identified as such in the DT (same compatible) so I would not have
anywayy the capability to check in the DT which is which (PBX/MBX) and if the
properties are appropriate or not, nor I could know which extensions are really
implemented, so such subnodes would ony be a way of grouping props in the DT
without adding any compile time check capability nor adding any improvement to
the runtime DT parsing proces...

..BUT, of course, I could be wrong and missing a something here, so I
am happy to corrected on the subnodes utility...

> 
> > +  '#mbox-cells':
> > +    description: |
> > +      The first argument in the consumers 'mboxes' property represents the
> > +      extension type, the second is for the channel number while the third
> > +      depends on extension type.
> > +
> > +      Extension type for DBE is 0 and the third parameter represents the
> > +      doorbell flag number to use.
> > +      Extension type for FCE is 1, third parameter unused.
> > +      Extension type for FE is 2, third parameter unused.
> > +
> > +      mboxes = <&mhu 0 0 5>; // DBE, Doorbell Channel Window 0, doorbell flag 5.
> > +      mboxes = <&mhu 0 1 7>; // DBE, Doorbell Channel Window 1, doorbell flag 7.
> > +      mboxes = <&mhu 1 0 0>; // FCE, FastChannel Window 0.
> > +      mboxes = <&mhu 1 3 0>; // FCE, FastChannel Window 3.
> > +      mboxes = <&mhu 2 1 0>; // FE, FIFO Channel Window 1.
> > +      mboxes = <&mhu 2 7 0>; // FE, FIFO Channel Window 7.
> >
> Please define the extension types, instead of 0, 1 and 2.
> 

I'll do.

Thanks for the review.
Cristian

