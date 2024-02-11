Return-Path: <linux-kernel+bounces-60840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56806850A10
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9511C20E88
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A8A5B67B;
	Sun, 11 Feb 2024 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cLw3Z9jq"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85E144C9E
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666097; cv=none; b=XyKfL46BbWJwPqDpHfEU2NiUtjw9/WG/+KXTKBDUJwRH/7tksqFDzF3jeDQJzYXeXvDRDgmiZDs5v/pQdjYOj5toPFsEuIrSeFJBrwcY2u37sMNMjj5o+hOxKXwpjGXmU6uxC87ls9Gh53WkA91Qlm138/Ll3cmHnelT/pJz5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666097; c=relaxed/simple;
	bh=nF+C2Wmo+HoCSViqCFxLWaM/5OmHs22JTBYSU3sawpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7gWO9Z3lIUi2mlH4bYD0OTPW+NgTjmgW4djWKhKL/dfc30mqes6H54UZZbBObKlPgHQpaYfhxzOXq2RVAmZuogqKzo3s6kyF9ZlQbuuC0ccURl4o8ZqfTNImcLW4CtFreyJ+Ro+4ay7dmdwU+1PVEQKupxqPvkynZQh2cBitTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cLw3Z9jq; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707666086; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Aw4Jj3qtUe+zeWB3BpSnQaMW9sQiXys3qy4Y4qroNJA=;
	b=cLw3Z9jqdIjfsoe+ifO94bPHxX22Zbmg0KIQg1nlAhxf9xMOnZg2qDEMYjVq0kQir3GI5xn8r1rzjFRhtvUTk6z4NEmmZg4TzZvPKXFdvx5VD1TnzlWaHd/WPxI31xA7RiVFPPhbUCIU/PQPdJDJj2xriWAb+0T1v03+WOp7jE8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W0QTTMQ_1707666083;
Received: from 192.168.0.104(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W0QTTMQ_1707666083)
          by smtp.aliyun-inc.com;
          Sun, 11 Feb 2024 23:41:25 +0800
Message-ID: <05563a26-9c3f-4a3b-ade6-c417feca70e6@linux.alibaba.com>
Date: Sun, 11 Feb 2024 23:41:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 2/2] watchdog/softlockup: report the most frequent
 interrupts
Content-Language: en-US
To: Doug Anderson <dianders@chromium.org>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com,
 liusong@linux.alibaba.com, linux-kernel@vger.kernel.org,
 yaoma@linux.alibaba.com
References: <20240208125426.70511-1-yaoma@linux.alibaba.com>
 <20240208125426.70511-3-yaoma@linux.alibaba.com>
 <CAD=FV=UP_G3Rswi_HePkgmcniADKhkoP51=H=PxGKbdegEfUgg@mail.gmail.com>
From: Bitao Hu <yaoma@linux.alibaba.com>
In-Reply-To: <CAD=FV=UP_G3Rswi_HePkgmcniADKhkoP51=H=PxGKbdegEfUgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/9 00:03, Doug Anderson wrote:
> Hi,
> 
> On Thu, Feb 8, 2024 at 4:54 AM Bitao Hu <yaoma@linux.alibaba.com> wrote:
>>
>> +static void start_counting_irqs(void)
>> +{
>> +       int i;
>> +       int local_nr_irqs;
>> +       struct irq_desc *desc;
>> +       u32 *counts = __this_cpu_read(hardirq_counts);
>> +
>> +       if (!counts) {
>> +               /*
>> +                * nr_irqs has the potential to grow at runtime. We should read
>> +                * it and store locally to avoid array out-of-bounds access.
>> +                */
>> +               local_nr_irqs = READ_ONCE(nr_irqs);
> 
> nit: I don't think the READ_ONCE() is actually needed above. All that
> matters is that you're consistently using the same local variable
> ("local_nr_irqs") for allocating the array, looping, and then storing.
> No matter what optimizations might be happening and what else might be
> happening on other CPUs, once you put it in a local variable the
> compiler _must_ keep it consistent.
Oh, yes, READ_ONCE() is not necessary here.
> 
> That being said, I don't think it really matters, so I'm not sure it's
> worth spinning your series just for that.
> 
> In any case, this patch looks good to me now. Thanks!
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

