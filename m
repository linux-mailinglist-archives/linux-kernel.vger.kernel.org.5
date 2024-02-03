Return-Path: <linux-kernel+bounces-50806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271A847E17
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60E91F22451
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB43D1C02;
	Sat,  3 Feb 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="azwQ2XMI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC2E7468;
	Sat,  3 Feb 2024 01:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706923005; cv=none; b=sLQCi7EwcqiXw3nB/U3JonFHLRXEOC3Fz7Y9HXUaYInGHLmPAxCZut9w1f+YWeit+7dmuYaiiGYR7HlMLH9c/OiTsBTIs0DFYc9iCWfy0DZ37nDfBhGFBV0R/pxYXYqirSJQymaeGCx6RxLxFfzrTpxBzcApOukHK333H8h0MSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706923005; c=relaxed/simple;
	bh=WBi5fjeQLzqu5VweIAi77aBO8Co5njeJwDmQl2Or8js=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=bSuTj+/spsozGffM/5JWPNBLzIPfp1F2pUCWo3VVFYUy0Wb+WzidCUzvsAnFf1jVkeIZJk+yPP3b2wx7KeVXEB0jA7np18WsCWjnsqjQi65F+OvPIwBukaZZhGuxwFM7NZ0TWQH8lNvJv8/9055JTbECu4ikX0NTJngkq9dsEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=azwQ2XMI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=qyXe97uWehxWlU06p4SzFgk45X8VJ8tYlQZAOutFjWg=; b=azwQ2XMIArUw1hOOO06YQT9IDk
	vqBiqUqdsCTte5D5uUiDH3aB4LOqfjAM9hwrqSCig5hJi2LQd6oN9IYhzzfWKpBLF4LInpI3AO9eo
	PCVSxSKxTMUMDaL6MdUvGRJtiM/PZcT5/G92JksaqMoY2JvMc9DChb9csp4zJgWu8bxuvTAWBeSYp
	aGzUIXRu31BX4Yjbu5iWquaXOOHvhw5y53FIC7RJt6U/CkQAFeA7u8xVTXb5Ll2OFYpodvmTpBo6I
	Mi9znn9XoOcyF4/l8CGiDluPPWkpueaQCERE+s/b44cRqWSpw7MG5DKvW8hSvoZ/RrW8ss3HfEkAH
	S6yr2g3Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rW4eA-0000000E6Jj-0UOb;
	Sat, 03 Feb 2024 01:16:42 +0000
Message-ID: <881d47bf-5f5d-49d6-9502-3b22899eb253@infradead.org>
Date: Fri, 2 Feb 2024 17:16:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_?=
 =?UTF-8?Q?what_led_to_the_regression_of_outgoing_network_speed_and_each_tim?=
 =?UTF-8?Q?e_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c75849406?=
 =?UTF-8?Q?c?=
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 Network Development <netdev@vger.kernel.org>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <43a769dd-aa09-4da3-a226-ecef98f32e0f@infradead.org>
In-Reply-To: <43a769dd-aa09-4da3-a226-ecef98f32e0f@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[correct the netdev mailing list address]


On 2/2/24 17:15, Randy Dunlap wrote:
> Hi,
> 
> On 2/2/24 17:02, Mikhail Gavrilov wrote:
>> Hi,
>> I'm trying to find the first bad commit that led to a decreased
>> network outgoing speed.
>> And every time I come to a huge merge [Merge tag 'usb-6.8-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb]
>> I have already triple-checked all my answers and speed measurements.
>> I don't understand where I'm making a mistake.
>>
>> Let's try to figure it out together.
>>
>> Input data:
>> Two computers connected 1Gbps link.
>> Both have the same hardware.
>> Network: RTL8125 2.5GbE Controller (rev 05)
>>
>> When I copy files from one computer to another and kernel snapshot
>> builded from commit 296455ade1fd I have 97-110MB/sec which is almost
>> max speed of 1Gbps link.
>> When I move to commit 9d1694dc91ce I have only 66-70MB/sec which is
>> significantly slower.
>>
>> I bisected the issue by measuring network speed on each step.
>> I save all results to file [1]
>>
>> [1] file is attached as a zip archive.
>>
>> # first bad commit: [8c94ccc7cd691472461448f98e2372c75849406c] Merge
>> tag 'usb-6.8-rc1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> 
> a. Do you clean the object files between each test run?
> or at least clean net/* and drivers/net/ethernet/* ?
> 
> b. I am far from a git expert, but in the bisects that I have
> done, after each test run, I just say
> $ git bisect good
> or
> $ git bisect bad
> 
> It looks like you are typing
> $ git bisect [good | bad] hashID
> 
> Is that correct?
> 
> Anyway, I am interested in your outcome just to learn
> how to handle this problem.
> 
> Good luck.
> 

-- 
#Randy

