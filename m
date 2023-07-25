Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7698E7608F2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjGYFAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGYFAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:00:16 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA210F9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:00:15 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-346099c6f43so69695ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690261215; x=1690866015;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umau7/FwFgOF8m+8m55+/Po+dwxui9pFp9Rfbe/60xE=;
        b=2QryMXryQr5HcL4XhGY+h8umz32mkv+kzR8XzbygSzwDvigz3LeDuPrlNivWuPg3S9
         ULlATc5umWRgMe4cavdqz5dO7BlgDinf93UDpKdlNzuLDg+DgloGVNCTl9ywT3rZgAmd
         c4RYi/bR4K+F4wpfh4e5mPDaatBrUkBVbrqj+znrd5kvbQtJ4b/gchc1cwqRawe92J9X
         /XxvUoGE9dNc0oauE06r60hCJmIhTUqXvbJvwXJM0WznrN3fHLOU5L7U+XLYcksBxKMI
         tiUeYMhN1G0DuGHSBHarQsm2JMxz7Du0rWrqShbzRF5g6TqOK/6DvYnAorhqbFjLWjrF
         at+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690261215; x=1690866015;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umau7/FwFgOF8m+8m55+/Po+dwxui9pFp9Rfbe/60xE=;
        b=KVYaFrFWTJhS4iwNd1hLlDCxGoQfLrYvooX5R1/UDZ5MuWnkQxo2cEjts/TY49AOnC
         sj9AxWO1dx+3s9NTgKSG2/EdxQ3ajpcyyiYudfpnr+p+vQsCMIdoYu9NhkQz6KDzgtIx
         +RQNLZgwLUWxJiS+9J/HHP2SkZQOmNnhzkgnQL6ipjtS+JFZi3GQSZndQCJ5E/5/mvYk
         2nyg3mEeoyLikhRUd/rvYACkAmjnWpHpJFUsOjY2NiDpRRJ6qUnArrcx8uaaOznOPAp3
         SmodKivJ12nhQa6qW1k4QIYcW6BYHigcGpUdw0tMN/IjGR2u7FvsE50lxnMAhRVnNzLV
         qQcQ==
X-Gm-Message-State: ABy/qLZvQyMcFVQ8OMaI6khoLTFKe75LUoSvHeQRcMVYLMtfpyhEazg1
        p1a9p9SgAVoGvHp9DxHdzJ8Ln92NLaxUtTZ3xr2vYfnTOR/QNcwrKPmWk1SO
X-Google-Smtp-Source: APBJJlHTSNrbAbBTcBgXFCzjWQjKbFnMq579tny/O5p+cvkXUEPJtPHRMbfXZaYuphSuPj2kITz9wfQVm8HdPrpr95I=
X-Received: by 2002:a05:6e02:1b0b:b0:345:dcdf:206b with SMTP id
 i11-20020a056e021b0b00b00345dcdf206bmr42287ilv.25.1690261214505; Mon, 24 Jul
 2023 22:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230724111206.3067352-1-howardchung@google.com> <CABBYNZ+UrWFNULhn8Nu79rvS-NZ4Rt4X4y=s+-DHEwjfKuX8Gg@mail.gmail.com>
In-Reply-To: <CABBYNZ+UrWFNULhn8Nu79rvS-NZ4Rt4X4y=s+-DHEwjfKuX8Gg@mail.gmail.com>
From:   Yun-hao Chung <howardchung@google.com>
Date:   Tue, 25 Jul 2023 13:00:03 +0800
Message-ID: <CAPHZWUe-Un49W40ufrJVCr0XC--wdwbte4=orgUT8z=6rDXbWQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: Add timeout in disconnect when power off
To:     LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
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

Thanks Paul for the review. I'll fix them in the next patch.

Hi Luiz,

I think the controller did reset its internal state in the link layer,
so the next time we asked the controller to create a connection to the
same remote, the controller didn't reply the error in the command
complete event but the connection was rejected by the remote. If we
really want the controller to complete the disconnect procedure on
reset, the power-off procedure could be stuck for tens of seconds if
the remote was not responding. A similar problem was found and solved
in this patch [Bluetooth: hci_sync: Don't wait peer's reply when
powering off].

The other reason why we think this is better to be solved in the
software layer is this is not only observed in Intel's AX211 but also
MTK's MT7921 and maybe more.

Since this is a tradeoff problem, I make it a configurable parameter
so that each user can decide a good number from their perspective. If
it is 0, which is the default value, the behavior should remain the
same.

Do you think this sounds good to you?

Thanks,
Howard


On Tue, Jul 25, 2023 at 6:31=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Howard,
>
> On Mon, Jul 24, 2023 at 4:12=E2=80=AFAM Howard Chung <howardchung@google.=
com> wrote:
> >
> > For some controllers, it is known that when the HCI disconnect and HCI
> > Reset are too close to each other, the LMP disconnect command might not
> > been sent out yet and the command will be dropped by the controoler whe=
n
> > it is asked to reset itself. This could happen on powering off adapter.
> >
> > One possible issue is that if a connection exists, and then powering of=
f
> > and on adapter within a short time, then our host stack assumes the
> > conntection was disconnected but this might not be true, so if we issue
> > a connection to the peer, it will fail with ACL Already Connected error=
.
>
> That sounds more like a bug in the controller though, the spec is
> quite clear that it must reset the link-layer state:
>
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> page 1972
>
> ...HCI_Reset command shall reset the Link Manager, Baseband and Link Laye=
r.
>
> So it sounds like the controller shall perform and the necessary
> procedures before it respond with a Command Complete.
>
> > This CL makes the host stack to wait for |HCI_EV_DISCONN_COMPLETE| when
> > powering off with a configurable timeout unless the timeout is set to 0=
.
> >
> > Reviewed-by: Archie Pusaka <apusaka@google.com>
> > Signed-off-by: Howard Chung <howardchung@google.com>
> > ---
> > Hi upstream maintainers, this is tested with an AX211 device and Logi
> > K580 keyboard by the following procedures:
> > 1. pair the peer and stay connected.
> > 2. power off and on immediately
> > 3. observe that the btsnoop log is consistent with the configured
> >    timeout.
> >
> >  include/net/bluetooth/hci_core.h |  1 +
> >  net/bluetooth/hci_core.c         |  2 +-
> >  net/bluetooth/hci_sync.c         | 38 +++++++++++++++++++++++---------
> >  net/bluetooth/mgmt_config.c      |  6 +++++
> >  4 files changed, 35 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 8200a6689b39..ce44f9c60059 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -432,6 +432,7 @@ struct hci_dev {
> >         __u16           advmon_allowlist_duration;
> >         __u16           advmon_no_filter_duration;
> >         __u8            enable_advmon_interleave_scan;
> > +       __u16           discon_on_poweroff_timeout;
> >
> >         __u16           devid_source;
> >         __u16           devid_vendor;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 0fefa6788911..769865494f45 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2479,7 +2479,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_pri=
v)
> >         hdev->adv_instance_cnt =3D 0;
> >         hdev->cur_adv_instance =3D 0x00;
> >         hdev->adv_instance_timeout =3D 0;
> > -
> > +       hdev->discon_on_poweroff_timeout =3D 0;   /* Default to no time=
out */
> >         hdev->advmon_allowlist_duration =3D 300;
> >         hdev->advmon_no_filter_duration =3D 500;
> >         hdev->enable_advmon_interleave_scan =3D 0x00;     /* Default to=
 disable */
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 3348a1b0e3f7..260e9f05359c 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5250,6 +5250,8 @@ static int hci_disconnect_sync(struct hci_dev *hd=
ev, struct hci_conn *conn,
> >                                u8 reason)
> >  {
> >         struct hci_cp_disconnect cp;
> > +       unsigned long timeout;
> > +       int err;
> >
> >         if (conn->type =3D=3D AMP_LINK)
> >                 return hci_disconnect_phy_link_sync(hdev, conn->handle,=
 reason);
> > @@ -5258,19 +5260,33 @@ static int hci_disconnect_sync(struct hci_dev *=
hdev, struct hci_conn *conn,
> >         cp.handle =3D cpu_to_le16(conn->handle);
> >         cp.reason =3D reason;
> >
> > -       /* Wait for HCI_EV_DISCONN_COMPLETE, not HCI_EV_CMD_STATUS, whe=
n the
> > -        * reason is anything but HCI_ERROR_REMOTE_POWER_OFF. This reas=
on is
> > -        * used when suspending or powering off, where we don't want to=
 wait
> > -        * for the peer's response.
> > +       /* The HCI_ERROR_REMOTE_POWER_OFF is used when suspending or po=
wering off,
> > +        * so we don't want to waste time waiting for the reply of the =
peer.
> > +        * However, if the configuration specified, we'll wait some tim=
e to give the
> > +        * controller chance to actually send the disconnect command.
> >          */
> > -       if (reason !=3D HCI_ERROR_REMOTE_POWER_OFF)
> > -               return __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT=
,
> > -                                               sizeof(cp), &cp,
> > -                                               HCI_EV_DISCONN_COMPLETE=
,
> > -                                               HCI_CMD_TIMEOUT, NULL);
> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF && !hdev->discon_o=
n_poweroff_timeout) {
> > +               return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT,
> > +                                            sizeof(cp), &cp, HCI_CMD_T=
IMEOUT);
> > +       }
> >
> > -       return __hci_cmd_sync_status(hdev, HCI_OP_DISCONNECT, sizeof(cp=
), &cp,
> > -                                    HCI_CMD_TIMEOUT);
> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> > +               timeout =3D msecs_to_jiffies(hdev->discon_on_poweroff_t=
imeout);
> > +       else
> > +               timeout =3D HCI_CMD_TIMEOUT;
> > +
> > +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_DISCONNECT,
> > +                                      sizeof(cp), &cp,
> > +                                      HCI_EV_DISCONN_COMPLETE,
> > +                                      timeout, NULL);
> > +
> > +       /* Ignore the error in suspending or powering off case to avoid=
 the procedure being
> > +        * aborted.
> > +        */
> > +       if (reason =3D=3D HCI_ERROR_REMOTE_POWER_OFF)
> > +               return 0;
> > +
> > +       return err;
> >  }
> >
> >  static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
> > diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> > index 6ef701c27da4..f3194e3642d9 100644
> > --- a/net/bluetooth/mgmt_config.c
> > +++ b/net/bluetooth/mgmt_config.c
> > @@ -78,6 +78,7 @@ int read_def_system_config(struct sock *sk, struct hc=
i_dev *hdev, void *data,
> >                 HDEV_PARAM_U16(advmon_allowlist_duration);
> >                 HDEV_PARAM_U16(advmon_no_filter_duration);
> >                 HDEV_PARAM_U8(enable_advmon_interleave_scan);
> > +               HDEV_PARAM_U16(discon_on_poweroff_timeout);
> >         } __packed rp =3D {
> >                 TLV_SET_U16(0x0000, def_page_scan_type),
> >                 TLV_SET_U16(0x0001, def_page_scan_int),
> > @@ -111,6 +112,7 @@ int read_def_system_config(struct sock *sk, struct =
hci_dev *hdev, void *data,
> >                 TLV_SET_U16(0x001d, advmon_allowlist_duration),
> >                 TLV_SET_U16(0x001e, advmon_no_filter_duration),
> >                 TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
> > +               TLV_SET_U16(0x0020, discon_on_poweroff_timeout),
> >         };
> >
> >         bt_dev_dbg(hdev, "sock %p", sk);
> > @@ -186,6 +188,7 @@ int set_def_system_config(struct sock *sk, struct h=
ci_dev *hdev, void *data,
> >                 case 0x001b:
> >                 case 0x001d:
> >                 case 0x001e:
> > +               case 0x0020:
> >                         exp_type_len =3D sizeof(u16);
> >                         break;
> >                 case 0x001f:
> > @@ -314,6 +317,9 @@ int set_def_system_config(struct sock *sk, struct h=
ci_dev *hdev, void *data,
> >                 case 0x0001f:
> >                         hdev->enable_advmon_interleave_scan =3D TLV_GET=
_U8(buffer);
> >                         break;
> > +               case 0x00020:
> > +                       hdev->discon_on_poweroff_timeout =3D TLV_GET_LE=
16(buffer);
> > +                       break;
> >                 default:
> >                         bt_dev_warn(hdev, "unsupported parameter %u", t=
ype);
> >                         break;
> > --
> > 2.41.0.487.g6d72f3e995-goog
> >
>
>
> --
> Luiz Augusto von Dentz
