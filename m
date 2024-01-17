Return-Path: <linux-kernel+bounces-29185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB6E830A60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AFB1C23E20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F102231F;
	Wed, 17 Jan 2024 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJOPGU9E"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0292209F;
	Wed, 17 Jan 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507651; cv=none; b=bRaKDA9viNh0yDmXpGCaAFVvcUyYogXzndb12zfmdGbbHrguvsPGMvq+dVSTZ8zDIfMHgmQCyDZZwaiqNU+y6KiQ4zh4mmQDti/oXk54czlNhjkbZKHn8xP4OIFVBUiuVsoWcsCaxqZJXzOxd6IeP+1hGVSWPrDZ24doeB7jYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507651; c=relaxed/simple;
	bh=Pt6/Laf5caE2AuXw4AhcoXLhTOdqETCSl9vEqaK0dOo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=mqVjVBf+2wl4Na1FAGOpDgbwTZSK6BvfeMxw4ETgnqUy4MWOyfr+TermRLsvsejVJjPtqLVjrzio/rOUkjV4nas0/Pr45+vrXsJyTvvcJ0V8hJlpIHcOzeaaxxWB9EBzZK6i9jwHnFwSAjXHKn1B0KLyVBH9xJ4fB6FDRkQFvGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJOPGU9E; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-337b976773fso1864228f8f.0;
        Wed, 17 Jan 2024 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705507648; x=1706112448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOLnXzAsbzKvRY+jTL8FAUZUJfwwLzT0EUqM2CJtgGE=;
        b=OJOPGU9E6ymHGKWscBNntqz3sA6AXEDpQU4nksYfzu1SRHNqAjY9g+k3Jbe43XIXDD
         op2kvu9x4bhnZDPw3d6pDVq4XRfEJnYHJfbmQusntFRBzXdUuA+WSOwKPv5l4GuZ39RP
         Emrhuo/zQshdIPGRLNFqf3Ts7UXLfNB8clvUDwrGOBXwua7CIZYYyJ5NXVynEjXPg4LO
         Hl0sMOaR6KEEGu6du3nwqsjGmKNd2Acfm8IqP+3miFw/W4cdEsFG3D6pqIH4VKcRhmC2
         Rmy2Qvlyz67qTHB5tJNELmdis8vcu4dT+2qIpTevBAAWsWD9vZ0xDq+ojJly2iNJXLgh
         W9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705507648; x=1706112448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOLnXzAsbzKvRY+jTL8FAUZUJfwwLzT0EUqM2CJtgGE=;
        b=BoLSx/jgszAAZ5Aa4V/IV4AueFF6wqc4Q9J3IWWO5wB+F/EDsOigDj1rjMDy1TuV7s
         SeYth/5iHRpl/DN1hK+KQfi5ksV/0eIa5ELmGOFHiS3MnjSP9U41EwUIY6zYEr68f6Bx
         LDv1bbdYsfBNphBLeT+emU1TPcLLggvpur4w2MYD1u6gHzAS/JPVdTgp6D9fyMXx81T0
         HDUV6C0ePR8sjGRHC94gGMKh0mHT2n0DkdzeBg29s16NLhpPbhYPaniKSQdRbTKUm34E
         xG0OVyxvnFM9yTh1sKklAg5Zo4LbNjvX38WWUQ1mBW5z8XLaKE/GBjyyKYs63BdMapLE
         sKlg==
X-Gm-Message-State: AOJu0YwGbayPaOUrKgSZgaBg6THDJDLZVhpvBKacao+w9TyNBqopMK07
	HO+zzbltzUEfRVFfVxzbVXwUB3uKbOGeOhvVD/A=
X-Google-Smtp-Source: AGHT+IGNjx2lbJAgGFge9QaR9KuSRNYSUEkNCrXT26MYHJeTZ4JR6QRl6Ko0TaFSeSiWHuFCOcKamHA/EaRbAcf2+k4=
X-Received: by 2002:a5d:4e52:0:b0:337:9f44:a0b3 with SMTP id
 r18-20020a5d4e52000000b003379f44a0b3mr3517963wrt.31.1705507647872; Wed, 17
 Jan 2024 08:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117113806.2584341-1-badhri@google.com>
In-Reply-To: <20240117113806.2584341-1-badhri@google.com>
From: =?UTF-8?Q?G=C3=A1bor_Stefanik?= <netrolller.3d@gmail.com>
Date: Wed, 17 Jan 2024 17:07:20 +0100
Message-ID: <CA+XFjioEL4ZcdDZgK2N3squudx8T_DJGrwNDCaN-2XJ3Nb4sXQ@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "usb: typec: tcpm: fix cc role at port reset"
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: gregkh@linuxfoundation.org, linux@roeck-us.net, 
	heikki.krogerus@linux.intel.com, kyletso@google.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, rdbabiera@google.com, 
	amitsd@google.com, stable@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This will break operation of batteryless devices relying on a USB
Type-C port for their power needs, as the port reset upon controller
initialization will cause power to be cut to the device, resulting in
a boot loop.
Devices using the FUSB302C port controller are especially severely
affected, as upon losing power, this controller can retain CC states
for a very long time (potentially forever if some parasitic source of
power is present), requiring a full mechanical disconnect-reconnect
cycle before the device receives power again.

While the USB Type C specification does require this behavior, I would
consider this an oversight in the standard (perhaps left over from
when USB Power Delivery was still going to be USB Battery Charging
2.0).

Badhri Jagan Sridharan <badhri@google.com> ezt =C3=ADrta (id=C5=91pont: 202=
4.
jan. 17., Sze, 12:38):
>
> This reverts commit 1e35f074399dece73d5df11847d4a0d7a6f49434.
>
> Given that ERROR_RECOVERY calls into PORT_RESET for Hi-Zing
> the CC pins, setting CC pins to default state during PORT_RESET
> breaks error recovery.
>
> 4.5.2.2.2.1 ErrorRecovery State Requirements
> The port shall not drive VBUS or VCONN, and shall present a
> high-impedance to ground (above zOPEN) on its CC1 and CC2 pins.
>
> Hi-Zing the CC pins is the inteded behavior for PORT_RESET.
> CC pins are set to default state after tErrorRecovery in
> PORT_RESET_WAIT_OFF.
>
> 4.5.2.2.2.2 Exiting From ErrorRecovery State
> A Sink shall transition to Unattached.SNK after tErrorRecovery.
> A Source shall transition to Unattached.SRC after tErrorRecovery.
>
> Cc: stable@kernel.org
> Fixes: 1e35f074399d ("usb: typec: tcpm: fix cc role at port reset")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index 5945e3a2b0f7..9d410718eaf4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4876,8 +4876,7 @@ static void run_state_machine(struct tcpm_port *por=
t)
>                 break;
>         case PORT_RESET:
>                 tcpm_reset_port(port);
> -               tcpm_set_cc(port, tcpm_default_state(port) =3D=3D SNK_UNA=
TTACHED ?
> -                           TYPEC_CC_RD : tcpm_rp_cc(port));
> +               tcpm_set_cc(port, TYPEC_CC_OPEN);
>                 tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>                                PD_T_ERROR_RECOVERY);
>                 break;
>
> base-commit: 933bb7b878ddd0f8c094db45551a7daddf806e00
> --
> 2.43.0.429.g432eaa2c6b-goog
>
>

