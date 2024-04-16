Return-Path: <linux-kernel+bounces-147316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B90A8A726B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF89E1F23152
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D8413342A;
	Tue, 16 Apr 2024 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4C1FZxI"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C8F4E7;
	Tue, 16 Apr 2024 17:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288758; cv=none; b=PwU0E6fGOxeRh3kD8YVEuqa//uJ6jmWYZvz6W2vog/jQUjcb0gC/2CMNNFlyeqlcvlXMdrVaxaYzv05QLPkUYcV5HqzjFec+MNZMhDy0E/fWkh5Vg1e1TU0mBS/urXRtgtkRAApqqqh9PXxGjeoyN61I5HZhKZzJoY3xkOQeNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288758; c=relaxed/simple;
	bh=7VKV1EUsD87ldi+cT0aXudqS/r014jvpTOraAVsjgJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+/UVpZcjBYRqKcy/Nd6ToRg0m3NOUC34DUWaP3t7AcfKbcq8Z6owp3G9/5kbmnIUCLE5fATIopRnmNh/YkFs4KDcXoDYUIdjCVXXjmyn3WDtxGFcI14HdgVUy5Y0PXE3+DFjGCLCfCOc1yzvZlMmgWfUE3sF7qekgWOJ6fFyQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4C1FZxI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so3984818f8f.0;
        Tue, 16 Apr 2024 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713288755; x=1713893555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IO+hOuqEkrsrUsRHeAcDDvHavwu6kyd/enzsNdg3aQ=;
        b=G4C1FZxIulua8SaYrMChOcR2wM+amxqPUDes+dg1H56JlKo1qSw8yvU9nuTQ2DCQeS
         ni0AbsCkXFxy0zZXeaqI6Wr9/5YeXYewj04yEtBGPx6a0Zb9ORrUwz9quwbu+OqYl7IP
         OrqmAEgYjHrV8KovgFXVKDraIQOA+yDb97p6twFhcZza78Iq6qS4NJ2Qhxc7sYlAeidF
         5XykUx5cl26OBdbAYDOtmDxIrpNUsfgkwue7ON6kvrd/MBSuuKH7osvvIoDT7gA2FIH+
         RzTxTMQ/waRke455Xbq2ALQwCprqUc2PYI0Bpoxy/tJkii8+nwknOGqt+kea4tZW5pS+
         jZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288755; x=1713893555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IO+hOuqEkrsrUsRHeAcDDvHavwu6kyd/enzsNdg3aQ=;
        b=Wm1SlByESCfr10/QdhjqQpr9btdde4WDB4GDLlsCvZc6KpzebPiJMXHhl20NDKU6wu
         epHs87vQlfyj+VDDJczaBVOE/Gq+3ajy+vb9XHbe8v/V5YwBPwxwHegr+rORAvlOyLJU
         rjsPXRKTVfWwxk6D/hU2VOW20pnF1xF8djR+cN8zjkBqXV3uHfL1NIRKALUputVs93c8
         pmh/mhLF9ueHgtXrR2647JbAgdfZlzqejZ2kubC3aaLi+DEjztvbagZIzSG7PAwt3Irn
         vH+Yk4Wbav/KHYNunujCSBJboqe3hk24mLF8CqUUT+iicPr/v1rpA7t/55jLcG4g4S20
         Pplw==
X-Forwarded-Encrypted: i=1; AJvYcCXsMFXKWyYrkj7th37bi0+Wy1muaix5anZgsGuOio9yBEVb+ItmRI3jjoFCEpfDzG+mgnqbDFkh1I4v1Fsi86r2oBalYWtvdqYVJzbqMMBz6JwGH55cyjrRZDEKH9jHhbRmhSen1AEtuk3tovD1NTtnpKjE+o//99E8O6gkdSKojSwg4eXsziMHZLaMz1270Wu0o8WZO13b1cSjiYHLXmQXOz/+/rvGKQ==
X-Gm-Message-State: AOJu0YyDJc1anWzLs/KBOfqbH2Y3kaiQc2nedE9QtJ+9vWR3r9lC4Mqr
	6b/HGWFjuCkgETM+gkVtOVnKiCko92zdz2P71jBlC74JfGyniM8TKbYoG6Kwxuu29/c1X5JxdTV
	64AiXRZxIYuWyTHjfy4noiFCOxE8=
X-Google-Smtp-Source: AGHT+IHhkCf/2ZnzY6pNeLJbq60C0fBWHz8dbjiDAKTwhyZmVWd1gblADeMUbMwbc7myH0QHmC/VGj3aVOrkIOZb5sY=
X-Received: by 2002:a05:6000:d47:b0:343:734e:73d1 with SMTP id
 du7-20020a0560000d4700b00343734e73d1mr10848248wrb.37.1713288754926; Tue, 16
 Apr 2024 10:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416053909.256319-1-hpa@redhat.com> <20240416053909.256319-4-hpa@redhat.com>
In-Reply-To: <20240416053909.256319-4-hpa@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 16 Apr 2024 20:31:59 +0300
Message-ID: <CAHp75VdRgBqaX4NNvABS-90O34OtRf5t85JOjpG=tOw2SHr_tw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] leds: rgb: leds-ktd202x: I2C ID tables for KTD2026
 and 2027
To: Kate Hsuan <hpa@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:40=E2=80=AFAM Kate Hsuan <hpa@redhat.com> wrote:
>
> This table shows the maximum support LED channel for KTD2026 and KTD-2027=
.
> The 3-channel LED controller KTD2026 controls R/G/B three LEDs. The
> 4-channel LED controller KTD2027 controls R/G/B and a flashing LEDs.

and flashing

..

> Link: https://www.kinet-ic.com/uploads/KTD2026-7-04h.pdf

Make it Datasheet: tag

>

and drop this blank line (to ensure the Datasheet will be recognised as a t=
ag).

> Signed-off-by: Kate Hsuan <hpa@redhat.com>

..

> -       .shutdown =3D ktd202x_shutdown
> +       .shutdown =3D ktd202x_shutdown,
> +       .id_table =3D ktd202x_id

Exactly good example to show what the difference is between
"terminator entry" and "last field in the initialiser" and why in the
latter it's better to keep a trailing comma. And hence why the stray
change in the previous patch. So, id_table also should keep a trailing
comma.

--=20
With Best Regards,
Andy Shevchenko

