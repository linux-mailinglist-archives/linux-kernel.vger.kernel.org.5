Return-Path: <linux-kernel+bounces-117168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F4988A84C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D01340C20
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7201F612EC;
	Mon, 25 Mar 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa0RdV9P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5672D18E06;
	Mon, 25 Mar 2024 13:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374280; cv=none; b=nL/2um+0jx4TPugNf9dXN7+mTbYnbrPpA8FRsEjQ0Ytax8qB3x3RdRMPv8ivewuEETZ5dACw8rzXKykTYUwo80TrY1SSZLmeIWnrf/Uoyn0gVWilGUFquiwLkPVWBUL/v3LuCgFMnLOMnlRKWcF8L2zOgTwRKHdLjXQBkDuUzrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374280; c=relaxed/simple;
	bh=DZl6nDTB2qGtV6PxioPQOgrKAtIwR3hCFBQwQXqjh2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXDVHr4p/QNi4uDnmpMrC8vpbwQP8cWgUYjA0ZG6ZhbECd1wrSpMGi2teMOm2wkE5O/RPIhZbR54pxOj9O4e54QQBvj/pVvXU/2lesZHUergzd2O1r4BBsxEQgorhhfvkLRtzFl9cfL7t2hqf4iY8sv1KdiQunPWIpPwKqbuFV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa0RdV9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F4FC43394;
	Mon, 25 Mar 2024 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711374280;
	bh=DZl6nDTB2qGtV6PxioPQOgrKAtIwR3hCFBQwQXqjh2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xa0RdV9P+hPBrFjZAlkbrC8whEDn7XqCtSCQnrt7wEe+I0CnbSsRuXoPH3e0xvZo3
	 JeLh65yMEGhSIAU2kmzjDp8x8dhe9mgonh/9MFGPUjXPt4RKdtKY3GpoFSvcBxIuhz
	 htJW1xmgDsus3dQ5soIBZzzf4q67/AA0bQ1CQHcN4R45RMez8WACBWLe0pzPYymX30
	 rXWfvwaPThvnWqHM9yZgJ1Q2i31uETEXYgKqgT8MkA2caLy0Wo/Wa9hIzbdrOR0Jlc
	 qPhnmTdSpqYbiLDkuwx6lYZ2a2SI8fo952FB73pwEm/kFQgJ/Og5W0e7MlQ8XZ/c5W
	 wdxDIV3xgy0lw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so5913069e87.0;
        Mon, 25 Mar 2024 06:44:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYkaKw1gv4pL1wa/7alL+JHN6Qi/xH0tmYmng8k3gqGu5RZ4rRXTWKTD7KMzmt54WtAzR/NIkCikx6d4ozlH1cU1FeGhTjluKwcA==
X-Gm-Message-State: AOJu0YxUyf2yIh+5+RwLBl2jkAogxyW5pwUnhsfC+RoQlzQNOd3vKp0Q
	ISRdVSsYu7LrcGQz1aMq5LkKc5mW99o3AdDGe6VZtaPtEkePmDgOunjp/o8yuPPtoTGtI7ZE58F
	UlqhZwU9xwVuTF0iVRgzfnVgjdg==
X-Google-Smtp-Source: AGHT+IFCwvfdTNdOVONLZ2l9mTxAgYoPvzuYyg3raz4YL3hudDkpzUAO+J9tMp0FOd7bflLxSvMLVjR4TVGjQ8+othE=
X-Received: by 2002:a19:6a0c:0:b0:515:9abb:fa61 with SMTP id
 u12-20020a196a0c000000b005159abbfa61mr4926300lfu.24.1711374278436; Mon, 25
 Mar 2024 06:44:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325092808.117510-1-cristian.marussi@arm.com> <20240325092808.117510-2-cristian.marussi@arm.com>
In-Reply-To: <20240325092808.117510-2-cristian.marussi@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 25 Mar 2024 08:44:24 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKr9maL9W_9hQapPKFa+6S6wTr7WubHoHWtENyk74BDFA@mail.gmail.com>
Message-ID: <CAL_JsqKr9maL9W_9hQapPKFa+6S6wTr7WubHoHWtENyk74BDFA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, sudeep.holla@arm.com, jassisinghbrar@gmail.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:28=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Add bindings for the ARM MHUv3 Mailbox controller.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  .../bindings/mailbox/arm,mhuv3.yaml           | 239 ++++++++++++++++++
>  1 file changed, 239 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.y=
aml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml b/D=
ocumentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> new file mode 100644
> index 000000000000..bfb8ec341d26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> @@ -0,0 +1,239 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/arm,mhuv3.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM MHUv3 Mailbox Controller
> +
> +maintainers:
> +  - Sudeep Holla <sudeep.holla@arm.com>
> +  - Cristian Marussi <cristian.marussi@arm.com>
> +
> +description: |
> +  The Arm Message Handling Unit (MHU) Version 3 is a mailbox controller =
that
> +  enables unidirectional communications with remote processors through v=
arious
> +  possible transport protocols.
> +  The controller can optionally support a varying number of extensions t=
hat, in
> +  turn, enable different kinds of transport to be used for communication=
.
> +  Number, type and characteristics of each supported extension can be di=
scovered
> +  dynamically at runtime.
> +
> +  Given the unidirectional nature of the controller, an MHUv3 mailbox co=
ntroller
> +  is composed of a MHU Sender (MHUS) containing a PostBox (PBX) block an=
d a MHU
> +  Receiver (MHUR) containing a MailBox (MBX) block, where
> +
> +   PBX is used to
> +      - Configure the MHU
> +      - Send Transfers to the Receiver
> +      - Optionally receive acknowledgment of a Transfer from the Receive=
r
> +
> +   MBX is used to
> +      - Configure the MHU
> +      - Receive Transfers from the Sender
> +      - Optionally acknowledge Transfers sent by the Sender
> +
> +  Both PBX and MBX need to be present and defined in the DT description =
if you
> +  need to establish a bidirectional communication, since you will have t=
o
> +  acquire two distinct unidirectional channels, one for each block.
> +
> +  As a consequence both blocks needs to be represented separately and sp=
ecified
> +  as distinct DT nodes in order to properly describe their resources.
> +
> +  Note that, though, thanks to the runtime discoverability, there is no =
need to
> +  identify the type of blocks with distinct compatibles.
> +
> +  Following are the MHUv3 possible extensions.
> +
> +  - Doorbell Extension (DBE): DBE defines a type of channel called a Doo=
rbell
> +    Channel (DBCH). DBCH enables a single bit Transfer to be sent from t=
he
> +    Sender to Receiver. The Transfer indicates that an event has occurre=
d.
> +    When DBE is implemented, the number of DBCHs implemented is between =
1 and
> +    128, numbered starting from 0 in ascending order.
> +    Each DBCH contains 32 individual fields, referred to as flags, each =
of which
> +    can be used independently. It is possible for the Sender to send mul=
tiple
> +    Transfers at once using a single DBCH, so long as each Transfer uses
> +    a different flag in the DBCH.
> +    Optionally, data may be transmitted through an out-of-band shared me=
mory
> +    region, wherein the MHU Doorbell is used strictly as an interrupt ge=
neration
> +    mechanism, but this is out of the scope of these bindings.
> +
> +  - FastChannel Extension (FCE): FCE defines a type of channel called a =
Fast
> +    Channel (FCH). FCH is intended for lower overhead communication betw=
een
> +    Sender and Receiver at the expense of determinism. An FCH allows the=
 Sender
> +    to update the channel value at any time, regardless of whether the p=
revious
> +    value has been seen by the Receiver. When the Receiver reads the cha=
nnel's
> +    content it gets the last value written to the channel.
> +    FCH is considered lossy in nature, and means that the Sender has no =
way of
> +    knowing if, or when, the Receiver will act on the Transfer.
> +    FCHs are expected to behave as RAM which generates interrupts when w=
rites
> +    occur to the locations within the RAM.
> +    When FCE is implemented, the number of FCH that an implementation of=
 the MHU
> +    can support is between 1-1024, if the Fast Channel word-size is 32-b=
its, or
> +    between 1-512, when the Fast Channel word-size is 64-bits.

Be consistent: FastChannel

> +    FCHs are numbered from 0 in ascending order.
> +    Note that Fast Channel word-size is implementation defined, not conf=
igurable
> +    but discoverable at run-time.
> +    Optionally, data may be transmitted through an out-of-band shared me=
mory
> +    region, wherein the MHU FastChannel is used as an interrupt generati=
on
> +    mechanism which carries also a pointer to such out-of-band data, but=
 this
> +    is out of the scope of these bindings.
> +
> +  - FIFO Extension (FE): FE defines a Channel type called a FIFO Channel=
 (FFCH).
> +    FFCH allows a Sender to send
> +       - Multiple Transfer to the Receiver without having to wait for a =
previous
> +         Transfer to be acknowledged by the Receiver, as long as the FIF=
O has
> +         room for the Transfer.
> +       - Transfers which require the Receiver to provide acknowledgment.
> +       - Transfers which have in-band payload.
> +    In all cases, the data is guaranteed to be observed by the Receiver =
in the
> +    same order which the Sender sent it.
> +    When FE is implemented, the number of FFCH an implementation of the =
MHU can
> +    support is between 1 and 64, numbered starting from the 0 in ascendi=
ng
> +    order. The FIFO size is implementation defined and not configurable.

Size is discoverable or opaque to s/w?

> +    Optionally, additional data may be transmitted through an out-of-ban=
d shared
> +    memory region, wherein the MHU FIFO is used to transmit, in order, a=
 small
> +    part of the payload (like a header) and a reference to the shared me=
mory
> +    area holding the remaining, bigger, chunk of the payload, but this i=
s out of
> +    the scope of these bindings.
> +
> +properties:
> +  compatible:
> +    const: arm,mhuv3
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 38
> +
> +  interrupt-names:
> +    description: |
> +      The MHUv3 controller generates a number of events some of which ar=
e used
> +      to generate interrupts; as a consequence it can expose a varying n=
umber of
> +      optional PBX/MBX interrupts, representing the events generated dur=
ing the
> +      operation of the various transport protocols associated with diffe=
rent
> +      extensions. All interrupts of the MHU are level-sensitive.
> +      Some of these optional interrupts are defined per-channel, where t=
he
> +      number of channels effectively available is implementation defined=
 and
> +      run-time discoverable.
> +      In the following, for sake of simplicity, only a limited number of
> +      per-channel interrupt names are enumerated, out of all the possibl=
e
> +      channels allowed by the specification for each extension type.
> +
> +      - "combined": PBX/MBX Combined interrupt
> +      - "combined-ffch": PBX/MBX FIFO Combined interrupt
> +      - "ffch-low-tide-<N>": PBX/MBX FIFO Channel <N> Low Tide interrupt
> +      - "ffch-high-tide-<N>": PBX/MBX FIFO Channel <N> High Tide interru=
pt
> +      - "ffch-flush-<N>": PBX/MBX FIFO Channel <N> Flush interrupt
> +      - "mbx-dbch-xfer-<N>": MBX Doorbell Channel <N> Transfer interrupt
> +      - "mbx-fch-xfer-<N>": MBX Fast Channel <N> Transfer interrupt
> +      - "mbx-fchgrp-xfer-<N>": MBX Fast Channel <N> Group Transfer inter=
rupt
> +      - "mbx-ffch-xfer-<N>": MBX FIFO Channel <N> Transfer interrupt
> +      - "pbx-dbch-xfer-ack-<N>": PBX Doorbell Channel <N> Transfer Ack i=
nterrupt
> +      - "pbx-ffch-xfer-ack-<N>": PBX FIFO Channel <N> Transfer Ack inter=
rupt

It would be better to not define these strings twice. You can do
something like this:

items:
  oneOf:
     - const: combined
       description: ...
     - pattern: '^ffch-low-tide-[0-9]+$'
       description: ...

And so on.

> +
> +      The only mandatory interrupts on the MHU are:
> +        - combined
> +        - mbx-fch-xfer-<N> but only if mbx-fcgrp-xfer-<N> is not impleme=
nted.
> +
> +    minItems: 1
> +    maxItems: 38

Perhaps a comment on where 38 comes from. AIUI, this is a "should be
enough for now" value.

> +    items:
> +      enum:
> +        - combined
> +        - combined-ffch
> +        - ffch-low-tide-0
> +        - ffch-low-tide-1
> +        - ffch-low-tide-2
> +        - ffch-low-tide-3
> +        - ffch-high-tide-0
> +        - ffch-high-tide-1
> +        - ffch-high-tide-2
> +        - ffch-high-tide-3
> +        - ffch-flush-0
> +        - ffch-flush-1
> +        - ffch-flush-2
> +        - ffch-flush-3
> +        - mbx-dbch-xfer-0
> +        - mbx-dbch-xfer-1
> +        - mbx-dbch-xfer-2
> +        - mbx-dbch-xfer-3
> +        - mbx-fch-xfer-0
> +        - mbx-fch-xfer-1
> +        - mbx-fch-xfer-2
> +        - mbx-fch-xfer-3
> +        - mbx-fchgrp-xfer-0
> +        - mbx-fchgrp-xfer-1
> +        - mbx-fchgrp-xfer-2
> +        - mbx-fchgrp-xfer-3
> +        - mbx-ffch-xfer-0
> +        - mbx-ffch-xfer-1
> +        - mbx-ffch-xfer-2
> +        - mbx-ffch-xfer-3
> +        - pbx-dbch-xfer-ack-0
> +        - pbx-dbch-xfer-ack-1
> +        - pbx-dbch-xfer-ack-2
> +        - pbx-dbch-xfer-ack-3
> +        - pbx-ffch-xfer-ack-0
> +        - pbx-ffch-xfer-ack-1
> +        - pbx-ffch-xfer-ack-2
> +        - pbx-ffch-xfer-ack-3
> +
> +  '#mbox-cells':
> +    description: |
> +      The first argument in the consumers 'mboxes' property represents t=
he
> +      extension type, the second is for the channel number while the thi=
rd
> +      depends on extension type.
> +
> +      Extension type for DBE is 0 and the third parameter represents the
> +      doorbell flag number to use.
> +      Extension type for FCE is 1, third parameter unused.
> +      Extension type for FE is 2, third parameter unused.
> +
> +      mboxes =3D <&mhu 0 0 5>; // DBE, Doorbell Channel Window 0, doorbe=
ll flag 5.
> +      mboxes =3D <&mhu 0 1 7>; // DBE, Doorbell Channel Window 1, doorbe=
ll flag 7.
> +      mboxes =3D <&mhu 1 0 0>; // FCE, Fast Channel Window 0.
> +      mboxes =3D <&mhu 1 3 0>; // FCE, Fast Channel Window 3.
> +      mboxes =3D <&mhu 2 1 0>; // FE, FIFO Channel Window 1.
> +      mboxes =3D <&mhu 2 7 0>; // FE, FIFO Channel Window 7.
> +    const: 3
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-names
> +  - '#mbox-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        mhu_tx: mailbox@2aaa0000 {

Drop unused labels.

> +            compatible =3D "arm,mhuv3";
> +            #mbox-cells =3D <3>;
> +            reg =3D <0 0x2aaa0000 0 0x10000>;
> +            clocks =3D <&clock 0>;
> +            interrupt-names =3D "combined", "pbx-dbch-xfer-ack-1",
> +                               "ffch-high-tide-0";
> +            interrupts =3D <0 36 4>, <0 37 4>;
> +        };
> +
> +        mhu_rx: mailbox@2ab00000 {
> +            compatible =3D "arm,mhuv3";
> +            #mbox-cells =3D <3>;
> +            reg =3D <0 0x2aab0000 0 0x10000>;
> +            clocks =3D <&clock 0>;
> +            interrupt-names =3D "combined", "mbx-dbch-xfer-1", "ffch-low=
-tide-0";
> +            interrupts =3D <0 35 4>, <0 38 4>, <0 39 4>;
> +        };
> +    };
> --
> 2.34.1
>

