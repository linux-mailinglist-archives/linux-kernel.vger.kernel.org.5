Return-Path: <linux-kernel+bounces-66054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49C8555FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E011C1C2667A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663D1468EF;
	Wed, 14 Feb 2024 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ChvbvfNm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C181468F9;
	Wed, 14 Feb 2024 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949972; cv=none; b=nLe0S9Kge8M2on/TxdZxCOXWKqrStTrEKwT/xer2d72xKMdD6YlpY0tpQCSDJUkvHJ88U8r9pM2FK4tSFJ9hBraSeqny7M1dDwnAYvDPXgluJp207VqYtKLm/etR7HbzaO8d9yUAFX8g6tdmtUtdPVgWWug59rhzXS2Z/UQ5zrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949972; c=relaxed/simple;
	bh=mtSCdZgv47o/+T7mrZ6PURkHLuduyEU6ViQab5y8ou0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WtkA6FgmL/Mh5jHOL8sTvRVwKFat59VGFBzRlQfg9+7PZdXRLh+LyZl80F9C8BB7ANgHSFCY7/q95e9cKxZvQ6xYsC7OuvhE8sOhXh3LZkYbXXRRZt6ENXQQ9CFN0fRxROFvEOcCTaXXBfPC1GWSFkGecfWVnO9JbpTrY4rYGAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ChvbvfNm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2D0542A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707949970; bh=DaUyTprerc/4/xqpSGepd29lPCcYefcY+1+HzQWaNw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ChvbvfNmGue0EKZyb4sm5gN+/28Uz9jDTPcdC0KcL3spgF72rXuwxUSIHdUOxPAPn
	 jv1bnhRKZceAjJ5tkFzySSFitQnn5bg42Pot6S6NaRK3Y2RPbB9CmirEZ2jJAfUOxh
	 UT6YL1t03PzT/aDhIL5dDdKXmGNSB0h47rtVaylmO+7Pv+92Ic4Kiz/wR3uk6BkyLs
	 HWsqVSFRgLj6bZNYanNuhg89QVr7F3JHrsUEAqWS6YNrdDNkVNwryTOzb5kX3CIZb3
	 0kQO/0gqfZ/iXDQTKWh8yTWRQqFnjwsBhhJr2rGmw0XJ7Cz2GtyCR9rbA62ARK+d5Y
	 I9MvXeWM4D8uQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C2D0542A45;
	Wed, 14 Feb 2024 22:32:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>, mchehab@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 vegard.nossum@oracle.com, Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH v3] docs: scripts: sphinx-pre-install: Fix building docs
 with pyyaml package
In-Reply-To: <20240208205550.984-1-thorsten.blum@toblux.com>
References: <ED5D37EF-B353-4EA3-8AC9-7368BDD2CFD9@toblux.com>
 <20240208205550.984-1-thorsten.blum@toblux.com>
Date: Wed, 14 Feb 2024 15:32:48 -0700
Message-ID: <87cysyznfz.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> The Python module pyyaml is required to build the docs, but it is only
> listed in Documentation/sphinx/requirements.txt and is therefore missing
> when Sphinx is installed as a package and not via pip/pypi.
>
> Add pyyaml as an optional package for multiple distros to fix building the
> docs if you prefer to install Sphinx as a package.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
> Tested-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
> Changes in v2:
> - s/pyyaml/yaml/ as suggested by Vegard Nossum
> - Make the check require the Python module; was optional
>
> Changes in v3:
> - Preserve Reviewed-by: and Tested-by: tags
> - Add pyyaml to openSUSE as suggested by Vegard Nossum
> ---
>  scripts/sphinx-pre-install | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

jon

