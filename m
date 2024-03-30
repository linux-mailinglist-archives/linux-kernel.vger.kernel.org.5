Return-Path: <linux-kernel+bounces-125728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA8892B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78811B22254
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2741D68F;
	Sat, 30 Mar 2024 12:58:16 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750D282F7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711803495; cv=none; b=MtKCAhl7Wk1t7lNvBzZBAby1A7rlHBgqVlXEv6jQBmkHPxOxTC9tZkQ5wJG6mE2otZz5t1KSxLCok6qMXhQym/HyUpXarOFBpsnGyc6xsIEVLD1bW0gGidcT2wWjrjBbgYI8BoI82p6d9V44jeOPykHxeapux5wQ9r8IcosC1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711803495; c=relaxed/simple;
	bh=VZS0Yhea1VuqzBkvRh9+dF6lilkH2Gyb3e+oRQiXOVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMIT0vz8PNW+VOmW9JuyfR2dHH6O3Pu+lcXmNOTs911Zbi5wzwHYKT+gZoDR/JnTotqYlJz13fAjfY61iPQOnSCYkmX6Umn2SXdpyAVEeArzRucS+XivciUB2qNoyOsP+IPEBK7x+QvAmlHikesPyhz8pnbJpS+QLLLzobVR+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 465C9424F7;
	Sat, 30 Mar 2024 14:48:49 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rqY8f-0008Bi-0O;
	Sat, 30 Mar 2024 14:48:49 +0200
Date: Sat, 30 Mar 2024 14:48:48 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Jia
 Tan <jiat0218@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [tech-board] [PATCH 00/11] xz: Updates to license, filters, and
 compression options
Message-ID: <20240330144848.102a1e8c@kaneli>
In-Reply-To: <20240329195602.382cb1c99bb70e3d8c6093ae@linux-foundation.org>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
	<202403291221.124220E0F4@keescook>
	<87h6go3go2.fsf@meer.lwn.net>
	<20240329195602.382cb1c99bb70e3d8c6093ae@linux-foundation.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2024-03-29 Andrew Morton wrote:
> On Fri, 29 Mar 2024 14:51:41 -0600 Jonathan Corbet <corbet@lwn.net>
> wrote:
> 
> > > Andrew (and anyone else), please do not take this code right now.
> > >
> > > Until the backdooring of upstream xz[1] is fully understood, we
> > > should not accept any code from Jia Tan, Lasse Collin, or any
> > > other folks associated with tukaani.org. It appears the domain,
> > > or at least credentials associated with Jia Tan, have been used
> > > to create an obfuscated ssh server backdoor via the xz upstream
> > > releases since at least 5.6.0. Without extensive analysis, we
> > > should not take any associated code. It may be worth doing some
> > > retrospective analysis of past contributions as well...
> > >
> > > Lasse, are you able to comment about what is going on here?  
> > 
> > FWIW, it looks like this series has been in linux-next for a few
> > days. Maybe it needs to come out, for now at least?  
> 
> Yes, I have removed that series.

Thank you. None of these patches are urgent. I'm on a holiday and only
happened to look at my emails and it seems to be a major mess.

My proper investigation efforts likely start in the first days of
April. That is, I currently know only a few facts which alone are bad
enough.

Info will be updated here: https://tukaani.org/xz-backdoor/

-- 
Lasse Collin

