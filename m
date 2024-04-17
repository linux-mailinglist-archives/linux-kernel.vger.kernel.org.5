Return-Path: <linux-kernel+bounces-148153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A98A7E60
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E55B253EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A212126F2C;
	Wed, 17 Apr 2024 08:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfBEpZU0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651142A83;
	Wed, 17 Apr 2024 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342865; cv=none; b=PIMJfGdNnDFCqkREKgFQSzMvURR7SniUGNDT5pEAQw0Z3t80LR9eGlxNL8yz7TA9z97qbTV4NDqwWXvA4eG01z2CRP04wi3ypQFzIJ+uruQsitcatqf9wFzBAF0F1Wmiqt1+c1maepTMYJX8L40oW5/DZ6huI9rYe51tMzZ9hoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342865; c=relaxed/simple;
	bh=s0/8NwQnmMOTxw/pDh1/9tQW0awcQnIOgrb+lAYC168=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCJPh+RCShXzF/fhOHFaQbX1bnGVGsmHxvEmxGVmEBTP3HrO126tFc0g8LDfXNjSjgKhhEUbHG0TKzg7TzahgUrt1w0+oJbPBV4Utbcdj+3HZ2fZh66QSmpjAtJlcstigPaTTRUmIw5RRafuz6iiRZlE9O2ZGbJ4Q0NANr+tR5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfBEpZU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB9BC072AA;
	Wed, 17 Apr 2024 08:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713342865;
	bh=s0/8NwQnmMOTxw/pDh1/9tQW0awcQnIOgrb+lAYC168=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SfBEpZU0mJ3S6rEbPWy5lc3DL7kqfQJ5rHWhVMDISFJm3vX9h4Z4r4VCEcmMxQKFF
	 8zLbk4+FXnPDqCyzhYxKsItWNzhPDlVFdcyNE/RCFkheSxAFkf63e9WhR3Fhq1Sa72
	 7uIf2SLG7GeyRI0mIX2WDcjtYotAxZFZ3cQQK1qfGj89XJo0AxALViWtoWwMldaJdg
	 LTVZXfMVZXTzkAgUiPqIE5B1JPXyYFquT/tfkEQJrdKOhxSuHA/DNwjJFhb6RLMT0o
	 5LczNowNAw6FZSrhzkEMba7aGykbZY4l3e0OLrefBhquAGyqsJPCdSSFBJ1OdkZ+Bk
	 LLnHCqdjd94sw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5acdbfac113so211723eaf.3;
        Wed, 17 Apr 2024 01:34:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8yxFTWZKiWcWj5fWmGVbv8wV13Xuo6iKzyv1UgnAXjZnhNLyLcJl++tjqoLlR6qIGVN/pN0hgr6hW3Id65XiZCnHglCS3D1WyecHDrHeNApG36V6bajmuC0Tyg9UuU9VJJ5yHMIk=
X-Gm-Message-State: AOJu0YzzUQq6Lc2WN+lpDNkDeeIonrUKjXjh/EV0AHtBXN8R5HKQBhW2
	uF3hI56uyu+TtK6WLsUgfbNiO6D6BjcgX9QbXK3zHigPNBDerr/P5/ldSdV1/FyR4jokMwd6eR6
	TeRt+okRjk+HucSLCMIKgtPigZos=
X-Google-Smtp-Source: AGHT+IGcsRnDLpjjTgbpHkK4JnzqlUQhItrDjYDobJhARv5yhC8Q9xAmq3LJxwQIx7VB03oe6HYibVISRHSwpVGmleE=
X-Received: by 2002:a05:6820:f44:b0:5aa:241a:7f4b with SMTP id
 ep4-20020a0568200f4400b005aa241a7f4bmr14997194oob.1.1713342864351; Wed, 17
 Apr 2024 01:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408035141.248644-1-rui.zhang@intel.com> <20240408035141.248644-2-rui.zhang@intel.com>
 <CAJZ5v0hF-AHY97y-Hz78=1MYGM4zHtOZ8U62NQBMMUNP4L-Kqw@mail.gmail.com> <45835aa25b4574732d8d4eb4dfd5b7f89af66f58.camel@intel.com>
In-Reply-To: <45835aa25b4574732d8d4eb4dfd5b7f89af66f58.camel@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Apr 2024 10:34:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iCpG3fKcXTMyFCe_nVnUCMmvTGpiuM+wQWQhO5G6Pe1A@mail.gmail.com>
Message-ID: <CAJZ5v0iCpG3fKcXTMyFCe_nVnUCMmvTGpiuM+wQWQhO5G6Pe1A@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] powercap: intel_rapl: Sort header files
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: "rafael@kernel.org" <rafael@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 3:57=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Tue, 2024-04-16 at 16:01 +0200, Rafael J. Wysocki wrote:
> > On Mon, Apr 8, 2024 at 5:51=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> =
wrote:
> > >
> > > Sort header files alphabetically.
> > >
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/powercap/intel_rapl_common.c | 24 ++++++++++++------------
> > >  1 file changed, 12 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/powercap/intel_rapl_common.c
> > > b/drivers/powercap/intel_rapl_common.c
> > > index a28d54fd5222..1f4a7aa12d77 100644
> > > --- a/drivers/powercap/intel_rapl_common.c
> > > +++ b/drivers/powercap/intel_rapl_common.c
> > > @@ -5,27 +5,27 @@
> > >   */
> > >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > >
> > > +#include <linux/bitmap.h>
> > >  #include <linux/cleanup.h>
> > > +#include <linux/cpu.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/intel_rapl.h>
> > >  #include <linux/kernel.h>
> > > -#include <linux/module.h>
> > >  #include <linux/list.h>
> > > -#include <linux/types.h>
> > > -#include <linux/device.h>
> > > -#include <linux/slab.h>
> > >  #include <linux/log2.h>
> > > -#include <linux/bitmap.h>
> > > -#include <linux/delay.h>
> > > -#include <linux/sysfs.h>
> > > -#include <linux/cpu.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > >  #include <linux/powercap.h>
> > > -#include <linux/suspend.h>
> > > -#include <linux/intel_rapl.h>
> > >  #include <linux/processor.h>
> > > -#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/suspend.h>
> > > +#include <linux/sysfs.h>
> > > +#include <linux/types.h>
> > >
> > > -#include <asm/iosf_mbi.h>
> > >  #include <asm/cpu_device_id.h>
> > >  #include <asm/intel-family.h>
> > > +#include <asm/iosf_mbi.h>
> > >
> > >  /* bitmasks for RAPL MSRs, used by primitive access functions */
> > >  #define ENERGY_STATUS_MASK      0xffffffff
> > > --
> >
> > I can apply this cleanup right away, so do you want me to do that?
>
> yes, please. thanks!

Now applied as 6.10 material, thanks!

