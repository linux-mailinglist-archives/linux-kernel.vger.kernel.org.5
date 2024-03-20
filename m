Return-Path: <linux-kernel+bounces-108421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB70880A4F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603621F236BC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E5D224C9;
	Wed, 20 Mar 2024 04:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b="WzM3oORq"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA87721100
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 04:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710908442; cv=none; b=eiyylHeilewur6RABTmYLXNqCJW5thAwUy5rQCJqNU5s8RA+R6OiznUw2p1dzqeTs6HSyLA6hcMZp0wNwB8TIhktR+hcSFWWNy+gbb1rt9UzipmdUho+Uz8z2TtddmVzKz5tfrfJbCLtvONvz9xF7YrlU5YsmJLyCQrmjtbOpk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710908442; c=relaxed/simple;
	bh=SjbEN4fkrrBL1ck5gPJrGqik62t0NXeQF6UqdJMndQI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pud5hR344Eq1IO3puF+k9mKLlauIHysdAjcUakhxH0JHzYfV2vToYYLCL1l8sWM5T6seLl7Z0pMqL/zsPXctQ8ywA+HEcKE6YhkMyirER50kk7Vaci6Pyy+MmUKPpacM3Yafw9aUEy5YzqeLvvagAhpu+X6Gvt9yGxA51Bux7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com; spf=pass smtp.mailfrom=turingpi.com; dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b=WzM3oORq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turingpi.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso4835151a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 21:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=turingpi.com; s=google; t=1710908440; x=1711513240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zXzIlG5TYdMxur/TeuDOa7DGRuUn8c/2Q48Teo2gnXY=;
        b=WzM3oORqQlMQOKcZLF3NzBZM4MY5wThfEGquETU6NBC7qcxi30OCAn1dipgE8zsPVx
         MIR4e7YryUG2sya3aZnGtBqJiTlnANuZenUtYVq835TsOObCV20EgL6KoH604EXTzj+y
         2WI2ccJo0OvxGb7NR/SiYPIAjVMNdJ7zsAP3wAUdvUc/vVI/PDy+S1LEQZN34YrUYg/5
         x3Dgw3W9YCOZvwUNKsci0XHrn/OXrIIvqTsUMgy2lkHigl65WvvjnMulEfhKsp0hkztB
         aYpV1dLSGcw3QvOOZo+NJMZDoNJnOcyVFOnV7DPs8g0hMd/Sel+wpA7yxnS/pc1IhzhW
         ByHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710908440; x=1711513240;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXzIlG5TYdMxur/TeuDOa7DGRuUn8c/2Q48Teo2gnXY=;
        b=Qk8nokKNLqkaYTCciqrU9vUoUSulCTUwVh2euHyoFwP0yycdPdgRhrI9Gp85pDC/sA
         wpsroDzD8bIBQXLsIcEYGAxE1rqMX7HXm/0iJlpSV+zx5xxSiPd3oUpgf5dqo+zPBYv/
         XPeJX6Y47Y0yzGn4zTGy0sEZY8dsCtDu2NjGMa7c3DcQrDjVI0LCrek7h70/LHqdaVpg
         Dsb+ZU9PjAczEiKuXhwCwgfDtyZFfcBJn0vgbKr9y86B763Ea0uYI1gEoIhcm64U5oz8
         sLFobnw5TOrcDuzDiD+dZ0CUDMfK8aGGxf6UVWGAQNDXcBUnX+gB+cdDsx9QOSt5jhqw
         WPQA==
X-Forwarded-Encrypted: i=1; AJvYcCXGzTVN7JfwsFxmc37mfW437MYZ2CsP6vwghJhj0djHU6Tw0EGWdollGDC6n375si+hOk7a7PhmK4ziJoYd30q5qflXcfI4VzjCmj/l
X-Gm-Message-State: AOJu0YzayU4wANLT2OQyL82BBuzH2vEZxuQIaGSOVUG1MpWvrwmFjgmC
	iX7skinKCxH3sRpPXsUYebzJr0zi14Bfid0HzaHMe6F5HF+0tiuOmkHYMCh7CrSKPkD2sjkeygd
	sGHQtEIIEXl+9Rh4VYRKUHxmBA0adcderEG/o1Q==
X-Google-Smtp-Source: AGHT+IHLc/sHqe1BPJZKiM9d8WGXJt3ykzdFPowhPBIUGdabOE1ph8nHAaE8apaaQ5wtFd5++lXLpeaXEcj08Ikb60M=
X-Received: by 2002:a05:6a20:3c9e:b0:1a3:4e19:1831 with SMTP id
 b30-20020a056a203c9e00b001a34e191831mr5564805pzj.13.1710908440204; Tue, 19
 Mar 2024 21:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sam Edwards <sam@turingpi.com>
Date: Tue, 19 Mar 2024 22:20:29 -0600
Message-ID: <CAF8uH3sH0LXnxMxy0Nw12J7+bxR6SM3TfCob0yHq0Yj-vmJ6ww@mail.gmail.com>
Subject: [RESEND RFC PATCH 3/5] i2c: mv64xxx: Refactor FSM
To: Gregory CLEMENT <gregory.clement@bootlin.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Conceptually, there are two FSMs here: a hardware FSM in the MV64XXX
itself, and a software FSM in the driver. The current software FSM is
not a "real" FSM: it is just using the hardware status to decide what to
do next, and the `state` is mostly unused.

There are two drawbacks to this approach:
1) If the hardware returns an unexpected status, the driver will accept
   it blindly, allowing bugs to go unnoticed and complicating testing.
2) The driver FSM cannot have states/transitions not represented in
   hardware.

Rework this by making the hardware status decoder state-aware, and
introducing an enum of "events" which can be fed to the driver FSM that
reflect the hardware events deduced by the status decoder. Any
unexpected status results in an "invalid" event, which triggers the
driver's error recovery. The state machine logic is otherwise the same:
the sequence of actions emitted by the FSM is unchanged by this patch.

Note: The meaning of bytes_left in reads is now the number of byte reads
left to *start* on the hardware, not the number of bytes left to be read
from the data register.

Signed-off-by: Sam Edwards <sam@turingpi.com>
---
 drivers/i2c/busses/i2c-mv64xxx.c | 270 +++++++++++++++++++++----------
 1 file changed, 185 insertions(+), 85 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mv64xxx.c b/drivers/i2c/busses/i2c-mv64xxx.c
index bb048e655be7..3ae74160001d 100644
--- a/drivers/i2c/busses/i2c-mv64xxx.c
+++ b/drivers/i2c/busses/i2c-mv64xxx.c
@@ -4,10 +4,12 @@
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * 2005 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2005 (c) MontaVista, Software, Inc.
+ * Copyright (c) 2024 Turing Machines, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License v2.
+ * This program is licensed "as is" without any warranty of any kind, whether
+ * express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
@@ -86,12 +88,24 @@
 enum mv64xxx_i2c_state {
        MV64XXX_I2C_STATE_INVALID,
        MV64XXX_I2C_STATE_IDLE,
-       MV64XXX_I2C_STATE_WAITING_FOR_START_COND,
-       MV64XXX_I2C_STATE_WAITING_FOR_RESTART,
-       MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK,
-       MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK,
-       MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK,
-       MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA,
+       MV64XXX_I2C_STATE_START,
+       MV64XXX_I2C_STATE_RESTART,
+       MV64XXX_I2C_STATE_SEND_ADDR_1,
+       MV64XXX_I2C_STATE_SEND_ADDR_2,
+       MV64XXX_I2C_STATE_WRITE,
+       MV64XXX_I2C_STATE_READ,
+};
+
+/* Driver events */
+enum mv64xxx_i2c_event {
+       MV64XXX_I2C_EVENT_INVALID,
+       MV64XXX_I2C_EVENT_STARTED,
+       MV64XXX_I2C_EVENT_ADDR_ACK,
+       MV64XXX_I2C_EVENT_ADDR_NO_ACK,
+       MV64XXX_I2C_EVENT_WR_ACK,
+       MV64XXX_I2C_EVENT_WR_NO_ACK,
+       MV64XXX_I2C_EVENT_RD_ACKED,
+       MV64XXX_I2C_EVENT_RD_UNACKED,
 };

 /* Driver actions */
@@ -232,9 +246,73 @@ mv64xxx_i2c_hw_init(struct mv64xxx_i2c_data *drv_data)
        drv_data->state = MV64XXX_I2C_STATE_IDLE;
 }

+static enum mv64xxx_i2c_event
+mv64xxx_i2c_decode_status(struct mv64xxx_i2c_data *drv_data, u32 status)
+{
+       /* Decode status to event (state-driven; catches unexpected status) */
+       switch (drv_data->state) {
+       case MV64XXX_I2C_STATE_RESTART:
+       case MV64XXX_I2C_STATE_START:
+               if (status == MV64XXX_I2C_STATUS_MAST_START ||
+                   status == MV64XXX_I2C_STATUS_MAST_REPEAT_START)
+                       return MV64XXX_I2C_EVENT_STARTED;
+               return MV64XXX_I2C_EVENT_INVALID;
+
+       case MV64XXX_I2C_STATE_SEND_ADDR_1:
+               if (drv_data->msg->flags & I2C_M_RD) {
+                       if (status == MV64XXX_I2C_STATUS_MAST_RD_ADDR_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_ACK;
+                       else if (status ==
MV64XXX_I2C_STATUS_MAST_RD_ADDR_NO_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_NO_ACK;
+               } else {
+                       if (status == MV64XXX_I2C_STATUS_MAST_WR_ADDR_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_ACK;
+                       else if (status ==
MV64XXX_I2C_STATUS_MAST_WR_ADDR_NO_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_NO_ACK;
+               }
+               return MV64XXX_I2C_EVENT_INVALID;
+
+       case MV64XXX_I2C_STATE_SEND_ADDR_2:
+               if (drv_data->msg->flags & I2C_M_RD) {
+                       if (status == MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_ACK;
+                       else if (status ==
MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_NO_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_NO_ACK;
+               } else {
+                       if (status == MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_ACK;
+                       else if (status ==
MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_NO_ACK)
+                               return MV64XXX_I2C_EVENT_ADDR_NO_ACK;
+               }
+               return MV64XXX_I2C_EVENT_INVALID;
+
+       case MV64XXX_I2C_STATE_WRITE:
+               if (status == MV64XXX_I2C_STATUS_MAST_WR_ACK)
+                       return MV64XXX_I2C_EVENT_WR_ACK;
+               else if (status == MV64XXX_I2C_STATUS_MAST_WR_NO_ACK)
+                       return MV64XXX_I2C_EVENT_ADDR_NO_ACK;
+               return MV64XXX_I2C_EVENT_INVALID;
+
+       case MV64XXX_I2C_STATE_READ:
+               if (status == MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK)
+                       return MV64XXX_I2C_EVENT_RD_ACKED;
+               else if (status == MV64XXX_I2C_STATUS_MAST_RD_DATA_NO_ACK)
+                       return MV64XXX_I2C_EVENT_RD_UNACKED;
+               return MV64XXX_I2C_EVENT_INVALID;
+
+       default:
+               return MV64XXX_I2C_EVENT_INVALID;
+       }
+}
+
 static void
 mv64xxx_i2c_fsm(struct mv64xxx_i2c_data *drv_data, u32 status)
 {
+       enum mv64xxx_i2c_event event;
+       enum mv64xxx_i2c_state prev_state = drv_data->state;
+
+       drv_data->action = MV64XXX_I2C_ACTION_INVALID;
+
        /*
         * If state is idle, then this is likely the remnants of an old
         * operation that driver has given up on or the user has killed.
@@ -245,99 +323,121 @@ mv64xxx_i2c_fsm(struct mv64xxx_i2c_data
*drv_data, u32 status)
                return;
        }

-       /* The status from the ctlr [mostly] tells us what to do next */
-       switch (status) {
-       /* Start condition interrupt */
-       case MV64XXX_I2C_STATUS_MAST_START: /* 0x08 */
-       case MV64XXX_I2C_STATUS_MAST_REPEAT_START: /* 0x10 */
-               drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_1;
-               drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_ADDR_1_ACK;
+       /*
+        * The FSM is broken into 3 parts:
+        * 1) Decode `status` to determine the underlying hardware event
+        * 2) Handle hardware event driven state transitions
+        * 3) Perform internal state transitions and action emission
+        */
+       event = mv64xxx_i2c_decode_status(drv_data, status);
+
+       /* Handle event; determine state transition */
+       switch (event) {
+       case MV64XXX_I2C_EVENT_STARTED:
+               drv_data->state = MV64XXX_I2C_STATE_SEND_ADDR_1;
                break;

-       /* Performing a write */
-       case MV64XXX_I2C_STATUS_MAST_WR_ADDR_ACK: /* 0x18 */
-               if (drv_data->msg->flags & I2C_M_TEN) {
-                       drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_2;
-                       drv_data->state =
-                               MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK;
-                       break;
-               }
-               fallthrough;
-       case MV64XXX_I2C_STATUS_MAST_WR_ADDR_2_ACK: /* 0xd0 */
-       case MV64XXX_I2C_STATUS_MAST_WR_ACK: /* 0x28 */
-               if ((drv_data->bytes_left == 0)
-                               || (drv_data->aborting
-                                       && (drv_data->byte_posn != 0))) {
-                       if (drv_data->send_stop || drv_data->aborting) {
-                               drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
-                               drv_data->state = MV64XXX_I2C_STATE_IDLE;
-                       } else {
-                               drv_data->action =
-                                       MV64XXX_I2C_ACTION_SEND_RESTART;
-                               drv_data->state =
-                                       MV64XXX_I2C_STATE_WAITING_FOR_RESTART;
-                       }
-               } else {
-                       drv_data->action = MV64XXX_I2C_ACTION_SEND_DATA;
-                       drv_data->state =
-                               MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_ACK;
-                       drv_data->bytes_left--;
-               }
+       case MV64XXX_I2C_EVENT_ADDR_ACK:
+               if ((drv_data->state == MV64XXX_I2C_STATE_SEND_ADDR_1)
+                   && (drv_data->msg->flags & I2C_M_TEN))
+                       drv_data->state = MV64XXX_I2C_STATE_SEND_ADDR_2;
+               else if (drv_data->msg->flags & I2C_M_RD)
+                       drv_data->state = MV64XXX_I2C_STATE_READ;
+               else
+                       drv_data->state = MV64XXX_I2C_STATE_WRITE;
                break;

-       /* Performing a read */
-       case MV64XXX_I2C_STATUS_MAST_RD_ADDR_ACK: /* 40 */
-               if (drv_data->msg->flags & I2C_M_TEN) {
-                       drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_2;
-                       drv_data->state =
-                               MV64XXX_I2C_STATE_WAITING_FOR_ADDR_2_ACK;
-                       break;
-               }
-               fallthrough;
-       case MV64XXX_I2C_STATUS_MAST_RD_ADDR_2_ACK: /* 0xe0 */
-               if (drv_data->bytes_left == 0) {
-                       drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
-                       drv_data->state = MV64XXX_I2C_STATE_IDLE;
-                       break;
-               }
-               fallthrough;
-       case MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK: /* 0x50 */
-               if (status != MV64XXX_I2C_STATUS_MAST_RD_DATA_ACK)
-                       drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
-               else {
-                       drv_data->action = MV64XXX_I2C_ACTION_RCV_DATA;
-                       drv_data->bytes_left--;
-               }
-               drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_SLAVE_DATA;
+       case MV64XXX_I2C_EVENT_ADDR_NO_ACK:
+       case MV64XXX_I2C_EVENT_WR_NO_ACK:
+               /* Doesn't seem to be a device at other end */
+               drv_data->state = MV64XXX_I2C_STATE_IDLE;
+               break;

-               if ((drv_data->bytes_left == 1) || drv_data->aborting)
-                       drv_data->cntl_bits &= ~MV64XXX_I2C_REG_CONTROL_ACK;
+       case MV64XXX_I2C_EVENT_WR_ACK:
                break;

-       case MV64XXX_I2C_STATUS_MAST_RD_DATA_NO_ACK: /* 0x58 */
-               drv_data->action = MV64XXX_I2C_ACTION_RCV_DATA_STOP;
-               drv_data->state = MV64XXX_I2C_STATE_IDLE;
+       case MV64XXX_I2C_EVENT_RD_ACKED:
+               BUG_ON(drv_data->bytes_left == 0);
                break;

-       case MV64XXX_I2C_STATUS_MAST_WR_ADDR_NO_ACK: /* 0x20 */
-       case MV64XXX_I2C_STATUS_MAST_WR_NO_ACK: /* 30 */
-       case MV64XXX_I2C_STATUS_MAST_RD_ADDR_NO_ACK: /* 48 */
-               /* Doesn't seem to be a device at other end */
-               drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
-               drv_data->state = MV64XXX_I2C_STATE_IDLE;
-               drv_data->rc = -ENXIO;
+       case MV64XXX_I2C_EVENT_RD_UNACKED:
+               BUG_ON(drv_data->bytes_left != 0);
                break;

+       case MV64XXX_I2C_EVENT_INVALID:
        default:
                dev_err(&drv_data->adapter.dev,
                        "mv64xxx_i2c_fsm: Ctlr Error -- state: 0x%x, "
-                       "status: 0x%x, addr: 0x%x, flags: 0x%x\n",
-                        drv_data->state, status, drv_data->msg->addr,
+                       "status: 0x%x, event: 0x%x, addr: 0x%x, flags: 0x%x\n",
+                        drv_data->state, status, event, drv_data->msg->addr,
                         drv_data->msg->flags);
                drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
                mv64xxx_i2c_hw_init(drv_data);
                i2c_recover_bus(&drv_data->adapter);
                drv_data->rc = -EAGAIN;
+               return;
+       }
+
+       /* Internal FSM transitions and action emission */
+       switch (drv_data->state) {
+       case MV64XXX_I2C_STATE_IDLE:
+               drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+               drv_data->rc = -ENXIO;
+               break;
+
+       case MV64XXX_I2C_STATE_SEND_ADDR_1:
+               drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_1;
+               break;
+
+       case MV64XXX_I2C_STATE_SEND_ADDR_2:
+               drv_data->action = MV64XXX_I2C_ACTION_SEND_ADDR_2;
+               break;
+
+       case MV64XXX_I2C_STATE_READ:
+               if (drv_data->bytes_left == 0) {
+                       if (prev_state == MV64XXX_I2C_STATE_READ)
+                               drv_data->action =
MV64XXX_I2C_ACTION_RCV_DATA_STOP;
+                       else
+                               drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+                       drv_data->state = MV64XXX_I2C_STATE_IDLE;
+               } else {
+                       if (prev_state == MV64XXX_I2C_STATE_READ)
+                               drv_data->action = MV64XXX_I2C_ACTION_RCV_DATA;
+                       else
+                               drv_data->action = MV64XXX_I2C_ACTION_CONTINUE;
+
+                       /*
+                        * bytes_left counts the remaining read actions to send
+                        * to the hardware, not the remaining bytes to be
+                        * retrieved from the data register
+                        */
+                       if (drv_data->aborting)
+                               drv_data->bytes_left = 0;
+                       else
+                               drv_data->bytes_left--;
+
+                       if (drv_data->bytes_left == 0)
+                               drv_data->cntl_bits &=
~MV64XXX_I2C_REG_CONTROL_ACK;
+               }
+               break;
+
+       case MV64XXX_I2C_STATE_WRITE:
+               if ((drv_data->bytes_left == 0)
+                   || (drv_data->aborting && (drv_data->byte_posn != 0))) {
+                       if (drv_data->send_stop || drv_data->aborting) {
+                               drv_data->action = MV64XXX_I2C_ACTION_SEND_STOP;
+                               drv_data->state = MV64XXX_I2C_STATE_IDLE;
+                       } else {
+                               drv_data->action =
MV64XXX_I2C_ACTION_SEND_RESTART;
+                               drv_data->state = MV64XXX_I2C_STATE_RESTART;
+                       }
+               } else {
+                       drv_data->action = MV64XXX_I2C_ACTION_SEND_DATA;
+                       drv_data->bytes_left--;
+               }
+               break;
+
+       default:
        }
 }

@@ -611,7 +711,7 @@ mv64xxx_i2c_execute_msg(struct mv64xxx_i2c_data
*drv_data, struct i2c_msg *msg,

        spin_lock_irqsave(&drv_data->lock, flags);

-       drv_data->state = MV64XXX_I2C_STATE_WAITING_FOR_START_COND;
+       drv_data->state = MV64XXX_I2C_STATE_START;

        drv_data->send_stop = is_last;
        drv_data->block = 1;
--
2.43.2

