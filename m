Return-Path: <linux-kernel+bounces-164641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786828B808A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E931F2456F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AC2199E88;
	Tue, 30 Apr 2024 19:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N13BeDhi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D3F7710B;
	Tue, 30 Apr 2024 19:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505490; cv=none; b=NWOA83gaJE38w+RcRoIg5MEXCxlUWioEQZsFdX8aCTnQMuP8POuQiAIo6MplfAGMLFm/Oc8P50WbuZ/4VqamVQHbxkvIiBTlZdD78UHOO+1OH0YdC1lCvSNe/a5UglRt6NAb8s2ugH+7Bd8AtDdLTzeHo0g67xgk9xRkRPpP28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505490; c=relaxed/simple;
	bh=mhy41vjENoR6b+CqGTnI/eloIr2Vx8ytZKvulKHNzTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn4/rPnMDQyNNHPKS2oJLnA2yTMR7/3bnCDOk03UMv1hJLP3XBL/9EqNKFJ2JdJ0qSv13xt5g39tVsnNU2uB850HE1Q97zegL9UkkG31R9Su9zXlhwuCjCOYcEFrSW8sNhvHQM4+IAbcr7S3Z5cf1Yy9bm7Yz4cLvVY5EY2usPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N13BeDhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98CFC4AF18;
	Tue, 30 Apr 2024 19:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714505489;
	bh=mhy41vjENoR6b+CqGTnI/eloIr2Vx8ytZKvulKHNzTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N13BeDhiB660miJEaL1LlMznqD3+vJ1u5mRWx16nl2LfmeJtaBZ5XtGHWz/bgrnVz
	 P1N31nGm2pn62kdlLHyx/PxufegT2+CC1RFQP0Apn0GmsbBzQnBIQQe2W2fQW3c7/W
	 EGL+I/p8LOXZDnbm2eh873NiUwLow42+BCq+9HuiQliltrg7mR0SY6Nw197GS7K9hx
	 j+BQ5eXfKFhycFjmXYOlNhJ7lwG/b8RrhizZvgS0KYiapsjKaBiXIru7E3M0AvoZhd
	 PS2Q4gSbvzhhkOfvi3PKH/omhj1AOUSEy95RbXqzinTzbrYs2yTJ6egc4mdraZ+JGA
	 Q9t08O2g2NzMw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a9ef9ba998so1433555eaf.1;
        Tue, 30 Apr 2024 12:31:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWA/I9NfQVHn95Ze6YYUQnk58Zh89Bpfl+njz87j3zmzyX7kCa56Qwa7ptqfsrktPN8konQoBppR7bKq0how8EI+HWTGF+kaSPolEhEVBmA3coOeflgb2SjVda+NiHTJmuQJfHaF6EaPw==
X-Gm-Message-State: AOJu0YwpQ8g9mnJvg61opPtKjWhtKK1GlbU7g2x12aX/x/wc0MCm1eda
	qGk/iKaiqzKGpxkRx81nJzye6FXuAZA4Gs+zQyqfywRltkqPtkBH++Lhty8+xJsrQJkQIQ9Vf16
	z2OnKl54tBXm2yOAVh4qs0YOSaZk=
X-Google-Smtp-Source: AGHT+IG06AWn/BEuztA9ZNjXtr+xDp/yagJiUeTAatI9iFntRuqgkPe5UXvjKT53HmybpPPoqxhvuEFnhupVQxwSgg4=
X-Received: by 2002:a05:6820:2b06:b0:5ac:6fc1:c2cb with SMTP id
 dt6-20020a0568202b0600b005ac6fc1c2cbmr454366oob.0.1714505488902; Tue, 30 Apr
 2024 12:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429040441.748479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Zi9hFbrIfyDhrA5R@smile.fi.intel.com>
In-Reply-To: <Zi9hFbrIfyDhrA5R@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 21:31:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g7omX=OcObvEAs=ArpW9s+C8CvuW7Ew5EzQfuVDhpZjQ@mail.gmail.com>
Message-ID: <CAJZ5v0g7omX=OcObvEAs=ArpW9s+C8CvuW7Ew5EzQfuVDhpZjQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Move acpi_blacklisted() declaration to asm/acpi.h
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 10:58=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sun, Apr 28, 2024 at 09:04:41PM -0700, Kuppuswamy Sathyanarayanan wrot=
e:
> > The function acpi_blacklisted() is defined only when CONFIG_X86 is
> > enabled and is only used by X86 arch code. To align with its usage and
> > definition conditions, move its declaration to asm/acpi.h
>
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I have replaced the v1 that was applied some time ago with this one.

> ...
>
> >  extern char acpi_video_backlight_string[];
> >  extern long acpi_is_video_device(acpi_handle handle);
> > -extern int acpi_blacklisted(void);
>
> I would replace it with a blank line (to me it seems the above and below =
are
> different groups from semantic point of view, but Rafael may correct me).

And I have added the blank line as suggested.

> >  extern void acpi_osi_setup(char *str);
> >  extern bool acpi_osi_is_win8(void);
>
> --

Thanks!

