Return-Path: <linux-kernel+bounces-130857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1C897E0A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA01C21803
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86C1208A5;
	Thu,  4 Apr 2024 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UmuW5q4R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731418AF4;
	Thu,  4 Apr 2024 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712202306; cv=none; b=lRyf8FIx9OWDoOLNTV1I96nZKDODD5ob5+BxZCrxVedfAGs7fT6y2fDqfMNz8ck/Dj6VCQDjtryWwbnysPFqvoLDn6X1MRTtOovp/CGV+5Y8e2qUtW34IChvjele5ONwop8PY4Bbe9ro9A8q09IURTt7rQqmX19kEk49ZrzFY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712202306; c=relaxed/simple;
	bh=Lspe0S+sq87Ovamj3k0UkWs5QefU1BVoJlT+JZlQSoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGOkS/7V6Y8N43yY7gr1iUv6Yxa/PN4B+77lSM0WJ5GssqhKmiNus7L9iO0zJtJudBA2RQat6+P3K6iIcAKlCp0IkQ7hn6Gm2FGwdN7yIU56tqu3Nqxj4hAbXHMONtsASWHpLIXK2UTfQ9qR1OZCVrCWuG1bxuqPElY1q5hVwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UmuW5q4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E531CC433F1;
	Thu,  4 Apr 2024 03:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712202305;
	bh=Lspe0S+sq87Ovamj3k0UkWs5QefU1BVoJlT+JZlQSoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UmuW5q4RA6owKENizAib+IWAOVsnRyR7L5LHQr0UqrC3O4xgBc5iF/oet2MxRV0NF
	 bVymJta98oJ66NfIBBBFtl5d3Yel0glERwX72HbB9gJZoCHPzB52uygK/Cd8yFlLHy
	 IoBEny0F6cNpDF3LXtjRzUVD6Ys5SuVLuxM+Cj2uh52IvEeZryCW60bAq61gczQke4
	 y+4ozAMp0JEl7FS8FI+nZ1BvmQyTJKwtrJoE+IWFgDJOAkFXETzyoqzeUR+UAKyO2n
	 iJeVx6pVKY9GXCQy85xj4To+ig3cnZ5WnbQIUYe9NvXLjMyCOeNRCPH/3k9Azgd+Tj
	 M5nfKSNkFGb2g==
Message-ID: <3423b438-62eb-4bb7-ace5-ded592a8d89b@kernel.org>
Date: Thu, 4 Apr 2024 12:45:02 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/34] sata: mv: drop unnecessary #ifdef checks
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 Saeed Bishara <saeed@ubuntu-saeed.il.marvell.com>
Cc: Ma Ke <make_ruc2021@163.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Sergey Shtylyov <s.shtylyov@omp.ru>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-31-arnd@kernel.org>
 <a1ca8aa3-d122-4ec9-b239-8180a02106e1@kernel.org>
 <78731619-58a3-406b-9112-5eb991bc6e7e@app.fastmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <78731619-58a3-406b-9112-5eb991bc6e7e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 17:50, Arnd Bergmann wrote:
> On Wed, Apr 3, 2024, at 10:32, Damien Le Moal wrote:
>> On 4/3/24 17:06, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Building with W=1 shows a warning for an unused variable when CONFIG_PCI
>>> is diabled:
>>>
>>> drivers/ata/sata_mv.c:790:35: error: unused variable 'mv_pci_tbl' [-Werror,-Wunused-const-variable]
>>> static const struct pci_device_id mv_pci_tbl[] = {
>>>
>>> Move the table into the same block that containsn the pci_driver
>>> definition.
>>>
>>> Fixes: 7bb3c5290ca0 ("sata_mv: Remove PCI dependency")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> The patch title is also not describing what the patch does.
>> Are you OK with changing that to:
>>
>> ata: sata_mv: Fix PCI device ID table declaration warning
>>
>> ?
> 
> Yes, please do, thanks!

Applied to for-6.9-fixes with discussed tweaks and removal of extra blanklines
pointed out by Andy. Thanks !

> 
> I had first tried to remove all the #ifdef checks and just
> rely on dead-code-elimination doing the same when
> pci_register_driver() is stubbed out and IS_ENABLED(CONFIG_OF)
> checks turn off the rest. Unfortunately, the include/linux/pci.h
> interfaces are not all stubbed out here and cause compile-time
> failures without CONFIG_PCI, so that didn't work out.
> 
>      Arnd

-- 
Damien Le Moal
Western Digital Research


