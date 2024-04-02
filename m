Return-Path: <linux-kernel+bounces-128244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152EF89583B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2919C1C227A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9C613174A;
	Tue,  2 Apr 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="taUuDJWC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4813C134750;
	Tue,  2 Apr 2024 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071811; cv=none; b=d/b3MbDU62UpXPiKnFzfUaqFzMefwNaCY/4TE7tb+IhXJ4zgBth4h0kQpt/2WAObJ7ttM0mdgUjgAgl5C5rJU32JElPD9R3sfLiOSsSGqbuTOeXrdeQhKe/2BqgmeJGXusaN/ErBqQlENyeY2T7uSRMoulEbbSUk/dpp5qk/zPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071811; c=relaxed/simple;
	bh=Mg63hoWgyu1emHztvlNxc4m7lNkXFrtqWqUTYT7EolU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Br24p420GIpiAogL53EiZ6Wnuy2RdIrOiva0EiVorcIy4xspkqAjgTwAZarLYNQMtSip84YeZF/gOeZjHCqcjhQ1gOiMlTJOX5m3MGswOdGEZqLYdwt3ad/k4wXO1nHoq22mjONl81pwVnFpjUDohwjmzSUlL3JhQMAXpFlse9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=taUuDJWC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9544647C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712071808; bh=4J0PiXaFUEU/W3BdK9lcYY6frY80SRk/ZG3pwh+Rm64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=taUuDJWCrpZlU8jTnqUYUaVQOpYy+qCmcyYYeTm+l/UWyE6+a2dvQZ3xahSdTOcZ2
	 P3imBxmlYYhcbuf5NyKHSimE+BgsLsCJ23aqosTDgoz4wBog7nJUtiYQsJxLvNvxHf
	 ZIf6tnsoPEwQxeEjusmealuOSlQDealbt1nv44KW9mj0LoUhD8dp+aau9EQrlglHrg
	 x//jx/jg+WfAeLMJV9Z5tm54niTm1X1as5YrjSSuWJV/Ue8g8ge3yuHU+crnn62+vc
	 vVjWj0W2smkiqL4ymza6wHI044jrclw0o8LtDScKILZl30VHEzxy95WoTwO3aF8dHX
	 wOLkikqWyLX2g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9544647C1D;
	Tue,  2 Apr 2024 15:30:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Blum <thorsten.blum@toblux.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Blum
 <thorsten.blum@toblux.com>
Subject: Re: [PATCH] scripts: sphinx-pre-install: Add pyyaml hint to other
 distros
In-Reply-To: <20240323125837.2022-2-thorsten.blum@toblux.com>
References: <20240323125837.2022-2-thorsten.blum@toblux.com>
Date: Tue, 02 Apr 2024 09:30:07 -0600
Message-ID: <87ttkjwznk.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Blum <thorsten.blum@toblux.com> writes:

> Extend commit 84b4cc8189f2 ("docs: scripts: sphinx-pre-install: Fix
> building docs with pyyaml package") and add pyyaml as an optional
> package to Mageia, ArchLinux, and Gentoo.
>
> The Python module pyyaml is required to build the docs, but it is only
> listed in Documentation/sphinx/requirements.txt and is therefore missing
> when Sphinx is installed as a package and not via pip/pypi.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  scripts/sphinx-pre-install | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 4c781617ffe6..d4f05216ca23 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -514,6 +514,7 @@ sub give_mageia_hints()
>  {
>  	my %map = (
>  		"python-sphinx"		=> "python3-sphinx",
> +		"yaml"			=> "python3-yaml",
>  		"virtualenv"		=> "python3-virtualenv",
>  		"dot"			=> "graphviz",
>  		"convert"		=> "ImageMagick",
> @@ -557,6 +558,7 @@ sub give_mageia_hints()
>  sub give_arch_linux_hints()
>  {
>  	my %map = (
> +		"yaml"			=> "python-yaml",
>  		"virtualenv"		=> "python-virtualenv",
>  		"dot"			=> "graphviz",
>  		"convert"		=> "imagemagick",
> @@ -587,6 +589,7 @@ sub give_arch_linux_hints()
>  sub give_gentoo_hints()
>  {
>  	my %map = (
> +		"yaml"			=> "dev-python/pyyaml",
>  		"virtualenv"		=> "dev-python/virtualenv",
>  		"dot"			=> "media-gfx/graphviz",
>  		"convert"		=> "media-gfx/imagemagick",

Applied, thanks.

jon

