Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7936B7609FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGYGFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGYGFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:05:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4798310F8;
        Mon, 24 Jul 2023 23:05:23 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so77329541fa.0;
        Mon, 24 Jul 2023 23:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690265121; x=1690869921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDYIM0MJdY9Z0BK3/d93KgfnCK5eRHOV40ZWEqugoL4=;
        b=EZuNtsbRID7acfxRCUGJyKiSFPzEE/kHt14Oa/lcgefXfQswerX8J7xPhJa5AN9oZc
         ReT2LlcTdqugmHln2/oLKRTrlmIVu28ktD+37CYaKnbTVgsF52KQkqSVp5m9p9hRjKpQ
         Nc/UxcGAiePK06aT4CYpERXrDz86VjzNptNJ+ihvX9kRic8RMfAopk/ER3E2FLqxdT1Q
         eTvfzjNZ4NJ3mi+DSs8YJSmaNq7BMxW/zQ/EC0Vfze6L+kqXI9RKZz+iR7cO++fwcnfx
         x4G+5zsoWw0fUf8lvNRcv5Kz+xH+GrFtpYLBbV/Muz5GjO230gB3d7WV+LoZv7QG21YJ
         7+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690265121; x=1690869921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDYIM0MJdY9Z0BK3/d93KgfnCK5eRHOV40ZWEqugoL4=;
        b=FwwPeceCZmch8vAEt92mLWqTFAy5vKn4DH80ThJFwYwX5ofNvPmg2vwgwq/R8ZRzKD
         R7l9krlbhcS47xu1IURZPWOw2ttW0lsLKmzM+FD6y6i72rGDw2o0jauARkusLPgRagtR
         y4C9W+izwwMViM/RBNhsZOpeFLsrzpv57ADP+H8O+dTB1j7sdomL5yWX+BCwZj4ZekRh
         lBqTvLUgdw5OOjB6jHuV5q0Nu1ps+/e1NUC4PmM6SZ/uU1BgoJgLbIiqTjugzVycRGUC
         Yg5avo0lTYSkqsO3LuYZdbzQ8xU6SDkBs5ZK1uh5OLtv6acBmyLds3K+HZpBpuGsVe8k
         ylMQ==
X-Gm-Message-State: ABy/qLYaAj58VS5dftg+7Mpngm+0u0KeLkifmuwKlQyv9akcL8ia0tzH
        Zsni2tpYQCLHbrWjnILDmyaDwByzRC3RPjcYNj7Ul1+9tog=
X-Google-Smtp-Source: APBJJlFI7o5x6Tk6HK4glLYba+8+mA+YNUlbd+fD5fNkkfxsNETERKxQ9cg1g7qNtPXtwmlXh6J3ShRxWfmB/363qCg=
X-Received: by 2002:a05:651c:389:b0:2b6:98c2:6378 with SMTP id
 e9-20020a05651c038900b002b698c26378mr569034ljp.2.1690265121011; Mon, 24 Jul
 2023 23:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230724111206.3067352-1-howardchung@google.com>
 <CABBYNZ+UrWFNULhn8Nu79rvS-NZ4Rt4X4y=s+-DHEwjfKuX8Gg@mail.gmail.com> <CAPHZWUejzqz5=tHPwib6gfSjcd6K90dyfw8m_3CgaLqjdYRa3A@mail.gmail.com>
In-Reply-To: <CAPHZWUejzqz5=tHPwib6gfSjcd6K90dyfw8m_3CgaLqjdYRa3A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Jul 2023 23:05:08 -0700
Message-ID: <CABBYNZ+BbNQr6-RbXABF0TeUUgBuoVUABqwfkfHgHkZ09vyY4Q@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Add timeout in disconnect when power off
To:     Yun-hao Chung <howardchung@google.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yun-hao,

On Mon, Jul 24, 2023 at 9:56=E2=80=AFPM Yun-hao Chung <howardchung@google.c=
om> wrote:
>
> Thanks Paul for the review. I'll fix them in the next patch.
>
> Hi Luiz,
>
> I think the controller did reset its internal state in the link layer, so=
 the next time we asked the controller to create a connection to the same r=
emote, the controller didn't reply the error in the command complete event =
but the connection was rejected by the remote. If we really want the contro=
ller to complete the disconnect procedure on reset, the power-off procedure=
 could be stuck for tens of seconds if the remote was not responding. A sim=
ilar problem was found and solved in this patch [Bluetooth: hci_sync: Don't=
 wait peer's reply when powering off].
>
> The other reason why we think this is better to be solved in the software=
 layer is this is not only observed in Intel's AX211 but also MTK's MT7921 =
and maybe more.

Interesting, but in this case shouldn't the link-layer attempt to
cleanup _before_ it reset the state? Because as far I recall doing a
HCI_Reset shall cause a Disconnection even if not initiated by the
host stack with HCI_Disconnect, also there is something really odd
with the fact that the link-layer is generating such an error, because
in case that happens isn't it clear the states are out of sync and it
shall disconnect or something, I'm also curious what would happen if
one quickly toggle power then the same problem should manifest, at
least I don't see a difference between HCI_Reset and power off/on
within the connection supervision timeout.

> Since this is a tradeoff problem, I make it a configurable parameter so t=
hat each user can decide a good number from their perspective. If it is 0, =
which is the default value, the behavior should remain the same.
>
> Do you think this sounds good to you?
>
> Thanks,
> Howard
>
>
>
>
>
>
> On Tue, Jul 25, 2023 at 6:31=E2=80=AFAM Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:
>>
>> Hi Howard,
>>
>> On Mon, Jul 24, 2023 at 4:12=E2=80=AFAM Howard Chung <howardchung@google=
.com> wrote:
>> >
>> > For some controllers, it is known that when the HCI disconnect and HCI
>> > Reset are too close to each other, the LMP disconnect command might no=
t
>> > been sent out yet and the command will be dropped by the controoler wh=
en
>> > it is asked to reset itself. This could happen on powering off adapter=
.
>> >
>> > One possible issue is that if a connection exists, and then powering o=
ff
>> > and on adapter within a short time, then our host stack assumes the
>> > conntection was disconnected but this might not be true, so if we issu=
e
>> > a connection to the peer, it will fail with ACL Already Connected erro=
r.
>>
>> That sounds more like a bug in the controller though, the spec is
>> quite clear that it must reset the link-layer state:
>>
>> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>> page 1972
>>
>> ...HCI_Reset command shall reset the Link Manager, Baseband and Link Lay=
er.
>>
>> So it sounds like the controller shall perform and the necessary
>> procedures before it respond with a Command Complete.
>>
>> > This CL makes the host stack to wait for |HCI_EV_DISCONN_COMPLETE| whe=
n
>> > powering off with a configurable timeout unless the timeout is set to =
0.
>> >
>> > Reviewed-by: Archie Pusaka <apusaka@google.com>
>> > Signed-off-by: Howard Chung <howardchung@google.com>
>> > ---
>> > Hi upstream maintainers, this is tested with an AX211 device and Logi
>> > K580 keyboard by the following procedures:
>> > 1. pair the peer and stay connected.
>> > 2. power off and on immediately
>> > 3. observe that the btsnoop log is consistent with the configured
>> >    timeout.
>> >
>> >  include/net/bluetooth/hci_core.h |  1 +
>> >  net/bluetooth/hci_core.c         |  2 +-
>> >  net/bluetooth/hci_sync.c         | 38 +++++++++++++++++++++++--------=
-
>> >  net/bluetooth/mgmt_config.c      |  6 +++++
>> >  4 files changed, 35 insertions(+), 12 deletions(-)
>> >
>> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h
>> > index 8200a6689b39..ce44f9c60059 100644
>> > --- a/include/net/bluetooth/hci_core.h
>> > +++ b/include/net/bluetooth/hci_core.h
>> > @@ -432,6 +432,7 @@ struct hci_dev {
>> >         __u16           advmon_allowlist_duration;
>> >         __u16           advmon_no_filter_duration;
>> >         __u8            enable_advmon_interleave_scan;
>> > +       __u16           discon_on_poweroff_timeout;
>> >
>> >         __u16           devid_source;
>> >         __u16           devid_vendor;
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index 0fefa6788911..769865494f45 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -2479,7 +2479,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_pr=
iv)
>> >         hdev->adv_instance_cnt =3D 0;
>> >         hdev->cur_adv_instance =3D 0x00;
>> >         hdev->adv_instance_timeout =3D 0;
>> > -
>> > +       hdev->discon_on_poweroff_timeout =3D 0;   /* Default to no tim=
eout */
>> >         hdev->advmon_allowlist_duration =3D 300;
>> >         hdev->advmon_no_filter_duration =3D 500;
>> >         hdev->enable_advmon_interleave_scan =3D 0x00;     /* Default t=
o disable */
>> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> > index 3348a1b0e3f7..260e9f05359c 100644
>> > --- a/net/bluetooth/hci_sync.c
>> > +++ b/net/bluetooth/hci_sync.c
>> > @@ -5250,6 +5250,8 @@ static int hci_disconnect_sync(struct hci_dev *h=
dev, struct hci_conn *conn,
>> >                                u8 reason)
>> >  {
>> >         struct hci_cp_disconnect cp;
>> > +       unsigned long timeout;
>> > +       int err;
>> >
>> >         if (conn->type =3D=3D AMP_LINK)
>> >                 return hci_disconnect_phy_link_sync(hdev, conn->handle=
, reason);
>> > @@ -5258,19 +5260,33 @@ static int hci_disconnect_sync(struct hci_dev =
*hdev, struct hci_conn *conn,
>> >         cp.handle =3D cpu_to_le16(conn->handle);
>> >         cp.reason =3D reason;
>> >
>> > -       /* Wait for HCI_EV_DISCONN_COMPLETE, not HCI_EV_CMD_STATUS, wh=
en the
>> > -        * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This rea=
son is
>> > -        * used when suspending or powering off, where we don't want t=
o wait
>> > -        * for the peer's response.
>> > +       /* The HCI_ERROR_REMOTE_POWER_OFF is used when suspending or p=
owering off,
>> > +        * so we don't want to waste time waiting for the reply of the=
 peer.
>> > +        * However, if the configuration specified, we'll wait some ti=
me to give the
>> > +        * controller chance to actually send the disconnect command.
>> >          */
>> > -       if (reason !=3D HCI_ERROR_REMOTE_POWER_OFF)
>> > -               return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNEC=
T,
>> > -                                               sizeof(cp), &cp,
>> > -                                               HCI_EV_DISCONN_COMPLET=
E,
>> > -                                               HCI_CMD_TIMEOUT, NULL)=
;
>> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF && !hdev->discon_=
on_poweroff_timeout) {
>> > +               return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT,
>> > +                                            sizeof(cp), &cp, HCI_CMD_=
TIMEOUT);
>> > +       }
>> >
>> > -       return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT, sizeof(c=
p), &cp,
>> > -                                    HCI_CMD_TIMEOUT);
>> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
>> > +               timeout =3D msecs_to_jiffies(hdev->discon_on_poweroff_=
timeout);
>> > +       else
>> > +               timeout =3D HCI_CMD_TIMEOUT;
>> > +
>> > +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
>> > +                                      sizeof(cp), &cp,
>> > +                                      HCI_EV_DISCONN_COMPLETE,
>> > +                                      timeout, NULL);
>> > +
>> > +       /* Ignore the error in suspending or powering off case to avoi=
d the procedure being
>> > +        * aborted.
>> > +        */
>> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
>> > +               return 0;
>> > +
>> > +       return err;
>> >  }
>> >
>> >  static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
>> > diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
>> > index 6ef701c27da4..f3194e3642d9 100644
>> > --- a/net/bluetooth/mgmt_config.c
>> > +++ b/net/bluetooth/mgmt_config.c
>> > @@ -78,6 +78,7 @@ int read_def_system_config(struct sock *sk, struct h=
ci_dev *hdev, void *data,
>> >                 HDEV_PARAM_U16(advmon_allowlist_duration);
>> >                 HDEV_PARAM_U16(advmon_no_filter_duration);
>> >                 HDEV_PARAM_U8(enable_advmon_interleave_scan);
>> > +               HDEV_PARAM_U16(discon_on_poweroff_timeout);
>> >         } __packed rp =3D {
>> >                 TLV_SET_U16(0x0000, def_page_scan_type),
>> >                 TLV_SET_U16(0x0001, def_page_scan_int),
>> > @@ -111,6 +112,7 @@ int read_def_system_config(struct sock *sk, struct=
 hci_dev *hdev, void *data,
>> >                 TLV_SET_U16(0x001d, advmon_allowlist_duration),
>> >                 TLV_SET_U16(0x001e, advmon_no_filter_duration),
>> >                 TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
>> > +               TLV_SET_U16(0x0020, discon_on_poweroff_timeout),
>> >         };
>> >
>> >         bt_dev_dbg(hdev, "sock %p", sk);
>> > @@ -186,6 +188,7 @@ int set_def_system_config(struct sock *sk, struct =
hci_dev *hdev, void *data,
>> >                 case 0x001b:
>> >                 case 0x001d:
>> >                 case 0x001e:
>> > +               case 0x0020:
>> >                         exp_type_len =3D sizeof(u16);
>> >                         break;
>> >                 case 0x001f:
>> > @@ -314,6 +317,9 @@ int set_def_system_config(struct sock *sk, struct =
hci_dev *hdev, void *data,
>> >                 case 0x0001f:
>> >                         hdev->enable_advmon_interleave_scan =3D TLV_GE=
T_U8(buffer);
>> >                         break;
>> > +               case 0x00020:
>> > +                       hdev->discon_on_poweroff_timeout =3D TLV_GET_L=
E16(buffer);
>> > +                       break;
>> >                 default:
>> >                         bt_dev_warn(hdev, "unsupported parameter %u", =
type);
>> >                         break;
>> > --
>> > 2.41.0.487.g6d72f3e995-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
