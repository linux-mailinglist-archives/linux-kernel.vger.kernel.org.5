Return-Path: <linux-kernel+bounces-67701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF73F856F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723E4286200
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD17D1419A7;
	Thu, 15 Feb 2024 21:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGX5XVcr"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6A78B67;
	Thu, 15 Feb 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708033045; cv=none; b=aO2A7X9GhcDcFqPRyuHiVNZAu+L0prnB8+9T8p1opmX914KqwxedCCpRs0UF6f64GbIrSz5d+BCaT46DKRRQgrqP74j0P0Nx3Qa6T+APTOyhYHVeYbS1E/+FLxEtMVyNNLdkOlX4dDoTAhj6+KCyXoGepgpz57CNotGpgV3vhr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708033045; c=relaxed/simple;
	bh=p/D9l2LdVjVoAxXGUB9gV8bM6nr49Q8Re2/x44lUbeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KyzuRwtIb5WOZCN0xA9dH6UPHcnhbWBEJiJU/oZ8Cl1z1Tyh+HKEWd4gbC58pJfsLKdE+jSa9gkSrZOqugwDALaYo/E8tww6zPAaKzsuKsY2tZ0PFsuo9RhW+9iYxMvv/wG+kiPOPqLYB8NwyfSBF6BGPa9VpIJWV+/DlDMoSXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGX5XVcr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d11c55d7f2so20004831fa.2;
        Thu, 15 Feb 2024 13:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708033041; x=1708637841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ol+RYFc5wfSm1Xn8806GCkiU2EP3qs/UQCZpQ/EGEHo=;
        b=kGX5XVcrX3gONT5gLe9rNRObvZ7YTAj3Vsk88u9YOAswgl9Z8bNuPMNoM/WxW32k3/
         NwfmB7+j6h6jvYlcsIeLqzPx+IIXPDotqYbqE5pG9GVr5l8vyadIjdaaeGQK9CE1gYSU
         eCaXXHFK1JVBGXhbQM4fSaCoNaYV4j9BCpk87Rte7cqxQ+eWMrxy1F07SFD+e+IXge7m
         JniY8W738rtImcLukoxGkDAgfVJTI5gLeGeuIZ5Xc3bmt/cGlfAAgmKtRFAICd68qiL3
         wpzse1kW0ykzpxA2/+ELjGK9CEjBoDSvPK9ASqmOCTHnSkE2JWikjsAbU2yIVYucwLmn
         tIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708033041; x=1708637841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol+RYFc5wfSm1Xn8806GCkiU2EP3qs/UQCZpQ/EGEHo=;
        b=eih42D+9h2KkuSMry6URUhXmN6AJXFsHtgKKTrXAxsePGSZamwF/Q3EWlZuoXZFzpn
         sFcpsfo+bR4fu8J85o/IkvPx5OdGo8hlt+HOPOW//goqg7q9KKYItv7m23B1evfJ/0C3
         TBRJlVFFOfD6AmSfdnHI6fDNTTN7ar9AgjNjcRrBpYCSIsQXkOUg3PU4gJsbm2ZL9eqb
         ovilYlZ4iEXyJAxTRcYyp6fiuiLK48kmV5s8Am/T3pfBc5F5G7lUS/trut2BKE4yeD/C
         ZXKSswzqZb4vsbSknpXw4yC6M/Mo0o2I6XJFNNS9eLGqH2NTrLU01OcunZc25hnBKy5H
         VKnA==
X-Forwarded-Encrypted: i=1; AJvYcCWB0EUJadZLKYBiAY0yzdVY94DZYpHgnj755tzas1pgrWPnVe6Aa1w3gKXMPGg3yyyLyQ4FsWu3mm0JfB0DeCt1qCA8qeqJmCNAyfhY
X-Gm-Message-State: AOJu0YxzHsas118Fizvcq7j6XHSXnvNBMoxC5yx93b/CMa6+Su+mx7U0
	GPlikirWH2Tsie8ntYEOjkp3aT5bYarGfJ94lTIB0a8yZdiq3U616EQOun7Hpi+hjttbJufWO0x
	xwD8OxbkMWexfOSyWCf15jVQ4DlxEgYqeh9I=
X-Google-Smtp-Source: AGHT+IELuCSsPf84pwsOCk4aUHy02twIqt/HBSuX/1xhhd4uvCiI1n3TZxLr1CRHUsp046hOZUgGa3EdVp4gxfsG1kQ=
X-Received: by 2002:a2e:b6c6:0:b0:2d0:fa56:84ce with SMTP id
 m6-20020a2eb6c6000000b002d0fa5684cemr2104070ljo.52.1708033040935; Thu, 15 Feb
 2024 13:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
In-Reply-To: <20240214012328.BlueZ.1.I10eda6f375bc8dfedf4eef3a8cf6572c65803afc@changeid>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 15 Feb 2024 16:37:08 -0500
Message-ID: <CABBYNZ+MJRSAWHjgNTNwcWCdq5y0zBU5f8XJvr1tv3LCqvdKJw@mail.gmail.com>
Subject: Re: [BlueZ PATCH] Bluetooth: hci_core: Skip hci_cmd_work if
 hci_request is pending
To: Hsin-chen Chuang <chharry@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Tue, Feb 13, 2024 at 12:24=E2=80=AFPM Hsin-chen Chuang <chharry@chromium=
org> wrote:
>
> hci_cmd_work overwrites the hdev->sent_cmd which contains the required
> info for a hci_request to work. In the real world, it's observed that
> a request from hci_le_ext_create_conn_sync could be interrupted by
> the authentication (hci_conn_auth) caused by rfcomm_sock_connect. When
> it happends, hci_le_ext_create_conn_sync hangs until timeout; If the
> LE connection is triggered by MGMT, it freezes the whole MGMT interface.
>
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
>  net/bluetooth/hci_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 34c8dca2069f..e3706889976d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4213,8 +4213,11 @@ static void hci_cmd_work(struct work_struct *work)
>         BT_DBG("%s cmd_cnt %d cmd queued %d", hdev->name,
>                atomic_read(&hdev->cmd_cnt), skb_queue_len(&hdev->cmd_q));
>
> -       /* Send queued commands */
> -       if (atomic_read(&hdev->cmd_cnt)) {
> +       /* Send queued commands. Don't send the command when there is a p=
ending
> +        * hci_request because the request callbacks would be overwritten=
.
> +        */
> +       if (atomic_read(&hdev->cmd_cnt) &&
> +           !hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
>                 skb =3D skb_dequeue(&hdev->cmd_q);
>                 if (!skb)
>                         return;
> --
> 2.43.0.687.g38aa6559b0-goog


This seems to be causing some mgmt-tester failures:

Pair Device - Sec Mode 3 Success 1                   Timed out   22.753 sec=
onds
Pair Device - Sec Mode 3 Reject 1                    Timed out   22.533 sec=
onds
Pair Device - Sec Mode 3 Reject 2                    Timed out   22.526 sec=
onds

I think this is because we need to respond to an event with a command like:

< HCI Command: Create Conn.. (0x01|0x0005) plen 13  #241 [hci0] 16:25:38.69=
9066
        Address: 00:AA:01:01:00:00 (Intel Corporation)
        Packet type: 0x0018
          DM1 may be used
          DH1 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow peripheral (0x01)
> HCI Event: Command Status (0x0f) plen 4           #242 [hci0] 16:25:38.70=
1881
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Link Key Request (0x17) plen 6         #243 [hci0] 16:25:38.70=
2375
        Address: 00:AA:01:01:00:00 (Intel Corporation)

But because Create Connection is pending we cannot respond to Link Key
Request, so it is actually a design problem if we cannot send commands
because something is pending so perhaps we need to redesign how we
store cmd_sent so we can have multiple outstanding commands rather
than just one.

--=20
Luiz Augusto von Dentz

