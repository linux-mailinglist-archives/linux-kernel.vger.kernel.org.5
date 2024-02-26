Return-Path: <linux-kernel+bounces-80387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554B8667A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72F91F21855
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF31D53C;
	Mon, 26 Feb 2024 01:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUJE5BP2"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA33D2F0;
	Mon, 26 Feb 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708912204; cv=none; b=DZ8iwwUyFrxlPHkwu0cBLhfp+RxRrl3EEGyypOb4Wm9Q3an2Y47sKIaUuWU6pY55rZ2w6YZdn4D6dfsPfBbz1jB37NZa3jcYvhhDVnKjRIUBO8bmtkfqg7I0jsDH4N9+gs3nr1SiBDYwlpB4APVMCiydmfRBYqdiaEOw7/DwRE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708912204; c=relaxed/simple;
	bh=riJ/GsyB2kHXSe5xGEE9x/odTHS3y7VkDnqzOo3vTE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+c83NjJhz7lpVenLzQevdMzeYk0ycdn1dd1H/oJngqzxydUZ74L8ve5At15VpS/5OXV3Y5uCWCKhDM1mMa0gCT7KVPaulI9ro+KJt0XCM++Vlkbj1V2bVb0qVRtyu8DTfwbWrlfNkba9VlogKxp9o/vLHyicrruiR5aXMXn4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VUJE5BP2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5jVHeEn8AsDcLaezQpnELxCv34JvUs44XBdvMVQ8MaY=; b=VUJE5BP2nMCYcXO5P7OMxAEKPd
	yl/MU8a7oiLhuezoHljTZQS5PMBzEgdhjC9zDBaPsZQuVgeQK/kqXTgZizTMfyzqoHsvh+fqLn/Gr
	2I7xNZmGSXm+JdQ5XsCulJplKjIDLRym4e014ayW6u1X53mboKkShn2yJkgKp8qqEZyp5aqePFs6X
	CoxwXif58jo6wNA5fWVyWH95k5aQ7cM1Q/VQZ6Zplz9EAe+9MyLc4gG4nemi+iEL/0AmhDUVJNazs
	NZ2V2rJBEqp6Sac6E+C2RBTMeYNvBxVgEQs+LPWH2rNvpQj2Z+8H6p2T3IMixSxv3SEGl0ObDYxOx
	Ex4wfhoQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reQ80-0000000G6qS-3zJd;
	Mon, 26 Feb 2024 01:50:01 +0000
Message-ID: <0b5edafc-ac6c-4ef0-8bc3-a2979f30a9d9@infradead.org>
Date: Sun, 25 Feb 2024 17:49:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] leds: mlxreg: fix a kernel-doc warning
Content-Language: en-US
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Vadim Pasternak <vadimp@nvidia.com>,
 Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
References: <20240221060153.3924-1-rdunlap@infradead.org>
 <20240223110100.GU10170@google.com> <20240223110147.GV10170@google.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240223110147.GV10170@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/23/24 03:01, Lee Jones wrote:
> On Fri, 23 Feb 2024, Lee Jones wrote:
> 
>> On Tue, 20 Feb 2024, Randy Dunlap wrote:
>>
>> Would you mind being more descriptive in your subject lines please?

Will do.

>> It's common for people (me included) to find subject lines a reliable
>> way to search through Git history and these types of descriptions are
>> likely to cause duplication.
> 
> Also if you push them in a set, they're easier to apply.

Do you mean a git tree or a patch series?
I'll be glad to change the 3 patches to a patch series.

Thanks.
-- 
#Randy

