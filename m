Return-Path: <linux-kernel+bounces-122862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636988FE92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680FE1C2270F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407EB7EEF4;
	Thu, 28 Mar 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTITSUoj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9E43ABE;
	Thu, 28 Mar 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627415; cv=none; b=Kel7dRxyoMltVn/+HICb8BxEk36ffOUOkR38A3p7ixckL3VAWrOf69BVzMK47zbOt+y+sQOPc9ND22agl9t2lmXBeF6w7FBLKIPcLguU7ufWn0TgSZy33DDTj8/NwSQ2E5Lf1aEZy2YJDnibgU4yxTWDKXBO3fkr4uJCKySNBFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627415; c=relaxed/simple;
	bh=ftAi0138ljeybsCkA3p2TsAqoWmZb2V8KjzoPIukDkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFBAaJEziu65Ak3myrfMspCzFP/f9T5d21x3mD0lNzsJV6hF3BdPkOK48cqtgKbPyz8SascSDNvrkORuNJF62z6W9JKgjytFDc4qs9yfyhWlehEGDA9ZFUoUMuoNe5i+BLzBIwmbWqmeT+HXkEPKIfaM/AMuL7u+1zcZFZpjl0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTITSUoj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E19BC433F1;
	Thu, 28 Mar 2024 12:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711627415;
	bh=ftAi0138ljeybsCkA3p2TsAqoWmZb2V8KjzoPIukDkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTITSUojfmL0QlCbb0gXnBadPu3eZ1mEGnEUggOhx6hAPXuzr6DWg/p5xHLL7F5dp
	 21D3HwDhdniSffz69djLfuzgiRBX446JxR5288pRPaaYZBcYPG9mrWULd7HizmEkVr
	 pDkt63Tz6AKuBL1MMgiA5OdVC2txUtV28GA5fmhPmBtdlJfRtVUVAIy6y6SeSeWk0I
	 CexovdNTwSrf9Pi9PVzdCOjax6p/MNikaA6kADIRd4z4J5t3I4VnHP63m2HTYYG4bT
	 0/XfCsR0jPtXdAZL3ZnFGWR427QIEEPUNI3nHdgf3lC6sGEqEbJKIHybHwxvNzDSeE
	 R7ymhIV1S2e1w==
Date: Thu, 28 Mar 2024 12:03:29 +0000
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Ryan Walklin <ryan@testtoast.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Regulator due for
 the v6.9 merge window:wq
Message-ID: <20240328120329.GF13211@google.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
 <20240328095631.GW13211@google.com>
 <20240328111108.5ddfa073@minigeek.lan>
 <20240328120011.GE13211@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328120011.GE13211@google.com>

On Thu, 28 Mar 2024, Lee Jones wrote:

> On Thu, 28 Mar 2024, Andre Przywara wrote:
> 
> > On Thu, 28 Mar 2024 09:56:31 +0000
> > Lee Jones <lee@kernel.org> wrote:
> > 
> > Hi Lee,
> > 
> > many thanks for picking this up!
> > 
> > > Enjoy!
> > > 
> > > The following changes since commit 4cece764965020c22cff7665b18a012006359095:
> > > 
> > >   Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v6.9
> > > 
> > > for you to fetch changes up to d2ac3df75c3a995064cfac0171e082a30d8c4c66:
> > > 
> > >   regulator: axp20x: add support for the AXP717 (2024-03-28 09:51:03 +0000)
> > > 
> > > ----------------------------------------------------------------
> > > Immutable branch between MFD and Regulator due for the v6.9 merge window
> > 
> > Did you mean v6.10 merge window? Or is there a plan to merge this into
> > 6.9 still?
> 
> Yes - off-by-one!

Just recreated ib-mfd-regulator-v6.10 for all the OCD types (like me!).

-- 
Lee Jones [李琼斯]

