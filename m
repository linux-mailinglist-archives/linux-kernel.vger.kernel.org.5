Return-Path: <linux-kernel+bounces-68753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00886857F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843A228D0E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA2A12FB30;
	Fri, 16 Feb 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhdiNTts"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4ED12FB1D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094446; cv=none; b=dRXbN5xBcuutGWvlBiZXCtdwa8UVuWR6NxpSJJPMqxKgEAgNoJXVokLzSiUDsEaR1Wcb9XQCkUmK+NdjY1widxKZjOWCNxqMBabOZsYwUHdo4Qh65fFMxk35uWsVYI7Fvb04JltmB0WxXMJAaWlxaCcMXVNNPrCRNVNTGiL0cgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094446; c=relaxed/simple;
	bh=KyiJUwVp3WSEgIu/ScrsxW/jzrNSeVWnnoNAptYeyQs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPISCdPdA71rg7E0j1wNgCkuiccGeej4JEgf36ezUCHS4eFiOqwmdDwcL84AHbC7j5/ZfrnHT/z/lyljAtVyHGTFmfHhG57hs8oh+iF1r9LJ/ToIiAuyUXyMIDziZ2fjQDRUYabI7IpIlVQ2mAerxq9uD42JEEx85SLxBOS7hAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhdiNTts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2FFC43390;
	Fri, 16 Feb 2024 14:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708094445;
	bh=KyiJUwVp3WSEgIu/ScrsxW/jzrNSeVWnnoNAptYeyQs=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=IhdiNTtsz3SKvL19GUeYPjoehtyOuqzU7hczruIP/3RBlL3Oepr99tz1cXNVXJA1N
	 Ko49fBOBtABQ0vtXPYgj9P7VNIy58wmUXvYnAk8rGpMPQyqrGcG6Oec6HOgYbZHp5W
	 PSXTaZvuzZZ5k8kGM7uNSTOtYP29EM29RbUh44o9OdE5h3QnFFAy2ze4EMETfv/q4u
	 2CpJsE5q1jle6jdkLSUiKEFspSkPVjZVHFTF01ZXGXGNzQQP7hpHQVMwL8zpYoqEC4
	 lpixbVYwvp3cUUUVxRJeVFlQ9BNLPyxDg6d4XtWJXb/o1Vkq3kPTttJsP8wdYML1Uq
	 O/XDWyUBbdjCQ==
Date: Fri, 16 Feb 2024 15:40:40 +0100
From: Alexey Gladkov <legion@kernel.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v1 0/5] VT: Add ability to get font requirements
Message-ID: <Zc9z6P_Iyw2zboSZ@example.org>
References: <cover.1708011391.git.legion@kernel.org>
 <d7743747-1ec2-4557-9f2f-4cffd77284b3@kernel.org>
 <Zc9ijvUofv4PCLw_@example.org>
 <20240216134522.s6d22mljxyfd3fsx@begin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216134522.s6d22mljxyfd3fsx@begin>

On Fri, Feb 16, 2024 at 02:45:22PM +0100, Samuel Thibault wrote:
> Alexey Gladkov, le ven. 16 févr. 2024 14:26:38 +0100, a ecrit:
> > On Fri, Feb 16, 2024 at 08:21:38AM +0100, Jiri Slaby wrote:
> > > On 15. 02. 24, 16:37, Alexey Gladkov wrote:
> > > > We now have KD_FONT_OP_SET_TALL, but in fact such large fonts cannot be
> > > > loaded. No console driver supports tall fonts.
> > > 
> > > I thought fbcon can, no? If not, we should likely remove all the 
> > > KD_FONT_OP_SET_TALL checks here and there.
> > 
> > I thought so too until kbd users started trying to use such fonts. A month
> > after adding KD_FONT_OP_SET_TALL, support for large fonts was turned off
> > in fbcon:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=2b09d5d364986f724f17001ccfe4126b9b43a0be
> > 
> > But I don't think we need to remove KD_FONT_OP_SET_TALL completely. Maybe
> > support for large fonts can be fixed.
> 
> Some users *need* it to be fixed, because they need large fonts to be
> able to read their screen.

I totally understand that. That's why I don't think it's necessary to
remove or block SET_TALL. And that's also why I added you to the thread.

-- 
Rgrds, legion


