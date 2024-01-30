Return-Path: <linux-kernel+bounces-45504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7273584319B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06501C219A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C277EEFD;
	Tue, 30 Jan 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgsmiU9D"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D579DB1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706658907; cv=none; b=AsOJYIsiNA+/lTmhmmNrH3tIoH1Juqt1ymBKH0uKxdNMTesye9rDORcL7To9I+udyrOoScXvjZAIK+/ON+9pyLeeUUjtqKI6NCpmUlkJPCJr3HOfRm+hVAkh4PcLvFf8xhfg/N1GVzArH3t/x9W0I+DpGQ72xMHqJLj2k4S9Qzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706658907; c=relaxed/simple;
	bh=p2GcgaAdHa7BRbD4DeoJWHK47ieu1BWU78aKCcpW028=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UiZOFXh4Cmldr3+2HmHOV/CVtMEooXJtrXdMCE8neHfUbY7sbBWCs1D9TPZbG+jrDJ/oytA06mA9uaYIz3AJnOXE1b7YRGDOTM7AcoS8zdcihCCQ8Ccj/s5520pSTk0cK3HU7umHF03rMAskcouJOetok9DIrddSjca3+P77MQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgsmiU9D; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36387fd96easo7029705ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706658905; x=1707263705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoyajG9zgygzjGvubxqtKQvmVDhxzndQ43n2v/RUzK4=;
        b=JgsmiU9D+1Ejnn/CkA1XUUGgKdFzvr1yQSItKuiW3lXBJWejoaqEa/Hx5D2lOsSqrv
         7DxtUfaor9h5a90B5T9vzWWVxZT/nTmkIgDTK+slo+qGzwpqFXevDFGfrQk4qizjKsqe
         zoy1lVrpob0dg4sIM0QxpiYG1/WCrEf8Y1uwpnp7G86/Vm6a31B91EahZrp9iGYFs15x
         i/pcBPGLdE6+QYqczZLwBth5Kwq0I7QB1R0oPIwNpS/97xk/8xoKfu5blwP7QkcPHUfs
         x3WtsxB3eCz6S965wgflYDvl65iEhXt3Gazg+AGgiOUlohzR8KtR4K8rySPHELb++YYN
         pAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706658905; x=1707263705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XoyajG9zgygzjGvubxqtKQvmVDhxzndQ43n2v/RUzK4=;
        b=wPCeJQu1paUgn6UjjNJvetu0oBR93Q/c0qdhYiLTyddOeay5BixEQygMUSgz4MODXv
         DZVJYdUPuqn0y7uSFnsMXuO0MVT5MhRSs585+XbVHkUDgLTbhUTL1Q8SuevgvWsq4LR4
         w46G+yIAUx18NArYQ7hNYkz05cSuvBxBwP/tRMIdI84D+Ajef3nALha39qJahe8cxhUT
         Tky4skdXTfsJq/Vljm7wdYcf8XybYE86/411dkFCmx8+Efj46AROrtBtQhqWF4Mkz40f
         xuPXCTNWV5pSvOpf+Eh4HR2R7rccsvwm816sqagAJA7fl6DFl8yZZgsrw4bojTpTkN35
         LGSQ==
X-Gm-Message-State: AOJu0YyaftPBndF/PulIOF7XTKmc2OWiZ1MtiGD5O7VLA23tz9KAkbx/
	PRpmOPbAD5L+W0Rs5pSzqovZBOW3WUT6Q8tR42INjOSBVxbEIdZXTOE+KOFJrLMM1zqPLfO/BAI
	DP7RG0PtqfHeOFJjmHSb8lFrLdbL+Y7brQP8=
X-Google-Smtp-Source: AGHT+IETZsNcQLEiGMVNE2umkQgxWOthND/H0AIzlBUc7HWf8ZPHF9+8pNML96Cdgzt7I0LUTum2pXtsAqjxjKjUKD8=
X-Received: by 2002:a92:d84d:0:b0:363:7985:eee3 with SMTP id
 h13-20020a92d84d000000b003637985eee3mr99618ilq.24.1706658905012; Tue, 30 Jan
 2024 15:55:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <ZbiwW5BJhFeGc2Bd@google.com>
In-Reply-To: <ZbiwW5BJhFeGc2Bd@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jan 2024 15:54:54 -0800
Message-ID: <CAKEwX=OGkHmRVGLF6sAcj0CtQjL=tMpqu8qktAdLLwn24Q5Pgw@mail.gmail.com>
Subject: Re: [PATCH 00/20] mm: zswap: cleanups
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 12:16=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> Hey Johannes,
>
> On Mon, Jan 29, 2024 at 08:36:36PM -0500, Johannes Weiner wrote:
> > Cleanups and maintenance items that accumulated while reviewing zswap
> > patches. Based on akpm/mm-unstable + the UAF fix I sent just now.
>
> Patches 1 to 9 LGTM, thanks for the great cleanups!
>
> I am less excited about patches 10 to 20 though. Don't get me wrong, I
> am all of logically ordering the code. However, it feels like in this
> case, we will introduce unnecessary layers in the git history in a lot
> of places where I find myself checking the history regularly.
> Personally, I tend to jump around the file using vim search or using a
> cscope extension to find references/definitions, so I don't feel a need
> for such reordering.
>
> I am not objecting to it, but I just find it less appealing that the
> rest of the series.

As a frequent user of git blame, I kinda agree with it.

That said, zswap functions ordering hurts my brain a lot. So I vote
for the reordering, and for paying the price sooner rather than later.
The alternative is reordering sometimes in the future (which is just
delaying the pain), or never re-order at all (which sucks).

>
> >
> >  mm/zswap.c | 1961 +++++++++++++++++++++++++++++-----------------------=
------
> >  1 file changed, 971 insertions(+), 990 deletions(-)
> >

