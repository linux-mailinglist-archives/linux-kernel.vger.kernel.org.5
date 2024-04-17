Return-Path: <linux-kernel+bounces-148723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F198A8A86A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA55F2820A7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C95B1422DF;
	Wed, 17 Apr 2024 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrc/fQcm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894D13F44A;
	Wed, 17 Apr 2024 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365341; cv=none; b=f6D8IDhcPw0MssLe0jxArdGxPLBUnTj+8P7i3dzNYrwrClcOlVA0lpktiTORUL2g/bU/2xbHJhwXk9amMV8I5/pInEJEGC8L+qTqbp8V9eoA5kGKXoAKkgMCRNtqHgyJi0RYRlySEyyifTm6yacThRPrP2DnyZKb4sHSo3EqBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365341; c=relaxed/simple;
	bh=csDUpJcvCrwb5nQUKE6rIKwnccp2Lm3sAMFjZWS0LWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6B6HDfSn6Tsg4DwHCArM3u894+ywIhOD7ciLlX+LKz7OxpdWjL9zRVt5KfXsijtEgkpMfpDBfLl10ejZSbjHrbMBsI/uoHgDezVtztpcdvUuJ54Ncg3MwnVu5DC5/ENU8jnXuDVDy4GDqeF3qoJa6EGXx53OYG3kGccWAnmFuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrc/fQcm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0603BC072AA;
	Wed, 17 Apr 2024 14:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713365341;
	bh=csDUpJcvCrwb5nQUKE6rIKwnccp2Lm3sAMFjZWS0LWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zrc/fQcmdl1DSWDPiRcKShyJ9zUpZcY3Q6TZ4j75Gpqr2n2nPHifeZ6YfEc3Z9Joo
	 fj6m9UaqlBq2JECBILLgOuE/e5TBatqMTX/XhyLFq7EJzeBFgbslRDvg6FOLXzAZd/
	 qqULol9mm1N/IuYI7no3iwnOQ+gsj2vQpyC7evIu3rg+9j96BRqrG6RtHomJXM+jhz
	 WVjz3yfl/KQfTGS/ev+sDV9c2dDROl+EjZThyziVsG7o20rdo6zI4IQAPQ2aFWjKUc
	 PwIKi14x+3GrA5GjP1e45Bjaeob7LLvZM3Gv9qQbK6ooNi9fM2qnML3Apmn+PwWL1z
	 R1m+P2JySSZYA==
Date: Wed, 17 Apr 2024 07:48:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pratham Patel <prathampatel@thefossguy.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	thefirst1322@gmail.com
Subject: Re: [PATCH 0/2] Enable building of the devel RPM package from Kbuild
Message-ID: <20240417144859.GA1471879@dev-arch.thelio-3990X>
References: <20240417043654.60662-1-prathampatel@thefossguy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417043654.60662-1-prathampatel@thefossguy.com>

On Wed, Apr 17, 2024 at 04:37:32AM +0000, Pratham Patel wrote:
> This addresses a minor nit where I want a `-devel` RPM package to be
> built when I build a binary RPM package with either `binrpm-pkg`
> or `rpm-pkg` target(s).
> 
> Pratham Patel (2):
>   kbuild: allow toggling the `with_devel` RPM macro
>   docs: kbuild: document KBUILD_RPM_WITH_DEVEL
> 
>  Documentation/kbuild/kbuild.rst | 6 ++++++
>  scripts/Makefile.package        | 5 ++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> --
> 2.42.0
> 

Hmmm, when I execute

  $ make -skj"$(nproc)" ARCH=x86_64 O=build mrproper defconfig binrpm-pkg

I end up with

  $ ls -1 build/rpmbuild/RPMS/x86_64
  kernel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
  kernel-devel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
  kernel-headers-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm

so it seems like this is already happening?

Cheers,
Nathan

