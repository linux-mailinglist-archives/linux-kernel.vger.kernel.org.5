Return-Path: <linux-kernel+bounces-20011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09810827838
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E88B223E5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF4655784;
	Mon,  8 Jan 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERZO7pm5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A654F85;
	Mon,  8 Jan 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccbf8cbf3aso27887461fa.3;
        Mon, 08 Jan 2024 11:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704741087; x=1705345887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jov3ZKLRkU/twhQr/eXss79u9EeE0119uscHNpJ6qlg=;
        b=ERZO7pm5i+Bp9qicZW5ROYapLCX4EccBWx5pQSYqUY+iLT4UOhhTL8IW9FZqH8PJl/
         omq/kl7dyPPTatCCysn1Xf4xH43By+5TMP8CvSWi6+Tkjht2KNJJL74e+qSAxm2OdaWI
         Fg6ZNwIUYtuHrUzglbXNWR0DTvJmVNWd8yP2pEoiuvEYGRTQHxHK8YHxl1TG7dz+Bs/R
         0tcRopXhSuOuvlID+usyOHpzVzmNdXISqyAF8ZZ9rkcUdyv5YS2gx9kF1t2m//s4FhYz
         PBDLNr4Fdz10GwY12PKW1zcM++0r1VhQBTofNPCX11n9KK7+bKBzHE2C7deJtceY7pFB
         UoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741087; x=1705345887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jov3ZKLRkU/twhQr/eXss79u9EeE0119uscHNpJ6qlg=;
        b=HRiYcLAHuragfFS7gn2X5YVS2BF29Sm4edzn+KKIetyGBiPe/d7FhIOfukIsaAmBXe
         BMzmZpBNM/ob1EqVzOrrp7SYYYhtCeq5EKdMWJ66AUTKQW00I3SAXAOuf2rb9Bju6uV6
         8RoPOGWwu3O1zLSGPExtV05f5UbrxKbZ2dP37GTAKsRYv6Pg9VhPQikvDdXUjcG5PUls
         NuSg3S0oxqn+j5Hidr5Sx0+doFKqb4FWJXbci1x3OPVLCBHCDj7lrf9fjgw+wVvYQGIW
         shpH0goBUooh84bGNhq5v7/TOY4ZcR0pfheZKxhjP42Q1h94eJUgUtROkxpROyIzH0xQ
         /nyA==
X-Gm-Message-State: AOJu0YyvY7nn+yKceiwF70jdbeqVb07VKPxPHsZvySGiZ/UkvJFbh0JU
	PLOAI6p9US0aPJKSMaUMJQyVkSJJ8yAVaj0lumUlj18v
X-Google-Smtp-Source: AGHT+IGezgB3ZFieBoJfIZ2MA8SalePWRGnb2hFRUYFQbJSl6GQIgj86yvDhg7KLjrt3AEQC1IyZvSsTGOlOl4ASXzY=
X-Received: by 2002:a2e:9e84:0:b0:2cc:88ad:dd6b with SMTP id
 f4-20020a2e9e84000000b002cc88addd6bmr1766149ljk.76.1704741087091; Mon, 08 Jan
 2024 11:11:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108183938.468426-1-verdre@v0yd.nl> <20240108183938.468426-4-verdre@v0yd.nl>
In-Reply-To: <20240108183938.468426-4-verdre@v0yd.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 8 Jan 2024 14:11:14 -0500
Message-ID: <CABBYNZJ7yUiQjvwjVnuSM79ZRiXU-KY7zoCNny1F6UBwJofk6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_conn: Only do ACL connections sequentially
To: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Mon, Jan 8, 2024 at 1:39=E2=80=AFPM Jonas Dre=C3=9Fler <verdre@v0yd.nl> =
wrote:
>
> Pretty much all bluetooth chipsets only support paging a single device at
> a time, and if they don't reject a secondary "Create Connection" request
> while another is still ongoing, they'll most likely serialize those
> requests in the firware.
>
> With commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
> requests") we started adding some serialization of our own in case the
> adapter returns "Command Disallowed" HCI error.
>
> This commit was using the BT_CONNECT2 state for the serialization, this
> state is also used for a few more things (most notably to indicate we're
> waiting for an inquiry to cancel) and therefore a bit unreliable. Also
> not all BT firwares would respond with "Command Disallowed" on too many
> connection requests, some will also respond with "Hardware Failure"
> (BCM4378), and others will error out later and send a "Connect Complete"
> event with error "Rejected Limited Resources" (Marvell 88W8897).
>
> We can clean things up a bit and also make the serialization more reliabl=
e
> by using our hci_sync machinery to always do "Create Connection" requests
> in a sequential manner.
>
> This is very similar to what we're already doing for establishing LE
> connections, and it works well there.
> ---
>  include/net/bluetooth/hci.h |  1 +
>  net/bluetooth/hci_conn.c    | 37 ++++++++++++++++++++++++++-----------
>  2 files changed, 27 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index fef723afd..f2bbc0a14 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -427,6 +427,7 @@ enum {
>  #define HCI_ACL_TX_TIMEOUT     msecs_to_jiffies(45000) /* 45 seconds */
>  #define HCI_AUTO_OFF_TIMEOUT   msecs_to_jiffies(2000)  /* 2 seconds */
>  #define HCI_POWER_OFF_TIMEOUT  msecs_to_jiffies(5000)  /* 5 seconds */
> +#define HCI_ACL_CONN_TIMEOUT   msecs_to_jiffies(20000) /* 20 seconds */
>  #define HCI_LE_CONN_TIMEOUT    msecs_to_jiffies(20000) /* 20 seconds */
>  #define HCI_LE_AUTOCONN_TIMEOUT        msecs_to_jiffies(4000)  /* 4 seco=
nds */
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 76222565e..541d55301 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -229,11 +229,12 @@ static void hci_connect_le_scan_remove(struct hci_c=
onn *conn)
>         schedule_work(&conn->le_scan_cleanup);
>  }
>
> -static void hci_acl_create_connection(struct hci_conn *conn)
> +static int hci_acl_create_connection_sync(struct hci_dev *hdev, void *da=
ta)

Move the above function to hci_sync.c so it is simpler to reuse it in
the future.

>  {
> -       struct hci_dev *hdev =3D conn->hdev;
> +       struct hci_conn *conn =3D data;
>         struct inquiry_entry *ie;
>         struct hci_cp_create_conn cp;
> +       int err;
>
>         BT_DBG("hcon %p", conn);
>
> @@ -246,12 +247,10 @@ static void hci_acl_create_connection(struct hci_co=
nn *conn)
>          * request for discovery again when this flag becomes false.
>          */
>         if (test_bit(HCI_INQUIRY, &hdev->flags)) {
> -               /* Put this connection to "pending" state so that it will=
 be
> -                * executed after the inquiry cancel command complete eve=
nt.
> -                */
> -               conn->state =3D BT_CONNECT2;
> -               hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> -               return;
> +               err =3D __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_CANCEL=
, 0,
> +                                           NULL, HCI_CMD_TIMEOUT);
> +               if (err)
> +                       bt_dev_warn(hdev, "Failed to cancel inquiry %d", =
err);
>         }
>
>         conn->state =3D BT_CONNECT;
> @@ -284,7 +283,15 @@ static void hci_acl_create_connection(struct hci_con=
n *conn)
>         else
>                 cp.role_switch =3D 0x00;
>
> -       hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
> +       err =3D __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
> +                                      sizeof(cp), &cp,
> +                                      HCI_EV_CONN_COMPLETE,
> +                                      HCI_ACL_CONN_TIMEOUT, NULL);
> +
> +       if (err =3D=3D -ETIMEDOUT)
> +               hci_abort_conn(conn, HCI_ERROR_LOCAL_HOST_TERM);
> +
> +       return err;
>  }
>
>  int hci_disconnect(struct hci_conn *conn, __u8 reason)
> @@ -1622,10 +1629,18 @@ struct hci_conn *hci_connect_acl(struct hci_dev *=
hdev, bdaddr_t *dst,
>
>         acl->conn_reason =3D conn_reason;
>         if (acl->state =3D=3D BT_OPEN || acl->state =3D=3D BT_CLOSED) {
> +               int err;
> +
>                 acl->sec_level =3D BT_SECURITY_LOW;
>                 acl->pending_sec_level =3D sec_level;
>                 acl->auth_type =3D auth_type;
> -               hci_acl_create_connection(acl);
> +
> +               err =3D hci_cmd_sync_queue(hdev, hci_acl_create_connectio=
n_sync,
> +                                        acl, NULL);
> +               if (err) {
> +                       hci_conn_del(acl);
> +                       return ERR_PTR(err);
> +               }
>         }
>
>         return acl;
> @@ -2530,7 +2545,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
>
>         conn =3D hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
>         if (conn)
> -               hci_acl_create_connection(conn);
> +               hci_cmd_sync_queue(hdev, hci_acl_create_connection_sync, =
conn, NULL);
>
>         hci_dev_unlock(hdev);
>  }
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz

