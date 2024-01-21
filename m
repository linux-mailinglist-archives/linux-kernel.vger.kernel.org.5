Return-Path: <linux-kernel+bounces-32141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D401183571F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 18:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138551C20D04
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26411381CB;
	Sun, 21 Jan 2024 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF0aQ3+O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF237713;
	Sun, 21 Jan 2024 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705858470; cv=none; b=QqlKE5NNnX5naxSS8vNuSg3wZNm1GuVMwTOT9jXTV/g9eUeTgKKDONPPFJFyEfSVigIx4I48JrFbBkVSi7tNqur2EjHLwd7veGtLRH8K/ae2FvIQUew6+1A/p8BodEsH95QaJeGey497UuJ3vfd6stTkwD+3BOOt1yRaxLuXWak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705858470; c=relaxed/simple;
	bh=OD8Ruv5Z6/0dUrzR7pwmB6jzMRqOWFs8d2TNmfSltsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d9FSx1wwwJN66J6YlYqwKw2Ej/lsgvNb0k1zaSrvlnZdPI2aVAxSdYnGvPIYf1WK5s777rR+9d8hW6XCss57wdtTTx5nB3hhzWt/g+8bQ0MKw5Vw7o0Oqqi/9klobSO2eOx+s8toli77Z86ylNcwi6I5GqyaXCbiVNKGmG/Wc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF0aQ3+O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B7CC433A6;
	Sun, 21 Jan 2024 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705858470;
	bh=OD8Ruv5Z6/0dUrzR7pwmB6jzMRqOWFs8d2TNmfSltsI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nF0aQ3+O6diulmjit0YiMdoN31lohxZwj1sUzQEqfPc/9MKsckJUPKtyxQBawWPks
	 qUFBT68qRJzq4WJ257Gj8fdqvEJ9pKfUrtcfbDcIselG7gdAM4QWdqe9MqiGwMY8hg
	 pa9fOgHTk3/BbMRRB7OIm5KJtjlS01o8monAaZeHOJCvM+58A1EE1GzKwzkQoSHK8L
	 TufX9IX9mnFjZbznoqadjo25nNjTdYb4N5e4PYpSf4FzU64FukRkQG9AzTpm4FWX3w
	 Idn7Mqap1yVSbU5YU4g0+DkevLsSy2rWk1M9i8mzDg9UB7Sn82z+Da5B1eobxxerLS
	 3r9sqz0XdkV0A==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-204f50f305cso1616388fac.3;
        Sun, 21 Jan 2024 09:34:30 -0800 (PST)
X-Gm-Message-State: AOJu0YywVynnpyqbCGURwdTspb6eaobAxhonNQaYQf/kN7KatMih+0Ar
	uJB2hM1j50hgRV2RGzAiFJFbbVppQ0lXbHh0CIxL7HcnvPCq0z3tZIjnefRzsSkUYlqHAkhX90v
	z4zgy+oenvk79DQgaHvldfxYsGYo=
X-Google-Smtp-Source: AGHT+IEe5FN0kCJ+KSTjldgTQXwg9lRW/yroKqxzuTLy2ozixhvtGENiHHEFHjAWbIJ33l20r+1vbkJy6OexELuWrTM=
X-Received: by 2002:a05:6870:b489:b0:203:f3b8:411f with SMTP id
 y9-20020a056870b48900b00203f3b8411fmr2826580oap.20.1705858469601; Sun, 21 Jan
 2024 09:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNARX==sMKVTGXutGMmMkfg1idGUYLhBLZvKZ0psdwmiUvQ@mail.gmail.com>
 <20240118141246.370272-1-jtornosm@redhat.com>
In-Reply-To: <20240118141246.370272-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 22 Jan 2024 02:33:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNgp_oYWf69tw4+y0SMp=Hi2rixAt5h8R5=GaMkQLQYA@mail.gmail.com>
Message-ID: <CAK7LNARNgp_oYWf69tw4+y0SMp=Hi2rixAt5h8R5=GaMkQLQYA@mail.gmail.com>
Subject: Re: [PATCH V5 2/2] rpm-pkg: avoid install/remove the running kernel
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: dcavalca@meta.com, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 11:12=E2=80=AFPM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> > What is the problem with this?
> In my opinion, it is risky to remove the kernel that is running, that is
> the reason why I am trying to protect this.
> If you try to remove or update (and the running kernel is removed), if th=
e
> kernel and modules are already preloaded in memory, it could not happen
> anything but some extra action could be necessary or automatically starte=
d,
> and even the new kernel could not boot.
> Fedora and others are taking this into account with upper tools and decla=
re
> the running kernel as protected avoinding this action. But others
> (i.e. openSUSE Tumbleweed) allow this behavior.



As I replied in 1/2, I see an error like this:


vagrant@opensuse-tumbleweed20231218:~> sudo rpm -i
kernel-6.7.0_12924_g660a5f4a53e7-4.x86_64.rpm
file /lib/modules/6.7.0-12924-g660a5f4a53e7/vmlinuz from install of
kernel-6.7.0_12924_g660a5f4a53e7-4.x86_64 conflicts with file from
package kernel-6.7.0_12924_g660a5f4a53e7-3.x86_64



You can proceed with 'rpm -i --force', but
that is the user's responsibility if something bad happens.







> It may only be a safety measure but it can also be beneficial to avoid
> problems, just in case.
> Besides, in this way, all the tested distributions would have the same
> behavior.
>
> If it is ok, I will create a following version patch describing the probl=
em
> better and using indentation as you suggested for the other patch.


No, not OK.





>
> Thanks
>
> Best regards
> Jos=C3=A9 Ignacio
>

--
Best Regards
Masahiro Yamada

