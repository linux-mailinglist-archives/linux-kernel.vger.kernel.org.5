Return-Path: <linux-kernel+bounces-118787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B688BF51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0A3B240BA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D26679F3;
	Tue, 26 Mar 2024 10:26:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D715CDD9;
	Tue, 26 Mar 2024 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711448767; cv=none; b=F+yl3G11Ze9AdXHBGnpC++iVYZIDQHaIGAPJRvOQDWUZXwmxKbl9xfmEkz+/AwXd6Sr+VGeTnjm9X6w39o61T6VRmegQYR/UPmiJ4LGegWyF1bkFkIx+OoqFLrevOmMW/K5XATBbIwW1NVo6zmn9/g9qsmCP52JYLdcFk0ysg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711448767; c=relaxed/simple;
	bh=CbH8FA9A3GSen4uYy8cCMbH8CaGDcOrIGu6G7od56pQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/jzuO/9lKUTf6Yj+3SDYUVk2M+Sf1FJE5iFEozMAJALEI8SqqhXzVGlxrU2uUc0vixuiBdZNtxsCGlIlKwFtPoSzXNl+NKHtjtU2oV/3SMd3Xi1c0JkVxvw6t4LF6IXnab7t90fbgoSeolNpfnyhA4uTqbrgc2rhvWS4xqf7BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22D812F4;
	Tue, 26 Mar 2024 03:26:38 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80DAB3F64C;
	Tue, 26 Mar 2024 03:26:03 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:26:01 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, sudeep.holla@arm.com,
	jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
Message-ID: <ZgKiuR6Gc5w2mt-4@pluto>
References: <20240325092808.117510-1-cristian.marussi@arm.com>
 <20240325092808.117510-2-cristian.marussi@arm.com>
 <CAL_JsqKr9maL9W_9hQapPKFa+6S6wTr7WubHoHWtENyk74BDFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKr9maL9W_9hQapPKFa+6S6wTr7WubHoHWtENyk74BDFA@mail.gmail.com>

On Mon, Mar 25, 2024 at 08:44:24AM -0500, Rob Herring wrote:
> On Mon, Mar 25, 2024 at 4:28 AM Cristian Marussi
> <cristian.marussi@arm.com> wrote:
> >
> > Add bindings for the ARM MHUv3 Mailbox controller.
> >

Hi Rob,

thanks for having a look.

> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> >  .../bindings/mailbox/arm,mhuv3.yaml           | 239 ++++++++++++++++++
> >  1 file changed, 239 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> > new file mode 100644
> > index 000000000000..bfb8ec341d26
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> > @@ -0,0 +1,239 @@
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
> > +    When DBE is implemented, the number of DBCHs implemented is between 1 and
> > +    128, numbered starting from 0 in ascending order.
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
> > +    When FCE is implemented, the number of FCH that an implementation of the MHU
> > +    can support is between 1-1024, if the Fast Channel word-size is 32-bits, or
> > +    between 1-512, when the Fast Channel word-size is 64-bits.
> 
> Be consistent: FastChannel
> 

I'll fix.

> > +    FCHs are numbered from 0 in ascending order.
> > +    Note that Fast Channel word-size is implementation defined, not configurable
> > +    but discoverable at run-time.
> > +    Optionally, data may be transmitted through an out-of-band shared memory
> > +    region, wherein the MHU FastChannel is used as an interrupt generation
> > +    mechanism which carries also a pointer to such out-of-band data, but this
> > +    is out of the scope of these bindings.
> > +
> > +  - FIFO Extension (FE): FE defines a Channel type called a FIFO Channel (FFCH).
> > +    FFCH allows a Sender to send
> > +       - Multiple Transfer to the Receiver without having to wait for a previous
> > +         Transfer to be acknowledged by the Receiver, as long as the FIFO has
> > +         room for the Transfer.
> > +       - Transfers which require the Receiver to provide acknowledgment.
> > +       - Transfers which have in-band payload.
> > +    In all cases, the data is guaranteed to be observed by the Receiver in the
> > +    same order which the Sender sent it.
> > +    When FE is implemented, the number of FFCH an implementation of the MHU can
> > +    support is between 1 and 64, numbered starting from the 0 in ascending
> > +    order. The FIFO size is implementation defined and not configurable.
> 
> Size is discoverable or opaque to s/w?
>

FIFOs depth is the same across all of the implemented FIFO channels (between 1 and
1024 bytes) AND it is actually discoverable at runtime...I forgot to mention that here,
I'll fix.
 
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
> > +    maxItems: 38
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
> > +      In the following, for sake of simplicity, only a limited number of
> > +      per-channel interrupt names are enumerated, out of all the possible
> > +      channels allowed by the specification for each extension type.
> > +
> > +      - "combined": PBX/MBX Combined interrupt
> > +      - "combined-ffch": PBX/MBX FIFO Combined interrupt
> > +      - "ffch-low-tide-<N>": PBX/MBX FIFO Channel <N> Low Tide interrupt
> > +      - "ffch-high-tide-<N>": PBX/MBX FIFO Channel <N> High Tide interrupt
> > +      - "ffch-flush-<N>": PBX/MBX FIFO Channel <N> Flush interrupt
> > +      - "mbx-dbch-xfer-<N>": MBX Doorbell Channel <N> Transfer interrupt
> > +      - "mbx-fch-xfer-<N>": MBX Fast Channel <N> Transfer interrupt
> > +      - "mbx-fchgrp-xfer-<N>": MBX Fast Channel <N> Group Transfer interrupt
> > +      - "mbx-ffch-xfer-<N>": MBX FIFO Channel <N> Transfer interrupt
> > +      - "pbx-dbch-xfer-ack-<N>": PBX Doorbell Channel <N> Transfer Ack interrupt
> > +      - "pbx-ffch-xfer-ack-<N>": PBX FIFO Channel <N> Transfer Ack interrupt
> 
> It would be better to not define these strings twice. You can do
> something like this:
> 
> items:
>   oneOf:
>      - const: combined
>        description: ...
>      - pattern: '^ffch-low-tide-[0-9]+$'
>        description: ...
> 
> And so on.
> 

Thanks, I'll give it a go.

> > +
> > +      The only mandatory interrupts on the MHU are:
> > +        - combined
> > +        - mbx-fch-xfer-<N> but only if mbx-fcgrp-xfer-<N> is not implemented.
> > +
> > +    minItems: 1
> > +    maxItems: 38
> 
> Perhaps a comment on where 38 comes from. AIUI, this is a "should be
> enough for now" value.
>

Yes, I'll add and explanation to justify this.
 
> > +    items:
> > +      enum:
> > +        - combined
> > +        - combined-ffch
> > +        - ffch-low-tide-0
> > +        - ffch-low-tide-1
> > +        - ffch-low-tide-2
> > +        - ffch-low-tide-3
> > +        - ffch-high-tide-0
> > +        - ffch-high-tide-1
> > +        - ffch-high-tide-2
> > +        - ffch-high-tide-3
> > +        - ffch-flush-0
> > +        - ffch-flush-1
> > +        - ffch-flush-2
> > +        - ffch-flush-3
> > +        - mbx-dbch-xfer-0
> > +        - mbx-dbch-xfer-1
> > +        - mbx-dbch-xfer-2
> > +        - mbx-dbch-xfer-3
> > +        - mbx-fch-xfer-0
> > +        - mbx-fch-xfer-1
> > +        - mbx-fch-xfer-2
> > +        - mbx-fch-xfer-3
> > +        - mbx-fchgrp-xfer-0
> > +        - mbx-fchgrp-xfer-1
> > +        - mbx-fchgrp-xfer-2
> > +        - mbx-fchgrp-xfer-3
> > +        - mbx-ffch-xfer-0
> > +        - mbx-ffch-xfer-1
> > +        - mbx-ffch-xfer-2
> > +        - mbx-ffch-xfer-3
> > +        - pbx-dbch-xfer-ack-0
> > +        - pbx-dbch-xfer-ack-1
> > +        - pbx-dbch-xfer-ack-2
> > +        - pbx-dbch-xfer-ack-3
> > +        - pbx-ffch-xfer-ack-0
> > +        - pbx-ffch-xfer-ack-1
> > +        - pbx-ffch-xfer-ack-2
> > +        - pbx-ffch-xfer-ack-3
> > +
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
> > +      mboxes = <&mhu 1 0 0>; // FCE, Fast Channel Window 0.
> > +      mboxes = <&mhu 1 3 0>; // FCE, Fast Channel Window 3.
> > +      mboxes = <&mhu 2 1 0>; // FE, FIFO Channel Window 1.
> > +      mboxes = <&mhu 2 7 0>; // FE, FIFO Channel Window 7.
> > +    const: 3
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - '#mbox-cells'
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        mhu_tx: mailbox@2aaa0000 {
> 
> Drop unused labels.
>

Ok.

Thanks,
Cristian

