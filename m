Return-Path: <linux-kernel+bounces-15388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3847D822B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6B7DB22F84
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AAB18C16;
	Wed,  3 Jan 2024 10:26:35 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954918C01;
	Wed,  3 Jan 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-593f182f263so2312966eaf.0;
        Wed, 03 Jan 2024 02:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704277592; x=1704882392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpaaqw2etLR/hs22+qj7E5K5Xi3iMRhAz4MlAOEhsmk=;
        b=RM6bWWYcqIUHKbmDNvPp6ykIUO99qbg/CvYHORSwJ8Ra5rjeSs3DXb9pTvDnMF28Ah
         zO14VR6NcdwJe+faoD2Qf6rwaXESZvKhOJgsy9MM/xfOb5ZO2HOrupOCmEIwDQipBtje
         trgWepeoUsB0l04bDbW22m6inEeKLDM1cD9RZWF+WzLFh2X204X2baiUsW3XvROnS+I2
         nqpND/xhl9uprajVn97xJe2auXdsGvW7GmfxYYRnzAPuEWs6xeAFYavML+Z5xwCe1to5
         slmnR7uZTCoLlNre+bc1t4mrjgCJbsZWWw4e67SkHkKlIVsq+y6YtSP8WqJmna7i3bzK
         vZtw==
X-Gm-Message-State: AOJu0Yzh9eLlldMAZhEoxj0KZW/YKJUKHNCo0JIF4dPOo8pw9B++CgbH
	Hd8ou3X/VB7yxX0fmuG4iSXX0x43opsSJYmEc6yphWZL
X-Google-Smtp-Source: AGHT+IEaAOzfO5uo/6aswMWEivSoT8Dwc+BHdKAw000gMRmZE61EPsZLFyS5wMsfS3guEJemMvXxgC+XnCkP+UdpRC0=
X-Received: by 2002:a4a:ea4b:0:b0:595:fcca:e203 with SMTP id
 j11-20020a4aea4b000000b00595fccae203mr1588816ooe.0.1704277592793; Wed, 03 Jan
 2024 02:26:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4556052.LvFx2qVVIh@kreacher> <CAJZ5v0hRGKjwDv0VLw550CLfUuNGaVXxmvcpbFhS=PCPqY0n4A@mail.gmail.com>
 <3c9f9a53-958e-4d6c-8fe1-6514f97fe1e0@linaro.org>
In-Reply-To: <3c9f9a53-958e-4d6c-8fe1-6514f97fe1e0@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Jan 2024 11:26:22 +0100
Message-ID: <CAJZ5v0gVSYQBJgy1iU67dSbefGWQxOQCcz+xT+P-gLc+ZcOfTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] thermal: netlink: Redefine the API and drop unused code
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Jan 3, 2024 at 10:54=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> On 02/01/2024 14:24, Rafael J. Wysocki wrote:
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
>
> I did not have time to review them properly and I'm OoO until next week.
> Is it possible to wait for the next time so I can review them ?

I can defer them a few days of course, but if Lukasz can review them
in the meantime, I think that should be sufficient?

