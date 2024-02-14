Return-Path: <linux-kernel+bounces-65578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F8854EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183971F25013
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD3D60B9B;
	Wed, 14 Feb 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EDQ4KWpZ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340E60864;
	Wed, 14 Feb 2024 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929061; cv=none; b=uNsikm8bq5OZK3U9Gy8lTanLGioGxEl0v0mDQTvwsAOoNkBr7iByQKw98LDbyp0Fs+4s5RMGbrZEC2a2wjozB+qFW2IIYUoA05nYTCHQbfUyLydrUNTzkDeEyqotO/6RYFRbWjGsqRBvBDkXju9By9ZGlULQ+Jqoi0dP3fieLt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929061; c=relaxed/simple;
	bh=sfJuXclO1Ov9A69m5w+ZOgsfMXgKljyna2t9SiCtuw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHWbaT/WoRXUQcArzu7MMjOBqcoV+wImBK2n1kcWyMMqNFBGoNAwF4Iwtl+5fMezNP5I4pbffTUiBp+3rXwDjBnPJA2B1rPFnSHvqze1BDe1HU2j9fjbqk9aFbLAh4PObqltdu+YI1pKg1qyJtTCNd2fRX5X5whzwo0WP0Gt3s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EDQ4KWpZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hftmzppcjHlorwgYJRp+lM988Qc6AOkd1AYuK4Aj3w0=; b=EDQ4KWpZCjyQrQSpbU0qS+hfgt
	U4P5K0QWOTlNO/Gy8Ld5ua4ISXBQE4e2dzeLr7QZiWq5AccxD+wDdQKRMrq6mg9JUIKSTXqNfmS7w
	6cKSKmJNrDBI9JIt8AlH2G8yNuwDnTmwMBbhnOqs+U7mVYByFqFrtNmnpaNs47cSWotVHv99u/m+m
	P5h/bPloUGfsWPo9+SIPBrLJWDvXf+ViYExv7xpbpli68n8XxtIaRcjMbDIPznKFXmqZ/mPHD28f6
	ukZssGWyaVq91PablLgmHy6YRoqm4GIyw4g0tVH/8IcaFt4Y5RvY0UDDTmdr5FhLzqQuMs+FoXtfs
	kXvpKg+A==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raIMr-0000000Da5u-48Th;
	Wed, 14 Feb 2024 16:44:18 +0000
Message-ID: <768355d0-df1e-48dd-b7fd-9ed34f7a4b7c@infradead.org>
Date: Wed, 14 Feb 2024 08:44:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Document the Linux Kernel CVE process
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org,
 Sasha Levin <sashal@kernel.org>, Lee Jones <lee@kernel.org>
References: <2024021314-unwelcome-shrill-690e@gregkh>
 <60d67476-5c56-4fa4-93cf-1eb8f5aa5953@infradead.org>
 <2024021450-giddy-garland-e499@gregkh>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2024021450-giddy-garland-e499@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/24 23:15, Greg Kroah-Hartman wrote:
> On Tue, Feb 13, 2024 at 11:56:42AM -0800, Randy Dunlap wrote:
>>> +As part of the normal stable release process, kernel changes that are
>>> +potentially security issues are identified by the developers responsible
>>> +for CVE number assignments and have CVE numbers automatically assigned
>>> +to them.  These assignments are published on the linux-cve mailing list
>>
>>                                                     linux-cve-announce mailing list
> 
> Ah, good catch, you can see the "old" name for the list here, this is
> due to this document being an older version, a symptom of "write it on
> my workstation, sync to laptop, travel with laptop for 3+ weeks and make
> changes based on meetings with CVE and others and then forget to sync
> from laptop when arriving home".
> 
> Ugh :(
> 
> Thanks so much for the grammer fixes, they are much appreciated.  I'll
> apply them and send out the latest version in a bit.
> 
>>> +No CVEs will be assigned for unfixed security issues in the Linux
>>> +kernel, assignment will only happen after a fix is available as it can
>>
>>    kernel;
>>
>>> +be properly tracked that way by the git commit id of the original fix.
> 
> One of my goals in life is to never use a ';' in a sentence, and after
> writing 2 books without them, I thought I achieve that pretty well as I
> never seem to remember when they are to be used or not.  But I'll trust
> you on this and use it here.

For some reason kernel documentation has a plethora of run-on sentences. :(

Guess we need doclint.

-- 
#Randy

