Return-Path: <linux-kernel+bounces-41271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4882583EE45
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC40F1F229B8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067A2C18F;
	Sat, 27 Jan 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSwE3j78"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFF2C688;
	Sat, 27 Jan 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706372043; cv=none; b=H1uqr5e19TVZo/oFucLy4YCY5gU13pg7NZMigKtWoN5N8sXX/rcuGztQWtnQAgxpg4RKxEVz2m7IvhkkHCmqwyYtWknipRP+Pw43VpJ9RCaZ2VbXW9EE3PRFNA8UkiVWOg/mmqU/l2/YaKT6O1Pkeyxf+jH0xse9rZ+AvPaKTac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706372043; c=relaxed/simple;
	bh=6ziY9jQMfqufdbKh2W2AGmsExJ51u8/fcDot5GH2okU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IKQAWvzQgK6KeGepQ2xcqyP0g2Q+NpAtCYm2ksCcq8VHt9KvzmRfTKX51xdX+o9ifLhdlYWxdcHCGsi4dPhPq+hs87OfzcJUzJJhbSMda2pba6s1V1ugjqs96NpY244U8rnhLi9x5kXoLTpu2EH7UF5YXrQiPeX51opsDhe+LeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSwE3j78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04713C433B1;
	Sat, 27 Jan 2024 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706372043;
	bh=6ziY9jQMfqufdbKh2W2AGmsExJ51u8/fcDot5GH2okU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZSwE3j78MbEKWoAXjTZS30fj/qrI7C9jxG6m2hhEk+MpKDlzcOAsS0HTpoNviWOKA
	 Ncpt9O180nqYcFNWrVOOQOeBd9JMt3ooO1j5qyIhjhMBMSK9DVrZKVEayYPkVvnFlF
	 68Wm1QXj3wulg1e3xJeHAxSzerChf3dvRSKrMcOoZhEzRUNxcGdlCCjK0q+kvzSuCR
	 UH863y8IjpIjZsUrc/Vk7d0p//qGQHr/R+I/8p7cZ16iCubaDnT7SNsniQY9Cmy5/o
	 WtfXlRh84rdy6LeLgJgCj2Fn8g99dMITraAX5/u/hYtULtZxd62m82PFvfEtBQXnb0
	 Zh+D/ajEgS3GQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-204235d0913so730299fac.1;
        Sat, 27 Jan 2024 08:14:02 -0800 (PST)
X-Gm-Message-State: AOJu0YwgKG3VgnDmq9N9tb6OR/d65zdlrTRQZg7YapqaTQozIXVEZsGv
	Fee4LRaUrs8nc9D7nwY35J8xeNugq8+JiGj66hl3U+LSq7DqtzMJAzej4Q7wmUepHdmnFQPTlyv
	+hxko+91xX3UqXPhhwpUo6odku1E=
X-Google-Smtp-Source: AGHT+IGKTq0KLCvg72zZJLNv1Q53TeMAI4fP+JAU6Pew04ViELeYGInFZ1tMsStrFNscsbm8SFl0gkejdO5PAlS6v+o=
X-Received: by 2002:a05:6870:a927:b0:214:940e:9936 with SMTP id
 eq39-20020a056870a92700b00214940e9936mr1100581oab.17.1706372042376; Sat, 27
 Jan 2024 08:14:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113001135.7781-1-xtex@envs.net> <20240114081400.12452-1-xtex@envs.net>
 <20240114081400.12452-2-xtex@envs.net> <CAK7LNATObt70_dp0oFG_kUW6n6tC+jwodWyBMd0TQ3F2oidLQw@mail.gmail.com>
In-Reply-To: <CAK7LNATObt70_dp0oFG_kUW6n6tC+jwodWyBMd0TQ3F2oidLQw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 28 Jan 2024 01:13:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_WVrFtLA+gEm2DgR33TgVmjBck0HMavkNca2LRU50yA@mail.gmail.com>
Message-ID: <CAK7LNAQ_WVrFtLA+gEm2DgR33TgVmjBck0HMavkNca2LRU50yA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: defconf: use SRCARCH to find merged configs
To: Zhang Bingwu <xtex@envs.net>
Cc: Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhang Bingwu <xtexchooser@duck.com>, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 8:28=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sun, Jan 14, 2024 at 5:14=E2=80=AFPM Zhang Bingwu <xtex@envs.net> wrot=
e:
> >
> > From: Zhang Bingwu <xtexchooser@duck.com>
> >
> > For some ARCH values, SRCARCH, which should be used for finding arch/
> > subdirectory, is different from ARCH.
> >
> > Signed-off-by: Zhang Bingwu <xtexchooser@duck.com>
>
>
>
> As you can see in "git log scripts/Makefile.defconf",
> I was not involved in anything about this file.
>
> I do not see much interest in this patch set, but
> Arnd Bergmann might be excited about it.
>
> (You did not accompany with a real use case though)




Having said that, 1/2 is a bug fix.

I applied this to linux-kbuild/fixes. Thanks.




--=20
Best Regards
Masahiro Yamada

