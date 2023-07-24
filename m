Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE076024B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGXWb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:31:25 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7114110D;
        Mon, 24 Jul 2023 15:31:23 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b935316214so61528441fa.1;
        Mon, 24 Jul 2023 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690237882; x=1690842682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hyLFD9WDuFUoUwZ/OsjIvbcM065C9QMvLj1zUBG6gSs=;
        b=D8lWwBjBGAMzsHFRYBQ6rpF6OZp/H8askSMoajc/eyDhinGEKNAMmn6S35DJLfbVk3
         O/gNf+3UzyRYxYLe/Oh5VbDFAtc3VRS2P2rAGkPdc5sn1hBXPWwrnUO1Ec+DGHw3N7Mh
         9cTdFGxggt7lvsZl7vgRVH0qEuanzThS13cGa1OnquvyUmUHie3Sw2Xgvo+5DII9UVgw
         mvexL5Ikm5J40zETtVUzkh0mmEteTAEgStzt28I4mfKrzcDuiXa6olS5vymqsL6FESSp
         lVk3gde9A+VUniMEzRYfk58xEmxZ5sNxiTQ31VZGI/TGNLRMURXw81nTtw79qutQvnme
         ynyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690237882; x=1690842682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hyLFD9WDuFUoUwZ/OsjIvbcM065C9QMvLj1zUBG6gSs=;
        b=FRkWgTSZmylNdTGOvtQnXmzitWp6Dzuw8oATXuJyzbwp+/w+F684yb/ggNa2+yOxJ+
         /AuvnH1OK1U1ogQaIbtuNu777JVH3r4Cp5jsMsyPQrBym0fkXdAlj3rM7Tcz+iibF3PE
         Gek983/m0k7F1lkH/L77gfbnrFhJ5pg4lpp1l4ANYrDUOSHrS6VE3sdAAd0o7v1lq212
         wrMpihjT6lTzzlXZ8XqwiuazB/XCzHRgON2ljgt4Nv36HdgxscP5/aBtrqqj68xBguOh
         0kA2wspMMBfhcRtYcZvrwoEJun/7pUfft4+EbU9baO4a1hIWfPUoiY/XeH1iTgvvEpz3
         IDHQ==
X-Gm-Message-State: ABy/qLZcSzyVzaAYfL3QNKiSgfdJfLsKjTUc3DKCP21fAEKCkDtMPw5y
        gFsnr/2tqhm4HLTXD0yTDRGPw5Ux0QJr3d9J5yc=
X-Google-Smtp-Source: APBJJlH3RgcI+9OcZhDB3VBSHeLKnLdw/X5RT0kz+ivy2QJy6uHCoki8/0N9tEvZhMi1gQdkhw/J1cjNP9fMwsLtO40=
X-Received: by 2002:a2e:98c7:0:b0:2b6:d47f:2a4 with SMTP id
 s7-20020a2e98c7000000b002b6d47f02a4mr245042ljj.13.1690237881392; Mon, 24 Jul
 2023 15:31:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230724111206.3067352-1-howardchung@google.com>
In-Reply-To: <20230724111206.3067352-1-howardchung@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Jul 2023 15:31:08 -0700
Message-ID: <CABBYNZ+UrWFNULhn8Nu79rvS-NZ4Rt4X4y=s+-DHEwjfKuX8Gg@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Add timeout in disconnect when power off
To:     Howard Chung <howardchung@google.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        Archie Pusaka <apusaka@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Howard,

On Mon, Jul 24, 2023 at 4:12=E2=80=AFAM Howard Chung <howardchung@google.co=
m> wrote:
>
> For some controllers, it is known that when the HCI disconnect and HCI
> Reset are too close to each other, the LMP disconnect command might not
> been sent out yet and the command will be dropped by the controoler when
> it is asked to reset itself. This could happen on powering off adapter.
>
> One possible issue is that if a connection exists, and then powering off
> and on adapter within a short time, then our host stack assumes the
> conntection was disconnected but this might not be true, so if we issue
> a connection to the peer, it will fail with ACL Already Connected error.

That sounds more like a bug in the controller though, the spec is
quite clear that it must reset the link-layer state:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 1972

...HCI_Reset command shall reset the Link Manager, Baseband and Link Layer.

So it sounds like the controller shall perform and the necessary
procedures before it respond with a Command Complete.

> This CL makes the host stack to wait for |HCI_EV_DISCONN_COMPLETE| when
> powering off with a configurable timeout unless the timeout is set to 0.
>
> Reviewed-by: Archie Pusaka <apusaka@google.com>
> Signed-off-by: Howard Chung <howardchung@google.com>
> ---
> Hi upstream maintainers, this is tested with an AX211 device and Logi
> K580 keyboard by the following procedures:
> 1. pair the peer and stay connected.
> 2. power off and on immediately
> 3. observe that the btsnoop log is consistent with the configured
>    timeout.
>
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_core.c         |  2 +-
>  net/bluetooth/hci_sync.c         | 38 +++++++++++++++++++++++---------
>  net/bluetooth/mgmt_config.c      |  6 +++++
>  4 files changed, 35 insertions(+), 12 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 8200a6689b39..ce44f9c60059 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -432,6 +432,7 @@ struct hci_dev {
>         __u16           advmon_allowlist_duration;
>         __u16           advmon_no_filter_duration;
>         __u8            enable_advmon_interleave_scan;
> +       __u16           discon_on_poweroff_timeout;
>
>         __u16           devid_source;
>         __u16           devid_vendor;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0fefa6788911..769865494f45 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2479,7 +2479,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
>         hdev->adv_instance_cnt =3D 0;
>         hdev->cur_adv_instance =3D 0x00;
>         hdev->adv_instance_timeout =3D 0;
> -
> +       hdev->discon_on_poweroff_timeout =3D 0;   /* Default to no timeou=
t */
>         hdev->advmon_allowlist_duration =3D 300;
>         hdev->advmon_no_filter_duration =3D 500;
>         hdev->enable_advmon_interleave_scan =3D 0x00;     /* Default to d=
isable */
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 3348a1b0e3f7..260e9f05359c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5250,6 +5250,8 @@ static int hci_disconnect_sync(struct hci_dev *hdev=
, struct hci_conn *conn,
>                                u8 reason)
>  {
>         struct hci_cp_disconnect cp;
> +       unsigned long timeout;
> +       int err;
>
>         if (conn->type =3D=3D AMP_LINK)
>                 return hci_disconnect_phy_link_sync(hdev, conn->handle, r=
eason);
> @@ -5258,19 +5260,33 @@ static int hci_disconnect_sync(struct hci_dev *hd=
ev, struct hci_conn *conn,
>         cp.handle =3D cpu_to_le16(conn->handle);
>         cp.reason =3D reason;
>
> -       /* Wait for HCI_EV_DISCONN_COMPLETE, not HCI_EV_CMD_STATUS, when =
the
> -        * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This reason=
 is
> -        * used when suspending or powering off, where we don't want to w=
ait
> -        * for the peer's response.
> +       /* The HCI_ERROR_REMOTE_POWER_OFF is used when suspending or powe=
ring off,
> +        * so we don't want to waste time waiting for the reply of the pe=
er.
> +        * However, if the configuration specified, we'll wait some time =
to give the
> +        * controller chance to actually send the disconnect command.
>          */
> -       if (reason !=3D HCI_ERROR_REMOTE_POWER_OFF)
> -               return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
> -                                               sizeof(cp), &cp,
> -                                               HCI_EV_DISCONN_COMPLETE,
> -                                               HCI_CMD_TIMEOUT, NULL);
> +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF && !hdev->discon_on_=
poweroff_timeout) {
> +               return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT,
> +                                            sizeof(cp), &cp, HCI_CMD_TIM=
EOUT);
> +       }
>
> -       return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT, sizeof(cp),=
 &cp,
> -                                    HCI_CMD_TIMEOUT);
> +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> +               timeout =3D msecs_to_jiffies(hdev->discon_on_poweroff_tim=
eout);
> +       else
> +               timeout =3D HCI_CMD_TIMEOUT;
> +
> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
> +                                      sizeof(cp), &cp,
> +                                      HCI_EV_DISCONN_COMPLETE,
> +                                      timeout, NULL);
> +
> +       /* Ignore the error in suspending or powering off case to avoid t=
he procedure being
> +        * aborted.
> +        */
> +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> +               return 0;
> +
> +       return err;
>  }
>
>  static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index 6ef701c27da4..f3194e3642d9 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -78,6 +78,7 @@ int read_def_system_config(struct sock *sk, struct hci_=
dev *hdev, void *data,
>                 HDEV_PARAM_U16(advmon_allowlist_duration);
>                 HDEV_PARAM_U16(advmon_no_filter_duration);
>                 HDEV_PARAM_U8(enable_advmon_interleave_scan);
> +               HDEV_PARAM_U16(discon_on_poweroff_timeout);
>         } __packed rp =3D {
>                 TLV_SET_U16(0x0000, def_page_scan_type),
>                 TLV_SET_U16(0x0001, def_page_scan_int),
> @@ -111,6 +112,7 @@ int read_def_system_config(struct sock *sk, struct hc=
i_dev *hdev, void *data,
>                 TLV_SET_U16(0x001d, advmon_allowlist_duration),
>                 TLV_SET_U16(0x001e, advmon_no_filter_duration),
>                 TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
> +               TLV_SET_U16(0x0020, discon_on_poweroff_timeout),
>         };
>
>         bt_dev_dbg(hdev, "sock %p", sk);
> @@ -186,6 +188,7 @@ int set_def_system_config(struct sock *sk, struct hci=
_dev *hdev, void *data,
>                 case 0x001b:
>                 case 0x001d:
>                 case 0x001e:
> +               case 0x0020:
>                         exp_type_len =3D sizeof(u16);
>                         break;
>                 case 0x001f:
> @@ -314,6 +317,9 @@ int set_def_system_config(struct sock *sk, struct hci=
_dev *hdev, void *data,
>                 case 0x0001f:
>                         hdev->enable_advmon_interleave_scan =3D TLV_GET_U=
8(buffer);
>                         break;
> +               case 0x00020:
> +                       hdev->discon_on_poweroff_timeout =3D TLV_GET_LE16=
(buffer);
> +                       break;
>                 default:
>                         bt_dev_warn(hdev, "unsupported parameter %u", typ=
e);
>                         break;
> --
> 2.41.0.487.g6d72f3e995-goog
>


--=20
Luiz Augusto von Dentz
