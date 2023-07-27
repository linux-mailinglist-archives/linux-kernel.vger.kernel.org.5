Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50D3765F78
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjG0WaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjG0W36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:29:58 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BE82696;
        Thu, 27 Jul 2023 15:29:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6f97c7115so24152701fa.2;
        Thu, 27 Jul 2023 15:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690496995; x=1691101795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf1VfD2mrsoeJHi9af8lkNzG5SBTTSXYfrfwad1NxqQ=;
        b=Sk86zoXZky8KTz19W03fhhjpebEf3oFjFutbH0n3MHxGFraphpEv2PoFdVNv1b1ALp
         4ViJcDwJQ/kqNqFEAYbT3BJKFqpbKqO+Cw/m0Kfb6XqmCw4TDi2KnLcRHuoUwhn3c935
         E6R8qUjBzC3AJ9GoTe67aCcule9m37mtHkKag3YXic21V7JnqI+CDbNUqreCGh0fDXI4
         raOjaVlb4Dv718+TSlDUEvV3u8W9PlI3GLP51JyrkdkBnyl6rYTPYLf1CPjvJS9OMPdz
         53ibbng7gqRgES8SXHJ9/tevL4kPTuA2jckS855FK9pbGFU93YJb/y4SYzOiYES7074R
         vZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690496995; x=1691101795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf1VfD2mrsoeJHi9af8lkNzG5SBTTSXYfrfwad1NxqQ=;
        b=XJnZo+mCgtq/zksbWnX0uPEJH48sS2oDrpmBfFcQnhBBgND+us/Ucu6UaoCyH1oCz7
         vDuwoD7k/IvqHkJqSTnScLm6r6cVqIwOQvWdDJcoDf+UHyQoXWNrf9mGfhpHKVLgVvP8
         jijiAOf3uTeb/KnKysu61ZoZXGOATrzueFxnSqgsNN+y4FWoX0yS4Dhvt0TTCxXxMpV9
         BOfeb1Sc498zlX3xxHrS7QQE3+51DkojOBzJYl88Lm+RSq3IqYKVEFpjqQPnq7Zrir3g
         SkfiiNdkiWF0BC0kiwmJM2Qhoz53AT3X6/tpqCObexXCbBO5pigKwTnD0qI6CrPjf2zC
         x2UQ==
X-Gm-Message-State: ABy/qLZCCUb2JZgthBPpfrwylBOZYwJnBOQ1HcTErpm51YdJNy6N3ehZ
        pGXsPy4/kmbKrzd7lGCCEuuZ2rl/KpNFsa1V4gI=
X-Google-Smtp-Source: APBJJlEOHNkvOux8Yi22ws6pP3YjaVT/+qvLVC7gs2uw3NLLS1NmbrvFPZ0BrRfLY509HcuTYMFLHBSmDoGtGCYD30Y=
X-Received: by 2002:a2e:9f42:0:b0:2b6:bc30:7254 with SMTP id
 v2-20020a2e9f42000000b002b6bc307254mr269783ljk.13.1690496994820; Thu, 27 Jul
 2023 15:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230718034337.23502-1-jlee@suse.com> <CABBYNZJ97UMyZ7yX1YAGbuU4XwNDdoFewKNwbd=51_L9aNrrCQ@mail.gmail.com>
 <20230719154918.GJ14791@linux-l9pv.suse> <CABBYNZLKJTKwBeypHbwm1r2CnqY+S2pY6dLYri+Z-otEx-UQ6A@mail.gmail.com>
In-Reply-To: <CABBYNZLKJTKwBeypHbwm1r2CnqY+S2pY6dLYri+Z-otEx-UQ6A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 15:29:42 -0700
Message-ID: <CABBYNZJZisYm0Vgfzd8F2ge9RPJvUYBVGpj-4iySerT_wUTJNA@mail.gmail.com>
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

On Wed, Jul 19, 2023 at 5:25=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Joeyli,
>
> On Wed, Jul 19, 2023 at 8:49=E2=80=AFAM joeyli <jlee@suse.com> wrote:
> >
> > Hi Luiz Augusto von Dentz,
> >
> > On Tue, Jul 18, 2023 at 10:22:26AM -0700, Luiz Augusto von Dentz wrote:
> > > Hi Chun-Yi,
> > >
> > > On Mon, Jul 17, 2023 at 8:43=E2=80=AFPM Lee, Chun-Yi <joeyli.kernel@g=
mail.com> wrote:
> > > >
> > > > This change is used to relieve CVE-2020-26555. The description of t=
he
> > > > CVE:
> > > >
> > > > Bluetooth legacy BR/EDR PIN code pairing in Bluetooth Core Specific=
ation
> > > > 1.0B through 5.2 may permit an unauthenticated nearby device to spo=
of
> > > > the BD_ADDR of the peer device to complete pairing without knowledg=
e
> > > > of the PIN. [1]
> > >
> > > Btw, it is probably worth mentioning that in BR/EDR the key generatio=
n
> > > is actually handled in the controller, below HCI.
> > >
> >
> > Yes, the key generation be handled by link manager. I will mention it
> > in patch description.
> >
> > > > The detail of this attack is in IEEE paper:
> > > > BlueMirror: Reflections on Bluetooth Pairing and Provisioning Proto=
cols
> > > > [2]
> > > >
> > > > It's a reflection attack. Base on the paper, attacker can induce th=
e
> > > > attacked target to generate null link key (zero key) without PIN co=
de.
> > > >
> > > > We can ignore null link key in the handler of "Link Key Notificatio=
n
> > > > event" to relieve the attack. A similar implementation also shows i=
n
> > > > btstack project. [3]
> > >
> > > Perhaps we could clarify this statement by stating that if we ignore
> > > the link key it means the stack will not consider the device is bonde=
d
> > > and will not persist the link key, that said the controller will stil=
l
> > > consider it as paired, so I perhaps we should go one step forward and
> > > disconnect if we detect such a key is being used.
> > >
> >
> > I am new on bluetooth field. Did you mean like this patch? Sending
> > HCI_Disconnect when we found zero link key?
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index ff0c331f53d6..3482031cbbb8 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -4698,6 +4700,15 @@ static void hci_link_key_notify_evt(struct hci_d=
ev *hdev, void *data,
> >         if (!conn)
> >                 goto unlock;
> >
> > +       /* Ignore NULL link key against CVE-2020-26555 */
> > +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> > +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) for %=
pMR", &ev->bdaddr);
> > +               hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
> > +               hci_conn_drop(conn);
> > +               goto unlock;
> > +       }
>
> Yeah, something like that should do it, btw I hope you are testing
> these changes do actually work properly, even better if you could
> introduce a test into the likes of mgmt-tester to generate a ZERO_KEY
> so we are not caught by surprise if something doesn't quite work as
> expected, or some change cause a regression where this key is accepted
> again.

Are you still planning on updating these changes so we can apply it?

> >         hci_conn_hold(conn);
> >         conn->disc_timeout =3D HCI_DISCONN_TIMEOUT;
> >         hci_conn_drop(conn);
> >
> >
> > Is there anything I'm missing? Thanks a lot!
> >
> > > > v2:
> > > > - Used Link: tag instead of Closes:
> > > > - Used bt_dev_dbg instead of BT_DBG
> > > > - Added Fixes: tag
> > > >
> > > > Fixes: 55ed8ca10f35 ("Bluetooth: Implement link key handling for th=
e management interface")
> > > > Link: https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2020-265=
55 [1]
> > > > Link: https://ieeexplore.ieee.org/abstract/document/9474325/authors=
#authors [2]
> > > > Link: https://github.com/bluekitchen/btstack/blob/master/src/hci.c#=
L3722 [3]
> > > > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> > > > ---
> > > >  net/bluetooth/hci_event.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > > index 95816a938cea..ff0c331f53d6 100644
> > > > --- a/net/bluetooth/hci_event.c
> > > > +++ b/net/bluetooth/hci_event.c
> > > > @@ -4684,6 +4684,12 @@ static void hci_link_key_notify_evt(struct h=
ci_dev *hdev, void *data,
> > > >         bool persistent;
> > > >         u8 pin_len =3D 0;
> > > >
> > > > +       /* Ignore NULL link key against CVE-2020-26555 */
> > > > +       if (!memcmp(ev->link_key, ZERO_KEY, HCI_LINK_KEY_SIZE)) {
> > > > +               bt_dev_dbg(hdev, "Ignore NULL link key (ZERO KEY) f=
or %pMR", &ev->bdaddr);
> > > > +               return;
> > > > +       }
> > > > +
> > > >         bt_dev_dbg(hdev, "");
> > > >
> > > >         hci_dev_lock(hdev);
> > > > --
> > > > 2.35.3
> > > >
> >
> > Thanks a lot!
> > Joey Lee
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
