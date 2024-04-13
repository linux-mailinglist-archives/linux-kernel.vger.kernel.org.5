Return-Path: <linux-kernel+bounces-143833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC58A3DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 19:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBEC1C20F92
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAF524D0;
	Sat, 13 Apr 2024 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="PRQ9n2oh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ljRhNHZ0"
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6457C205E24;
	Sat, 13 Apr 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713029348; cv=pass; b=iUWGkArNDdgyajBTvGaINhxpshAb5m97gK8euXTHF8l70gcAFrUh5gIORtRA/qNh+8AQM6pYmwpPkNFVPhfYhIT24oEZxQM+Ry/IFWo0ABlzF57yVof+kf0XTGbqoKHTNXY0GWbKHJC4lk+vAJd8vI6yilLieOisrKZDhpFJZqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713029348; c=relaxed/simple;
	bh=hdAOoH0M8T0wKW5nzK49B4KfIbP4WUAD2lH9bfq5i9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tq1IntGQa/kswRmb5OOZlQZQxL90j0CtKLUo7noRB6No1QpceXEWfW+Q4KrqcgXL8VAyal0qAO3CmHwZHp8tjT392RceQ5yMUIPyxcQqiJn+0Boq7IjL/iKPHhl9mkJTkxTxLwxlRoV9qmdqghJzZLjUORNAaOPm0XziDJd7LS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=PRQ9n2oh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ljRhNHZ0; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1713029322; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ONtUTvJb9NMGihZalZLvdEUQWSp9rlg2MHWhQN2wpqLrXHO3KZvdCrUT0qRQN/qoCh
    MTdoYh8SnqyD5ZRfFp+9XRYBV/YjHt0yLGzFbIHb+hYtpgb/9qMcjXiwIoSCsaW1t2lO
    KyRw8tg4+wxAUV0yrGA3mH0oUIPmXcKCT7GvDgGqA5rsSlZCIkbOTWJB6hJxDvEbuaXV
    RbdMP8tB9eXk5hRh6zMo14wjs/iaCY3t4WkgEAMaqh5wC5NHAjjQGLh0lx8oKKvyb/Id
    maWZxyzFjMOBPCdkmjuKpsaNHjBuOxjahCGvFEJ5QX95/qtFGEBrxc+i78jLs4ywpra+
    Uxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1713029322;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FBH9LMoepmyrcw6RuF2NfXTeI1XfPgQ0pflvgRkY388=;
    b=XBrADgXh4JhrMcRHJ7Pn9YrZ0KncnALZMMBqqq2emMRbxjWjOyZvnQWzuSu5bjovrO
    WExiDFO57sjIrucXzbY01pjbvppzV/C/esNX6daR+yUFhtEgev3vO7B/EggsNrmNkwvr
    6AT/P6pT1Nu1wz9qrXagwvmnOERAsPl997xZf9mc9FS/qmQCqtixWnTCUORsctGxpi6X
    98NNnx8uKQAequjifgr15K9I/HZ5N0OJiUEaPLmkYt3n1vHhdD//iaWw11QkHshDiAJ5
    Fg3q7W7lFQhET1V6WRo9bh7UtcAiIKc6nIbN72qrVIjzzL4+PXV+142jJ8iJ8jnNekVS
    LcAw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1713029322;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FBH9LMoepmyrcw6RuF2NfXTeI1XfPgQ0pflvgRkY388=;
    b=PRQ9n2ohGKG5bb1C+YYmWDjBA8RDDjYeUpvFzeCb9edYUwX9U3lSqL6s7cyM9g+H2G
    RMvp0a319NViTfvxbIuT1WDAxST+fwGT2rJZ9Jdt7pIf1PnFHn6ZJdf6gVTI9ozx/B9Q
    YmGQ4mWhV0NI/zboUYwlSKBob5IQ4FPm/By/ZXD9PODgL9fvEf7l9qYHwqQXo/uwOFFL
    WoxY7CfBs+VaM2ADiOXOmZPFwpZ1etEVdTOEZgXskUciIjj0CkUuXFgmYiYQzZAjk/GY
    kGC+isGWz/Bk9KhoReUVEdaQDwlqsgj5iSGbEt0vJdKE4eIC8S7MgThnmElTx/Kk8nHt
    y1XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1713029322;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=FBH9LMoepmyrcw6RuF2NfXTeI1XfPgQ0pflvgRkY388=;
    b=ljRhNHZ0IWELsrpQJiyn1McNR74RtnIF4YRpK5KAxqQCvoRKTE+5urre38sj+YfswC
    yf8W5vdO57OeFUrgxbDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFr0USEbHoO0g=="
Received: from [IPV6:2a00:6020:4a8e:5010::923]
    by smtp.strato.de (RZmta 50.3.2 AUTH)
    with ESMTPSA id K701d603DHSgJ9D
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 13 Apr 2024 19:28:42 +0200 (CEST)
Message-ID: <9f5ad308-f2a0-47be-85f3-d152bc98099a@hartkopp.net>
Date: Sat, 13 Apr 2024 19:28:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: networking: document ISO
 15765-2:2016
To: Vincent Mailhol <vincent.mailhol@gmail.com>,
 Francesco Valla <valla.francesco@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
 fabio@redaril.me
References: <20240329133458.323041-2-valla.francesco@gmail.com>
 <20240329133458.323041-3-valla.francesco@gmail.com>
 <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <CAMZ6RqKLaYb+8EaeoFMHofcaBT5G2-qdqSb4do73xrgMvWMZaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

On 13.04.24 15:11, Vincent Mailhol wrote:
> Hi Francesco,
> 
> Thank you for the ISO-TP documentation.
> 
> I left a few comments, but overall, good work. Also, I did not double
> check each individual option one by one.
> 
> On Sat. 30 Mar 2024 at 00:06, Francesco Valla <valla.francesco@gmail.com> wrote:
>> Document basic concepts, APIs and behaviour of the ISO 15675-2:2016
>> (ISO-TP) CAN stack.
>>
>> Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
>> ---
>>   Documentation/networking/index.rst      |   1 +
>>   Documentation/networking/iso15765-2.rst | 356 ++++++++++++++++++++++++
>>   MAINTAINERS                             |   1 +
>>   3 files changed, 358 insertions(+)
>>   create mode 100644 Documentation/networking/iso15765-2.rst
>>
>> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
>> index 473d72c36d61..bbd9bf537793 100644
>> --- a/Documentation/networking/index.rst
>> +++ b/Documentation/networking/index.rst
>> @@ -19,6 +19,7 @@ Contents:
>>      caif/index
>>      ethtool-netlink
>>      ieee802154
>> +   iso15765-2
>>      j1939
>>      kapi
>>      msg_zerocopy
>> diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
>> new file mode 100644
>> index 000000000000..bbed4d2ef1a8
>> --- /dev/null
>> +++ b/Documentation/networking/iso15765-2.rst
>> @@ -0,0 +1,356 @@
>> +.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>> +
>> +=========================
>> +ISO 15765-2:2016 (ISO-TP)
>> +=========================
>> +
>> +Overview
>> +========
>> +
>> +ISO 15765-2:2016, also known as ISO-TP, is a transport protocol specifically
>> +defined for diagnostic communication on CAN. It is widely used in the automotive
>> +industry, for example as the transport protocol for UDSonCAN (ISO 14229-3) or
>> +emission-related diagnostic services (ISO 15031-5).
>> +
>> +ISO-TP can be used both on CAN CC (aka Classical CAN, CAN 2.0B) and CAN FD (CAN
> 
> CC is already the abbreviation of *C*lassical *C*AN. Saying CAN CC, is
> like saying CAN Classical CAN, c.f. the RAS syndrome:
> 
>    https://en.wikipedia.org/wiki/RAS_syndrome
> 
> Then, considering the CAN2.0B, as far as I know, ISO-TP can also be
> used on CAN2.0A (as long as you only use 11 bits CAN ids).

The suggestion "be used both on CAN CC (aka Classical CAN, CAN 2.0B) and 
CAN FD" was from my side.

And this follows the new CAN in Automation (can-cia.org) naming scheme.
E.g. https://www.can-cia.org/can-knowledge/can/cybersecurity-for-can/
"“Safety and security” specifies generic security options for CAN CC and 
CAN FD protocols."

So your hint to the RAS syndrome is right but in this case the this is 
intentional to be able to reference CAN CC/FD/XL content.

For that reason I wanted to introduce the new CAN CC naming scheme which 
is pretty handy IMO.

> 
> So, I would rather just say:
> 
>    ISO-TP can be used both on Classical CAN and CAN FD...
> 



>> +with Flexible Datarate) based networks. It is also designed to be compatible
>> +with a CAN network using SAE J1939 as data link layer (however, this is not a
>> +requirement).
>> +
>> +Specifications used
>> +-------------------
>> +
>> +* ISO 15765-2:2016 : Road vehicles - Diagnostic communication over Controller
> 
> ISO 15765-2:2016 is withdrawn. The latest version is 15765-2:2024.
> 
>> +  Area Network (DoCAN). Part 2: Transport protocol and network layer services.
>> +
>> +Addressing
>> +----------
>> +
>> +In its simplest form, ISO-TP is based on two kinds of addressing modes for the
>> +nodes connected to the same network:
>> +
>> +- physical addressing is implemented by two node-specific addresses (CAN
>> +  identifiers) and is used in 1-to-1 communication
>> +- functional addressing is implemented by one node-specific address (CAN
>> +  identifier) and is used in 1-to-N communication
>> +
>> +In a so-called "normal" addressing scenario, both these addresses are
>> +represented by a 29-bit CAN ID. However, in order to support larger networks,
>> +an "extended" addressing scheme can be adopted: in this case, the first byte of
>> +the data payload is used as an additional component of the address (both for
>> +the physical and functional cases); two different CAN IDs are still required.
> 
> There is more than that.
> 
>    - The normal addressing can also use the non-extended 11 bits CAN ID.

Right!

>    - In addition to the normal and extended addressing mode, there
>      is a third mode: the mixed addressing.
> 
> Ref:
> 
>    - ISO 15765:2024 §10.3.1 "Addressing formats"
>    - https://www.embedded-communication.com/en/misc/iso-tp-addressing/
> 
>> +
>> +Transport protocol and associated frame types
>> +---------------------------------------------
>> +
>> +When transmitting data using the ISO-TP protocol, the payload can either fit
>> +inside one single CAN message or not, also considering the overhead the protocol
>> +is generating and the optional extended addressing. In the first case, the data
>> +is transmitted at once using a so-called Single Frame (SF). In the second case,
>> +ISO-TP defines a multi-frame protocol, in which the sender provides (through a
>> +First Frame - FF) the PDU length which is to be transmitted and also asks for a
>> +Flow Control (FC) frame, which provides the maximum supported size of a macro
>> +data block (``blocksize``) and the minimum time between the single CAN messages
>> +composing such block (``stmin``). Once this information has been received, the
>> +sender starts to send frames containing fragments of the data payload (called
>> +Consecutive Frames - CF), stopping after every ``blocksize``-sized block to wait
>> +confirmation from the receiver (which should then send another Flow Control
>> +frame to inform the sender about its availability to receive more data).
> 
> Nitpick: I do not see the need for the brackets here:
> 
>    confirmation from the receiver which should then send another Flow Control
>    frame to inform the sender about its availability to receive more data.
> 
>> +How to Use ISO-TP
>> +=================
>> +
>> +As with others CAN protocols, the ISO-TP stack support is built into the
>> +Linux network subsystem for the CAN bus, aka. Linux-CAN or SocketCAN, and
>> +thus follows the same socket API.
>> +
>> +Creation and basic usage of an ISO-TP socket
>> +--------------------------------------------
>> +
>> +To use the ISO-TP stack, ``#include <linux/can/isotp.h>`` shall be used. A
>> +socket can then be created using the ``PF_CAN`` protocol family, the
>> +``SOCK_DGRAM`` type (as the underlying protocol is datagram-based by design)
>> +and the ``CAN_ISOTP`` protocol:
>> +
>> +.. code-block:: C
>> +
>> +    s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
>> +
>> +After the socket has been successfully created, ``bind(2)`` shall be called to
>> +bind the socket to the desired CAN interface; to do so:
>> +
>> +* a TX CAN ID shall be specified as part of the sockaddr supplied to the call
>> +  itself, and
> 
> Why did you put a newline here?
> 
>> +* a RX CAN ID shall also specified, unless broadcast flags have been set
>> +  through socket option (explained below)
> 
> Add a period at the end of your sentence:
> 
>    through socket option (explained below).
> 
>> +Once bound to an interface, the socket can be read from and written to using
>> +the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2)``,
>> +``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.
> 
> If this is a new paragraph, leave an empty newline. If not, do not add
> a newline before you reach the character column limit.
> 
>> +Unlike the CAN_RAW socket API, only the data payload shall be specified in all
>> +these calls, as the CAN header is automatically filled by the ISO-TP stack
>> +using information supplied during socket creation. In the same way, the stack
> 
> This is making a shortcut. There are the raw CAN payload and the
> ISO-TP payload. In this paragraph it is not clear that "data payload"
> is referring to the ISO-TP payload.
> 
> Also, what is the meaning of "the CAN header". Here, I think you mean
> CAN ID plus some of the few first byte of the CAN payload.
> 
> I suggest that you use more precise vocabulary from the standard:
> 
>    - Address information
>    - Protocol Information
>    - Data field
> 
> Something like:
> 
>    only the ISO-TP data field (the actual payload) is sent. The
>    address information and the protocol information is
>    automatically filled by the ISO-TP stack...
> 
>> +will use the transport mechanism when required (i.e., when the size of the data
>> +payload exceeds the MTU of the underlying CAN bus).
>> +
>> +The sockaddr structure used for SocketCAN has extensions for use with ISO-TP,
>> +as specified below:
>> +
>> +.. code-block:: C
>> +
>> +    struct sockaddr_can {
>> +        sa_family_t can_family;
>> +        int         can_ifindex;
>> +        union {
>> +            struct { canid_t rx_id, tx_id; } tp;
>> +        ...
>> +        } can_addr;
>> +    }
>> +
>> +* ``can_family`` and ``can_ifindex`` serve the same purpose as for other
>> +  SocketCAN sockets.
>> +
>> +* ``can_addr.tp.rx_id`` specifies the receive (RX) CAN ID and will be used as
>> +  a RX filter.
>> +
>> +* ``can_addr.tp.tx_id`` specifies the transmit (TX) CAN ID
>> +
>> +ISO-TP socket options
>> +---------------------
>> +
>> +When creating an ISO-TP socket, reasonable defaults are set. Some options can
>> +be modified with ``setsockopt(2)`` and/or read back with ``getsockopt(2)``.
>> +
>> +General options
>> +~~~~~~~~~~~~~~~
>> +
>> +General socket options can be passed using the ``CAN_ISOTP_OPTS`` optname:
>> +
>> +.. code-block:: C
>> +
>> +    struct can_isotp_options opts;
>> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts))
>> +
>> +where the ``can_isotp_options`` structure has the following contents:
>> +
>> +.. code-block:: C
>> +
>> +    struct can_isotp_options {
>> +        u32 flags;
>> +        u32 frame_txtime;
>> +        u8  ext_address;
>> +        u8  txpad_content;
>> +        u8  rxpad_content;
>> +        u8  rx_ext_address;
>> +    };
>> +
>> +* ``flags``: modifiers to be applied to the default behaviour of the ISO-TP
>> +  stack. Following flags are available:
>> +
>> +  - ``CAN_ISOTP_LISTEN_MODE``: listen only (do not send FC frames); normally
>> +    used as a testing feature.
>> +  - ``CAN_ISOTP_EXTEND_ADDR``: enable extended addressing, using the byte
>> +    specified in ``ext_address`` as additional address byte.
>                                      ^^^^^^^^^^^^^
> as an additional
> 
>> +  - ``CAN_ISOTP_TX_PADDING``: enable padding for tranmsitted frames, using
>                                                      ^^^^^^^^^^^
> transmitted
> 
>> +    ``txpad_content`` as value for the padding bytes.
>> +  - ``CAN_ISOTP_RX_PADDING``: enable padding for the received frames, using
>> +    ``rxpad_content`` as value for the padding bytes.
>> +  - ``CAN_ISOTP_CHK_PAD_LEN``: check for correct padding length on the received
>> +    frames.
>> +  - ``CAN_ISOTP_CHK_PAD_DATA``: check padding bytes on the received frames
>> +    against ``rxpad_content``; if ``CAN_ISOTP_RX_PADDING`` is not specified,
>> +    this flag is ignored.
>> +  - ``CAN_ISOTP_HALF_DUPLEX``: force ISO-TP socket in half duples mode
>                                                                ^^^^^^
> duplex
> 
>> +    (that is, transport mechanism can only be incoming or outgoing at the same
>> +    time, not both).
>> +  - ``CAN_ISOTP_FORCE_TXSTMIN``: ignore stmin from received FC; normally
>> +    used as a testing feature.
>> +  - ``CAN_ISOTP_FORCE_RXSTMIN``: ignore CFs depending on rx stmin; normally
>> +    used as a testing feature.
>> +  - ``CAN_ISOTP_RX_EXT_ADDR``: use ``rx_ext_address`` instead of ``ext_address``
>> +    as extended addressing byte on the reception path.
>> +  - ``CAN_ISOTP_WAIT_TX_DONE``: wait until the frame is sent before returning
>> +    from ``write(2)`` and ``send(2)`` calls (i.e., blocking write operations).
>> +  - ``CAN_ISOTP_SF_BROADCAST``: use 1-to-N functional addressing (cannot be
>> +    specified alongside ``CAN_ISOTP_CF_BROADCAST``).
>> +  - ``CAN_ISOTP_CF_BROADCAST``: use 1-to-N transmission without flow control
>> +    (cannot be specified alongside ``CAN_ISOTP_SF_BROADCAST``).
>> +    NOTE: this is not covered by the ISO15765-2:2016 standard.
>                                          ^^^^^^^^
> Add a space between ISO and the number. Also, update the year:
> 
>    ISO 15765-2:2024
> 

Interesting! Didn't know there's already a new version.

Will check this out whether we really support ISO 15765-2:2024 ...

Do you have the standard at hand right now or should we leave this as 
ISO15765-2:2016 until we know?

>> +  - ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control
>> +    parameters.
>> +
> 
> Sometimes you put an empty line between the items, sometimes not. Be consistent.
> 
>> +* ``frame_txtime``: frame transmission time (defined as N_As/N_Ar inside the
>> +  ISO standard); if ``0``, the default (or the last set value) is used.
>> +  To set the transmission time to ``0``, the ``CAN_ISOTP_FRAME_TXTIME_ZERO``
>> +  macro (equal to 0xFFFFFFFF) shall be used.
>> +
>> +* ``ext_address``: extended addressing byte, used if the
>> +  ``CAN_ISOTP_EXTEND_ADDR`` flag is specified.
>> +
>> +* ``txpad_content``: byte used as padding value for transmitted frames
> 
> Add a period at the end of the sentence.
> 
>> +
>> +* ``rxpad_content``: byte used as padding value for received frames
> 
> Add a period at the end of the sentence.
> 
>> +
>> +* ``rx_ext_address``: extended addressing byte for the reception path, used if
>> +  the ``CAN_ISOTP_RX_EXT_ADDR`` flag is specified.
>> +
>> +Flow Control options
>> +~~~~~~~~~~~~~~~~~~~~
>> +
>> +Flow Control (FC) options can be passed using the ``CAN_ISOTP_RECV_FC`` optname
>> +to provide the communication parameters for receiving ISO-TP PDUs.
>> +
>> +.. code-block:: C
>> +
>> +    struct can_isotp_fc_options fc_opts;
>> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RECV_FC, &fc_opts, sizeof(fc_opts));
>> +
>> +where the ``can_isotp_fc_options`` structure has the following contents:
>> +
>> +.. code-block:: C
>> +
>> +    struct can_isotp_options {
>> +        u8 bs;
>> +        u8 stmin;
>> +        u8 wftmax;
>> +    };
>> +
>> +* ``bs``: blocksize provided in flow control frames.
>> +
>> +* ``stmin``: minimum separation time provided in flow control frames; can
>> +  have the following values (others are reserved):
>> +  - 0x00 - 0x7F : 0 - 127 ms
>> +  - 0xF1 - 0xF9 : 100 us - 900 us
>> +
>> +* ``wftmax``: maximum number of wait frames provided in flow control frames.
>> +
>> +Link Layer options
>> +~~~~~~~~~~~~~~~~~~
>> +
>> +Link Layer (LL) options can be passed using the ``CAN_ISOTP_LL_OPTS`` optname:
>> +
>> +.. code-block:: C
>> +
>> +    struct can_isotp_ll_options ll_opts;
>> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_LL_OPTS, &ll_opts, sizeof(ll_opts));
>> +
>> +where the ``can_isotp_ll_options`` structure has the following contents:
>> +
>> +.. code-block:: C
>> +
>> +    struct can_isotp_ll_options {
>> +        u8 mtu;
>> +        u8 tx_dl;
>> +        u8 tx_flags;
>> +    };
>> +
>> +* ``mtu``: generated and accepted CAN frame type, can be equal to ``CAN_MTU``
>> +  for classical CAN frames or ``CANFD_MTU`` for CAN FD frames.
>> +
>> +* ``tx_dl``: maximum payload length for transmitted frames, can have one value
>> +  among: 8, 12, 16, 20, 24, 32, 48, 64. Values above 8 only apply to CAN FD
>> +  traffic (i.e.: ``mtu = CANFD_MTU``).
>> +
>> +* ``tx_flags``: flags set into ``struct canfd_frame.flags`` at frame creation.
>> +  Only applies to CAN FD traffic (i.e.: ``mtu = CANFD_MTU``).
>> +
>> +Transmission stmin
>> +~~~~~~~~~~~~~~~~~~
>> +
>> +The transmission minimum separaton time (stmin) can be forced using the
>                              ^^^^^^^^^
> separation
> 
>> +``CAN_ISOTP_TX_STMIN`` optname and providing an stmin value in microseconds as
>> +a 32bit unsigned integer; this will overwrite the value sent by the receiver in
>> +flow control frames:
>> +
>> +.. code-block:: C
>> +
>> +    uint32_t stmin;
>> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &stmin, sizeof(stmin));
>> +
>> +Reception stmin
>> +~~~~~~~~~~~~~~~
>> +
>> +The reception minimum separaton time (stmin) can be forced using the
>                           ^^^^^^^^^
> separation
> 
>> +``CAN_ISOTP_RX_STMIN`` optname and providing an stmin value in microseconds as
>> +a 32bit unsigned integer; received Consecutive Frames (CF) which timestamps
>> +differ less than this value will be ignored:
>> +
>> +.. code-block:: C
>> +
>> +    uint32_t stmin;
>> +    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, sizeof(stmin));
>> +
>> +Multi-frame transport support
>> +-----------------------------
>> +
>> +The ISO-TP stack contained inside the Linux kernel supports the multi-frame
>> +transport mechanism defined by the standard, with the following constraints:
>> +
>> +* the maximum size of a PDU is defined by a module parameter, with an hard
>> +  limit imposed at build time
>> +* when a transmission is in progress, subsequent calls to ``write(2)`` will
>> +  block, while calls to ``send(2)`` will either block or fail depending on the
>> +  presence of the ``MSG_DONTWAIT`` flag
>> +* no support is present for sending "wait frames": whether a PDU can be fully
>> +  received or not is decided when the First Frame is received
> 
> Add a period at the end of all the sentences of this enumeration.
> 
> Also, you sometimes use the hyphen '-' for your itemized list,
> sometimes you use the asterix '*'. Choose one style and stay
> consistent.
> 
>> +
>> +Errors
>> +------
>> +
>> +Following errors are reported to userspace:
>> +
>> +RX path errors
>> +~~~~~~~~~~~~~~
>> +
>> +============ ===============================================================
>> +-ETIMEDOUT   timeout of data reception
>> +-EILSEQ      sequence number mismatch during a multi-frame reception
>> +-EBADMSG     data reception with wrong padding
>> +============ ===============================================================
>> +
>> +TX path errors
>> +~~~~~~~~~~~~~~
>> +
>> +========== =================================================================
>> +-ECOMM     flow control reception timeout
>> +-EMSGSIZE  flow control reception overflow
>> +-EBADMSG   flow control reception with wrong layout/padding
>> +========== =================================================================
>> +
>> +Examples
>> +========
>> +
>> +Basic node example
>> +------------------
>> +
>> +Following example implements a node using "normal" physical addressing, with
>> +RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options are left
>> +to their default.
>> +
>> +.. code-block:: C
>> +
>> +  int s;
>> +  struct sockaddr_can addr;
> 
> Here, I would suggest the C99 designated field initialization:
> 
>    struct sockaddr_can addr = {
>            .can_family = AF_CAN;
>            .can_ifindex = if_nametoindex("can0");
>            .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
>            .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
>    };
> 
> Well, this is just a suggestion, feel free to reject it if you do not like it.

At least I don't like it.

These values are usually interactively given on the command line:

 >            .can_ifindex = if_nametoindex("can0");
 >            .tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
 >            .tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;

So have it in a static field initialization leads to a wrong path IMO.

> 
>> +  int ret;
>> +
>> +  s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
>> +  if (s < 0)
>> +      exit(1);
>> +
>> +  addr.can_family = AF_CAN;
>> +  addr.can_ifindex = if_nametoindex("can0");
> 
> if_nametoindex() may fail. Because you are doing error handling in
> this example, do it also here:
> 
>    if (!addr.can_ifindex)
>            err("if_nametoindex()");
> 

This is not really needed for an example like this.

When we have a problem here the bind() syscall with fail with -ENODEV

>> +  addr.tp.tx_id = (0x18DA42F1 | CAN_EFF_FLAG);
>> +  addr.tp.rx_id = (0x18DAF142 | CAN_EFF_FLAG);
> 
> Nitpick: the bracket are not needed here:
> 
>    addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
>    addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
> 
>> +
>> +  ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
>> +  if (ret < 0)
>> +      exit(1);
>> +
>> +  // Data can now be received using read(s, ...) and sent using write(s, ...)
> 
> Kernel style prefers C style comments over C++. I think that should
> also apply to the documentation:
> 
>    /* Data can now be received using read(s, ...) and sent using write(s, ...) */
>

ACK

>> +
>> +Additional examples
>> +-------------------
>> +
>> +More complete (and complex) examples can be found inside the ``isotp*`` userland
>> +tools, distributed as part of the ``can-utils`` utilities at:
>> +https://github.com/linux-can/can-utils
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6a233e1a3cf2..e0190b90d1a8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4695,6 +4695,7 @@ W:        https://github.com/linux-can
>>   T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git
>>   T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git
>>   F:     Documentation/networking/can.rst
>> +F:     Documentation/networking/iso15765-2.rst
>>   F:     include/linux/can/can-ml.h
>>   F:     include/linux/can/core.h
>>   F:     include/linux/can/skb.h
>> --
>> 2.44.0
>>
>>
> 

Thanks for the review, Vincent!

Best regards,
Oliver

