Return-Path: <linux-kernel+bounces-138939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92C89FC45
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9A728E249
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CCE172782;
	Wed, 10 Apr 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9p+IExG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199B316F0CC;
	Wed, 10 Apr 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764613; cv=none; b=Aq5bsPEywXBLbs9f47yYN2vFqJH/IDeV0ePr/gsKvaVNcwn6E5fw6OqxV590AqVj4nJyYJBfpij8329vvgBGuaBveHPzlnRZ2Y5/DQih1b5aJDtLmhXCwUUkvWC4Ot8NU+dvW9zqYYKkIqbouuqYBn0Qo6OTHuX+62ufxwjDKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764613; c=relaxed/simple;
	bh=m7g6XZOrWOR+xcsLIDtcAQGvtbAoitEl0jd9B9aOIXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaI391Z3QwTBpVn32BkDzXAE2dal5YlqjUTGpT7BFTx5eaPCFuuNBvwIWOdcabryfL4F/l/mW3WeTrBdWTeEot+GHy+GtXaSO3CQIeBPntLC72UQfa9pPPUbDQa0cs13hzYksV+4Q2efLKr112DzrrlsOs76cIUiENuajxLRTiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9p+IExG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86243C43330;
	Wed, 10 Apr 2024 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712764612;
	bh=m7g6XZOrWOR+xcsLIDtcAQGvtbAoitEl0jd9B9aOIXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f9p+IExGH7UoaoR1PSv63C7vdJqaK5ru2svSWjFdQwWMYeQ6STdnvVgq+ikK5NP/b
	 ZRubXqjRGCEfmhpu0dpbdozQyXfbvsFfnu3jfsBcJf/UTd4K/j/xA5a+eZkEApgDkv
	 +R25+I6lWvIIcFOatq1a9+tjHoSEy0/VG17oS9i5JruFNP4+B6j+CYs+NGgYg3clBf
	 Y5fyz3MtgSkNKNWjLL5FilryhpmyAA0VFKLHBhLF29HojS+FOqlYn3fmHGRkWD1IRV
	 4GaSuJ5JAgVWuniBE6rljwnmB1oQAXFOJm6PywLMneQ8ajPuczYKGdUKOuhLEq+URr
	 fr7t6v7CVGnFQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-22ec8db3803so572224fac.1;
        Wed, 10 Apr 2024 08:56:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQnjYA3NCb1nP4zE9LG4fXohbqQNsCl5VvCRhAIPx7OfMd4Y25SRCSLwcQtFA+Va7Q4bquGUITm6j0qb78rvPfu7eEfZQwb1bu5PaolUfOM8UPG9jKamfFOeMyhhTpDAVV1JlCmPY=
X-Gm-Message-State: AOJu0YzRczUtrKupCLo0ZQpYvukA3/pjue2tcbaSCpiNTtZQVoIUQmGg
	/Rv9mfAxV5kWqeEMC5lfZzH952YloGIjM9W9NQ9y8+fTG5mQLg7q4CGaVKg2agLGoYYRtc0oVPe
	aVnEUrL76QjHyLIMzrSp+Bq+0Vv0=
X-Google-Smtp-Source: AGHT+IECNxT89pwXBuDiC1lb4DCnKCL9XHtAMEbbetodKgUXGTo6d+Ez8YVfs76P9PNoGSP20m33a6GsouMJn5/tm88=
X-Received: by 2002:a05:6870:7183:b0:222:81cc:ac9c with SMTP id
 d3-20020a056870718300b0022281ccac9cmr3023708oah.5.1712764611654; Wed, 10 Apr
 2024 08:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4558251.LvFx2qVVIh@kreacher> <3556878.iIbC2pHGDl@kreacher>
 <CAJZ5v0j0jKi9=w_RiYqSZuQtveskcE8jKZHDwaP1EmNOxLk-RQ@mail.gmail.com> <a4e421d2-7279-4b03-9113-db0776dd5355@arm.com>
In-Reply-To: <a4e421d2-7279-4b03-9113-db0776dd5355@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 10 Apr 2024 17:56:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0igWeyW=x0DOeUVAvgUp4O+_QrXfwy=o3nj1+KAQ+B8pw@mail.gmail.com>
Message-ID: <CAJZ5v0igWeyW=x0DOeUVAvgUp4O+_QrXfwy=o3nj1+KAQ+B8pw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] thermal: core: Relocate critical and hot trip handling
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukasz,

On Fri, Apr 5, 2024 at 9:35=E2=80=AFAM Lukasz Luba <lukasz.luba@arm.com> wr=
ote:
>
> Hi Rafael,
>
> On 4/4/24 10:03, Rafael J. Wysocki wrote:
> > On Tue, Apr 2, 2024 at 9:04=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki=
net> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> Modify handle_thermal_trip() to call handle_critical_trips() only afte=
r
> >> finding that the trip temperature has been crossed on the way up and
> >> remove the redundant temperature check from the latter.
> >>
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > This change is premature, as it will cause handle_non_critical_trips()
> > to be called for hot/critical trips which is questionable, so I'm
> > withdrawing it for now.
> >
> > The rest of the series is still applicable, though.
> >
> >
>
> Could you explain your concerns about this, please?
> Is about the extra execution time for the non-critical trip,
> while we are in section of handling critical ASAP?
> (also it would require that extra sorting there IMO)

No, it is mostly about exposing the critical and hot trips to the
governor code that may not be ready for seeing them and get somewhat
surprised.  In particular, this would cause the User Space governor to
send uevents regarding critical and hot trip points which it has not
been doing so far and so user space may get confused.

