Return-Path: <linux-kernel+bounces-112157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B631A88765B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 02:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA54D1C21A7F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 01:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3D61388;
	Sat, 23 Mar 2024 01:22:51 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6FA48;
	Sat, 23 Mar 2024 01:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711156970; cv=none; b=uHF2iqIvQr/M4OWDN3UbL3KlJc53qrNbtqkb8gwpV5N9Kw5IaYOJWPmZiUNBc+XdKGNDwCHT32/gXrPBkQ/w/eD7ajGhVkyiWmHKgWQFH+XUODFjWp7DnqacLkgy02aGLom52BweGyf0+KfeqnQF6esfKfqj3JKiXME/T1WENZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711156970; c=relaxed/simple;
	bh=g+qmIKlNwWrQDYzprQZoIGrFsxp3GGvahsrx0ZcmM2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhG0voiHRJWA3YQ/oP4xky/q2x6J6OMUnj+XX4JCQcLFBl+6pxDyj5zhcb9t3dbdWD/AzGyzZZMbmYgpKQgS1VjulnVpQuWIXzu7cI34DddcmeD58sB3CSbjVja6W+MiJjUuE/EKvUzSf/iStHaxl7JAsCkA0w2IKClTldCc6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so1892310a12.0;
        Fri, 22 Mar 2024 18:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711156968; x=1711761768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+0aYMbrnVXpxfNyD1kFQ/0ZCzbVxGiIosenue/Nirk=;
        b=EDPLxeo3kmayxWMmehLbScRDb8PkotJoZjt6yr1iia7DuoVQB8lpDm7q1NknLqte3I
         +PENvAZOSdYvWv/FJFsj29rcXsxmewT+ikJCLIzA7SlmIPiH0b+vkxI9LHxOY8gNqwKX
         8aru82CtkAuwOUN4XnITmkq3hKVxkkbBVJT0CS70DLWakUHhrzsmOAfehYqbCvTTLuwd
         w29xNNUlf1NPXMAKXM5Dnmy/avDTAlXEW5W5KK6oE8kEdH6aJPFWGoK9fHmg9jmROCzh
         h91szPAYtxAojkpyj0eveN3ercn3GI9ZDhTQgur5rUxSW8mhu0lvJG5sSo2hxOahCkRy
         KRkg==
X-Forwarded-Encrypted: i=1; AJvYcCWnbsJvjNXXg5j2pdBuAvok21EOWHmdlfnvli/qlaLP4m20Wg0SE9owfg2iKiQoJrz3e5U1aCHAEfpStB6hS61NQ02pOqysuuBje2h0WrrvaCGDQFoaIS/31SoItSJust60+DB8xK+i2UcxrvmWVQ==
X-Gm-Message-State: AOJu0YwUMWwvGeKnJNRRdxHQjtPUmoHUE61raeRlE9NyR4St7a4LS+0Y
	Qj3BaMVYr+JRzjk6GDfU1smBogQ/zJU++jxtm6dqzzU833dRbWGQFqIv0ZmK6cJUjsNdsJZPa34
	aG0EfxnQbfU5zG0us1NnR/2OxZzM=
X-Google-Smtp-Source: AGHT+IG8AL/LCWLrgDYqEHDgy1TnH7Zrct2vQ47FKnUwlpTuTtVVj43GS4gR9sFC5t8aotRwe+0VGNGVZsDo1iMXwaw=
X-Received: by 2002:a05:6a20:be11:b0:1a3:ab6f:ca83 with SMTP id
 ge17-20020a056a20be1100b001a3ab6fca83mr1173045pzb.46.1711156968170; Fri, 22
 Mar 2024 18:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322164237.203358-1-ben.gainey@arm.com>
In-Reply-To: <20240322164237.203358-1-ben.gainey@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 22 Mar 2024 18:22:36 -0700
Message-ID: <CAM9d7chfXH0ynfT_PSPyjhE8ATa=fV-kbx_csgeQrWiv+1EiiQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] perf: Support PERF_SAMPLE_READ with inherit_stat
To: Ben Gainey <ben.gainey@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	james.clark@arm.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 9:42=E2=80=AFAM Ben Gainey <ben.gainey@arm.com> wro=
te:
>
> This change allows events to use PERF_SAMPLE READ with inherit so long
> as both inherit_stat and PERF_SAMPLE_TID are set.
>
> Currently it is not possible to use PERF_SAMPLE_READ with inherit. This
> restriction assumes the user is interested in collecting aggregate
> statistics as per `perf stat`. It prevents a user from collecting
> per-thread samples using counter groups from a multi-threaded or
> multi-process application, as with `perf record -e '{....}:S'`. Instead
> users must use system-wide mode, or forgo the ability to sample counter
> groups. System-wide mode is often problematic as it requires specific
> permissions (no CAP_PERFMON / root access), or may lead to capture of
> significant amounts of extra data from other processes running on the
> system.
>
> Perf already supports the ability to collect per-thread counts with
> `inherit` via the `inherit_stat` flag. This patch changes

I'm not sure about this part.  IIUC inherit and inherit_stat is not for
per-thread counts, it only supports per-process (including children)
events.


> `perf_event_alloc` relaxing the restriction to combine `inherit` with
> `PERF_SAMPLE_READ` so that the combination will be allowed so long as
> `inherit_stat` and `PERF_SAMPLE_TID` are enabled.

Anyway, does it really need 'inherit_stat'?  I think it's only for
counting use cases (e.g. 'perf stat') not for sampling.

Also technically, it can have PERF_SAMPLE_STREAM_ID instead
of PERF_SAMPLE_TID to distinguish the counter values.

>
> In this configuration stream ids (such as may appear in the read_format
> field of a PERF_RECORD_SAMPLE) are no longer globally unique, rather
> the pair of (stream id, tid) uniquely identify each event. Tools that
> rely on this, for example to calculate a delta between samples, would
> need updating to take this into account. Previously valid event
> configurations (system-wide, no-inherit and so on) where each stream id
> is the identifier are unaffected.

I think you meant PERF_SAMPLE_ID not PERF_SAMPLE_STREAM_ID.
IIUC the stream id is already unique.

Thanks,
Namhyung

>
>
> Changes since v3:
>  - Cleaned up perf test data changes incorrectly included into this
>    series from elsewhere.
>
> Changes since v2:
>  - Rebase on v6.8
>  - Respond to James Clarke's feedback; fixup some typos and move some
>    repeated checks into a helper macro.
>  - Cleaned up checkpatch lints.
>  - Updated perf test; fixed evsel handling so that existing tests pass
>    and added new tests to cover the new behaviour.
>
> Changes since v1:
>  - Rebase on v6.8-rc1
>  - Fixed value written into sample after child exists.
>  - Modified handling of switch-out so that context with these events
>    take the slow path, so that the per-event/per-thread PMU state is
>    correctly switched.
>  - Modified perf tools to support this mode of operation.
>
> Ben Gainey (4):
>   perf: Support PERF_SAMPLE_READ with inherit_stat
>   tools/perf: Track where perf_sample_ids need per-thread periods
>   tools/perf: Correctly calculate sample period for inherited
>     SAMPLE_READ values
>   tools/perf: Allow inherit + inherit_stat + PERF_SAMPLE_READ when
>     opening events
>
>  include/linux/perf_event.h                    |  1 +
>  kernel/events/core.c                          | 62 ++++++++++----
>  tools/lib/perf/evlist.c                       |  1 +
>  tools/lib/perf/evsel.c                        | 48 +++++++++++
>  tools/lib/perf/include/internal/evsel.h       | 55 ++++++++++++-
>  .../test-record-group-sampling-inherit-stat   | 62 ++++++++++++++
>  tools/perf/util/evsel.c                       | 82 ++++++++++++++++++-
>  tools/perf/util/evsel.h                       |  1 +
>  tools/perf/util/session.c                     | 11 ++-
>  9 files changed, 301 insertions(+), 22 deletions(-)
>  create mode 100644 tools/perf/tests/attr/test-record-group-sampling-inhe=
rit-stat
>
> --
> 2.44.0
>

