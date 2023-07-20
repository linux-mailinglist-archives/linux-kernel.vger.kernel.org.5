Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E085D75A369
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGTAZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjGTAZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:25:28 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C4189;
        Wed, 19 Jul 2023 17:25:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso2993841fa.1;
        Wed, 19 Jul 2023 17:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689812725; x=1692404725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=li2otsaC5616U3PoldxbrJyvMyJtirPvLPzcb7XzgDo=;
        b=KRfHvle0gTu+vDsYpGhqYMGor9eNo1pfkgz2/p4lV0KqOkXzjadxGXds5/SCEA0Imh
         2ehLjZHtR6vkb0s8i032+rpEadlCs6ngL3UKH9qp8bN8M0YdrKVxifIpFWcV3DwHy8lZ
         fxBX06LgGSy+pzqYKxfE0i3Tggvf7ZEGJRrEeht776rkEDSafNHtILHLQ0G2cl2Ltbed
         4FsFu02ErLz/WzOBmddWecAQj68NseK2XgYjsujP1auMam85y/9y3fOq9r9HLiMZMjgq
         sfjBpgvbDzzpEktqdKoJIvfW+FlqQaIRliJEakIJq1Wy4VIFlD8ZHNaGLGiRaCnPnB+U
         z2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689812725; x=1692404725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=li2otsaC5616U3PoldxbrJyvMyJtirPvLPzcb7XzgDo=;
        b=KNP9yVU+tQd6SMKm7H9rZITgn6mTQpO2NzlrqXfLpzLjvuw2KWfZbz6vozD9iKABi1
         SG08c/+Udb3va7SiR9STNS0QINlepA5s9um90k3jB8acOO/tF+wrPFlQMkS92aY0Mvso
         O9LsMS3AR4YhNDa3JztJjHYZ9MCHRDHcVR6YyV7NXqN36n9nYq5kUAuw8yNwwu/rnkcv
         DVzKr3vu4p+cfcmqdVYTMDqlsQidIJSXw3XymhuKn8q+B4q0aFwuWXe0T9ZNIAyK/M+O
         xyjTlPWZw9HbQyqnhjcLBa20xTmTClQrH3nOvQLVNvyukUKQ9tGgQH9e6gK3gXZbpqyA
         nLww==
X-Gm-Message-State: ABy/qLYmwO/Ub6tG/4Cn7JaGHxx/lZ4V0OyaXpIiev3q6Za6L1CFOnet
        NjvFv5G8uq+8Ia4YRA4wes3N1q2LoXjUJWpvJ+Y=
X-Google-Smtp-Source: APBJJlFiFmD+8EIVY6xdyk2QMndYOHjM37tL3jvBlGS7uQBZ+8hL/SomF22OAZYWpMYt74kwza8ml259Zlhl3rZGbH0=
X-Received: by 2002:a2e:b17a:0:b0:2b9:3491:c3d0 with SMTP id
 a26-20020a2eb17a000000b002b93491c3d0mr906510ljm.52.1689812724544; Wed, 19 Jul
 2023 17:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230718034337.23502-1-jlee@suse.com> <CABBYNZJ97UMyZ7yX1YAGbuU4XwNDdoFewKNwbd=51_L9aNrrCQ@mail.gmail.com>
 <20230719154918.GJ14791@linux-l9pv.suse>
In-Reply-To: <20230719154918.GJ14791@linux-l9pv.suse>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 19 Jul 2023 17:25:12 -0700
Message-ID: <CABBYNZLKJTKwBeypHbwm1r2CnqY+S2pY6dLYri+Z-otEx-UQ6A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_event: Ignore NULL link key
To:     joeyli <jlee@suse.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-bluetooth@vger.kernel.org
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

Hi Joeyli,

On Wed, Jul 19, 2023 at 8:49=E2=80=AFAM joeyli <jlee@suse.com> wrote:
>
> Hi Luiz Augusto von Dentz,
>
> On Tue, Jul 18, 2023 at 10:22:26AM -0700, Luiz Augusto von Dentz wrote:
> > Hi Chun-Yi,
> >
> > On Mon, Jul 17, 2023 at 8:43=E2=80=AFPM Lee, Chun-Yi <joeyli.kernel@gma=
il.com> wrote:
> > >
> > > This change is used to relieve CVE-2020-26555. The description of the
> > > CVE:
> > >
> > > Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specificat=
ion
> > > 1.0B through 5.2 may permit an unauthenticated nearby device to spoof
> > > the BD_ADDR of the peer device to complete pairing without knowledge
> > > of the PIN. [1]
> >
> > Btw, it is probably worth mentioning that in BR/EDR the key generation
> > is actually handled in the controller, below HCI.
> >
>
> Yes, the key generation be handled by link manager. I will mention it
> in patch description.
>
> > > The detail of this attack is in IEEE paper:
> > > BlueMirror: Reflections on Bluetooth Pairing and Provisioning Protoco=
ls
> > > [2]
> > >
> > > It's a reflection attack. Base on the paper, attacker can induce the
> > > attacked target to generate null link key (zero key) without PIN code=
.
> > >
> > > We can ignore null link key in the handler of "Link Key Notification
> > > event" to relieve the attack. A similar implementation also shows in
> > > btstack project. [3]
> >
> > Perhaps we could clarify this statement by stating that if we ignore
> > the link key it means the stack will not consider the device is bonded
> > and will not persist the link key, that said the controller will still
> > consider it as paired, so I perhaps we should go one step forward and
> > disconnect if we detect such a key is being used.
> >
>
> I am new on bluetooth field. Did you mean like this patch? Sending
> HCI_Disconnect when we found zero link key?
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ff0c331f53d6..3482031cbbb8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4698,6 +4700,15 @@ static void hci_link_key_notify_evt(struct hci_dev=
 *hdev, void *data,
>         if (!conn)
>                 goto unlock;
>
> +       /* Ignore NULL link key against CVE-2020-26555 */
> +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %pM=
R", &ev->bdaddr);
> +               hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
> +               hci_conn_drop(conn);
> +               goto unlock;
> +       }

Yeah, something like that should do it, btw I hope you are testing
these changes do actually work properly, even better if you could
introduce a test into the likes of mgmt-tester to generate a ZERO_KEY
so we are not caught by surprise if something doesn't quite work as
expected, or some change cause a regression where this key is accepted
again.

>         hci_conn_hold(conn);
>         conn->disc_timeout =3D HCI_DISCONN_TIMEOUT;
>         hci_conn_drop(conn);
>
>
> Is there anything I'm missing? Thanks a lot!
>
> > > v2:
> > > - Used Link: tag instead of Closes:
> > > - Used bt_dev_dbg instead of BT_DBG
> > > - Added Fixes: tag
> > >
> > > Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for the =
management interface")
> > > Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2020-26555=
 [1]
> > > Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors#a=
uthors [2]
> > > Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#L3=
722 [3]
> > > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > > ---
> > >  net/bluetooth/hci_event.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 95816a938cea..ff0c331f53d6 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct hci=
_dev *hdev, void *data,
> > >         bool persistent;
> > >         u8 pin_len =3D 0;
> > >
> > > +       /* Ignore NULL link key against CVE-2020-26555 */
> > > +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> > > +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for=
 %pMR", &ev->bdaddr);
> > > +               return;
> > > +       }
> > > +
> > >         bt_dev_dbg(hdev, "");
> > >
> > >         hci_dev_lock(hdev);
> > > --
> > > 2.35.3
> > >
>
> Thanks a lot!
> Joey Lee



--=20
Luiz Augusto von Dentz
