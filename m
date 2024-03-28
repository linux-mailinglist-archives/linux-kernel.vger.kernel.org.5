Return-Path: <linux-kernel+bounces-102600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814387B46C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B9C41C21C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE845D74E;
	Wed, 13 Mar 2024 22:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW//v944"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611535D725;
	Wed, 13 Mar 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369413; cv=none; b=A/MfwB9AkM5+pGJAE7ces9VNLXSFU1dSTP9veriPz2LYtL697mUIDRuwpVG6k7jZt2tKS5Q1XjIAV9+nqbla8xQUUbChZpAAgs6riRTIQosOPhs8tltIEadnvQF71B97CS0Q+ZsgkWt3/Tg8hJDvycR+nPAMT+o65fI+fssSkeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369413; c=relaxed/simple;
	bh=9a7x6cEbvXeYZWZG12o7028Qm2LKkbmst7VP8IzH9tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQI47phkWVO4L2Ul9EkMHKODtovT2sLdr2LgDo0ogs5triMnZYVu80fjfkpU01SaWi6o0OOYoZFS5vQRDLdJ+mSKEnCeJfFOt975unnffpmpqaRZUO9GKAl11xgdHYLKMIFcAmOQhQzDQI5shpYeM933MlpDigqRRcJaUO4FDEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW//v944; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so31346366b.0;
        Wed, 13 Mar 2024 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369410; x=1710974210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8/7va6XpsEoIKAkhS4uOo4aTrZ7IpXRufdR477jfNg=;
        b=gW//v944Hi2dXmHWNAVqQjlorvc+DXvHYuJ/zLrjE5dUOINWVYWBcvDbX47k5Bg0MC
         GR/qf+EIdCMpCQJLNklRTR9m55BeV9i/vdjI8H0QLewQOKT915TZ98AAsUS8M/BL9fnr
         WbRGnySrWmT8iixIG1VwvWrm5PhyWh5ZRtGaCpz69y1q+Mj2UsunDQTgdzmNVFytNkvh
         ROvJ37FbOqxip+dLdgVHPG+0R8UARbpCZS/aL1oZAjLxSqkUy1iI5BPbvFAaaqPKuAjB
         nIu/i5IuarGBfRLp7k6DSkSWabsBczkh2BY34esGtbBjhRLFVlpQStFevDf3suojxxcM
         mQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369410; x=1710974210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8/7va6XpsEoIKAkhS4uOo4aTrZ7IpXRufdR477jfNg=;
        b=LwdLHLk52oe/CI1U1lrQAVUb4RswK7mMb5+JhpmT7z0doP7RgP+gPmWq6+ReCasj1M
         DKyhnTw6IYEgL27RSPqJkltrSAinebMlI7HfLtshJpKHOwMvJTpXd1F7pf+Dei6SyzW3
         CKXDmc2PovYlPhhBL4C4m1pYf/aLJpAHTz3lYwUIj1EB3oFluANzIlyrJcqkdk5f2SNu
         TthxM8uEiFg5yfJMh2k9sGQn7vQw90VnpICa+J0SlVZ5UAQL+FN8Yx1Pc0gsOTTSJAbJ
         XsqSH7jTskx0nYRL7aI2KnmUBAorpoIGcH/M7WjzdgfEJ2Dkp4dMPPH2oKV2kzab6NIV
         9hrw==
X-Forwarded-Encrypted: i=1; AJvYcCV8y/YgNdlFxBL7tY6BoBQU/GPFX89eGu0EiRYO/JFAFIIJP1qbwAqNhUHqZXOke/wL8j6ds3XMihI/q1c4fn2RZSBhFhVyr/YOTz8po4038FCaOrqQX82iyL0QogeVFEQ3mGhexBctth+C394G5VdAha9xdQVFLktDHUz6/0LC
X-Gm-Message-State: AOJu0YwQr5pvJcLP8xLEiF16GB+61JCV8MQLLKAO7WDFFJVx54XRC4jC
	SlG5fkWPhQJtw5ux5FzfrgYHymLGc3MzBeDjrscWYc03uv4xFfLx3UfDb12Y7F7dIQ==
X-Google-Smtp-Source: AGHT+IEg3DTdOePm5GIpCTJmspNkDFLTDxvR3/hB6iLclQvhsyOlr/zZvD1XtCApFIN6L1KieqU9EQ==
X-Received: by 2002:a17:907:160c:b0:a46:4548:aba6 with SMTP id cw12-20020a170907160c00b00a464548aba6mr5503898ejd.56.1710369409430;
        Wed, 13 Mar 2024 15:36:49 -0700 (PDT)
Received: from fedora.fritz.box (host-95-250-206-50.retail.telecomitalia.it. [95.250.206.50])
        by smtp.gmail.com with ESMTPSA id dt22-20020a170906b79600b00a4669f6c2e2sm70366ejb.44.2024.03.13.15.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 15:36:49 -0700 (PDT)
From: Francesco Valla <valla.francesco@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: fabio@redaril.me,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Valla <valla.francesco@gmail.com>
Subject: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Date: Wed, 13 Mar 2024 23:34:31 +0100
Message-ID: <20240313223445.87170-2-valla.francesco@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313223445.87170-1-valla.francesco@gmail.com>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document basic concepts, APIs and behaviour of the CAN ISO-TP (ISO
15765-2) stack.

Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
---
 Documentation/networking/index.rst |   1 +
 Documentation/networking/isotp.rst | 347 +++++++++++++++++++++++++++++
 2 files changed, 348 insertions(+)
 create mode 100644 Documentation/networking/isotp.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 473d72c36d61..ba22acfae389 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -19,6 +19,7 @@ Contents:
    caif/index
    ethtool-netlink
    ieee802154
+   isotp
    j1939
    kapi
    msg_zerocopy
diff --git a/Documentation/networking/isotp.rst b/Documentation/networking/isotp.rst
new file mode 100644
index 000000000000..d0c49fd1f5c9
--- /dev/null
+++ b/Documentation/networking/isotp.rst
@@ -0,0 +1,347 @@
+.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+====================
+ISO-TP (ISO 15765-2) Transport Protocol
+====================
+
+Overview
+=========================
+
+ISO-TP, also known as ISO 15765-2 from the ISO standard it is defined in, is a
+transport protocol specifically defined for diagnostic communication on CAN.
+It is widely used in the automotive industry, for example as the transport
+protocol for UDSonCAN (ISO 14229-3) or emission-related diagnostic services
+(ISO 15031-5).
+
+ISO-TP can be used both on classical (2.0B) CAN and CAN-FD based networks.
+It is also designed to be compatible with a CAN network using SAE J1939 as data
+link layer (however, this is not a requirement).
+
+Addressing
+----------
+
+In its simplest form, ISO-TP is based on two kinds of addresses for the nodes
+connected to the same network:
+
+- a physical address, which identifies a single node and is used in 1-to-1
+  communication
+- a functional addess, which identifies a group of nodes and is used in 1-to-N
+  communication
+
+In a so-called "normal" addressing scenario, both these addresses are
+represented by a single byte and can be inserted inside the 29-bit version of
+the CAN ID. However, in order to support larger networks, an "extended"
+addressing scheme can be adopted; in this case, the first byte of the data
+payload is used as an additional component of the address (both for the
+physical and functional cases).
+
+Transport protocol and associated frame types
+---------------------------------------------
+
+When transmitting data using the ISO-TP protocol, the payload can either fit
+inside one single CAN message or not, also considering the overhead the protocol
+is generating and the optional extended addressing. In the first case, the data
+is transmitted at once using a so-called Single Frame (SF). In the second case,
+ISO-TP defines a multi-frame protocol, in which the sender asks (through a First
+Frame - FF) to the receiver the maximum supported size of a macro data block
+(``blocksize``) and the minimum time time between the single CAN messages
+composing such block (``stmin``). Once these informations have been received,
+the sender starts to send frames containing fragments of the data payload
+(called Consecutive Frames - CF), stopping after every ``blocksize``-sized block
+to wait confirmation from the receiver (which should then send a Flow Control
+frame - FC - to inform the sender about its availability to receive more data).
+
+Specifications used
+-------------------
+
+* ISO 15765-2 : Road vehicles - Diagnostic communication over Controller Area
+  Network (DoCAN). Part 2: Transport protocol and network layer services.
+
+How to Use ISO-TP
+=================
+
+As with others CAN protocols, the ISO-TP stack support is built as a variant of
+the SocketCAN communication, and thus uses the socket APIs.
+
+Creation and basic usage of an ISO-TP socket
+--------------------------------------------
+
+To use the ISO-TP stack, ``#include <linux/can/isotp.h>`` shall be used. A
+socket can then be created using the ``PF_CAN`` protocol family, the
+``SOCK_DGRAM`` type (as the underlying protocol is datagram-based by design)
+and the ``CAN_ISOTP`` protocol:
+
+.. code-block:: C
+
+    s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
+
+After the socket has been successfully created, ``bind(2)`` shall be called to
+bind the socket to the desired CAN interface, either:
+
+* specifying at least one RX or TX address, as part of the sockaddr supplied
+  to the call itself, or
+* after specifying broadcast flags through socket option (explained below)
+
+Once bound to an interface, the socket can be read from and written to using
+the usual ``read(2)`` and ``write(2)`` system calls, as well as ``send(2)``,
+``sendmsg(2)``, ``recv(2)`` and ``recvmsg(2)``.
+Unlike raw SocketCAN sockets, only the data payload shall be specified in all
+these calls, as the CAN header is automatically filled by the ISO-TP stack
+using information supplied during socket creation. In the same way, the stack
+will use the transport mechanism when required (i.e., when the size of the data
+payload exceeds the MTU of the underlying CAN bus).
+
+The sockaddr structure used for SocketCAN has extensions for use with ISO-TP,
+as specified below:
+
+.. code-block:: C
+
+    struct sockaddr_can {
+        sa_family_t can_family;
+        int         can_ifindex;
+        union {
+            struct { canid_t rx_id, tx_id; } tp;
+        ...
+        } can_addr;
+    }
+
+* ``can_family`` and ``can_ifindex`` serve the same purpose as for other
+  SocketCAN sockets.
+
+* ``can_addr.tp.rx_id`` specifies the receive (RX) CAN ID and will be used as
+  a RX filter.
+
+* ``can_addr.tp.tx_id`` specifies the transmit (TX) CAN ID
+
+ISO-TP socket options
+---------------------
+
+When creating an ISO-TP socket, reasonable defaults are set. Some options can
+be modified with ``setsockopt(2)`` and/or read back with ``getsockopt(2)``.
+
+General options
+~~~~~~~~~~~~~~~
+
+General socket options can be passed using the ``CAN_ISOTP_OPTS`` optname:
+
+.. code-block:: C
+
+    struct can_isotp_options opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_OPTS, &opts, sizeof(opts))
+
+where the ``can_isotp_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_options {
+        u32 flags;
+        u32 frame_txtime;
+        u8  ext_address;
+        u8  txpad_content;
+        u8  rxpad_content;
+        u8  rx_ext_address;
+    };
+
+* ``flags``: modifiers to be applied to the default behaviour of the ISO-TP
+  stack. Following flags are available:
+
+  - ``CAN_ISOTP_LISTEN_MODE``: listen only (do not send FC frames)
+  - ``CAN_ISOTP_EXTEND_ADDR``: enable extended addressing, using the byte
+    specified in ``ext_address`` as additional address byte.
+  - ``CAN_ISOTP_TX_PADDING``: enable padding for tranmsitted frames, using
+    ``txpad_content`` as value for the padding bytes.
+  - ``CAN_ISOTP_RX_PADDING``: enable padding for the received frames, using
+    ``rxpad_content`` as value for the padding bytes.
+  - ``CAN_ISOTP_CHK_PAD_LEN``: check for correct padding length on the received
+    frames.
+  - ``CAN_ISOTP_CHK_PAD_DATA``: check padding bytes on the received frames
+    against ``rxpad_content``; if ``CAN_ISOTP_RX_PADDING`` is not specified,
+    this flag is ignored.
+  - ``CAN_ISOTP_HALF_DUPLEX``: force ISO-TP socket in half duples mode
+    (that is, transport mechanism can only be incoming or outgoing at the same
+    time, not both)
+  - ``CAN_ISOTP_FORCE_TXSTMIN``: ignore stmin from received FC
+  - ``CAN_ISOTP_FORCE_RXSTMIN``: ignore CFs depending on rx stmin
+  - ``CAN_ISOTP_RX_EXT_ADDR``: use ``rx_ext_address`` instead of ``ext_address``
+    as extended addressing byte on the reception path.
+  - ``CAN_ISOTP_WAIT_TX_DONE``: wait until the frame is sent before returning
+    from ``write(2)`` and ``send(2)`` calls (i.e., blocking write operations).
+  - ``CAN_ISOTP_SF_BROADCAST``: use 1-to-N functional addressing (cannot be
+    specified alongside ``CAN_ISOTP_CF_BROADCAST``)
+  - ``CAN_ISOTP_CF_BROADCAST``: use 1-to-N transmission without flow control
+    (cannot be specified alongside ``CAN_ISOTP_SF_BROADCAST``)
+  - ``CAN_ISOTP_DYN_FC_PARMS``: enable dynamic update of flow control parameters
+
+* ``frame_txtime``: frame transmission time (defined as N_As/N_Ar inside the
+  ISO standard); if ``0``, the default (or the last set value) is used.
+  To set the transmission time to ``0``, the ``CAN_ISOTP_FRAME_TXTIME_ZERO``
+  macro (equal to 0xFFFFFFFF) shall be used.
+
+* ``ext_address``: extended addressing byte, used if the
+  ``CAN_ISOTP_EXTEND_ADDR`` flag is specified.
+
+* ``txpad_content``: byte used as padding value for transmitted frames
+
+* ``rxpad_content``: byte used as padding value for received frames
+
+* ``rx_ext_address``: extended addressing byte for the reception path, used if
+  the ``CAN_ISOTP_RX_EXT_ADDR`` flag is specified.
+
+Flow Control options
+~~~~~~~~~~~~~~~~~~~~
+
+Flow Control (FC) options can be passed using the ``CAN_ISOTP_RECV_FC`` optname:
+
+.. code-block:: C
+
+    struct can_isotp_fc_options fc_opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RECV_FC, &fc_opts, sizeof(fc_opts));
+
+where the ``can_isotp_fc_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_options {
+        u8 bs;
+        u8 stmin;
+        u8 wftmax;
+    };
+
+* ``bs``: blocksize provided in flow control frames.
+
+* ``stmin``: minimum separation time provided in flow control frames; can
+  have the following values (others are reserved):
+  - 0x00 - 0x7F : 0 - 127 ms
+  - 0xF1 - 0xF9 : 100 us - 900 us
+
+* ``wftmax``: maximum number of wait frames provided in flow control frames.
+
+Link Layer options
+~~~~~~~~~~~~~~~~~~
+
+Link Layer (LL) options can be passed using the ``CAN_ISOTP_LL_OPTS`` optname:
+
+.. code-block:: C
+
+    struct can_isotp_ll_options ll_opts;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_LL_OPTS, &ll_opts, sizeof(ll_opts));
+
+where the ``can_isotp_ll_options`` structure has the following contents:
+
+.. code-block:: C
+
+    struct can_isotp_ll_options {
+        u8 mtu;
+        u8 tx_dl;
+        u8 tx_flags;
+    };
+
+* ``mtu``: generated and accepted CAN frame type, can be equal to ``CAN_MTU``
+  for classical CAN frames or ``CANFD_MTU`` for CAN FD frames.
+
+* ``tx_dl``: maximum payload length for transmitted frames, can have one value
+  among: 8, 12, 16, 20, 24, 32, 48, 64.
+
+* ``tx_flags``: flags set set into ``struct canfd_frame.flags`` at frame
+  creation.
+
+Transmission stmin
+~~~~~~~~~~~~~~~~~~
+
+The transmission minimum separaton time (stmin) can be forced using the
+``CAN_ISOTP_TX_STMIN`` optname and providing an stmin value in microseconds as
+a 32bit unsigned integer; this will overwrite the value sent by the receiver in
+flow control frames:
+
+.. code-block:: C
+
+    uint32_t stmin;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_TX_STMIN, &stmin, sizeof(stmin));
+
+Reception stmin
+~~~~~~~~~~~~~~~
+
+The reception minimum separaton time (stmin) can be forced using the
+``CAN_ISOTP_RX_STMIN`` optname and providing an stmin value in microseconds as
+a 32bit unsigned integer; received Consecutive Frames (CF) which timestamps
+differ less than this value will be ignored:
+
+.. code-block:: C
+
+    uint32_t stmin;
+    ret = setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, sizeof(stmin));
+
+Multi-frame transport support
+--------------------------
+
+The ISO-TP stack contained inside the Linux kernel supports the multi-frame
+transport mechanism defined by the standard, with the following contraints:
+
+* the maximum size of a PDU is defined by a module parameter, with an hard
+  limit imposed at build time
+* when a transmission is in progress, subsequent calls to ``write(2)`` will
+  block, while calls to ``send(2)`` will either block or fail depending on the
+  presence of the ``MSG_DONTWAIT`` flag
+* no support is present for sending "wait frames": wheter a PDU can be fully
+  received or not is decided when the First Frame is received
+
+Errors
+------
+
+Following errors are reported to userspace:
+
+RX path errors
+~~~~~~~~~~~~~~
+
+============ =================================================================
+-ETIMEDOUT   timeout of data reception
+-EILSEQ      sequence number mismatch during a multi-frame reception
+-EBADMSG     data reception with wrong padding
+============ =================================================================
+
+TX path errors
+~~~~~~~~~~~~~~
+
+========== =================================================================
+-ECOMM     flow control reception timeout
+-EMSGSIZE  flow control reception overflow
+-EBADMSG   flow control reception with wrong layout/padding
+========== =================================================================
+
+Examples
+========
+
+Basic node example
+------------------
+
+Following example implements a node using "normal" physical addressing, with
+RX ID equal to 0x18DAF142 and a TX ID equal to 0x18DA42F1. All options are left
+to their default.
+
+.. code-block:: C
+
+  int s;
+  struct sockaddr_can addr;
+  int ret;
+
+  s = socket(PF_CAN, SOCK_DGRAM, CAN_ISOTP);
+  if (s < 0)
+      exit(1);
+
+  addr.can_family = AF_CAN;
+  addr.can_ifindex = if_nametoindex("can0");
+  addr.tp.tx_id = 0x18DA42F1;
+  addr.tp.rx_id = 0x18DAF142;
+
+  ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+  if (ret < 0)
+      exit(1);
+
+  // Data can now be received using read(s, ...) and sent using write(s, ...)
+
+Additional examples
+-------------------
+
+More complete (and complex) examples can be found inside the ``isotp*`` userland
+tools, distributed as part of the ``can-utils`` utilities at:
+https://github.com/linux-can/can-utils
-- 
2.44.0


