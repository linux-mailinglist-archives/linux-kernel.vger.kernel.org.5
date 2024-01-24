Return-Path: <linux-kernel+bounces-36914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326183A89C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D667B24296
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013360DCB;
	Wed, 24 Jan 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="c720hp7+"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0525F60BBC;
	Wed, 24 Jan 2024 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097570; cv=none; b=b9EUDvwRaY1jcgENh4r1I3WR1tLVybwcrR3mcANI8+bJ8rr3Jc0xonIFCZQ+8RNHg2w78h1HQAVLiJp7s+Zh8PQjHthE9aItxddxiylhRBS/Tw0hNZ+JoV9oxS1DtwoQY49xlclN45613QGS4dIynOq4RwT7VGTyNHolWbRuYOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097570; c=relaxed/simple;
	bh=zRI91rxXLZDZms7nr+vT21vbz/QGrBc+xdSOJtUg6JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thBBR0OPCM5GqWtQ419b94g9epFWqfFkBTRrZvPwO52lnDvQRP0TiSHTLZtLH3SEfta9k+KNwEE8I1G+PfrQ8+MCEFxg26IchDsBpMrvyX5ccpdyMYCRGEDkBlvPPcmqc7yoUichOmF+hDqZJmPu8uv65jWatTae2VPRJidbhJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=c720hp7+; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78AE240E01BB;
	Wed, 24 Jan 2024 11:59:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DSaR5PiRefZh; Wed, 24 Jan 2024 11:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706097562; bh=f039EAwY2JbAGOjR7hRLJIXTmhFyVr7QT7gsd7YvhAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c720hp7+V5ij/EdnUqYZEznYBtuKwVMpR8isHycps7SUKQmyvLI2xd44UklG4sAv6
	 boODEzf34ONVkZWZqDyl5Z5Ru9h3Ms/0Cr4y23uPwRKNNT/rm7iwfIr2LqD4lrV2LA
	 5EmmZbpHxx/a0suPInMebt1eNF8bEThqu4YM4NMVtOLhYsvhQYlKf6GJY8LJJvwzou
	 DTVnAXC+e5Dt7rizJLqWhMX53A1m9L+hbw98kSJjBmgXWWujZ8o8TkF3g/HGNB6DYR
	 pFcTVzYDUwwqeTBsJKWsstBS2CSDjQUsGpo0kWj2HcgNeT/1rwNlvVQ1ZEsNcs7hRJ
	 HamhaXznxhM1gVz3VE1xb4qtdBqZGWq3IUGSHJw3rnwfCi8705BQltnh+bv8mgR9o5
	 ix7c828luiSPlssaUIA3nuLq0vZf7ckvXTnp1EqPn3vTWr9p6FYJ5M+V4GE2+SSVOu
	 WNMAWQStRre4CuZlCts7GNgcAxHVktuQ7hOIeOOhH0cZnSyv41sjUsWZIG+VXL7DcX
	 SZrEf3WvnY2xeNFD6vURxddZf9lS741TBPmTsGd0NUHd18qkrfj9RXSpaAxUoUCHdI
	 bdL/GUjfis5QwyRRR9JEyqTiDHdxD/MaXWClXVRF2v7GaYrdokMPL8Mnr6SR9trSO1
	 o5iRTdik9jqQHQt9pR9QXApo=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E78CC40E01AE;
	Wed, 24 Jan 2024 11:59:10 +0000 (UTC)
Date: Wed, 24 Jan 2024 12:59:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com, muralidhara.mk@amd.com,
	william.roche@oracle.com, corbet@lwn.net, linux-doc@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 0/3] AMD Address Translation Library
Message-ID: <20240124115904.GCZbD7iFlIuQKc8H7U@fat_crate.local>
References: <20240123041401.79812-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240123041401.79812-1-yazen.ghannam@amd.com>

On Mon, Jan 22, 2024 at 10:13:58PM -0600, Yazen Ghannam wrote:
> Yazen Ghannam (3):
>   RAS: Introduce AMD Address Translation Library
>   EDAC/amd64: Use new AMD Address Translation Library
>   Documentation: RAS: Add index and address translation section

Applied, thanks.

New stuff goes ontop now:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-amd-atl

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

