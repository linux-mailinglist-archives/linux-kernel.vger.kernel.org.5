Return-Path: <linux-kernel+bounces-17992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F62D825684
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EE9BB22F6A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123BF2E635;
	Fri,  5 Jan 2024 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I81dc2fj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3128328B3;
	Fri,  5 Jan 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so21232771fa.3;
        Fri, 05 Jan 2024 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704468133; x=1705072933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAsrQIjxQMwzjAX4MlmzebgjZ3WSzdCGhy6tyRE0rKw=;
        b=I81dc2fjvTXi9Qf8U1oUGMVEZ0l5/X6eZmSX1VjQVpDa/ORfMIZB3+Cam4XZZMCUsE
         B3KwA9h3WEY63eXznVBLfdtp85A8FoUmEi1tHVIglFii9sGU2w962DWijO3FM+hRRP/B
         AQ52MbuaCRpV+qUKap7oV/0qy+kUz8UME2wGq2b0JzmL6m3aWrkfzpWnLIRgULvqQ4Bx
         evu+6qP9MVTt/kl9B7A2yb4j8Yv9sG2E7Rq2U1cyBVzLkcHOodnZzCLeI+IIzipgJC9+
         WNhexjNgjlKA5Zt34kaslrH6ubymxthfAKoZFtGaf3A7XSrdjzo+8ElVrFg+URcu9vKG
         AhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704468133; x=1705072933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAsrQIjxQMwzjAX4MlmzebgjZ3WSzdCGhy6tyRE0rKw=;
        b=ICAX5vRU95rrEWeW2QfdMLENLG5DBRZsiLYuOx8tx9Dge+pi6cHgvk79RJkKopq16t
         CQHOwD+dArQk8BJ/QIuUovroOlImSROI/sCV4qWzmVqHAkLURjwBLjrT0Csuk1pPt3At
         NsrKHawmM2slrZ6cGY+nu4wR6LNRDlw7lGVTBt3nFFCgfELp/DTvLfQGCe6/OQKNSy24
         sWUAxs9qWwoE5JCmjQyB5bx0jRpBTh3KMWFNhfZ27xjSwj3OgtxXSsTgYppupi2VQX4L
         ShOLvnaaGzwAqhIHrqFh9gykYrLizTEQQ6rCVEoP6vf4Hb2CNthlz0N2SXSattMlorVc
         C9VQ==
X-Gm-Message-State: AOJu0YzXMhf/xwPtEQKn4niSkO00CHnUlxaNOnmvCWr78+13YfQcrew8
	qBu6UayMsdmNw259DeNLJCXSWaNxh4dz8R47CekWu669PBo=
X-Google-Smtp-Source: AGHT+IHohJ7DdOCL0br8xfbhkXEAecRiduLqQXhdZLb7+bERm65KyWqjkuG6Sx6xCYEgVNlXWk1ELkBsCzRvJdN72bI=
X-Received: by 2002:a2e:a481:0:b0:2cc:effb:cbd0 with SMTP id
 h1-20020a2ea481000000b002cceffbcbd0mr1072384lji.55.1704468132560; Fri, 05 Jan
 2024 07:22:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105025625.125895-1-clancy_shang@163.com>
In-Reply-To: <20240105025625.125895-1-clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jan 2024 10:21:59 -0500
Message-ID: <CABBYNZJRTfDUizZ=+JDGT3rZDRJ1HCvYBssrCfgrxOm4U8d-Qw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix BLE devices were unable to
 disable the wakeup function
To: clancy_shang@163.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clancy,

On Thu, Jan 4, 2024 at 9:56=E2=80=AFPM <clancy_shang@163.com> wrote:
>
> From: Clancy Shang <clancy.shang@quectel.com>
>
> when BLE master enter suspend,  it does not delete the peripheral that
> in acceptlist. so if disable the wakeup function, the BLE master scans wi=
th
> basic filter next time, the peripheral can be scanned which is unexpected
>
> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> ---
>  net/bluetooth/hci_sync.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d85a7091a116..abc7f614da5f 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -2533,6 +2533,7 @@ static u8 hci_update_accept_list_sync(struct hci_de=
v *hdev)
>         struct bdaddr_list *b, *t;
>         u8 num_entries =3D 0;
>         bool pend_conn, pend_report;
> +       struct hci_conn_params *conn_params;
>         u8 filter_policy;
>         size_t i, n;
>         int err;
> @@ -2585,6 +2586,15 @@ static u8 hci_update_accept_list_sync(struct hci_d=
ev *hdev)
>                         continue;
>                 }
>
> +               conn_params =3D hci_conn_params_lookup(hdev, &b->bdaddr, =
b->bdaddr_type);
> +               /* During suspend, only wakeable devices can be in accept=
list */
> +               if (conn_params && hdev->suspended &&
> +                   !(conn_params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)) =
{
> +                       hci_le_del_accept_list_sync(hdev, &b->bdaddr,
> +                                                   b->bdaddr_type);
> +                       continue;
> +               }

This might require a lock since that is not a copy of the conn_params
which can be updated concurrently, so perhaps something like the
following is might be safer:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b3141e3f9cf6..eeb73a54fd26 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2206,8 +2206,11 @@ static int hci_le_add_accept_list_sync(struct
hci_dev *hdev,

        /* During suspend, only wakeable devices can be in acceptlist */
        if (hdev->suspended &&
-           !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
+           !(params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)) {
+               hci_le_del_accept_list_sync(hdev, &params->bdaddr,
+                                           params->bdaddr_type);
                return 0;
+       }

        /* Select filter policy to accept all advertising */
        if (*num_entries >=3D hdev->le_accept_list_size)

>                 num_entries++;
>         }
>
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz

