Return-Path: <linux-kernel+bounces-64827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F7D854352
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B6628CF38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D161170A;
	Wed, 14 Feb 2024 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2BImXe5d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E910A25;
	Wed, 14 Feb 2024 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894944; cv=none; b=nyjGa2qg4a9A4YSyFNxw6iLOIC6Bu191K9TmiH+TUJN085s6SPJd3HTbOoR/ugxuXcrx7kg5FnuH+Dwhud7L9VJYXH7q11KdpNOgHbthJcsowWktFKqo+rk+bFIN2aExS7oueepREQtVqlu68BmJEC1Ji7x2/Hi6ODwU1cUoolA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894944; c=relaxed/simple;
	bh=IIvvVsjR/hVM2f/NvgMQKuJJLg9nuLk9INfiWWzJeds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAUQ6c80IfsnG3Ym3gTbBfjOh72a7VL2o8Ui1bVOKmnxkCSmE/OoaGMsEgxDhub9L6cMDQnhYeFAAio/DJuryA5IEBiUax3SRRKVgH54Ow+XAVGv/SQ0JAXiJCdZOW3kuX3j2OBvSr6yXoRm/DZTKH9tgFCCi/nIshecA+UGKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2BImXe5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5392C433C7;
	Wed, 14 Feb 2024 07:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707894943;
	bh=IIvvVsjR/hVM2f/NvgMQKuJJLg9nuLk9INfiWWzJeds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2BImXe5dl2/K6e+ijgtbrCPUcncWRTVXd5Yy0EDHMH8DynfC3IJCHLXOwwUIVBBRC
	 PllI2aku/QHOG7Bfcs6S0etYBH1nx1gm9mxlQg7k9kh7fRr1sM1N2NcDSbqUgLdg9W
	 JzyuwZ6gCQ8xl/Z2d1I7Y/NQxIgAyHFNoXSCBHb4=
Date: Wed, 14 Feb 2024 08:15:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
Message-ID: <2024021450-giddy-garland-e499@gregkh>
References: <2024021314-unwelcome-shrill-690e@gregkh>
 <60d67476-5c56-4fa4-93cf-1eb8f5aa5953@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60d67476-5c56-4fa4-93cf-1eb8f5aa5953@infradead.org>

On Tue, Feb 13, 2024 at 11:56:42AM -0800, Randy Dunlap wrote:
> > +As part of the normal stable release process, kernel changes that are
> > +potentially security issues are identified by the developers responsible
> > +for CVE number assignments and have CVE numbers automatically assigned
> > +to them.  These assignments are published on the linux-cve mailing list
> 
>                                                     linux-cve-announce mailing list

Ah, good catch, you can see the "old" name for the list here, this is
due to this document being an older version, a symptom of "write it on
my workstation, sync to laptop, travel with laptop for 3+ weeks and make
changes based on meetings with CVE and others and then forget to sync
from laptop when arriving home".

Ugh :(

Thanks so much for the grammer fixes, they are much appreciated.  I'll
apply them and send out the latest version in a bit.

> > +No CVEs will be assigned for unfixed security issues in the Linux
> > +kernel, assignment will only happen after a fix is available as it can
> 
>    kernel;
> 
> > +be properly tracked that way by the git commit id of the original fix.

One of my goals in life is to never use a ';' in a sentence, and after
writing 2 books without them, I thought I achieve that pretty well as I
never seem to remember when they are to be used or not.  But I'll trust
you on this and use it here.

thanks again for the review, much appreciated.

greg k-h

