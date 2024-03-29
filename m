Return-Path: <linux-kernel+bounces-124375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5989166D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07AC1C2238A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0E7524C0;
	Fri, 29 Mar 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGsQ80ZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E0F3C082;
	Fri, 29 Mar 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706482; cv=none; b=BWV7miicVzruPdxI6biGdR6Mok5nKj66bgjl2qlQywFzUtfJmYmKEU8+vzcUmV5jxjNCAIiJcUktYOCUYbQ9kz32cxMXlfpUxUYGi7fPtVTvcTkjyz2PgUHBIkaUx5craQx/zo583UcnY8BayGHTbGwXnmQW5YkAtzbVQZkPHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706482; c=relaxed/simple;
	bh=wtkFSyk+K3WBxG1FeJmsvrusngXPw6by46g/7b7BKLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALEr4F48bVtHOOjCbjQNmvZ6kL6dimoN6cXSW7nfl32yfeRaVnUTmajAPpI1QqPLo8kgu9osmVIv1iwrwBkLej8EfBNqPa6VOtyNSRcdrEqytHGdIT1MKzI416hURwSUxXLy+NwvFFPTKsc0HNpgCGzMqjQvOqSaiIDe59CzbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGsQ80ZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C40BC43394;
	Fri, 29 Mar 2024 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711706482;
	bh=wtkFSyk+K3WBxG1FeJmsvrusngXPw6by46g/7b7BKLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pGsQ80ZZbtGykk+0fbrIAgYKNCBNgrkzmTnOeDZmQkrCBdnOAbtTrH9/h4NSdJqyz
	 BUM/Q1Nl/JMYidMRduLpOztT1IzhnSBqXjfivuWWcM4Yg7GBsbTOABvql3zHM+ZgOg
	 QPYtB1WmN+JyYJZUkPUFGuhTRBvgQrkQKZYM05RCxGzABiT6huIRKhTe/m6Gcv2/o/
	 Te2QOKMKTnMYcIZ6OpIhZYXIXoQvSkdzPA1SFrRaAo4YI7DP1OVuVfdNLi4jsbtc26
	 Xzjhkei05eubnx10JyYUVqPSYdJ/wUq7qQSKb67NSBDv5+uTSNCoFFj3bVKFKIosgY
	 bJe1Hw21TS3QA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-515a86daf09so2286417e87.3;
        Fri, 29 Mar 2024 03:01:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUQzDWW+HDTHKKVcZ++t1Zz/H+YDI6Wzit/T85gbNr+p04MFoHb6pyqZ3FzzS7vBHTHeKdPQ0ZBJLJ5l2kI70v4iYwgaRt94pO8CMmPuDchyLD5kfW2gxSkxHPa1vuG2A/Vuc33PChtXHnkVhrvireynIEcZUh2oDaK6gKqKxHvQIY/yQry0cLyJJdu09gQKTkMk6eLA1I+yHJQQBC+wc6K
X-Gm-Message-State: AOJu0Yzl1o0uA3JvjU7WwIdxKROhUBhwFn2kh3o/xobnpWaAD+pBRPrv
	fNrC7v7FOJ1PpuVTWhpS5u9Xnwsyg0ZSAH8Os9IlSX581+zZiLXUbkXL0tYtORVtHzEndVL6ON4
	0VfTMeVnZhJQDIhZYLQcqa5nJn2U=
X-Google-Smtp-Source: AGHT+IGwq8VV/L7M9VNMtYwfwPRGoYQfJ7HoQQfg1LXajsktZsxTgzQvygnKXtTF0R+0JRi3MpiO3uzFYVWULY1hCtg=
X-Received: by 2002:a19:c20e:0:b0:515:c00d:7766 with SMTP id
 l14-20020a19c20e000000b00515c00d7766mr1323587lfc.54.1711706480893; Fri, 29
 Mar 2024 03:01:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329032836.141899-1-sjg@chromium.org> <20240329032836.141899-3-sjg@chromium.org>
In-Reply-To: <20240329032836.141899-3-sjg@chromium.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 29 Mar 2024 19:00:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQWYvysMd8WjTj4+hh7ajL_1tV5rh1=BTgjc5OrMH6FiA@mail.gmail.com>
Message-ID: <CAK7LNAQWYvysMd8WjTj4+hh7ajL_1tV5rh1=BTgjc5OrMH6FiA@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] arm64: boot: Support Flat Image Tree
To: Simon Glass <sjg@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Ahmad Fatoum <a.fatoum@pengutronix.de>, Nicolas Schier <nicolas@fjasle.eu>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 12:29=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Add a script which produces a Flat Image Tree (FIT), a single file
> containing the built kernel and associated devicetree files.
> Compression defaults to gzip which gives a good balance of size and
> performance.
>
> The files compress from about 86MB to 24MB using this approach.
>
> The FIT can be used by bootloaders which support it, such as U-Boot
> and Linuxboot. It permits automatic selection of the correct
> devicetree, matching the compatible string of the running board with
> the closest compatible string in the FIT. There is no need for
> filenames or other workarounds.
>
> Add a 'make image.fit' build target for arm64, as well.
>
> The FIT can be examined using 'dumpimage -l'.
>
> This uses the 'dtbs-list' file but processes only .dtb files, ignoring
> the overlay .dtbo files.
>
> This features requires pylibfdt (use 'pip install libfdt'). It also
> requires compression utilities for the algorithm being used. Supported
> compression options are the same as the Image.xxx files. Use
> FIT_COMPRESSION to select an algorithm other than gzip.
>
> While FIT supports a ramdisk / initrd, no attempt is made to support
> this here, since it must be built separately from the Linux build.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v12:
> - Avoid showing FIT message if V=3D0


Acked-by: Masahiro Yamada <masahiroy@kernel.org>


--=20
Best Regards
Masahiro Yamada

