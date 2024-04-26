Return-Path: <linux-kernel+bounces-160184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2883C8B3A52
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5578F1C24730
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA40F148822;
	Fri, 26 Apr 2024 14:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR89E2Ob"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86371145343;
	Fri, 26 Apr 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142747; cv=none; b=Tbp/Bh1ZP46q3d1pDAsQIcCt0U5q7kfoVUA8zB84WOlMSBR2s2THA2meT3mTSK3Cb7T9N3NCyQvFBKkYF7rBQFcv0hz8CzruR7TRdsqv3o1g/WfOaVWVvbwU05kBLyyMDwIOnI3hnRVkGR1EMstMuYauwFwP06IWa4ATktVZeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142747; c=relaxed/simple;
	bh=PPEdR5k3Sy2QCd40SOPMzSepQmkyNNu5zt1BvI8PrxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPOYzH7eLXDVHHvsvvhF9ue6uv8Dg+vNl9U40HtlEiJSvdankY/PYeS4ivqWHvZnkeZSgGaFHcik4UA4pKPS+qoHAoLLWWHWL8ACScRJYyC2cIz3xXNixvDkjVjt3nQQZZMsuMTel15Q+UX7mRqoE13FfBs1exW7f4G/w2Qvdkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR89E2Ob; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41adf155cffso15914325e9.2;
        Fri, 26 Apr 2024 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714142744; x=1714747544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VifuJ+1YpDUjiXq0nfZBSyvnXA3hWnQhVXai5Y/kXGQ=;
        b=UR89E2ObGvij0wXK0NJUlxUDzEfnSf0QKwQGpUVN3rSV7Ihy1InXRPMlZQAqHl93Lt
         +yUFp3829hzV75O6qDcb6LSms3/ey/T+ok625vC70cQwrkDahfTZ5MdgU2tQXEhagBu9
         ayIlZgYF0wAB/DY4NZiwN9+oCnEL49MpKqXM0StgdtjtcXU6n6+Uv8WobkUipIhZbQmy
         DqHbt0ipSh+9JsoV0yWAtDvbI4x3se7f8/PkIxpagh/iIcVnHvT30ajywmmr/jBbrfkU
         KeeU2l2b4JyM/f2/pKcAHEnPmgYkx5QNO8vQJX65n2HAmcjsRjGl1dPesaWvI8sK2Rvd
         1lAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714142744; x=1714747544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VifuJ+1YpDUjiXq0nfZBSyvnXA3hWnQhVXai5Y/kXGQ=;
        b=DtiAfbBhqOeUZpSDM01VT+Fs0V4GAC793pgLDt6pCNeFOxEqSYt/P1sr99pyhkwcub
         ThTU86U8PlPNP7SHY0MLMCqRw9M9o1pxebFol+wzrayRs8u5gFpylRbQuHbZK5muo9dw
         G3i9oUaMii6ViN0aZrjq5eBR7eMAb8g+jf2LsKzo1OWN04qwHi4+f+SzmwmDArDXqxe0
         8KKZUO6QajCl1IPhIimDlGH7wMr1KSNCPbv5hCmHiFObAUhVlTszGt19ixsJkjH4gupa
         kQLwNS/Vj9LQSyhIje+W2cx7cXlEkoY/Ed3XcuCY0m9p/iQro67/Tsqj8fvEfIednMEG
         2PgA==
X-Forwarded-Encrypted: i=1; AJvYcCVx8NKNnKRUV2nogEEQ6ZMRucrdL9wK6epW7nc6GSuW4nZc3WmFCzTMcUGinSF0iUaxKqLzdCDu8aIMBr7pjYzp0XN39njv3a36LYTL4A+/fNFhLLhSLB17ikcDvi/Djrzna+/6H5MzH/iKAVs=
X-Gm-Message-State: AOJu0Ywi4fGEvfYDRMLSBuQIRQrQnMNTHPDRRyT4kgh5/0ZxKNJNSHoj
	Id39ccbyXfYZ/zVi0iFbU4HBPaGpXd1I24pql4OP7bGVfUgcIllZIYfZgCEad2BhW6TXmklChyO
	yvuHe996k4haH0Lf7bYgAZpo9sz8=
X-Google-Smtp-Source: AGHT+IHIIDds8VIXhbA/z3xYSMfozMo9ODJUXJjglU5xk+l6mvMJjvBSWWAy44MjiApfAmP3l+6ZOrN2bnn+Tq68ovU=
X-Received: by 2002:a05:600c:45cd:b0:41a:a521:9699 with SMTP id
 s13-20020a05600c45cd00b0041aa5219699mr2249699wmo.4.1714142743502; Fri, 26 Apr
 2024 07:45:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
 <20240425090727.3787160-2-peteryin.openbmc@gmail.com> <5ed8bfd6ce559a7d00ec89f1bd7ae1aea90e3ae7.camel@codeconstruct.com.au>
In-Reply-To: <5ed8bfd6ce559a7d00ec89f1bd7ae1aea90e3ae7.camel@codeconstruct.com.au>
From: Chia Hsing Yin <peteryin.openbmc@gmail.com>
Date: Fri, 26 Apr 2024 22:45:32 +0800
Message-ID: <CAPSyxFTa6k3FzUmDoZ6HMpAfwZGK_yPrQKGSvSdtj_JqsnMVrA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] drivers: watchdog: revise watchdog bootstatus
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can include reset condition in struct maybe like this

static const struct aspeed_wdt_config ast2600_config =3D {
ext_pulse_width_mask =3D 0xfffff,
irq_shift =3D 0,
irq_mask =3D GENMASK(31, 10),
compatible =3D "aspeed,ast2600-scu",
reset_event =3D AST2600_SYSTEM_RESET_EVENT,
watchdog_reset_flag =3D AST2600_WATCHDOG_RESET_FLAG,
extern_reset_flag =3D EXTERN_RESET_FLAG,
reset_flag_clear =3D AST2600_RESET_FLAG_CLEAR,
};

in probe( ) we  just call

scu_base =3D syscon_regmap_lookup_by_compatible(wdt->cfg->compatible);
if (IS_ERR(scu_base))
    return PTR_ERR(scu_base);

ret =3D regmap_read(scu_base, wdt->cfg->reset_event, &status);
if (ret)
    return ret;

if ((status & POWERON_RESET_FLAG) =3D=3D 0 &&
     status & wdt->cfg->watchdog_reset_flag)
    wdt->wdd.bootstatus =3D (status & wdt->cfg->extern_reset_flag) ?
    WDIOF_EXTERN1 : WDIOF_CARDRESET;

status =3D wdt->cfg->watchdog_reset_flag | POWERON_RESET_FLAG |
wdt->cfg->extern_reset_flag;

ret =3D regmap_write(scu_base, wdt->cfg->reset_event, status);

Does this meet your expectations?

On Fri, Apr 26, 2024 at 8:42=E2=80=AFAM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Thu, 2024-04-25 at 17:07 +0800, Peter Yin wrote:
> > Regarding the AST2600 specification, the WDTn Timeout Status Register
> > (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> > on ast2500 if the boot was from the second boot source.
> > It does not indicate that the most recent reset was triggered by
> > the watchdog. The code should just be changed to set WDIOF_CARDRESET
> > if bit 0 of the status register is set. However, this bit can be clear =
when
> > watchdog register 0x0c bit1(Reset System after timeout) is enabled.
> > Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRE=
SET
> > in ast2600 SCU74 or ast2400/ast2500 SCU3C.
> >
> > Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> > ---
> >  drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 103 insertions(+), 6 deletions(-)
>
> After this patch the probe() implementation is ~250loc with a whole
> bunch of conditional behaviours based on the SoC version. Maybe it's
> time to break it up into version-specific functions that are called
> from the probe() implementation?
>
> Andrew

