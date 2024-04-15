Return-Path: <linux-kernel+bounces-144503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F24708A472E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 05:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B85BB21910
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 03:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDAE1C68F;
	Mon, 15 Apr 2024 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVSz1k7m"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E101C11;
	Mon, 15 Apr 2024 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713150581; cv=none; b=qSMaxL/4UoVhhNsLFl9B78ey+gpDDZfIf0y7S5q6fmgeS+nQQpXGmKfEztKuhX5bjkIBnyMOlaX+8OLCZalLhs6q371nSa+zQwwHVSlz0ciGG1N0mVy+G8IHR/ToK8YX9CnXTc/PZCQiQBFV+hTbOVIsU1yGmZjs8QmtZ5BOVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713150581; c=relaxed/simple;
	bh=B5c45AMoL3wzqBDQ4ZBb+uVb54X4ZMoy753JGePZM74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snjCtORrOK2/t28TtwtF4Gqayxc403gfewmMMY8qj3MheqljFJCsn4J7NQzPCI0YLgeiiLeyoja9weoDbTr5jiM/dB06a5hUG5yu+u0uR5PdZwOzk7g2Fm97C+khix5H/UaiNTIAOwro+FIwtwVMEC0o8HYxAMPJ1gMXa3VYkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVSz1k7m; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e40042c13eso18233525ad.2;
        Sun, 14 Apr 2024 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713150579; x=1713755379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UPWqCrnI8CghjSXhegqZCjZ+hwAoK3/5Alf8rtEL158=;
        b=IVSz1k7mw1mvXCB/cd/53I7WIe7nGDrh5wbXGyrh+jimkguwGgB/weDv+KjXlqrYA3
         HvEZqO+ymoLwlJ5m/yr8LXxJnzAzuH2LRZjLWsmtETU1SbciE6dL5h8116KDsS6m6R0n
         XOvrLSEDoLFtrANBMuhqnCRTBmoMi6d55LW+hsOFKMLaGNWHbE4i2kEq5Mh/SBvXyXK/
         2MuAt+ruTZBok53pqMGx5j6BVVF91pUq3oXE73Hhi/b2Rj3w+q4AVUOfW/LGk8vUzd8Y
         fY6hKpwh6wrwlT4iNm1qjL4RahSvMwxS21YIl1N8wJLyZufrUimL+ttAzx7QhzavsZ8q
         gjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713150579; x=1713755379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPWqCrnI8CghjSXhegqZCjZ+hwAoK3/5Alf8rtEL158=;
        b=so8sFEn09+lhbVY6YlKysK5DDJuLUizhTZ84zGw98Bq/sqUXyPxXhMd/3ZpodM9Brx
         kwVZ1Wb9b+zHQb96J83lCMrKCr6Di/6gjJ2sqvBiedqfubrv0eujcdK0CTYwD31mnjOK
         C/yGBZD890TnN8/xe5X2nWoa5v4kI7raEHgq+6MdE3Hw6GI6FJvlbUzIZ9qyygbVWJBs
         QTGMZI51W3XNzj8tahV1tgDT/HRb+tZQXvzVq1dDQi3JIian6ILfcww1Lgb1tVGMS9lU
         A8AJ0WaJzBdQLAUPj2e6kRyi1hxsGr/4TWrR4Jp+SYbb5U2zRhadMKUxsqznciokuGe5
         zovA==
X-Forwarded-Encrypted: i=1; AJvYcCVWUOzI0otV6Qy+Abc/MqTfVL7RXLPFwUeRQ5R60gnCHin4XZPKu4OfKmLxz3aS0UVaZF+6gmoAPc9Sl94rY1exgwoCS8LrPYGFhgc2lhtSBws6jS8GhLahyRTYL1r9iztEIpT2WLNq
X-Gm-Message-State: AOJu0YzzivSZwBKf4Nq5lXUr0FmlrOI4EjE9bZdVUTJ4bqwc/cL1F0ds
	3NKyQ+Sa0oUyBaWqJnQw/3t4SuTeY6L5UcH6rxF8L/V0QuvlFdQIcuD1Lw==
X-Google-Smtp-Source: AGHT+IG6tms+hwWgWQyxs7ksPXtrHMugpbRzHKUsNtWP2R77hJMhXyueqSeZ4f9UxLHfFb/9scWACg==
X-Received: by 2002:a17:903:32d0:b0:1e3:f923:e257 with SMTP id i16-20020a17090332d000b001e3f923e257mr9447732plr.49.1713150578931;
        Sun, 14 Apr 2024 20:09:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b001e5572a99c3sm6638102plh.207.2024.04.14.20.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 20:09:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 6E06D1850B725; Mon, 15 Apr 2024 10:09:35 +0700 (WIB)
Date: Mon, 15 Apr 2024 10:09:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Francesco Valla <valla.francesco@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Linux CAN <linux-can@vger.kernel.org>
Cc: Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Simon Horman <horms@kernel.org>, fabio@redaril.me,
	Mao Zhu <zhumao001@208suo.com>, Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
Message-ID: <Zhyabya8UyRG0ZY5@archie.me>
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qSWMrSDOEZitIUIC"
Content-Disposition: inline
In-Reply-To: <20240329133458.323041-3-valla.francesco@gmail.com>


--qSWMrSDOEZitIUIC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 02:34:41PM +0100, Francesco Valla wrote:
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
> +
> +How to Use ISO-TP
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +As with others CAN protocols, the ISO-TP stack support is built into the
> +Linux network subsystem for the CAN bus, aka. Linux-CAN or SocketCAN, and
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
> +* a RX CAN ID shall also specified, unless broadcast flags have been set
> +  through socket option (explained below)
> +
> +Once bound to an interface, the socket can be read from and written to u=
sing
> +the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2=
)``,
> +``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.
> +Unlike the CAN_RAW socket API, only the data payload shall be specified =
in all
> +these calls, as the CAN header is automatically filled by the ISO-TP sta=
ck
> +using information supplied during socket creation. In the same way, the =
stack
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
> +  - ``CAN_ISOTP_EXTEND_ADDR``: enable extended addressing, using the byte
> +    specified in ``ext_address`` as additional address byte.
> +  - ``CAN_ISOTP_TX_PADDING``: enable padding for tranmsitted frames, usi=
ng
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
> +  - ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control
> +    parameters.
> +
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
> +
> +* ``rxpad_content``: byte used as padding value for received frames
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
> +* ``stmin``: minimum separation time provided in flow control frames; can
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
> +  int ret;
> +
> +  s =3D socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
> +  if (s < 0)
> +      exit(1);
> +
> +  addr.can_family =3D AF_CAN;
> +  addr.can_ifindex =3D if_nametoindex("can0");
> +  addr.tp.tx_id =3D (0x18DA42F1 | CAN_EFF_FLAG);
> +  addr.tp.rx_id =3D (0x18DAF142 | CAN_EFF_FLAG);
> +
> +  ret =3D bind(s, (struct sockaddr *)&addr, sizeof(addr));
> +  if (ret < 0)
> +      exit(1);
> +
> +  // Data can now be received using read(s, ...) and sent using write(s,=
 ...)
> +
> +Additional examples
> +-------------------
> +
> +More complete (and complex) examples can be found inside the ``isotp*`` =
userland
> +tools, distributed as part of the ``can-utils`` utilities at:
> +https://github.com/linux-can/can-utils

Other than the ongoing review comments, the doc LGTM (no htmldocs warnings).
Thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--qSWMrSDOEZitIUIC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhyaYwAKCRD2uYlJVVFO
o7w4AP9/h/CFC1jxxuLbU6Cq4oODpPCwFLR9+5h4o2cXu4iUFAEAgwPt/DPSpG53
gKCQ92aZYRpMv0ofA6Q5FwbNDlksHAc=
=8BC7
-----END PGP SIGNATURE-----

--qSWMrSDOEZitIUIC--

