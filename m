Return-Path: <linux-kernel+bounces-64152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBA4853AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812551F28130
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4601F92C;
	Tue, 13 Feb 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UXy3zfYe"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2F51CD33;
	Tue, 13 Feb 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852034; cv=none; b=Nh/gAfFyB/jKNq854+OfDdviDsJOwyjlViKeq+VVWlm7UUf/itmpTTRVir532CFOusnvB1MoVdp3cx7ugIoXODlnFQH5DsU2CKwt3hkiaF3TZBEm2ISnMxEeh1npXeL+JVC3GtWQdNpsHStTKQNbJOCmMkGiQsJuHvclVEJbxfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852034; c=relaxed/simple;
	bh=bCBD7mPLAylg/6M3bBUD0Tc0oDZ4U8rgdh620O4x+0U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mT96NrmPmiZf0hWJU+wkP5xaopFVlqipmYb+cvZ/qw/p6K6tH7GA11lp/PpIDzC6C3McjP9kfzokVpnthj0h9r5J0zZiu+Hpb3+O7lZMmzMgFwRkZdk4gc4Sme0Zj/9Q0KaAHTtZuNGC8BgWBO+rduF1YNJ6jX5uJAnRLF+B/Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UXy3zfYe; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A34CF45ACA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707852031; bh=TJPwRgqvklzt+2lG0mVqS0xnQODHATZ076Sy/XkZG1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UXy3zfYetLJkznjxjfelUZOqJPk1DuPI/IDFFGrdQaJLAi3kg+vRGeEIiRYoaWUgs
	 pJFVHSRGsyuGEBlwjlq7am0t9sMQHJ5KgKY3dhe0XUVX1KIBRS1SO1JOeCyO7KyT/M
	 a3n5wcV2xZ7ybc4qmnH0wJ4YEIN7ctLl65IyymWF+KrKkcjI09eJXK0HcYujKw3nrs
	 5UEtvxzfs9f6/3BzHWg7VSZWTQmwUsKN6Uax3jGNi/ciw047cF+NRJPEpu09jAge11
	 Vpu0b6BQ0+4WHlqxzdjKCKQeSSfWyzgnZvOfCIHu6Gl9jUU4oNaWYMA8LjjF3DeWTb
	 R028Ober9z4Hg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A34CF45ACA;
	Tue, 13 Feb 2024 19:20:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, Sasha Levin
 <sashal@kernel.org>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
In-Reply-To: <2024021322-pumice-corny-eabc@gregkh>
References: <2024021314-unwelcome-shrill-690e@gregkh>
 <2024021322-pumice-corny-eabc@gregkh>
Date: Tue, 13 Feb 2024 12:20:30 -0700
Message-ID: <87sf1w41dt.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Feb 13, 2024 at 07:48:12PM +0100, Greg Kroah-Hartman wrote:
>> The Linux kernel project now has the ability to assign CVEs to fixed
>> issues, so document the process and how individual developers can get a
>> CVE if one is not automatically assigned for their fixes.
>> 
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> ---
>
> Jon, if you don't have any objections, I can just take this in my tree
> for the next -rc pull request I have for Linus with other driver-core
> type stuff.

Up to you - I probably have another 6.8 pull to do as well.  Happy
either way, if you want to push it:

Acked-by: Jonathan Corbet <corbet@lwn.net>

Thanks,

jon

