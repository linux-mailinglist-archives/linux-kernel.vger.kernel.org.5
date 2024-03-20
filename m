Return-Path: <linux-kernel+bounces-108593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93654880CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A55EB21A14
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7C2C86A;
	Wed, 20 Mar 2024 08:08:58 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC021642B;
	Wed, 20 Mar 2024 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922137; cv=none; b=XmXdtldK/cbSHIzOoqKPYqnIaalfFFlu9tRzrKIAVjEBZGYb7Sk+wkRC8z4Yb4T/ntTecc64hMnjcx1CPta5rSEvKjy86UMn6C2r4qlCpYAJCcDXP+I+Mh+VhySmaaibuDA63XXJAscUAcLgjGQJCRNwm3Pgz3p7GynNRxlv+CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922137; c=relaxed/simple;
	bh=YHYOadkmOipUMw5vHmVozyaiYQFe3Wgatl1WnyHvUMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZLpH1mVvxKvc8N3qDJ8xiuCksBVi+0Talor+EErEkzSIYrFH5CIlXiQ1Rok6z631IrE7oIohD49qGZD+c3XlImH2ejwv28RfB/+zHcxLxucxZ02VOtKKm1IWgmO7okaOwm7kaJjBuRoK55l18OPRd5vF3gdjg94d1se1kTerBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609f359b7b1so75592957b3.1;
        Wed, 20 Mar 2024 01:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710922134; x=1711526934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxAjfDS34SkaeqdOsAUG7ZjS13iVv3mgsYNBQbuG+9o=;
        b=CTT35BJxGjG91jqMkN0Qlmvj17pcrdP6khHdiQuK5K0IfErFPZOY+SSshO3wPsMIIA
         rjaD+ugB3Tp1v+9ZD/1Zi8B3tL+QATd6ngQAFv6M0Rhhi+fD/altqf4CwcmAFtZdnOYM
         J1DbsW1aReZJhcgZK+EYPR8zrua9Vi9rItilg82X//Hgdi0Lf8XRmmZ75Jb9xF1BADB7
         1cHVhJCvGsh3Mgw147U5fMK3oBNs8vjQvDyjehvBFe6Gi1Poa54dmswlI6CVDceXUAQo
         a0Aul9Z3s79vHc5FmQqQIoyXshldaHxFXuaaDhy14kaGVa2jZwHjs1Pl23C5CQ7YJEWd
         /wfg==
X-Forwarded-Encrypted: i=1; AJvYcCWXHxvhYKAMSw7K34XRNChj61bIyZaUf1Sl6JljR6XwAiQLOc3p3CPZ395APJZZzreZMCb3oX3HRqt/JSXAj1+36Ukzq25x+1RDippgnoLSkhdOTTS2n/JMVgPbs+90gbAzPu7viXtEAg==
X-Gm-Message-State: AOJu0Yze0QXTThUOlTqKmxQndok+5lwaCPv3kv1k79cGlZtrAcFV3rTd
	RG6tqP/n9P/oBVJUnGcHNx3zzYioBMv6AiGm2j3Oi85SaAxNtbCWd11HQg5D0+0=
X-Google-Smtp-Source: AGHT+IGasCsLKtbgBJzbK44zWI4+raapf2xsNEu4QsMmZWQ1hc1o3WHnw/x577Pc62k3/HA3LIbbCw==
X-Received: by 2002:a81:b2c7:0:b0:610:e46c:18f6 with SMTP id q190-20020a81b2c7000000b00610e46c18f6mr3966229ywh.17.1710922134605;
        Wed, 20 Mar 2024 01:08:54 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id p1-20020a81ca01000000b00610f3850e14sm249309ywi.131.2024.03.20.01.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 01:08:54 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-609f359b7b1so75592767b3.1;
        Wed, 20 Mar 2024 01:08:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/vIirLIYjDEH7xzHHiZtNMnZ9eO7W0YwOKX/uMLWWf6qx9lMzh8h2SDd675NBDHX3R4EFDARFr5AOfPydI07qLv49QnsYuIPtNog5beQzz7eIk2GZ9GBaL/CKIcQzGLRI4dgTsN7eZw==
X-Received: by 2002:a0d:fb87:0:b0:609:fdf7:b443 with SMTP id
 l129-20020a0dfb87000000b00609fdf7b443mr4533721ywf.52.1710922133920; Wed, 20
 Mar 2024 01:08:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48ca5e827ca420bbdbabb1643e2179dc95c9e0b7.1710849638.git.geert@linux-m68k.org>
 <d1a1b0b8-41f1-4ead-b393-d8d2f099b0c4@acm.org> <CAMuHMdWzD1OR8qj8oHfUgQ9GMtrD8y69G+A+ONdVm0vTCvYe=w@mail.gmail.com>
 <0d41ae1a-f6aa-4377-b8a3-7fcf067f99ac@acm.org>
In-Reply-To: <0d41ae1a-f6aa-4377-b8a3-7fcf067f99ac@acm.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2024 09:08:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVig-cm7KPi76ow9-xyZ55z4YgYrx6QuO9V5A0ni7HxDA@mail.gmail.com>
Message-ID: <CAMuHMdVig-cm7KPi76ow9-xyZ55z4YgYrx6QuO9V5A0ni7HxDA@mail.gmail.com>
Subject: Re: [PATCH] scsi: core: Make scsi_lib KUnit tests modular for real
To: Bart Van Assche <bvanassche@acm.org>
Cc: Mike Christie <michael.christie@oracle.com>, 
	"James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hoi Bart,

CC linux-kselftest@vger.kernel.org

On Tue, Mar 19, 2024 at 6:01=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
> On 3/19/24 09:10, Geert Uytterhoeven wrote:
> > On Tue, Mar 19, 2024 at 5:03=E2=80=AFPM Bart Van Assche <bvanassche@acm=
org> wrote:
> >> On 3/19/24 05:02, Geert Uytterhoeven wrote:
> >> kernel module? What are the advantages compared to the current approac=
h?
> >> That information is missing from the patch description.
> >
> > SCSI_LIB_KUNIT_TEST is already tristate, so the original author must
> > have meant it to be modular.  Or perhaps he just copied it from
> > (most/all) other tests ;-)
> >
> > Anyway, I find it very useful to be able to do "modprobe kunit" and
> > "modprobe <test>" to run a test when I feel the need to do so.
>
> Why to run hardware-independent kunit tests on the target system instead
> of on the host? Isn't it much more convenient when developing embedded
> software to run kunit tests on the host using UML? The script I use to

Because test results may differ between target and host?
It's not uncommon for supposedly hardware-independent tests to behave
differently on different architectures and platforms, due to subtle
differences in word size, endianness, alignment rules, CPU topology, ...

> run SCSI kunit tests is available below. And if there is a desire to run
> SCSI tests on the target system, how about adding triggers in sysfs for
> running kunit tests? The (GPL v2) Samsung smartphone kernel supports
> this but I have not yet checked whether their implementation is
> appropriate for the upstream kernel.

That would require all tests to be built-in, reducing the amount of memory
(if any remains at all) available to the real application.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

