Return-Path: <linux-kernel+bounces-134666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3C89B4A2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC94E2810A3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C893446D4;
	Sun,  7 Apr 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FK+43PIB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35571E535;
	Sun,  7 Apr 2024 23:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712533148; cv=none; b=RcJ4tNAA+sr91ndm3+iQxNC48neEpfHcG6pM17G4VrYfiSRTX629+SPDRgbvOEu9kOB06kL4Mxm05OfrJIbfZy+akZroz03ya5rGlNMqHxxM6jJueBBcF4XuufURocfex58PdckuFAfbDDXKcptE0+f4yxqdqLdkmmpOnL9UNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712533148; c=relaxed/simple;
	bh=sZm32cPa0CqWhpzpeccH46S33Xj7MYCZca4uIxQpcp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VEZVabF8JuHOEjGjQWxF/zWHrmWrOYjDx5aC+WeGBJCyM9uQd30CrQs7quiAfWwiaR+jKj7f3W1HZ7O8yescetw09twZuaCvkDNT/CQJNF30Qb5+p6IFDiDk6kN756EvjLlZ7QIN3q25DmkQEgm6jxMYWEJ/39paDADx+MpUp7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FK+43PIB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a20a6041so283688666b.0;
        Sun, 07 Apr 2024 16:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712533144; x=1713137944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ensjQx4/hg15rNnfSa4BVQuVzzMXROyZyh1XV0NxUfw=;
        b=FK+43PIBzShBx4TBBxHYB3jgLYNOM+vYiG/y6VLeS+1hB+pfw4jahHlCH5unf6e6Yi
         6ofMgOYWgP+1SdTeNrAV//A6hmHFrZ902yP4Dx3HJ0vK5xA1YE51F1tcD9tQ/3iWPsQv
         3lGiquVSZCffBRcqVrnukH3YRuH+5k+NnmEVapjmFosn4w12pgjIdW5Nw27g9O+2VcRu
         lj0/kPOTcaflZaOUWWOrXUwAH8tz2ikBb2CLToBEmL8Y2jNlMCMxxzm/V3bNjfPbRZUD
         DiGIyhmCwH/PslPS88iKlsSLgk+BSZKp6Xija2IsxdyEwTpCcH1xTCK0qWsivWR6znMq
         /drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712533144; x=1713137944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ensjQx4/hg15rNnfSa4BVQuVzzMXROyZyh1XV0NxUfw=;
        b=MszdkteeIgPKaObFAnkL+E+3vReziOV2SB8R+dmz4HPLMDBTjVq7hOUBnunvw3z9t/
         evlDwQp3bVwfYiHWjPcnSLacyI4QwooVffJhaCmtHFfYiQzXmywiAgUNereXKGY3+jue
         YdkiXKOyl+tPe57MH5mLGC5+MZB1mGllbQjVqUEyJJ5nB4XfP+ME7zbwzhij8xeFEAgd
         WA5Nqz6JBp1f6X7+S9KtTFwNZLC/vz2T/8AmnJ3QLIa8h8E/b26zeRfPGKUpbVJpOpP8
         hBb3TX2cBHhjOWSTffJksvviJGAkYT+bTJyELxB9910lShX6SbXjgZ2OWMAGRAqKThAT
         z5XA==
X-Forwarded-Encrypted: i=1; AJvYcCV4vcXC+HTre5QPQS55czPD8HQFImoUp/Mz8MkxgTrwhtP6aMweEx5lZSg41jMddV92ejpDv+Mi1KayFZWshmfAxw5+uqiKOYy9vw==
X-Gm-Message-State: AOJu0YzWnIDrREF5mdHCz9TTC1QGPKLG2bvpheWfnMPQq+aI5M+DCxcq
	3atc2F/y+/zy+hvegZeb8MYmluzjxNRn2PH8HG6y/gHLJ1+YZt3ajlgvXnicFRW8FRTWI6w1x3j
	dwfo3dfZYKGeSJE3JW/p+ORFe56E=
X-Google-Smtp-Source: AGHT+IGKszBRoVxNw93duLWwiy0GOmmlweJB9pYpYADOnN40kwJCf7ixaAO4N8f3pS8ijOZJQbbupadIG40ln8iCXfs=
X-Received: by 2002:a17:906:c404:b0:a4e:2b9e:5b73 with SMTP id
 u4-20020a170906c40400b00a4e2b9e5b73mr4318590ejz.49.1712533143938; Sun, 07 Apr
 2024 16:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404062347.3219795-1-cristian.marussi@arm.com> <20240404062347.3219795-2-cristian.marussi@arm.com>
In-Reply-To: <20240404062347.3219795-2-cristian.marussi@arm.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sun, 7 Apr 2024 18:38:52 -0500
Message-ID: <CABb+yY07OQQ8gAOZM2iV7nh_P5sQPWwNPODfwnJNZoPk8MNg2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, sudeep.holla@arm.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 1:25=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Add bindings for the ARM MHUv3 Mailbox controller.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v2 -> v3
> - fixed spurious tabs in dt_binding_check
> v1 -> v2
> - clarified extension descriptions around configurability and discoverabi=
lity
> - removed unused labels from the example
> - using pattern properties to define interrupt-names
> - bumped interrupt maxItems to 74 (allowing uo to 8 channels per extensio=
n)
> ---
>  .../bindings/mailbox/arm,mhuv3.yaml           | 217 ++++++++++++++++++
>  1 file changed, 217 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.y=
aml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml b/D=
ocumentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> new file mode 100644
> index 000000000000..32a8bb711464
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
> @@ -0,0 +1,217 @@
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
> +    When DBE is implemented, the number of DBCHs that an implementation =
of the
> +    MHU can support is between 1 and 128, numbered starting from 0 in as=
cending
> +    order and discoverable at run-time.
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
> +    When FCE is implemented, the number of FCHs that an implementation o=
f the
> +    MHU can support is between 1-1024, if the FastChannel word-size is 3=
2-bits,
> +    or between 1-512, when the FastChannel word-size is 64-bits.
> +    FCHs are numbered from 0 in ascending order.
> +    Note that the number of FCHs and the word-size are implementation de=
fined,
> +    not configurable but discoverable at run-time.
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
> +       - Multiple Transfers to the Receiver without having to wait for t=
he
> +         previous Transfer to be acknowledged by the Receiver, as long a=
s the
> +         FIFO has room for the Transfer.
> +       - Transfers which require the Receiver to provide acknowledgment.
> +       - Transfers which have in-band payload.
> +    In all cases, the data is guaranteed to be observed by the Receiver =
in the
> +    same order which the Sender sent it.
> +    When FE is implemented, the number of FFCHs that an implementation o=
f the
> +    MHU can support is between 1 and 64, numbered starting from 0 in asc=
ending
> +    order. The number of FFCHs, their depth (same for all implemented FF=
CHs) and
> +    the access-granularity are implementation defined, not configurable =
but
> +    discoverable at run-time.
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
> +    maxItems: 74
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
> +      In the following names are enumerated using patterns, with per-cha=
nnel
> +      interrupts implicitly capped at the maximum channels allowed by th=
e
> +      specification for each extension type.
> +      For the sake of simplicity maxItems is anyway capped to a most pla=
usible
> +      number, assuming way less channels would be implemented than actua=
lly
> +      possible.
> +
> +      The only mandatory interrupts on the MHU are:
> +        - combined
> +        - mbx-fch-xfer-<N> but only if mbx-fcgrp-xfer-<N> is not impleme=
nted.
> +
> +    minItems: 1
> +    maxItems: 74
> +    items:
> +      oneOf:
> +        - const: combined
> +          description: PBX/MBX Combined interrupt
> +        - const: combined-ffch
> +          description: PBX/MBX FIFO Combined interrupt
> +        - pattern: '^ffch-low-tide-[0-9]+$'
> +          description: PBX/MBX FIFO Channel <N> Low Tide interrupt
> +        - pattern: '^ffch-high-tide-[0-9]+$'
> +          description: PBX/MBX FIFO Channel <N> High Tide interrupt
> +        - pattern: '^ffch-flush-[0-9]+$'
> +          description: PBX/MBX FIFO Channel <N> Flush interrupt
> +        - pattern: '^mbx-dbch-xfer-[0-9]+$'
> +          description: MBX Doorbell Channel <N> Transfer interrupt
> +        - pattern: '^mbx-fch-xfer-[0-9]+$'
> +          description: MBX FastChannel <N> Transfer interrupt
> +        - pattern: '^mbx-fchgrp-xfer-[0-9]+$'
> +          description: MBX FastChannel <N> Group Transfer interrupt
> +        - pattern: '^mbx-ffch-xfer-[0-9]+$'
> +          description: MBX FIFO Channel <N> Transfer interrupt
> +        - pattern: '^pbx-dbch-xfer-ack-[0-9]+$'
> +          description: PBX Doorbell Channel <N> Transfer Ack interrupt
> +        - pattern: '^pbx-ffch-xfer-ack-[0-9]+$'
> +          description: PBX FIFO Channel <N> Transfer Ack interrupt
> +
Can we have optional subnodes (with different properties as required)
for each extension type ?


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
> +      mboxes =3D <&mhu 1 0 0>; // FCE, FastChannel Window 0.
> +      mboxes =3D <&mhu 1 3 0>; // FCE, FastChannel Window 3.
> +      mboxes =3D <&mhu 2 1 0>; // FE, FIFO Channel Window 1.
> +      mboxes =3D <&mhu 2 7 0>; // FE, FIFO Channel Window 7.
>
Please define the extension types, instead of 0, 1 and 2.

Cheers!
Jassi

