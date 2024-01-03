Return-Path: <linux-kernel+bounces-15382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF293822B39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8723D1F23FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18A18B0D;
	Wed,  3 Jan 2024 10:24:27 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA2D18C03;
	Wed,  3 Jan 2024 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-594cabe74f8so342439eaf.0;
        Wed, 03 Jan 2024 02:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277464; x=1704882264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cqvf+yrxjn7ZuAyIxhrwAMBD1FRrppXcklII58Vtq/g=;
        b=VLwFktISnJAKXiFUPuSK+sjghmSASVhzCtMAdAYT5V262n+680JEZbNfqP9o8iiRME
         ubnbB2eoNcFLBlrB8lzei6lKKfIzpyoYybVfT19zQzioqbK0s0ajfQM77VLN0Qlv3LC5
         N9tEhef+RqSr2u20wW3D+zE5oRp4yGCU+DR2T9uikZETj7EqG85O4g6fRWOJQfHr0zb4
         23sqPLxNwjN+dNV6rKQnGCEZREusYIDIeisP4QFBdWm1YVmBaE1Ug8KQYmo8Jprz71XJ
         fxYd+PS/2z7rVsfD2w6PEcj9PJmyZEC1fWOrqsNZ3soaBZqF+PgcfdfodMoSJvgGGZdw
         P9Iw==
X-Gm-Message-State: AOJu0YxAmmK8qQQr0DfKCJpyQbxwvhaBybomUKNmmYqrk4nD8eZeUExf
	pZt/wdWnu9zJLKUlz4R2Y0hGMlqM++rdQgkkB/5RR1En
X-Google-Smtp-Source: AGHT+IExyBe6bUzYjW4DhQn85miz2Ftlb3jJzSW0DMcvpVuAG09NrGfmwPf01hFToO3AzQ8Z3o3A1i0t6Ko61ien5vk=
X-Received: by 2002:a4a:dc96:0:b0:594:ad62:bab9 with SMTP id
 g22-20020a4adc96000000b00594ad62bab9mr19642880oou.1.1704277464554; Wed, 03
 Jan 2024 02:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4556052.LvFx2qVVIh@kreacher> <CAJZ5v0hRGKjwDv0VLw550CLfUuNGaVXxmvcpbFhS=PCPqY0n4A@mail.gmail.com>
 <b670b0bc-79ea-4be7-a78d-644b344be408@arm.com>
In-Reply-To: <b670b0bc-79ea-4be7-a78d-644b344be408@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 11:24:13 +0100
Message-ID: <CAJZ5v0jcaa8S7g+kKCC9yHHW-7BN0TLWZecOhdNMpHWYFExgHw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] thermal: netlink: Redefine the API and drop unused code
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Wed, Jan 3, 2024 at 9:10=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Hi Rafael,
>
> On 1/2/24 13:24, Rafael J. Wysocki wrote:
> > On Fri, Dec 15, 2023 at 9:02=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> >>
> >> Hi Everyone,
> >>
> >> This patch series redefines the thermal netlink API to be somewhat mor=
e
> >> convenient to use on the caller side and drops some unused code from
> >> the thermal netlink library.
> >>
> >> Please refer to the individual patch changelogs for details.
> >
> > No feedback, so this series doesn't appear to be controversial, and I
> > would like to get it into 6.8.
> >
> > Tentatively queuing it up and please let me know if it is problematic.
> >
> > Thanks!
> >
>
> I agree, these are not controversial patches, so IMO queuing them is OK.
> I took a glance at them, but I can do the proper review today if you
> like.

Well, if you can allocate some time for that, it would be appreciated!

