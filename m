Return-Path: <linux-kernel+bounces-106464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A90787EEFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D00281EF3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BD5A785;
	Mon, 18 Mar 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPqQq6P9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99356470;
	Mon, 18 Mar 2024 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783237; cv=none; b=qPfSygKMCYJLETOsZQbYasTp3SIXOcGs/PGf0VUX7qhgqpC4ulSaLJ/YeYLuOb6+Y+OENQaAxr3x7ZEA0QgWO78Qq+XgK8+zYqeqUDEy8H7SwEeCFj3PwOD3DokThCaaNdrWdXhynPjhMqfOMMPGTImr8tgwbamJFiJ+bm5/pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783237; c=relaxed/simple;
	bh=qXEfVoNPEmSPkbQ//RBEx2k6HLSnNGGkPn5kbQVBBqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1Ty5YNPd6hZFWpjsEfBlpTajV0hiT+mDupwf5sI7BOnEmD7QLSbqbrlbTcbvwWgmiHXxwKsa4cRx+Cq3mIbPzOaV4TxOX7qjewAZxW8Q1hlncc8rm3eGuFvy6cK4vPYp3GkEE81s+UlzJTDRrwVzQX6Y6Eb+OxbfHJ9GFKlhNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPqQq6P9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9371BC433F1;
	Mon, 18 Mar 2024 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710783236;
	bh=qXEfVoNPEmSPkbQ//RBEx2k6HLSnNGGkPn5kbQVBBqU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mPqQq6P9QDMb6xni6eZgg8K5ypJ6LS75uphp0NGEvV0R9VifF+CDEE3WtlRZrvTAj
	 xrJf8odti7hYQXC7EiBwxs48p8esxZXmDQtloqdLA8BsJnWaSZtvsRKcO9vG9r312M
	 FGUezZ0L99eZYbt+f3TG6M6fJyly0y0XKypMN9Hy0XHx0/TNexJBuG64PLgObN3ycH
	 IfajfwsHgFrXAvYQoRHyy0u+36tRNoV2QyHzzPTNrP2KRXMNBYEemrcS5yBt2uNsUF
	 SOJXortJNRftWuHv5ejfo2zSrz7Xgm2UIOKw1c6UfGhKjgUFrv5CBuiiO7wXX6q6A+
	 tvIhwOvVxalXw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso62411701fa.1;
        Mon, 18 Mar 2024 10:33:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/t3WdRMsO683iAQ/PcidSecPO5QRAjXMRvyo6tssATIGc/FNtCNZeEahdRkMvwKcHCJg9tmcJTamkFhZ27U3SpNP2Sa0nyzxnhcJb
X-Gm-Message-State: AOJu0Ywy0IqOLwWHpD5NYuDZvDcPQUEDHOG4Eeb66bMp9rZKYYFBWmb9
	ykj7Unt9/KfFf6ISva57M2jDsWNdBI3kupdpmCQYhK9l5K0Nyz/Esvz9QonZVXqoEMsZCo848V4
	vKAVrGJQKq0O1f154qPpercdlieI=
X-Google-Smtp-Source: AGHT+IFnRKZkLESYK4kF7VEHuFz4Q39wy/VDYD6Xrqmnc4lSwoSW9zQz+dkLS/DiSKR/1PdVFUg8yPR+yp6PZwggpvo=
X-Received: by 2002:a05:651c:c6:b0:2d4:2b05:a671 with SMTP id
 6-20020a05651c00c600b002d42b05a671mr7088206ljr.32.1710783235330; Mon, 18 Mar
 2024 10:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNAQ6_kr0Q1RB0dELiGUObFJ4HEEu3XTErGf6FaNntKMnTg@mail.gmail.com>
 <20240311162238.1761147-1-jtornosm@redhat.com>
In-Reply-To: <20240311162238.1761147-1-jtornosm@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 19 Mar 2024 02:33:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNARRBkwo1DqpgYd1HkYxg9aFDYv9e_Z8WmBjVidAJ7SuiQ@mail.gmail.com>
Message-ID: <CAK7LNARRBkwo1DqpgYd1HkYxg9aFDYv9e_Z8WmBjVidAJ7SuiQ@mail.gmail.com>
Subject: Re: [PATCH V2] kbuild: rpm-pkg: add dtb files in kernel rpm
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, nicolas@fjasle.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 1:22=E2=80=AFAM Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Some architectures, like aarch64 ones, need a dtb file to configure the
> hardware. The default dtb file can be preloaded from u-boot, but the fina=
l
> and/or more complete dtb file needs to be able to be loaded later from
> rootfs.
>
> Add the possible dtb files to the kernel rpm and mimic Fedora shipping
> process, storing the dtb files in the module directory. These dtb files
> will be copied to /boot directory by the install scripts, but add fallbac=
k
> just in case, checking if the content in /boot directory is correct.
>
> Mark the files installed to /boot as %ghost to make sure they will be
> removed when the package is uninstalled.
>
> Tested with Fedora Rawhide (x86_64 and aarch64) with dnf and rpm tools.
> In addition, fallback was also tested after modifying the install scripts=
.
>
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> V1 -> V2:
> - Follow the suggestions from Masahiro Yamada to improve the checks and
> avoid the loop to ghost the dtb files in /boot folder.


Applied to linux-kbuild.
Thanks.






--=20
Best Regards
Masahiro Yamada

