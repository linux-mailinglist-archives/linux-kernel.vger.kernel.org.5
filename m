Return-Path: <linux-kernel+bounces-63625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F185326A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C022835E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064756764;
	Tue, 13 Feb 2024 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZd1Q5Jv"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D857300;
	Tue, 13 Feb 2024 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707832644; cv=none; b=kwiRPGnGmSl4o+YT9aPWuZRugMNCc9gx8mzVySvl89IOfel+upZxDNCPAM2jCBtWaqKlThCs3SNanjyixA525hPVZ3lbvUD0jkH55wKK3XaXbQOOh2RWrsRK5G73S5U2x33pGC+kGZoRL904/WWQkxaCIIK6U//N6qGyPmznclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707832644; c=relaxed/simple;
	bh=GOYtF3nICf5fOssmoGYfYWkcaeQnHv7lcoKjvM4fqlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VyaLhmeYcr+QegGL92QmKoQN39sCFFGNvg4swa3Iruu5scX7UdBs2hwXrfR8amgHXQ7jbps9AzAx8vhaO6yZW9duOghqXM4tYH9p7cz8seeYbVcC0M3wa3onMA0WfBa0JW+rk/M/L3ZZ9DHHJH9WRGzcytpEkTCcjA5KiVK1YpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZd1Q5Jv; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso3824075a12.0;
        Tue, 13 Feb 2024 05:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707832642; x=1708437442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ews9LretG+7Nl7ZjC3wjCehGNuAPRvTJzxU82fgBvTo=;
        b=ZZd1Q5JvbtIuglWxcMaY7Q7hy41P0jRi6XAZxCdtQb/z6YQBi6vBzJznETzE4UppUZ
         W9khS5i6yz/9T9HjAGjIPVayooB6GCiBe7a5vM+jLhuiq9zdrcuqE7M8vAsr/fvoSTWe
         J8K2Xg9hKMMDBzxM+CnfTMK3FscRl6peld2KDgV7UF7g58OSsXamXTC9KHnXiHhNn5Nx
         b3ZRVBeazPe1agOmB0AmpdUXk/jiFqTU3Zhz462o5hRBSg4t5BQBEvsxAiA5SPTedVHe
         8iIb3Ut56ZSQi4lUn5Seb/y+QZ0tdS5vwN7HD95xvLbzO/3diX3QD4hhX5E8ckrID3h5
         FbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707832642; x=1708437442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ews9LretG+7Nl7ZjC3wjCehGNuAPRvTJzxU82fgBvTo=;
        b=RI0eYzE0FOkBot67q4os4xSXJB2UMzqqSwlDynCGdloIrLs2x6rNJ+2KPtlF3QwbqY
         NhzrglrdHuF2iUAJWqsOZsBQYLLgBrzJ91xmnjA2VMQeKPQH6aEH4xe0i8w91NhYZnlu
         menspNnN+aPz3Cc9NusZVBbL92YCTvZNTjjJ1cyL1ICKIbf7E7QfH/1R8Dau/Otjz3NZ
         A/OULeQpp4S7jPygvk6j2g110blXMJM9/VXhsp4s4lTyt9jR3e4LIvxFzyFixU2JIcPx
         owMIo3gVljLUyBXXcS0o388yv4hkeYVrkwFBbYOYD9/E7bPg61alncs+mNqUmb1q1tKJ
         Kyow==
X-Forwarded-Encrypted: i=1; AJvYcCXHY3msc/QoQVkyv+7fNcsXAQ/m3Z1xAjl7+EJGqAKOusvlWYrycUDyqTidSZgI891vgdk5krCF4dToJYKxSWpYiB8YndettcrJd6wG6jURSfAJpKRlJxN/qeFRg+1AoDzeQQ6LJPvxtx/oD2VI
X-Gm-Message-State: AOJu0Yw5p5mnk1Yb1xEMBr8gYxYFnqQxgxvx+uCcJH1DYt2MUMwqgGi4
	XgK17ygRxbx/sb12P+lZmdkqz5PPMq5+hCPD91sA9mE9EiO/YwlP6Ms/eyFF31xIepSdJ91Ja/5
	hO1mV2N4vVBUu/v9OmJfhbG5rLcc=
X-Google-Smtp-Source: AGHT+IE8niuSb6UQkEJPSLe0v2o73Xa65bUwPkECghkBxeu/HyfBIIpslNd21RXH6d/lzTEBvT/2lZHB8xHR1PyvO4U=
X-Received: by 2002:a17:90a:ec03:b0:296:669d:bf74 with SMTP id
 l3-20020a17090aec0300b00296669dbf74mr7440074pjy.1.1707832641532; Tue, 13 Feb
 2024 05:57:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128173352.2714442-1-andreas@kemnade.info> <20240128173352.2714442-4-andreas@kemnade.info>
In-Reply-To: <20240128173352.2714442-4-andreas@kemnade.info>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 13 Feb 2024 07:57:10 -0600
Message-ID: <CAHCN7x+rfwNeb+xOnLmQR78MQVDwGOOEHqnEceJcDkMrRJtE5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] gnss: Add driver for AI2 protocol
To: Andreas Kemnade <andreas@kemnade.info>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, 
	johan@kernel.org, jirislaby@kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	Tony Lindgren <tony@atomide.com>, tomi.valkeinen@ideasonboard.com, 
	=?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, robh@kernel.org, 
	hns@goldelico.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 11:34=E2=80=AFAM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
>
> Add a driver for the Air Independent Interface protocol used by some TI
> Wilink combo chips. Per default, send out just NMEA to userspace and turn
> on/off things at open()/close() but keep the door open for any
> sophisticated development regarding the AI2 protocol by having a kernel
> parameter to turn it into raw mode resembling /dev/tigps provided by some
> TI vendor kernels.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

I am still trying to find a GPS antenna for the Logic PD board I have,
but it occurred to me that the kit that I have used may require
special GPS firmware.  Are you using any special firmware in the radio
in conjunction with these driver patches or are you using the standard
bts files?

adam
> ---
>  drivers/gnss/Kconfig  |  13 ++
>  drivers/gnss/Makefile |   3 +
>  drivers/gnss/ai2.c    | 523 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 539 insertions(+)
>  create mode 100644 drivers/gnss/ai2.c
>
> diff --git a/drivers/gnss/Kconfig b/drivers/gnss/Kconfig
> index d7fe265c28696..3a20212dacc9e 100644
> --- a/drivers/gnss/Kconfig
> +++ b/drivers/gnss/Kconfig
> @@ -65,4 +65,17 @@ config GNSS_USB
>
>           If unsure, say N.
>
> +config GNSS_AI2
> +       tristate "TI AI2 procotol support"
> +       depends on BT_HCIUART_LL
> +       help
> +         Say Y here if you have a Texas Instruments Wilink combo chip
> +         contaning among other things a GNSS receiver speaking the

s/contaning /containing

> +         Air Independent Interface (AI2) protocol.
> +
> +         To compile this driver as a module, choose M here: the module w=
ill
> +         be called gnss-ai2.
> +
> +         If unsure, say N.
> +
>  endif # GNSS
> diff --git a/drivers/gnss/Makefile b/drivers/gnss/Makefile
> index bb2cbada34359..bf6fefcb2e823 100644
> --- a/drivers/gnss/Makefile
> +++ b/drivers/gnss/Makefile
> @@ -20,3 +20,6 @@ gnss-ubx-y :=3D ubx.o
>
>  obj-$(CONFIG_GNSS_USB)                 +=3D gnss-usb.o
>  gnss-usb-y :=3D usb.o
> +
> +obj-$(CONFIG_GNSS_AI2)                 +=3D gnss-ai2.o
> +gnss-ai2-y :=3D ai2.o
> diff --git a/drivers/gnss/ai2.c b/drivers/gnss/ai2.c
> new file mode 100644
> index 0000000000000..673fbe8de7ef2
> --- /dev/null
> +++ b/drivers/gnss/ai2.c
> @@ -0,0 +1,523 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Texas Instruments AI2 (Air independent interface) protocol device dri=
ver
> + * Used for some TI WLAN/Bluetooth/GNSS combo chips.
> + *
> + * Copyright (C) 2024 Andreas Kemnade <andreas@kemnade.info>
> + */
> +#include <linux/errno.h>
> +#include <linux/gnss.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/ti_wilink_st.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +/* Channel-9 details for GPS */
> +#define GPS_CH9_PKT_NUMBER             0x9
> +#define GPS_CH9_OP_WRITE               0x1
> +#define GPS_CH9_OP_READ                        0x2
> +#define GPS_CH9_OP_COMPLETED_EVT       0x3
> +
> +/* arbitarily chosen, should fit everything seen in the past */
> +#define MAX_AI2_FRAME_SIZE 2048
> +
> +#define AI2_ESCAPE 0x10 /* if sent as data, it is doubled */
> +#define AI2_END_MARKER 0x3
> +#define AI2_ACK 0x2
> +
> +/* reports */
> +#define AI2_REPORT_NMEA 0xd3
> +
> +#define NMEA_HEADER_LEN 4
> +
> +/* commands */
> +#define AI2_CMD_RECEIVER_STATE 2
> +
> +#define RECEIVER_STATE_OFF 1
> +#define RECEIVER_STATE_IDLE 2
> +#define RECEIVER_STATE_ON 3
> +
> +#define AI2_CMD_CONFIG_NMEA 0xe5
> +#define NMEA_MASK_GGA (1 << 0)
> +#define NMEA_MASK_GLL (1 << 1)
> +#define NMEA_MASK_GSA (1 << 2)
> +#define NMEA_MASK_GSV (1 << 3)
> +#define NMEA_MASK_RMC (1 << 4)
> +#define NMEA_MASK_VTG (1 << 5)
> +
> +#define NMEA_MASK_ALL (NMEA_MASK_GGA | \
> +               NMEA_MASK_GLL | \
> +               NMEA_MASK_GSA | \
> +               NMEA_MASK_GSV | \
> +               NMEA_MASK_RMC | \
> +               NMEA_MASK_VTG)
> +
> +
> +static bool ai2raw;
> +
> +struct ai2_device {
> +       struct mutex gdev_mutex;
> +       bool gdev_open;
> +       struct gnss_device *gdev;
> +       struct device *dev;
> +       struct sk_buff *recv_skb;
> +       bool recv_esc;
> +};
> +
> +static struct sk_buff *ai2_skb_alloc(unsigned int len, gfp_t how)
> +{
> +       struct sk_buff *skb;
> +
> +       skb =3D bt_skb_alloc(len + sizeof(struct gps_event_hdr), how);
> +       if (skb)
> +               skb_reserve(skb, sizeof(struct gps_event_hdr));
> +
> +       return skb;
> +}
> +
> +static int ai2_send_frame(struct ai2_device *ai2dev,
> +                         struct sk_buff *skb)
> +{
> +       int len;
> +       struct gps_event_hdr *gnssdrv_hdr;
> +       struct hci_dev *hdev;
> +
> +       if (skb->len >=3D U16_MAX)
> +               return -EINVAL;
> +
> +       /*
> +        * note: fragmentation at this point not handled yet
> +        * not needed for simple config commands
> +        */
> +       len =3D skb->len;
> +       gnssdrv_hdr =3D skb_push(skb, sizeof(struct gps_event_hdr));
> +       gnssdrv_hdr->opcode =3D GPS_CH9_OP_WRITE;
> +       gnssdrv_hdr->plen =3D __cpu_to_le16(len);
> +
> +       hci_skb_pkt_type(skb) =3D GPS_CH9_PKT_NUMBER;
> +       hdev =3D st_get_hci(ai2dev->dev->parent);
> +       return hdev->send(hdev, skb);
> +}
> +
> +static void ai2_put_escaped(struct sk_buff *skb, u8 d)
> +{
> +       skb_put_u8(skb, d);
> +       if (d =3D=3D 0x10)
> +               skb_put_u8(skb, d);
> +}
> +
> +static struct sk_buff *ai2_compose_frame(bool request_ack,
> +                                       u8 cmd,
> +                                       const u8 *data,
> +                                       int len)
> +{
> +       u16 sum;
> +       int i;
> +       /* duplicate the length to have space for worst case escaping */
> +       struct sk_buff *skb =3D ai2_skb_alloc(2 + len * 2 + 2 + 2, GFP_KE=
RNEL);
> +
> +       skb_put_u8(skb, AI2_ESCAPE);
> +       skb_put_u8(skb, request_ack ? 1 : 0);
> +
> +       sum =3D AI2_ESCAPE;
> +       if (request_ack)
> +               sum++;
> +
> +       ai2_put_escaped(skb, cmd);
> +       sum +=3D cmd;
> +
> +       ai2_put_escaped(skb, len & 0xff);
> +       sum +=3D len & 0xff;
> +
> +       ai2_put_escaped(skb, len >> 8);
> +       sum +=3D len >> 8;
> +
> +       for (i =3D 0; i < len; i++) {
> +               sum +=3D data[i];
> +               ai2_put_escaped(skb, data[i]);
> +       }
> +
> +       ai2_put_escaped(skb, sum & 0xFF);
> +       ai2_put_escaped(skb, sum >> 8);
> +       skb_put_u8(skb, AI2_ESCAPE);
> +       skb_put_u8(skb, AI2_END_MARKER);
> +
> +       return skb;
> +}
> +
> +static int ai2_set_receiver_state(struct ai2_device *ai2dev,
> +                                             uint8_t state)
> +{
> +       struct sk_buff *skb =3D ai2_compose_frame(true, AI2_CMD_RECEIVER_=
STATE,
> +                                               &state, 1);
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       return ai2_send_frame(ai2dev, skb);
> +}
> +
> +static int ai2_config_nmea_reports(struct ai2_device *ai2dev,
> +                                  uint8_t mask)
> +{
> +       u8 buf[4] =3D {0};
> +       struct sk_buff *skb;
> +
> +       buf[0] =3D mask;
> +       skb =3D ai2_compose_frame(true, AI2_CMD_CONFIG_NMEA,
> +                               buf, sizeof(buf));
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       return ai2_send_frame(ai2dev, skb);
> +}
> +
> +/*
> + * Unknown commands, give some version information, must be sent
> + * once, not sure what undoes them besides resetting the whole
> + * bt part, but no sings of significant things being still

s/sings/signs

> + * turned on without undoing this.
> + */
> +static int gnss_ai2_init(struct ai2_device *ai2dev)
> +{
> +       int ret;
> +       u8 d =3D 0x01;
> +       struct sk_buff *skb =3D ai2_compose_frame(true, 0xf5, &d, 1);
> +
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       ret =3D ai2_send_frame(ai2dev, skb);
> +       if (ret)
> +               return ret;
> +
> +       msleep(200);
> +       d =3D 5;
> +       skb =3D ai2_compose_frame(true, 0xf1, &d, 1);
> +       if (!skb)
> +               return -ENOMEM;
> +
> +       return ai2_send_frame(ai2dev, skb);
> +}
> +
> +static int gnss_ai2_open(struct gnss_device *gdev)
> +{
> +       struct ai2_device *ai2dev =3D gnss_get_drvdata(gdev);
> +       int ret;
> +
> +       mutex_lock(&ai2dev->gdev_mutex);
> +       ai2dev->gdev_open =3D true;
> +       mutex_unlock(&ai2dev->gdev_mutex);
> +       if (ai2raw)
> +               return 0;
> +
> +       ret =3D gnss_ai2_init(ai2dev);
> +       if (ret)
> +               goto err;
> +
> +       /* TODO: find out on what kind of ack we should wait */
> +       msleep(200);
> +       ret =3D ai2_set_receiver_state(ai2dev, RECEIVER_STATE_IDLE);
> +       if (ret)
> +               goto err;
> +
> +       msleep(200);
> +       ret =3D ai2_config_nmea_reports(ai2dev, NMEA_MASK_ALL);
> +       if (ret)
> +               goto err;
> +
> +       msleep(200);
> +       ret =3D ai2_set_receiver_state(ai2dev, RECEIVER_STATE_ON);
> +       if (ret)
> +               goto err;
> +
> +       return 0;
> +err:
> +       mutex_lock(&ai2dev->gdev_mutex);
> +       ai2dev->gdev_open =3D false;
> +       if (ai2dev->recv_skb)
> +               kfree_skb(ai2dev->recv_skb);
> +
> +       ai2dev->recv_skb =3D NULL;
> +       mutex_unlock(&ai2dev->gdev_mutex);
> +       return ret;
> +}
> +
> +static void gnss_ai2_close(struct gnss_device *gdev)
> +{
> +       struct ai2_device *ai2dev =3D gnss_get_drvdata(gdev);
> +
> +       /* TODO: find out on what kind of ack we should wait */
> +       if (!ai2raw) {
> +               msleep(200);
> +               ai2_set_receiver_state(ai2dev, RECEIVER_STATE_IDLE);
> +               msleep(200);
> +               ai2_set_receiver_state(ai2dev, RECEIVER_STATE_OFF);
> +               msleep(200);
> +       }
> +
> +       mutex_lock(&ai2dev->gdev_mutex);
> +       ai2dev->gdev_open =3D false;
> +       if (ai2dev->recv_skb)
> +               kfree_skb(ai2dev->recv_skb);
> +
> +       ai2dev->recv_skb =3D NULL;
> +       mutex_unlock(&ai2dev->gdev_mutex);
> +}
> +
> +
> +static int gnss_ai2_write_raw(struct gnss_device *gdev,
> +               const unsigned char *buf, size_t count)
> +{
> +       struct ai2_device *ai2dev =3D gnss_get_drvdata(gdev);
> +       int err =3D 0;
> +       struct sk_buff *skb =3D NULL;
> +
> +       if (!ai2raw)
> +               return -EPERM;
> +
> +       /* allocate packet */
> +       skb =3D ai2_skb_alloc(count, GFP_KERNEL);
> +       if (!skb) {
> +               BT_ERR("cannot allocate memory for HCILL packet");
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       skb_put_data(skb, buf, count);
> +
> +       err =3D ai2_send_frame(ai2dev, skb);
> +       if (err)
> +               goto out;
> +
> +       return count;
> +out:
> +       return err;
> +}
> +
> +static const struct gnss_operations gnss_ai2_ops =3D {
> +       .open           =3D gnss_ai2_open,
> +       .close          =3D gnss_ai2_close,
> +       .write_raw      =3D gnss_ai2_write_raw,
> +};
> +
> +static void process_ai2_packet(struct ai2_device *ai2dev,
> +                              u8 cmd, u8 *data, u16 len)
> +{
> +       if (cmd !=3D AI2_REPORT_NMEA)
> +               return;
> +
> +       if (len <=3D NMEA_HEADER_LEN)
> +               return;
> +
> +       len -=3D NMEA_HEADER_LEN;
> +       data +=3D NMEA_HEADER_LEN;
> +
> +       gnss_insert_raw(ai2dev->gdev, data, len);
> +}
> +
> +/* do some sanity checks and split frame into packets */
> +static void process_ai2_frame(struct ai2_device *ai2dev)
> +{
> +       u16 sum;
> +       int i;
> +       u8 *head;
> +       u8 *data;
> +
> +       sum =3D 0;
> +       data =3D ai2dev->recv_skb->data;
> +       for (i =3D 0; i < ai2dev->recv_skb->len - 2; i++)
> +               sum +=3D data[i];
> +
> +       print_hex_dump_bytes("ai2 frame: ", DUMP_PREFIX_OFFSET, data, ai2=
dev->recv_skb->len);
> +
> +       if (get_unaligned_le16(data + i) !=3D sum) {
> +               dev_dbg(ai2dev->dev,
> +                       "checksum error in reception, dropping frame\n");
> +               return;
> +       }
> +
> +       /* reached if byte 1 in the command packet is set to 1 */
> +       if (data[1] =3D=3D AI2_ACK)
> +               return;
> +
> +       head =3D skb_pull(ai2dev->recv_skb, 2); /* drop frame start marke=
r */
> +       while (head && (ai2dev->recv_skb->len >=3D 3)) {
> +               u8 cmd;
> +               u16 pktlen;
> +
> +               cmd =3D head[0];
> +               pktlen =3D get_unaligned_le16(head + 1);
> +               data =3D skb_pull(ai2dev->recv_skb, 3);
> +               if (!data)
> +                       break;
> +
> +               if (pktlen > ai2dev->recv_skb->len)
> +                       break;
> +
> +               head =3D skb_pull(ai2dev->recv_skb, pktlen);
> +
> +               process_ai2_packet(ai2dev, cmd, data, pktlen);
> +       }
> +}
> +
> +static void process_ai2_data(struct ai2_device *ai2dev,
> +                            u8 *data, int len)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < len; i++) {
> +               if (!ai2dev->recv_skb) {
> +                       ai2dev->recv_esc =3D false;
> +                       if (data[i] !=3D AI2_ESCAPE) {
> +                               dev_dbg(ai2dev->dev, "dropping data, tryi=
ng to resync\n");
> +                               continue;
> +                       }
> +                       ai2dev->recv_skb =3D alloc_skb(MAX_AI2_FRAME_SIZE=
, GFP_KERNEL);
> +                       if (!ai2dev->recv_skb)
> +                               return;
> +
> +                       dev_dbg(ai2dev->dev, "starting packet\n");
> +
> +                       /* this initial AI2_ESCAPE is part of checksum co=
mputation */
> +                       skb_put_u8(ai2dev->recv_skb, data[i]);
> +                       continue;
> +               }
> +               if (ai2dev->recv_skb->len =3D=3D 1) {
> +                       if (data[i] =3D=3D AI2_END_MARKER) {
> +                               dev_dbg(ai2dev->dev, "unexpected end of f=
rame received\n");
> +                               kfree_skb(ai2dev->recv_skb);
> +                               ai2dev->recv_skb =3D NULL;
> +                               continue;
> +                       }
> +                       skb_put_u8(ai2dev->recv_skb, data[i]);
> +               } else {
> +                       /* drop one of two AI2_ESCAPE */
> +                       if ((!ai2dev->recv_esc) &&
> +                          (data[i] =3D=3D AI2_ESCAPE)) {
> +                               ai2dev->recv_esc =3D true;
> +                               continue;
> +                       }
> +
> +                       if (ai2dev->recv_esc &&
> +                           (data[i] =3D=3D AI2_END_MARKER)) {
> +                               process_ai2_frame(ai2dev);
> +                               kfree_skb(ai2dev->recv_skb);
> +                               ai2dev->recv_skb =3D NULL;
> +                               continue;
> +                       }
> +                       skb_put_u8(ai2dev->recv_skb, data[i]);
> +               }
> +       }
> +}
> +
> +static void gnss_recv_frame(struct device *dev, struct sk_buff *skb)
> +{
> +       struct ai2_device *ai2dev =3D dev_get_drvdata(dev);
> +       struct gps_event_hdr *gnss_hdr;
> +       u8 *data;
> +
> +       if (!ai2dev->gdev) {
> +               kfree_skb(skb);
> +               return;
> +       }
> +
> +       gnss_hdr =3D (struct gps_event_hdr *)skb->data;
> +
> +       data =3D skb_pull(skb, sizeof(*gnss_hdr));
> +       /*
> +        * REVISIT: maybe do something with the completed
> +        * event
> +        */
> +       if (gnss_hdr->opcode =3D=3D GPS_CH9_OP_READ) {
> +               mutex_lock(&ai2dev->gdev_mutex);
> +               if (ai2dev->gdev_open) {
> +                       if (ai2raw)
> +                               gnss_insert_raw(ai2dev->gdev, data, skb->=
len);
> +                       else
> +                               process_ai2_data(ai2dev, data, skb->len);
> +               } else {
> +                       dev_dbg(ai2dev->dev,
> +                               "receiving data while chip should be off\=
n");
> +               }
> +               mutex_unlock(&ai2dev->gdev_mutex);
> +       }
> +       kfree_skb(skb);
> +}
> +
> +static int gnss_ai2_probe(struct platform_device *pdev)
> +{
> +       struct gnss_device *gdev;
> +       struct ai2_device *ai2dev;
> +       int ret;
> +
> +       ai2dev =3D devm_kzalloc(&pdev->dev, sizeof(*ai2dev), GFP_KERNEL);
> +       if (!ai2dev)
> +               return -ENOMEM;
> +
> +       ai2dev->dev =3D &pdev->dev;
> +       gdev =3D gnss_allocate_device(&pdev->dev);
> +       if (!gdev)
> +               return -ENOMEM;
> +
> +       gdev->ops =3D &gnss_ai2_ops;
> +       gdev->type =3D ai2raw ? GNSS_TYPE_AI2 : GNSS_TYPE_NMEA;
> +       gnss_set_drvdata(gdev, ai2dev);
> +       platform_set_drvdata(pdev, ai2dev);
> +       st_set_gnss_recv_func(pdev->dev.parent, gnss_recv_frame);
> +       mutex_init(&ai2dev->gdev_mutex);
> +
> +       ret =3D gnss_register_device(gdev);
> +       if (ret)
> +               goto err;
> +
> +       ai2dev->gdev =3D gdev;
> +       return 0;
> +
> +err:
> +       st_set_gnss_recv_func(pdev->dev.parent, NULL);
> +
> +       if (ai2dev->recv_skb)
> +               kfree_skb(ai2dev->recv_skb);
> +
> +       gnss_put_device(gdev);
> +       return ret;
> +}
> +
> +static void gnss_ai2_remove(struct platform_device *pdev)
> +{
> +       struct ai2_device *ai2dev =3D  platform_get_drvdata(pdev);
> +
> +       st_set_gnss_recv_func(pdev->dev.parent, NULL);
> +       gnss_deregister_device(ai2dev->gdev);
> +       gnss_put_device(ai2dev->gdev);
> +       if (ai2dev->recv_skb)
> +               kfree_skb(ai2dev->recv_skb);
> +}
> +
> +static const struct platform_device_id gnss_ai2_id[] =3D {
> +       {
> +               .name =3D "ti-ai2-gnss"
> +       }, {
> +               /* sentinel */
> +       }
> +};
> +MODULE_DEVICE_TABLE(platform, gnss_ai2_id);
> +
> +static struct platform_driver gnss_ai2_driver =3D {
> +       .driver =3D {
> +               .name =3D "gnss-ai2",
> +       },
> +       .probe          =3D gnss_ai2_probe,
> +       .remove_new     =3D gnss_ai2_remove,
> +       .id_table       =3D gnss_ai2_id,
> +};
> +module_platform_driver(gnss_ai2_driver);
> +
> +module_param(ai2raw, bool, 0600);
> +MODULE_DESCRIPTION("AI2 GNSS driver");
> +MODULE_LICENSE("GPL");
> --
> 2.39.2
>

