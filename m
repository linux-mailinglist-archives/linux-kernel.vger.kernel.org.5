Return-Path: <linux-kernel+bounces-20909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A888828740
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFDEEB237B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94F638FB0;
	Tue,  9 Jan 2024 13:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx2gKLx0"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9226D39842;
	Tue,  9 Jan 2024 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso32743541fa.1;
        Tue, 09 Jan 2024 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704807720; x=1705412520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o/iVAspJoPe7wwOlMbx4e7jS1dNzyLr6xVTp3jus74=;
        b=Fx2gKLx0oJf8sNNdjYerp9XZs+0TVIWaBd75SqtnT6irnzgFyjH6ZgLDmu/Fk9QEw/
         F8Q6dP4cs+T9crQRMSdZQzBlaVL6SLetWm6AKmfcSCunW0yklv2X5tXZKQnSuV8sKt/t
         mY2Yzn/c37f+PyFwIKFv2vWubc46Ec3uFPhgcg7mRFObFf4TMUv8QDw10azZkxzhircr
         PKPi0XwTDsCJuFYslRWSgA6M9e5bRkbEWDPVw3j3BXovG1zpjHyiTzGTPB2eaVfjEQBx
         R13RzVhsqMY+w+4fMVR879e3FLD55xUjwVKPqv2ruyBHrKDUKx2JqeBVgVRty2L6ZVr3
         VUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704807720; x=1705412520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o/iVAspJoPe7wwOlMbx4e7jS1dNzyLr6xVTp3jus74=;
        b=aBOVNdevccy4vF7B4/q8QcMYy9wg+dFhEpk+a3RTVz9Y3dF9dx3SZeKuS3l7EdPesz
         w6M3XMYLiQCUEOEZ4O4tXqWe4rA5M4J2rQ+qbZkgES/ogHBAoIAn9gEwOcYQhI02yQyN
         QPnlFj0uYWIF3jNtrZs77O2tyeL5kfuI5v+PGn+DEv8MvHCgHUsQ3In/OHbzedbVtHpn
         k9E/y4THoqmT4XnoI15j+7K1m+vuAGPxFcVfIAZmQWJLSCtoov7hkuJcg1QmzFxdr5DR
         mA7/poYcaxrAvCcb7bccioB+XOd73cswzlMu3sJVb6osuuKZZs+ZK5cWzFMnNR9H8c3V
         bOng==
X-Gm-Message-State: AOJu0Yxtx9ePOQ9ZhGHj7Ol25jT7bKh0WLkpfBkpVibKtbuf5VMNrvYs
	SvBhXhzwiWv0NSS+xoN/iRgvz2u3z8Xeln2Afco=
X-Google-Smtp-Source: AGHT+IHUtifv+RQldaVvD3tr60Zdyo2DCLNb52fzX/CgtibgnJ8LP3jhRLNEKVqax5ZhAKk3dSY3vezkhqyI38Si+zw=
X-Received: by 2002:a2e:a0cb:0:b0:2cc:7d70:fa45 with SMTP id
 f11-20020a2ea0cb000000b002cc7d70fa45mr2495792ljm.27.1704807720240; Tue, 09
 Jan 2024 05:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105025625.125895-1-clancy_shang@163.com> <CABBYNZJRTfDUizZ=+JDGT3rZDRJ1HCvYBssrCfgrxOm4U8d-Qw@mail.gmail.com>
 <5ebcd5f1.2a8d.18ced8b011e.Coremail.clancy_shang@163.com>
In-Reply-To: <5ebcd5f1.2a8d.18ced8b011e.Coremail.clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 9 Jan 2024 08:41:45 -0500
Message-ID: <CABBYNZ+GBcoru9F82BNfkr-R8Tv4psEjpKqLWxqRDnr=Ny_nxw@mail.gmail.com>
Subject: Re: Re: [PATCH] Bluetooth: hci_sync: Fix BLE devices were unable to
 disable the wakeup function
To: clancy_shang <clancy_shang@163.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clancy,

On Tue, Jan 9, 2024 at 4:26=E2=80=AFAM clancy_shang <clancy_shang@163.com> =
wrote:
>
> Hi Luiz Augusto von Dentz,
>
> Thanks for you suggestions. is the patch has been accepted? or need me mo=
dify as your suggested and resend to you?

It has been applied already:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D0bcd317e8b31833d36cd9843902905aafbd70017

> Kind regards,
>
> Clancy
>
>
>
>
>
>
>
> At 2024-01-05 23:21:59, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> w=
rote:
> >Hi Clancy,
> >
> >On Thu, Jan 4, 2024 at 9:56=E2=80=AFPM <clancy_shang@163.com> wrote:
> >>
> >> From: Clancy Shang <clancy.shang@quectel.com>
> >>
> >> when BLE master enter suspend,  it does not delete the peripheral that
> >> in acceptlist. so if disable the wakeup function, the BLE master scans=
 with
> >> basic filter next time, the peripheral can be scanned which is unexpec=
ted
> >>
> >> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> >> ---
> >>  net/bluetooth/hci_sync.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >> index d85a7091a116..abc7f614da5f 100644
> >> --- a/net/bluetooth/hci_sync.c
> >> +++ b/net/bluetooth/hci_sync.c
> >> @@ -2533,6 +2533,7 @@ static u8 hci_update_accept_list_sync(struct hci=
_dev *hdev)
> >>         struct bdaddr_list *b, *t;
> >>         u8 num_entries =3D 0;
> >>         bool pend_conn, pend_report;
> >> +       struct hci_conn_params *conn_params;
> >>         u8 filter_policy;
> >>         size_t i, n;
> >>         int err;
> >> @@ -2585,6 +2586,15 @@ static u8 hci_update_accept_list_sync(struct hc=
i_dev *hdev)
> >>                         continue;
> >>                 }
> >>
> >> +               conn_params =3D hci_conn_params_lookup(hdev, &b->bdadd=
r, b->bdaddr_type);
> >> +               /* During suspend, only wakeable devices can be in acc=
eptlist */
> >> +               if (conn_params && hdev->suspended &&
> >> +                   !(conn_params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP=
)) {
> >> +                       hci_le_del_accept_list_sync(hdev, &b->bdaddr,
> >> +                                                   b->bdaddr_type);
> >> +                       continue;
> >> +               }
> >
> >This might require a lock since that is not a copy of the conn_params
> >which can be updated concurrently, so perhaps something like the
> >following is might be safer:
> >
> >diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >index b3141e3f9cf6..eeb73a54fd26 100644
> >--- a/net/bluetooth/hci_sync.c
> >+++ b/net/bluetooth/hci_sync.c
> >@@ -2206,8 +2206,11 @@ static int hci_le_add_accept_list_sync(struct
> >hci_dev *hdev,
> >
> >        /* During suspend, only wakeable devices can be in acceptlist */
> >        if (hdev->suspended &&
> >-           !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
> >+           !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)) {
> >+               hci_le_del_accept_list_sync(hdev, &params->bdaddr,
> >+                                           params->bdaddr_type);
> >                return 0;
> >+       }
> >
> >        /* Select filter policy to accept all advertising */
> >        if (*num_entries >=3D hdev->le_accept_list_size)
> >
> >>                 num_entries++;
> >>         }
> >>
> >> --
> >> 2.25.1
> >>
> >
> >
> >--
> >Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

