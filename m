Return-Path: <linux-kernel+bounces-79773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BD886267D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221D7282967
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D40481DB;
	Sat, 24 Feb 2024 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gkurGxvr"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD0481AA;
	Sat, 24 Feb 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797081; cv=none; b=hN6buPo9+ARF0z76kxMFD8uGhKKg1U3ax/rMsdTsM5U5oV+WWEwj0ccf4Cnn654RGz5k67oR/RmAm1W1n2KNzveIFdWYOzGWWKUDy//ap5LQ1d5+QEeqardIBwAyTzSbAr7m3V0WefFLieD0tYW5t5mylR+ukQ5gzQkbK1rYewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797081; c=relaxed/simple;
	bh=Gmi4gT9FcIo7etOk4hFwbEDPYNbk4flm2ABlzQlc2Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ondnNsH5c2lYSQ4RmYoNtf2FOam17sXg/kwV9xSP7OPBXI/jRxyVceFkGx9harwwpCQv18LfysP0VFi+b8ObI6tBrCs0xgFD4PG6SLT1fqIKS20MqggBMY0zQeh4Qzizj3zfdGJCkUJ4ulSSPzWF72LMui7vyI4jItYPYwUJqMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gkurGxvr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZlWOXGsz6mtfbYnmfMG7yZRn5419GRR7ClVn8QWIxY0=; b=gkurGxvrlIgWCdat2QGa1pkFM1
	hahgqQ6aUjLPPL1nYRjYcQOOSJ00cArzE30vvhX4j2JigWJYZRMTIREVuAn9CvaFCQRw7pDnr7n/y
	LBcFlnomJp5lJtUXbhAtrDM1FHfX8cClrax9FomZxAuopYRy7LpC/wVYEN5BKUAkniwyFiFhesyuA
	IYnn27sPE4WR6lB6ktipxxSzv65Lh1wwRnZ2J3lmNDTdewKKd+3o7jJ+rm1768/W0ye2MXNHI0d9s
	q+RReXBLg6b8BsyxKxkPe+dcaCNnhc1L2z+E0HhlpQltPhMmon3XlIAj5LO3TqAYdnYpsB1QaosYV
	P1dUEHMQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwBB-0000000DN79-47lE;
	Sat, 24 Feb 2024 17:51:18 +0000
Message-ID: <c2793745-49b2-4515-b106-d3f0d39b274f@infradead.org>
Date: Sat, 24 Feb 2024 09:51:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: parisc: kernel/cpu.c:3110:9: error: expected identifier or '('
 before '=' token
Content-Language: en-US
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 linux-parisc <linux-parisc@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Alexey Dobriyan <adobriyan@gmail.com>
References: <CA+G9fYvSsq8tALGihWXOvJ-0qJ0iiDARmE4q28g0w9gOh5ZeOA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CA+G9fYvSsq8tALGihWXOvJ-0qJ0iiDARmE4q28g0w9gOh5ZeOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[add Alexey]


On 2/23/24 01:18, Naresh Kamboju wrote:
> [ Please ignore this email if it is already reported ]
> 
> The parisc builds failed on Linux next tag next-20240220..next-20240223.
> First build failures noticed on tag next-20240220.
> 
> parisc:
>     defconfig: gcc-11 - Failed
>     allnoconfig: gcc-11 - Failed
>     tinyconfig: gcc-11 - Failed
> 
> kernel/cpu.c:3110:9: error: expected identifier or '(' before '=' token
>  3110 |         = {CPU_BITS_ALL};
>       |         ^

commit da92df490eea
Author: Alexey Dobriyan <adobriyan@gmail.com>
Date:   Mon Feb 5 13:01:19 2024 +0300

    cpu: Mark cpu_possible_mask as __ro_after_init

inserts a ';' here:

 #ifdef CONFIG_INIT_ALL_POSSIBLE
-struct cpumask __cpu_possible_mask __read_mostly
+struct cpumask __cpu_possible_mask __ro_after_init;
        = {CPU_BITS_ALL};
 #else


> make[4]: *** [scripts/Makefile.build:244: kernel/cpu.o] Error 1
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Steps to reproduce:
>  $ tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
> --kconfig defconfig
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22811934/suite/build/test/gcc-11-defconfig/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22811934/suite/build/test/gcc-11-defconfig/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cl8psPmccoERtfX4SrhL0yxD0F/
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

-- 
#Randy

