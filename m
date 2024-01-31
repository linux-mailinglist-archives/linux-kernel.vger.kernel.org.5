Return-Path: <linux-kernel+bounces-45610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5B8432FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212A61C25907
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F763B8;
	Wed, 31 Jan 2024 01:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEA6xl2P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0A4C6F;
	Wed, 31 Jan 2024 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665759; cv=none; b=r3w/9889qpyX85BIjJ/ckkWalyCCiqkqGAVbOOWnNMx/EmuJf+qldol8a5Xbj7lGvQdha7aYgJQeTWeLc2dQBjhHsH8d7qDwhSs4RXVuOV7GU+CvV1hUSjJzh5S55L/xfTMarDkv+Scf9CBBoyaQotzPezfvrj05M9F37IXg20c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665759; c=relaxed/simple;
	bh=OiYv3On7yu88BBgxRxAAeYrIOf05OpfHEFuw9vndegM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxYTF96bmvn18pv8HwbMHcQE8oaDse/SvpBxeN1HnBwvGw2fYfp6f6nIQc4ecYItnIkcre2DYFqH/QevxZ+5u3ccorswuNMxCaoJD3uokoEwr/ZsgNHC/BRCXucnMxvFlCBbEEKkhzsKOoFHS/+1dQK2vyzqE0kE/W/yYp2OKX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEA6xl2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E43C43394;
	Wed, 31 Jan 2024 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706665758;
	bh=OiYv3On7yu88BBgxRxAAeYrIOf05OpfHEFuw9vndegM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iEA6xl2PnIIlpuw8QfpVTRon0X5gwefCfa8AEzfKcuSn/3qNFqMRbUxcW2EBhzi4H
	 cyA6C0CPShEgXuCnb96WbeV7vyjLoJqZsOXn9Bn3CQnxAfto8yNSx3NoXWV69rPHgD
	 gnKXgc+SZQ86tHcfrCn9ykqcaiuNYCRzGtdQ1B9bkMtp/X8J6FrKqakQc/BkrupU0r
	 tlKXWZXspR1Bq9XbIjccSU01DqiAtb5wdhL9d0JjfZh2VnGIyuMJ28dSUrWDaCN9SV
	 jvkB0T40viZ0Oxq65uALy+UAwfTtWUkQHPXrBb0xH21qee6gCbDmX5jncSlrDSycEh
	 b5Ny+c4hZlx/g==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-20503dc09adso3091298fac.2;
        Tue, 30 Jan 2024 17:49:18 -0800 (PST)
X-Gm-Message-State: AOJu0YxIgBuhhqkmAxU+07Yw81OZCigT0T6QVLlKBvh4LG8NK1a3O+T4
	MunX5tGb4NQNgE6hIfd2KiyoyO80pIhq+waHpWbyaq+GIP/j/qvaN0lAlejIq3Y2LsGH/Phu4J6
	anHxyMRAQKYAq3unsXtWJ1Q6QLPQ=
X-Google-Smtp-Source: AGHT+IFwvJciBWAf8OLEoVPFOvkG6OiHeqt3VCmVBqCCwH5l8In8IYspitAp1nikFxF8+s9FJW1jLVcoiSvNv2eouLY=
X-Received: by 2002:a05:6871:7a11:b0:210:d74e:9d0d with SMTP id
 pc17-20020a0568717a1100b00210d74e9d0dmr473202oac.57.1706665757880; Tue, 30
 Jan 2024 17:49:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAR2xDjbn+BZqUrgbDxPJUyQBULFB51kTiN8Nc78DXVyEw@mail.gmail.com>
 <20240129092819.10088-1-jtornosm@redhat.com>
In-Reply-To: <20240129092819.10088-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 31 Jan 2024 10:48:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2gA_B_SR87GdSL1itToM3nJi2iBiwBkrnk5zGwcfifA@mail.gmail.com>
Message-ID: <CAK7LNAT2gA_B_SR87GdSL1itToM3nJi2iBiwBkrnk5zGwcfifA@mail.gmail.com>
Subject: Re: [PATCH v7] rpm-pkg: simplify installkernel %post
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 6:28=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> The new installkernel application that is now included in systemd-udev
> package allows installation although destination files are already presen=
t
> in the boot directory of the kernel package, but is failing with the
> implemented workaround for the old installkernel application from grubby
> package.
>
> For the new installkernel application, as Davide says:
> <<The %post currently does a shuffling dance before calling installkernel=
.
> This isn't actually necessary afaict, and the current implementation
> ends up triggering downstream issues such as
> https://github.com/systemd/systemd/issues/29568
> This commit simplifies the logic to remove the shuffling. For reference,
> the original logic was added in commit 3c9c7a14b627("rpm-pkg: add %post
> section to create initramfs and grub hooks").>>
>
> But we need to keep the old behavior as well, because the old installkern=
el
> application from grubby package, does not allow this simplification and
> we need to be backward compatible to avoid issues with the different
> packages.
>
> Mimic Fedora shipping process and store vmlinuz, config amd System.map
> in the module directory instead of the boot directory. In this way, we wi=
ll
> avoid the commented problem for all the cases, because the new destinatio=
n
> files are not going to exist in the boot directory of the kernel package.
>
> Replace installkernel tool with kernel-install tool, because the latter i=
s
> more complete.
>
> Besides, after installkernel tool execution, check to complete if the
> correct package files vmlinuz, System.map and config files are present
> in /boot directory, and if necessary, copy manually for install operation=
.
> In this way, take into account if  files were not previously copied from
> /usr/lib/kernel/install.d/* scripts and if the suitable files for the
> requested package are present (it could be others if the rpm files were
> replace with a new pacakge with the same release and a different build).
>
> Tested with Fedora 38, Fedora 39, RHEL 9, Oracle Linux 9.3,
> openSUSE Tumbleweed and openMandrive ROME, using dnf/zypper and rpm tools=
.
>
> cc: stable@vger.kernel.org
> Co-Developed-by: Davide Cavalca <dcavalca@meta.com>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Complete to be backward compatible with the previous installkernel
> application.
> V2 -> V3:
> - Follow the suggestions from Masahiro Yamada and change the installation
> destination to avoid problems instead of checking the package.
> V3 -> V4:
> - Make the patch applicable to linux-kbuild/for-next (ia64 support was
> already removed).
> V4 -> V5:
> - Complete for other Linux distributions.
> V5 -> V6
> - Simplify and do more compatible checks when copied files wants to be
>   replaced.
> - Remove %preun because it will be better done with another patch.
> - Add indentation and quotation.
> V6 -> V7
> - Simplify check to copy (cpm --silent return error if file doesn't exist=
).
> - Limit indientation to modifications.


Applied to linux-kbuild/fixes. Thanks.


--=20
Best Regards
Masahiro Yamada

