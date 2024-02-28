Return-Path: <linux-kernel+bounces-85018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF086AF32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882332849EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED15C145B32;
	Wed, 28 Feb 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="t1Yhpauh"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2420313B29F;
	Wed, 28 Feb 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123437; cv=none; b=T9RbYD5yTaW6OBvjW4K5Ne+vMHi33pSGTY/NNhKbET1wMjX1GaE5cGe2WHazHtzkjGz5YcMUcFW5EWSNO+K88/Gql8xOC3Gi+sOtF51Kb0YtJW+HAkd6ZR1xS7XtBk74Sfs/OYUVk0G51LSVXkhPvimICYa3CXsfh16If0BkbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123437; c=relaxed/simple;
	bh=hoZQVrL5u/mtK2ujnFl7+qtwb0tilnz6ZexxD8yIOM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqaV/c4+cblX2K/e8ApyUgES4VGd+0JXIjsan1Adj6x4ZaZ4uNdZrPqaCLXawCeVQXjAqSHLuqNoKOi+79gv+CC0WJuEfeBBKy9NpY4UyIe4ybVLyHW9HB4WfOSu1+kVVspRS1gcm+Tik6lzGtuwE+95nqURSCUvVjgfIIOpn5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=t1Yhpauh; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1709123423;
	bh=d0komw+WC3ouQiMH5R2F20wMoA9nbMU09H8vLZRoHKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=t1Yhpauhd7IYU+OzJ0cT1fMkojCX1z/O6OLkLEAGCl+PHA71Dzfykw0ttZSJiuLli
	 rCHtoXx2XCjh9/kpSDyHD0oU4sSFFBTjhzEwz+yJ+thv2AxXOeYgM587qIe2q6x7Cp
	 Mdl/MhgxCtnTFNASbW+RP0HfDuY/fUDZbzSILfD8=
Received: from [IPV6:2409:8961:2a02:15df:f9d1:6130:b1bb:a122] ([2409:8961:2a02:15df:f9d1:6130:b1bb:a122])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 79222892; Wed, 28 Feb 2024 20:30:18 +0800
X-QQ-mid: xmsmtpt1709123418t6g9vcb96
Message-ID: <tencent_C8F359A66A8E9A390869923ABD8D19C1CF05@qq.com>
X-QQ-XMAILINFO: M91SeYiYjPckNqot5gOlsgfKOFhKrZmNn+gEfhCBD6uELKtcpJmxXfIFZ+rhhb
	 nDdIRAfYFRJ5xnYrOT0JVi4z0YbVS1ufuib4+i729ZwJVXtnaoWAX/kecbzQ6yZlv1aPsPd7hbCY
	 pGqR3drZMZt+UoJa87P/MFywwqC+Dtte+l6lvjx9/OEyqOscbETk5mAbkFbEW0P3EFTL3QGm0OKR
	 BW2v+L2vrcpsQBqKaLul1zGXbEc3Rx2+OcJxHyVYBo5H/MHAqlDLe0BRT8I0oJCQV0g4TRsYgUFf
	 dAcCFjn12uJ5CScWOMdvCjQVFXHMfWiH9Heib+/GvZM1owWxe1iNjk62Mxf4dMbZoWiFK5jK0XgG
	 wzTsEV09r3cmyTE7UVtvdCx+eng/dfUJd5o2yzMSxZcgmpxEtHvL+OOW4awRGRpua/E02i1z9oZA
	 2HvMDTP6Q4m81TUYb0iSsWYkU9vU8sGrjTHKLA3tyzC5NSGkgT8ftLTKsbakxHCaBXISrWLhwbaU
	 ugeaRZ8s4Yxkj+okUkK0UFYAi30hNQ5Ryr0A6C1CYw9E33U9wtudvhqUm5P8ownr+nWaIuDG5TBy
	 Uu7W1DwTZqmZ5SXZpR+/5yeyMfQzN9/Y4leY6ec5V6XCQe2IxIVsc0s9wTgFBnqEPSwzLvLY59Mw
	 z5szSZnqD2UCqXFvZQz3hCCK25wfiEGs9sU2raOT77epCgXl8QnwOWFAUkpWkdQ/VDh7azrrNJ0n
	 f81Skd2SRYNxPJQHUBe6LqefhRH9QjhCLhkCd42CO9uDaNh4mDBFFY8ZfQUdRiEEc7euSHZ1nWuh
	 Kmu7a+DPC2WL/1vqUkGZ+MqBx23/Ay8AIXEuuwF1vo9PSe93KUJQiYS0IDNZv7BsyJbSUnAeXHvF
	 hZ30BDmTcr4KdgV+5qqmAukcWPvfnbmCTl6pX8reHG4nF6vLDlRS1+/1dpJU98okNoSKLt8XcudJ
	 WFYPqI8xV/lYXP8E/IfI5EnoNaza8jGEVkVLjZGNauYbWRDlCWMPtJHzGlEsXldv+C3wITwYQeaw
	 XsJrsCLc9Y6KZMaui/Csgg4YsWBh6+fkS5eKkszFwoOnLJ++Aqf5rL+8KnDYCrmeNzq+4LNlDMCr
	 kFov5bApK3+NrP2lH+SupGscb/XA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-OQ-MSGID: <8e960a57-cbc9-c30e-43f8-90779865373a@foxmail.com>
Date: Wed, 28 Feb 2024 20:30:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/8] introduce sysctl SYSCTL_U8_MAX and
 SYSCTL_LONG_S32_MAX
To: Jakub Kicinski <kuba@kernel.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
 Joel Granados <j.granados@samsung.com>,
 Christian Brauner <brauner@kernel.org>, davem@davemloft.net,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_275FF7F351D515B570D0F82447BA30F3AA06@qq.com>
 <20240226072814.1d9ab85f@kernel.org>
Content-Language: en-US
From: Wen Yang <wenyang.linux@foxmail.com>
In-Reply-To: <20240226072814.1d9ab85f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/2/26 23:28, Jakub Kicinski wrote:
> You provide no data on how big the reduction is.
> Eric's suggestion to encode the values directly in the table entry
> sounds great, please invest your time in that, instead of half measures.


Thanks for your comments. Well, we are making modifications according to 
Eric's suggestions, and the RFC patch series will be sent within a few 
weeks.

--
Best wishes,
Wen


