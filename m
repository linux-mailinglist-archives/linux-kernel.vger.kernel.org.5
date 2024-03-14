Return-Path: <linux-kernel+bounces-102697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E781F87B619
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D720C1C2161B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 01:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5F4C94;
	Thu, 14 Mar 2024 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XY81ZqTF"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACC4683;
	Thu, 14 Mar 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710379357; cv=none; b=L/eWyxbtkBacLb6h/5CPk1/7EjqePX5Me/iF5r8HA7Xj5VaOZls7mNHjWk8Br53GXY4/N+jhkTsUHygH3/6FEDdVTtLpodUWAJS20zB7sk9eNxcZWn+9spXtButFO9EP/TdDOHKUZoeu5GAeSDRQDPJzx8aIAmYGbJwhS8ls6PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710379357; c=relaxed/simple;
	bh=pAQkH+6DSDcb7CyxFZOp2uoilkQlP1D1yQ/yVjdP/fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vkto/7fkfI1veT1Ldl5hNc15psq1w8dpVOJtBpfBNagvPSYmYwBO97ihMHI7zCJbhY+SUqF1kv9D89FtLX6sNXsWsQYOvMXBUkeNYuOwNoq5zb9LfI4ok6IKoUT3RclUyPkcSunKRomihBV58alY7KGsKg/+Nl/X5K+aTBaWkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XY81ZqTF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690cffa8a0bso3556356d6.0;
        Wed, 13 Mar 2024 18:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710379354; x=1710984154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tTpJPpuoM2KgnH34jKTWoVcJvMq+ftI0Tp+y3kEoFg=;
        b=XY81ZqTFmLHSNHa7cBz+jDFeS2pPxJaZh3evei4rYFLtwAl3eMglfs/iJQrpdyvjTQ
         ohx/RswBXPJ+7lrqwZHZxvya2l6lHLOFqvzUynOezHoqL9T8mE3mXQtq88FbBIxD8sjP
         6VQRRk4tXo3bqTO90OnpuhSHIjQgLEdMM1tQFfvSiHnI069/h7EMxl+1s6I9AUOUYe+7
         SWEq88LuABvjVVKZFBdpMNuZYQZiJd3CVGm06CoDEuzUqsG5GGrH3WrtLfJbcGXehR4z
         ip7n3XVmBoPzf9ujq6jcYfXb742VnDsGnWRBPh90LfyjgW++0QPrJr417JrfnpZd503u
         nfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710379354; x=1710984154;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tTpJPpuoM2KgnH34jKTWoVcJvMq+ftI0Tp+y3kEoFg=;
        b=Z40M7ssSNhGSj6DFWxMW2cXkqyS6tvO7hFYxqoP46VCKp8hCULfQSPb0vUh+my7Y5I
         xhzx5Dq9Qwf08m0qAXAagdoyY8aHgQvkw5nB0NM1ZsrzlFf7oTGwex9rbRndRQEHM0Pj
         Bq96H0gF34T/4+xkv+clHT83f29t8aj49qWkOJlfoUsAOfp7Sq5uMlWKgAqkgfn/zXY5
         K68SxBKKQBmgB6RUdGifNj0fkxmP/HJUWUsLqIL7C/tC/hROWaY4rCfqxw4rmxfJypQe
         GIlF8e0onsaZ/fZEQlQ+adh+tbtTDW3sJ1IeSAZBM5tNp8rRI9kSAKgFHOILEFB74+5T
         tNpg==
X-Forwarded-Encrypted: i=1; AJvYcCUHzWG4SRYIDbQ1m8fqcg87/ZWaRVQY2rQ0PFfmAgWvFQDLuz0X6NXh/ccWtphE4VLa5xby7/Yc7XRfJBTdqIvbMLyK+Q1rd1XHVmbRp2zQ1H/yixWHcH7kpnnMluMfjnw1
X-Gm-Message-State: AOJu0YwcjT05/X3MHdmSh6/xXLpLuJnmsIgnTthQnP5yM+620gpHcWSW
	S0AQk9biSR5lX9yl59jYSyJjOFe0Lhvnq1zJisR7u/CxlrqL+UWi
X-Google-Smtp-Source: AGHT+IEYLAmZFX2XxFs4gOVqSnsnOPiM9kKIzm+VbHJXeySauJQhGYJuIviA0MVa/0O7S018IBLTnw==
X-Received: by 2002:ad4:408f:0:b0:690:cc97:94b2 with SMTP id l15-20020ad4408f000000b00690cc9794b2mr398443qvp.9.1710379354380;
        Wed, 13 Mar 2024 18:22:34 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id fv15-20020a056214240f00b0068f35e9e9a2sm267023qvb.8.2024.03.13.18.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 18:22:33 -0700 (PDT)
Message-ID: <7e02744b-f8de-4d97-a72a-10d33265c1cb@gmail.com>
Date: Wed, 13 Mar 2024 18:22:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
 tglx@linutronix.de, rcu@vger.kernel.org, neeraj.upadhyay@amd.com,
 urezki@gmail.com, qiang.zhang1211@gmail.com, frederic@kernel.org,
 bigeasy@linutronix.de, chenzhongjin@huawei.com, yangjihong1@huawei.com,
 rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfItZs756Bps2pFa@shell.armlinux.org.uk>
 <337ad5f0-bd1b-4dbf-a94b-681a21f0df45@gmail.com>
 <CAHk-=widRkpp1NqpDWoOv7stHcjcDOwZ8monxu6f8VOWPDDdag@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <CAHk-=widRkpp1NqpDWoOv7stHcjcDOwZ8monxu6f8VOWPDDdag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/13/2024 6:15 PM, Linus Torvalds wrote:
> On Wed, 13 Mar 2024 at 16:29, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On this specific commit 7ee988770326fca440472200c3eb58935fe712f6, there
>> is a 100% failure for at least 3 devices out of the 16 that are running
>> the test.
> 
> Hmm.  I have no idea what is going on, and the unimac-mdio probe
> function (one of the things that seem to take forever on your setup)
> looks fairly simple.
> 
> There doesn't even seem to be any timers involved.
> 
> That said - one of the things it does is
> 
>    unimac_mdio_probe ->
>      unimac_mdio_clk_set ->
>        clk_prepare_enable
> 
> and maybe that's a pattern, because you report that
> brcm_pcie_resume_noirq is another problem spot (on resume).
> 
> And guess what brcm_pcie_resume_noirq() does?
> 
> Yup. clk_prepare_enable().
> 
> So I'm wondering if there's some interaction with some clock driver?
> That might explain why it shows up on some arm platforms but not
> elsewhere.
> 
> I may be barking *entirely* up the wrong tree, though. I was just
> looking at that unimac probe and going "there's absolutely _nothing_
> timer-related here" and that clk thing looked like it might at least
> have _some_ relevance.

FWIW, we use the clk-scmi.c driver and the implementation of the SCMI 
platform/server resides in the ARM EL3 trusted firmware, that also has 
not changed. Ultimately this results in an ARM SMC call made to the 
firmware after having posted some SCMI message in a shared memory 
region. None of that has changed or is new, but it does also require me 
to look drivers/firmware/arm_scmi/ for possible changes.

Thanks!
-- 
Florian

