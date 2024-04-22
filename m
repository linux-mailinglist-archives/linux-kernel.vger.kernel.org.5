Return-Path: <linux-kernel+bounces-154062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99508AD6BF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFE21F2154E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5841CF8D;
	Mon, 22 Apr 2024 21:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoIIGwAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F86EAC7;
	Mon, 22 Apr 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713822403; cv=none; b=oXM7BcNnxbL9x2+j8c2fX455bQVl5qwxZBZUd3wu37jnl9Km7OiHO0K0YAnQ/YBl19Xlxo3C2za2kgWTw5IFITAEw1rHHE4PhOSEcw0olcKJ4GSBTOcTW3HS20MKbephHfezG1PeOCNr3eF1MP5/k86I9ZfS1a80ZbuHMHXJEY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713822403; c=relaxed/simple;
	bh=Uyo/yaZ3LbMAAccaNuIjAy4pMm8JBULlodrmTeIiBVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8NtEGeptHXyNhGSEfnlkWWS5jsEpg8E77zha3LuZjNwPu/es0qVBIEEPjBHh45XNc5pggFaLegYsU+Lk5M6utQ2kY13JEDFp31uHksNs3vh9cYXRk7iWb/WW4R74K5b8iabNRDmT9TUxGIUbYFotyQtt+eEzgjQI7BPV1L3EYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QoIIGwAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF625C113CC;
	Mon, 22 Apr 2024 21:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713822402;
	bh=Uyo/yaZ3LbMAAccaNuIjAy4pMm8JBULlodrmTeIiBVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QoIIGwApW+RxsuCe7+HEI5q+dPoXaygTpAWmtSIUtUm+f5yWrNWJFP+On9Z5F2Ui8
	 3DBHJNGV5KDn6a1PLAU/oA5Km7d2n4tgNgSUBjBAsNqyAG5O9UcHRpzTswx1x3kV6b
	 sYEzfIbczmp4Sx5eo+Zq9pgXDeaO0rx3Tv8J0TAIxxvcWwm/FeH+OyidOdDuMmkDVt
	 3gn5PlEoVCXwC5Yc2hbUzmJuXkYFq7OZI/cUmMRagQXNjoKK/kHNsv9FhrFMuXohFI
	 c4cfSUipj9qrylNdZxEZHAFJz+MzcNXQZkekOAJuEI3H3qdMYu0OZXkBnSQkKK3AHP
	 lglWRYAKKbhYw==
Date: Mon, 22 Apr 2024 22:46:37 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Greg KH
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 helpdesk@kernel.org, "workflows@vger.kernel.org"
 <workflows@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Please create the email alias do-not-apply-to-stable@kernel.org
 -> /dev/null
Message-ID: <20240422224637.01bb3058@sal.lan>
In-Reply-To: <20240422-stoic-sawfly-of-protection-db8bfe@lemur>
References: <b452fd54-fdc6-47e4-8c26-6627f6b7eff3@leemhuis.info>
	<20240417-lively-zebu-of-tact-efc8f3@lemur>
	<e7318984-7ef4-48cd-aae4-1deda3d711a5@leemhuis.info>
	<2024041734-gleeful-freewill-b24b@gregkh>
	<d4853f43-2538-4a92-9ac4-aff5c7b0893e@leemhuis.info>
	<2024041830-karaoke-aspirate-df00@gregkh>
	<655ce2a3-eb04-4ade-999e-23fc5dc5fb3a@leemhuis.info>
	<20240422-stoic-sawfly-of-protection-db8bfe@lemur>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 22 Apr 2024 15:25:18 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> escreveu:

> On Mon, Apr 22, 2024 at 05:49:29PM +0200, Thorsten Leemhuis wrote:
> > @Greg, BTW: should this be stable+noautosel@kernel.org or have a 
> > 'vger.'  
> 
> No vger, just stable+whatever@kernel.org.
> 
> > in it, e.g. stable+noautosel@vger.kernel.org? I assume without 'vger.'
> > is fine, just wanted to be sure, as
> > Documentation/process/stable-kernel-rules.rst in all other cases
> > specifies stable@vger.kernel.org, so people are likely to get confused.
> > :-/ #sigh  
> 
> These serve two different purposes:
> 
> stable@kernel.org (goes into devnull)
> stable@vger.kernel.org (actual mailing list)
> 
> Confusion happens all the time, unfortunately.

Yeah, I did already used stable@kernel.org a few times in the
past. 

IMO, the best would be either for stable to also accept it or for
kernel.org mail server to return an error message (only to the
submitter) warning about the invalid address, eventually with a
hint message pointing to the correct value.

> 
> Notably, even if someone uses stable+noautosel@vger.kernel.org, it won't 
> do anything terrible (it won't bounce, it'll just quietly go into 
> nowhere because that's not a valid expansion command).
> 
> -K
> 

