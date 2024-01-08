Return-Path: <linux-kernel+bounces-20104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C48827950
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6B971C22E3C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2146B55792;
	Mon,  8 Jan 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGV8B3lW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446755776;
	Mon,  8 Jan 2024 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd053d5683so25992911fa.2;
        Mon, 08 Jan 2024 12:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704746796; x=1705351596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZQSSuEov1m94GTK+3rCrdLk/BXHqNE/mhue/X0KjOo=;
        b=TGV8B3lWdzPuZVteIbtemrM1hNcvlQ49mgpREq+mSuLthfFHDx/9acNhf25h0aCXb/
         Haga3uT8VrLRVMeKugCDebmZ0dyXWDgxy5AyZK40UFrYI//SJg/vBRGnquKqjoHFl5u0
         8MJNvfVl5CVpPp5SN38B8NsWIX4k8U/b2T/a3ltc09KXVqEN9Et4IzuSQOaeBuSxvusH
         /AKtFIeyei7TR1oMpAj++BTEUjYcP/5QjvTDrdZTafbSEwEvuyWgg2+rpfL6QXUpuG4c
         w/bozufNu5NVKUmPkRh/IsM4L0QLlpaGoPTxYuZyvQwf2y4HReMdTI3ux4PFJmxlUbHO
         lKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704746796; x=1705351596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZQSSuEov1m94GTK+3rCrdLk/BXHqNE/mhue/X0KjOo=;
        b=CnSF2uYxNUci0YL9+fh3ugDm2X9LI45GDbTWyJhEK4Z7/xXxFtOMlW01ywioPdTQze
         ZJW026f4UgqX9GkBLc0UFYrqNr0GMOrSfAf9flN4Kk2U/ZMUqENz+Td5ahD2bqUawt2l
         qncQnCK8IQfHwrgKZmp63BPyvdqZwKaUcTAt9o7C+ohQ9XJoMI3JWOgWhWjQMWE+t8BO
         /cLCvUMstDafPLl58mN56WHmjE7gcE/AvUY2F9IM9J6Omg9w11O6xYyQ/yFDulE2zvxS
         vfvAinn5xFTioUqF59G6+0ervzT8hZDmJsyXU1DvJEQb5p6r4lch78IdJHQQO+dy3lGc
         mC0Q==
X-Gm-Message-State: AOJu0Yx+3OkzqyALO7+7imPiW6ecaLhp0fgnvUghU140BoohTAJXYx5F
	zrwFBo+PomuB49cqikldmahrG9AWo/hgoax5WPA=
X-Google-Smtp-Source: AGHT+IFAd1Im/x73j+HN+fteMR6gcTc/xpPKbDXMlbjrxEb5PxAfwwEoMkT0wU9YgL9OgE+2e+ctSO0isVXTHc6buX8=
X-Received: by 2002:a05:651c:118f:b0:2cc:eaa3:bb4d with SMTP id
 w15-20020a05651c118f00b002cceaa3bb4dmr1511107ljo.61.1704746796173; Mon, 08
 Jan 2024 12:46:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108183938.468426-1-verdre@v0yd.nl> <20240108183938.468426-5-verdre@v0yd.nl>
 <5d1f2013-5758-4d6c-8d01-e96a76bb2686@v0yd.nl> <40550fc1-3b5b-438c-891d-2da0f30874f3@v0yd.nl>
 <CABBYNZKV8SujJ7GFUqTMXUskE=yK0q=opmwvTZNEpPb=JkiQbA@mail.gmail.com>
 <d1e7219f-e7b4-4474-ae89-70925b8787fa@v0yd.nl> <CABBYNZLNeKOT0n=D-PN=aPgfu07xZ-x8nNKitas40X=0Snp4jQ@mail.gmail.com>
 <d7e6ff1d-f69f-4e48-8167-7dbcb0d8093f@v0yd.nl>
In-Reply-To: <d7e6ff1d-f69f-4e48-8167-7dbcb0d8093f@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jan 2024 15:46:22 -0500
Message-ID: <CABBYNZJZ8cA77FBgvXWJeVjVpzjuwzC4Mn4QRR3OsZJn+M=VyQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Bluetooth: Remove pending ACL connection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Jan 8, 2024 at 3:26=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Hi Luiz,
>
> On 1/8/24 20:41, Luiz Augusto von Dentz wrote:
> > Hi Jonas,
> >
> > On Mon, Jan 8, 2024 at 2:29=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.=
nl> wrote:
> >>
> >> Hi Luiz,
> >>
> >> On 1/8/24 20:14, Luiz Augusto von Dentz wrote:
> >>> Hi Jonas,
> >>>
> >>> On Mon, Jan 8, 2024 at 1:55=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0y=
d.nl> wrote:
> >>>>
> >>>> On 1/8/24 19:44, Jonas Dre=C3=9Fler wrote:
> >>>>> On 1/8/24 19:39, Jonas Dre=C3=9Fler wrote:
> >>>>>> With the last commit we moved to using the hci_sync queue for "Cre=
ate
> >>>>>> Connection" requests, removing the need for retrying the paging af=
ter
> >>>>>> finished/failed "Create Connection" requests and after the end of
> >>>>>> inquiries.
> >>>>>>
> >>>>>> hci_conn_check_pending() was used to trigger this retry, we can re=
move it
> >>>>>> now.
> >>>>>>
> >>>>>> Note that we can also remove the special handling for COMMAND_DISA=
LLOWED
> >>>>>> errors in the completion handler of "Create Connection", because "=
Create
> >>>>>> Connection" requests are now always serialized.
> >>>>>>
> >>>>>> This is somewhat reverting commit 4c67bc74f016 ("[Bluetooth] Suppo=
rt
> >>>>>> concurrent connect requests").
> >>>>>>
> >>>>>> With this, the BT_CONNECT2 state of ACL hci_conn objects should no=
w be
> >>>>>> back to meaning only one thing: That we received a connection requ=
est
> >>>>>> from another device (see hci_conn_request_evt), but the actual con=
nect
> >>>>>> should be deferred.
> >>>>>> ---
> >>>>>>     include/net/bluetooth/hci_core.h |  1 -
> >>>>>>     net/bluetooth/hci_conn.c         | 16 ----------------
> >>>>>>     net/bluetooth/hci_event.c        | 21 ++++-----------------
> >>>>>>     3 files changed, 4 insertions(+), 34 deletions(-)
> >>>>>>
> >>>>>> diff --git a/include/net/bluetooth/hci_core.h
> >>>>>> b/include/net/bluetooth/hci_core.h
> >>>>>> index 2c30834c1..d7483958d 100644
> >>>>>> --- a/include/net/bluetooth/hci_core.h
> >>>>>> +++ b/include/net/bluetooth/hci_core.h
> >>>>>> @@ -1330,7 +1330,6 @@ struct hci_conn *hci_conn_add(struct hci_dev
> >>>>>> *hdev, int type, bdaddr_t *dst,
> >>>>>>                       u8 role);
> >>>>>>     void hci_conn_del(struct hci_conn *conn);
> >>>>>>     void hci_conn_hash_flush(struct hci_dev *hdev);
> >>>>>> -void hci_conn_check_pending(struct hci_dev *hdev);
> >>>>>>     struct hci_chan *hci_chan_create(struct hci_conn *conn);
> >>>>>>     void hci_chan_del(struct hci_chan *chan);
> >>>>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>>>>> index 541d55301..22033057b 100644
> >>>>>> --- a/net/bluetooth/hci_conn.c
> >>>>>> +++ b/net/bluetooth/hci_conn.c
> >>>>>> @@ -2534,22 +2534,6 @@ void hci_conn_hash_flush(struct hci_dev *hd=
ev)
> >>>>>>         }
> >>>>>>     }
> >>>>>> -/* Check pending connect attempts */
> >>>>>> -void hci_conn_check_pending(struct hci_dev *hdev)
> >>>>>> -{
> >>>>>> -    struct hci_conn *conn;
> >>>>>> -
> >>>>>> -    BT_DBG("hdev %s", hdev->name);
> >>>>>> -
> >>>>>> -    hci_dev_lock(hdev);
> >>>>>> -
> >>>>>> -    conn =3D hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNEC=
T2);
> >>>>>> -    if (conn)
> >>>>>> -        hci_cmd_sync_queue(hdev, hci_acl_create_connection_sync,
> >>>>>> conn, NULL);
> >>>>>> -
> >>>>>> -    hci_dev_unlock(hdev);
> >>>>>> -}
> >>>>>> -
> >>>>>>     static u32 get_link_mode(struct hci_conn *conn)
> >>>>>>     {
> >>>>>>         u32 link_mode =3D 0;
> >>>>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>>>>> index e8b4a0126..91973d6d1 100644
> >>>>>> --- a/net/bluetooth/hci_event.c
> >>>>>> +++ b/net/bluetooth/hci_event.c
> >>>>>> @@ -117,8 +117,6 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev
> >>>>>> *hdev, void *data,
> >>>>>>             hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >>>>>>         hci_dev_unlock(hdev);
> >>>>>> -    hci_conn_check_pending(hdev);
> >>>>>> -
> >>>>>>         return rp->status;
> >>>>>>     }
> >>>>>> @@ -149,8 +147,6 @@ static u8 hci_cc_exit_periodic_inq(struct hci_=
dev
> >>>>>> *hdev, void *data,
> >>>>>>         hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
> >>>>>> -    hci_conn_check_pending(hdev);
> >>>>>> -
> >>>>>>         return rp->status;
> >>>>>>     }
> >>>>>> @@ -2296,10 +2292,8 @@ static void hci_cs_inquiry(struct hci_dev
> >>>>>> *hdev, __u8 status)
> >>>>>>     {
> >>>>>>         bt_dev_dbg(hdev, "status 0x%2.2x", status);
> >>>>>> -    if (status) {
> >>>>>> -        hci_conn_check_pending(hdev);
> >>>>>> +    if (status)
> >>>>>>             return;
> >>>>>> -    }
> >>>>>>         set_bit(HCI_INQUIRY, &hdev->flags);
> >>>>>>     }
> >>>>>> @@ -2323,12 +2317,9 @@ static void hci_cs_create_conn(struct hci_d=
ev
> >>>>>> *hdev, __u8 status)
> >>>>>>         if (status) {
> >>>>>>             if (conn && conn->state =3D=3D BT_CONNECT) {
> >>>>>> -            if (status !=3D HCI_ERROR_COMMAND_DISALLOWED ||
> >>>>>> conn->attempt > 2) {
> >>>>>> -                conn->state =3D BT_CLOSED;
> >>>>>> -                hci_connect_cfm(conn, status);
> >>>>>> -                hci_conn_del(conn);
> >>>>>> -            } else
> >>>>>> -                conn->state =3D BT_CONNECT2;
> >>>>>> +            conn->state =3D BT_CLOSED;
> >>>>>> +            hci_connect_cfm(conn, status);
> >>>>>> +            hci_conn_del(conn);
> >>>>>>             }
> >>>>>>         } else {
> >>>>>>             if (!conn) {
> >>>>>> @@ -3020,8 +3011,6 @@ static void hci_inquiry_complete_evt(struct
> >>>>>> hci_dev *hdev, void *data,
> >>>>>>         bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> >>>>>> -    hci_conn_check_pending(hdev);
> >>>>>> -
> >>>>>>         if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
> >>>>>>             return;
> >>>>>> @@ -3247,8 +3236,6 @@ static void hci_conn_complete_evt(struct hci=
_dev
> >>>>>> *hdev, void *data,
> >>>>>>     unlock:
> >>>>>>         hci_dev_unlock(hdev);
> >>>>>> -
> >>>>>> -    hci_conn_check_pending(hdev);
> >>>>>>     }
> >>>>>>     static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bd=
addr)
> >>>>>
> >>>>> Please take a special look at this one: I'm not sure if I'm breakin=
g the
> >>>>> functionality of deferred connecting using BT_CONNECT2 in
> >>>>> hci_conn_request_evt() here, as I don't see anywhere where we check=
 for
> >>>>> this state and establish a connection later.
> >>>>>
> >>>>> It seems that this is how hci_conn_request_evt() was initially writ=
ten
> >>>>> though, hci_conn_check_pending() only got introduced later and seem=
s
> >>>>> unrelated.
> >>>>
> >>>> Ahh nevermind... The check for BT_CONNECT2 on "Conn Complete event" =
got
> >>>> introduced with 4c67bc74f01 ([Bluetooth] Support concurrent connect
> >>>> requests). And later the deferred connection setup on "Conn Request
> >>>> event" got introduced with 20714bfef8 ("Bluetooth: Implement deferre=
d
> >>>> sco socket setup").
> >>>>
> >>>> I assume the latter commit was relying on the "Create Connection"
> >>>> request "Conn Complete event" that got introduced with the former co=
mmit
> >>>> then? That would imply that we use BT_CONNECT2 if there's already a
> >>>> "Create Connection" going on when the "Conn Request event" happens, =
and
> >>>> we must wait for that existing request to finish.. Is that how those
> >>>> deferred connections are supposed to work?
> >>>
> >>> Well if you are not sure that works we better make sure we have tests
> >>> that cover this, for LE I know for sure it works because we have the
> >>> likes of iso-tester that do connect 2 peers simultaneously, but for
> >>> classic I don't recall having any test that does multiple connections=
.
> >>
> >> The sequential "Create Connection" logic works, I tested that (of cour=
se
> >> I'm happy to add tests if it's not too much work).
> >>
> >> What I'm unsure about is if and how incoming connection requests from
> >> other devices with HCI_PROTO_DEFER flag are supposed to work and wheth=
er
> >> they are meant to trigger a "Create Connection" from us?
> >
> > For incoming connections on Classic that should result in an
> > accept/reject connection command, so it should cause another Create
> > Connection if that is what you are afraid of.
> >
>
> Hmm, do you mean it *shouldn't* cause another "Create Connection"?

Yeah, sorry about that, it is Monday I should probably double check if
what I wrote makes any sense before sending :D

> I just checked in the spec: It sounds like once we send the "Accept
> Connection Request" to the controller, the controller takes care of
> establishing the connection by itself (no "Create Connection"
> necessary), and will then later give us a "Connection Complete" event to
> indicate that the connection is done.

Yep, it will follow up with a Connection Complete.

> If I'm reading all this correctly, that sounds like my commit is
> correct, and we had a bug in this logic before by interpreting
> BT_CONNECT2 in two different ways.
>
> >>>
> >>>>>
> >>>>> Thanks,
> >>>>> Jonas
> >>>
> >>>
> >>>
> >
> >
> >



--=20
Luiz Augusto von Dentz

