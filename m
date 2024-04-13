Return-Path: <linux-kernel+bounces-143736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4101B8A3CCA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7791B216FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62D741A85;
	Sat, 13 Apr 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvimY95f"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481801CFA8;
	Sat, 13 Apr 2024 13:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713013930; cv=none; b=obicjMt+jUjoutZ+h5xqpgD1Re97AYLmcfH5TLY0ACpOb88IwWPlQI/Fn1aYI5zypmpye/JQ7360Z2vOMk1ubKCoKhnz1XkHDuHXvGWGxIEdY6yz0Lv/jq4MYDM3itZP+l7WIOu7LJOzhHHcemOvd+uFQsIomiS4BbyKbZEj5ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713013930; c=relaxed/simple;
	bh=KaCbtKY11ObHdXc3TmjVYsINpG0R1xfAu1Aha+urbRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSm4odcPXzqmfCVFBziDPden5oL2blPc7FIQiD53jvtWgIwZqliaf8HQ/lL9DwWGJdOrHIg92eWfhYxg5275R01V8MavSci2ZcSWoUK3QVYditxrPk3LHJysQyaCe0ghYJgRPmmhbtAzNXrbDFuXZYold1kq9nYGnT5mHflA/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvimY95f; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso1083610a12.2;
        Sat, 13 Apr 2024 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713013927; x=1713618727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87+jCncLVw08iDnzxLW8X3GJ4Z999Nuxxx2YRM+bb0g=;
        b=VvimY95fnEWeltGzwvvmJQ7xW6Sg1+Vwe1+IHyZNT5K9U7+rJNYI9BO3obCdiYIGnR
         r51xN2R/1OTGslXo1SgoIq/hdbCkUYuNbU077dGn0SE4rytSPOn+HXCkiCnosUl5WxuJ
         7ewB9HxN1Ers+TVb+O0RlZFdCF51vccaL0AweI5t/x+jw39k1wEFyw85AoqTOltfXVHG
         j6yQCZqzJyPCJiQ6RN0+7iRUkpcVEtVcRI8GObaRXj1KZ9Z01GRcZfS+VTQzL6NkMqKD
         wVv5KZwoP8QBL/v0BP7/Jmb10aQc0sA4S+PPpdSZ2gPY5psE0bYP7Xa64Cdt85/bhXYn
         Cayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713013927; x=1713618727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87+jCncLVw08iDnzxLW8X3GJ4Z999Nuxxx2YRM+bb0g=;
        b=IlJviffw9mKN9qBMT3ZGHshLeEDbXIsTi46xt4Slc3Rwk7I0O+hUBb3jxXMuNHBN70
         J7gEK72nheOKR7AUEW0wPyJ8VIgqFZn1Rs9vNdMFJadrJ3EOCTw2vdb+l0WD6MaX8tGm
         cbjo+Xrptxgj7gFeC2wOwwnxacC1/MzuSPqJWHLrVaUWj10n1pXYLikl7TiSILTC2xls
         y6vyJu3lHQbl+G4OA4mIPYeNunHqGFJxMH560v6uXYXoGhzIJ5lTXBP0Cm2/1DQtswFz
         yufBeN+/5HHwxcL2j3Oq0Sg4fYvbrSaMCN4zXiY1iHSC9/W6165bJH8nq0vMXFk7LxI7
         dAwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUycvkgUz9JHGSu6qhZpTCTXs8g+aePWvEPiHos/pMC+ubNNi7/DB7qB4UK++Zz/Qlvkd5MUTkBSMjihQSOrLiK/c4Oe96t4dBBDeeX/TXk8+Op3l7LksD2sS5Iz4YyzeWKbrcDOVPSY1ZvHM0p8tEBEbucHWffJdkV7C57QliT
X-Gm-Message-State: AOJu0YzJlLyXJusp6hS7gm6a1zH2Zn3ulAnbDMGiewXc/Kp5ufiADXAv
	DXdeId/N/l6ZAOA3gKFJQgFnVqNzFDbLBr8VuCwlLa6Ql4AhD24g1A2GQye0jQxYZGe1DnoClyO
	N4qzlOs7Jh5DI8x5aWzMdqjLgCJI=
X-Google-Smtp-Source: AGHT+IFVtMscyaPBPf6K9DwrteI432+VRr4rsN9OoOeivf4ja6Y0vf30EM1w1KdnJdkYZdVgF2H+ke7jzcWOCoxWH5A=
X-Received: by 2002:a17:90b:1050:b0:2a0:9c1c:50f4 with SMTP id
 gq16-20020a17090b105000b002a09c1c50f4mr4897663pjb.4.1713013927139; Sat, 13
 Apr 2024 06:12:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329133458.323041-2-valla.francesco@gmail.com> <20240329133458.323041-3-valla.francesco@gmail.com>
In-Reply-To: <20240329133458.323041-3-valla.francesco@gmail.com>
From: Vincent Mailhol <vincent.mailhol@gmail.com>
Date: Sat, 13 Apr 2024 22:11:55 +0900
Message-ID: <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO 15765-2:2016
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, fabio@redaril.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

Thank you for the ISO-TP documentation.

I left a few comments, but overall, good work. Also, I did not double
check each individual option one by one.

On Sat. 30 Mar 2024 at 00:06, Francesco Valla <valla.francesco@gmail.com> w=
rote:
> Document basic concepts, APIs and behaviour of the ISO 15675-2:2016
> (ISO-TP) CAN stack.
>
> Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> ---
>  Documentation/networking/index.rst      |   1 +
>  Documentation/networking/iso15765-2.rst | 356 ++++++++++++++++++++++++
>  MAINTAINERS                             |   1 +
>  3 files changed, 358 insertions(+)
>  create mode 100644 Documentation/networking/iso15765-2.rst
>
> diff --git a/Documentation/networking/index.rst b/Documentation/networkin=
g/index.rst
> index 473d72c36d61..bbd9bf537793 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -19,6 +19,7 @@ Contents:
>     caif/index
>     ethtool-netlink
>     ieee802154
> +   iso15765-2
>     j1939
>     kapi
>     msg_zerocopy
> diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/netw=
orking/iso15765-2.rst
> new file mode 100644
> index 000000000000..bbed4d2ef1a8
> --- /dev/null
> +++ b/Documentation/networking/iso15765-2.rst
> @@ -0,0 +1,356 @@
> +.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +ISO 15765-2:2016 (ISO-TP)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ISO 15765-2:2016, also known as ISO-TP, is a transport protocol specific=
ally
> +defined for diagnostic communication on CAN. It is widely used in the au=
tomotive
> +industry, for example as the transport protocol for UDSonCAN (ISO 14229-=
3) or
> +emission-related diagnostic services (ISO 15031-5).
> +
> +ISO-TP can be used both on CAN CC (aka Classical CAN, CAN 2.0B) and CAN =
FD (CAN

CC is already the abbreviation of *C*lassical *C*AN. Saying CAN CC, is
like saying CAN Classical CAN, c.f. the RAS syndrome:

  https://en.wikipedia.org/wiki/RAS_syndrome

Then, considering the CAN2.0B, as far as I know, ISO-TP can also be
used on CAN2.0A (as long as you only use 11 bits CAN ids).

So, I would rather just say:

  ISO-TP can be used both on Classical CAN and CAN FD...

> +with Flexible Datarate) based networks. It is also designed to be compat=
ible
> +with a CAN network using SAE J1939 as data link layer (however, this is =
not a
> +requirement).
> +
> +Specifications used
> +-------------------
> +
> +* ISO 15765-2:2016 : Road vehicles - Diagnostic communication over Contr=
oller

ISO 15765-2:2016 is withdrawn. The latest version is 15765-2:2024.

> +  Area Network (DoCAN). Part 2: Transport protocol and network layer ser=
vices.
> +
> +Addressing
> +----------
> +
> +In its simplest form, ISO-TP is based on two kinds of addressing modes f=
or the
> +nodes connected to the same network:
> +
> +- physical addressing is implemented by two node-specific addresses (CAN
> +  identifiers) and is used in 1-to-1 communication
> +- functional addressing is implemented by one node-specific address (CAN
> +  identifier) and is used in 1-to-N communication
> +
> +In a so-called "normal" addressing scenario, both these addresses are
> +represented by a 29-bit CAN ID. However, in order to support larger netw=
orks,
> +an "extended" addressing scheme can be adopted: in this case, the first =
byte of
> +the data payload is used as an additional component of the address (both=
 for
> +the physical and functional cases); two different CAN IDs are still requ=
ired.

There is more than that.

  - The normal addressing can also use the non-extended 11 bits CAN ID.
  - In addition to the normal and extended addressing mode, there
    is a third mode: the mixed addressing.

Ref:

  - ISO 15765:2024 =C2=A710.3.1 "Addressing formats"
  - https://www.embedded-communication.com/en/misc/iso-tp-addressing/

> +
> +Transport protocol and associated frame types
> +---------------------------------------------
> +
> +When transmitting data using the ISO-TP protocol, the payload can either=
 fit
> +inside one single CAN message or not, also considering the overhead the =
protocol
> +is generating and the optional extended addressing. In the first case, t=
he data
> +is transmitted at once using a so-called Single Frame (SF). In the secon=
d case,
> +ISO-TP defines a multi-frame protocol, in which the sender provides (thr=
ough a
> +First Frame - FF) the PDU length which is to be transmitted and also ask=
s for a
> +Flow Control (FC) frame, which provides the maximum supported size of a =
macro
> +data block (``blocksize``) and the minimum time between the single CAN m=
essages
> +composing such block (``stmin``). Once this information has been receive=
d, the
> +sender starts to send frames containing fragments of the data payload (c=
alled
> +Consecutive Frames - CF), stopping after every ``blocksize``-sized block=
 to wait
> +confirmation from the receiver (which should then send another Flow Cont=
rol
> +frame to inform the sender about its availability to receive more data).

Nitpick: I do not see the need for the brackets here:

  confirmation from the receiver which should then send another Flow Contro=
l
  frame to inform the sender about its availability to receive more data.

> +How to Use ISO-TP
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +As with others CAN protocols, the ISO-TP stack support is built into the
> +Linux network subsystem for the CAN bus, aka. Linux-CAN or SocketCAN, an=
d
> +thus follows the same socket API.
> +
> +Creation and basic usage of an ISO-TP socket
> +--------------------------------------------
> +
> +To use the ISO-TP stack, ``#include <linux/can/isotp.h>`` shall be used.=
 A
> +socket can then be created using the ``PF_CAN`` protocol family, the
> +``SOCK_DGRAM`` type (as the underlying protocol is datagram-based by des=
ign)
> +and the ``CAN_ISOTP`` protocol:
> +
> +.. code-block:: C
> +
> +    s =3D socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> +
> +After the socket has been successfully created, ``bind(2)`` shall be cal=
led to
> +bind the socket to the desired CAN interface; to do so:
> +
> +* a TX CAN ID shall be specified as part of the sockaddr supplied to the=
 call
> +  itself, and

Why did you put a newline here?

> +* a RX CAN ID shall also specified, unless broadcast flags have been set
> +  through socket option (explained below)

Add a period at the end of your sentence:

  through socket option (explained below).

> +Once bound to an interface, the socket can be read from and written to u=
sing
> +the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2=
)``,
> +``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.

If this is a new paragraph, leave an empty newline. If not, do not add
a newline before you reach the character column limit.

> +Unlike the CAN_RAW socket API, only the data payload shall be specified =
in all
> +these calls, as the CAN header is automatically filled by the ISO-TP sta=
ck
> +using information supplied during socket creation. In the same way, the =
stack

This is making a shortcut. There are the raw CAN payload and the
ISO-TP payload. In this paragraph it is not clear that "data payload"
is referring to the ISO-TP payload.

Also, what is the meaning of "the CAN header". Here, I think you mean
CAN ID plus some of the few first byte of the CAN payload.

I suggest that you use more precise vocabulary from the standard:

  - Address information
  - Protocol Information
  - Data field

Something like:

  only the ISO-TP data field (the actual payload) is sent. The
  address information and the protocol information is
  automatically filled by the ISO-TP stack...

> +will use the transport mechanism when required (i.e., when the size of t=
he data
> +payload exceeds the MTU of the underlying CAN bus).
> +
> +The sockaddr structure used for SocketCAN has extensions for use with IS=
O-TP,
> +as specified below:
> +
> +.. code-block:: C
> +
> +    struct sockaddr_can {
> +        sa_family_t can_family;
> +        int         can_ifindex;
> +        union {
> +            struct { canid_t rx_id, tx_id; } tp;
> +        ...
> +        } can_addr;
> +    }
> +
> +* ``can_family`` and ``can_ifindex`` serve the same purpose as for other
> +  SocketCAN sockets.
> +
> +* ``can_addr.tp.rx_id`` specifies the receive (RX) CAN ID and will be us=
ed as
> +  a RX filter.
> +
> +* ``can_addr.tp.tx_id`` specifies the transmit (TX) CAN ID
> +
> +ISO-TP socket options
> +---------------------
> +
> +When creating an ISO-TP socket, reasonable defaults are set. Some option=
s can
> +be modified with ``setsockopt(2)`` and/or read back with ``getsockopt(2)=
``.
> +
> +General options
> +~~~~~~~~~~~~~~~
> +
> +General socket options can be passed using the ``CAN_ISOTP_OPTS`` optnam=
e:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_options opts;
> +    ret =3D setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(o=
pts))
> +
> +where the ``can_isotp_options`` structure has the following contents:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_options {
> +        u32 flags;
> +        u32 frame_txtime;
> +        u8  ext_address;
> +        u8  txpad_content;
> +        u8  rxpad_content;
> +        u8  rx_ext_address;
> +    };
> +
> +* ``flags``: modifiers to be applied to the default behaviour of the ISO=
-TP
> +  stack. Following flags are available:
> +
> +  - ``CAN_ISOTP_LISTEN_MODE``: listen only (do not send FC frames); norm=
ally
> +    used as a testing feature.
> +  - ``CAN_ISOTP_EXTEND_ADDR``: enable extended addressing, using the byt=
e
> +    specified in ``ext_address`` as additional address byte.
                                    ^^^^^^^^^^^^^
as an additional

> +  - ``CAN_ISOTP_TX_PADDING``: enable padding for tranmsitted frames, usi=
ng
                                                    ^^^^^^^^^^^
transmitted

> +    ``txpad_content`` as value for the padding bytes.
> +  - ``CAN_ISOTP_RX_PADDING``: enable padding for the received frames, us=
ing
> +    ``rxpad_content`` as value for the padding bytes.
> +  - ``CAN_ISOTP_CHK_PAD_LEN``: check for correct padding length on the r=
eceived
> +    frames.
> +  - ``CAN_ISOTP_CHK_PAD_DATA``: check padding bytes on the received fram=
es
> +    against ``rxpad_content``; if ``CAN_ISOTP_RX_PADDING`` is not specif=
ied,
> +    this flag is ignored.
> +  - ``CAN_ISOTP_HALF_DUPLEX``: force ISO-TP socket in half duples mode
                                                              ^^^^^^
duplex

> +    (that is, transport mechanism can only be incoming or outgoing at th=
e same
> +    time, not both).
> +  - ``CAN_ISOTP_FORCE_TXSTMIN``: ignore stmin from received FC; normally
> +    used as a testing feature.
> +  - ``CAN_ISOTP_FORCE_RXSTMIN``: ignore CFs depending on rx stmin; norma=
lly
> +    used as a testing feature.
> +  - ``CAN_ISOTP_RX_EXT_ADDR``: use ``rx_ext_address`` instead of ``ext_a=
ddress``
> +    as extended addressing byte on the reception path.
> +  - ``CAN_ISOTP_WAIT_TX_DONE``: wait until the frame is sent before retu=
rning
> +    from ``write(2)`` and ``send(2)`` calls (i.e., blocking write operat=
ions).
> +  - ``CAN_ISOTP_SF_BROADCAST``: use 1-to-N functional addressing (cannot=
 be
> +    specified alongside ``CAN_ISOTP_CF_BROADCAST``).
> +  - ``CAN_ISOTP_CF_BROADCAST``: use 1-to-N transmission without flow con=
trol
> +    (cannot be specified alongside ``CAN_ISOTP_SF_BROADCAST``).
> +    NOTE: this is not covered by the ISO15765-2:2016 standard.
                                        ^^^^^^^^
Add a space between ISO and the number. Also, update the year:

  ISO 15765-2:2024

> +  - ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control
> +    parameters.
> +

Sometimes you put an empty line between the items, sometimes not. Be consis=
tent.

> +* ``frame_txtime``: frame transmission time (defined as N_As/N_Ar inside=
 the
> +  ISO standard); if ``0``, the default (or the last set value) is used.
> +  To set the transmission time to ``0``, the ``CAN_ISOTP_FRAME_TXTIME_ZE=
RO``
> +  macro (equal to 0xFFFFFFFF) shall be used.
> +
> +* ``ext_address``: extended addressing byte, used if the
> +  ``CAN_ISOTP_EXTEND_ADDR`` flag is specified.
> +
> +* ``txpad_content``: byte used as padding value for transmitted frames

Add a period at the end of the sentence.

> +
> +* ``rxpad_content``: byte used as padding value for received frames

Add a period at the end of the sentence.

> +
> +* ``rx_ext_address``: extended addressing byte for the reception path, u=
sed if
> +  the ``CAN_ISOTP_RX_EXT_ADDR`` flag is specified.
> +
> +Flow Control options
> +~~~~~~~~~~~~~~~~~~~~
> +
> +Flow Control (FC) options can be passed using the ``CAN_ISOTP_RECV_FC`` =
optname
> +to provide the communication parameters for receiving ISO-TP PDUs.
> +
> +.. code-block:: C
> +
> +    struct can_isotp_fc_options fc_opts;
> +    ret =3D setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RECV_FC, &fc_opts, si=
zeof(fc_opts));
> +
> +where the ``can_isotp_fc_options`` structure has the following contents:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_options {
> +        u8 bs;
> +        u8 stmin;
> +        u8 wftmax;
> +    };
> +
> +* ``bs``: blocksize provided in flow control frames.
> +
> +* ``stmin``: minimum separation time provided in flow control frames; ca=
n
> +  have the following values (others are reserved):
> +  - 0x00 - 0x7F : 0 - 127 ms
> +  - 0xF1 - 0xF9 : 100 us - 900 us
> +
> +* ``wftmax``: maximum number of wait frames provided in flow control fra=
mes.
> +
> +Link Layer options
> +~~~~~~~~~~~~~~~~~~
> +
> +Link Layer (LL) options can be passed using the ``CAN_ISOTP_LL_OPTS`` op=
tname:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_ll_options ll_opts;
> +    ret =3D setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_LL_OPTS, &ll_opts, si=
zeof(ll_opts));
> +
> +where the ``can_isotp_ll_options`` structure has the following contents:
> +
> +.. code-block:: C
> +
> +    struct can_isotp_ll_options {
> +        u8 mtu;
> +        u8 tx_dl;
> +        u8 tx_flags;
> +    };
> +
> +* ``mtu``: generated and accepted CAN frame type, can be equal to ``CAN_=
MTU``
> +  for classical CAN frames or ``CANFD_MTU`` for CAN FD frames.
> +
> +* ``tx_dl``: maximum payload length for transmitted frames, can have one=
 value
> +  among: 8, 12, 16, 20, 24, 32, 48, 64. Values above 8 only apply to CAN=
 FD
> +  traffic (i.e.: ``mtu =3D CANFD_MTU``).
> +
> +* ``tx_flags``: flags set into ``struct canfd_frame.flags`` at frame cre=
ation.
> +  Only applies to CAN FD traffic (i.e.: ``mtu =3D CANFD_MTU``).
> +
> +Transmission stmin
> +~~~~~~~~~~~~~~~~~~
> +
> +The transmission minimum separaton time (stmin) can be forced using the
                            ^^^^^^^^^
separation

> +``CAN_ISOTP_TX_STMIN`` optname and providing an stmin value in microseco=
nds as
> +a 32bit unsigned integer; this will overwrite the value sent by the rece=
iver in
> +flow control frames:
> +
> +.. code-block:: C
> +
> +    uint32_t stmin;
> +    ret =3D setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &stmin, siz=
eof(stmin));
> +
> +Reception stmin
> +~~~~~~~~~~~~~~~
> +
> +The reception minimum separaton time (stmin) can be forced using the
                         ^^^^^^^^^
separation

> +``CAN_ISOTP_RX_STMIN`` optname and providing an stmin value in microseco=
nds as
> +a 32bit unsigned integer; received Consecutive Frames (CF) which timesta=
mps
> +differ less than this value will be ignored:
> +
> +.. code-block:: C
> +
> +    uint32_t stmin;
> +    ret =3D setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, siz=
eof(stmin));
> +
> +Multi-frame transport support
> +-----------------------------
> +
> +The ISO-TP stack contained inside the Linux kernel supports the multi-fr=
ame
> +transport mechanism defined by the standard, with the following constrai=
nts:
> +
> +* the maximum size of a PDU is defined by a module parameter, with an ha=
rd
> +  limit imposed at build time
> +* when a transmission is in progress, subsequent calls to ``write(2)`` w=
ill
> +  block, while calls to ``send(2)`` will either block or fail depending =
on the
> +  presence of the ``MSG_DONTWAIT`` flag
> +* no support is present for sending "wait frames": whether a PDU can be =
fully
> +  received or not is decided when the First Frame is received

Add a period at the end of all the sentences of this enumeration.

Also, you sometimes use the hyphen '-' for your itemized list,
sometimes you use the asterix '*'. Choose one style and stay
consistent.

> +
> +Errors
> +------
> +
> +Following errors are reported to userspace:
> +
> +RX path errors
> +~~~~~~~~~~~~~~
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +-ETIMEDOUT   timeout of data reception
> +-EILSEQ      sequence number mismatch during a multi-frame reception
> +-EBADMSG     data reception with wrong padding
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +TX path errors
> +~~~~~~~~~~~~~~
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +-ECOMM     flow control reception timeout
> +-EMSGSIZE  flow control reception overflow
> +-EBADMSG   flow control reception with wrong layout/padding
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +Examples
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Basic node example
> +------------------
> +
> +Following example implements a node using "normal" physical addressing, =
with
> +RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options a=
re left
> +to their default.
> +
> +.. code-block:: C
> +
> +  int s;
> +  struct sockaddr_can addr;

Here, I would suggest the C99 designated field initialization:

  struct sockaddr_can addr =3D {
          .can_family =3D AF_CAN;
          .can_ifindex =3D if_nametoindex("can0");
          .tp.tx_id =3D 0x18DA42F1 | CAN_EFF_FLAG;
          .tp.rx_id =3D 0x18DAF142 | CAN_EFF_FLAG;
  };

Well, this is just a suggestion, feel free to reject it if you do not like =
it.

> +  int ret;
> +
> +  s =3D socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> +  if (s < 0)
> +      exit(1);
> +
> +  addr.can_family =3D AF_CAN;
> +  addr.can_ifindex =3D if_nametoindex("can0");

if_nametoindex() may fail. Because you are doing error handling in
this example, do it also here:

  if (!addr.can_ifindex)
          err("if_nametoindex()");

> +  addr.tp.tx_id =3D (0x18DA42F1 | CAN_EFF_FLAG);
> +  addr.tp.rx_id =3D (0x18DAF142 | CAN_EFF_FLAG);

Nitpick: the bracket are not needed here:

  addr.tp.tx_id =3D 0x18DA42F1 | CAN_EFF_FLAG;
  addr.tp.rx_id =3D 0x18DAF142 | CAN_EFF_FLAG;

> +
> +  ret =3D bind(s, (struct sockaddr *)&addr, sizeof(addr));
> +  if (ret < 0)
> +      exit(1);
> +
> +  // Data can now be received using read(s, ...) and sent using write(s,=
 ...)

Kernel style prefers C style comments over C++. I think that should
also apply to the documentation:

  /* Data can now be received using read(s, ...) and sent using write(s, ..=
) */

> +
> +Additional examples
> +-------------------
> +
> +More complete (and complex) examples can be found inside the ``isotp*`` =
userland
> +tools, distributed as part of the ``can-utils`` utilities at:
> +https://github.com/linux-can/can-utils
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6a233e1a3cf2..e0190b90d1a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4695,6 +4695,7 @@ W:        https://github.com/linux-can
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.g=
it
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-n=
ext.git
>  F:     Documentation/networking/can.rst
> +F:     Documentation/networking/iso15765-2.rst
>  F:     include/linux/can/can-ml.h
>  F:     include/linux/can/core.h
>  F:     include/linux/can/skb.h
> --
> 2.44.0
>
>

