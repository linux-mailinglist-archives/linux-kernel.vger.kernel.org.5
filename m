Return-Path: <linux-kernel+bounces-146124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E23FD8A6106
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 04:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FADF1C2105F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 02:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AF10A16;
	Tue, 16 Apr 2024 02:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX9jc1Cy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F74E545;
	Tue, 16 Apr 2024 02:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713234438; cv=none; b=o+P/CpJM6otnCwa5LNTctMa+eJgmMjkQ2zTzmPrEdtrCF4kJpcRMwzyGmaEnJ5ZajulFZgKHrzrmYN01oLzmZOqZXZQ9yxVzTz8aNaLePYE5QBR5q5Pjn1ySJG4mRFGqTA1lWQqsth1g5fimhJ4dq+KpwtbzD2kdeevh30ueJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713234438; c=relaxed/simple;
	bh=pmLftJlGu8NQ398v4iEjYmaMThxHaBsa77xQ1OOrWNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBHJF9Ak7l1E9rXo6fhhoGn1L+ky6wUyxqdGAu9T1Ie6x80TBtkz69f7OuDkLZHDc4rAK+NLbOrgP3KiGYWKhoQi43xj3loDbxAJprje4uM7YEX7QTzVe4I6wy8+DEYv/Y/K6jbpmhENFhrCLnnH7SCixMHy52+Z8099ufIY0IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX9jc1Cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DCDC2BD11;
	Tue, 16 Apr 2024 02:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713234437;
	bh=pmLftJlGu8NQ398v4iEjYmaMThxHaBsa77xQ1OOrWNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PX9jc1CyPOfa4vfPRYuhXQrGzGkShPuOtrD+Zn+lPhLU1aNeSYvhamZFAz7YLpkJp
	 K0WwtDofsDfMXdltijRTWq9DyIoNTjtpeW04DEw/soUxBz1L3go9KlEPviH66+/c9T
	 /gdkFfjwXvxyruC7NFRmwpufG6p2Xrd/9+nfJYlnqm3fNQYFMgp/NJMk5ODQ70tMji
	 Wfcz2ZZS/pStBZaG8wMMg8DO/R/mVMzT2e7QZHO2NlVgzy6415kIje5o5ne4deJFNc
	 Rhi+TCYn8Ed64w55xZaALASlWRE7U/ydyiRFTAWHnrdOMytfp/XIQvEWpDDDtKgrQx
	 Yfun7hg0KaEMQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2da01cb187cso69570721fa.0;
        Mon, 15 Apr 2024 19:27:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgf9IB0BgAfKsM96pAgsHc2pV+ObHq2OYSBaIZaAM/R5ezsYnfy3+v7JsaH/z4eq81kGmb/fDueN693emWfwVCgt88LIcQZo0oK+aKUP7rS2IjM0XLIFjN5UZNdFSdxe49t2cUWZwPnwQ3
X-Gm-Message-State: AOJu0YwfYdb/pH0iWTdnJW+2cCNDOfd+KC7EHhrIOGwwXMb83iAglrxo
	qwoC5eza0v3n/rlBh5KfRlhhqbICeuL1g8MniYdY5JOgtw2gxr32CES9WzfA1mK8Be9SHP34Mud
	FB4o5yZ+SBWWa0EnIGxzAwmhWajc=
X-Google-Smtp-Source: AGHT+IHpZ8FAVtZZ0v4ayvNRiHFVWg6QR/3OXAWLAuyYXPPApbgvMEghHtNsb0OD1+JuNTsHIuMgTwZehjcnblMMpz0=
X-Received: by 2002:a2e:9c13:0:b0:2d7:1e2b:6284 with SMTP id
 s19-20020a2e9c13000000b002d71e2b6284mr8273532lji.27.1713234436381; Mon, 15
 Apr 2024 19:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330100849.426874-1-masahiroy@kernel.org> <c29a12d1-840c-4fe9-b03c-200182be0191@gmx.de>
In-Reply-To: <c29a12d1-840c-4fe9-b03c-200182be0191@gmx.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 16 Apr 2024 11:26:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgmvb098A2cjkXfS4QaHEj2tjWk8-i-sysLavkjFbHMw@mail.gmail.com>
Message-ID: <CAK7LNASgmvb098A2cjkXfS4QaHEj2tjWk8-i-sysLavkjFbHMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] parisc: vdso: remove dead code in vdso32/Makefile
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 7:46=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> On 3/30/24 11:08, Masahiro Yamada wrote:
> > This commit removes the unused build rule because 'obj-cvdso32' is
> > not defined.
> >
> > If you add a C file into arch/parisc/kernel/vdso32/ in the future,
> > you can revert this change. The kernel does not keep code that
> > may or may not be used.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Helge Deller <deller@gmx.de>
>
> Thank you for those cleanups, Masahiro!
>
> Shall I take your patches via parisc git tree, or will you take
> them via your git trees?
>
> Helge


Thanks, I applied this to my tree now.

(I need this as a prerequisite for my Kbuild work)



--=20
Best Regards
Masahiro Yamada

