Return-Path: <linux-kernel+bounces-125907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D8F892E0C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 00:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF028282A59
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 23:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4084AEE0;
	Sat, 30 Mar 2024 23:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2V0UH20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02C2209F;
	Sat, 30 Mar 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711839845; cv=none; b=mt9Tj+MHJpRQHvhx0PU2pfraI/4QCFTWM79cei2kz4NW7wLukp1FKuogmsxYfVqCF50cueVDk/P1xnF3GSYl0MMwXKX2g/PD8g2SOO0T1WlvN+4IcA9QlhSe4DWzscksqozVQc0dlTaGlHS9gMD6KK7HUwD8WWiFkr0tlM2ep6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711839845; c=relaxed/simple;
	bh=W+lXDAUszoyOMZqfu30yCBMmZT/I9/hK9QyYre/7z38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZyU7aYl40U+ITTDK4HXpC7AwbENlsq7vAyN2na83zeUUJibzM1QSH6P1vR1IGJZStWNck/Pw4soz6hxwyAUB0aAXgaLc8KyHjStKbl3Mvf40Tb0QmYBJNbHAZkavkDK+FU5sdmmzLOOzGvqofTs9ZD6sp7N4L/9Jyf9eV3aolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2V0UH20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509CCC433C7;
	Sat, 30 Mar 2024 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711839845;
	bh=W+lXDAUszoyOMZqfu30yCBMmZT/I9/hK9QyYre/7z38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h2V0UH20f+Q2uS5n6JEAhKckjgV7uhFNTa5x+/kH0LgBh44SU/krbwlXI70KbegWG
	 SNmR6tI68tW6f0c42ZgfOh32R3kGntodhG1+ahO2ujFwiQP81GZwMlUf9FXmrssK7O
	 6Ea7eMaKgmNolDjg0fuDRhJnvJQA6gSw/ER6CCGRzxhYZtlvGb6RKRecfJnMaFpoos
	 vQV1n7Hhj3S08ZWtTZQxPeeFC0LH0HfzEoTSaYKCbTDI9jmEtrVLb0M+/4XeWodLDP
	 LUVQj55F6/DQUfpvUuS1mNZTrFLLyVEa7zJLJzC1l4djdj0hPtbd8l2felLocmP97B
	 /cfpFpqeBGCiA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d23114b19dso41800531fa.3;
        Sat, 30 Mar 2024 16:04:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdc4D3dZ0GvxZLMKHnna5DVDIUS54gh0tj9auCVoZvRD5XPwTYbqUAsf3MAfAyAzpvEm/xJ5xP18AW1G/HcIrOuYLC15RmQ8kVktYx
X-Gm-Message-State: AOJu0YzTCmh/MOa9+0lL7np8U2V+tbcNZ9Cih75U6R6Wo5cssD7A+BF6
	S/S/1dlFaegbfRccqa2FlAMV6e7n3vLLgMXX+s+RGxjZWyjw738+L74BiYPWkJBNTtT4GhCgEfH
	oT22xUdTgZ6KJdBJI7WOtMFPEZaY=
X-Google-Smtp-Source: AGHT+IFjNJB4zoGtwRlr5x40WVI1gdZMGC9MU8JMrl75Wwj636B+U+cRxHJT0p8X/Eg1DDwUBOkCFLOL5zeL9UoZmtI=
X-Received: by 2002:a2e:22c2:0:b0:2d4:6c1a:ee6f with SMTP id
 i185-20020a2e22c2000000b002d46c1aee6fmr3580757lji.35.1711839844071; Sat, 30
 Mar 2024 16:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330151945.95875-1-isak01@gmail.com>
In-Reply-To: <20240330151945.95875-1-isak01@gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 31 Mar 2024 08:03:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQzsm6LrqAj5kjZvdWA4tvDDnkeViMPqt_uU1RXcQ-tZw@mail.gmail.com>
Message-ID: <CAK7LNAQzsm6LrqAj5kjZvdWA4tvDDnkeViMPqt_uU1RXcQ-tZw@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Fix typo HEIGTH to HEIGHT
To: Isak Ellmer <isak01@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 31, 2024 at 12:20=E2=80=AFAM Isak Ellmer <isak01@gmail.com> wro=
te:
>
> Fixed a typo in some variables where height was misspelled as heigth.
>
> Signed-off-by: Isak Ellmer <isak01@gmail.com>
> ---


Applied to linux-kbuild/fixes.
Thanks.




--=20
Best Regards
Masahiro Yamada

