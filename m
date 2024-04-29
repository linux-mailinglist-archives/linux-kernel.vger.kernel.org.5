Return-Path: <linux-kernel+bounces-161940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CA38B539F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A601B1F21CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CA3199C7;
	Mon, 29 Apr 2024 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGynr5sy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CDC17730;
	Mon, 29 Apr 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381252; cv=none; b=BUSyRelzgoviazhuHdz5V9EIrQLgcaVuZ1PYbaDADnwi/pywUXVCKmDB6R26KwHbCFjaPY3nQVG3FC6CHSdY6MScb7PtotZbN7YEW9p/nGVqYiEC69Tx/y8GkPXK6tYFliUayol/O1yhY+guPVytAJlcfdplMqjqlyeroAHzBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381252; c=relaxed/simple;
	bh=WTbF45LMBGUB6jvhWCWRT2RiVJKkLIAYg4Ug8t7zrjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KG4dW/tNVI/7UWi40Qeq2Eb1dyBHyQ+vGl4/0f2H7B5Ornwa9T5W+kfH84iQSaqTFchmvDetz0m0DOSnoR7KDZv414y3wDA3aSHvKYsfiEPmZH9m16a7JbhZFQiCf7Kpl8Vo8wsSHciFiihTfHcad6n3gdZ1HaH1Dw6d7DzrvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGynr5sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B5EC4AF17;
	Mon, 29 Apr 2024 09:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381252;
	bh=WTbF45LMBGUB6jvhWCWRT2RiVJKkLIAYg4Ug8t7zrjI=;
	h=From:To:Cc:Subject:Date:From;
	b=TGynr5syjOpEBwkGYECenjwLbB+/DG0Pm88lI0MOe+0VZuW+IbGELgAFw3LrsdYcl
	 oq0jcnArYwTH3vgwKeCfK4DZGuCahiJXrUY4Wa/iyjfRq5HV8ItVUFAFSBmAFaUYJa
	 EEIC5lxat6cbi2/0YD7XQVuuiGk+tpbu87W0t0dHFOGIaPa8eQR8yO4J6iChcD5B5m
	 SkrC0pRkBgLydfOqEhIMaIbx0Zsiyaaenid8Jg1iNNjFbNSwSb+5m5vqODI+YFn+sS
	 r0YKLLGO5UPdSW24uicJtlzbUpdJrZomGFezXi4Neva4BWCAZjmKoYQb9MV7zMqhxM
	 iCDrrK40nMAXg==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1s1MsR-0000000825b-3aQf;
	Mon, 29 Apr 2024 10:00:47 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Michael Bunk <micha@freedict.org>,
	Wei Chen <harperchen1110@gmail.com>,
	Yu Zhe <yuzhe@nfschina.com>,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH] media: dw2102: fix coding style issues
Date: Mon, 29 Apr 2024 10:00:41 +0100
Message-ID: <4a7d735191dec9ccaf95f26f63cb6b46fb8cd260.1714381239.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use checkpatch --strict --in-place to cleanup most style issues.
Then, do some manual work to fix most of the remaining issues.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/usb/dvb-usb/dw2102.c | 273 ++++++++++++++---------------
 1 file changed, 132 insertions(+), 141 deletions(-)

diff --git a/drivers/media/usb/dvb-usb/dw2102.c b/drivers/media/usb/dvb-usb/dw2102.c
index 8077d5584b6b..03b411ad64bb 100644
--- a/drivers/media/usb/dvb-usb/dw2102.c
+++ b/drivers/media/usb/dvb-usb/dw2102.c
@@ -36,7 +36,6 @@
 /* Max transfer size done by I2C transfer functions */
 #define MAX_XFER_SIZE  64
 
-
 #define DW210X_READ_MSG 0
 #define DW210X_WRITE_MSG 1
 
@@ -99,11 +98,10 @@ static int dw210x_op_rw(struct usb_device *dev, u8 request, u16 value,
 	if (!u8buf)
 		return -ENOMEM;
 
-
 	if (flags == DW210X_WRITE_MSG)
 		memcpy(u8buf, data, len);
 	ret = usb_control_msg(dev, pipe, request, request_type | USB_TYPE_VENDOR,
-				value, index, u8buf, len, 2000);
+			      value, index, u8buf, len, 2000);
 
 	if (flags == DW210X_READ_MSG)
 		memcpy(data, u8buf, len);
@@ -114,7 +112,7 @@ static int dw210x_op_rw(struct usb_device *dev, u8 request, u16 value,
 
 /* I2C */
 static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
-		int num)
+			       int num)
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	int i = 0;
@@ -136,7 +134,7 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		value = msg[0].buf[0];/* register */
 		for (i = 0; i < msg[1].len; i++) {
 			dw210x_op_rw(d->udev, 0xb5, value + i, 0,
-					buf6, 2, DW210X_READ_MSG);
+				     buf6, 2, DW210X_READ_MSG);
 			msg[1].buf[i] = buf6[0];
 		}
 		break;
@@ -152,7 +150,7 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			buf6[1] = msg[0].buf[0];
 			buf6[2] = msg[0].buf[1];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
-					buf6, 3, DW210X_WRITE_MSG);
+				     buf6, 3, DW210X_WRITE_MSG);
 			break;
 		case 0x60:
 			if (msg[0].flags == 0) {
@@ -169,7 +167,7 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				buf6[5] = msg[0].buf[2];
 				buf6[6] = msg[0].buf[3];
 				dw210x_op_rw(d->udev, 0xb2, 0, 0,
-						buf6, 7, DW210X_WRITE_MSG);
+					     buf6, 7, DW210X_WRITE_MSG);
 			} else {
 				if (msg[0].len < 1) {
 					num = -EOPNOTSUPP;
@@ -177,7 +175,7 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				}
 			/* read from tuner */
 				dw210x_op_rw(d->udev, 0xb5, 0, 0,
-						buf6, 1, DW210X_READ_MSG);
+					     buf6, 1, DW210X_READ_MSG);
 				msg[0].buf[0] = buf6[0];
 			}
 			break;
@@ -187,7 +185,7 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				break;
 			}
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
-					buf6, 2, DW210X_READ_MSG);
+				     buf6, 2, DW210X_READ_MSG);
 			msg[0].buf[0] = buf6[0];
 			msg[0].buf[1] = buf6[1];
 			break;
@@ -199,7 +197,7 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			buf6[0] = 0x30;
 			buf6[1] = msg[0].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
-					buf6, 2, DW210X_WRITE_MSG);
+				     buf6, 2, DW210X_WRITE_MSG);
 			break;
 		}
 
@@ -211,7 +209,7 @@ static int dw2102_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 }
 
 static int dw2102_serit_i2c_transfer(struct i2c_adapter *adap,
-						struct i2c_msg msg[], int num)
+				     struct i2c_msg msg[], int num)
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	u8 buf6[] = {0, 0, 0, 0, 0, 0, 0};
@@ -242,10 +240,10 @@ static int dw2102_serit_i2c_transfer(struct i2c_adapter *adap,
 		buf6[1] = msg[0].len;
 		buf6[2] = msg[0].buf[0];
 		dw210x_op_rw(d->udev, 0xc2, 0, 0,
-				buf6, msg[0].len + 2, DW210X_WRITE_MSG);
+			     buf6, msg[0].len + 2, DW210X_WRITE_MSG);
 		/* read si2109 register */
 		dw210x_op_rw(d->udev, 0xc3, 0xd0, 0,
-				buf6, msg[1].len + 2, DW210X_READ_MSG);
+			     buf6, msg[1].len + 2, DW210X_READ_MSG);
 		memcpy(msg[1].buf, buf6 + 2, msg[1].len);
 
 		break;
@@ -264,11 +262,11 @@ static int dw2102_serit_i2c_transfer(struct i2c_adapter *adap,
 			buf6[1] = msg[0].len;
 			memcpy(buf6 + 2, msg[0].buf, msg[0].len);
 			dw210x_op_rw(d->udev, 0xc2, 0, 0, buf6,
-					msg[0].len + 2, DW210X_WRITE_MSG);
+				     msg[0].len + 2, DW210X_WRITE_MSG);
 			break;
 		case(DW2102_RC_QUERY):
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
-					buf6, 2, DW210X_READ_MSG);
+				     buf6, 2, DW210X_READ_MSG);
 			msg[0].buf[0] = buf6[0];
 			msg[0].buf[1] = buf6[1];
 			break;
@@ -276,7 +274,7 @@ static int dw2102_serit_i2c_transfer(struct i2c_adapter *adap,
 			buf6[0] = 0x30;
 			buf6[1] = msg[0].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
-					buf6, 2, DW210X_WRITE_MSG);
+				     buf6, 2, DW210X_WRITE_MSG);
 			break;
 		}
 		break;
@@ -320,10 +318,10 @@ static int dw2102_earda_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg ms
 		obuf[1] = msg[0].len;
 		obuf[2] = msg[0].buf[0];
 		dw210x_op_rw(d->udev, 0xc2, 0, 0,
-				obuf, msg[0].len + 2, DW210X_WRITE_MSG);
+			     obuf, msg[0].len + 2, DW210X_WRITE_MSG);
 		/* second read registers */
 		dw210x_op_rw(d->udev, 0xc3, 0xd1, 0,
-				ibuf, msg[1].len + 2, DW210X_READ_MSG);
+			     ibuf, msg[1].len + 2, DW210X_READ_MSG);
 		memcpy(msg[1].buf, ibuf + 2, msg[1].len);
 
 		break;
@@ -345,7 +343,7 @@ static int dw2102_earda_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg ms
 			obuf[1] = msg[0].len;
 			memcpy(obuf + 2, msg[0].buf, msg[0].len);
 			dw210x_op_rw(d->udev, 0xc2, 0, 0,
-					obuf, msg[0].len + 2, DW210X_WRITE_MSG);
+				     obuf, msg[0].len + 2, DW210X_WRITE_MSG);
 			break;
 		}
 		case 0x61: {
@@ -363,14 +361,14 @@ static int dw2102_earda_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg ms
 			obuf[1] = msg[0].len;
 			memcpy(obuf + 2, msg[0].buf, msg[0].len);
 			dw210x_op_rw(d->udev, 0xc2, 0, 0,
-					obuf, msg[0].len + 2, DW210X_WRITE_MSG);
+				     obuf, msg[0].len + 2, DW210X_WRITE_MSG);
 			break;
 		}
 		case(DW2102_RC_QUERY): {
 			u8 ibuf[2];
 
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
-					ibuf, 2, DW210X_READ_MSG);
+				     ibuf, 2, DW210X_READ_MSG);
 			memcpy(msg[0].buf, ibuf, 2);
 			break;
 		}
@@ -380,7 +378,7 @@ static int dw2102_earda_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg ms
 			obuf[0] = 0x30;
 			obuf[1] = msg[0].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
-					obuf, 2, DW210X_WRITE_MSG);
+				     obuf, 2, DW210X_WRITE_MSG);
 			break;
 		}
 		}
@@ -410,7 +408,7 @@ static int dw2104_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[], i
 			u8 ibuf[2];
 
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
-					ibuf, 2, DW210X_READ_MSG);
+				     ibuf, 2, DW210X_READ_MSG);
 			memcpy(msg[j].buf, ibuf, 2);
 			break;
 		}
@@ -420,7 +418,7 @@ static int dw2104_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[], i
 			obuf[0] = 0x30;
 			obuf[1] = msg[j].buf[0];
 			dw210x_op_rw(d->udev, 0xb2, 0, 0,
-					obuf, 2, DW210X_WRITE_MSG);
+				     obuf, 2, DW210X_WRITE_MSG);
 			break;
 		}
 		/* case 0x55: cx24116
@@ -441,15 +439,13 @@ static int dw2104_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[], i
 				}
 
 				dw210x_op_rw(d->udev, 0xc3,
-						(msg[j].addr << 1) + 1, 0,
-						ibuf, msg[j].len + 2,
-						DW210X_READ_MSG);
+					     (msg[j].addr << 1) + 1, 0,
+					     ibuf, msg[j].len + 2,
+					     DW210X_READ_MSG);
 				memcpy(msg[j].buf, ibuf + 2, msg[j].len);
 				mdelay(10);
-			} else if (((msg[j].buf[0] == 0xb0) &&
-						(msg[j].addr == 0x68)) ||
-						((msg[j].buf[0] == 0xf7) &&
-						(msg[j].addr == 0x55))) {
+			} else if (((msg[j].buf[0] == 0xb0) && (msg[j].addr == 0x68)) ||
+				   ((msg[j].buf[0] == 0xf7) && (msg[j].addr == 0x55))) {
 				/* write firmware */
 				u8 obuf[19];
 
@@ -460,10 +456,10 @@ static int dw2104_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[], i
 				i = 1;
 				do {
 					memcpy(obuf + 3, msg[j].buf + i,
-							(len > 16 ? 16 : len));
+					       (len > 16 ? 16 : len));
 					dw210x_op_rw(d->udev, 0xc2, 0, 0,
-						obuf, (len > 16 ? 16 : len) + 3,
-						DW210X_WRITE_MSG);
+						     obuf, (len > 16 ? 16 : len) + 3,
+						     DW210X_WRITE_MSG);
 					i += 16;
 					len -= 16;
 				} while (len > 0);
@@ -482,13 +478,12 @@ static int dw2104_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[], i
 				obuf[1] = msg[j].len;
 				memcpy(obuf + 2, msg[j].buf, msg[j].len);
 				dw210x_op_rw(d->udev, 0xc2, 0, 0,
-						obuf, msg[j].len + 2,
-						DW210X_WRITE_MSG);
+					     obuf, msg[j].len + 2,
+					     DW210X_WRITE_MSG);
 			}
 			break;
 		}
 		}
-
 	}
 	ret = num;
 
@@ -498,7 +493,7 @@ static int dw2104_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[], i
 }
 
 static int dw3101_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
-								int num)
+			       int num)
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	int ret;
@@ -531,10 +526,10 @@ static int dw3101_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		obuf[1] = msg[0].len;
 		obuf[2] = msg[0].buf[0];
 		dw210x_op_rw(d->udev, 0xc2, 0, 0,
-				obuf, msg[0].len + 2, DW210X_WRITE_MSG);
+			     obuf, msg[0].len + 2, DW210X_WRITE_MSG);
 		/* second read registers */
 		dw210x_op_rw(d->udev, 0xc3, 0x19, 0,
-				ibuf, msg[1].len + 2, DW210X_READ_MSG);
+			     ibuf, msg[1].len + 2, DW210X_READ_MSG);
 		memcpy(msg[1].buf, ibuf + 2, msg[1].len);
 
 		break;
@@ -556,14 +551,14 @@ static int dw3101_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			obuf[1] = msg[0].len;
 			memcpy(obuf + 2, msg[0].buf, msg[0].len);
 			dw210x_op_rw(d->udev, 0xc2, 0, 0,
-					obuf, msg[0].len + 2, DW210X_WRITE_MSG);
+				     obuf, msg[0].len + 2, DW210X_WRITE_MSG);
 			break;
 		}
 		case(DW2102_RC_QUERY): {
 			u8 ibuf[2];
 
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
-					ibuf, 2, DW210X_READ_MSG);
+				     ibuf, 2, DW210X_READ_MSG);
 			memcpy(msg[0].buf, ibuf, 2);
 			break;
 		}
@@ -574,7 +569,7 @@ static int dw3101_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 
 	for (i = 0; i < num; i++) {
 		deb_xfer("%02x:%02x: %s ", i, msg[i].addr,
-				msg[i].flags == 0 ? ">>>" : "<<<");
+			 msg[i].flags == 0 ? ">>>" : "<<<");
 		debug_dump(msg[i].buf, msg[i].len, deb_xfer);
 	}
 	ret = num;
@@ -585,7 +580,7 @@ static int dw3101_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 }
 
 static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
-								int num)
+			     int num)
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	struct usb_device *udev;
@@ -603,7 +598,7 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			u8 ibuf[5];
 
 			dw210x_op_rw(d->udev, 0xb8, 0, 0,
-					ibuf, 5, DW210X_READ_MSG);
+				     ibuf, 5, DW210X_READ_MSG);
 			memcpy(msg[j].buf, ibuf + 3, 2);
 			break;
 		}
@@ -613,11 +608,11 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			obuf[0] = 1;
 			obuf[1] = msg[j].buf[1];/* off-on */
 			dw210x_op_rw(d->udev, 0x8a, 0, 0,
-					obuf, 2, DW210X_WRITE_MSG);
+				     obuf, 2, DW210X_WRITE_MSG);
 			obuf[0] = 3;
 			obuf[1] = msg[j].buf[0];/* 13v-18v */
 			dw210x_op_rw(d->udev, 0x8a, 0, 0,
-					obuf, 2, DW210X_WRITE_MSG);
+				     obuf, 2, DW210X_WRITE_MSG);
 			break;
 		}
 		case (DW2102_LED_CTRL): {
@@ -626,7 +621,7 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			obuf[0] = 5;
 			obuf[1] = msg[j].buf[0];
 			dw210x_op_rw(d->udev, 0x8a, 0, 0,
-					obuf, 2, DW210X_WRITE_MSG);
+				     obuf, 2, DW210X_WRITE_MSG);
 			break;
 		}
 		/* case 0x55: cx24116
@@ -648,12 +643,11 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				}
 
 				dw210x_op_rw(d->udev, 0x91, 0, 0,
-						ibuf, msg[j].len,
+					     ibuf, msg[j].len,
 						DW210X_READ_MSG);
 				memcpy(msg[j].buf, ibuf, msg[j].len);
 				break;
-			} else if ((msg[j].buf[0] == 0xb0) &&
-						(msg[j].addr == 0x68)) {
+			} else if ((msg[j].buf[0] == 0xb0) && (msg[j].addr == 0x68)) {
 				/* write firmware */
 				u8 obuf[19];
 
@@ -665,10 +659,10 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				i = 1;
 				do {
 					memcpy(obuf + 3, msg[j].buf + i,
-							(len > 16 ? 16 : len));
+					       (len > 16 ? 16 : len));
 					dw210x_op_rw(d->udev, 0x80, 0, 0,
-						obuf, (len > 16 ? 16 : len) + 3,
-						DW210X_WRITE_MSG);
+						     obuf, (len > 16 ? 16 : len) + 3,
+						     DW210X_WRITE_MSG);
 					i += 16;
 					len -= 16;
 				} while (len > 0);
@@ -687,10 +681,9 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				obuf[1] = (msg[j].addr << 1);
 				memcpy(obuf + 2, msg[j].buf, msg[j].len);
 				dw210x_op_rw(d->udev,
-						le16_to_cpu(udev->descriptor.idProduct) ==
-						0x7500 ? 0x92 : 0x90, 0, 0,
-						obuf, msg[j].len + 2,
-						DW210X_WRITE_MSG);
+					     le16_to_cpu(udev->descriptor.idProduct) == 0x7500 ? 0x92 : 0x90,
+					     0, 0, obuf, msg[j].len + 2,
+					     DW210X_WRITE_MSG);
 				break;
 			} else {
 				/* write registers */
@@ -706,8 +699,8 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				obuf[1] = (msg[j].addr << 1);
 				memcpy(obuf + 2, msg[j].buf, msg[j].len);
 				dw210x_op_rw(d->udev, 0x80, 0, 0,
-						obuf, msg[j].len + 2,
-						DW210X_WRITE_MSG);
+					     obuf, msg[j].len + 2,
+					     DW210X_WRITE_MSG);
 				break;
 			}
 			break;
@@ -722,7 +715,7 @@ static int s6x0_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 }
 
 static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
-								int num)
+			       int num)
 {
 	struct dvb_usb_device *d = i2c_get_adapdata(adap);
 	struct dw2102_state *state;
@@ -748,13 +741,13 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			state->data[1] = 3;
 			state->data[2] = 0;
 			if (dvb_usb_generic_rw(d, state->data, 3,
-					state->data, 0, 0) < 0)
+					       state->data, 0, 0) < 0)
 				err("i2c transfer failed.");
 			break;
 		case DW2102_RC_QUERY:
 			state->data[0] = 0x10;
 			if (dvb_usb_generic_rw(d, state->data, 1,
-					state->data, 2, 0) < 0)
+					       state->data, 2, 0) < 0)
 				err("i2c transfer failed.");
 			msg[j].buf[1] = state->data[0];
 			msg[j].buf[0] = state->data[1];
@@ -763,33 +756,33 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			/* if the current write msg is followed by a another
 			 * read msg to/from the same address
 			 */
-			if ((j+1 < num) && (msg[j+1].flags & I2C_M_RD) &&
-			    (msg[j].addr == msg[j+1].addr)) {
+			if ((j + 1 < num) && (msg[j + 1].flags & I2C_M_RD) &&
+			    (msg[j].addr == msg[j + 1].addr)) {
 				/* join both i2c msgs to one usb read command */
 				if (4 + msg[j].len > sizeof(state->data)) {
 					warn("i2c combined wr/rd: write len=%d is too big!\n",
-					    msg[j].len);
+					     msg[j].len);
 					num = -EOPNOTSUPP;
 					break;
 				}
-				if (1 + msg[j+1].len > sizeof(state->data)) {
+				if (1 + msg[j + 1].len > sizeof(state->data)) {
 					warn("i2c combined wr/rd: read len=%d is too big!\n",
-					    msg[j+1].len);
+					    msg[j + 1].len);
 					num = -EOPNOTSUPP;
 					break;
 				}
 
 				state->data[0] = 0x09;
 				state->data[1] = msg[j].len;
-				state->data[2] = msg[j+1].len;
+				state->data[2] = msg[j + 1].len;
 				state->data[3] = msg[j].addr;
 				memcpy(&state->data[4], msg[j].buf, msg[j].len);
 
 				if (dvb_usb_generic_rw(d, state->data, msg[j].len + 4,
-					state->data, msg[j+1].len + 1, 0) < 0)
+					state->data, msg[j + 1].len + 1, 0) < 0)
 					err("i2c transfer failed.");
 
-				memcpy(msg[j+1].buf, &state->data[1], msg[j+1].len);
+				memcpy(msg[j + 1].buf, &state->data[1], msg[j + 1].len);
 				j++;
 				break;
 			}
@@ -809,7 +802,7 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 				memcpy(&state->data[4], msg[j].buf, msg[j].len);
 
 				if (dvb_usb_generic_rw(d, state->data, 4,
-					state->data, msg[j].len + 1, 0) < 0)
+						       state->data, msg[j].len + 1, 0) < 0)
 					err("i2c transfer failed.");
 
 				memcpy(msg[j].buf, &state->data[1], msg[j].len);
@@ -830,7 +823,7 @@ static int su3000_i2c_transfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			memcpy(&state->data[3], msg[j].buf, msg[j].len);
 
 			if (dvb_usb_generic_rw(d, state->data, msg[j].len + 3,
-						state->data, 1, 0) < 0)
+					       state->data, 1, 0) < 0)
 				err("i2c transfer failed.");
 		} // switch
 		j++;
@@ -888,11 +881,11 @@ static int dw210x_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 	u8 eeprom[256], eepromline[16];
 
 	for (i = 0; i < 256; i++) {
-		if (dw210x_op_rw(d->udev, 0xb6, 0xa0 , i, ibuf, 2, DW210X_READ_MSG) < 0) {
+		if (dw210x_op_rw(d->udev, 0xb6, 0xa0, i, ibuf, 2, DW210X_READ_MSG) < 0) {
 			err("read eeprom failed.");
 			return -EIO;
 		} else {
-			eepromline[i%16] = ibuf[0];
+			eepromline[i % 16] = ibuf[0];
 			eeprom[i] = ibuf[0];
 		}
 		if ((i % 16) == 15) {
@@ -999,7 +992,6 @@ static int su3000_read_mac_address(struct dvb_usb_device *d, u8 mac[6])
 			.flags = I2C_M_RD,
 			.buf = ibuf,
 			.len = 1,
-
 		}
 	};
 
@@ -1037,6 +1029,7 @@ static int dw210x_set_voltage(struct dvb_frontend *fe,
 	};
 
 	struct dvb_usb_adapter *udev_adap = fe->dvb->priv;
+
 	if (voltage == SEC_VOLTAGE_18)
 		msg.buf = command_18v;
 	else if (voltage == SEC_VOLTAGE_13)
@@ -1240,11 +1233,11 @@ static int dw2104_frontend_attach(struct dvb_usb_adapter *d)
 
 	if (demod_probe & 4) {
 		d->fe_adap[0].fe = dvb_attach(stv0900_attach, &dw2104a_stv0900_config,
-				&d->dev->i2c_adap, 0);
-		if (d->fe_adap[0].fe != NULL) {
+					      &d->dev->i2c_adap, 0);
+		if (d->fe_adap[0].fe) {
 			if (dvb_attach(stb6100_attach, d->fe_adap[0].fe,
-					&dw2104a_stb6100_config,
-					&d->dev->i2c_adap)) {
+				       &dw2104a_stb6100_config,
+				       &d->dev->i2c_adap)) {
 				tuner_ops = &d->fe_adap[0].fe->ops.tuner_ops;
 				tuner_ops->set_frequency = stb6100_set_freq;
 				tuner_ops->get_frequency = stb6100_get_freq;
@@ -1259,11 +1252,11 @@ static int dw2104_frontend_attach(struct dvb_usb_adapter *d)
 
 	if (demod_probe & 2) {
 		d->fe_adap[0].fe = dvb_attach(stv0900_attach, &dw2104_stv0900_config,
-				&d->dev->i2c_adap, 0);
-		if (d->fe_adap[0].fe != NULL) {
+					      &d->dev->i2c_adap, 0);
+		if (d->fe_adap[0].fe) {
 			if (dvb_attach(stv6110_attach, d->fe_adap[0].fe,
-					&dw2104_stv6110_config,
-					&d->dev->i2c_adap)) {
+				       &dw2104_stv6110_config,
+				       &d->dev->i2c_adap)) {
 				d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
 				info("Attached STV0900+STV6110A!");
 				return 0;
@@ -1273,8 +1266,8 @@ static int dw2104_frontend_attach(struct dvb_usb_adapter *d)
 
 	if (demod_probe & 1) {
 		d->fe_adap[0].fe = dvb_attach(cx24116_attach, &dw2104_config,
-				&d->dev->i2c_adap);
-		if (d->fe_adap[0].fe != NULL) {
+					      &d->dev->i2c_adap);
+		if (d->fe_adap[0].fe) {
 			d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
 			info("Attached cx24116!");
 			return 0;
@@ -1282,10 +1275,10 @@ static int dw2104_frontend_attach(struct dvb_usb_adapter *d)
 	}
 
 	d->fe_adap[0].fe = dvb_attach(ds3000_attach, &dw2104_ds3000_config,
-			&d->dev->i2c_adap);
-	if (d->fe_adap[0].fe != NULL) {
+				      &d->dev->i2c_adap);
+	if (d->fe_adap[0].fe) {
 		dvb_attach(ts2020_attach, d->fe_adap[0].fe,
-			&dw2104_ts2020_config, &d->dev->i2c_adap);
+			   &dw2104_ts2020_config, &d->dev->i2c_adap);
 		d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
 		info("Attached DS3000!");
 		return 0;
@@ -1303,8 +1296,8 @@ static int dw2102_frontend_attach(struct dvb_usb_adapter *d)
 	if (dw2102_properties.i2c_algo == &dw2102_serit_i2c_algo) {
 		/*dw2102_properties.adapter->tuner_attach = NULL;*/
 		d->fe_adap[0].fe = dvb_attach(si21xx_attach, &serit_sp1511lhb_config,
-					&d->dev->i2c_adap);
-		if (d->fe_adap[0].fe != NULL) {
+					      &d->dev->i2c_adap);
+		if (d->fe_adap[0].fe) {
 			d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
 			info("Attached si21xx!");
 			return 0;
@@ -1313,10 +1306,10 @@ static int dw2102_frontend_attach(struct dvb_usb_adapter *d)
 
 	if (dw2102_properties.i2c_algo == &dw2102_earda_i2c_algo) {
 		d->fe_adap[0].fe = dvb_attach(stv0288_attach, &earda_config,
-					&d->dev->i2c_adap);
-		if (d->fe_adap[0].fe != NULL) {
+					      &d->dev->i2c_adap);
+		if (d->fe_adap[0].fe) {
 			if (dvb_attach(stb6000_attach, d->fe_adap[0].fe, 0x61,
-					&d->dev->i2c_adap)) {
+				       &d->dev->i2c_adap)) {
 				d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
 				info("Attached stv0288!");
 				return 0;
@@ -1327,8 +1320,8 @@ static int dw2102_frontend_attach(struct dvb_usb_adapter *d)
 	if (dw2102_properties.i2c_algo == &dw2102_i2c_algo) {
 		/*dw2102_properties.adapter->tuner_attach = dw2102_tuner_attach;*/
 		d->fe_adap[0].fe = dvb_attach(stv0299_attach, &sharp_z0194a_config,
-					&d->dev->i2c_adap);
-		if (d->fe_adap[0].fe != NULL) {
+					      &d->dev->i2c_adap);
+		if (d->fe_adap[0].fe) {
 			d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
 			info("Attached stv0299!");
 			return 0;
@@ -1340,8 +1333,8 @@ static int dw2102_frontend_attach(struct dvb_usb_adapter *d)
 static int dw3101_frontend_attach(struct dvb_usb_adapter *d)
 {
 	d->fe_adap[0].fe = dvb_attach(tda10023_attach, &dw3101_tda10023_config,
-				&d->dev->i2c_adap, 0x48);
-	if (d->fe_adap[0].fe != NULL) {
+				      &d->dev->i2c_adap, 0x48);
+	if (d->fe_adap[0].fe) {
 		info("Attached tda10023!");
 		return 0;
 	}
@@ -1351,10 +1344,10 @@ static int dw3101_frontend_attach(struct dvb_usb_adapter *d)
 static int zl100313_frontend_attach(struct dvb_usb_adapter *d)
 {
 	d->fe_adap[0].fe = dvb_attach(mt312_attach, &zl313_config,
-			&d->dev->i2c_adap);
-	if (d->fe_adap[0].fe != NULL) {
+				      &d->dev->i2c_adap);
+	if (d->fe_adap[0].fe) {
 		if (dvb_attach(zl10039_attach, d->fe_adap[0].fe, 0x60,
-				&d->dev->i2c_adap)) {
+			       &d->dev->i2c_adap)) {
 			d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
 			info("Attached zl100313+zl10039!");
 			return 0;
@@ -1369,9 +1362,9 @@ static int stv0288_frontend_attach(struct dvb_usb_adapter *d)
 	u8 obuf[] = {7, 1};
 
 	d->fe_adap[0].fe = dvb_attach(stv0288_attach, &earda_config,
-			&d->dev->i2c_adap);
+				      &d->dev->i2c_adap);
 
-	if (d->fe_adap[0].fe == NULL)
+	if (!d->fe_adap[0].fe)
 		return -EIO;
 
 	if (dvb_attach(stb6000_attach, d->fe_adap[0].fe, 0x61, &d->dev->i2c_adap) == NULL)
@@ -1384,7 +1377,6 @@ static int stv0288_frontend_attach(struct dvb_usb_adapter *d)
 	info("Attached stv0288+stb6000!");
 
 	return 0;
-
 }
 
 static int ds3000_frontend_attach(struct dvb_usb_adapter *d)
@@ -1393,13 +1385,13 @@ static int ds3000_frontend_attach(struct dvb_usb_adapter *d)
 	u8 obuf[] = {7, 1};
 
 	d->fe_adap[0].fe = dvb_attach(ds3000_attach, &s660_ds3000_config,
-			&d->dev->i2c_adap);
+				      &d->dev->i2c_adap);
 
-	if (d->fe_adap[0].fe == NULL)
+	if (!d->fe_adap[0].fe)
 		return -EIO;
 
 	dvb_attach(ts2020_attach, d->fe_adap[0].fe, &s660_ts2020_config,
-		&d->dev->i2c_adap);
+		   &d->dev->i2c_adap);
 
 	st->old_set_voltage = d->fe_adap[0].fe->ops.set_voltage;
 	d->fe_adap[0].fe->ops.set_voltage = s660_set_voltage;
@@ -1416,8 +1408,8 @@ static int prof_7500_frontend_attach(struct dvb_usb_adapter *d)
 	u8 obuf[] = {7, 1};
 
 	d->fe_adap[0].fe = dvb_attach(stv0900_attach, &prof_7500_stv0900_config,
-					&d->dev->i2c_adap, 0);
-	if (d->fe_adap[0].fe == NULL)
+				      &d->dev->i2c_adap, 0);
+	if (!d->fe_adap[0].fe)
 		return -EIO;
 
 	d->fe_adap[0].fe->ops.set_voltage = dw210x_set_voltage;
@@ -1473,12 +1465,12 @@ static int su3000_frontend_attach(struct dvb_usb_adapter *adap)
 	mutex_unlock(&d->data_mutex);
 
 	adap->fe_adap[0].fe = dvb_attach(ds3000_attach, &su3000_ds3000_config,
-					&d->i2c_adap);
-	if (adap->fe_adap[0].fe == NULL)
+					 &d->i2c_adap);
+	if (!adap->fe_adap[0].fe)
 		return -EIO;
 
 	if (dvb_attach(ts2020_attach, adap->fe_adap[0].fe,
-				&dw2104_ts2020_config,
+		       &dw2104_ts2020_config,
 				&d->i2c_adap)) {
 		info("Attached DS3000/TS2020!");
 		return 0;
@@ -1533,10 +1525,10 @@ static int t220_frontend_attach(struct dvb_usb_adapter *adap)
 	mutex_unlock(&d->data_mutex);
 
 	adap->fe_adap[0].fe = dvb_attach(cxd2820r_attach, &cxd2820r_config,
-					&d->i2c_adap, NULL);
-	if (adap->fe_adap[0].fe != NULL) {
+					 &d->i2c_adap, NULL);
+	if (adap->fe_adap[0].fe) {
 		if (dvb_attach(tda18271_attach, adap->fe_adap[0].fe, 0x60,
-					&d->i2c_adap, &tda18271_config)) {
+			       &d->i2c_adap, &tda18271_config)) {
 			info("Attached TDA18271HD/CXD2820R!");
 			return 0;
 		}
@@ -1561,14 +1553,14 @@ static int m88rs2000_frontend_attach(struct dvb_usb_adapter *adap)
 	mutex_unlock(&d->data_mutex);
 
 	adap->fe_adap[0].fe = dvb_attach(m88rs2000_attach,
-					&s421_m88rs2000_config,
-					&d->i2c_adap);
+					 &s421_m88rs2000_config,
+					 &d->i2c_adap);
 
-	if (adap->fe_adap[0].fe == NULL)
+	if (!adap->fe_adap[0].fe)
 		return -EIO;
 
 	if (dvb_attach(ts2020_attach, adap->fe_adap[0].fe,
-				&dw2104_ts2020_config,
+		       &dw2104_ts2020_config,
 				&d->i2c_adap)) {
 		info("Attached RS2000/TS2020!");
 		return 0;
@@ -1735,14 +1727,14 @@ static int tt_s2_4600_frontend_attach(struct dvb_usb_adapter *adap)
 static int dw2102_tuner_attach(struct dvb_usb_adapter *adap)
 {
 	dvb_attach(dvb_pll_attach, adap->fe_adap[0].fe, 0x60,
-		&adap->dev->i2c_adap, DVB_PLL_OPERA1);
+		   &adap->dev->i2c_adap, DVB_PLL_OPERA1);
 	return 0;
 }
 
 static int dw3101_tuner_attach(struct dvb_usb_adapter *adap)
 {
 	dvb_attach(dvb_pll_attach, adap->fe_adap[0].fe, 0x60,
-		&adap->dev->i2c_adap, DVB_PLL_TUA6034);
+		   &adap->dev->i2c_adap, DVB_PLL_TUA6034);
 
 	return 0;
 }
@@ -1760,7 +1752,7 @@ static int dw2102_rc_query(struct dvb_usb_device *d)
 	if (d->props.i2c_algo->master_xfer(&d->i2c_adap, &msg, 1) == 1) {
 		if (msg.buf[0] != 0xff) {
 			deb_rc("%s: rc code: %x, %x\n",
-					__func__, key[0], key[1]);
+			       __func__, key[0], key[1]);
 			rc_keydown(d->rc_dev, RC_PROTO_UNKNOWN, key[0], 0);
 		}
 	}
@@ -1781,7 +1773,7 @@ static int prof_rc_query(struct dvb_usb_device *d)
 	if (d->props.i2c_algo->master_xfer(&d->i2c_adap, &msg, 1) == 1) {
 		if (msg.buf[0] != 0xff) {
 			deb_rc("%s: rc code: %x, %x\n",
-					__func__, key[0], key[1]);
+			       __func__, key[0], key[1]);
 			rc_keydown(d->rc_dev, RC_PROTO_UNKNOWN, key[0] ^ 0xff,
 				   0);
 		}
@@ -1803,7 +1795,7 @@ static int su3000_rc_query(struct dvb_usb_device *d)
 	if (d->props.i2c_algo->master_xfer(&d->i2c_adap, &msg, 1) == 1) {
 		if (msg.buf[0] != 0xff) {
 			deb_rc("%s: rc code: %x, %x\n",
-					__func__, key[0], key[1]);
+			       __func__, key[0], key[1]);
 			rc_keydown(d->rc_dev, RC_PROTO_RC5,
 				   RC_SCANCODE_RC5(key[1], key[0]), 0);
 		}
@@ -1880,7 +1872,7 @@ static struct usb_device_id dw2102_table[] = {
 MODULE_DEVICE_TABLE(usb, dw2102_table);
 
 static int dw2102_load_firmware(struct usb_device *dev,
-			const struct firmware *frmwr)
+				const struct firmware *frmwr)
 {
 	u8 *b, *p;
 	int ret = 0, i;
@@ -1907,12 +1899,12 @@ static int dw2102_load_firmware(struct usb_device *dev,
 	dw210x_op_rw(dev, 0xa0, 0x7f92, 0, &reset, 1, DW210X_WRITE_MSG);
 	dw210x_op_rw(dev, 0xa0, 0xe600, 0, &reset, 1, DW210X_WRITE_MSG);
 
-	if (p != NULL) {
+	if (p) {
 		memcpy(p, fw->data, fw->size);
 		for (i = 0; i < fw->size; i += 0x40) {
-			b = (u8 *) p + i;
+			b = (u8 *)p + i;
 			if (dw210x_op_rw(dev, 0xa0, i, 0, b, 0x40,
-					DW210X_WRITE_MSG) != 0x40) {
+					 DW210X_WRITE_MSG) != 0x40) {
 				err("error while transferring firmware");
 				ret = -EINVAL;
 				break;
@@ -1938,22 +1930,22 @@ static int dw2102_load_firmware(struct usb_device *dev,
 		case USB_PID_CYPRESS_DW2104:
 			reset = 1;
 			dw210x_op_rw(dev, 0xc4, 0x0000, 0, &reset, 1,
-					DW210X_WRITE_MSG);
+				     DW210X_WRITE_MSG);
 			fallthrough;
 		case USB_PID_CYPRESS_DW3101:
 			reset = 0;
 			dw210x_op_rw(dev, 0xbf, 0x0040, 0, &reset, 0,
-					DW210X_WRITE_MSG);
+				     DW210X_WRITE_MSG);
 			break;
 		case USB_PID_TERRATEC_CINERGY_S:
 		case USB_PID_CYPRESS_DW2102:
 			dw210x_op_rw(dev, 0xbf, 0x0040, 0, &reset, 0,
-					DW210X_WRITE_MSG);
+				     DW210X_WRITE_MSG);
 			dw210x_op_rw(dev, 0xb9, 0x0000, 0, &reset16[0], 2,
-					DW210X_READ_MSG);
+				     DW210X_READ_MSG);
 			/* check STV0299 frontend  */
 			dw210x_op_rw(dev, 0xb5, 0, 0, &reset16[0], 2,
-					DW210X_READ_MSG);
+				     DW210X_READ_MSG);
 			if ((reset16[0] == 0xa1) || (reset16[0] == 0x80)) {
 				dw2102_properties.i2c_algo = &dw2102_i2c_algo;
 				dw2102_properties.adapter->fe[0].tuner_attach = &dw2102_tuner_attach;
@@ -1964,9 +1956,9 @@ static int dw2102_load_firmware(struct usb_device *dev,
 			reset16[1] = 1;
 			reset16[2] = 0;
 			dw210x_op_rw(dev, 0xc2, 0, 0, &reset16[0], 3,
-					DW210X_WRITE_MSG);
+				     DW210X_WRITE_MSG);
 			dw210x_op_rw(dev, 0xc3, 0xd1, 0, &reset16[0], 3,
-					DW210X_READ_MSG);
+				     DW210X_READ_MSG);
 			if (reset16[2] == 0x11) {
 				dw2102_properties.i2c_algo = &dw2102_earda_i2c_algo;
 				break;
@@ -1974,13 +1966,13 @@ static int dw2102_load_firmware(struct usb_device *dev,
 			fallthrough;
 		case 0x2101:
 			dw210x_op_rw(dev, 0xbc, 0x0030, 0, &reset16[0], 2,
-					DW210X_READ_MSG);
+				     DW210X_READ_MSG);
 			dw210x_op_rw(dev, 0xba, 0x0000, 0, &reset16[0], 7,
-					DW210X_READ_MSG);
+				     DW210X_READ_MSG);
 			dw210x_op_rw(dev, 0xba, 0x0000, 0, &reset16[0], 7,
-					DW210X_READ_MSG);
+				     DW210X_READ_MSG);
 			dw210x_op_rw(dev, 0xb9, 0x0000, 0, &reset16[0], 2,
-					DW210X_READ_MSG);
+				     DW210X_READ_MSG);
 			break;
 		}
 
@@ -2593,7 +2585,7 @@ static struct dvb_usb_device_properties tt_s2_4600_properties = {
 };
 
 static int dw2102_probe(struct usb_interface *intf,
-		const struct usb_device_id *id)
+			const struct usb_device_id *id)
 {
 	if (!(dvb_usb_device_init(intf, &dw2102_properties,
 				  THIS_MODULE, NULL, adapter_nr) &&
@@ -2617,7 +2609,6 @@ static int dw2102_probe(struct usb_interface *intf,
 				  THIS_MODULE, NULL, adapter_nr) &&
 	      dvb_usb_device_init(intf, &tt_s2_4600_properties,
 				  THIS_MODULE, NULL, adapter_nr))) {
-
 		return 0;
 	}
 
-- 
2.44.0


