Return-Path: <linux-kernel+bounces-74969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221E85E095
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59811C22823
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE827FBCE;
	Wed, 21 Feb 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K50p+rEw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50C69D05
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528178; cv=none; b=vFAFBITsGRXcoFLDsLALqVmkUbd3ZtmlICUz0N5jJX/fu2ZPCD4bXX+jfPzYehPO/ylqD0lpywj1DJtz+xHJKwyg8wyetzk1Z0/PtaCvoC0O2g9v63aWqBd3MQ9xF0cl8q7m2/2gCom/j5Flym1BSnyAtrV4ZuhBbymo/KMzPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528178; c=relaxed/simple;
	bh=RYGokGLx+MsZssGjhMGohu1anyJAoXCl5Na4dmZHiyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soWNYFVCj99ilDynEhZwLFVUMSS2a16oYvLLnDLNf9hnP9DZdP5bhBan2vQVISVjW4zUDq7t1TYuCDFYYGtwYzsBHAqVxyAcTO/5eeRzXvMe3kG7h9e8VzWVCGgwuC3k140iiOGUQE2c5O4OswDQpt5mM4OiZ19vwf6PN00cCAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K50p+rEw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d73066880eso63973175ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708528176; x=1709132976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYGokGLx+MsZssGjhMGohu1anyJAoXCl5Na4dmZHiyA=;
        b=K50p+rEwAMnE8dkijb8hbc47y2wQsAHdmfwsfPGZKLSMm7lMshZ1FAebXlirIaJ5Gb
         C07N7LTPUqwM+ds5xh6l6BzNbPtWqV0gJu5YUqffVIpYVxdbeUi4vxG0N7/S6++bHIt3
         xeV/Lz1lcC/P9mtrlD/Q+co8/cz8ehc/jTwJjQyCqFXA97EVc7Gov3Ieuu7HxRLOcz9v
         6tV+5odQdRv2BkBnd4BcNMNNuAcBE8h3jThdF7n4gRP8iBPb29HCdXz2kAGX8ogc86kD
         9v5EjLkFn0pMmm9aRlY8Z6/UrO0ZEVuksuTJFebtiIZF+z5lmEiH7v0uL0JxMsw8xY0C
         pmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528176; x=1709132976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYGokGLx+MsZssGjhMGohu1anyJAoXCl5Na4dmZHiyA=;
        b=REv3Vsb6zQDBhZ0QUlirxEPkMcNwnv/zjmjrph2i2gylhEVeqXfQU/6kW7JNsNOR0f
         WilRX4Quhr5sb0sDopeNowgkZA/cJ2lUta+OscyGYG3tx0FChoODY05xrAU45CSpD1Om
         ZBWkt5MyTNMgPZrabkzHb8U34P4cmxSU0Yf+/Gee2OWUP95uw1+U5cErZuZtPb8KIEWd
         grQEPkrXoFGJZJrLiZ0o6wpQstbQuBhbdxYM+cv+QvFTBISl3tNyjUaXDlH4Vgi1v3gQ
         kNclrN8GGJDaNxAr4pAXueO9R1jfmyIREP1RCknl2m6E1xXacdGWXu5omljJZJ9RzNC0
         OGzA==
X-Forwarded-Encrypted: i=1; AJvYcCW6chTXGiRyJgxzTfFZGYcarnPKj9VpMejEjC2YxS7tFVqMUD5w7Xrqga6n337YOhu/YrUygLueS0dN1P5BhV1hzPb6NRAsn1n9ackt
X-Gm-Message-State: AOJu0YyXjwGmjX9kMzaEBkxmDNptv+eEBGLkdVdxo/Kn2uWeX+FygvBw
	aT9e0zwu22aADliJcHj/4cMeuP6l/WzxAMT7Qrr8oEvGzi3rov8fv3BqR1HBji7Kt5o3enCD3wf
	kJ8xktLsxQgYYpn/9rN8nlVpYjnY=
X-Google-Smtp-Source: AGHT+IEca0w2zET9mnuEfIMyzr4ETxGm3rQePup7GK4aE/VKbU+SdeUCwyLtvZWLCoMpo2QIQfBpTxTE7FvykWhJkkg=
X-Received: by 2002:a17:90a:a008:b0:297:24b8:6dd4 with SMTP id
 q8-20020a17090aa00800b0029724b86dd4mr15598276pjp.21.1708528176285; Wed, 21
 Feb 2024 07:09:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219230116.77b8ad68@yea> <ZdRtDOhQGQUm5X4d@archie.me>
 <20240220134556.61f6441c@yea> <ae1ffd81-5026-4d64-b055-4f60090962a5@amd.com>
 <20240220184323.2c8b4f0a@yea> <3c5b80a7-5bf9-4752-a596-438924fdec9c@amd.com>
In-Reply-To: <3c5b80a7-5bf9-4752-a596-438924fdec9c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Feb 2024 10:09:23 -0500
Message-ID: <CADnq5_NUuZ_cfLxsS-ZBFh9b1DDNi-oNuuQuMz8Px7LtT_g6_A@mail.gmail.com>
Subject: Re: Running ttm_device_test leads to list_add corruption. prev->next
 should be next (ffffffffc05cd428), but was 6b6b6b6b6b6b6b6b.
 (prev=ffffa0b1a5c034f0) (kernel 6.7.5)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Karolina Stolarek <karolina.stolarek@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Zi Yan <ziy@nvidia.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 9:13=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.02.24 um 18:43 schrieb Erhard Furtner:
> > On Tue, 20 Feb 2024 14:50:04 +0100
> > Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> >
> >> Yeah and that's probably the problem. The test is not supposed to be
> >> compiled and executed on bare metal, but rather just as unit test
> >> through user mode Linux.
> >>
> >> We probably don't check that correctly in the kconfig for some reason.
> >> Can you provide your .config file?
> >>
> > Here's my v6.8-rc5 .config attached.
>
> Thanks for that.
>
> As long as nobody comes up with an approach how to run the test even
> when other drivers want to interact with TTM the attached patch is my
> best idea.
>
> It basically disabled compiling the TTM tests as long as neither
> compiling for UML or COMPILE_TEST are set.
>
> Opinions?

Makes sense to me.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks,
> Christian.
>
> >
> > Regards,
> > Erhard

