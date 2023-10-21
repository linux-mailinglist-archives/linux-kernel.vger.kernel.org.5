Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C67D1DCC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjJUPGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJUPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:06:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB370E7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:06:23 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9c496c114so118465ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697900783; x=1698505583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRjoNCM5H4ZT/KccokCTei8MLExcpIHGSolwggkp3kM=;
        b=gERfVvhqNT85dnqbrdU0SGcBMkV6S+aqMVD3JQAgxoVaxhIR0VWLluD9TRKUl2rQew
         Uw3r+MjP1CRlY1RI7g6IgfT/l2R58YfYa+hKuEjo6IRkBtPTIrkHBjbrj6ib6e9Tpjlc
         AEl4Vi/VClGvqqI4oY9YovbITLEvuznB7d6oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697900783; x=1698505583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aRjoNCM5H4ZT/KccokCTei8MLExcpIHGSolwggkp3kM=;
        b=bUWabeZpIBx08YQ1ZT4jlCaRVsmUzf4koxSJIq7faWhM4n+3sXBj7Xv+UQ7+j0lxE1
         Fak9ZuZ1bDqfuTIY4t5Pt0N8wuHkI5iqu4rWgzKf9Cgl65CdFXT5xuK23UTRz3blc15+
         aaIFzXhUWfxbNPbhgBlopERDO2lQgGjdR0YH61hvdlRexW3FLQi1BtlGjADn6AbRUcg3
         G2MHLn+LYuLTggSiuq9zbQ2cJwYJ0ligOdsH4WCYzZp45HGH2Xs1xKLD5tIwUHW3O4I6
         hFSc6bJ+WEWwD2UZCpb+2DcyR2fnZA/GTPcryoxhMTFTV5Jk4txEDDFR/mCg+tEVDDTU
         7HAA==
X-Gm-Message-State: AOJu0Yyd4tQDOLxqpnuCd9putwy35IKaPFw6y32RaW8IK0hYSZ66X8V4
        mspTWCi3zPfxeGFttLKwNLYz/H+sQ7lBpef4dP0V2A==
X-Google-Smtp-Source: AGHT+IF70eDf+F49f2+NWLLu2I7mxYoVTKxM+jyKBqOroY7YNbe+YaNHeZC0aMleXk7s2NEh10ABzG/B1UM3jGdF0AY=
X-Received: by 2002:a17:902:f60b:b0:1ca:84b4:68fd with SMTP id
 n11-20020a170902f60b00b001ca84b468fdmr388691plg.12.1697900782768; Sat, 21 Oct
 2023 08:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.7.Iaacab4e73761e7bd9bb622b30a804c5d20bd5b4c@changeid>
In-Reply-To: <20231020140655.v5.7.Iaacab4e73761e7bd9bb622b30a804c5d20bd5b4c@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 08:06:11 -0700
Message-ID: <CANEJEGsBxMq92F6vgYw73aLPVabj8ZuBybbSe9xjE3ORSYq1-w@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] r8152: Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> Whenever the RTL8152_UNPLUG is set that just tells the driver that all
> accesses will fail and we should just immediately bail. A future patch
> will use this same concept at a time when the driver hasn't actually
> been unplugged but is about to be reset. Rename the flag in
> preparation for the future patch.
>
> This is a no-op change and just a search and replace.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - ("Rename RTL8152_UNPLUG to RTL8152_INACCESSIBLE") new for v2.
>
>  drivers/net/usb/r8152.c | 96 ++++++++++++++++++++---------------------
>  1 file changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 982f9ca03e7a..65232848b31d 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -764,7 +764,7 @@ enum rtl_register_content {
>
>  /* rtl8152 flags */
>  enum rtl8152_flags {
> -       RTL8152_UNPLUG =3D 0,
> +       RTL8152_INACCESSIBLE =3D 0,
>         RTL8152_SET_RX_MODE,
>         WORK_ENABLE,
>         RTL8152_LINK_CHG,
> @@ -1245,7 +1245,7 @@ int set_registers(struct r8152 *tp, u16 value, u16 =
index, u16 size, void *data)
>  static void rtl_set_unplug(struct r8152 *tp)
>  {
>         if (tp->udev->state =3D=3D USB_STATE_NOTATTACHED) {
> -               set_bit(RTL8152_UNPLUG, &tp->flags);
> +               set_bit(RTL8152_INACCESSIBLE, &tp->flags);
>                 smp_mb__after_atomic();
>         }
>  }
> @@ -1256,7 +1256,7 @@ static int generic_ocp_read(struct r8152 *tp, u16 i=
ndex, u16 size,
>         u16 limit =3D 64;
>         int ret =3D 0;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         /* both size and indix must be 4 bytes align */
> @@ -1300,7 +1300,7 @@ static int generic_ocp_write(struct r8152 *tp, u16 =
index, u16 byteen,
>         u16 byteen_start, byteen_end, byen;
>         u16 limit =3D 512;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         /* both size and indix must be 4 bytes align */
> @@ -1537,7 +1537,7 @@ static int read_mii_word(struct net_device *netdev,=
 int phy_id, int reg)
>         struct r8152 *tp =3D netdev_priv(netdev);
>         int ret;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         if (phy_id !=3D R8152_PHY_ID)
> @@ -1553,7 +1553,7 @@ void write_mii_word(struct net_device *netdev, int =
phy_id, int reg, int val)
>  {
>         struct r8152 *tp =3D netdev_priv(netdev);
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         if (phy_id !=3D R8152_PHY_ID)
> @@ -1758,7 +1758,7 @@ static void read_bulk_callback(struct urb *urb)
>         if (!tp)
>                 return;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         if (!test_bit(WORK_ENABLE, &tp->flags))
> @@ -1850,7 +1850,7 @@ static void write_bulk_callback(struct urb *urb)
>         if (!test_bit(WORK_ENABLE, &tp->flags))
>                 return;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         if (!skb_queue_empty(&tp->tx_queue))
> @@ -1871,7 +1871,7 @@ static void intr_callback(struct urb *urb)
>         if (!test_bit(WORK_ENABLE, &tp->flags))
>                 return;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         switch (status) {
> @@ -2615,7 +2615,7 @@ static void bottom_half(struct tasklet_struct *t)
>  {
>         struct r8152 *tp =3D from_tasklet(tp, t, tx_tl);
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         if (!test_bit(WORK_ENABLE, &tp->flags))
> @@ -2658,7 +2658,7 @@ int r8152_submit_rx(struct r8152 *tp, struct rx_agg=
 *agg, gfp_t mem_flags)
>         int ret;
>
>         /* The rx would be stopped, so skip submitting */
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags) ||
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) ||
>             !test_bit(WORK_ENABLE, &tp->flags) || !netif_carrier_ok(tp->n=
etdev))
>                 return 0;
>
> @@ -3058,7 +3058,7 @@ static int rtl_enable(struct r8152 *tp)
>
>  static int rtl8152_enable(struct r8152 *tp)
>  {
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         set_tx_qlen(tp);
> @@ -3145,7 +3145,7 @@ static int rtl8153_enable(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         set_tx_qlen(tp);
> @@ -3177,7 +3177,7 @@ static void rtl_disable(struct r8152 *tp)
>         u32 ocp_data;
>         int i;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
>                 rtl_drop_queued_tx(tp);
>                 return;
>         }
> @@ -3631,7 +3631,7 @@ static u16 r8153_phy_status(struct r8152 *tp, u16 d=
esired)
>                 }
>
>                 msleep(20);
> -               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                         break;
>         }
>
> @@ -3663,7 +3663,7 @@ static void r8153b_ups_en(struct r8152 *tp, bool en=
able)
>                         int i;
>
>                         for (i =3D 0; i < 500; i++) {
> -                               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +                               if (test_bit(RTL8152_INACCESSIBLE, &tp->f=
lags))
>                                         return;
>                                 if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_B=
OOT_CTRL) &
>                                     AUTOLOAD_DONE)
> @@ -3705,7 +3705,7 @@ static void r8153c_ups_en(struct r8152 *tp, bool en=
able)
>                         int i;
>
>                         for (i =3D 0; i < 500; i++) {
> -                               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +                               if (test_bit(RTL8152_INACCESSIBLE, &tp->f=
lags))
>                                         return;
>                                 if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_B=
OOT_CTRL) &
>                                     AUTOLOAD_DONE)
> @@ -4050,8 +4050,8 @@ static int rtl_phy_patch_request(struct r8152 *tp, =
bool request, bool wait)
>         for (i =3D 0; wait && i < 5000; i++) {
>                 u32 ocp_data;
>
> -               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> -                       break;
> +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> +                       return -ENODEV;
>
>                 usleep_range(1000, 2000);
>                 ocp_data =3D ocp_reg_read(tp, OCP_PHY_PATCH_STAT);
> @@ -6009,7 +6009,7 @@ static int rtl8156_enable(struct r8152 *tp)
>         u32 ocp_data;
>         u16 speed;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         r8156_fc_parameter(tp);
> @@ -6067,7 +6067,7 @@ static int rtl8156b_enable(struct r8152 *tp)
>         u32 ocp_data;
>         u16 speed;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         set_tx_qlen(tp);
> @@ -6253,7 +6253,7 @@ static int rtl8152_set_speed(struct r8152 *tp, u8 a=
utoneg, u32 speed, u8 duplex,
>
>  static void rtl8152_up(struct r8152 *tp)
>  {
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8152_aldps_en(tp, false);
> @@ -6263,7 +6263,7 @@ static void rtl8152_up(struct r8152 *tp)
>
>  static void rtl8152_down(struct r8152 *tp)
>  {
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
>                 rtl_drop_queued_tx(tp);
>                 return;
>         }
> @@ -6278,7 +6278,7 @@ static void rtl8153_up(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153_u1u2en(tp, false);
> @@ -6318,7 +6318,7 @@ static void rtl8153_down(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
>                 rtl_drop_queued_tx(tp);
>                 return;
>         }
> @@ -6339,7 +6339,7 @@ static void rtl8153b_up(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153b_u1u2en(tp, false);
> @@ -6363,7 +6363,7 @@ static void rtl8153b_down(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
>                 rtl_drop_queued_tx(tp);
>                 return;
>         }
> @@ -6400,7 +6400,7 @@ static void rtl8153c_up(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153b_u1u2en(tp, false);
> @@ -6481,7 +6481,7 @@ static void rtl8156_up(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153b_u1u2en(tp, false);
> @@ -6554,7 +6554,7 @@ static void rtl8156_down(struct r8152 *tp)
>  {
>         u32 ocp_data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags)) {
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
>                 rtl_drop_queued_tx(tp);
>                 return;
>         }
> @@ -6692,7 +6692,7 @@ static void rtl_work_func_t(struct work_struct *wor=
k)
>         /* If the device is unplugged or !netif_running(), the workqueue
>          * doesn't need to wake the device, and could return directly.
>          */
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags) || !netif_running(tp->ne=
tdev))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags) || !netif_running(=
tp->netdev))
>                 return;
>
>         if (usb_autopm_get_interface(tp->intf) < 0)
> @@ -6731,7 +6731,7 @@ static void rtl_hw_phy_work_func_t(struct work_stru=
ct *work)
>  {
>         struct r8152 *tp =3D container_of(work, struct r8152, hw_phy_work=
.work);
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         if (usb_autopm_get_interface(tp->intf) < 0)
> @@ -6858,7 +6858,7 @@ static int rtl8152_close(struct net_device *netdev)
>         netif_stop_queue(netdev);
>
>         res =3D usb_autopm_get_interface(tp->intf);
> -       if (res < 0 || test_bit(RTL8152_UNPLUG, &tp->flags)) {
> +       if (res < 0 || test_bit(RTL8152_INACCESSIBLE, &tp->flags)) {
>                 rtl_drop_queued_tx(tp);
>                 rtl_stop_rx(tp);
>         } else {
> @@ -6891,7 +6891,7 @@ static void r8152b_init(struct r8152 *tp)
>         u32 ocp_data;
>         u16 data;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         data =3D r8152_mdio_read(tp, MII_BMCR);
> @@ -6935,7 +6935,7 @@ static void r8153_init(struct r8152 *tp)
>         u16 data;
>         int i;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153_u1u2en(tp, false);
> @@ -6946,7 +6946,7 @@ static void r8153_init(struct r8152 *tp)
>                         break;
>
>                 msleep(20);
> -               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                         break;
>         }
>
> @@ -7075,7 +7075,7 @@ static void r8153b_init(struct r8152 *tp)
>         u16 data;
>         int i;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153b_u1u2en(tp, false);
> @@ -7086,7 +7086,7 @@ static void r8153b_init(struct r8152 *tp)
>                         break;
>
>                 msleep(20);
> -               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                         break;
>         }
>
> @@ -7157,7 +7157,7 @@ static void r8153c_init(struct r8152 *tp)
>         u16 data;
>         int i;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153b_u1u2en(tp, false);
> @@ -7177,7 +7177,7 @@ static void r8153c_init(struct r8152 *tp)
>                         break;
>
>                 msleep(20);
> -               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                         return;
>         }
>
> @@ -8006,7 +8006,7 @@ static void r8156_init(struct r8152 *tp)
>         u16 data;
>         int i;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         ocp_data =3D ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
> @@ -8027,7 +8027,7 @@ static void r8156_init(struct r8152 *tp)
>                         break;
>
>                 msleep(20);
> -               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                         return;
>         }
>
> @@ -8102,7 +8102,7 @@ static void r8156b_init(struct r8152 *tp)
>         u16 data;
>         int i;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         ocp_data =3D ocp_read_byte(tp, MCU_TYPE_USB, USB_ECM_OP);
> @@ -8136,7 +8136,7 @@ static void r8156b_init(struct r8152 *tp)
>                         break;
>
>                 msleep(20);
> -               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                         return;
>         }
>
> @@ -9165,7 +9165,7 @@ static int rtl8152_ioctl(struct net_device *netdev,=
 struct ifreq *rq, int cmd)
>         struct mii_ioctl_data *data =3D if_mii(rq);
>         int res;
>
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return -ENODEV;
>
>         res =3D usb_autopm_get_interface(tp->intf);
> @@ -9267,7 +9267,7 @@ static const struct net_device_ops rtl8152_netdev_o=
ps =3D {
>
>  static void rtl8152_unload(struct r8152 *tp)
>  {
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         if (tp->version !=3D RTL_VER_01)
> @@ -9276,7 +9276,7 @@ static void rtl8152_unload(struct r8152 *tp)
>
>  static void rtl8153_unload(struct r8152 *tp)
>  {
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153_power_cut_en(tp, false);
> @@ -9284,7 +9284,7 @@ static void rtl8153_unload(struct r8152 *tp)
>
>  static void rtl8153b_unload(struct r8152 *tp)
>  {
> -       if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
>                 return;
>
>         r8153b_power_cut_en(tp, false);
> --
> 2.42.0.758.gaed0368e0e-goog
>
