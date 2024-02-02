Return-Path: <linux-kernel+bounces-49082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF098465AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4606B28D0B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8CBA24;
	Fri,  2 Feb 2024 02:14:01 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C56C8C08
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840040; cv=none; b=GE4VIcRT+f0e0q+EF0RiOyh905R5mPIPGFQUQYHXEUkqmWlWAdjYHsjtLKZqTT/7qOWAMdt3hlBb7WqN7fUVNV9AZp4Zd5cbGWlvCgiCiIiFoBGm7VxO6th4t+JwoxV4GcYk9WEhJOQ9zvkXs4aAOEPk/7pbhaIpz3t46pmBl50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840040; c=relaxed/simple;
	bh=sNS8usbEtbDf7LpbeSuCpxUU9imPhuQu5zZPRTiQCVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzbtiTh2YiHbEUQl5N0da5nREPVkW9ShrG/WNa1v4H+ZjxuhV6nr2pUPg3dWKKH3GMOhrAsURJ9Itj+e5o36j+WK2MLogLsYVp829p0b+xMFxMdsx6As20tvg/ywtiBuUk8NvENfu8GI8rThNAQxr6gzax9ijbEhrGDkdgb+ZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d94b222a3aso12701005ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:13:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840039; x=1707444839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJPfleRqllGEzdFlU+h87ytjQ1VtUOoZphhjUjlezJM=;
        b=gADHdQpzzCetbKSZVDUIWfjXA8es8EODtDYwPsZQEl92LNfZ5+OAHpui/Ey73cT9w7
         Sqwsb8MU+Dz45hr4ssnMagDXuYZRRcFYqrp/Lcmy6XXDEg7JK5STBHPdZGwQeVegx5P0
         wHh23f7B9iHbp9HZxXVLsMyXV75Nnw6iWLnatjPGMnou9NmS7qLXGdtWlAU0DMPfaLHB
         F3XHgoK7evdsudqYENvzLVQHALdvEaAXbYl3f+L42AHA7Sx9M7V/PvamJDeh9zSSj4T+
         pzNhbUXJkChdeozZCMyIHfaQOVVSEId7w29RN1g2bvoaLQGmrDKQ6ec9LhdJiv8aT5cD
         R4Kg==
X-Gm-Message-State: AOJu0YyDPgcjQxpBN6gQfvU5aIC9nG0IubFCoQSSDaKy2ac00siuI0t9
	AZVhLORSu47/Ay4IHRiX502kANzACLjVeqFxUfL7/ezIaReoGXJD
X-Google-Smtp-Source: AGHT+IHiGgFgiy99xWU+et9DL9kQts5nKfcgoxcZQu46XwQL8GFohux6Rmi6mAmOpTvYlNbW14tAvg==
X-Received: by 2002:a17:902:cece:b0:1d9:4ebd:b954 with SMTP id d14-20020a170902cece00b001d94ebdb954mr1041336plg.45.1706840038529;
        Thu, 01 Feb 2024 18:13:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTUlRMuVSDk+1oD09IbiNEsgyNqFn5S5JnjESwipbYXBU0QdnDFz4ISmTq5Z3VuWjF7SUgsFxBAr7q82eecCRayHNWtIcnACxHyXbi94K036r7lqed82o9PzKU0G3hH4N5fkL/wzqqPdWcLt5Xboiku5SN8ys0SQNhFqRG3iJuPvglG2tjn03j5tILCwxfkpN0ZsLi+rK/sReydT/rRlKj0rNDYCozjU+zVVWwyNq58OYf6rS9iwy4FqIzZO3g1MIFuoZtWeA+DzQ2YPtYunxYHllEgX/3oOc+WlLODQes7Fqq8+3GTIdVvf4Itv9OGO0=
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001d933201459sm493164pla.77.2024.02.01.18.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 18:13:58 -0800 (PST)
Message-ID: <891016e2-0f3a-4617-bb8e-a2a3af0f78c8@acm.org>
Date: Thu, 1 Feb 2024 18:13:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Content-Language: en-US
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, longman@redhat.com,
 linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xuewen.yan@unisoc.com, Carlos Llamas <cmllamas@google.com>
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
 <2d1f4f16-6d66-4449-a7b7-5e2b2a4eaeb3@acm.org>
 <Zbv31aq6aZuSXpY1@boqun-archlinux>
 <c485e96c-6aed-4c4c-bbba-de5c8784be69@acm.org>
 <ZbwSxGpySa8RBt9A@boqun-archlinux>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZbwSxGpySa8RBt9A@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 13:53, Boqun Feng wrote:
> Have you checked the change in the patch? Now call_rcu_zapped() has been
> splitted into two parts: preparing the callback and calling call_rcu(),
> the preparing part checks and sets the delayed_free.scheduled under
> graph_lock(), so only one CPU/thread will win and do the actual
> call_rcu(). And the RCU callback free_zapped_rcu() will unset
> delayed_free.scheduled, again under graph_lock().
> 
> If you think it's still possible, could you provide a case where the
> race may happen?

Yes, I noticed that call_rcu_zapped() has been split but the first time
I took a look at this patch I wasn't sure that the new code is correct.
After having taken a second look, the new mechanism for deciding whether
or not to invoke call_rcu() seems fine to me.

Bart.

