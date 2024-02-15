Return-Path: <linux-kernel+bounces-66304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AFA855A11
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217951F29A73
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B549475;
	Thu, 15 Feb 2024 05:16:53 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AD98C1E;
	Thu, 15 Feb 2024 05:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707974213; cv=none; b=eSbIY6N0CWt7ntS7Es1Ed8K3THufQuZ5ES2QZ5bMIjsw+JQql0+bPNhScSHcA+jf6QIpj8euoFLL5OgRZMaoTPGB7esZinphHSyOLyoPjmwZWFHyNrqoRTiPI8q3tjUIM81JbFRZE2lPU7sPUOOs9OwDMIUEtl60TiJmPXnsxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707974213; c=relaxed/simple;
	bh=WKtwSdl5mpFfEMXteLY1/ZKYrOUDBVq7SR6RNuUdqqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hH3RGRfWsZOFqRLLZy+YTR0mNa0BjW7TmkOnZeQ5ePbguPAtHwB0FtiQBcn0OiBrnv3KMbq5IIawuCpEXMtjppZsiU+joUHUaAuEEpH90dGyVWp96LQ7vKVeydGoPViU1/1/UOZ6VX4jz0vgwMkR3GCS8rxFULgm7JejJ2moGrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso412019a12.2;
        Wed, 14 Feb 2024 21:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707974211; x=1708579011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ruwll+hxpV2Wzn+JcenNTjZZjZj6kJ1R9W9xEqhdl8=;
        b=RdZOQ1ka8m/GaU+LSHU/WUz0UBnPQnDm9aR4VPtZxrWh0qZyCcgHw0YQNomRcZWjMo
         qNvLMVQvDB095FJhhh9a45SnQ5L/TmSG0aM3fGqK8h32OVK/s/6Onu17ospESZzLd7v0
         gWGDHnTpfAnv1ixbqTXIsPht1fMoVEe6bO0cprQmJ5KiETPDPV948PY91OvBCbZH4cwi
         3Z6CHns6d8fgA27zKSQT31sAb/GDvM52KgIYhm6IfwjJuDjZBNhMeB4kWCbYmmUM+eGY
         uqYjTtEoL09W9wpoJfYjlxESaxDc5RFWaeuWAD5cKbgIc3eFCmV7u8m09NcSYA88HBSL
         yplg==
X-Forwarded-Encrypted: i=1; AJvYcCXFDtJA0/5MA2W+ZW91fD7rvrfZITPepdsjpLCWUguJZS028rgjuQkitnP4+VKPw91sqbA9EfI+hQnqMcbheY4duqRyx7mkdi8xLk0mSijo7akfmI45/6WIcqKezJCImoG9haivDFjjn9kvhOo5Og==
X-Gm-Message-State: AOJu0Yx0/s8AgVXqC1e6BB5MNNAhp2LrllawWmYXsCGnXZDCiSVg0dr5
	YdE1fUTL42mgNQDG316Nrgjoc1TR7qZO4dgURzQQI6i1zv791KMjQbo8DYDz9325tRzSzv6FQJE
	3sxsh1geZ8m+5pJeAxI54T6EXzFo=
X-Google-Smtp-Source: AGHT+IEZeWol3ZAZUtZ21zYeS6PEFB1WMIMMONAEcTsE8qZ7WyTw1ISUW3T+uLeusGQubNW/+EurgGE03EczMMArcjU=
X-Received: by 2002:a17:90b:4a06:b0:298:b0b6:3824 with SMTP id
 kk6-20020a17090b4a0600b00298b0b63824mr716577pjb.48.1707974210848; Wed, 14 Feb
 2024 21:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213075256.1983638-1-namhyung@kernel.org> <20240213075256.1983638-2-namhyung@kernel.org>
 <CAP-5=fVXgKc0r+fup0+2-JOAtJERAsPq61MZh_f7HYTk2XqObg@mail.gmail.com>
In-Reply-To: <CAP-5=fVXgKc0r+fup0+2-JOAtJERAsPq61MZh_f7HYTk2XqObg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Wed, 14 Feb 2024 21:16:39 -0800
Message-ID: <CAM9d7chCSSpJKfG=ThpzRXz2tL4Ao2SBAJ6tBJ7GFHLoWBRSuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] libperf evlist: Update group info in perf_evlist__remove()
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 3:50=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Feb 12, 2024 at 11:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> >
> > When an event in a group is removed, it should update the group status
> > including the pointer to leader and number of member events.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Should we worry about evlist's all_cpus that could also be stale now?

Hmm.. right.  I will refresh the cpu list after removal.

Thanks,
Namhyung

