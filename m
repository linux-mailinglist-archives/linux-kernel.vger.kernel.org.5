Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC89760C02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjGYHfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjGYHeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:34:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181921BD1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:33:47 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40550136e54so232211cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690270426; x=1690875226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRwyW3+mbk6fXtXJFfRXjmT5wtykuSyfrvdH/y+/1HA=;
        b=SUIOUZ/38P4bs1smQKZ9yCv3A/XAxDi6q6gfcrlX1CbpIchvyIoaYEUNY9gMxpf6Fq
         gBeC1XJ1M+vLFl13PAMgLV9JUryA3SOQ2qrvFCkG1XKIf9P+esnsqhibCR3tgo4wPyrd
         QNxPQ897RSJnJZNT62Ua7QNsJ/OMpHaaXZHZGvdyzfkRGM4gbkb2U4p5EMJWZxVf6Rbl
         vG9baSVZq5QyxiYN7iQIK8ox8aPt+vk4w2ORszrRy2RUd8NDwcZZR6BE/lN4c42ZwZE1
         PSXqFJLVp/rjfCpB4Z2hzCKX6HjHXa5/RPtqeJRx1k/AMhQyI2DreoLS77OVOphanQsi
         7sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270426; x=1690875226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRwyW3+mbk6fXtXJFfRXjmT5wtykuSyfrvdH/y+/1HA=;
        b=UaBWgJlXRAYAxk3wRsuAnZUbaJ/tkUFvUGoBKu9Hgz72lfX+w/ZsDwnY8r11NGCqgS
         y08oVDmZB62rqO94GUDgmDg0+PhGAv05r5deTja9Tzqye3XRR6sFMyZIGGEp/iAbYYL9
         9obaUYJiI6V38f3YSOR9LMKNRXQVjJ1LSZUARparR4sYn3PBZnC5WQ8El5nNKxi7pQsn
         VQQqpBkLyOE/enZ1GKG5rBUqcfXhgDhjTr2j4iJfWuyawz9svdaVlvn6GkVaKi11Zamo
         4gBMl9Y2/zVEefcFTDROhY4Nhdf+iwlodmsVotr8Ct0cwSgTLIdyrzEyzx3QbC7GpaP1
         za4Q==
X-Gm-Message-State: ABy/qLYHWNNF69bpmXiFSUH1JwycWT40V326+g56WZTXDXlzCBoudliw
        K7zkWxwKKs0tEQf3PrOMeQ255h7SQFhi4p/yFK8QHA==
X-Google-Smtp-Source: APBJJlFLkxULvYVpKpviqifFl587r4JHp6vFeOLBTcxBDwFSW3u8/JerMFFUstpGop7Wp810W/R6fZaNZX0y5CiH5PE=
X-Received: by 2002:ac8:4e86:0:b0:403:59cb:66c4 with SMTP id
 6-20020ac84e86000000b0040359cb66c4mr65531qtp.23.1690270425985; Tue, 25 Jul
 2023 00:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230724111206.3067352-1-howardchung@google.com>
 <CABBYNZ+UrWFNULhn8Nu79rvS-NZ4Rt4X4y=s+-DHEwjfKuX8Gg@mail.gmail.com>
 <CAPHZWUejzqz5=tHPwib6gfSjcd6K90dyfw8m_3CgaLqjdYRa3A@mail.gmail.com> <CABBYNZ+BbNQr6-RbXABF0TeUUgBuoVUABqwfkfHgHkZ09vyY4Q@mail.gmail.com>
In-Reply-To: <CABBYNZ+BbNQr6-RbXABF0TeUUgBuoVUABqwfkfHgHkZ09vyY4Q@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Tue, 25 Jul 2023 15:33:34 +0800
Message-ID: <CAPHZWUfh2kPDA+_wtEisw85NwHwDik0A60Dc7zKwVur+SeqTOQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Add timeout in disconnect when power off
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 2:05=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yun-hao,
>
> On Mon, Jul 24, 2023 at 9:56=E2=80=AFPM Yun-hao Chung <howardchung@google=
.com> wrote:
> >
> > Thanks Paul for the review. I'll fix them in the next patch.
> >
> > Hi Luiz,
> >
> > I think the controller did reset its internal state in the link layer, =
so the next time we asked the controller to create a connection to the same=
 remote, the controller didn't reply the error in the command complete even=
t but the connection was rejected by the remote. If we really want the cont=
roller to complete the disconnect procedure on reset, the power-off procedu=
re could be stuck for tens of seconds if the remote was not responding. A s=
imilar problem was found and solved in this patch [Bluetooth: hci_sync: Don=
't wait peer's reply when powering off].
> >
> > The other reason why we think this is better to be solved in the softwa=
re layer is this is not only observed in Intel's AX211 but also MTK's MT792=
1 and maybe more.
>
> Interesting, but in this case shouldn't the link-layer attempt to
> cleanup _before_ it reset the state? Because as far I recall doing a
> HCI_Reset shall cause a Disconnection even if not initiated by the
> host stack with HCI_Disconnect, also there is something really odd
> with the fact that the link-layer is generating such an error, because
> in case that happens isn't it clear the states are out of sync and it
> shall disconnect or something, I'm also curious what would happen if
> one quickly toggle power then the same problem should manifest, at
> least I don't see a difference between HCI_Reset and power off/on
> within the connection supervision timeout.

Do you think it's better to do this instead: Set HCI Supervision
timeout with a configurable or just a small value and then it's more
safe to wait for disconnect complete because the result should be
returned within the supervision timeout.
In this way, we don't need the controller to do a graceful
disconnection on HCI_Reset and the controller state won't be
out-of-sync.

>
> > Since this is a tradeoff problem, I make it a configurable parameter so=
 that each user can decide a good number from their perspective. If it is 0=
, which is the default value, the behavior should remain the same.
> >
> > Do you think this sounds good to you?
> >
> > Thanks,
> > Howard
> >
> >
> >
> >
> >
> >
> > On Tue, Jul 25, 2023 at 6:31=E2=80=AFAM Luiz Augusto von Dentz <luiz.de=
ntz@gmail.com> wrote:
> >>
> >> Hi Howard,
> >>
> >> On Mon, Jul 24, 2023 at 4:12=E2=80=AFAM Howard Chung <howardchung@goog=
le.com> wrote:
> >> >
> >> > For some controllers, it is known that when the HCI disconnect and H=
CI
> >> > Reset are too close to each other, the LMP disconnect command might =
not
> >> > been sent out yet and the command will be dropped by the controoler =
when
> >> > it is asked to reset itself. This could happen on powering off adapt=
er.
> >> >
> >> > One possible issue is that if a connection exists, and then powering=
 off
> >> > and on adapter within a short time, then our host stack assumes the
> >> > conntection was disconnected but this might not be true, so if we is=
sue
> >> > a connection to the peer, it will fail with ACL Already Connected er=
ror.
> >>
> >> That sounds more like a bug in the controller though, the spec is
> >> quite clear that it must reset the link-layer state:
> >>
> >> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> >> page 1972
> >>
> >> ...HCI_Reset command shall reset the Link Manager, Baseband and Link L=
ayer.
> >>
> >> So it sounds like the controller shall perform and the necessary
> >> procedures before it respond with a Command Complete.
> >>
> >> > This CL makes the host stack to wait for |HCI_EV_DISCONN_COMPLETE| w=
hen
> >> > powering off with a configurable timeout unless the timeout is set t=
o 0.
> >> >
> >> > Reviewed-by: Archie Pusaka <apusaka@google.com>
> >> > Signed-off-by: Howard Chung <howardchung@google.com>
> >> > ---
> >> > Hi upstream maintainers, this is tested with an AX211 device and Log=
i
> >> > K580 keyboard by the following procedures:
> >> > 1. pair the peer and stay connected.
> >> > 2. power off and on immediately
> >> > 3. observe that the btsnoop log is consistent with the configured
> >> >    timeout.
> >> >
> >> >  include/net/bluetooth/hci_core.h |  1 +
> >> >  net/bluetooth/hci_core.c         |  2 +-
> >> >  net/bluetooth/hci_sync.c         | 38 +++++++++++++++++++++++------=
---
> >> >  net/bluetooth/mgmt_config.c      |  6 +++++
> >> >  4 files changed, 35 insertions(+), 12 deletions(-)
> >> >
> >> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetoot=
h/hci_core.h
> >> > index 8200a6689b39..ce44f9c60059 100644
> >> > --- a/include/net/bluetooth/hci_core.h
> >> > +++ b/include/net/bluetooth/hci_core.h
> >> > @@ -432,6 +432,7 @@ struct hci_dev {
> >> >         __u16           advmon_allowlist_duration;
> >> >         __u16           advmon_no_filter_duration;
> >> >         __u8            enable_advmon_interleave_scan;
> >> > +       __u16           discon_on_poweroff_timeout;
> >> >
> >> >         __u16           devid_source;
> >> >         __u16           devid_vendor;
> >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >> > index 0fefa6788911..769865494f45 100644
> >> > --- a/net/bluetooth/hci_core.c
> >> > +++ b/net/bluetooth/hci_core.c
> >> > @@ -2479,7 +2479,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_=
priv)
> >> >         hdev->adv_instance_cnt =3D 0;
> >> >         hdev->cur_adv_instance =3D 0x00;
> >> >         hdev->adv_instance_timeout =3D 0;
> >> > -
> >> > +       hdev->discon_on_poweroff_timeout =3D 0;   /* Default to no t=
imeout */
> >> >         hdev->advmon_allowlist_duration =3D 300;
> >> >         hdev->advmon_no_filter_duration =3D 500;
> >> >         hdev->enable_advmon_interleave_scan =3D 0x00;     /* Default=
 to disable */
> >> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >> > index 3348a1b0e3f7..260e9f05359c 100644
> >> > --- a/net/bluetooth/hci_sync.c
> >> > +++ b/net/bluetooth/hci_sync.c
> >> > @@ -5250,6 +5250,8 @@ static int hci_disconnect_sync(struct hci_dev =
*hdev, struct hci_conn *conn,
> >> >                                u8 reason)
> >> >  {
> >> >         struct hci_cp_disconnect cp;
> >> > +       unsigned long timeout;
> >> > +       int err;
> >> >
> >> >         if (conn->type =3D=3D AMP_LINK)
> >> >                 return hci_disconnect_phy_link_sync(hdev, conn->hand=
le, reason);
> >> > @@ -5258,19 +5260,33 @@ static int hci_disconnect_sync(struct hci_de=
v *hdev, struct hci_conn *conn,
> >> >         cp.handle =3D cpu_to_le16(conn->handle);
> >> >         cp.reason =3D reason;
> >> >
> >> > -       /* Wait for HCI_EV_DISCONN_COMPLETE, not HCI_EV_CMD_STATUS, =
when the
> >> > -        * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This r=
eason is
> >> > -        * used when suspending or powering off, where we don't want=
 to wait
> >> > -        * for the peer's response.
> >> > +       /* The HCI_ERROR_REMOTE_POWER_OFF is used when suspending or=
 powering off,
> >> > +        * so we don't want to waste time waiting for the reply of t=
he peer.
> >> > +        * However, if the configuration specified, we'll wait some =
time to give the
> >> > +        * controller chance to actually send the disconnect command=
.
> >> >          */
> >> > -       if (reason !=3D HCI_ERROR_REMOTE_POWER_OFF)
> >> > -               return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONN=
ECT,
> >> > -                                               sizeof(cp), &cp,
> >> > -                                               HCI_EV_DISCONN_COMPL=
ETE,
> >> > -                                               HCI_CMD_TIMEOUT, NUL=
L);
> >> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF && !hdev->disco=
n_on_poweroff_timeout) {
> >> > +               return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT=
,
> >> > +                                            sizeof(cp), &cp, HCI_CM=
D_TIMEOUT);
> >> > +       }
> >> >
> >> > -       return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT, sizeof=
(cp), &cp,
> >> > -                                    HCI_CMD_TIMEOUT);
> >> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> >> > +               timeout =3D msecs_to_jiffies(hdev->discon_on_powerof=
f_timeout);
> >> > +       else
> >> > +               timeout =3D HCI_CMD_TIMEOUT;
> >> > +
> >> > +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
> >> > +                                      sizeof(cp), &cp,
> >> > +                                      HCI_EV_DISCONN_COMPLETE,
> >> > +                                      timeout, NULL);
> >> > +
> >> > +       /* Ignore the error in suspending or powering off case to av=
oid the procedure being
> >> > +        * aborted.
> >> > +        */
> >> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> >> > +               return 0;
> >> > +
> >> > +       return err;
> >> >  }
> >> >
> >> >  static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
> >> > diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config=
.c
> >> > index 6ef701c27da4..f3194e3642d9 100644
> >> > --- a/net/bluetooth/mgmt_config.c
> >> > +++ b/net/bluetooth/mgmt_config.c
> >> > @@ -78,6 +78,7 @@ int read_def_system_config(struct sock *sk, struct=
 hci_dev *hdev, void *data,
> >> >                 HDEV_PARAM_U16(advmon_allowlist_duration);
> >> >                 HDEV_PARAM_U16(advmon_no_filter_duration);
> >> >                 HDEV_PARAM_U8(enable_advmon_interleave_scan);
> >> > +               HDEV_PARAM_U16(discon_on_poweroff_timeout);
> >> >         } __packed rp =3D {
> >> >                 TLV_SET_U16(0x0000, def_page_scan_type),
> >> >                 TLV_SET_U16(0x0001, def_page_scan_int),
> >> > @@ -111,6 +112,7 @@ int read_def_system_config(struct sock *sk, stru=
ct hci_dev *hdev, void *data,
> >> >                 TLV_SET_U16(0x001d, advmon_allowlist_duration),
> >> >                 TLV_SET_U16(0x001e, advmon_no_filter_duration),
> >> >                 TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
> >> > +               TLV_SET_U16(0x0020, discon_on_poweroff_timeout),
> >> >         };
> >> >
> >> >         bt_dev_dbg(hdev, "sock %p", sk);
> >> > @@ -186,6 +188,7 @@ int set_def_system_config(struct sock *sk, struc=
t hci_dev *hdev, void *data,
> >> >                 case 0x001b:
> >> >                 case 0x001d:
> >> >                 case 0x001e:
> >> > +               case 0x0020:
> >> >                         exp_type_len =3D sizeof(u16);
> >> >                         break;
> >> >                 case 0x001f:
> >> > @@ -314,6 +317,9 @@ int set_def_system_config(struct sock *sk, struc=
t hci_dev *hdev, void *data,
> >> >                 case 0x0001f:
> >> >                         hdev->enable_advmon_interleave_scan =3D TLV_=
GET_U8(buffer);
> >> >                         break;
> >> > +               case 0x00020:
> >> > +                       hdev->discon_on_poweroff_timeout =3D TLV_GET=
_LE16(buffer);
> >> > +                       break;
> >> >                 default:
> >> >                         bt_dev_warn(hdev, "unsupported parameter %u"=
, type);
> >> >                         break;
> >> > --
> >> > 2.41.0.487.g6d72f3e995-goog
> >> >
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
