Return-Path: <linux-kernel+bounces-166771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44C8B9F53
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B566B21410
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4116FF3C;
	Thu,  2 May 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/YGbibJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032BC15E7F4;
	Thu,  2 May 2024 17:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670096; cv=none; b=qnNxsW12F/lUFg+4ZwGHmcJHOjUb2mfjWqWGPCdPCCw7F8+LMCBtxuFvCvnGZGHP2fjozFhenMkmyOAWX4e2Lz3d+Cry89VIuwJ9f+7mdzTKLCXwXBuWTygg09nyHo8k976AsSoeG2zQqrZhYyJxlQPwgVVHGL6i6G+0mlQ9uk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670096; c=relaxed/simple;
	bh=N5HHrMygWqjBvhvqTPXKIRh02+LNnMgHkw3e9eLY0ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0YfPSndBxG4lp1Ec+E526TlAFvtWaykP82dBSBJWnsjxPIqOKi6/tC15osf/vPHVC1fJK4gKaGZHbW8kEj6fbUfTWaJKoig+Gr+ceGvMSiGFQ9bJofju6W03X1RkKtxXIlJrSsw7MPy0KhlaVAxZH5MRyE4MZVST0Mi6JCdUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/YGbibJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF56C116B1;
	Thu,  2 May 2024 17:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670095;
	bh=N5HHrMygWqjBvhvqTPXKIRh02+LNnMgHkw3e9eLY0ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/YGbibJzsWR0UG2me+jlP7N6NbtsfyxLPs94dUbAHBdUosFWZ3fAbXfTudpooG5q
	 Ou4W/VP8l/jtDiya8wSkyrYLgbLWid4J2VMgBoX2JsBvXVcjHQ3CeE2xFjkX6BoOG/
	 InKwP3CAB+6vC8c3g+hkcGAjQGOihD7y05OIHD9dYo9LeXIT5Du260ncYPhvibd0NW
	 7n6RFjWUXJ6r4wX00sG/puIqaOvx23EBX59y8xyp04Y7R1+T+YVcHAKrkHvqY9Kx9H
	 sHj8kgTXofB2P1/Pfxe+yxImR09iGrQF4B1qoVlGVt886zcdLlK9nJyHGmr590YuCH
	 O7uGRlvkCb3DA==
Date: Thu, 2 May 2024 18:14:51 +0100
From: Lee Jones <lee@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Pavel Machek <pavel@ucw.cz>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] leds: mt6370: Remove an unused field in struct
 mt6370_priv
Message-ID: <20240502171451.GE1200070@google.com>
References: <e389be5e1012dc05fc2641123883ca3b0747525a.1714328839.git.christophe.jaillet@wanadoo.fr>
 <16df315e-8a05-49a4-ac07-d1ed150c9317@collabora.com>
 <d526b169-0385-4f23-8806-17bc73c2507b@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d526b169-0385-4f23-8806-17bc73c2507b@wanadoo.fr>

On Mon, 29 Apr 2024, Christophe JAILLET wrote:

> Le 29/04/2024 à 10:13, AngeloGioacchino Del Regno a écrit :
> > Il 28/04/24 20:27, Christophe JAILLET ha scritto:
> > > In "struct mt6370_priv", the 'reg_cfgs' field is unused.
> > > 
> > > Moreover the "struct reg_cfg" is defined nowhere. Neither in this
> > > file, nor
> > > in a global .h file, so it is completely pointless.
> > > 
> > > Remove it.
> > 
> > Sure
> > 
> > > 
> > > Found with cppcheck, unusedStructMember.
> > > 
> > > So, remove it.
> > 
> > Again?! :-P
> 
> Yes. This way we safe twice the memory space :).

I changed all of the commit messages in this disjointed set to flow a
little better.  No need for a Fixes tag either I feel.

-- 
Lee Jones [李琼斯]

