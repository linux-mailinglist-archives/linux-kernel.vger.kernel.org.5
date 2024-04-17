Return-Path: <linux-kernel+bounces-148763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF548A8717
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71CA8B26DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F251474AF;
	Wed, 17 Apr 2024 15:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="e5VyCHM3"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED72146A95;
	Wed, 17 Apr 2024 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366555; cv=none; b=HiAF90ZZkXRoxXlmbpQQMQtgYtOv4EVRWwx1xQkMV/kLnTtwoVVIKeYyCoj3eV1XLP0U38QMTLMPIQxp8HDBelikQ3w1MQ7kiXtFGIIl6H+jL/9M2qVSSn8ElDtPy1TgCi14uQn5QSPiBpMQDIt1y9k8bG82tfrfgPLXQhhN+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366555; c=relaxed/simple;
	bh=ttKdkzHMSd4PN+R+DnzszfWy/6/MTbcl4uKdYya5r2I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WCBNpAvpPdhonlpAlQ4aVDeZk4Xj4xTgkqYEBaStynEyOGsrTqSd7k5mag8X2KKt8uds2iAR5OBT8eoiHA9pcDk5kw0bBt0yxiznnvrr2t2jOo+B9Iz4ZU54LJpiVefFi39Y3RLLbsy1q8wybywM97390pYc4QSqNX3SSr7skYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=e5VyCHM3; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1713366546; x=1713625746;
	bh=KXu6bVlBQqZX1RSrSxQRTAvWT4KoOmUy+znF/34aNxM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e5VyCHM3mqicw7sbd5rjhEtRSrbAgoctZK/gbcqUm7uzOiVPGjmzxeu9BbwCYX/f2
	 MtXxJf8tior2UMmwju5DPxRpGjqblKn7o1zJ0bZNPftMT+ZImafvtPUq+j/Hud39E+
	 ciBRhsZnSEaaKrW+I2kLX+Ge0i/RLIZMop9vNnoj05n/9SfbNwSwYUT32Hgv1Draqi
	 meNehBpxi999vxqwBrTh8lrzMCL91L1/iEmJrxw46NX6JQnVc7d4cayDNJk5Xo/ujh
	 2aQrv3/nquoKXbOkHoFlp+4dDpmeOPV45kUYOZVAcepR887lfmjRlxASjqY2nqFNb4
	 A3TmukYCTq4sQ==
Date: Wed, 17 Apr 2024 15:08:57 +0000
To: Nathan Chancellor <nathan@kernel.org>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, thefirst1322@gmail.com
Subject: Re: [PATCH 0/2] Enable building of the devel RPM package from Kbuild
Message-ID: <D0MHQUIYGONC.3LTT2WN2885D7@thefossguy.com>
In-Reply-To: <20240417144859.GA1471879@dev-arch.thelio-3990X>
References: <20240417043654.60662-1-prathampatel@thefossguy.com> <20240417144859.GA1471879@dev-arch.thelio-3990X>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Apr 17, 2024 at 8:18 PM IST, Nathan Chancellor wrote:
> On Wed, Apr 17, 2024 at 04:37:32AM +0000, Pratham Patel wrote:
> > This addresses a minor nit where I want a `-devel` RPM package to be
> > built when I build a binary RPM package with either `binrpm-pkg`
> > or `rpm-pkg` target(s).
> >
> > Pratham Patel (2):
> >   kbuild: allow toggling the `with_devel` RPM macro
> >   docs: kbuild: document KBUILD_RPM_WITH_DEVEL
> >
> >  Documentation/kbuild/kbuild.rst | 6 ++++++
> >  scripts/Makefile.package        | 5 ++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > --
> > 2.42.0
> >
>
> Hmmm, when I execute
>
>   $ make -skj"$(nproc)" ARCH=3Dx86_64 O=3Dbuild mrproper defconfig binrpm=
-pkg
>
> I end up with
>
>   $ ls -1 build/rpmbuild/RPMS/x86_64
>   kernel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
>   kernel-devel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
>   kernel-headers-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
>
> so it seems like this is already happening?
>
> Cheers,
> Nathan

Ah sorry, that was a typo. I meant to say the following:
"This addresses a minor nit where I **don't** want a `-devel` RPM
package to be built when I build a binary RPM package with either
`binrpm-pkg` or `rpm-pkg` target(s)."

That is because on ARM systems where I just need to quickly test the
upstream defconfig, I don't really need the `-devel` package.

Also, I see that in a hurry, I did the opposite of what I wanted in the
patches. This went unnoticed since I had KBUILD_RPM_WITH_DEVEL=3D0 for me
during testing. Sorry about that!

I'll send a v2 fixing this stupid mistake.

 -- Pratham Patel


