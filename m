Return-Path: <linux-kernel+bounces-122830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CB888FE0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD877294C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E067E583;
	Thu, 28 Mar 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hByEHpw7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4B7CF2B;
	Thu, 28 Mar 2024 11:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625190; cv=none; b=Fz0TsEDXxBCe8VJCS6OvnHnxg7r2L6eCgKQgvyeP1Xjd+Og1vp4bHIVEetILnKs/F8WNf4t++exzcAJSyjsxkpqC4+qAVnPJf4tmS3H4tGDFGxsyg0CZcwnlSFseN/W6WifU1hQ5+8v2JgsFdsaveiKkFJebAuTQnKzrBb03WQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625190; c=relaxed/simple;
	bh=RW+bEitQVyzqcixJGBJkJeN1dc8oywkABnm+GeaVq5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7DMnvm5zJmUFbATb/qV5gN5765jtGi3DKlXBZ5o4SOIk8IyCgCfy74VhaRwl7L/djRKYxwXKGDuqCYTKY0fIjBtqgeDSb/G/FGsHzDMa35mHXRlfh05SaShsHSQiU9Ld+aZY65HjimrjudGECohE4ph+cjY3wEaOAQyctiDFHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hByEHpw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781ADC433C7;
	Thu, 28 Mar 2024 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711625190;
	bh=RW+bEitQVyzqcixJGBJkJeN1dc8oywkABnm+GeaVq5I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hByEHpw7A1f+VNpDOvuG6KswboMmsECSdiFzP1i4i5/TKdCTk6bXuW/91x+FyBbbx
	 cU3GQBAp41qpu84ZVHO4QOQ1V37RxxQTW5Wm8mEvGgQ8aVxw0l03hLEL8SY6hWd+eq
	 htFCiVXYeFGwEZ6nereNQmEtSyL/h/k/3zlZiQRU9BNBBVRjmggQ3jA2fDf/+UObyA
	 Jvt1mI5lPKPqYvVaKJbz3oEXcOhAm1JAYVov7JbP7BOvQ8XZhfkTpahyxjtcni7RX7
	 IFsC97O0f5yP5ccOxhuFwn3Aakyc+jE3vVI+wESSjSZznWE3gVp6hgk8bI7jODiVFr
	 jX9E3eKCcCNAQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2229ad7a15aso170019fac.0;
        Thu, 28 Mar 2024 04:26:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0VQ3Tg7+Ti/8qblzrUg8HBvvhNOyXM9YWDBL1jZA4m/jR3NagM8EAPl81Zmtj82SqbyN1EP4TPokL2NzqFtIIw2GkopfLfWIAGHCbvsfaices6Vyec8cIy0JLFr+MARPlHZgidN8=
X-Gm-Message-State: AOJu0YwtOjT2AXb95Pej1Projcr6YFhiu/w8fk0GZNFiPE5V2QFXTjNp
	6bhuyRvNwM+cnd0XtbSJLvNMb8wVgqmKlA2PyTms+tCfbN0bxI+w17WnVuBE58nsI6xm/muRFKu
	bWPgIYm7V8YYQnuG4pkbCaWnH2cM=
X-Google-Smtp-Source: AGHT+IFsY0yNL1Uoky4ja6PpWw1sFDAeWwkybKu8Ye/ktcEwRu/9Dew3Rp8WRBmejTHA+N6A0MgGQlK1qfRhyFj9iME=
X-Received: by 2002:a05:6870:e993:b0:229:ec0b:e078 with SMTP id
 r19-20020a056870e99300b00229ec0be078mr2648557oao.0.1711625189726; Thu, 28 Mar
 2024 04:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13494237.uLZWGnKmhe@kreacher> <9269494.CDJkKcVGEf@kreacher> <f1bdd6a971c67ea83697278ed2f1beff89a78f1f.camel@linux.intel.com>
In-Reply-To: <f1bdd6a971c67ea83697278ed2f1beff89a78f1f.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Mar 2024 12:26:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ir-V5ppRuw5q7PsZK4rsuvh7y4a3HNunJhovvurGh3hg@mail.gmail.com>
Message-ID: <CAJZ5v0ir-V5ppRuw5q7PsZK4rsuvh7y4a3HNunJhovvurGh3hg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] cpufreq: intel_pstate: Update the maximum CPU
 frequency consistently
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:08=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2024-03-25 at 18:06 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There are 3 places at which the maximum CPU frequency may change,
> > store_no_turbo(), intel_pstate_update_limits() (when called by the
> > cpufreq core) and intel_pstate_notify_work() (when handling a HWP
> > change notification).  Currently, cpuinfo.max_freq is only updated by
> > store_no_turbo(), although it principle it may be necessary to update
> > it at the other 2 places too.
>
> It also works for intel_pstate_notify_work() path as is without this
> change.
>
> To start with:
>
> $ sudo rdmsr 0x771
> 6080c14
> $ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_*
> 2000000
> 800000
> 0
>
> Now trigger a max frequency change via SST. intel_pstate_notify_work()
> called because guaranteed also changed. We didn't subscribe for max
> change only (although we should).
>
> Max changed from 2GHz to 1.9 GHz.
>
> $ sudo rdmsr 0x771
> 6080e13
> [labuser@gnr-bkc ~]$ cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_*
> 1900000
> 800000
> 0
>
> Now trigger SST to change to max frequency to 2GHz.
>
> sudo rdmsr 0x771
> 6080c14
>
> cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_*
> 2000000
> 800000
> 0
>
> May be you mean something else.

No, I don't, and you are right.

When I was writing the changelog, I somehow forgot that
intel_pstate_notify_work() called __intel_pstate_update_max_freq(),
even though the code changes in the patch obviously take that into
account (I can't really explain what happened :-/).

I'll fix the changelog.

Cheers,
Rafael

