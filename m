Return-Path: <linux-kernel+bounces-153403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFCD8ACDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C972854EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E54D14F11E;
	Mon, 22 Apr 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT7Ap/Ld"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BBD14A4C4;
	Mon, 22 Apr 2024 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790975; cv=none; b=UK1fQqyBw3Z3h0/L3s5vR3qPu4o2YDbjaMQ4tCUPCDiPZ94AXmGhrpUFhXwGgfz5VODHTaNU5b/W47glsplHY3/YuYk6gDVnTDNLL3ki+h6yRYk4BKqD6HUYBLREvpjcHMXs7KtrhQlPuGU6e9zeqaO4J2IOLfUVmTL+ObwuWBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790975; c=relaxed/simple;
	bh=t2+sKE0HslHFtPd+U0Q51wY48L1S/5UCwXt6NX009I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTHWIvx6jYT+o5fs4o6CwTqlDup6G+FdfZhosOLYA7MIJjrT+mko+o75ny2qcTJocTJG2hQz3o3jK5X/onk85BwlJdCLs1AJzXieK0EvShHMXt7bsdMb/b4hy+t+mwr3PBPm8WF6D4mf9+AhWSEO+sXZo7tHSfbXtwS1YKvxKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT7Ap/Ld; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56fffd131a8so1841182a12.0;
        Mon, 22 Apr 2024 06:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713790969; x=1714395769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2+sKE0HslHFtPd+U0Q51wY48L1S/5UCwXt6NX009I8=;
        b=OT7Ap/LdbemJKCRscklx15jb9/Xk0QjcWjxMJlBOAW5HHhsrSCv/uQZnCHXCknmETw
         X5bYkEXyos0dhVASJOvqHiviHYxWxEfhCZRvfUWMGlBLbGI578e5a25QsZGIjJdFeM19
         ptMGoltVyBXLzDhFC8CToMG7+iSuHUA07K1rOr7cMXTWXVg/eQzEl1J5hhCZ8H/OsWQ3
         ewfuT05MjKmqY/yqsSW6wo9Jog+ptRVb0QPpJKmHmwCTDDDsOZxtfivUwXLNuWLzGiue
         wJUYEq+IJ4Dxp1Ie4ivrpuaugKEmfde5nS8zGHQqeRet369zXMF6hsv4gp76MkHgxsHb
         ATrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790969; x=1714395769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2+sKE0HslHFtPd+U0Q51wY48L1S/5UCwXt6NX009I8=;
        b=r6fpZhgi87ZIEV3wFFVvODxnRO0PGH9stqdfZ6UjsEAlCv/1wL72K/73yzFxMUlMDZ
         ytCz3fm9CvUJoO67Oc1l4c4LzjaTR4xoJa16N8APXFeSU3rHcUaHvcTfn+v4ag2H2zpA
         kFb3+GiEOboNzlMWDRKYXKotK8IRWclKhrspIqOHlK46JufmiRTsTc+oI/Jxtb4OjuQV
         0tLyB62eQzMID5p16bktaBZt+P2vkKfgfPmguzqZBobLmHSiRCZOfkgLytAZYjXmwvxA
         70Y/nRdE/tJFo+KxIQEpBvL2FfrOzpOK0LJVWZjag+3pb5R8ggSygDoHP9awt1sLHhhN
         RTWw==
X-Forwarded-Encrypted: i=1; AJvYcCUMVJmzcMsX3Z8nu7xZ+nwVwZt1hhNdxsKGIVVPdEdZhGUfOd095YI1jBy4Q/44i6dTXEchr/VlFkelPqSx4q3WdsZ3LXB2UPAKtM4YyF5FKdL/dPTY5OfjSQmX9T7coGH6Mz4SLcW2dia4IB9UdYPkP4njVl59KNMBG0dgxLzQ4rWsOgOEgQ==
X-Gm-Message-State: AOJu0Yx+AAKt4SxkmSorV1stN53SyYFcsAr+aKeU02V+BnN653WhP5DQ
	gGrgvPn/sCX2XpFu6wp2M7ZUeVj1m87XPCh46ArhyeB8CuTrI0bVFbVNLI8xIF7d/v43SsOapfH
	Q7LT+RuLH9lHadiacFe1KsYoVCvk=
X-Google-Smtp-Source: AGHT+IFKVMheNb73b/4c+5LVIsP869+V2uEzBfTjhaKmRKbNbrd9wRhnmG+2HGL6eKtRMmLC6JOa8qNLG0+Dv3geJ6E=
X-Received: by 2002:a50:9548:0:b0:56e:2bf4:fe02 with SMTP id
 v8-20020a509548000000b0056e2bf4fe02mr8915587eda.11.1713790968857; Mon, 22 Apr
 2024 06:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422123801.2695129-1-rilian.la.te@ya.ru> <20240422123801.2695129-3-rilian.la.te@ya.ru>
 <28bde53d-f3ab-44c3-9ade-a42b2e0120ef@linaro.org>
In-Reply-To: <28bde53d-f3ab-44c3-9ade-a42b2e0120ef@linaro.org>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Mon, 22 Apr 2024 16:05:00 +0300
Message-ID: <CAF1WSuzXzbAqzp=PWbLt0oNZ5Pkhn_oCkSTWdNoSZMh_fAtvjQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:00=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/04/2024 14:37, Konstantin Pugin wrote:
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > Add EXAR XR20M1172 UART compatible line into devicetree documentation.
> >
> > Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> > Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
>
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/su=
bmitting-patches.rst#L577
>
> If a tag was not added on purpose, please state why and what changed.
>
> Best regards,
> Krzysztof
>

Yes, I am sorry. I missed a tag on v6 process. Will add on v7.

