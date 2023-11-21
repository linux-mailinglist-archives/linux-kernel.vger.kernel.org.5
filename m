Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD57F31DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjKUPEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjKUPEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:04:40 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D578A9A;
        Tue, 21 Nov 2023 07:04:34 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c210e34088so3025430a12.2;
        Tue, 21 Nov 2023 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700579074; x=1701183874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIE1djqYi2kioMnL4zQEapN7NaRvo8HfBQjSKyvxo0M=;
        b=fF21pNpLqKiLyIAsLeSQOK+jGZ3HHQqjFma32uQPjB3wLUigH0oogf8Fs9mHNFKHUg
         S7Ywag8AkShEv1q+IxWC+V7ysB5fIqLUfhjqXxzETuffhXl3C8rH3/iAYdZAx6fpZYKf
         cJUiaGE5ncWC1Uy50tPz2BXESwwDzezyIUOw0w3RUurv6NjQcEpLLsMhFTqV9Dx3cf54
         P/xC8C+WoX6ygA82XHYQcmHLE/PUaN92wmzkWWn890COylMwIg293vM12QnTQCSTN0nZ
         VitdP2NyyYj2Gqm6rC/VMWdBGsgIziNCt1lOw+woAFDzldMeSwxstvMUHy6LVr7vF4/u
         aJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700579074; x=1701183874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VIE1djqYi2kioMnL4zQEapN7NaRvo8HfBQjSKyvxo0M=;
        b=Xy0nzHqcO3vyUD0xa87B/eAZHRDWWFOIJ1JsY/rUQB7s3ruJoj5mbuq5AVJ5u0/JNd
         dhTemefsJwbMkVSCaQCavJ37Q/XQL/nFHMWpuiTNgU/lc9mT+Fs+oUdrIRFGkTlgxVSz
         BNDqnDOCMf191KRh1n1RAB1vgioFyRHZTnNf1x9qWAYT9sfzQtYNY3yn/EwC5NotMzye
         BFxaFV5T/V+/IkjNc/93FPxCIDU3WVaBERA/HK4eU9EZkVdj69H+b7As1UNpkTVdeUSn
         s62IwxOrxr3lQyZJ7AdCQuL7jrt0DApbDUVsc/qv3pRpIEKlRMiKgOTL0FJvZdiBqxd+
         UDmA==
X-Gm-Message-State: AOJu0YzUvc6079XJeEok6XDWN1r7/vm0lrRUNqtZPhzfrEnIzxlcv97M
        XRFzP/fxolUfvSx8Dz4Qv2jbZspLlTZAfzO0e2E=
X-Google-Smtp-Source: AGHT+IH65KxfGqyoRrCf/Wlph32TO7fxxaG+1b+n3nO9qEoLmQ+Q6YBm9A/tiwkAvEppkHpUi6MGHyaDky5sSGBSZxw=
X-Received: by 2002:a17:90b:2711:b0:280:cd5f:bf8e with SMTP id
 px17-20020a17090b271100b00280cd5fbf8emr11187371pjb.18.1700579073710; Tue, 21
 Nov 2023 07:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20231120175657.4070921-1-stefan.maetje@esd.eu> <20231120175657.4070921-3-stefan.maetje@esd.eu>
In-Reply-To: <20231120175657.4070921-3-stefan.maetje@esd.eu>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Wed, 22 Nov 2023 00:04:22 +0900
Message-ID: <CAMZ6Rq+HxJ3tG5PkS_m1p4AUs80Ncrjb1eES1Rs1oLDs0UhF6g@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] can: esd: add support for esd GmbH PCIe/402 CAN
 interface family
To:     =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two last comments. These are not withstanding.

On Tue. 21 Nov. 2023 at 02:57, Stefan M=C3=A4tje <stefan.maetje@esd.eu> wro=
te:
> This patch adds support for the PCI based PCIe/402 CAN interface family
> from esd GmbH that is available with various form factors
> (https://esd.eu/en/products/402-series-can-interfaces).
>
> All boards utilize a FPGA based CAN controller solution developed
> by esd (esdACC). For more information on the esdACC see
> https://esd.eu/en/products/esdacc.
>
> This driver detects all available CAN interface board variants of
> the family but atm. operates the CAN-FD capable devices in
> Classic-CAN mode only! A later patch will introduce the CAN-FD
> functionality in this driver.
>
> Co-developed-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>
> Signed-off-by: Thomas K=C3=B6rper <thomas.koerper@esd.eu>
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>
> ---

(...)

> diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
> new file mode 100644
> index 000000000000..c990e60c09f1
> --- /dev/null
> +++ b/drivers/net/can/esd/esdacc.c
> @@ -0,0 +1,761 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2015 - 2016 Thomas K=C3=B6rper, esd electronic system d=
esign gmbh
> + * Copyright (C) 2017 - 2023 Stefan M=C3=A4tje, esd electronics gmbh
> + */
> +
> +#include "esdacc.h"
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/ktime.h>
> +
> +/* esdACC ID register layout */
> +#define ACC_ID_ID_MASK GENMASK(28, 0)
> +#define ACC_ID_EFF_FLAG BIT(29)
> +
> +/* esdACC DLC register layout */
> +#define ACC_DLC_DLC_MASK GENMASK(3, 0)
> +#define ACC_DLC_RTR_FLAG BIT(4)
> +#define ACC_DLC_TXD_FLAG BIT(5)
> +
> +/* ecc value of esdACC equals SJA1000's ECC register */
> +#define ACC_ECC_SEG 0x1f
> +#define ACC_ECC_DIR 0x20
> +#define ACC_ECC_BIT 0x00
> +#define ACC_ECC_FORM 0x40
> +#define ACC_ECC_STUFF 0x80
> +#define ACC_ECC_MASK 0xc0
> +
> +/* esdACC Status Register bits. Unused bits not documented. */
> +#define ACC_REG_STATUS_MASK_STATUS_ES BIT(17)
> +#define ACC_REG_STATUS_MASK_STATUS_EP BIT(18)
> +#define ACC_REG_STATUS_MASK_STATUS_BS BIT(19)
> +
> +/* esdACC Overview Module BM_IRQ_Mask register related defines */
> +/*   Two bit wide command masks to mask or unmask a single core IRQ */
> +#define ACC_BM_IRQ_UNMASK BIT(0)
> +#define ACC_BM_IRQ_MASK (ACC_BM_IRQ_UNMASK << 1)
> +/*   Command to unmask all IRQ sources. Created by shifting
> + *   and oring the two bit wide ACC_BM_IRQ_UNMASK 16 times.
> + */
> +#define ACC_BM_IRQ_UNMASK_ALL 0x55555555U
> +
> +static void acc_resetmode_enter(struct acc_core *core)
> +{
> +       acc_set_bits(core, ACC_CORE_OF_CTRL_MODE,
> +                    ACC_REG_CONTROL_MASK_MODE_RESETMODE);
> +
> +       /* Read back reset mode bit to flush PCI write posting */
> +       acc_resetmode_entered(core);
> +}
> +
> +static void acc_resetmode_leave(struct acc_core *core)
> +{
> +       acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
> +                      ACC_REG_CONTROL_MASK_MODE_RESETMODE);
> +
> +       /* Read back reset mode bit to flush PCI write posting */
> +       acc_resetmode_entered(core);
> +}
> +
> +static void acc_txq_put(struct acc_core *core, u32 acc_id, u8 acc_dlc,
> +                       const void *data)
> +{
> +       acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
> +                          *((const u32 *)(data + 4)));
> +       acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
> +                          *((const u32 *)data));
> +       acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
> +       /* CAN id must be written at last. This write starts TX. */
> +       acc_write32(core, ACC_CORE_OF_TXFIFO_ID, acc_id);
> +}
> +
> +static u8 acc_tx_fifo_next(struct acc_core *core, u8 tx_fifo_idx)
> +{
> +       ++tx_fifo_idx;
> +       if (tx_fifo_idx >=3D core->tx_fifo_size)
> +               tx_fifo_idx =3D 0U;
> +       return tx_fifo_idx;
> +}
> +/* Convert timestamp from esdACC time stamp ticks to ns
> + *
> + * The conversion factor ts2ns from time stamp counts to ns is basically
> + *     ts2ns =3D NSEC_PER_SEC / timestamp_frequency
> + *
> + * We handle here only a fixed timestamp frequency of 80MHz. The
> + * resulting ts2ns factor would be 12.5.
> + *
> + * At the end we multiply by 12 and add the half of the HW timestamp
> + * to get a multiplication by 12.5. This way any overflow is
> + * avoided until ktime_t itself overflows.
> + */
> +#define ACC_TS_FACTOR (NSEC_PER_SEC / ACC_TS_FREQ_80MHZ)
> +#define ACC_TS_80MHZ_SHIFT 1
> +
> +static ktime_t acc_ts2ktime(struct acc_ov *ov, u64 ts)
> +{
> +       u64 ns;
> +
> +       ns =3D (ts * ACC_TS_FACTOR) + (ts >> ACC_TS_80MHZ_SHIFT);
> +
> +       return ns_to_ktime(ns);
> +}

Nitpick: if the macro is meant to have a global scope, better to put
it at the beginning with other macros. If the scope is only
acc_ts2ktime(), then undefine them once it is out of scope.

  #undef ACC_TS_FACTOR
  #undef ACC_TS_80MHZ_SHIFT

> +void acc_init_ov(struct acc_ov *ov, struct device *dev)
> +{
> +       u32 temp;
> +
> +       temp =3D acc_ov_read32(ov, ACC_OV_OF_VERSION);
> +       ov->version =3D temp;
> +       ov->features =3D (temp >> 16);
> +
> +       temp =3D acc_ov_read32(ov, ACC_OV_OF_INFO);
> +       ov->total_cores =3D temp;
> +       ov->active_cores =3D (temp >> 8);
> +
> +       ov->core_frequency =3D acc_ov_read32(ov, ACC_OV_OF_CANCORE_FREQ);
> +       ov->timestamp_frequency =3D acc_ov_read32(ov, ACC_OV_OF_TS_FREQ_L=
O);
> +
> +       /* Depending on esdACC feature NEW_PSC enable the new prescaler
> +        * or adjust core_frequency according to the implicit division by=
 2.
> +        */
> +       if (ov->features & ACC_OV_REG_FEAT_MASK_NEW_PSC) {
> +               acc_ov_set_bits(ov, ACC_OV_OF_MODE,
> +                               ACC_OV_REG_MODE_MASK_NEW_PSC_ENABLE);
> +       } else {
> +               ov->core_frequency /=3D 2;
> +       }
> +
> +       dev_dbg(dev,
> +               "esdACC v%u, freq: %u/%u, feat/strap: 0x%x/0x%x, cores: %=
u/%u\n",
> +               ov->version, ov->core_frequency, ov->timestamp_frequency,
> +               ov->features, acc_ov_read32(ov, ACC_OV_OF_INFO) >> 16,
> +               ov->active_cores, ov->total_cores);
> +}
> +
> +void acc_init_bm_ptr(struct acc_ov *ov, struct acc_core *cores, const vo=
id *mem)
> +{
> +       unsigned int u;
> +
> +       /* DMA buffer layout as follows where N is the number of CAN core=
s
> +        * implemented in the FPGA, i.e. N =3D ov->total_cores
> +        *
> +        *  Section Layout           Section size
> +        * ----------------------------------------------
> +        *  FIFO Card/Overview       ACC_CORE_DMABUF_SIZE
> +        *  FIFO Core0               ACC_CORE_DMABUF_SIZE
> +        *  ...                      ...
> +        *  FIFO CoreN               ACC_CORE_DMABUF_SIZE
> +        *  irq_cnt Card/Overview    sizeof(u32)
> +        *  irq_cnt Core0            sizeof(u32)
> +        *  ...                      ...
> +        *  irq_cnt CoreN            sizeof(u32)
> +        */
> +       ov->bmfifo.messages =3D mem;
> +       ov->bmfifo.irq_cnt =3D mem + (ov->total_cores + 1U) * ACC_CORE_DM=
ABUF_SIZE;
> +
> +       for (u =3D 0U; u < ov->active_cores; u++) {
> +               struct acc_core *core =3D &cores[u];
> +
> +               core->bmfifo.messages =3D mem + (u + 1U) * ACC_CORE_DMABU=
F_SIZE;
> +               core->bmfifo.irq_cnt =3D ov->bmfifo.irq_cnt + (u + 1U);
> +       }
> +}
> +
> +int acc_open(struct net_device *netdev)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> +       struct acc_core *core =3D priv->core;
> +       u32 tx_fifo_status;
> +       u32 ctrl_mode;
> +       int err;
> +
> +       /* Retry to enter RESET mode if out of sync. */
> +       if (priv->can.state !=3D CAN_STATE_STOPPED) {
> +               netdev_warn(netdev, "Entered %s() with bad can.state: %s\=
n",
> +                           __func__, can_get_state_str(priv->can.state))=
;
> +               acc_resetmode_enter(core);
> +               priv->can.state =3D CAN_STATE_STOPPED;
> +       }
> +
> +       err =3D open_candev(netdev);
> +       if (err)
> +               return err;
> +
> +       ctrl_mode =3D ACC_REG_CONTROL_MASK_IE_RXTX |
> +                       ACC_REG_CONTROL_MASK_IE_TXERROR |
> +                       ACC_REG_CONTROL_MASK_IE_ERRWARN |
> +                       ACC_REG_CONTROL_MASK_IE_OVERRUN |
> +                       ACC_REG_CONTROL_MASK_IE_ERRPASS;
> +
> +       if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
> +               ctrl_mode |=3D ACC_REG_CONTROL_MASK_IE_BUSERR;
> +
> +       if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> +               ctrl_mode |=3D ACC_REG_CONTROL_MASK_MODE_LOM;
> +
> +       acc_set_bits(core, ACC_CORE_OF_CTRL_MODE, ctrl_mode);
> +
> +       acc_resetmode_leave(core);
> +       priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
> +
> +       /* Resync TX FIFO indices to HW state after (re-)start. */
> +       tx_fifo_status =3D acc_read32(core, ACC_CORE_OF_TXFIFO_STATUS);
> +       core->tx_fifo_head =3D tx_fifo_status & 0xff;
> +       core->tx_fifo_tail =3D (tx_fifo_status >> 8) & 0xff;
> +
> +       netif_start_queue(netdev);
> +       return 0;
> +}
> +
> +int acc_close(struct net_device *netdev)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> +       struct acc_core *core =3D priv->core;
> +
> +       acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
> +                      ACC_REG_CONTROL_MASK_IE_RXTX |
> +                      ACC_REG_CONTROL_MASK_IE_TXERROR |
> +                      ACC_REG_CONTROL_MASK_IE_ERRWARN |
> +                      ACC_REG_CONTROL_MASK_IE_OVERRUN |
> +                      ACC_REG_CONTROL_MASK_IE_ERRPASS |
> +                      ACC_REG_CONTROL_MASK_IE_BUSERR);
> +
> +       netif_stop_queue(netdev);
> +       acc_resetmode_enter(core);
> +       priv->can.state =3D CAN_STATE_STOPPED;
> +
> +       /* Mark pending TX requests to be aborted after controller restar=
t. */
> +       acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
> +
> +       /* ACC_REG_CONTROL_MASK_MODE_LOM is only accessible in RESET mode=
 */
> +       acc_clear_bits(core, ACC_CORE_OF_CTRL_MODE,
> +                      ACC_REG_CONTROL_MASK_MODE_LOM);
> +
> +       close_candev(netdev);
> +       return 0;
> +}
> +
> +netdev_tx_t acc_start_xmit(struct sk_buff *skb, struct net_device *netde=
v)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> +       struct acc_core *core =3D priv->core;
> +       struct can_frame *cf =3D (struct can_frame *)skb->data;
> +       u8 tx_fifo_head =3D core->tx_fifo_head;
> +       int fifo_usage;
> +       u32 acc_id;
> +       u8 acc_dlc;
> +
> +       if (can_dropped_invalid_skb(netdev, skb))
> +               return NETDEV_TX_OK;
> +
> +       /* Access core->tx_fifo_tail only once because it may be changed
> +        * from the interrupt level.
> +        */
> +       fifo_usage =3D tx_fifo_head - core->tx_fifo_tail;
> +       if (fifo_usage < 0)
> +               fifo_usage +=3D core->tx_fifo_size;
> +
> +       if (fifo_usage >=3D core->tx_fifo_size - 1) {
> +               netdev_err(core->netdev,
> +                          "BUG: TX ring full when queue awake!\n");
> +               netif_stop_queue(netdev);
> +               return NETDEV_TX_BUSY;
> +       }
> +
> +       if (fifo_usage =3D=3D core->tx_fifo_size - 2)
> +               netif_stop_queue(netdev);
> +
> +       acc_dlc =3D can_get_cc_dlc(cf, priv->can.ctrlmode);
> +       if (cf->can_id & CAN_RTR_FLAG)
> +               acc_dlc |=3D ACC_DLC_RTR_FLAG;
> +
> +       if (cf->can_id & CAN_EFF_FLAG) {
> +               acc_id =3D cf->can_id & CAN_EFF_MASK;
> +               acc_id |=3D ACC_ID_EFF_FLAG;
> +       } else {
> +               acc_id =3D cf->can_id & CAN_SFF_MASK;
> +       }
> +
> +       can_put_echo_skb(skb, netdev, core->tx_fifo_head, 0);
> +
> +       core->tx_fifo_head =3D acc_tx_fifo_next(core, tx_fifo_head);
> +
> +       acc_txq_put(core, acc_id, acc_dlc, cf->data);
> +
> +       return NETDEV_TX_OK;
> +}
> +
> +int acc_get_berr_counter(const struct net_device *netdev,
> +                        struct can_berr_counter *bec)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> +       u32 core_status =3D acc_read32(priv->core, ACC_CORE_OF_STATUS);
> +
> +       bec->txerr =3D (core_status >> 8) & 0xff;
> +       bec->rxerr =3D core_status & 0xff;
> +
> +       return 0;
> +}
> +
> +int acc_set_mode(struct net_device *netdev, enum can_mode mode)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> +
> +       switch (mode) {
> +       case CAN_MODE_START:
> +               /* Paranoid FIFO index check. */
> +               {
> +                       const u32 tx_fifo_status =3D
> +                               acc_read32(priv->core, ACC_CORE_OF_TXFIFO=
_STATUS);
> +                       const u8 hw_fifo_head =3D tx_fifo_status;
> +
> +                       if (hw_fifo_head !=3D priv->core->tx_fifo_head ||
> +                           hw_fifo_head !=3D priv->core->tx_fifo_tail) {
> +                               netdev_warn(netdev,
> +                                           "TX FIFO mismatch: T %2u H %2=
u; TFHW %#08x\n",
> +                                           priv->core->tx_fifo_tail,
> +                                           priv->core->tx_fifo_head,
> +                                           tx_fifo_status);
> +                       }
> +               }
> +               acc_resetmode_leave(priv->core);
> +               /* To leave the bus-off state the esdACC controller begin=
s
> +                * here a grace period where it counts 128 "idle conditio=
ns" (each
> +                * of 11 consecutive recessive bits) on the bus as requir=
ed
> +                * by the CAN spec.
> +                *
> +                * During this time the TX FIFO may still contain already
> +                * aborted "zombie" frames that are only drained from the=
 FIFO
> +                * at the end of the grace period.
> +                *
> +                * To not to interfere with this drain process we don't
> +                * call netif_wake_queue() here. When the controller reac=
hes
> +                * the error-active state again, it informs us about that
> +                * with an acc_bmmsg_errstatechange message. Then
> +                * netif_wake_queue() is called from
> +                * handle_core_msg_errstatechange() instead.
> +                */
> +               break;
> +
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +int acc_set_bittiming(struct net_device *netdev)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(netdev);
> +       const struct can_bittiming *bt =3D &priv->can.bittiming;
> +       u32 brp;
> +       u32 btr;
> +
> +       if (priv->ov->features & ACC_OV_REG_FEAT_MASK_CANFD) {
> +               u32 fbtr =3D 0;
> +
> +               netdev_dbg(netdev, "bit timing: brp %u, prop %u, ph1 %u p=
h2 %u, sjw %u\n",
> +                          bt->brp, bt->prop_seg,
> +                          bt->phase_seg1, bt->phase_seg2, bt->sjw);
> +
> +               brp =3D FIELD_PREP(ACC_REG_BRP_FD_MASK_BRP, bt->brp - 1);
> +
> +               btr =3D FIELD_PREP(ACC_REG_BTR_FD_MASK_TSEG1, bt->phase_s=
eg1 + bt->prop_seg - 1);
> +               btr |=3D FIELD_PREP(ACC_REG_BTR_FD_MASK_TSEG2, bt->phase_=
seg2 - 1);
> +               btr |=3D FIELD_PREP(ACC_REG_BTR_FD_MASK_SJW, bt->sjw - 1)=
;
> +
> +               /* Keep order of accesses to ACC_CORE_OF_BRP and ACC_CORE=
_OF_BTR. */
> +               acc_write32(priv->core, ACC_CORE_OF_BRP, brp);
> +               acc_write32(priv->core, ACC_CORE_OF_BTR, btr);
> +
> +               netdev_dbg(netdev, "esdACC: BRP %u, NBTR 0x%08x, DBTR 0x%=
08x",
> +                          brp, btr, fbtr);
> +       } else {
> +               netdev_dbg(netdev, "bit timing: brp %u, prop %u, ph1 %u p=
h2 %u, sjw %u\n",
> +                          bt->brp, bt->prop_seg,
> +                          bt->phase_seg1, bt->phase_seg2, bt->sjw);
> +
> +               brp =3D FIELD_PREP(ACC_REG_BRP_CL_MASK_BRP, bt->brp - 1);
> +
> +               btr =3D FIELD_PREP(ACC_REG_BTR_CL_MASK_TSEG1, bt->phase_s=
eg1 + bt->prop_seg - 1);
> +               btr |=3D FIELD_PREP(ACC_REG_BTR_CL_MASK_TSEG2, bt->phase_=
seg2 - 1);
> +               btr |=3D FIELD_PREP(ACC_REG_BTR_CL_MASK_SJW, bt->sjw - 1)=
;
> +
> +               /* Keep order of accesses to ACC_CORE_OF_BRP and ACC_CORE=
_OF_BTR. */
> +               acc_write32(priv->core, ACC_CORE_OF_BRP, brp);
> +               acc_write32(priv->core, ACC_CORE_OF_BTR, btr);
> +
> +               netdev_dbg(netdev, "esdACC: BRP %u, BTR 0x%08x", brp, btr=
);
> +       }
> +
> +       return 0;
> +}
> +
> +static void handle_core_msg_rxtxdone(struct acc_core *core,
> +                                    const struct acc_bmmsg_rxtxdone *msg=
)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> +       struct net_device_stats *stats =3D &core->netdev->stats;
> +       struct sk_buff *skb;
> +
> +       if (msg->acc_dlc.len & ACC_DLC_TXD_FLAG) {
> +               u8 tx_fifo_tail =3D core->tx_fifo_tail;
> +
> +               if (core->tx_fifo_head =3D=3D tx_fifo_tail) {
> +                       netdev_warn(core->netdev,
> +                                   "TX interrupt, but queue is empty!?\n=
");
> +                       return;
> +               }
> +
> +               /* Direct access echo skb to attach HW time stamp. */
> +               skb =3D priv->can.echo_skb[tx_fifo_tail];
> +               if (skb) {
> +                       skb_hwtstamps(skb)->hwtstamp =3D
> +                               acc_ts2ktime(priv->ov, msg->ts);
> +               }
> +
> +               stats->tx_packets++;
> +               stats->tx_bytes +=3D can_get_echo_skb(core->netdev, tx_fi=
fo_tail,
> +                                                   NULL);
> +
> +               core->tx_fifo_tail =3D acc_tx_fifo_next(core, tx_fifo_tai=
l);
> +
> +               netif_wake_queue(core->netdev);
> +
> +       } else {
> +               struct can_frame *cf;
> +
> +               skb =3D alloc_can_skb(core->netdev, &cf);
> +               if (!skb) {
> +                       stats->rx_dropped++;
> +                       return;
> +               }
> +
> +               cf->can_id =3D msg->id & ACC_ID_ID_MASK;
> +               if (msg->id & ACC_ID_EFF_FLAG)
> +                       cf->can_id |=3D CAN_EFF_FLAG;
> +
> +               can_frame_set_cc_len(cf, msg->acc_dlc.len & ACC_DLC_DLC_M=
ASK,
> +                                    priv->can.ctrlmode);
> +
> +               if (msg->acc_dlc.len & ACC_DLC_RTR_FLAG) {
> +                       cf->can_id |=3D CAN_RTR_FLAG;
> +               } else {
> +                       memcpy(cf->data, msg->data, cf->len);
> +                       stats->rx_bytes +=3D cf->len;
> +               }
> +               stats->rx_packets++;
> +
> +               skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->ov, m=
sg->ts);
> +
> +               netif_rx(skb);
> +       }
> +}
> +
> +static void handle_core_msg_txabort(struct acc_core *core,
> +                                   const struct acc_bmmsg_txabort *msg)
> +{
> +       struct net_device_stats *stats =3D &core->netdev->stats;
> +       u8 tx_fifo_tail =3D core->tx_fifo_tail;
> +       u32 abort_mask =3D msg->abort_mask;   /* u32 extend to avoid warn=
ings later */
> +
> +       /* The abort_mask shows which frames were aborted in esdACC's FIF=
O. */
> +       while (tx_fifo_tail !=3D core->tx_fifo_head && (abort_mask)) {
> +               const u32 tail_mask =3D (1U << tx_fifo_tail);
> +
> +               if (!(abort_mask & tail_mask))
> +                       break;
> +               abort_mask &=3D ~tail_mask;
> +
> +               can_free_echo_skb(core->netdev, tx_fifo_tail, NULL);
> +               stats->tx_dropped++;
> +               stats->tx_aborted_errors++;
> +
> +               tx_fifo_tail =3D acc_tx_fifo_next(core, tx_fifo_tail);
> +       }
> +       core->tx_fifo_tail =3D tx_fifo_tail;
> +       if (abort_mask)
> +               netdev_warn(core->netdev, "Unhandled aborted messages\n")=
;
> +
> +       if (!acc_resetmode_entered(core))
> +               netif_wake_queue(core->netdev);
> +}
> +
> +static void handle_core_msg_overrun(struct acc_core *core,
> +                                   const struct acc_bmmsg_overrun *msg)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> +       struct net_device_stats *stats =3D &core->netdev->stats;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +
> +       /* lost_cnt may be 0 if not supported by esdACC version */
> +       if (msg->lost_cnt) {
> +               stats->rx_errors +=3D msg->lost_cnt;
> +               stats->rx_over_errors +=3D msg->lost_cnt;
> +       } else {
> +               stats->rx_errors++;
> +               stats->rx_over_errors++;
> +       }
> +
> +       skb =3D alloc_can_err_skb(core->netdev, &cf);
> +       if (!skb)
> +               return;
> +
> +       cf->can_id |=3D CAN_ERR_CRTL;
> +       cf->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> +
> +       skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->ov, msg->ts);
> +
> +       netif_rx(skb);
> +}
> +
> +static void handle_core_msg_buserr(struct acc_core *core,
> +                                  const struct acc_bmmsg_buserr *msg)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> +       struct net_device_stats *stats =3D &core->netdev->stats;
> +       struct can_frame *cf;
> +       struct sk_buff *skb;
> +       const u32 reg_status =3D msg->reg_status;
> +       const u8 rxerr =3D reg_status;
> +       const u8 txerr =3D (reg_status >> 8);
> +       u8 can_err_prot_type =3D 0U;
> +
> +       priv->can.can_stats.bus_error++;
> +
> +       /* Error occurred during transmission? */
> +       if (msg->ecc & ACC_ECC_DIR) {
> +               stats->rx_errors++;
> +       } else {
> +               can_err_prot_type |=3D CAN_ERR_PROT_TX;
> +               stats->tx_errors++;
> +       }
> +       /* Determine error type */
> +       switch (msg->ecc & ACC_ECC_MASK) {
> +       case ACC_ECC_BIT:
> +               can_err_prot_type |=3D CAN_ERR_PROT_BIT;
> +               break;
> +       case ACC_ECC_FORM:
> +               can_err_prot_type |=3D CAN_ERR_PROT_FORM;
> +               break;
> +       case ACC_ECC_STUFF:
> +               can_err_prot_type |=3D CAN_ERR_PROT_STUFF;
> +               break;
> +       default:
> +               can_err_prot_type |=3D CAN_ERR_PROT_UNSPEC;
> +               break;
> +       }
> +
> +       skb =3D alloc_can_err_skb(core->netdev, &cf);
> +       if (!skb)
> +               return;
> +
> +       cf->can_id |=3D CAN_ERR_PROT | CAN_ERR_BUSERROR | CAN_ERR_CNT;
> +
> +       /* Set protocol error type */
> +       cf->data[2] =3D can_err_prot_type;
> +       /* Set error location */
> +       cf->data[3] =3D msg->ecc & ACC_ECC_SEG;
> +
> +       /* Insert CAN TX and RX error counters. */
> +       cf->data[6] =3D txerr;
> +       cf->data[7] =3D rxerr;
> +
> +       skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->ov, msg->ts);
> +
> +       netif_rx(skb);
> +}
> +
> +static void
> +handle_core_msg_errstatechange(struct acc_core *core,
> +                              const struct acc_bmmsg_errstatechange *msg=
)
> +{
> +       struct acc_net_priv *priv =3D netdev_priv(core->netdev);
> +       struct can_frame *cf =3D NULL;
> +       struct sk_buff *skb;
> +       const u32 reg_status =3D msg->reg_status;
> +       const u8 rxerr =3D reg_status;
> +       const u8 txerr =3D (reg_status >> 8);
> +       enum can_state new_state;
> +
> +       if (reg_status & ACC_REG_STATUS_MASK_STATUS_BS) {
> +               new_state =3D CAN_STATE_BUS_OFF;
> +       } else if (reg_status & ACC_REG_STATUS_MASK_STATUS_EP) {
> +               new_state =3D CAN_STATE_ERROR_PASSIVE;
> +       } else if (reg_status & ACC_REG_STATUS_MASK_STATUS_ES) {
> +               new_state =3D CAN_STATE_ERROR_WARNING;
> +       } else {
> +               new_state =3D CAN_STATE_ERROR_ACTIVE;
> +               if (priv->can.state =3D=3D CAN_STATE_BUS_OFF) {
> +                       /* See comment in acc_set_mode() for CAN_MODE_STA=
RT */
> +                       netif_wake_queue(core->netdev);
> +               }
> +       }
> +
> +       skb =3D alloc_can_err_skb(core->netdev, &cf);
> +
> +       if (new_state !=3D priv->can.state) {
> +               enum can_state tx_state, rx_state;
> +
> +               tx_state =3D (txerr >=3D rxerr) ?
> +                       new_state : CAN_STATE_ERROR_ACTIVE;
> +               rx_state =3D (rxerr >=3D txerr) ?
> +                       new_state : CAN_STATE_ERROR_ACTIVE;
> +
> +               /* Always call can_change_state() to update the state
> +                * even if alloc_can_err_skb() may have failed.
> +                * can_change_state() can cope with a NULL cf pointer.
> +                */
> +               can_change_state(core->netdev, cf, tx_state, rx_state);
> +       }
> +
> +       if (skb) {
> +               cf->can_id |=3D CAN_ERR_CNT;
> +               cf->data[6] =3D txerr;
> +               cf->data[7] =3D rxerr;
> +
> +               skb_hwtstamps(skb)->hwtstamp =3D acc_ts2ktime(priv->ov, m=
sg->ts);
> +
> +               netif_rx(skb);
> +       }
> +
> +       if (new_state =3D=3D CAN_STATE_BUS_OFF) {
> +               acc_write32(core, ACC_CORE_OF_TX_ABORT_MASK, 0xffff);
> +               can_bus_off(core->netdev);
> +       }
> +}
> +
> +static void handle_core_interrupt(struct acc_core *core)
> +{
> +       u32 msg_fifo_head =3D core->bmfifo.local_irq_cnt & 0xff;
> +
> +       while (core->bmfifo.msg_fifo_tail !=3D msg_fifo_head) {
> +               const union acc_bmmsg *msg =3D
> +                       &core->bmfifo.messages[core->bmfifo.msg_fifo_tail=
];
> +
> +               switch (msg->msg_id) {
> +               case BM_MSG_ID_RXTXDONE:
> +                       handle_core_msg_rxtxdone(core, &msg->rxtxdone);
> +                       break;
> +
> +               case BM_MSG_ID_TXABORT:
> +                       handle_core_msg_txabort(core, &msg->txabort);
> +                       break;
> +
> +               case BM_MSG_ID_OVERRUN:
> +                       handle_core_msg_overrun(core, &msg->overrun);
> +                       break;
> +
> +               case BM_MSG_ID_BUSERR:
> +                       handle_core_msg_buserr(core, &msg->buserr);
> +                       break;
> +
> +               case BM_MSG_ID_ERRPASSIVE:
> +               case BM_MSG_ID_ERRWARN:
> +                       handle_core_msg_errstatechange(core,
> +                                                      &msg->errstatechan=
ge);
> +                       break;
> +
> +               default:
> +                       /* Ignore all other BM messages (like the CAN-FD =
messages) */
> +                       break;
> +               }
> +
> +               core->bmfifo.msg_fifo_tail =3D
> +                               (core->bmfifo.msg_fifo_tail + 1) & 0xff;
> +       }
> +}
> +
> +/**
> + * acc_card_interrupt() - handle the interrupts of an esdACC FPGA
> + *
> + * @ov: overview module structure
> + * @cores: array of core structures
> + *
> + * This function handles all interrupts pending for the overview module =
and the
> + * CAN cores of the esdACC FPGA.
> + *
> + * It examines for all cores (the overview module core and the CAN cores=
)
> + * the bmfifo.irq_cnt and compares it with the previously saved
> + * bmfifo.local_irq_cnt. An IRQ is pending if they differ. The esdACC FP=
GA
> + * updates the bmfifo.irq_cnt values by DMA.
> + *
> + * The pending interrupts are masked by writing to the IRQ mask register=
 at
> + * ACC_OV_OF_BM_IRQ_MASK. This register has for each core a two bit comm=
and
> + * field evaluated as follows:
> + *
> + * Define,   bit pattern: meaning
> + *                    00: no action
> + * ACC_BM_IRQ_UNMASK, 01: unmask interrupt
> + * ACC_BM_IRQ_MASK,   10: mask interrupt
> + *                    11: no action

Nitpick: consider this format

 *  Define              bit pattern     meaning
 * ------------------------------------------------------
 *                      00              no action
 *  ACC_BM_IRQ_UNMASK   01              unmask interrupt
 *  ACC_BM_IRQ_MASK     10              mask interrupt
 *                      11              no action

(I am using spaces due to a limitation of my email client, you can use
tab instead)

> + * For each CAN core with a pending IRQ handle_core_interrupt() handles =
all
> + * busmaster messages from the message FIFO. The last handled message (F=
IFO
> + * index) is written to the CAN core to acknowledge its handling.
> + *
> + * Last step is to unmask all interrupts in the FPGA using
> + * ACC_BM_IRQ_UNMASK_ALL.
> + *
> + * Return:
> + *     IRQ_HANDLED, if card generated an interrupt that was handled
> + *     IRQ_NONE, if the interrupt is not ours
> + */
> +irqreturn_t acc_card_interrupt(struct acc_ov *ov, struct acc_core *cores=
)
> +{
> +       u32 irqmask;
> +       int i;
> +
> +       /* First we look for whom interrupts are pending, card/overview
> +        * or any of the cores. Two bits in irqmask are used for each;
> +        * Each two bit field is set to ACC_BM_IRQ_MASK if an IRQ is
> +        * pending.
> +        */
> +       irqmask =3D 0U;
> +       if (READ_ONCE(*ov->bmfifo.irq_cnt) !=3D ov->bmfifo.local_irq_cnt)=
 {
> +               irqmask |=3D ACC_BM_IRQ_MASK;
> +               ov->bmfifo.local_irq_cnt =3D READ_ONCE(*ov->bmfifo.irq_cn=
t);
> +       }
> +
> +       for (i =3D 0; i < ov->active_cores; i++) {
> +               struct acc_core *core =3D &cores[i];
> +
> +               if (READ_ONCE(*core->bmfifo.irq_cnt) !=3D core->bmfifo.lo=
cal_irq_cnt) {
> +                       irqmask |=3D (ACC_BM_IRQ_MASK << (2 * (i + 1)));
> +                       core->bmfifo.local_irq_cnt =3D READ_ONCE(*core->b=
mfifo.irq_cnt);
> +               }
> +       }
> +
> +       if (!irqmask)
> +               return IRQ_NONE;
> +
> +       /* At second we tell the card we're working on them by writing ir=
qmask,
> +        * call handle_{ov|core}_interrupt and then acknowledge the
> +        * interrupts by writing irq_cnt:
> +        */
> +       acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_MASK, irqmask);
> +
> +       if (irqmask & ACC_BM_IRQ_MASK) {
> +               /* handle_ov_interrupt(); - no use yet. */
> +               acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_COUNTER,
> +                              ov->bmfifo.local_irq_cnt);
> +       }
> +
> +       for (i =3D 0; i < ov->active_cores; i++) {
> +               struct acc_core *core =3D &cores[i];
> +
> +               if (irqmask & (ACC_BM_IRQ_MASK << (2 * (i + 1)))) {
> +                       handle_core_interrupt(core);
> +                       acc_write32(core, ACC_OV_OF_BM_IRQ_COUNTER,
> +                                   core->bmfifo.local_irq_cnt);
> +               }
> +       }
> +
> +       acc_ov_write32(ov, ACC_OV_OF_BM_IRQ_MASK, ACC_BM_IRQ_UNMASK_ALL);
> +
> +       return IRQ_HANDLED;
> +}

(...)

Yours sincerely,
Vincent Mailhol
