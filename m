Return-Path: <linux-kernel+bounces-11552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAEF81E81E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B164B21BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4634F217;
	Tue, 26 Dec 2023 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYfuZXYE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB954CB53;
	Tue, 26 Dec 2023 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccbc328744so16608901fa.3;
        Tue, 26 Dec 2023 07:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703605220; x=1704210020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hj/YtDE1HieIgLU8cZsELqjG+tdptAzgf1YDfH1SyI4=;
        b=kYfuZXYEHNA+XSRh2Za+JPKRmB6XVW/bzjpOjhdCJe3Gb/YevzBPiLFRzIeYec0+NQ
         WgRWA7MsazVUVpbb92r1FQymocldXZJwk6T5f/wPpB6XHj/tuuqpI2n1Qr+dHcLl0U60
         sTL4nhzkKecqarQGp9RMYHmPb3fZ5/lsYghc/IPljqZ2bhidb8Ok8ZtPrj6IcfC44ogk
         iWli8Lm1Meu5RPe+chTDXRZpVnAnFXEJYO0GJoRQHwqEkS6pSBGkKgDIM/78T7zwE8yf
         ARGwDFKBdoq6lIQkSYfuvnIkyXtvG8qlu++2YsIaGddLZqjQ0B5+vK5S/WfDYoPele/e
         AUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703605220; x=1704210020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hj/YtDE1HieIgLU8cZsELqjG+tdptAzgf1YDfH1SyI4=;
        b=Wt4JFnYFDK8Yf/oNx1rxrUwdZ3Cr2iCpjnF8w7O3LgyKCU5QghgqOawJI5kFBySGTt
         QPcsLxjCS+SFbAZQYypmiu3QTWZh42RCrYsif8LZM16v++RJnwWM3j3GQtWv/qxLonxl
         ZeZMcrHL+OWhA5+KBYp0zwDWUSDluguQSJxutGcyQ6TyiG4qqeILd+bbRK4Wmb+IuDll
         42rkAMl3BWTmoXDOKlwvbQOQbdQd8h2m1POtGMieya+V0k7NG/w1Zsp3kFUDfJl9hCZ0
         ykW2bZcTe60T/nKy24a59SjOuSAJtKKTEqK3a+yWtg/mMXKN+5Rsog3VfgMw79gs1N6i
         LA4Q==
X-Gm-Message-State: AOJu0YyQd+wlp7O9TlvIVD8k92evixSIEXsQXrR60nwJUQ75YDOcSQZu
	ixNisayi9rmTLLWDJ2Z7g5RBcL3Oy1iiURNqG+o=
X-Google-Smtp-Source: AGHT+IFRkHdO3Hqh1Cbn+WDhR36HIa2PUTdp5MdJW+XCSIjdm3f+ctzkQ7ICDiF7editnU8K9tHuRzoynXsQg6HIujM=
X-Received: by 2002:a2e:9f0c:0:b0:2cc:60bf:b2fb with SMTP id
 u12-20020a2e9f0c000000b002cc60bfb2fbmr2835720ljk.104.1703605219446; Tue, 26
 Dec 2023 07:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226060818.2446327-1-clancy_shang@163.com>
In-Reply-To: <20231226060818.2446327-1-clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Dec 2023 10:40:07 -0500
Message-ID: <CABBYNZJQFD_=VcFZxK=AugixVMgc=Zw4WPgQn+ax28cNGWBGUQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix hogp device suspend bug
To: clancy_shang@163.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clancy,

On Tue, Dec 26, 2023 at 1:09=E2=80=AFAM <clancy_shang@163.com> wrote:
>
> From: Clancy Shang <clancy.shang@quectel.com>
>
> when Bluetooth enters suspend, and disconnects everything with the
> disconnect reason code of 0x15, the hogp device could not into sleep
> and continued advertising. when use the disconnect reason code of 0x13,
> the hogp device going into sleep succeeded.
>
> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index d85a7091a116..16b5420c32d0 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -5927,7 +5927,7 @@ int hci_suspend_sync(struct hci_dev *hdev)
>
>         if (hci_conn_count(hdev)) {
>                 /* Soft disconnect everything (power off) */
> -               err =3D hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_PO=
WER_OFF);
> +               err =3D hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_US=
ER_TERM);

So the device interpretes that it can reconnect on power off but not
on user termination error? And you think changing the error would make
this interoperate any better? Afaik user termination can be generated
by various reasons, including the non-clean termination ones, while
power off error is quite clear on the reason, so instead of using a
more generic error you probably should contact the device manufacturer
and have it fix this problem and until then Id probably disable wakeup
support since it doesn't behave properly when receiving
HCI_ERROR_REMOTE_POWER_OFF.

>                 if (err) {
>                         /* Set state to BT_RUNNING so resume doesn't noti=
fy */
>                         hdev->suspend_state =3D BT_RUNNING;
> --
> 2.25.1
>
>


--=20
Luiz Augusto von Dentz

