Return-Path: <linux-kernel+bounces-83373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE0D8695F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CCFE1C20D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B78F1420D4;
	Tue, 27 Feb 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/hRbMnn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2E21420A2;
	Tue, 27 Feb 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042788; cv=none; b=h2ObwSof7JJtf6RJqjDw+FWLc9MUdRlqe7q7v6xvd2ea9Y2aUr2JCqcLv82GIfPnKM53rRBRH11r6EZlTwQ/rlBoZXbYoRF1ZXDdDRND/VNYruwBSa8pV8EQW9e/y2MMKYoTVwY19vzVNX3Lga9wWi2CnFxEdGDG/iLW7WT/PLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042788; c=relaxed/simple;
	bh=fim3gdliVyWO1z5CFYSVECFfVAjlYEqkkbZSlHGibs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNwVZ9MTleLGoAoJmn9E+WMbdqrVQzgozMVOuEsAZrdQoDxyJ9TiHELrgTeN5MfRZQxKz1vrIirA4XfOP8rl1zY3Tx6sUvr2LrhWjy4YbP0fqw/P3uUIqcrDUKle//BXxGa5OdRY3IcIcbSIkvFp450iXAMlm34V2JzbENndxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/hRbMnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25491C43390;
	Tue, 27 Feb 2024 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709042788;
	bh=fim3gdliVyWO1z5CFYSVECFfVAjlYEqkkbZSlHGibs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y/hRbMnnVAx1in8hmqY5Y+OGqH1RMKQF6Mvho03kx97cV93tY8sTXQWut8MkF94m8
	 p4zuSWUBpMYzmj1AdmBgMScfWGBxPtq6GwGq/DSeSp1mfg0T1W5u3FqUct+65veapd
	 HCqr5Tw2LXyrmAKJub3vLOPsVhDF4TD4AVw5h+qWqB4tgEpB6YD0yLEW782DcS+KXR
	 tO5KoVCCcxsDLw/PlilVv7hL51kMG+Qc5oXUC17smgfTJuyB+khzrZNDvJ/R9v2s7E
	 7FkZ6xJXpFovWTJvllm+a2LHi/QcaSLV9NzX6hyU+ZlmXaE4fbyUkniDzLTtYlbFYz
	 p2ApkX514kDGA==
Date: Tue, 27 Feb 2024 15:06:23 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] sticon: Allow to get max font width and height
Message-ID: <Zd3sX5OwVj4q9Y9h@example.org>
References: <cover.1708011391.git.legion@kernel.org>
 <cover.1708960303.git.legion@kernel.org>
 <07c0cb7f0c175460561957190e48a6e01a74a676.1708960303.git.legion@kernel.org>
 <2024022755-viewable-breeding-0bff@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022755-viewable-breeding-0bff@gregkh>

On Tue, Feb 27, 2024 at 06:52:17AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 26, 2024 at 04:21:12PM +0100, Alexey Gladkov wrote:
> > Signed-off-by: Alexey Gladkov <legion@kernel.org>
> 
> For obvious reasons, I can't take patches without any changelog text at
> all, and you don't want me to :(

It's just an RFC. I'm not sure if this is the best solution or if I added
the new ioctl correctly.

If you think that this approach is acceptable, then I will send a proper 
patches.

-- 
Rgrds, legion


