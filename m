Return-Path: <linux-kernel+bounces-163814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835EE8B71DA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5E3A1C225A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B50612D1FD;
	Tue, 30 Apr 2024 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGyug1LK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BF712C462;
	Tue, 30 Apr 2024 11:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474889; cv=none; b=Sm1A0K646qvMSz7KQHerrFX3xwpZdi9f4ZNqCjk5m2feQ7ReMPnTbkCVXdQke+suz+z4jI3KbfSQM4clPvjLy50E6saSufBpYXAm6J9xC4xXJVrw5VRWU2zTcLiJppxcK0HtYP1Tw4ru76DdWMX4RUSUwEcOGY1iX/Qi3yPCVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474889; c=relaxed/simple;
	bh=7k26v8spb/SVU8KHpWsFuVmQm5vt6zLCxU8gvvmJook=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8dlz9SV9FxXm9X3ylGmlwByoC0VjJlmN1VXHFTu9z/8CdOLNgvPaCnDprlAu7ORyhifHdIzVH8DFIlT1A2I0T4P15ooOnG7Qfzdqhz2TdliRktCOeZB9hT19z+cHRuU5zxCGFMozFWFKuTTCRp/P0xu+8tUQz2x+3xKXYyerc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGyug1LK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2052CC4AF1D;
	Tue, 30 Apr 2024 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714474889;
	bh=7k26v8spb/SVU8KHpWsFuVmQm5vt6zLCxU8gvvmJook=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GGyug1LKuNWymH/ERsE/SqyEKJ4tQDhqpB7AQgHS3JmYwT9W4LmsEmygP+76DlGdo
	 WhGMh2GIqdED2SU1fXEmwwClyPJNOGcfJmBw1uhr9lPaknoR0M35XNdxKCFeYg7wpY
	 UkBXZx05wD7PFKzzgnYIvRFsDDClcgMNeQftm0lG4ljfQNyV+5siClgSYhnIo4N2m+
	 c5Wnq8Dm91MAAQcXMapRUR+bza06buUeqnC8T2hUri5biPP8f9fzQlfU4lODvbTmpc
	 /C4ffB4pOetheQfpS2tRWARniB2bWz99RWGM0EFCYbNGObpf6zTExRcNAY/vYDeT2x
	 kxTN0xr6+h+Hg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ac970dded6so1319151eaf.0;
        Tue, 30 Apr 2024 04:01:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWk3yHi3Php4wEkSyjV878+3BZIptycLh7VXPwCn1O+FQ7F84OQsoV44hyA0NwAbD3J/vMzFvhMY2WqXkHdYbt9DNvp+VxTBpqB9veRtZvxCgwb/AzZL1DWhRpY2/UkkRVdlNeDsuXqAYz3QmZjwgyec8DXqid19kH7jFNzTQIsdqhqzJdLzPo=
X-Gm-Message-State: AOJu0YwCgbDcGa2NJcN8731s0d4RJc8xFPAj/+X9NRchuwobsumLHToX
	VzQQiSihOXxJ/iPz9FhSUDAWlzgGPq9mHOzTxmlldYVR1ZM2Jky5E6ydG2yDSKSRfJHY1vyMhmv
	4KXhKuDYEpJTaqtHhSaJEaYQz2SY=
X-Google-Smtp-Source: AGHT+IFp05rDtY+IvpJ8x7q4pMxAXzR0PMTOyMAy5jx8xIsDl3iRswutRKcNQGaJAEvhKWLxz6FJReMtS8/5Y9j11aQ=
X-Received: by 2002:a4a:a683:0:b0:5aa:3e4f:f01e with SMTP id
 f3-20020a4aa683000000b005aa3e4ff01emr14418920oom.1.1714474888346; Tue, 30 Apr
 2024 04:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429-strncpy-kernel-power-hibernate-c-v1-1-8688f492d3e6@google.com>
 <20240430093625.qbuaxltkrmlaoiza@dhruva>
In-Reply-To: <20240430093625.qbuaxltkrmlaoiza@dhruva>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 30 Apr 2024 13:01:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iesjQ2CS8OUDcFzjdRtZVDbOMnBtF5BR6ugx01g55N+A@mail.gmail.com>
Message-ID: <CAJZ5v0iesjQ2CS8OUDcFzjdRtZVDbOMnBtF5BR6ugx01g55N+A@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: replace deprecated strncpy with strscpy
To: Dhruva Gole <d-gole@ti.com>, Justin Stitt <justinstitt@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 11:36=E2=80=AFAM Dhruva Gole <d-gole@ti.com> wrote:
>
> On Apr 29, 2024 at 20:50:30 +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > This kernel config option is simply assigned with the resume_file
> > buffer. It should be NUL-terminated but not necessarily NUL-padded as
> > per its further usage with other string apis:
> > |     static int __init find_resume_device(void)
> > |     {
> > |             if (!strlen(resume_file))
> > |                     return -ENOENT;
> > |
> > |             pm_pr_dbg("Checking hibernation image partition %s\n", re=
sume_file);
> >
> > Use strscpy [2] as it guarantees NUL-termination on the destination
> > buffer. Specifically, use the new 2-argument version of strscpy()
> > introduced in Commit e6584c3964f2f ("string: Allow 2-argument
> > strscpy()").
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> [...]
>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Applied as 6.10 material, thanks!

