Return-Path: <linux-kernel+bounces-55798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58AD84C1E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02EBFB21AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B01C8C4;
	Wed,  7 Feb 2024 01:29:48 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8ACD267;
	Wed,  7 Feb 2024 01:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707269387; cv=none; b=Pxa3QkEAqjAQnQaAhHw0aw77elhCSE71h7A77Kywp/1fgTby7H4zV4yzbDl0LS39LvoFjXFkCUh3D3c+GeeMt2RWbcUaRUbeYeFxXbrx5jzjyBw3MkoXIVLtF62UszCLz7vvPJCN8C+9EgDcbaZYGNzHmD2rMi3UhUxt/k7CxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707269387; c=relaxed/simple;
	bh=7LavG8jMyccXWVp7cRBsy8BANS/3CgKOHLGHFdtQqyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4R0+bkg9stNPSaIrGgpK0QXMRYUc8rt0djZOzB30/njFQ4CCIT85oiRt4kqWH2x6bXBoaM1qQrNVJI4MgiWHiSWRjwGZdlIQHOIsf32pClaK9tREYijLUzynqVhdfZE/zOpffA13By1tStUKx6OfNIynLu8M3cEmCzOQ1MlHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e067ececb1so77172b3a.3;
        Tue, 06 Feb 2024 17:29:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707269385; x=1707874185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39tNX3eQwjL3Nw/bzUuXe+Kw6+iYW52FocBtDdukHNk=;
        b=FzYOfk54FGZWT3JD3xaouHRvfSQfvT8mOr2B4Bi84aQuLHXs57I/tk4YCEgoJwXuFN
         QLWc7II6ez/BgU+IW6Wp6eYn8A09NJOWXgccO9raoqGLCGXODpR600+4xfGV/qhqn3Nf
         KCxjgZE6FUePC4BkxqAgwEui/8F6zjYAqW1qDKWuEJZhZZ4VTH0FW+TsC915w48vCkn/
         dL9F3Uyx9VXb8Ks/+FxjrpeG6ofV6/dqFMyRgYD5sETI03nLhr4w9hiO2FlvAoMyluJ9
         bQFC4Lmj0asw5TgUqYNHsXZ3RLyToJr6P7pceiQW/WC2tYAMrOlbopVI4TVwJCKG65mw
         H0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqwSVAwi9dlCRvJ5LB9PKNG2gL/xoeD4QQZAWOSX/a92OBHgUFxS8GUXMX2iULOjG/wEnxeYcaTwDCM5+jPnwDiihENzu/hoO9bxjlosAIR6dGczntYmhYYhn2172yeJKW0To0ztELq7WlmrIjEMxHqANQMP2DUSWORI03dqDWH1elZjYDzKdmJTLPLguFyJCJN6fMabM40YZpPU9/UgteRxugSd5S/pxeZi4HyZE5n6qtfQ==
X-Gm-Message-State: AOJu0Yz2HCOiOk8R0A1ddCvcoVQQKiOD88GZlXAEX0qM9wm//Xz51AWf
	i3r00Bi+2lpLNAh2SbXfKU2luBpB3yyzheB8S6eaRlea3n0LfvhRRcuqHedpKbArZe2QSnj4nwr
	KrErKYwikk+Zr7g7SeJmE0jJ8oEkh0KM/hsk=
X-Google-Smtp-Source: AGHT+IGf1F2e6N9N+PrdkWzLAd3fNOyTM/4Fc0qxoQrZrZTsO2/Ds85UkZYEwKzXnIsM3CexCOOokqwW+RfeEu8FCuY=
X-Received: by 2002:a05:6a20:9184:b0:19a:4462:4ad6 with SMTP id
 v4-20020a056a20918400b0019a44624ad6mr4161703pzd.31.1707269385135; Tue, 06 Feb
 2024 17:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202220459.527138-1-namhyung@kernel.org> <20240202220459.527138-10-namhyung@kernel.org>
 <CAP-5=fWhHb8iomEQ_rhwC50kGhPEVbDZv6X6riY_3pr787bhAQ@mail.gmail.com>
 <CAM9d7cg4Apu0OhDrn2uPzRnzV24-vK=L-yR04=2eGR=n_YngTA@mail.gmail.com>
 <CAP-5=fVPfSBGi1DrNkv3Moug_HyPZdEyab6X6sDyg=1-F2NAWw@mail.gmail.com> <CA+JHD91q4vA5z0g4AMPJpXV-+_ppmg6+jVu=YWcxY4hARn5LRw@mail.gmail.com>
In-Reply-To: <CA+JHD91q4vA5z0g4AMPJpXV-+_ppmg6+jVu=YWcxY4hARn5LRw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 6 Feb 2024 17:29:32 -0800
Message-ID: <CAM9d7cgoioUi7bopYtBETuY94c1nsroBnC9ZONNMZsFL1UKRbQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] perf annotate-data: Handle call instructions
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Stephane Eranian <eranian@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-toolchains@vger.kernel.org, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:44=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Tue, Feb 6, 2024, 8:36 PM Ian Rogers <irogers@google.com> wrote:
>>
>> On Tue, Feb 6, 2024 at 3:17=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
>> >
>> > On Fri, Feb 2, 2024 at 7:09=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
>> > >
>> > > On Fri, Feb 2, 2024 at 2:05=E2=80=AFPM Namhyung Kim <namhyung@kernel=
org> wrote:
>> > > >
>> > > > When updating instruction states, the call instruction should play=
 a
>> > > > role since it can change the register states.  For simplicity, mar=
k some
>> > > > registers as scratch registers (should be arch-dependent), and
>> > > > invalidate them all after a function call.
>> > >
>> > > nit: Volatile or caller-save would be a more conventional name than =
scratch.
>> >
>> > 'volatile' is a keyword and 'caller_saved' seems somewhat verbose.
>> > Maybe 'temporary'?
>>
>> Sgtm, perhaps temp for brevity and the documentation to call them caller=
 save?
>
>
>
> "caller_saved" seems to be the conventional name doesn't look too long to=
 use to help in reading this code by new people that have read the literatu=
re.

Ok, as you both requested, I will use "caller_saved". :)

Thanks,
Namhyung


>
> For instance, from a quick Google search:
>
> https://stackoverflow.com/questions/9268586/what-are-callee-and-caller-sa=
ved-registers
>
> - Arnaldo

