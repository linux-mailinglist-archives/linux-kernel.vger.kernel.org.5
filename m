Return-Path: <linux-kernel+bounces-155729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE48AF643
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0335E1F22E70
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF07713E3EF;
	Tue, 23 Apr 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkDHqjiE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098EF1420B3;
	Tue, 23 Apr 2024 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895550; cv=none; b=VNfa603+sIGce/4FBocrkimrd+/w6LFjvG3ovg7bO5UDu5u6SQFAgNzZu4vubfIREJzhT1JnEbDCsLpi+0po4AKTh+RVWVZZlWjx9mPuzej2mq5jcQ5W/Q3JUGlKWloVOBDkaNnVzafF/VIrfSwq+nO45aIqlcE6TxGdHj0xvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895550; c=relaxed/simple;
	bh=OGMcGHaqmVBhYuFv0XCcX1mQzR2UG/wAjsLV5VmbwUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+DdEU+AEViiqiKcoUVb3FLfIpgokpWGOglObbeILErporcoluqG+8CPDNwEbsNH7KzmuHuADpYt2OoLBcc3lYy4aea6vofxOI4FAzjhsuroS18kktu1CWqPuF9hEm6Dy9H5vFUJlQ6xtNHL1HdQjqmimXtA7X11A0lnHyUDFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkDHqjiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8526FC2BD10;
	Tue, 23 Apr 2024 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713895549;
	bh=OGMcGHaqmVBhYuFv0XCcX1mQzR2UG/wAjsLV5VmbwUI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WkDHqjiE3LCkX3HPeTNDULGQ0DVIPnQl/X1zq8Aw/MBVnjMFOVxl3ARRK9bmWkvAW
	 U0BlupYN2L8DjgJgUGOAVk7x2LUxcBv0xDo4VwabqNunS6+sVGDWwWEEALwaHmUqox
	 M8KOVtS9SFnqyEbuUIbBdNfR4pgHPeyLsRa9IN+edz0oR2DlbOnoRnyzQmhjqwJPO+
	 20i2Z1cxZSfuS0Bvy/nVywABRQL2OoE/vx+agEkCBxyzDdgawrLKFOCpNDDAM3ddM3
	 ZK+wneHy9SkQY9UOBCp8KzcIYCNWn8++17H99GKJ2xq2Hwm0qJXVemkzuO5JzUZ+jb
	 cueC0bXubAI9g==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5acdbfa7a45so1850905eaf.2;
        Tue, 23 Apr 2024 11:05:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWnzS3ct8FM6VkTqPOKolee1bv2qctRhUqpkHk4zExoWj2Ac3C5TRa9kwBXn0RVqb/n3ppicpN+8LKhJS4SzpYgdktufdiG5RfT8rr7nUiMCJnv0LqDHMR4VwmUb3OwapR+9/CxogY=
X-Gm-Message-State: AOJu0Yyo3Pva20DbbRmtj50IaSU8bcAKIL8luWvt61dTpQOsy+z1N4JG
	yA70HHzHgU5EQMn0zkUgm8Se0jg1AFU/ctIx2WOthmxL6B0O/XzRq6WfAcjmJY7nI95v3omW8dI
	0VM8Spk6UdmqHma4hFrwbiMNGmqU=
X-Google-Smtp-Source: AGHT+IHA3zRxg1BGJSgFNpcroEm6mCZAwWfZ03DVjGk2V5epNCqRunPkRnnFOzcfuQronb1t6Qww4+MDB94LAzg7Vaw=
X-Received: by 2002:a4a:ee8d:0:b0:5aa:6b2e:36f0 with SMTP id
 dk13-20020a4aee8d000000b005aa6b2e36f0mr126873oob.0.1713895548914; Tue, 23 Apr
 2024 11:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13515747.uLZWGnKmhe@kreacher> <1913649.CQOukoFCf9@kreacher>
 <8e26c3cb-1283-4561-95aa-30432f1d13ee@linaro.org> <CAJZ5v0h=15LYhukPWmHPK5hvD=2u75rTEiC8oJMVBFziMkB5gQ@mail.gmail.com>
 <33cafcb3-af9c-4058-b6b6-4e5aab6e21cb@linaro.org>
In-Reply-To: <33cafcb3-af9c-4058-b6b6-4e5aab6e21cb@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Apr 2024 20:05:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hR-fN08g-g_S261e+U=2Enfza3b9NZpmp4yhzAa=426A@mail.gmail.com>
Message-ID: <CAJZ5v0hR-fN08g-g_S261e+U=2Enfza3b9NZpmp4yhzAa=426A@mail.gmail.com>
Subject: Re: [PATCH v1 07/16] thermal: gov_power_allocator: Eliminate a
 redundant variable
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:00=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 23/04/2024 19:54, Rafael J. Wysocki wrote:
> > On Tue, Apr 23, 2024 at 7:35=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 10/04/2024 18:12, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Notice that the passive field in struct thermal_zone_device is not
> >>> used by the Power Allocator governor itself and so the ordering of
> >>> its updates with respect to allow_maximum_power() or allocate_power()
> >>> does not matter.
> >>>
> >>> Accordingly, make power_allocator_manage() update that field right
> >>> before returning, which allows the current value of it to be passed
> >>> directly to allow_maximum_power() without using the additional update
> >>> variable that can be dropped.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>
> >> The step_wise and the power allocator are changing the tz->passive
> >> values, so telling the core to start and stop the passive mitigation t=
imer.
> >>
> >> It looks strange that a plugin controls the core internal and not the
> >> opposite.
> >>
> >> I'm wondering if it would not make sense to have the following ops:
> >>
> >>          .start
> >>          .stop
> >>
> >> .start is called when the first trip point is crossed the way up
> >> .stop is called when the first trip point is crossed the way down
> >>
> >>    - The core is responsible to start and stop the passive mitigation =
timer.
> >>
> >>    - the governors do no longer us tz->passive
> >>
> >> The reset of the governor can happen at start or stop, as well as the
> >> device cooling states.
> >
> > I have a patch that simply increments tz->passive when a passive trip
> > point is passed on the way up and decrements it when a passive trip
> > point is crossed on the way down.  It appears to work reasonably well.
>
> Does it make the governors getting ride of it ? Or at least not changing
> its value ?

Not yet, but I'm going to update it this way.  The governors should
not mess up with tz->passive IMV.

