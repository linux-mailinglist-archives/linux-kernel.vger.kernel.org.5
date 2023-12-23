Return-Path: <linux-kernel+bounces-10457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99281D49F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04F11F2253E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9FEA52;
	Sat, 23 Dec 2023 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvcwpWiF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F1FBE8;
	Sat, 23 Dec 2023 14:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EA3C433CA;
	Sat, 23 Dec 2023 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703342005;
	bh=CXeSf3J57otm3DHuod73QJLKsmQKMwMyPPyKjpcDrA8=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=kvcwpWiFD/gI2NjBq8Ie41V0rficKoEo/xgIOPEaPp/hvdeNAfUKw1S5E+NAYgxNK
	 vrkmp74kR7MOTbK6NXK2w5yVoXNZTd/deimhxqIIEcwVfCaELAcZzuqhi9t1f9ynEc
	 tH6+Inpqxr9bYRTqocA7JvlfQuOqZhfJ8tDzsLy/gd9fHTeK/tYKtsSVJgFuTzSI/s
	 IAvfPzBYBZ7ITcaAf+dzi/ZTVLNdbfYQSWqtsoMC8KdR7z/2elw7QpAjaEUW0nE0W5
	 NdnNu/05wDllwPUxjj5MNSPeTkS/Zto0XLqjTavxTlZO+OHi+PKWiRVkjtPxeGHGF1
	 Sa/cN0EuJ2B9Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-204235d0913so1584815fac.1;
        Sat, 23 Dec 2023 06:33:25 -0800 (PST)
X-Gm-Message-State: AOJu0YwlfzipPUrOMP88BFxu/8m3gkQ1aq7NJsFCP6bOOF1uhpLBWdUx
	NWnamZiATt3EnpQfkcj2J64WWkATyRGrEkv9/U4=
X-Google-Smtp-Source: AGHT+IGEsoeOUouEGfY0Cgdj/+b3UrEBzgggPnlbJispkarEMGAmI7RR+ykGQVrakZK030hpfBPCswYdihh+e9nCq1Q=
X-Received: by 2002:a05:6871:5221:b0:203:caf4:f0d0 with SMTP id
 ht33-20020a056871522100b00203caf4f0d0mr3894124oac.52.1703342005089; Sat, 23
 Dec 2023 06:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219154049.1095323-1-masahiroy@kernel.org> <ZYWGgOgGpMwqqes9@buildd.core.avm.de>
In-Reply-To: <ZYWGgOgGpMwqqes9@buildd.core.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 23 Dec 2023 23:32:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGFJvKj7-6mRzwY+DYUuACHJ0Ljo2-f51Hxu2eP=LdeA@mail.gmail.com>
Message-ID: <CAK7LNATGFJvKj7-6mRzwY+DYUuACHJ0Ljo2-f51Hxu2eP=LdeA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: split debian/copyright
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, 
	Ben Hutchings <ben@decadent.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 9:52=E2=80=AFPM Nicolas Schier <n.schier@avm.de> wr=
ote:
>
> On Wed, Dec 20, 2023 at 12:40:49AM +0900, Masahiro Yamada wrote:
> > Copy debian/copyright instead of generating it by the 'cat' command.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> > Subject: Re: [PATCH] kbuild: deb-pkg: split debian/copyright
>
> With 'split' in the patch summary I had expected something different;
> but cp instead of cat seems quite reasonable.


For clarification, I will reword the subject to

"kbuild: deb-pkg: split debian/copyright from the mkdebian script"


Thanks.







--=20
Best Regards
Masahiro Yamada

