Return-Path: <linux-kernel+bounces-37838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BDA83B645
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15C1EB21F08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F49D136F;
	Thu, 25 Jan 2024 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChTDwg+C"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D3EA9;
	Thu, 25 Jan 2024 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706144079; cv=none; b=HOWyCxBrz2DaPgtW7cU5gLTlvHfWCaFtAnXOTHZXUI8DePyVwSbcVheTgZDVmqwZY+J/kYnCcFX2SdOculVW8IArFE8jFe11wGYd7aHiPu67Bysw6/Oxu4HN8ru6GvG7C1g+1nff10BBRyPHbmT+kzb8f7J4lfVsZ9G0uPKiwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706144079; c=relaxed/simple;
	bh=FzqykWuCJoJoX4tybj34XyCUyvzGyTun6uDYiAW2pF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlheHPobVg6v3Djyxr9RXxOvTWB17JCUBDql8ha32OJ9dDXZYl162TeLay5+R7fSbY6TgormGhjd8+fgacriy8AsY/YyyiKLvhaUXhrJhGp9Es6C6uChNX9iLpXsLMFPd0KdA0QUYsnzQVtoL2tScHSwdRcrNO+LR9ds9gQXat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChTDwg+C; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so6001520f8f.1;
        Wed, 24 Jan 2024 16:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706144076; x=1706748876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3GLAs2BQsaDpmFe+ANpjbfXLSKm2rkObjJFpjMlSgg=;
        b=ChTDwg+Ceb63BN8Ze8Ja4u/fnxbTEckj0wgqV3JHYL1gfQrx03SdIuN/1GvakJpaUU
         71oVyISfjU95UNeQKkgJrRYbYLVgokf3kEdE5L+4JvnEOZZT1eA8vSpXYoMdq2QxSWNQ
         d3fHVhWvk9zqMRJpIUcXSFM045snetw7T02fM29rXWEMyQe3BEb6wQ451cuTgxvPUp2I
         jGtKe1M3I91FnrFgn5GtIghDmPHNLxOJE8IGKdmeMQBLTwIX/XJSiZ8viAQMyjoJWmKn
         FHf4HpKPKk9wHu6dRvmsGwIzz01NwxpDFKlMrf4w68bXYLPSoIvgxLn3n20oCff1Olvw
         3cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706144076; x=1706748876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3GLAs2BQsaDpmFe+ANpjbfXLSKm2rkObjJFpjMlSgg=;
        b=VSfynBxR7BeFcaoUi3NG4ZAI5ndHFyw86qpWnNTpaDwBCIC32uZ5neo5npc43F5Z0q
         TbwQf5Azp2UHPsmBu76RiLibrzF3fLKOzE+Uw44bu8r1xlo4aup6XZl98b06e2icxzoH
         qv7LQ7mPSd7kx1p+ZqX5f3C1cflssYq3dmNqTMCTn4XTL+RsYIAMvDKZ7IZRnK4sJCN1
         gLHVwwy7qJD7leGZcLrHd1MFxczn+KznoaRnaNr9B7cIqPaRT2X0FRETrkVr+9e/v1O9
         bIAceONkeDhyHx/EeuqcjsvUZeJcUSpVgp8gZjoc9lbBFEDnit+8d0tF1jAAZEaWkH9p
         HISg==
X-Gm-Message-State: AOJu0Ywy7a5/KnjgHIWCrX/RdKOaokMUUBnnKlb+i3HYOYWI2X5ZSqot
	Tfmhi22ynanYordpv362aJYkQ9/0QfDHWysDpttqd/CTYi2q+zveS03f9g8ClGb8QdqdGCSkmmG
	bmq3GPJIgk0+sFkBf/sCoNtotHv0=
X-Google-Smtp-Source: AGHT+IEzwiwY5RszluMn7OqT13AbBUtnewaJ0/R/SanG04IhAzps06ydKPEVCj9zr3Txlqe2GX/YPGi3TF8NqSqdJq8=
X-Received: by 2002:a5d:56c5:0:b0:337:9f44:a0b4 with SMTP id
 m5-20020a5d56c5000000b003379f44a0b4mr99803wrw.24.1706144075979; Wed, 24 Jan
 2024 16:54:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-6-max@enpas.org>
In-Reply-To: <20240115144538.12018-6-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 24 Jan 2024 16:54:24 -0800
Message-ID: <CAEc3jaCYWpXX=YgeNzXJd0Pg4yn4WKqL=GBSAzaWNzo=3RSw1A@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] HID: playstation: DS4: Parse minimal report 0x01
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max,

On Mon, Jan 15, 2024 at 6:52=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> Some third-party controllers never switch to the full 0x11 report.
>
> They keep sending the short 0x01 report, so let's parse that instead.
>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/hid/hid-playstation.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index 2bf44bd3cc8a..086b0768fa51 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -287,6 +287,8 @@ struct dualsense_output_report {
>
>  #define DS4_INPUT_REPORT_USB                   0x01
>  #define DS4_INPUT_REPORT_USB_SIZE              64
> +#define DS4_INPUT_REPORT_BT_MINIMAL            0x01
> +#define DS4_INPUT_REPORT_BT_MINIMAL_SIZE       10
>  #define DS4_INPUT_REPORT_BT                    0x11
>  #define DS4_INPUT_REPORT_BT_SIZE               78
>  #define DS4_OUTPUT_REPORT_USB                  0x05
> @@ -2198,6 +2200,7 @@ static int dualshock4_parse_report(struct ps_device=
 *ps_dev, struct hid_report *
>         int battery_status, i, j;
>         uint16_t sensor_timestamp;
>         unsigned long flags;
> +       bool is_minimal =3D false;
>
>         /*
>          * DualShock4 in USB uses the full HID report for reportID 1, but
> @@ -2225,6 +2228,18 @@ static int dualshock4_parse_report(struct ps_devic=
e *ps_dev, struct hid_report *
>                 ds4_report =3D &bt->common;
>                 num_touch_reports =3D bt->num_touch_reports;
>                 touch_reports =3D bt->touch_reports;
> +       } else if (hdev->bus =3D=3D BUS_BLUETOOTH &&
> +                  report->id =3D=3D DS4_INPUT_REPORT_BT_MINIMAL &&
> +                        size =3D=3D DS4_INPUT_REPORT_BT_MINIMAL_SIZE) {
> +               /* Some third-party pads never switch to the full 0x11 re=
port.
> +                * The short 0x01 report is 10 bytes long:
> +                *   u8 report_id =3D=3D 0x01
> +                *   u8 first_bytes_of_full_report[9]
> +                * So let's reuse the full report parser, and stop it aft=
er
> +                * parsing the buttons.
> +                */
> +               ds4_report =3D (struct dualshock4_input_report_common *)&=
data[1];
> +               is_minimal =3D true;
>         } else {
>                 hid_err(hdev, "Unhandled reportID=3D%d\n", report->id);
>                 return -1;
> @@ -2258,6 +2273,9 @@ static int dualshock4_parse_report(struct ps_device=
 *ps_dev, struct hid_report *
>         input_report_key(ds4->gamepad, BTN_MODE,   ds4_report->buttons[2]=
 & DS_BUTTONS2_PS_HOME);
>         input_sync(ds4->gamepad);
>
> +       if (is_minimal)
> +               goto finish_minimal;
> +

I would say let's turn this into a 'return 0'. The goto is not useful
since there is no need for any common cleanup or some other common
logic later.

>         /* Parse and calibrate gyroscope data. */
>         for (i =3D 0; i < ARRAY_SIZE(ds4_report->gyro); i++) {
>                 int raw_data =3D (short)le16_to_cpu(ds4_report->gyro[i]);
> @@ -2365,6 +2383,7 @@ static int dualshock4_parse_report(struct ps_device=
 *ps_dev, struct hid_report *
>         ps_dev->battery_status =3D battery_status;
>         spin_unlock_irqrestore(&ps_dev->lock, flags);
>
> +finish_minimal:
>         return 0;
>  }
>
> --
> 2.39.2
>
>

Thanks,
Roderick

