Return-Path: <linux-kernel+bounces-157614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624048B1397
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B901C22A20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BA777F1E;
	Wed, 24 Apr 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PUuvJjG2"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7FF1BF37
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987167; cv=none; b=rYAIxfrnu/gIgIfOOMznzNn8TiYgFgUPKg9FwQpzKQ7CQ6kHk/M1KEO9AzE5mzdEANtytm/rmUmN7qxBfd3ZSl0lo9Z9warfglwAANu5qoNWEUeRxHNnEaLTtzSNiSNyZLk/gaK1diGQqphGLgzlkYLBdT6MUr2OwTLL5rW6ahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987167; c=relaxed/simple;
	bh=47HcS+tUP8b+9bxu0PIF6L0JsffW7atYv21eLmoyL7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wt2hZBxb8u6rCNdV1lIUfEa4dITTQO9U/6sQBcGOdtR37KtbUdPAcTCK6x5zHNeFt6lDp+c8MfNgmuqHn8RnFxeKEgMToTvZKH5FUqpEhh1gamabXj+ZtjSe+L+fATFy/AMg6j0ylfOt13lNfceLdBFW9laN6ctXdvKD1tm2aU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PUuvJjG2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dde0b30ebe2so287824276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713987165; x=1714591965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47HcS+tUP8b+9bxu0PIF6L0JsffW7atYv21eLmoyL7s=;
        b=PUuvJjG2QIZyobBSBrmrBUakczPCtjxqGPus+LFIJLV8Y2Ia4875ENSkdAocTnnlve
         Xb3AXJbOP0wPJOYbNaE3ZFfQtAlmHZDOHtp/nGmOAJUn6SXLx1ikeVzYAjjmmhwTrnNg
         duuv68TAyZsKTMXW8BKHxeXhhVNkTcCWLlbp2ett84fSINaI/cBv6zdpE71R6dbwzUQx
         6qLL7XUzKQTDfVvPMjmho6ey7huKetRwVnkzzPH5vU1dcv9u12uyS7Q/H8G8LlDeFYID
         Hs01oonWFKk6OufMB1VdhQKp6VPRHJ0ChMb4ELWh99VFI6DXCaXQDui0e/0eeZVjjkd4
         jLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713987165; x=1714591965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47HcS+tUP8b+9bxu0PIF6L0JsffW7atYv21eLmoyL7s=;
        b=Nii4Mkj9RnInBvuzWcu5Uvvn/12+PUgz0cC+vesVwYv5a1BsLZydEa11I9VtOHw+8T
         ojCkMvrKqFc6KqCcyw3eA8oxWDouiefdM9try8Bh6xDfkc4CAdxlbjqSlQ63Pntu4NNZ
         +Ije7FaQeWWKKqEfWaC3uqK0yplcQyUzdxKQjNZiZOInSOO2J8JQq9zB5Bwj4eTTDRLd
         97/y107/vbYbAJs+cKBHVSYUKUsDYJ6YcYTqUrW4Zg7zD+ykAbksktP0V9AzCZK8Flmb
         RPP74Set5JauBM5nKu9A0/nmyomXK6PxfdnCm885QhxxhQfyYlNqvq0C9JI5iCFGMnXf
         k+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWBWz/f85ixUS2SoxlrP5ZKr0/zcqUJGS/icqZ8J4bmoZBPtPMFI6ZPvyONydIu5VJTajbdZc4Oxzjlo5soa99jtk01ApDZNe9GxnOp
X-Gm-Message-State: AOJu0YynSx8ZGQjB40sgc3JMq9rghZbIuvKTE0S4OfEVfoNRP+e/MhGk
	aYvpmogJx993mR+m4jk2ZPNNUziDZHHPatsDjefpSYVtYBlHjgJtGphqmn3Gv9MVCgTqyk31AzB
	0WT29hj9hjsQEVKGnz9woqi+nvuKN7WsBGbxEgA==
X-Google-Smtp-Source: AGHT+IF00MN5VEZITEjzf5PI6hYeI6Nm5bCzHMoFOU8I1tTtInkOgWhiANYycMpRJwQGESp+WPQSi67G0TQVeSangug=
X-Received: by 2002:a25:ae88:0:b0:de4:70b7:7bf with SMTP id
 b8-20020a25ae88000000b00de470b707bfmr3285349ybj.31.1713987164932; Wed, 24 Apr
 2024 12:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422164658.217037-1-sui.jingfeng@linux.dev>
 <Zie3ebHOEpWHj1qV@smile.fi.intel.com> <d5bc1e73-a553-451e-ab74-f5f0ca259c6b@linux.dev>
 <hcltp2bbxxg2t7ibmzgiib7mgbwgmvzwnnq6mochdh7c4h76r3@bxj6yk5zq64e>
 <ZikE4qOVO7rgIs9a@smile.fi.intel.com> <CAA8EJpr1FSjizAh6Dp5Bmux3NrGYh=BfHFL4D1fa87Og4ymY0w@mail.gmail.com>
 <Zikck2FJb4-PgXX0@smile.fi.intel.com> <kucey3jsydjye3ndflns3cqolcpizhnxgzz3fkmcatlnpbnwrk@22ulsqfh2vf6>
 <Zik3AjiWkytSVn-1@smile.fi.intel.com>
In-Reply-To: <Zik3AjiWkytSVn-1@smile.fi.intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 22:32:33 +0300
Message-ID: <CAA8EJpr_zAmsVMeOvMjmnxZpcoDsLk3X9fTtQjn5aDEt=hQPPQ@mail.gmail.com>
Subject: Re: [PATCH v2] software node: Implement device_get_match_data fwnode callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 19:45, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Apr 24, 2024 at 07:34:54PM +0300, Dmitry Baryshkov wrote:
> > On Wed, Apr 24, 2024 at 05:52:03PM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 24, 2024 at 04:34:39PM +0300, Dmitry Baryshkov wrote:
> > > > On Wed, 24 Apr 2024 at 16:11, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Wed, Apr 24, 2024 at 12:37:16AM +0300, Dmitry Baryshkov wrote:
> > > > > > On Wed, Apr 24, 2024 at 12:49:18AM +0800, Sui Jingfeng wrote:
> > > > > > > On 2024/4/23 21:28, Andy Shevchenko wrote:
> > > > > > > > On Tue, Apr 23, 2024 at 12:46:58AM +0800, Sui Jingfeng wrot=
e:
>
> ...
>
> > > > > > But let me throw an argument why this patch (or something simil=
ar) looks
> > > > > > to be necessary.
> > > > > >
> > > > > > Both on DT and non-DT systems the kernel allows using the non-O=
F based
> > > > > > matching. For the platform devices there is platform_device_id-=
based
> > > > > > matching.
> > > > > >
> > > > > > Currently handling the data coming from such device_ids require=
s using
> > > > > > special bits of code, e.g. platform_get_device_id(pdev)->driver=
_data to
> > > > > > get the data from the platform_device_id. Having such codepaths=
 goes
> > > > > > against the goal of unifying DT and non-DT paths via generic pr=
operty /
> > > > > > fwnode code.
> > > > > >
> > > > > > As such, I support Sui's idea of being able to use device_get_m=
atch_data
> > > > > > for non-DT, non-ACPI platform devices.
> > > > >
> > > > > I'm not sure I buy this. We have a special helpers based on the b=
us type to
> > > > > combine device_get_match_data() with the respective ID table craw=
ling, see
> > > > > the SPI and I=C2=B2C cases as the examples.
> > > >
> > > > I was thinking that we might be able to deprecate these helpers and
> > > > always use device_get_match_data().
> > >
> > > True, but that is orthogonal to swnode match_data support, right?
> > > There even was (still is?) a patch series to do something like a new
> > > member to struct device_driver (? don't remember) to achieve that.
> >
> > Maybe the scenario was not properly described in the commit message, or
> > maybe I missed something. The usecase that I understood from the commit
> > message was to use instatiated i2c / spi devices, which means
> > i2c_device_id / spi_device_id. The commit message should describe why
> > the usecase requires using 'compatible' property and swnode. Ideally it
> > should describe how these devices are instantiated at the first place.
>
> Yep. I also do not clearly understand the use case and why we need to hav=
e
> a board file, because the swnodes all are about board files that we must =
not
> use for the new platforms.

Not necessarily board files. In some cases it also allows creating
device nodes to patch devices, e.g. when the ACPI description is
incomplete. But my main concern is about using the "compatible"
property here. I suppose that it should be avoided if not absolutely
required, instead the driver should use native foo_device_id matching.

Here is a list of existing "compatible" properties and their usecases.

arch/arm/mach-omap1/board-nokia770.c:
PROPERTY_ENTRY_STRING("compatible", "ti,ads7846"),

This one looks like a way to overcome shortcomings of the ads7846
driver. The driver should add spi_device_id, use
spi_get_device_match_data(), then the property can be dropped.

drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c: nodes->i2c_props[0] =3D
PROPERTY_ENTRY_STRING("compatible", "snps,designware-i2c");
drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c: nodes->sfp_props[0] =3D
PROPERTY_ENTRY_STRING("compatible", "sff,sfp");

I think these two can also be dropped if the corresponding drivers get
platform_device_id entries.

drivers/platform/x86/x86-android-tablets/asus.c:
PROPERTY_ENTRY_STRING("compatible", "simple-battery"),
drivers/platform/x86/x86-android-tablets/shared-psy-info.c:
PROPERTY_ENTRY_STRING("compatible", "simple-battery"),

These are required by the power_supply core to identify the "battery
stub" case. There is no corresponding device being created and/or
matched.

drivers/platform/chrome/chromeos_laptop.c:
PROPERTY_ENTRY_STRING("compatible", "atmel,maxtouch"),
drivers/platform/chrome/chromeos_laptop.c:
PROPERTY_ENTRY_STRING("compatible", "atmel,maxtouch"),
drivers/platform/chrome/chromeos_laptop.c:
PROPERTY_ENTRY_STRING("compatible", "atmel,maxtouch"),
drivers/platform/x86/x86-android-tablets/asus.c:
PROPERTY_ENTRY_STRING("compatible", "atmel,atmel_mxt_ts"),

The driver checks for the presence of the "compatible" property to
check that the device has properties at all. I think it was added as a
safegap against treating incomplete trackpad nodes (which should have
linux,gpio-keymap) as touchscreens (which have none).

--=20
With best wishes
Dmitry

