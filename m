Return-Path: <linux-kernel+bounces-135620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1AA89C8A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE7BB244E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15501419B4;
	Mon,  8 Apr 2024 15:43:04 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95075140E4F;
	Mon,  8 Apr 2024 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590984; cv=none; b=kPBFmsooLW2wVYfmz565ZuetDJWiHAvm1/lJIbtQgL0HtBlftsYdLha6lvAvYYIR2yocRnCLUmyCNKKXX8lp6157E4HT+gZrUDfbi91GUkzkO4lOXZ0hiKbqPra8AloqEjVmw5SGzs+uX1Ycdw7BisFhIlKs8SS3fhHgfj7cuqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590984; c=relaxed/simple;
	bh=u84nzCTNcDWnJynwd2ody8MWoy74b9HyxAnHlJf7VLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rvawbQybeBdQ6WgtmkYkHtqQAixtVfYPMFl68Pkq+IDrUjHGjNtKDgM7hRE6ewtwE7W4EA6xxYP9exoOM+jilTvf0Acr3HUiBipZS8+D8/8qYOlHE9m1DPl+g/YoXrUKgslzh/cFAXsDmyQaClpuC7Ejcni+urM5I2ZD6qjrsAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a47385a4379so1037797266b.0;
        Mon, 08 Apr 2024 08:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590981; x=1713195781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DZWqINXfXQoMnEdU+hyVda4sKWIxPOFDKIPjHb2rhh4=;
        b=aTUo+4PXaGRzfMsMQyipb+hany+VwAAENggECWkchAW5xpRCPLM/91UpvPsXdhApic
         pGMfYeO7UB2wvunx7mRW6Xzzcr8z8Z1ROaBTUaZd3YuNWykFMDsNeqcwklGbHK62HTB6
         SrL/Yl12YXLmm3RUy4NtmnPufUS8e6iVwF+XKKoehDZ/d1FRGJBD7fE3fvRNnNGz5g1L
         I7z5+7CpN8ZsoxqxtvnaNlComPmRhUn8jqAR3EhaBc9kWD+lZR06peVedjLAEw//qdIm
         UKb/Jqhn5aM8GfMROXe4SeJsZy/KnCXK1gQ7u5bVctrmyIPJcjz5rvKB72AMuFqG1Azm
         KSGA==
X-Forwarded-Encrypted: i=1; AJvYcCWWVQXkcZPWcJ7djU06yBPQUGh1OHABUWSFLWbALfFPK+ZJUUnBsjCMlWduVCV1XlWmkfYSDo15U4F8grdR3bf6tPTB29OaOMEyVCYe5d/a96l5sSlWPtojD8HEVDYVUUPNhl1THWIoWQ==
X-Gm-Message-State: AOJu0YyqVb2G4piUXhu4DRLQraQGiEFjNsQfbs9GCWxgRmhNjaS0A/io
	4onavXy1hhgXStM2eL0t6E9f3ySkzn5b/DlUUKeRYi9FAvx7Fez550rLZCULtng=
X-Google-Smtp-Source: AGHT+IEb2tkCJ5LtsHHh+awJaUpNleR7NuEVn30Ony6kKYtpbE4jPA3g00j8HmqrnOlXBgzZMb1F+g==
X-Received: by 2002:a17:907:1c21:b0:a51:9575:bd3a with SMTP id nc33-20020a1709071c2100b00a519575bd3amr41936ejc.38.1712590980346;
        Mon, 08 Apr 2024 08:43:00 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id an2-20020a17090656c200b00a51b00b5236sm3758352ejc.120.2024.04.08.08.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 08:43:00 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so777067766b.1;
        Mon, 08 Apr 2024 08:43:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUoGjDKDaWBkl4Kh4/apT7/NMANJqcuw3q7cT5Etm6MSqDcTiRA4A6t4nr5TX0lvUMEYENv9LtMRuHL2CJp78/4P8LBc/ZuhH6IvirOo8/c3jsSIKggWewd5YbowMk9r896vWcp5pgmkw==
X-Received: by 2002:a17:907:3e1d:b0:a51:c62f:3c91 with SMTP id
 hp29-20020a1709073e1d00b00a51c62f3c91mr54115ejc.21.1712590980025; Mon, 08 Apr
 2024 08:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407063341.3710801-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ZhQE9dU-VIcWI6au@smile.fi.intel.com>
In-Reply-To: <ZhQE9dU-VIcWI6au@smile.fi.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Date: Mon, 8 Apr 2024 08:42:48 -0700
X-Gmail-Original-Message-ID: <CAC41dw-Df3L7B=Tq2QkQHDT2Yf3MzHgy8-czPAkZhdPf0Tea4Q@mail.gmail.com>
Message-ID: <CAC41dw-Df3L7B=Tq2QkQHDT2Yf3MzHgy8-czPAkZhdPf0Tea4Q@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Declare acpi_blacklisted() only if CONFIG_X86 is enabled
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 7:53=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Sat, Apr 06, 2024 at 11:33:41PM -0700, Kuppuswamy Sathyanarayanan wrot=
e:
> > The function acpi_blacklisted() is defined only when CONFIG_X86 is
> > enabled. So to keep it consistent, protect its declaration with
> > CONFIG_X86.
>
> ...
>
> >  extern char acpi_video_backlight_string[];
> >  extern long acpi_is_video_device(acpi_handle handle);
> > +#ifdef CONFIG_X86
> >  extern int acpi_blacklisted(void);
> > +#endif
> >  extern void acpi_osi_setup(char *str);
> >  extern bool acpi_osi_is_win8(void);
>
> IIRC there is already similar ifdeffery, can we just move the declaration
> there?

There is none for CONFIG_X86. We only have some combinations or
derived config checks like below:

#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
#ifdef CONFIG_X86_IO_APIC

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

