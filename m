Return-Path: <linux-kernel+bounces-107600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC887FEF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAD81F25C74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7011D80612;
	Tue, 19 Mar 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="P1OqbeGV"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F9780607
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855567; cv=none; b=eWrlGxkp9i4YUnpZommC/lC7qM9SIoGLPA9ehRr6yiSD0ZiZFuuYoTpFj38TeVQ+qHDMyQGkanBBpqpY3gjsSloOeGimWHTltOUhER0vsmQfJegtapMgLHFRvPwPiEGl9+dVeE7yZixLE2TKI//Eb1LVV5tLZR7LxrEakMMqwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855567; c=relaxed/simple;
	bh=sGGyhg7qmrAF3VEJNWEaHGwkum60h1VaoacXAoOTovk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsBNQSAs0mFMr94c2jEtO2DmKe6ynBtBwQoNXCYuImtG1VtnyDeixajQtUscmBbKnwlczDrv4rxEGUVlOj7t260Q/W35AReAWvHv7HJQ+g94G26pdfLU8IBE++OzDWPErk3iwxLx+xbYTRRZr6xbEavS8PJxZDmo/oAr7q0OCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=P1OqbeGV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-568107a9ff2so6680820a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1710855563; x=1711460363; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4zAsS/uNen1I904a04qYYT/TYDmbVxX/Uth0W4MlTuw=;
        b=P1OqbeGVx/LNo6k00aDeY0qqnZbyhwxJi/H5vPs6blh9cklngarVGr+2Kzw4IJuh70
         IHsav1HSdeXmJmu0MgqJNAyJGChxVzybXBLcOlvptlhZHQaaQvVdZ52/dvfBzaca6rFx
         rXk/Te8lH7/NwcnTOYnJZbXrAdHziu2G9JLPHlfCU275a4W5kUqRNvEQaVw0KSkN//PB
         2A283x3TDCPoPcbPlYs3h4CrcbcazIDpje6gu0cmDePzxJAjBabTvgxyMthK3BKVEOyH
         ckEnLuasQGtvjUmZiXrwXmtg9NZvsfsryVW38m5mjRVOZKFiehQ6WPw5Dya2bb30S343
         p0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855563; x=1711460363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zAsS/uNen1I904a04qYYT/TYDmbVxX/Uth0W4MlTuw=;
        b=d2JMHE9BhjXZUheK763DKgKTdhbfYNKhVlFyKrelce9o2fRIQkbMbRQrSLjZ4ozVfF
         8hnhcWmeQ5rNOb3g2f/HZ0wZ9WFjpLd0MRu9eIAh4o//jS8im/koT8PzEkcgbtNKIMel
         CnnueUEVmTu6uM+bWONLfkmhHMVdNaZUPEjpcHq/g7gAijPTiOSPgl6DOSFlxd0wxA3L
         aAj/JeOJUnbf28d2hbzG84yy+iUglsQiNhZj3+exuO+DHy/NirrfD+KKCzuqynsJRJLj
         fly/fkTpuYuVk+w6hS3IKZRddVhqfkBmuEy89Arl8lH4eNkCEMeRgCOZKkOccknalLWd
         tpEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAMdSkgNfHeW5ccCMaAML79kyc3P2JGKlBknczsZAPtX549CMCQo+g/2QOZ8AgYc3dvj89FXl3vnal5HC3YSboKZ4Y66k1MhywFwhT
X-Gm-Message-State: AOJu0YyYVbZKj78YyuPofTtnnslGQFecUzWqvK1eFO5x29+WUAQXnrej
	P6o7HU6jkGSVLx/oVVz25D9zii75ve3qXwp/at2wlhWtBkOpzIi4G7leyKCMJ0Q=
X-Google-Smtp-Source: AGHT+IHVRMJgWhA6FUGYuB3YQ2YkT+vT6+CMMifWJKwecbxw4bHQrbgtLR+eeZnyMUCHzJq6zdMjMg==
X-Received: by 2002:a05:6402:5516:b0:568:1248:9f49 with SMTP id fi22-20020a056402551600b0056812489f49mr11014066edb.18.1710855562942;
        Tue, 19 Mar 2024 06:39:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id er27-20020a056402449b00b00568d2518105sm2756561edb.12.2024.03.19.06.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 06:39:22 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:39:21 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: Atish Patra <atishp@rivosinc.com>, 
	Inochi Amaoto <inochiama@outlook.com>, Qingfang Deng <dqfext@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Atish Patra <atishp@atishpatra.org>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf: RISC-V: fix IRQ detection on T-Head C908
Message-ID: <20240319-3e72d732cbf2fcf1cb81f968@orel>
References: <20240311063018.1886757-1-dqfext@gmail.com>
 <IA1PR20MB4953ECC3E32E95303872CD14BB242@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CALW65jZ+q8sDiRKgsRL9n+939HNUCnkKuO=YJjHB5Js=WYQeOg@mail.gmail.com>
 <20240312-evil-resource-66370b68b9b4@spud>
 <IA1PR20MB4953CE8999960BA71B46DE6CBB2A2@IA1PR20MB4953.namprd20.prod.outlook.com>
 <20240315-73aa13079ef83a4559869084@orel>
 <2de56d8b-bc78-428b-9c09-4729b269fa41@rivosinc.com>
 <20240318-such-animal-bf33de12dc3a@spud>
 <4bdaaff1-13ec-48c2-b165-6a8255784aef@rivosinc.com>
 <20240319-worry-video-66589b3ed8ae@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319-worry-video-66589b3ed8ae@spud>

On Tue, Mar 19, 2024 at 09:06:34AM +0000, Conor Dooley wrote:
> On Mon, Mar 18, 2024 at 05:48:13PM -0700, Atish Patra wrote:
> > On 3/18/24 16:48, Conor Dooley wrote:
> > > On Mon, Mar 18, 2024 at 03:46:54PM -0700, Atish Patra wrote:
> 
> > > > For 2.b, either we can start defining pseudo extensions or adding
> > > > vendor/arch/impid checks.
> > > > 
> > > > @Conor: You seems to prefer the earlier approach instead of adding the
> > > > checks. Care to elaborate why do you think that's a better method compared
> > > > to a simple check ?
> > > 
> > > Because I don't think that describing these as "errata" in the first
> > > place is even accurate. This is not a case of a vendor claiming they
> > > have Sscofpmf support but the implementation is flawed. As far as I
> > > understand, this is a vendor creating a useful feature prior to the
> > > creation of a standard extension.
> > > A bit of a test for this could be "If the standard extension never
> > > existed, would this be considered a new feature or an implementation
> > > issue". I think this is pretty clearly in the former camp.
> > > 
> > 
> > So we have 3 cases.
> > 
> > 1. Pseudo extension: An vendor extension designed and/or implemented before
> > the standard RVI extension was ratified but do not violate any standard
> > encoding space.

The vendor should name these extensions themselves.

> > 
> > 2. Erratas: An genuine bug/design issue in the expected behavior from a
> > standard RVI extension (including violating standard encoding space)

More on this below, but I think vendors should name these too.

> > 
> > 3. Vendor extension: A new or a variant of standard RVI extension which is
> > different enough from standard extension.
> > 
> > IMO, the line between #2 and #1 may get blurry as we going forward because
> > of the sheer number of small extensions RVI is comping up with (which is a
> > problem as well).

The line between #1 and #2 is blurry because the only difference is the
original intentions. The end result is that a vendor has implemented
something that resembles a standard extension, but is not the same as the
standard extension.

> 
> Aye, I think some of that is verging on ridiculous.
> 
> > Just to clarify: I am not too worried about this particular case as we know
> > that T-head's implementation predates the Sscofpmf extension.
> > But once we define a standard mechanism for this kind of situation, vendor
> > may start to abuse it.
> 
> How do you envisage it being abused by a vendor?
> Pre-dating the standard extension does make this one fairly clear-cut,
> but are you worried about people coming along and claiming to implement
> XConorSscofpmf instead of Sscofpmf rather than suffer the "shame" of a
> broken implementation?

Other than the concern of the ballooning bitmap, I'd prefer this approach.
If a vendor has implemented some extension which happens to be "almost
Sscofpmf", then whether it was implemented before the Sscofpmf spec
existed, or after, isn't really important. What's important is that it's
only "almost Sscofpmf" and not _exactly_ Sscofpmf, which means it should
not use the Sscofpmf extension name. Since vendors are allowed to create
their own XVendor names, then that shouldn't be a problem. Indeed, the
abuse concern seems to be in the opposite direction, that vendors will
try to pass off almost-standard extensions as standard extensions by
trying to get workarounds into Linux. Maybe Linux policy should be to
simply reject workarounds to extensions, requiring vendors to create new
names instead.

> All this stuff is going to be pretty case-by-case (to begin with at
> least) so I'm not too worried about that sort of abuse.

Case-by-case is reasonable, since it's probably too strict to always
require new names. We can consider each proposed workaround as they
come, but it's a slippery slope once workarounds are accepted.

Thanks,
drew

