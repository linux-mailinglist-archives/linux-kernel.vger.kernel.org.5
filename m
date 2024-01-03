Return-Path: <linux-kernel+bounces-15718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA44F8230DD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 766931F24A61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3673A1B28C;
	Wed,  3 Jan 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Apn/sAvO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4E1BDC2;
	Wed,  3 Jan 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd053d5683so26877771fa.2;
        Wed, 03 Jan 2024 07:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704297320; x=1704902120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBL9Qlw0s9HFYXJhGaaKeiT1PrvQ2SXf3tpTJ4/9DV8=;
        b=Apn/sAvOwHkQEwx+qyZYiLV6CdzxiKwwwPCng8d/kV0wJ/XYP3Iv+IQaxFP2WAbj58
         E7A4Zl7tYYbmfRWA7vZk77pZixFRy9J0Cf0YxyHPAhFlH7U8JHdppu5oed1TN5TIbSdp
         ROP3zgws6plkvSXgPh0zUcZPk47l7vgGmU9bP42mBaKqo8hkeCPw25BvOD/Ue1sgtpr6
         zZdG7pZDVdBNYqyTbAGQ87lPK1iSnoNlj6lM+2hiT53RiBg5VO8yvrjIq42CmVuPKTGs
         np8AvRPAunGWDZVJ7gqIHhkeTaxV94vJ6oFVkID7qTHi/WQibR5yIjZuxY0jPzfEujYC
         ZiVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704297320; x=1704902120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBL9Qlw0s9HFYXJhGaaKeiT1PrvQ2SXf3tpTJ4/9DV8=;
        b=Pggj0TYCk+U8vvZX1ZdgWxpNa4Hj3c6sFSWZ0aTkESovYUbhEQxQRWLjcyIrdIBGrl
         xCgcKFb3220YSNvC4tyOFqusC8bvqm9fvTip3CCq3UteP44DOTTSQVYJn9HSJnBFBncg
         fGi5wdSggGRoRHGCTv7LpwEJ11vkFoJr4Qw/yP+/+YGuJrjC73z6o9nlNEgMiO++ccHT
         uPVs3tYzmDwTtUA7E6dA/zkPaJU6pkNcukWOxMPoxzDMheSaTLPl4WeJcNjFEcluFHlf
         A9/i5v3fTXl6ksx929Rv9T74DXkLP/c/98qeLjgXwtBo7Tkkw/TQgM58TP3nIeYaBNP6
         2P3w==
X-Gm-Message-State: AOJu0Ywm8Bo3HwbGplbY8iXIOMrm1gFIsq4qmwz28R+i5QEHEmICm4Jh
	gwkOcSg0GFRAFHRyqq1yaYoDT+8mDrlZFxpJack=
X-Google-Smtp-Source: AGHT+IF5Wm64hVkZ2r/6KR3R9lcK/6o4Q8H5mbV6WqP5Q66wa4IPcHzCETBSF0Bv/lJDOVVHMJNNANgPOdHUJnIF+DU=
X-Received: by 2002:a2e:9643:0:b0:2cc:ea26:38d1 with SMTP id
 z3-20020a2e9643000000b002ccea2638d1mr3842952ljh.45.1704297319902; Wed, 03 Jan
 2024 07:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103101201.1812679-1-clancy_shang@163.com>
In-Reply-To: <20240103101201.1812679-1-clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jan 2024 10:55:06 -0500
Message-ID: <CABBYNZL=Tfe=Psg+JEjVqZBFv=vrbyhYa-5HzZJAOSe5aOAtgQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: fix hogp device suspend bug
To: clancy_shang@163.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clancy,

On Wed, Jan 3, 2024 at 5:12=E2=80=AFAM <clancy_shang@163.com> wrote:
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

Are you actually paying attention to my responses? I did nak this
change before, so we need to find some way to detect the device is
handling HCI_ERROR_REMOTE_POWER_OFF as link loss, which is wrong, and
only then use HCI_ERROR_REMOTE_USER_TERM, so please don't keep sending
the same patch over and over until you make these changes.

>                 if (err) {
>                         /* Set state to BT_RUNNING so resume doesn't noti=
fy */
>                         hdev->suspend_state =3D BT_RUNNING;
> --
> 2.25.1
>


--=20
Luiz Augusto von Dentz

