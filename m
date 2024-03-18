Return-Path: <linux-kernel+bounces-106452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB587EED6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A57F281AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A8955789;
	Mon, 18 Mar 2024 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlegEMS2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671B55766;
	Mon, 18 Mar 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783153; cv=none; b=g8mfckmaqktwJ+HlTENAyW9Bg04hF3uYAcASOnbU9fUWJw2gzlON7WEGIJDaPXlO7Fhd0GQSMqZm1sa0fpEriBWOnG3+sFVqW4tbKHGdj2KcUdx7n9Gix71Sxdhv5aI2uHg2sQj6B2RBAiFu+kn239eKDGnjMEszvk07JaVyoaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783153; c=relaxed/simple;
	bh=XVPhZ3PBupJhhGEX83rbBm7q0DsDbGUve7MHqKGgqbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooAYBOSg8p/MkfMkGUwfRtKI+vcxWj9iltwXLwk2BXGdzi8AQhfq/vHtVK/uRO6Iz8BCZiot3dsHoMWP9jX3qEI3OIx7DIXb4ggp3Du5do46DIk09LZBjTqqQTjglhiDNVaIWUxla/Xm51mkTeoeXvCthUWaYvuFdnWtUjp5pzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlegEMS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD17C43390;
	Mon, 18 Mar 2024 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710783153;
	bh=XVPhZ3PBupJhhGEX83rbBm7q0DsDbGUve7MHqKGgqbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QlegEMS2KlySZVRhAqJgjHk8OhX5yMNAWv/c/0VZwTU7q+XZFt0Zjbi4cV1777cZk
	 nBTd2LLkDL909RQhoCvNs1xCIxqMH5Q2b6eSK8VPmUmYsYL4P9f2dQ3Cze5mUg1SmN
	 wZ00sHMrR8aKFmlqRWef4M8oER9vD3rmME1/wVdSub5vRha/eNL9DIzuDTZ99okSIW
	 1H3nnmY0DcNvAWYWcb2OC0Dpia+DUPZIJeofq2rJA7y9CblqHdGpJsRwR7ri9FW7GP
	 GodJu5Cj2+fXeWy8q/WLv3D6ar6V5YqxMFCEGQYUbwHdKI9294Tx2tVy6RjsrEpU5f
	 7Xw5L6yHnJ8Tw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4698f4936so66682161fa.1;
        Mon, 18 Mar 2024 10:32:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkYANkC5DKFQ5aYDvKxUwMywnhnCU8bvHAsvYtiFkPmlILP3pevcKS5EHOCHUwvvelSj1CMY8n18xMe4KEejFXcQVkkGuXER6G5QSRwRXomKl7U8F7x3JRFuPXYNfA8abhGlZiQUIGQfZx
X-Gm-Message-State: AOJu0Yy4hXl865sVc6++Hc+K01/bB4TNuUTvD5aDmFFn78hkIQz4fMQv
	purzf8X5/E2H1Qu2c38yUb40CQ1feilJB/vcRop2QvncGF8ijMaAfPasQjBRLvnyLdlAY+DqwFW
	NSKiEAa2D/e2BiNW7euyVTZ1MpS0=
X-Google-Smtp-Source: AGHT+IE8OEjuiWEp34I61WW4MuLVhQZoBS06afGf0qEvLiajTJnLooMq0Itj+17w7tyyJSSAp1nwJGA58BNP4UYSL68=
X-Received: by 2002:a2e:b0f5:0:b0:2d4:a078:73c with SMTP id
 h21-20020a2eb0f5000000b002d4a078073cmr3207729ljl.16.1710783152015; Mon, 18
 Mar 2024 10:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215141321.899675-1-max.kellermann@ionos.com>
 <CAK7LNAT772pZEV09nEYTLOyU_og73zPkKjjL54e8yor-tnnHtw@mail.gmail.com> <CAKPOu+87bmXkh9uEMEjCOBQ5hjgMysWsyac9EHvQnPp5Pf5d3A@mail.gmail.com>
In-Reply-To: <CAKPOu+87bmXkh9uEMEjCOBQ5hjgMysWsyac9EHvQnPp5Pf5d3A@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 19 Mar 2024 02:31:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS6QAgvTOrozaGDBBHgWdhLktrNmFqc4wzRFhRReQXJqw@mail.gmail.com>
Message-ID: <CAK7LNAS6QAgvTOrozaGDBBHgWdhLktrNmFqc4wzRFhRReQXJqw@mail.gmail.com>
Subject: Re: [PATCH] scripts/mod/modpost: fix null pointer dereference
To: Max Kellermann <max.kellermann@ionos.com>
Cc: nathan@kernel.org, nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:51=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Sat, Feb 17, 2024 at 1:24=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> > Can you describe the steps to reproduce it?
> >
> > I set CONFIG_TEST_USER_COPY=3Dm, but I could not
> > reproduce it.
>
> I have just reproduced (and logged) it - with "ARCH=3Darm randconfig
> KCONFIG_SEED=3D0xDD5A884F". Config file attached.


Thanks for the test case. I confirmed that.

Applied to linux-kbuild.



--=20
Best Regards
Masahiro Yamada

