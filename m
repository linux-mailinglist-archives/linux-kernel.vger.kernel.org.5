Return-Path: <linux-kernel+bounces-166859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AE78BA0F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE41E283A51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD49917BB21;
	Thu,  2 May 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv1+/p+k"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEDD17B4F1;
	Thu,  2 May 2024 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677401; cv=none; b=bRr7km8+oucZOYpmumMRvmUUVLpUoVYyLVm6UdASpk+m6HBLWY6zzur3lroJ9m0f/o3/sjde5xx3LK9urlatHF2U3aTVg2ZGZCxlFzVrz3V8idtnrTcSNfJYl57xSgJBgT02eK4lkf3LJiV7cOTdEZvXArZDi7nlxg2U2+NLNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677401; c=relaxed/simple;
	bh=TT47vrRaRN/6EIefMl1F/4OcvIvSeygmA+JHdGn8OQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lvfqf1Yjs58WqCLSPFWKQuAFVgVUsF2wHFGgWxOfj4a1j3rMyPhNvjIoU4zhgWhIYXJNn3Ms26U+Z6QoWrWSYQLewLaZ7b4NacvIyVuNDo3UmDcBdpL42u+talhdJDErx3bBT/hqrKTvDdYAAgMSojbLyUionoFzMFgSRcenvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fv1+/p+k; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572babec735so1197377a12.0;
        Thu, 02 May 2024 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714677397; x=1715282197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9Pt4LunRcuoSqyDxcU2IHHUezPKEgwmRljlzl98f0U=;
        b=Fv1+/p+kiQNBR7EPk2Li6EjVWqJqFKUMu1ZBJMXD2WCEVCpXhZa1LbTG7daFlaCrl1
         Hj4w9Vy+y1zlhv2Ud8PJaTzRW99GZsBX5fMxiPCTKdwpUOYIZiB1b2haoB7SvYyg4vMD
         zBdByMOJV17+/JiDAgqrWC+gGUj6lQMrk0kx924fouXw2Eglm6oEXO2qBLaXbhGtVV+0
         uJIaJs3BsRK246SIvlPFbtmvHmzTp2q68ZI7DLhUd+/5wmlzRKU4jYFVvpXqmGv0hwhN
         3NcjxrAp5ZxMRiVLCPoZzZpqMyJPNClSOvys3aeBYqrupcNVjVnGnPQcJByWUmZ7SEIL
         y2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714677397; x=1715282197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9Pt4LunRcuoSqyDxcU2IHHUezPKEgwmRljlzl98f0U=;
        b=oRLEhcSUNA2fNTMO/RdoL3pyNAROElwz4ttanc8y16sTe+0iLLqlvP6YGXNIpWMVje
         ztRGPXvRGX4cXJp/UKL1OZTvf3zN2pAf3jo4HkEn6SbroHnKHJyJj2NaCQ00ndOMTA5l
         NALcRVeD7XzqcXMxv1f6PjwCLUQl0TFf/XF0+6aKeOGDSYWew6QZdam67qyQFY+mxZn4
         FdLpP0MSPEFavqnHi/oINQN1rpl6f4VxpCBWn7nk2d+5JVllwqdgXh8U/pLIQzU6KWlt
         c93AQ3r8ppSyGtqwKK4LwZjEoN0bD3nYxUDn6emo5sulz795eUN5K39US72zg+2SCRC5
         AbXg==
X-Forwarded-Encrypted: i=1; AJvYcCXMJYF4hDlg1XbkOJICS6esyIrECFttmg0GB9/ENU0HULC62qjTOvdhLh8elJMZaUWxqv9W6qDM/hS8C4vV2tMRhCqXr7MGPffRo4nVwEjNPjwfeSbu0xQNup1YdrEN5hw9ZEc/rGOZWNQmjrly5nW/a8zdM8+xHJzm6hgR4EIHm7xOJyFH
X-Gm-Message-State: AOJu0Yz0qbTkIgVp8FrrgwDbtB9Znm/4jh5Ahw1jRwNHH+OTYTDe6FnZ
	hQlDlB4Rg++fcaFHsg/sLODvx6AkxXXQcKnMxqPZdXNOUT0KTk/aMfcV1btbOomCeO1sNNnwy20
	uhXFO/wFcmAaRjiRGf5o2xSiSUlmnKzeM
X-Google-Smtp-Source: AGHT+IHGvjzEzUwhbfnsN5ylBpZIHW+lskNYDCokbARhoq8LT4vlRCbRGeDTK35d5G85irUnsDWyY0xALprMDMW0Xww=
X-Received: by 2002:a17:906:c8d8:b0:a58:921a:970d with SMTP id
 gc24-20020a170906c8d800b00a58921a970dmr605540ejb.6.1714677397491; Thu, 02 May
 2024 12:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502185819.788716-1-andreas@kemnade.info> <20240502185819.788716-3-andreas@kemnade.info>
In-Reply-To: <20240502185819.788716-3-andreas@kemnade.info>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 2 May 2024 22:16:01 +0300
Message-ID: <CAHp75Vd1A8sy2Oky9TENUTAj0SCCyVQ8Zh49AN3X7t9cK2F+iw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: ektf2127 - add ektf2232 support
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, hdegoede@redhat.com, u.kleine-koenig@pengutronix.de, 
	siebren.vroegindeweij@hotmail.com, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 9:58=E2=80=AFPM Andreas Kemnade <andreas@kemnade.inf=
o> wrote:
>
> The chip is similar, but has status bits at different positions,
> so use the correct bits.

..

> +       if (ts->shifted_status) {
> +               ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & 1));
> +               ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & 2));

BIT(0)
BIT(1)

> +       } else {
> +               ektf2127_report2_contact(ts, 0, &buf[1], !!(buf[7] & 2));
> +               ektf2127_report2_contact(ts, 1, &buf[4], !!(buf[7] & 4));

BIT(1)
BIT(2)

> +       }

..

> +       if (dev->of_node &&
> +           of_device_is_compatible(dev->of_node, "elan,ektf2232"))

if (device_is_compatible(...))

> +               ts->shifted_status =3D true;

--=20
With Best Regards,
Andy Shevchenko

