Return-Path: <linux-kernel+bounces-20050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8059B8278B1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0521E1F23DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AC554FAB;
	Mon,  8 Jan 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoM89uyu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9953801;
	Mon,  8 Jan 2024 19:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ccea11b6bbso20633261fa.0;
        Mon, 08 Jan 2024 11:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704742892; x=1705347692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8rmRyFycC4hgDH+A5hcdmap6wg84H2QKcFImDeoAyM=;
        b=HoM89uyuWbKCWwTqjV79b0opIR01McS1FvEa0DH7ZfpOVXjewoknV2FF2kfy27vFIC
         g25YSLMqWoOi1Y9qCmgLZPWRId1zxnzrIajAt0K86Lv0mNjc1Lo18IohsR+c4uY5q+sN
         XtS11jdj/v0A795z03y5ml2Op6UIBC2o8F+viEzCnj/oXQ+vNXY0S875VvsXW4cmSDRV
         ZuZPz7Nqkr0MfXvqXsE3HBuXTTgmRh5O47nZ10IjoaghQaSbB1kK69nTH5dTFyZJvAOa
         1V9nN1jPT8vC4uOMNpJgHprRxRrEf9wrq4E9rUQei7r439ze+jG/l7+pVsxojtFm22QX
         aIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704742892; x=1705347692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8rmRyFycC4hgDH+A5hcdmap6wg84H2QKcFImDeoAyM=;
        b=Em3mEtkLd1nf2wX4OmQP+2qeYnhMzujAAJXIdhq7w1AQv81M/uqo/pAHmixCpz8lzx
         0++o61qSgn2KUcx3QIw527t65qXQ1j8PUMZs3XrAj5snKMP83HV3aPNGaExdXGpXUEkG
         UdTEtRAAWZksUMf4bX33lgxX4ZiZp4/RNFqZWBxefIj+XACjas0kaqmhSkvXSuGq7n7G
         DKW6GW2RjtChHTO/Ce2ql6NPqchLY9so8sQ4Bvv85qu4cjvlXGsX5gBlzzAxyV5P2pIj
         G6fe2DwTQjnWq6uXIzKvgnE5YGIANfVfs8+bFcmcizzkSozn+lbNlSliwYjVIkZi9sWR
         4RZg==
X-Gm-Message-State: AOJu0YzhvFQ6Dccl+I8ukQ2aoPm56ryfGI3HkjU2g3Q4XzXr2IWrwUvD
	3mFGcYzmuj+KolvZflXAdX5NCfjrTgR143aibXY=
X-Google-Smtp-Source: AGHT+IFkLB5b2mIG0RWTRfxQSn4bhHE53eFVbj8hivKZ+GpM0wDn2K40gEq9zaBZenfDXat33IEHuYguehz2KjyqIWo=
X-Received: by 2002:a05:651c:22a:b0:2cd:178a:6dbe with SMTP id
 z10-20020a05651c022a00b002cd178a6dbemr141944ljn.4.1704742892067; Mon, 08 Jan
 2024 11:41:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108183938.468426-1-verdre@v0yd.nl> <20240108183938.468426-5-verdre@v0yd.nl>
 <5d1f2013-5758-4d6c-8d01-e96a76bb2686@v0yd.nl> <40550fc1-3b5b-438c-891d-2da0f30874f3@v0yd.nl>
 <CABBYNZKV8SujJ7GFUqTMXUskE=yK0q=opmwvTZNEpPb=JkiQbA@mail.gmail.com> <d1e7219f-e7b4-4474-ae89-70925b8787fa@v0yd.nl>
In-Reply-To: <d1e7219f-e7b4-4474-ae89-70925b8787fa@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jan 2024 14:41:19 -0500
Message-ID: <CABBYNZLNeKOT0n=D-PN=aPgfu07xZ-x8nNKitas40X=0Snp4jQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Bluetooth: Remove pending ACL connection attempts
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Jan 8, 2024 at 2:29=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Hi Luiz,
>
> On 1/8/24 20:14, Luiz Augusto von Dentz wrote:
> > Hi Jonas,
> >
> > On Mon, Jan 8, 2024 at 1:55=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.=
nl> wrote:
> >>
> >> On 1/8/24 19:44, Jonas Dre=C3=9Fler wrote:
> >>> On 1/8/24 19:39, Jonas Dre=C3=9Fler wrote:
> >>>> With the last commit we moved to using the hci_sync queue for "Creat=
e
> >>>> Connection" requests, removing the need for retrying the paging afte=
r
> >>>> finished/failed "Create Connection" requests and after the end of
> >>>> inquiries.
> >>>>
> >>>> hci_conn_check_pending() was used to trigger this retry, we can remo=
ve it
> >>>> now.
> >>>>
> >>>> Note that we can also remove the special handling for COMMAND_DISALL=
OWED
> >>>> errors in the completion handler of "Create Connection", because "Cr=
eate
> >>>> Connection" requests are now always serialized.
> >>>>
> >>>> This is somewhat reverting commit 4c67bc74f016 ("[Bluetooth] Support
> >>>> concurrent connect requests").
> >>>>
> >>>> With this, the BT_CONNECT2 state of ACL hci_conn objects should now =
be
> >>>> back to meaning only one thing: That we received a connection reques=
t
> >>>> from another device (see hci_conn_request_evt), but the actual conne=
ct
> >>>> should be deferred.
> >>>> ---
> >>>>    include/net/bluetooth/hci_core.h |  1 -
> >>>>    net/bluetooth/hci_conn.c         | 16 ----------------
> >>>>    net/bluetooth/hci_event.c        | 21 ++++-----------------
> >>>>    3 files changed, 4 insertions(+), 34 deletions(-)
> >>>>
> >>>> diff --git a/include/net/bluetooth/hci_core.h
> >>>> b/include/net/bluetooth/hci_core.h
> >>>> index 2c30834c1..d7483958d 100644
> >>>> --- a/include/net/bluetooth/hci_core.h
> >>>> +++ b/include/net/bluetooth/hci_core.h
> >>>> @@ -1330,7 +1330,6 @@ struct hci_conn *hci_conn_add(struct hci_dev
> >>>> *hdev, int type, bdaddr_t *dst,
> >>>>                      u8 role);
> >>>>    void hci_conn_del(struct hci_conn *conn);
> >>>>    void hci_conn_hash_flush(struct hci_dev *hdev);
> >>>> -void hci_conn_check_pending(struct hci_dev *hdev);
> >>>>    struct hci_chan *hci_chan_create(struct hci_conn *conn);
> >>>>    void hci_chan_del(struct hci_chan *chan);
> >>>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> >>>> index 541d55301..22033057b 100644
> >>>> --- a/net/bluetooth/hci_conn.c
> >>>> +++ b/net/bluetooth/hci_conn.c
> >>>> @@ -2534,22 +2534,6 @@ void hci_conn_hash_flush(struct hci_dev *hdev=
)
> >>>>        }
> >>>>    }
> >>>> -/* Check pending connect attempts */
> >>>> -void hci_conn_check_pending(struct hci_dev *hdev)
> >>>> -{
> >>>> -    struct hci_conn *conn;
> >>>> -
> >>>> -    BT_DBG("hdev %s", hdev->name);
> >>>> -
> >>>> -    hci_dev_lock(hdev);
> >>>> -
> >>>> -    conn =3D hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2=
);
> >>>> -    if (conn)
> >>>> -        hci_cmd_sync_queue(hdev, hci_acl_create_connection_sync,
> >>>> conn, NULL);
> >>>> -
> >>>> -    hci_dev_unlock(hdev);
> >>>> -}
> >>>> -
> >>>>    static u32 get_link_mode(struct hci_conn *conn)
> >>>>    {
> >>>>        u32 link_mode =3D 0;
> >>>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>>> index e8b4a0126..91973d6d1 100644
> >>>> --- a/net/bluetooth/hci_event.c
> >>>> +++ b/net/bluetooth/hci_event.c
> >>>> @@ -117,8 +117,6 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev
> >>>> *hdev, void *data,
> >>>>            hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> >>>>        hci_dev_unlock(hdev);
> >>>> -    hci_conn_check_pending(hdev);
> >>>> -
> >>>>        return rp->status;
> >>>>    }
> >>>> @@ -149,8 +147,6 @@ static u8 hci_cc_exit_periodic_inq(struct hci_de=
v
> >>>> *hdev, void *data,
> >>>>        hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
> >>>> -    hci_conn_check_pending(hdev);
> >>>> -
> >>>>        return rp->status;
> >>>>    }
> >>>> @@ -2296,10 +2292,8 @@ static void hci_cs_inquiry(struct hci_dev
> >>>> *hdev, __u8 status)
> >>>>    {
> >>>>        bt_dev_dbg(hdev, "status 0x%2.2x", status);
> >>>> -    if (status) {
> >>>> -        hci_conn_check_pending(hdev);
> >>>> +    if (status)
> >>>>            return;
> >>>> -    }
> >>>>        set_bit(HCI_INQUIRY, &hdev->flags);
> >>>>    }
> >>>> @@ -2323,12 +2317,9 @@ static void hci_cs_create_conn(struct hci_dev
> >>>> *hdev, __u8 status)
> >>>>        if (status) {
> >>>>            if (conn && conn->state =3D=3D BT_CONNECT) {
> >>>> -            if (status !=3D HCI_ERROR_COMMAND_DISALLOWED ||
> >>>> conn->attempt > 2) {
> >>>> -                conn->state =3D BT_CLOSED;
> >>>> -                hci_connect_cfm(conn, status);
> >>>> -                hci_conn_del(conn);
> >>>> -            } else
> >>>> -                conn->state =3D BT_CONNECT2;
> >>>> +            conn->state =3D BT_CLOSED;
> >>>> +            hci_connect_cfm(conn, status);
> >>>> +            hci_conn_del(conn);
> >>>>            }
> >>>>        } else {
> >>>>            if (!conn) {
> >>>> @@ -3020,8 +3011,6 @@ static void hci_inquiry_complete_evt(struct
> >>>> hci_dev *hdev, void *data,
> >>>>        bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> >>>> -    hci_conn_check_pending(hdev);
> >>>> -
> >>>>        if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
> >>>>            return;
> >>>> @@ -3247,8 +3236,6 @@ static void hci_conn_complete_evt(struct hci_d=
ev
> >>>> *hdev, void *data,
> >>>>    unlock:
> >>>>        hci_dev_unlock(hdev);
> >>>> -
> >>>> -    hci_conn_check_pending(hdev);
> >>>>    }
> >>>>    static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdadd=
r)
> >>>
> >>> Please take a special look at this one: I'm not sure if I'm breaking =
the
> >>> functionality of deferred connecting using BT_CONNECT2 in
> >>> hci_conn_request_evt() here, as I don't see anywhere where we check f=
or
> >>> this state and establish a connection later.
> >>>
> >>> It seems that this is how hci_conn_request_evt() was initially writte=
n
> >>> though, hci_conn_check_pending() only got introduced later and seems
> >>> unrelated.
> >>
> >> Ahh nevermind... The check for BT_CONNECT2 on "Conn Complete event" go=
t
> >> introduced with 4c67bc74f01 ([Bluetooth] Support concurrent connect
> >> requests). And later the deferred connection setup on "Conn Request
> >> event" got introduced with 20714bfef8 ("Bluetooth: Implement deferred
> >> sco socket setup").
> >>
> >> I assume the latter commit was relying on the "Create Connection"
> >> request "Conn Complete event" that got introduced with the former comm=
it
> >> then? That would imply that we use BT_CONNECT2 if there's already a
> >> "Create Connection" going on when the "Conn Request event" happens, an=
d
> >> we must wait for that existing request to finish.. Is that how those
> >> deferred connections are supposed to work?
> >
> > Well if you are not sure that works we better make sure we have tests
> > that cover this, for LE I know for sure it works because we have the
> > likes of iso-tester that do connect 2 peers simultaneously, but for
> > classic I don't recall having any test that does multiple connections.
>
> The sequential "Create Connection" logic works, I tested that (of course
> I'm happy to add tests if it's not too much work).
>
> What I'm unsure about is if and how incoming connection requests from
> other devices with HCI_PROTO_DEFER flag are supposed to work and whether
> they are meant to trigger a "Create Connection" from us?

For incoming connections on Classic that should result in an
accept/reject connection command, so it should cause another Create
Connection if that is what you are afraid of.

> >
> >>>
> >>> Thanks,
> >>> Jonas
> >
> >
> >



--=20
Luiz Augusto von Dentz

