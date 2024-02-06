Return-Path: <linux-kernel+bounces-54768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DE584B372
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0476F283614
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5212EBEE;
	Tue,  6 Feb 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsryKiel"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63812E1DD;
	Tue,  6 Feb 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218943; cv=none; b=QhuHb46Rz+ymEpIsBWzsdzoWSSF/6bfSUmoHx85T+21ISqgwHHy4OJwBrGYBq6k6hxbPaaoXeMv5kCJ9OZq22bYNZ/aYq/X7Dbu2ru53hNWL6yjrORGbE2KzF/MxQKnk2xCudHG80ihYzgV/dARMNsAJMk/J2EhO870acZZClfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218943; c=relaxed/simple;
	bh=xItSGKOsHY3nXC2qGy9xvtt+bnUbZopMnd876K04tjk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KjOpcMZYTjX4k9ug96m5A1daqv5Y+YTkNnSqI7+AHOh/0F6TKhWAUho5diFeBtkH42BQ9jqZLNbXflTykdRFEXj4BOCpbgHuAReHphbvHkAud8a4BtzcX8D55V6T3kKQbAbiI+RQEVykEuXYskuySFS5WmViXm0l4D5DZXDOoNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsryKiel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18D0C433C7;
	Tue,  6 Feb 2024 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707218942;
	bh=xItSGKOsHY3nXC2qGy9xvtt+bnUbZopMnd876K04tjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EsryKielTwcYBcVxuAxMAD0zvVmbPIbLkTrIBNpyeEXJDILMUGxe5VwThjhAPGnyO
	 rLKJuiVoAMk877bcSrF8uDICB52XvtgnldywkMDYIUPLZfloZfAi3SBNlqPkVA5eMU
	 rtW7cjWZGmSUlCxcZT3OUAe1pwiQ1NEcz1OoSMpGOOP/MQVUe9ovK2gd20aO9bMxUc
	 7F6rVhcCMrxY0Lj0hbNT1tJTo6qegUW6e2CN95Dy8UeQd1tfvVavKRMi3A2Rafq7dY
	 lxatORJk8dJTp3fusXqMAzr6uJHu5gTp95RSwtKKAotz7xRo64bafcCmGPZI/JkC+R
	 4KjRAVWhH6ezw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Feb 2024 12:28:58 +0100
From: Michael Walle <mwalle@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics
 <intel-gfx@lists.freedesktop.org>, DRI <dri-devel@lists.freedesktop.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Inki Dae
 <inki.dae@samsung.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Michael Trimarchi
 <michael@amarulasolutions.com>, Robert Foss <rfoss@kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
In-Reply-To: <20240206120643.1d30764c@canb.auug.org.au>
References: <20240206115956.4570e9b1@canb.auug.org.au>
 <20240206120643.1d30764c@canb.auug.org.au>
Message-ID: <fe0b21360178348543e662e9d620af9c@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hi Stephen and all,

>> Today's linux-next merge of the drm-misc tree got a conflict in:
>> 
>>   drivers/gpu/drm/bridge/samsung-dsim.c
>> 
>> between commit:
>> 
>>   ff3d5d04db07 ("drm: bridge: samsung-dsim: Don't use 
>> FORCE_STOP_STATE")
>> 
>> from Linus' tree and commit:
>> 
>>   b2fe2292624a ("drm: bridge: samsung-dsim: enter display mode in the 
>> enable() callback")
>> 
>> from the drm-misc tree.
>> 
>> I fixed it up (see below, please check) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but 
>> any
>> non trivial conflicts should be mentioned to your upstream maintainer
>> when your tree is submitted for merging.  You may also want to 
>> consider
>> cooperating with the maintainer of the conflicting tree to minimise 
>> any
>> particularly complex conflicts.
> 
> I changed my mind and just used the latter version of this file.

Bug wise, this is the wrong solution. Because it will reintroduce the
faulty FORCE_STOP_STATE. Also keep in mind, my fixes commit is/was 
already
backported to the stable series.

See also the discussion at [1]. Unfortunately, there was no conculusion 
yet.
I think [2] is the proper resolution, at least for the commit 
b2fe2292624a
("drm: bridge: samsung-dsim: enter display mode in the enable() 
callback")
I'm not sure in what state the drm-misc tree is.

-michael

[1] 
https://lore.kernel.org/dri-devel/CAPM=9tytMB9frxNeD08hu1qsusY=wEE3bJOFmUgA1rSpabwDpg@mail.gmail.com/
[2] 
https://lore.kernel.org/dri-devel/31e1a38a1d012a32d6f7bc8372b6360e@kernel.org/

