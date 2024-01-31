Return-Path: <linux-kernel+bounces-46814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 932AD8444A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475291F304EB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280C512BE8F;
	Wed, 31 Jan 2024 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N83M/nAR"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0CCA7D;
	Wed, 31 Jan 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718908; cv=none; b=fn/83hER3fvPr1FkUcv2pQ/RovlqoMj1aHlFZdbJykDp6uJgGG6HgCSCv35oc+vwAh0Gq+4ZnSxwJ4/0FohFEtHZ5XppnXVYt7aV2RcElB2Fqpwy1wGdrRpnL4+p0YrbD0k4sJHwVy9djoCAv2jIA/ZSeTYaH/9s89qrDZzHyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718908; c=relaxed/simple;
	bh=Qxiwueyh/N0KuzbrKpLYmDwQR9CuTnvfmMEhL4GQrlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If35p9kJBq2WxjsUdKmQyI/fCUISuQvDLgOrJEEi5i4iAqBL55NRCqAbhF7Yh4nUjtnoQWPZfGN9yKNVtAdtFGRtXnkNNhxoRdBG9NBGmMQQpRedxMCh8TuD/gC3DghANc0NhOiqrFEswmu9LmsfSnIudMAONg49v7qlZwmqQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N83M/nAR; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6636389a12.0;
        Wed, 31 Jan 2024 08:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706718905; x=1707323705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qxiwueyh/N0KuzbrKpLYmDwQR9CuTnvfmMEhL4GQrlg=;
        b=N83M/nARtlq8TDeC3nWTaosDxZtDtvKtAAEpcugtNM8/F0Q7HQfP0oMP18R0aQZtpT
         QOkpJxPu28ysVeAYkV8MJssqVmwazknpcV7IiTKPlGzPmknRFaa6rxAaMYKtOZ9uY8kE
         bHqI+K8afXyqSLD1Rh5KNqfh3Ug1/M9g5aH344oTIcS2A8ssSNmpF317f+FaNwcaQhCR
         H/Exv4qqvme/Ya1YoIOqWiS5z2c55AxiI5H9QsPxxC/RcBrjrlqQSbIdj+aGV2FReHdc
         bNvKcDlkwUU4z4aZ41Gs45rFnyOu0lHIHb37hNXaT9sf6nlNOsCBdQJUpNGzmyM/9Vm3
         /NgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706718905; x=1707323705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qxiwueyh/N0KuzbrKpLYmDwQR9CuTnvfmMEhL4GQrlg=;
        b=hfQSWtDNE9YHTqd8nrJVjzPACGkViwoehgAzBIz+Um4i10zz6qMK9Bqra9fUbMruKa
         u3k3zIP7edFpTJSRIDa7gU956asCIoHk1/k2DoxN4YSicJBuqF8vnUxSm/zDAE3JLAAD
         oeZMWjD1Rss0cwwpaJoDH7Gc9+VSQ3GVuR10VyUeihd1uljhAis7Qmuw8dziQZ3q/ZOG
         DQLZyPRbB2/RQ6z6hUgzopVnSiRgfv3xbBUogCYWtdS0qCE4TDhfBElaCTvQd1sxszYw
         H9nOe4j4UqsysKsPuR2dARN6Skp2yVhxuDFx0XlH479WfohaF0xkhcIUuETOhBgG0nZn
         iVsA==
X-Gm-Message-State: AOJu0YykcglMnNGpP8FSYF6DBEqpItHLTNdtulm2me7rZpfgUi4SvtH/
	YMoocNdDgTh9c6opJ1ODwVA/SAmM8bBWcnfT6zAphS0XUhWSBNgnvhNkFPHoGjs9lYETbSdBVJ0
	sJ29/7fM55r3NQ84RGKlteV25XXo=
X-Google-Smtp-Source: AGHT+IFTPsfCpWtWwT/4tqGg2+ajs4IBu4Nn68Hpw/Qm0A92fu/SG1iDQWZj1DT+I55z5nXhPVcjeMLdufKIh/bnpmE=
X-Received: by 2002:aa7:c3cc:0:b0:55f:43f4:9ba with SMTP id
 l12-20020aa7c3cc000000b0055f43f409bamr1354833edr.34.1706718904679; Wed, 31
 Jan 2024 08:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-8-max@enpas.org>
 <CAEc3jaBU3M0Zce2pdFvdBSG50a7Ky=GY4gLO3dkYdDrkYtiO0Q@mail.gmail.com>
 <e107b202-5843-41a7-b61e-68dd92128176@enpas.org> <CAEc3jaCifoWW3ZXHvySSfgwhVm1AffYe=z7HRP9RjmYyu53w7Q@mail.gmail.com>
 <d5d301c6-172d-4204-88cc-2dc9b351e693@enpas.org>
In-Reply-To: <d5d301c6-172d-4204-88cc-2dc9b351e693@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 31 Jan 2024 08:34:52 -0800
Message-ID: <CAEc3jaDFh3UY8AGnXA3s13DbcKTFnBT8Z7iq4qdqnM5o3nVHFA@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER controllers
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:48=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> On 1/31/24 06:07, Roderick Colenbrander wrote:
> > Hmpf, euhm euhm I'm not entirely sure what makes sense. From the
> > sounds of it are somewhat broken devices (buggy firmwares on them) or
> > perhaps one of your controllers (the one with not working touch) is
> > perhaps broken.
> >
> > Some of the patches like handling report id 0x1 (minimal) won't hurt,
> > the LED fixes won't either. It makes it easier to add more devices. I
> > wonder if we have fully have enough data.
> >
> > Need to think a bit...
>
> Yeah, maybe for now, let's focus on the patches that you don't see much t=
rouble with. Better to enable some devices, than none.
>
> I suggest dropping this here patch (enabling 7545:0104) for now, and if t=
here's ever a change of mind, we can just pick it from the LKML archives :)
>
>
> You can also drop the other patch that you're uneasy about, since I belie=
ve these 7545:0104 devices are the only ones I've observed to not implement=
 the what-is-your-MAC-address command.
>
>
>
> Max
>

I agree it sounds like a good idea for now to drop just those 2 paches
and just see what other devices are out there (SDL2 has a good ds4
implementation too and they dealt with a lot of devices). May need to
get some of the 8bitdo and many others to see some patterns.

Thanks,
Roderick

