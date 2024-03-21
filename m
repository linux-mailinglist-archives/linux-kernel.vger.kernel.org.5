Return-Path: <linux-kernel+bounces-110106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C57885A17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3679FB21CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437D884A54;
	Thu, 21 Mar 2024 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdT9JP84"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4D5810B;
	Thu, 21 Mar 2024 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028914; cv=none; b=keeMpzrQrIVbbU97REyhXBnUwCm25unSt6zRqbEEV5hHdSA4uQdTO0vAxjDFsnacrQDfcho0KLezBcnRUHMGbGHz7xkZwhKSm3Ct1v03uv9X3BgTfvMQwvpiDALgvsV/8LBCOvnKe9JzWuVNpnPYV7WB+TKqbptEEiYCkmkg9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028914; c=relaxed/simple;
	bh=V5RBETxUeQ31LdNz29iy7Ib6LpbGMzdOR34CyxswrlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjojKEk+72PVqOhtgYAPGJgVc2kVjzWhlHLoL4sRotmU+AAfg6T68x4tqch4LpWZ5+JROh6aTlGrHZ4oXiU0+WtCOICYpP/VzgIyX+B3ZMNKPacncK/Pb1FXZpSH8DBFHG4s8Bj60iHlClu63t0BhROPVFc566VFGFbSqCPkNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdT9JP84; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB20C433C7;
	Thu, 21 Mar 2024 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711028914;
	bh=V5RBETxUeQ31LdNz29iy7Ib6LpbGMzdOR34CyxswrlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kdT9JP84vFIrStaRlOk5A2K3PDF+foU/KUGFhOs9c4FcKE5C1M0cMp90i9ZwflFYT
	 wTlvdVBo0lCE96Zoy6hAG5TC5ewgj9QyM/VMoPGmtYOn+sKfvK/3ZbAgDa6aae047C
	 +kPg5f7NGLjNvf9TYBIz0u0VVKhIj2t5v7EDPHOQbBWkioZqeABV8EaMtaRRRy6PHw
	 w3jYf8pFkqGk6VIvcpRTMWte5j/EmUwpj1W9kHI5rFuQZJ6EMXA2TM7mL2txSqVJ/C
	 45DzXfdFDLUVcFx17q408DfMVYEC48TQ7xgh3XD72+A8hHQVtqYlKuggRGpIzpl1wm
	 62csEMK0inWxQ==
Date: Thu, 21 Mar 2024 06:48:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.9-rc1
Message-ID: <20240321134831.GA2762840@dev-arch.thelio-3990X>
References: <Zfwv2y7P7BneKqMZ@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfwv2y7P7BneKqMZ@kroah.com>

On Thu, Mar 21, 2024 at 02:02:19PM +0100, Greg KH wrote:
> All of these have been in linux-next for a long time with no reported
> issue, other than a build warning with some older versions of gcc for a
> speakup driver, fix for that will come in a few days when I catch up
> with my pending patch queues.
..
> Samuel Thibault (2):
>       speakup: Fix 8bit characters from direct synth
>       speakup: Add /dev/synthu device

That build warning actually happens with clang, not GCC as far as I am
aware, and it is actually a hard build error with older versions of
clang, as Arnd points out in his patch to fix this (although the warning
is a hard error with CONFIG_WERROR too, which causes allmodconfig to
break):

https://lore.kernel.org/20240313100413.875280-1-arnd@kernel.org/

Samuel's patch was even simpler:

https://lore.kernel.org/20240309203549.jj2l6epnznyjsrje@begin/

Why was one of these changes not applied before this was sent? I am
aware you were on vacation recently but you are now adding a known issue
to -rc1, which can proliferate to other maintainer's trees and makes
testing for us more difficult :/ -next has been broken for the entire
merge window over this, which is usually when there is a chance we can
get maybe a week of green builds...

Cheers,
Nathan

