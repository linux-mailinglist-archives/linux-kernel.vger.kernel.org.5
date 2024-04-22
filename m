Return-Path: <linux-kernel+bounces-153419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC798ACDE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C3C28572D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B962014EC6E;
	Mon, 22 Apr 2024 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TtRAMlly"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71804145342;
	Mon, 22 Apr 2024 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791520; cv=none; b=iIk6XmJXd5t+PltghQqs38JEf148SgYhL4FZnLJqAO9Mu99P6nP5QUEv8eiyVHoqpwZNC0PnQ8jLyAzx/1Mo8msBEZur3/7vIzk3AhtjyUR9IBGK7hJxrwKEJfeh0cbgmgrgpSmxjeAtga1nUQ1AKEUp2u8Sd/fbSHubzqqewbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791520; c=relaxed/simple;
	bh=XOe3rO+V4OSg40SEQ1ztLJzq8dL9itVN6gTILUOr+sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3CKynZILXiJQtbrnyKst2xa+w1/JGCi6bE3LvMO0X+ETpsyksiTsolKCjM3v9iREiaGeRsEXUWcBWSCHPNzLRp/VWhEy8yOp0ApET+G2rB8fcpO7yy5H9fQCuoVld3X/HWCSSIskVUz0eLKQBoI8VQYeW8ygo1dGs2WvIcbwfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TtRAMlly; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VNQd26fR4z680f;
	Mon, 22 Apr 2024 15:11:50 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VNQd237yKz67yS;
	Mon, 22 Apr 2024 15:11:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1713791510;
	bh=iD3Put1A9IYrX60+JD9GoM52tBmlJ+dyLBFknV0tTPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TtRAMllyiIjnlMnB6dqO3KD6WcIQO5NTJkh6TKPLjrT/J/9ZcPM3F6bFOTThF33Si
	 UdX/+xkzQfUDpCq7x24jv2whpot9Bj+ZJepyWqsq1xUb2RsvSlaRytJqDYP6aNEE3u
	 Me8YSRtuU9Lnoyfj4tH9eQMca7zsZpwGrIvqf8n8=
Message-ID: <509e2bb2-54c2-4156-9bb8-4541c87ea2f2@gaisler.com>
Date: Mon, 22 Apr 2024 15:11:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] sparc64: Fix CPU online bug and warning fixes
To: Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
 Atish Patra <atish.patra@oracle.com>, stable@vger.kernel.org,
 Bob Picco <bob.picco@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
 <4e57929b-1539-4a25-ab05-a2a9e04ecc1d@app.fastmail.com>
 <20240330183937.GA191882@ravnborg.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240330183937.GA191882@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-03-30 19:39, Sam Ravnborg wrote:
> Hi Arnd,
> 
> On Sat, Mar 30, 2024 at 11:19:37AM +0100, Arnd Bergmann wrote:
>> On Sat, Mar 30, 2024, at 10:57, Sam Ravnborg via B4 Relay wrote:
>>> Nick Bowler reported that sparc64 failed to bring all his CPU's online,
>>> and that turned out to be an easy fix.
>>>
>>> The sparc64 build was rather noisy with a lot of warnings which had
>>> irritated me enough to go ahead and fix them.
>>> With this set of patches my arch/sparc/ is almost warning free for
>>> all{no,yes,mod}config + defconfig builds.
>>
>> Patches 1-9 look good to me,
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Thanks!

Picking up patches 1-8 to my for-next with

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

and, having run it only on single core qemu, patch 9 with

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

>>
>>> There is one warning about "clone3 not implemented", which I have ignored.
>>>
>>> The warning fixes hides the fact that sparc64 is not yet y2038 prepared,
>>> and it would be preferable if someone knowledgeable would fix this
>>> poperly.
>>
>> The clone3 bug has been around for ages, it's probably not even that
>> hard to fix and just needs a little bit of testing.
> I looked briefly and it involves a better understanding of the window
> register manipulation than what I have today.
> 
>>
>> If anyone wants to work on the time64 support for the vdso, I can
>> explain the details for how it's done.
>
> I am happy to type the patches but need to rely on others for testing.
> Anything to help me get started would be super.

I'm not picking up patch 10 at the moment, but it would be really nice
to get allmodconfig builds to not fail due to prototype Werrors.

Thanks,
Andreas

