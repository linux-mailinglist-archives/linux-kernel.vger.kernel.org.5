Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D0B7621FB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjGYTCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 15:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGYTCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 15:02:52 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02F7E2;
        Tue, 25 Jul 2023 12:02:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso8981780e87.2;
        Tue, 25 Jul 2023 12:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690311769; x=1690916569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ+zD+lQYJ687dfJcdLlEcIu144gHbrt/w0O5zbvv0A=;
        b=ZA5VcxPPnk7kJuJwRUaOvZlRsaiG8QXNU7+YEXiO6hsAbqBje6zfkQu3llko9X32CU
         fP1ZBsxIIA8RI+S67mscbpbMl8KA3ZaposAHxotJj+jq8OgpzNfQD8Wc1R+/3IiZ39U9
         tpUOVoSunv+wN0+P4jFyDNUHSzBRDh5ma7yU+UhwnAiSwKZ9h7JVu1eqFUz8gDs5aA9i
         Ee2VXgVqbXNaivMcNJzx0ETB0MlFrYHg7uHBTmsmp4NLBy3t375WeFk2zfbZYfBCSq6C
         E7FrjU4i8r2e8S2bv5vh/LdOpdJHiwqHsOp93881dVu119cCHNvmkgdAD8Lope5c4yem
         TnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690311769; x=1690916569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZ+zD+lQYJ687dfJcdLlEcIu144gHbrt/w0O5zbvv0A=;
        b=B6VJiTl0RID9x3vhHJm7GcmaSqnlqfIfyLm+GihBcMWjrlDCKvTxDKYYuansiYRRBQ
         aNse4n9ixJV/UXn3WkM1ZGu0MGWbePcK/5ZB73gn6tMAM5F9e5bKgIksZ5jVTAiRTy/z
         mpVefKJdb8PJubKA70OP3vSmMJZ8pqiaYUamtR6qbPGNivOYBCSxSK+OYbTBdHAmxiA+
         RqMS4ehdJ2Z/4q6X0Qpb/LWhqzYClQSXtWWSYBO9EgXM/qPTzgB5KpF1Hca9qbqWkwk3
         OaMw2bjONCbrZfb93WnLpBqv8gX5RYT4QSuw7i/J3kr4r8A5rqKGMEbOXcuwl0yMC9Hz
         n8Bw==
X-Gm-Message-State: ABy/qLZqCJ3Bh5GaLGTfQmH+O/nU1PvUl+WfLLIAhSTMNX8KUFFDdZyi
        CM+lErWaa50O+zp4WkyqsjKxpNEDLucRZ7AOTIcG+wFqeTs=
X-Google-Smtp-Source: APBJJlG6hnVqkiDDWIHNBLR/pQ9FWQuIA/Op8Bj3+yz4OUxxhiG06uxsNvPMCwtXiLTF/Tz/4Bf0R+O6Ac/Mem6cFlc=
X-Received: by 2002:a2e:9914:0:b0:2b9:45ad:88b1 with SMTP id
 v20-20020a2e9914000000b002b945ad88b1mr9094733lji.2.1690311768905; Tue, 25 Jul
 2023 12:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230724111206.3067352-1-howardchung@google.com>
 <CABBYNZ+UrWFNULhn8Nu79rvS-NZ4Rt4X4y=s+-DHEwjfKuX8Gg@mail.gmail.com>
 <CAPHZWUejzqz5=tHPwib6gfSjcd6K90dyfw8m_3CgaLqjdYRa3A@mail.gmail.com>
 <CABBYNZ+BbNQr6-RbXABF0TeUUgBuoVUABqwfkfHgHkZ09vyY4Q@mail.gmail.com> <CAPHZWUfh2kPDA+_wtEisw85NwHwDik0A60Dc7zKwVur+SeqTOQ@mail.gmail.com>
In-Reply-To: <CAPHZWUfh2kPDA+_wtEisw85NwHwDik0A60Dc7zKwVur+SeqTOQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 25 Jul 2023 12:02:36 -0700
Message-ID: <CABBYNZ+StoKG2EMFgyJqAeiJPzWeizSWdg69pvV1NLNoWfSXsw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yun-hao,

On Tue, Jul 25, 2023 at 12:33=E2=80=AFAM Yun-hao Chung <howardchung@google.=
com> wrote:
>
> On Tue, Jul 25, 2023 at 2:05=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Yun-hao,
> >
> > On Mon, Jul 24, 2023 at 9:56=E2=80=AFPM Yun-hao Chung <howardchung@goog=
le.com> wrote:
> > >
> > > Thanks Paul for the review. I'll fix them in the next patch.
> > >
> > > Hi Luiz,
> > >
> > > I think the controller did reset its internal state in the link layer=
, so the next time we asked the controller to create a connection to the sa=
me remote, the controller didn't reply the error in the command complete ev=
ent but the connection was rejected by the remote. If we really want the co=
ntroller to complete the disconnect procedure on reset, the power-off proce=
dure could be stuck for tens of seconds if the remote was not responding. A=
 similar problem was found and solved in this patch [Bluetooth: hci_sync: D=
on't wait peer's reply when powering off].
> > >
> > > The other reason why we think this is better to be solved in the soft=
ware layer is this is not only observed in Intel's AX211 but also MTK's MT7=
921 and maybe more.
> >
> > Interesting, but in this case shouldn't the link-layer attempt to
> > cleanup _before_ it reset the state? Because as far I recall doing a
> > HCI_Reset shall cause a Disconnection even if not initiated by the
> > host stack with HCI_Disconnect, also there is something really odd
> > with the fact that the link-layer is generating such an error, because
> > in case that happens isn't it clear the states are out of sync and it
> > shall disconnect or something, I'm also curious what would happen if
> > one quickly toggle power then the same problem should manifest, at
> > least I don't see a difference between HCI_Reset and power off/on
> > within the connection supervision timeout.
>
> Do you think it's better to do this instead: Set HCI Supervision
> timeout with a configurable or just a small value and then it's more
> safe to wait for disconnect complete because the result should be
> returned within the supervision timeout.
> In this way, we don't need the controller to do a graceful
> disconnection on HCI_Reset and the controller state won't be
> out-of-sync.

I think it is worth trying at least, not sure if we won't get into the
same situation as to wait for the command to complete though, anyway
the default of supervision timeout is something like 20 seconds which
is way too long compared to our command timeout.

> >
> > > Since this is a tradeoff problem, I make it a configurable parameter =
so that each user can decide a good number from their perspective. If it is=
 0, which is the default value, the behavior should remain the same.
> > >
> > > Do you think this sounds good to you?
> > >
> > > Thanks,
> > > Howard
> > >
> > >
> > >
> > >
> > >
> > >
> > > On Tue, Jul 25, 2023 at 6:31=E2=80=AFAM Luiz Augusto von Dentz <luiz.=
dentz@gmail.com> wrote:
> > >>
> > >> Hi Howard,
> > >>
> > >> On Mon, Jul 24, 2023 at 4:12=E2=80=AFAM Howard Chung <howardchung@go=
ogle.com> wrote:
> > >> >
> > >> > For some controllers, it is known that when the HCI disconnect and=
 HCI
> > >> > Reset are too close to each other, the LMP disconnect command migh=
t not
> > >> > been sent out yet and the command will be dropped by the controole=
r when
> > >> > it is asked to reset itself. This could happen on powering off ada=
pter.
> > >> >
> > >> > One possible issue is that if a connection exists, and then poweri=
ng off
> > >> > and on adapter within a short time, then our host stack assumes th=
e
> > >> > conntection was disconnected but this might not be true, so if we =
issue
> > >> > a connection to the peer, it will fail with ACL Already Connected =
error.
> > >>
> > >> That sounds more like a bug in the controller though, the spec is
> > >> quite clear that it must reset the link-layer state:
> > >>
> > >> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> > >> page 1972
> > >>
> > >> ...HCI_Reset command shall reset the Link Manager, Baseband and Link=
 Layer.
> > >>
> > >> So it sounds like the controller shall perform and the necessary
> > >> procedures before it respond with a Command Complete.
> > >>
> > >> > This CL makes the host stack to wait for |HCI_EV_DISCONN_COMPLETE|=
 when
> > >> > powering off with a configurable timeout unless the timeout is set=
 to 0.
> > >> >
> > >> > Reviewed-by: Archie Pusaka <apusaka@google.com>
> > >> > Signed-off-by: Howard Chung <howardchung@google.com>
> > >> > ---
> > >> > Hi upstream maintainers, this is tested with an AX211 device and L=
ogi
> > >> > K580 keyboard by the following procedures:
> > >> > 1. pair the peer and stay connected.
> > >> > 2. power off and on immediately
> > >> > 3. observe that the btsnoop log is consistent with the configured
> > >> >    timeout.
> > >> >
> > >> >  include/net/bluetooth/hci_core.h |  1 +
> > >> >  net/bluetooth/hci_core.c         |  2 +-
> > >> >  net/bluetooth/hci_sync.c         | 38 +++++++++++++++++++++++----=
-----
> > >> >  net/bluetooth/mgmt_config.c      |  6 +++++
> > >> >  4 files changed, 35 insertions(+), 12 deletions(-)
> > >> >
> > >> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/blueto=
oth/hci_core.h
> > >> > index 8200a6689b39..ce44f9c60059 100644
> > >> > --- a/include/net/bluetooth/hci_core.h
> > >> > +++ b/include/net/bluetooth/hci_core.h
> > >> > @@ -432,6 +432,7 @@ struct hci_dev {
> > >> >         __u16           advmon_allowlist_duration;
> > >> >         __u16           advmon_no_filter_duration;
> > >> >         __u8            enable_advmon_interleave_scan;
> > >> > +       __u16           discon_on_poweroff_timeout;
> > >> >
> > >> >         __u16           devid_source;
> > >> >         __u16           devid_vendor;
> > >> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > >> > index 0fefa6788911..769865494f45 100644
> > >> > --- a/net/bluetooth/hci_core.c
> > >> > +++ b/net/bluetooth/hci_core.c
> > >> > @@ -2479,7 +2479,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeo=
f_priv)
> > >> >         hdev->adv_instance_cnt =3D 0;
> > >> >         hdev->cur_adv_instance =3D 0x00;
> > >> >         hdev->adv_instance_timeout =3D 0;
> > >> > -
> > >> > +       hdev->discon_on_poweroff_timeout =3D 0;   /* Default to no=
 timeout */
> > >> >         hdev->advmon_allowlist_duration =3D 300;
> > >> >         hdev->advmon_no_filter_duration =3D 500;
> > >> >         hdev->enable_advmon_interleave_scan =3D 0x00;     /* Defau=
lt to disable */
> > >> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > >> > index 3348a1b0e3f7..260e9f05359c 100644
> > >> > --- a/net/bluetooth/hci_sync.c
> > >> > +++ b/net/bluetooth/hci_sync.c
> > >> > @@ -5250,6 +5250,8 @@ static int hci_disconnect_sync(struct hci_de=
v *hdev, struct hci_conn *conn,
> > >> >                                u8 reason)
> > >> >  {
> > >> >         struct hci_cp_disconnect cp;
> > >> > +       unsigned long timeout;
> > >> > +       int err;
> > >> >
> > >> >         if (conn->type =3D=3D AMP_LINK)
> > >> >                 return hci_disconnect_phy_link_sync(hdev, conn->ha=
ndle, reason);
> > >> > @@ -5258,19 +5260,33 @@ static int hci_disconnect_sync(struct hci_=
dev *hdev, struct hci_conn *conn,
> > >> >         cp.handle =3D cpu_to_le16(conn->handle);
> > >> >         cp.reason =3D reason;
> > >> >
> > >> > -       /* Wait for HCI_EV_DISCONN_COMPLETE, not HCI_EV_CMD_STATUS=
, when the
> > >> > -        * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This=
 reason is
> > >> > -        * used when suspending or powering off, where we don't wa=
nt to wait
> > >> > -        * for the peer's response.
> > >> > +       /* The HCI_ERROR_REMOTE_POWER_OFF is used when suspending =
or powering off,
> > >> > +        * so we don't want to waste time waiting for the reply of=
 the peer.
> > >> > +        * However, if the configuration specified, we'll wait som=
e time to give the
> > >> > +        * controller chance to actually send the disconnect comma=
nd.
> > >> >          */
> > >> > -       if (reason !=3D HCI_ERROR_REMOTE_POWER_OFF)
> > >> > -               return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCO=
NNECT,
> > >> > -                                               sizeof(cp), &cp,
> > >> > -                                               HCI_EV_DISCONN_COM=
PLETE,
> > >> > -                                               HCI_CMD_TIMEOUT, N=
ULL);
> > >> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF && !hdev->dis=
con_on_poweroff_timeout) {
> > >> > +               return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNE=
CT,
> > >> > +                                            sizeof(cp), &cp, HCI_=
CMD_TIMEOUT);
> > >> > +       }
> > >> >
> > >> > -       return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT, size=
of(cp), &cp,
> > >> > -                                    HCI_CMD_TIMEOUT);
> > >> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> > >> > +               timeout =3D msecs_to_jiffies(hdev->discon_on_power=
off_timeout);
> > >> > +       else
> > >> > +               timeout =3D HCI_CMD_TIMEOUT;
> > >> > +
> > >> > +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
> > >> > +                                      sizeof(cp), &cp,
> > >> > +                                      HCI_EV_DISCONN_COMPLETE,
> > >> > +                                      timeout, NULL);
> > >> > +
> > >> > +       /* Ignore the error in suspending or powering off case to =
avoid the procedure being
> > >> > +        * aborted.
> > >> > +        */
> > >> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> > >> > +               return 0;
> > >> > +
> > >> > +       return err;
> > >> >  }
> > >> >
> > >> >  static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
> > >> > diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_conf=
ig.c
> > >> > index 6ef701c27da4..f3194e3642d9 100644
> > >> > --- a/net/bluetooth/mgmt_config.c
> > >> > +++ b/net/bluetooth/mgmt_config.c
> > >> > @@ -78,6 +78,7 @@ int read_def_system_config(struct sock *sk, stru=
ct hci_dev *hdev, void *data,
> > >> >                 HDEV_PARAM_U16(advmon_allowlist_duration);
> > >> >                 HDEV_PARAM_U16(advmon_no_filter_duration);
> > >> >                 HDEV_PARAM_U8(enable_advmon_interleave_scan);
> > >> > +               HDEV_PARAM_U16(discon_on_poweroff_timeout);
> > >> >         } __packed rp =3D {
> > >> >                 TLV_SET_U16(0x0000, def_page_scan_type),
> > >> >                 TLV_SET_U16(0x0001, def_page_scan_int),
> > >> > @@ -111,6 +112,7 @@ int read_def_system_config(struct sock *sk, st=
ruct hci_dev *hdev, void *data,
> > >> >                 TLV_SET_U16(0x001d, advmon_allowlist_duration),
> > >> >                 TLV_SET_U16(0x001e, advmon_no_filter_duration),
> > >> >                 TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
> > >> > +               TLV_SET_U16(0x0020, discon_on_poweroff_timeout),
> > >> >         };
> > >> >
> > >> >         bt_dev_dbg(hdev, "sock %p", sk);
> > >> > @@ -186,6 +188,7 @@ int set_def_system_config(struct sock *sk, str=
uct hci_dev *hdev, void *data,
> > >> >                 case 0x001b:
> > >> >                 case 0x001d:
> > >> >                 case 0x001e:
> > >> > +               case 0x0020:
> > >> >                         exp_type_len =3D sizeof(u16);
> > >> >                         break;
> > >> >                 case 0x001f:
> > >> > @@ -314,6 +317,9 @@ int set_def_system_config(struct sock *sk, str=
uct hci_dev *hdev, void *data,
> > >> >                 case 0x0001f:
> > >> >                         hdev->enable_advmon_interleave_scan =3D TL=
V_GET_U8(buffer);
> > >> >                         break;
> > >> > +               case 0x00020:
> > >> > +                       hdev->discon_on_poweroff_timeout =3D TLV_G=
ET_LE16(buffer);
> > >> > +                       break;
> > >> >                 default:
> > >> >                         bt_dev_warn(hdev, "unsupported parameter %=
u", type);
> > >> >                         break;
> > >> > --
> > >> > 2.41.0.487.g6d72f3e995-goog
> > >> >
> > >>
> > >>
> > >> --
> > >> Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
