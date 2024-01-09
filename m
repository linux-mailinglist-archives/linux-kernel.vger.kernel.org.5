Return-Path: <linux-kernel+bounces-21012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D4D828872
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2271C245CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFBF39ADB;
	Tue,  9 Jan 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTnmaj97"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5BE3A1A0;
	Tue,  9 Jan 2024 14:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCE3C43390;
	Tue,  9 Jan 2024 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704811646;
	bh=G9fzViUgHdIs1o8LOB4p+I9kaJ6zP5yZvjApZIL6h+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jTnmaj977X4vPBvb/smaeyLBNY9brm6/6hg6P8Vl/0jS+79Ot7Ee34u0rPGj9lxQO
	 0qhif2z5EiEwEqk5pM4lMZa29Ly4mXkHh+7C7ieuT9+IIWGahOmCpFbYwlx4N8lxSq
	 p6Gi4E7eb3s0pRHQ6WlAhKN+FdO0cYAB/uvxmN6+xKMvvbaaS3PGT/wXraX5OtfyaD
	 nA9T5kXb1/I/oOsv0Oq3B5Iqx/KpqWSkvEq1PzhpSl1p09oQRU4KK6sW0rWCBNv6eQ
	 Siv+7KIdbZmxlguq0ryphzltASxAwIIP/A4MUmc1wJS5fkrhdsFxy+R1qG1SeqesN6
	 3flrV5CMm3b4g==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bbd6e377ceso2803908b6e.1;
        Tue, 09 Jan 2024 06:47:25 -0800 (PST)
X-Gm-Message-State: AOJu0YzP1pGypxHzkcNoLigOE6HF8OMhkTQzQm9r+3As7xUdjqU9s6qn
	d3On2IvaPel6yxe24gV7unFMjGk90gIXFehN1yk=
X-Google-Smtp-Source: AGHT+IF9m5RmsRnW0v2Mh8Qj2lgLc5QR/54i4jeGa1XF62g1eD0H+47aBPS99z5ljL4fpTLnz+VGtf6DzYA1wNyE6cU=
X-Received: by 2002:a05:6870:e60b:b0:203:c5ca:5333 with SMTP id
 q11-20020a056870e60b00b00203c5ca5333mr7012794oag.41.1704811645380; Tue, 09
 Jan 2024 06:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <20231230135200.1058873-2-masahiroy@kernel.org> <ZZ1UxkCgKQ9J6Iut@reykjavik.ads.avm.de>
In-Reply-To: <ZZ1UxkCgKQ9J6Iut@reykjavik.ads.avm.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 9 Jan 2024 23:46:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATdFdLfw4Xg9C29_X1iEun4kmgccFbW=Nvqkk2LFzewsA@mail.gmail.com>
Message-ID: <CAK7LNATdFdLfw4Xg9C29_X1iEun4kmgccFbW=Nvqkk2LFzewsA@mail.gmail.com>
Subject: Re: [PATCH 2/5] kbuild: deb-pkg: make debian/rules quiet by default
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:14=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Sat, Dec 30, 2023 at 10:51:57PM +0900, Masahiro Yamada wrote:
> > Add $(Q) to commands in debian/rules to make them quiet when the packag=
e
> > built is initiated by 'make deb-pkg'.
> >
> > While the commands in debian/rules are not hidden when you directly wor=
k
> > with the debianized tree, you can set 'terse' to DEB_BUILD_OPTIONS to
> > silence them.
>
> Reading Debian Policy =C2=A74.9 [1] I'd expected some fiddling with V=3D1=
 or
> 'make -s', but I am ok with the simple '@' silencing (which matches my
> personal preference).


Hmm, you are right.


Maybe, we should follow what the Debian kernel does.

Debian kernel sets KBUILD_VERBOSE=3D1 unless
'terse' is given.


https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.7-1_exp1/debian/=
rules.real#L36




>
> Reviewed-by: Nicolas Schier <n.schier@avm.de>



--=20
Best Regards
Masahiro Yamada

