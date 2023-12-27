Return-Path: <linux-kernel+bounces-12148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B46881F096
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5ACA282422
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E605746424;
	Wed, 27 Dec 2023 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6gFjB8+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C1286AC;
	Wed, 27 Dec 2023 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ccbd9000f3so26045231fa.2;
        Wed, 27 Dec 2023 08:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703695679; x=1704300479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XrjQy/o97Qaqx7whLd+nAIygM1hlHgt6eEFP61yvaI=;
        b=C6gFjB8+WFg2bMSvSR958Ti2lEfItILImNGia3GtAfbANZB+nQwrlNFK0t8/zRujl4
         GBnIkdrAQdw/qPuec7Q7OyeG93IyTdZ9Y40xd/wPys3kWyK1xjnJN1+5ET+bTujN7r8I
         7WcyXC7HrT8FRSjGQyi//5KxlOoROjU+X+VxYtzK5MxVgyspZAJvt30ZhC8JYOxKYobp
         n9OQ/aCysD2kjaJMsM43+4TZmbeJFzzGvRicnm1xntsTGKU76wjikG7CWHmW1P725EOL
         OpImUfhuxh0+wC2a5Gxth/Imukq4wErf5WbZPx7Jnvy4Cy8wPzlWvGhYrDf4i5nAjGLw
         DZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703695679; x=1704300479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XrjQy/o97Qaqx7whLd+nAIygM1hlHgt6eEFP61yvaI=;
        b=CI+IPEbEJOUg2YlFB02GsQ861G+XlR3iALIPrr8jdfMsFP5bWmrP7i4LENLnJBsKY5
         MoRZjggABavfmCLaWAbkgr0jZm/VNrB2xaGS/7dPaQnK9mz+Ao0mdxGpetgYTosfTQC2
         RlrlML4jRC7/A0WVTsRmBOVDrPMgwSPVxKUo/GIgkKyg8EMctdP6IbJUkBmRb0+tbNXa
         dPsvpGN/gS/Mg6e9yJpPsNqOujrX3vfjeZyUFT70qRAgoX3JwMLq5ukTb3gEeklUKI6C
         BLB9o045Hk57QaCZN7jWR15ixAwj78E817b7s2RMBA6BkNMJvjTibI1DQZjbL3OB4VP/
         UmXQ==
X-Gm-Message-State: AOJu0YxmX4V2YF/2M2I7ja3KWcP6O4KGbHQBCU2tUzpyzQP7QWwNa3TC
	Esi2zD3rm+wwtLkYc70JjBTrL1XarlLdp3LiwFQ=
X-Google-Smtp-Source: AGHT+IHEPgjJKhTCDleUp0O07TTkQIXi60fl1ouXm+MI5WGWzWr50Uzqr+U5HBBMtqClQf3kxox1rBslJpoD4Ry3XEc=
X-Received: by 2002:a2e:3a03:0:b0:2cc:9435:a5f8 with SMTP id
 h3-20020a2e3a03000000b002cc9435a5f8mr3695304lja.6.1703695679189; Wed, 27 Dec
 2023 08:47:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226060818.2446327-1-clancy_shang@163.com>
 <CABBYNZJQFD_=VcFZxK=AugixVMgc=Zw4WPgQn+ax28cNGWBGUQ@mail.gmail.com> <6358e9a9.6c6.18ca8e3e1cf.Coremail.clancy_shang@163.com>
In-Reply-To: <6358e9a9.6c6.18ca8e3e1cf.Coremail.clancy_shang@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Dec 2023 11:47:46 -0500
Message-ID: <CABBYNZK782JSRsxmNGFFSiEevrdzAomWUYnUYX0tFirNFBCqHg@mail.gmail.com>
Subject: Re: Re: [PATCH] Bluetooth: hci_sync: fix hogp device suspend bug
To: clancy_shang <clancy_shang@163.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Clancy,

On Tue, Dec 26, 2023 at 8:29=E2=80=AFPM clancy_shang <clancy_shang@163.com>=
 wrote:
>
> Hi Luiz Augusto von Dentz,
>
> Thank you for your reply.
>
> >>And you think changing the error would make
> >> this interoperate any better?
>
> > Yes, I think change this make the interoperate better, this is my test =
report.
> if i don't change disconnect reason,all hogp device can abnormal wakeup h=
ost device
> when it into suspend.


It seems you are targeting gaming controllers, none of these models
handle POWER_OFF reason? I bet that we can probably make a case for
both Microsoft and Valve to handle it properly.

The core spec actually describe a proper way to detect the so called Link L=
oss:

`3.1 LINK SUPERVISION FOR ACTIVE PHYSICAL LINKS

To be able to detect link loss, both the Central and the Peripheral shall u=
se a
link supervision timer, T supervision . Upon reception of a valid
packet header with
one of the Peripheral's addresses (see Section 4.2) on the physical link, t=
he
timer shall be reset. If at any time in Connection state, the timer reaches=
 the
supervisionTO value, the connection shall be considered disconnected. The
same link supervision timer shall be used for SCO, eSCO, and ACL logical
transports.`

`CONNECTION TIMEOUT (0x08)
The Connection Timeout error code indicates that either the link supervisio=
n
timeout has expired for a given connection or that the synchronization time=
out
has expired for a given broadcast`

So anything other than the error above shall _not_ be interpreted as Link L=
oss.

HOGP Reconnection Procedure is only meant to be used when a Link Loss
is detected:

`Link Loss Reconnection Procedure
When a connection is terminated due to link loss a HID Device should attemp=
t to
reconnect to the HID Host by entering a GAP connectable mode using the
recommended advertising interval values shown in Table 5.2. The HID
Device may also
wait until it has data to transmit or until the next user activity is detec=
ted.`

This means that Reconnection Procedure shall _only_ be triggered when
Connection Timeout (0x08) is generated, otherwise it shall wait until
the user activity is detected.

>
>
> Kind regards,
>
>
> Clancy
>
>
>
>
>
> At 2023-12-26 23:40:07, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> w=
rote:
> >Hi Clancy,
> >
> >On Tue, Dec 26, 2023 at 1:09=E2=80=AFAM <clancy_shang@163.com> wrote:
> >>
> >> From: Clancy Shang <clancy.shang@quectel.com>
> >>
> >> when Bluetooth enters suspend, and disconnects everything with the
> >> disconnect reason code of 0x15, the hogp device could not into sleep
> >> and continued advertising. when use the disconnect reason code of 0x13=
,
> >> the hogp device going into sleep succeeded.
> >>
> >> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> >> ---
> >>  net/bluetooth/hci_sync.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> >> index d85a7091a116..16b5420c32d0 100644
> >> --- a/net/bluetooth/hci_sync.c
> >> +++ b/net/bluetooth/hci_sync.c
> >> @@ -5927,7 +5927,7 @@ int hci_suspend_sync(struct hci_dev *hdev)
> >>
> >>         if (hci_conn_count(hdev)) {
> >>                 /* Soft disconnect everything (power off) */
> >> -               err =3D hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE=
_POWER_OFF);
> >> +               err =3D hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE=
_USER_TERM);
> >
> >So the device interpretes that it can reconnect on power off but not
> >on user termination error? And you think changing the error would make
> >this interoperate any better? Afaik user termination can be generated
> >by various reasons, including the non-clean termination ones, while
> >power off error is quite clear on the reason, so instead of using a
> >more generic error you probably should contact the device manufacturer
> >and have it fix this problem and until then Id probably disable wakeup
> >support since it doesn't behave properly when receiving
> >HCI_ERROR_REMOTE_POWER_OFF.
> >
> >>                 if (err) {
> >>                         /* Set state to BT_RUNNING so resume doesn't n=
otify */
> >>                         hdev->suspend_state =3D BT_RUNNING;
> >> --
> >> 2.25.1
> >>
> >>
> >
> >
> >--
> >Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

