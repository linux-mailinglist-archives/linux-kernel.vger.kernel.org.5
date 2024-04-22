Return-Path: <linux-kernel+bounces-153538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBD8ACF57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88721F214B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54C14F105;
	Mon, 22 Apr 2024 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfpGl6Yc"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693365028B;
	Mon, 22 Apr 2024 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796012; cv=none; b=ubm+ruYJHZOxXKtAKx1kXdThP/s6+u8WR+KIPfQNXWOr5OSrJ5vZhjFLlJXrVYdSCNT2Ol8HGso31gd+2gVJkiQ1VlpQhiA0/DsKMrSfO16MyEdqPXbWMveWHHqjVae3x3i4wUi46jhlcnLHPEfbP2EVC6N0R9ReY15GD+ZeyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796012; c=relaxed/simple;
	bh=ndyb3WCIBF0MkwDkWYq9dvpu1dX63fvYCWWODidMEkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JX2zpY3NoxvuMph+e0b4zO17W0J/hgakmxltUmFm0Ma3O2vI6lT2yDCz35BvQHc8UKyu1AxssfUG5Wvj/ZCPowOFUjhEdKVvDSTiJWBmtRztJ6q0c2qID9ptrs1G1MrcM38LtcrX/uuxadaZ9+t8/RqBhxcM9zs3DPcXD/w33Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfpGl6Yc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so5925577a12.3;
        Mon, 22 Apr 2024 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713796009; x=1714400809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndyb3WCIBF0MkwDkWYq9dvpu1dX63fvYCWWODidMEkk=;
        b=kfpGl6YckwX8HDZV8/g4loBO51ODKB6+mkSCiTir+QXkknj7Z9DbPraPadQFD35Z51
         o5vpSsFHx1uBugaYVDqjNmQIryqtnsPz/btfi6n5V8is5IQvcxfHzgdjHrYTxEkgTEPK
         ku91LJxF44eu/wklkC/CUfOv819y7ulifJokQXJB+TA6AoldJhK/CCm3JutEF4cwY6zC
         2hGdtx+1e1DNAbsJtIdvwTd1m5Zocoygy7Hx1fEiEX0KrTkCYj3TsW58rsqzunVyra7n
         2o0w+mFX+pAzxwiMnSBH2kg3JXxRo9WLBFtBthLL8J3ouL2HqKcbSmVa+vNXHMBpix6c
         mQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796009; x=1714400809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndyb3WCIBF0MkwDkWYq9dvpu1dX63fvYCWWODidMEkk=;
        b=uDPdctti7/ARDIVRQ+4fV1hOD1Zf9me1MN9KUQ/B84RiQxSYjtGqtfGOjpf7yeLmzU
         F2suYF27UKQDa6Eurf9PMNM/TO5Ffh0YCrP4Vf0AWYJzmH8KIZ6GlZiItHt+smCl/BXf
         yPiVmN0zbA0+O+HigsjI/nZzzeEB66Krf4umlL41DjAYwj3MTuvbji0lbl+LJLJDy9Oa
         4dxW9ZRTT6R7RHBU+7CwVVXlV91PWKI00G4Z3MshMx5HXvebv715S8ysjn8OVtkyTuOm
         5yqm7pvrIdE8ieoZ/D5hrJOV1LWYPCynn4GpejBQEOSByeH0edbMRwzfShOBuvfoUrOK
         O3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCV85oKaQfnaa05PTS3TIhOq4XmivlFEZ5GXysMWXEHn6/xKpTWiVBm6NaM2tlpJbnKWDbDmsK+1HzWHM3zLEKfLfQ3ztDLFnn7eJahUqrrOwM+ie3OmL/ktvS0BR8M2JTl/yDPl9G6GNxFY
X-Gm-Message-State: AOJu0Yw+sDyEpnAgT+VvkAdm3ViZ7VByXiuwkhE6XwGzASKYtTTvRHqR
	kKoc7Bz0wVXWWldw4aGl3cpwiVrtuz7KVvsoQnMCVOarCPbS6vcn2QL+7HM+WxvdOH1O0U9Cgcz
	Pm/8U8GZ6Qm5B8+6OAlmxNdPUb8g=
X-Google-Smtp-Source: AGHT+IH9FjNdARKI+JxtbwbDm14gWs6NyZLMcz0evw0Qtl0r+/tng0InrBOF/GDSk3Zmtqb23ErtQnShVCJVzshY0dY=
X-Received: by 2002:a17:907:7d8c:b0:a55:b7b1:5996 with SMTP id
 oz12-20020a1709077d8c00b00a55b7b15996mr2178417ejc.47.1713796009431; Mon, 22
 Apr 2024 07:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422123801.2695129-1-rilian.la.te@ya.ru> <20240422123801.2695129-2-rilian.la.te@ya.ru>
 <ZiZcyhoKRgfteO5d@smile.fi.intel.com> <CAF1WSuxPmzWYhCQU3tiA_GYMLowxMuvEJWRv83atithv8NCRxg@mail.gmail.com>
In-Reply-To: <CAF1WSuxPmzWYhCQU3tiA_GYMLowxMuvEJWRv83atithv8NCRxg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 17:26:12 +0300
Message-ID: <CAHp75VcJo61=KhLPZnm4G8s_0-pZJSkAiYT=UFq=770TddodAg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, 
	conor@kernel.org, lkp@intel.com, vz@mleia.com, robh@kernel.org, 
	jcmvbkbc@gmail.com, nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, 
	corbet@lwn.net, ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, 
	Maarten.Brock@sttls.nl, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:18=E2=80=AFPM Konstantin P. <ria.freelander@gmail=
com> wrote:
> On Mon, Apr 22, 2024 at 3:56=E2=80=AFPM Andy Shevchenko <andy@kernel.org>=
 wrote:

..

> Andy, I need to do v7 (because there is a missed fix), but Yandex do
> not allow me to send more mail( So, can it be sent next day?

You must wait, as it's spelled in the documentation and common sense.
Let people have time to review that. I suggest for this series the
cadence ~3 working days, so next one on Wednesday evening (European
time) or so.

--=20
With Best Regards,
Andy Shevchenko

