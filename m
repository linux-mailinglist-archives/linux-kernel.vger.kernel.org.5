Return-Path: <linux-kernel+bounces-29921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630FA831533
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C171C221F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4722B12E41;
	Thu, 18 Jan 2024 08:56:50 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE02125A7;
	Thu, 18 Jan 2024 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568209; cv=none; b=GjwrvmQcDMbX8/kb177U87Gf3b4SSrv1C55T3f/lmdja/gKxVyo3sv8DKjn2qWpulmlId7fLtHVsehnovCcmS298gVDN1vm941qGBa9hE7Edm/i5t7qYG2rJEQuI4S2GioiJvNKOYjhqDS1Wg1WauphqalJKE4s1EkY+E3ddGbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568209; c=relaxed/simple;
	bh=DKc/D2UkkHwXWH4OMtAGeleG7U/HKVCzA9yBkCaGT+0=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Received:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=NYXvvawTfbzrnhh0eSuAQ5GCvQTyepo8laaCRSgCMFytHGELNMMlYo5yfdSE67NdCHYruYCJYt4hXp3kWPPReB1SRCPX55tPAXKAVo9avbxAAPSRZJy5TNFJaIWSPUv7U2YZyXwiYoSyW55Geo7s/PgW8qqSPnEGkMEMMDfFfUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f0629e67f4so120156667b3.3;
        Thu, 18 Jan 2024 00:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705568207; x=1706173007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yUhp044KaG5kosWl9TplBzHfM0oWfk1S3xB5Nr0ifxs=;
        b=FvWJE/IPvz4lef+pVbRhjQJ+a74ODWgOqPsnOqRMJhlUcMPUsJsYz/m0xDD+uQRZVb
         M5Zcw4cvslSQwDr78Y/XbcKF6OhGQZDHfVTxydmSCLaI+NDMYqRFQGWfsckRH/xzLO0E
         3y64QD6L2W7qMisjMQ2tWCn6X/+WcYscilCuf+Xn8LBjfbpxSYHjim6En7AddQ456u9k
         5F7ccKKYRsKaCV/2cg4zC+09CMK4MRsjAmlYsEPFALMRJyIMTQY/PaKAMja9xS8PLOrC
         2obhYP61iDQ6g0GPRSxIFWi7YjllZ5bMMWHX7Azrv/hhI77reGT2lUIGxBKOUVMq16Ek
         Icww==
X-Gm-Message-State: AOJu0YxtIUBYGvamLpgqEZ4z/rop1sanGLiHwdVxZ7Zu5QusJuNY6xN1
	6mdNFiGXLM7+PNvO8haJPlhW1EL+IsifeiF/C9TG0AhcpWhbi72uW0sGjOHkWTM=
X-Google-Smtp-Source: AGHT+IF6lL8EQfZZdv6kebQAfAHjechw+y9fjjKUjzfE0aS4EkBi7nItihgyegNwcHj3R9ZgnE0F/w==
X-Received: by 2002:a0d:dbd4:0:b0:5ff:63e0:885b with SMTP id d203-20020a0ddbd4000000b005ff63e0885bmr418769ywe.76.1705568207309;
        Thu, 18 Jan 2024 00:56:47 -0800 (PST)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id v67-20020a814846000000b005ff88cbbc93sm286920ywa.111.2024.01.18.00.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 00:56:47 -0800 (PST)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so1839225276.0;
        Thu, 18 Jan 2024 00:56:47 -0800 (PST)
X-Received: by 2002:a25:86c5:0:b0:dc2:42fc:135d with SMTP id
 y5-20020a2586c5000000b00dc242fc135dmr352561ybm.62.1705568206842; Thu, 18 Jan
 2024 00:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118075756.10541-1-jirislaby@kernel.org> <20240118075756.10541-20-jirislaby@kernel.org>
In-Reply-To: <20240118075756.10541-20-jirislaby@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jan 2024 09:56:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU5P9v9ofeeMA9M+kbHv2fSikChZCS3=tbaAZmG8dwF6A@mail.gmail.com>
Message-ID: <CAMuHMdU5P9v9ofeeMA9M+kbHv2fSikChZCS3=tbaAZmG8dwF6A@mail.gmail.com>
Subject: Re: [PATCH 19/45] tty: vt: make init parameter of consw::con_init() a bool
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Thu, Jan 18, 2024 at 9:03=E2=80=AFAM Jiri Slaby (SUSE) <jirislaby@kernel=
org> wrote:
> The 'init' parameter of consw::con_init() is true for the first call of
> the hook on a particular console. So make the parameter a bool.
>
> And document the hook.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Thanks for your patch!

> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -367,7 +367,7 @@ static const char *vgacon_startup(void)
>         return display_desc;
>  }
>
> -static void vgacon_init(struct vc_data *c, int init)
> +static void vgacon_init(struct vc_data *c, bool init)
>  {
>         struct uni_pagedict *p;
>

Below, there is one more line to update:

    -        /* set dimensions manually if init !=3D 0 since vc_resize()
will fail */
    +        /* set dimensions manually if init is true since
vc_resize() will fail */

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

