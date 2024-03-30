Return-Path: <linux-kernel+bounces-125577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 626EB8928F3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 03:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C970B283749
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 02:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920506FBE;
	Sat, 30 Mar 2024 02:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1hXSTLc5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D517A5680
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711767363; cv=none; b=QQNH0HVITl8J54OvDKQjHN+wW4M/YHM0kRoLPGj1FNDtDWovywfeBqqV1QFsPqKXBQHE53vkKIcPWo8ivSKwuUXnetDhUUgQiZtX0VF3BNB7ibpWau6S6X0e2hqz1Qu4Rvls1FxIs0KL48kTAn8vGaUCGHNbYj+WV8GhbTy0jQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711767363; c=relaxed/simple;
	bh=rwo876/D3BbCLDz9AnxgxEK63GG3r3tn2mTNlDvq1c4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Gk1mnuN1IhAQtkHva3tiPeuipEL9/ZXGuflVehoXvMkAjyqeOSlIdL64KOyrJUXwpY/w+V+2cKOXp4OEnA0AAYrMwWVUh1L05L7nmU9W2sPcil/7UQU2lO04/s8PqpK7BRpVtnGV6PiTb37eE7yyzcfwcwxdim0drOKzuzw7rH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1hXSTLc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A25C433C7;
	Sat, 30 Mar 2024 02:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711767363;
	bh=rwo876/D3BbCLDz9AnxgxEK63GG3r3tn2mTNlDvq1c4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1hXSTLc5Wq09D8Saa2jjpH5D6UZTd4uM6lId4vPv/LHHq/Ywd3cLaYRw4AoI4XZ1+
	 Kuoy/zoylLwNidJxwUS4fHr/aIBFpSSbtoGraBlBeaH9Icf/Wyizu/rh8/Kk0MamfL
	 PaYhu37gDAyF7cVXdZeVxE87yKOXVEye232eBKMM=
Date: Fri, 29 Mar 2024 19:56:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>, Lasse Collin
 <lasse.collin@tukaani.org>, Jia Tan <jiat0218@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [tech-board] [PATCH 00/11] xz: Updates to license, filters, and
 compression options
Message-Id: <20240329195602.382cb1c99bb70e3d8c6093ae@linux-foundation.org>
In-Reply-To: <87h6go3go2.fsf@meer.lwn.net>
References: <20240320183846.19475-1-lasse.collin@tukaani.org>
	<202403291221.124220E0F4@keescook>
	<87h6go3go2.fsf@meer.lwn.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 14:51:41 -0600 Jonathan Corbet <corbet@lwn.net> wrote:

> > Andrew (and anyone else), please do not take this code right now.
> >
> > Until the backdooring of upstream xz[1] is fully understood, we should not
> > accept any code from Jia Tan, Lasse Collin, or any other folks associated
> > with tukaani.org. It appears the domain, or at least credentials
> > associated with Jia Tan, have been used to create an obfuscated ssh
> > server backdoor via the xz upstream releases since at least 5.6.0.
> > Without extensive analysis, we should not take any associated code.
> > It may be worth doing some retrospective analysis of past contributions
> > as well...
> >
> > Lasse, are you able to comment about what is going on here?
> 
> FWIW, it looks like this series has been in linux-next for a few days.
> Maybe it needs to come out, for now at least?

Yes, I have removed that series.

