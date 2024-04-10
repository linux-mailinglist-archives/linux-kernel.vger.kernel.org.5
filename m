Return-Path: <linux-kernel+bounces-138974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD4A89FCD3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6071C21E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D517A93F;
	Wed, 10 Apr 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfoDkDZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621C15ADBF;
	Wed, 10 Apr 2024 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766565; cv=none; b=o7a9b2h1vww+M5ZUttEXH7O00dDKPabwg660/D43XZQqPjcPJ2u+KJufugeBW11+Lwe92WOQHy7mW3srXUBehoX9fnWu3lx2pqduvpv0neR3a3zH/RvXprud9p/TWKDY5oo9GNzXCllHCUhTD1Fy5LCYScVurE7ATRLhQt5ga6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766565; c=relaxed/simple;
	bh=YSAPIOtYNplSycjf3v7XSTEn1r+NDjIrTJDrbvJR6wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSwwGr6g8CXPJmYzVSmFJA7IgeUryVwdMnkqGtw88RdTA/io4qVlbMzLdV6XZ+Sfz9saRakrra90f5tPe/YM9ps2nH1w5RID5kpQIl6xRCE/8wlDQmVfvghdFE2FkFgkNquy2InEO/ZTMM0JeQvq5iS9NuXBNzQ496jwRJTCr/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfoDkDZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E97C433F1;
	Wed, 10 Apr 2024 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712766564;
	bh=YSAPIOtYNplSycjf3v7XSTEn1r+NDjIrTJDrbvJR6wQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfoDkDZmkfM1oz64jIu5UjxX41RaJQV5t+KnioNgququptp/uL1Ngg3yuFw1jrM/Y
	 Avy/wg6bFnwXimgGm2fPCTdKORiXvuF0RWNGJpH7/YgrC40a9EBz0Xs9rieevLBPMt
	 bma23ZzR1JhK3g7R4/R7mMGL+wxGQLxJi8gjMnNQUoXxG/jNS4IWef++uCTdR6yZDo
	 gUchAkh8ExprvWjL093grl2C0CGwdLVq5zlN4LWAxGkyJqKPKaHzA4mUkFeDkTUMJn
	 BooX7ewcIzpZI91f2IykdEFzrSV9im+noRy4iUgJCnXr0dJ62xpQ84nyIc7gkUpzpU
	 XPDKOkCeDKp6A==
Date: Wed, 10 Apr 2024 18:29:19 +0200
From: Alexey Gladkov <legion@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
	linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-serial@vger.kernel.org, Helge Deller <deller@gmx.de>
Subject: Re: [RESEND PATCH v3 1/2] VT: Add KDFONTINFO ioctl
Message-ID: <Zha-X8QS_8L9eF0r@example.org>
References: <cover.1710252966.git.legion@kernel.org>
 <cover.1712053848.git.legion@kernel.org>
 <ed056326540f04b72c97a276fbcc316e1b2f6371.1712053848.git.legion@kernel.org>
 <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
 <ZgwF72yHH_0-A4FW@example.org>
 <6bb4f4fb-573c-4f63-967c-2cb08514fc91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6bb4f4fb-573c-4f63-967c-2cb08514fc91@kernel.org>

On Wed, Apr 03, 2024 at 07:27:55AM +0200, Jiri Slaby wrote:
> On 02. 04. 24, 15:19, Alexey Gladkov wrote:
> >>> --- a/include/uapi/linux/kd.h
> >>> +++ b/include/uapi/linux/kd.h
> ...
> >>> +struct console_font_info {
> >>> +	unsigned int min_width, min_height;	/* minimal font size */
> >>> +	unsigned int max_width, max_height;	/* maximum font size */
> >>> +	unsigned int flags;			/* KD_FONT_INFO_FLAG_* */
> >>
> >> This does not look like a well-defined™ and extendable uapi structure.
> >> While it won't change anything here, still use fixed-length __u32.
> >>
> >> And you should perhaps add some reserved fields. Do not repeat the same
> >> mistakes as your predecessors with the current kd uapi.
> > 
> > I thought about it, but I thought it would be overengineering.
> 
> It would not. UAPI structs are set in stone once released.
> 
> And in this case, it's likely you would want to know more info about 
> fonts in the future.
> 
> > Can you suggest how best to do this?
> 
> Given you have flags in there already (to state that the structure 
> contains more), just add an array of u32 reserved[] space. 3 or 5, I 
> would say (to align the struct to 64bit).

struct console_font_info {
       __u32 min_width, min_height;    /* minimal font size */
       __u32 max_width, max_height;    /* maximum font size */
       __u32  flags;                   /* KD_FONT_INFO_FLAG_* */
       __u32 reserved[5];              /* This field is reserved forfuture use. Must be 0. */
};

So, struct should be like this ?

I wouldn't add the version to the flags. Maybe it would be better to add a
separate field with the version?

-- 
Rgrds, legion


