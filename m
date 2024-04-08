Return-Path: <linux-kernel+bounces-134869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2A589B80F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC54B281BCE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8529A25622;
	Mon,  8 Apr 2024 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+oTm0h9"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF22554B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559677; cv=none; b=TFE6A6is9QlpAZl5WwOJsgvhZfj0UYB3hPOPKkETh/Z/7yODPM+SwxIl3uGWRhK4bJ0WB/mBuzcldCRXrPqRoEhFkcpNj1ecyM2pM7INug81oj+yt6KGslGH6uVdJ6LHl6gc96TZ/paT479v27ldGNHoDsbw/valhEwOWyuauQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559677; c=relaxed/simple;
	bh=nLsZRwx1i4MrD7mYj20l01ThXf/uHKnb3iNXZjBpzqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmzWPJqyVuPBnbDhhLpktTLFgxqtslLx/qYMmWDrEx2Ly+FKbSWXQpCC74rm/w7fxGkVGFVzn11tibdVMIV2qQioH6PTYN4oPsN15UnIR+mUXwoSMwsbbyRnDobhwMVINdZ32pM+p8vErQvqnNQw/ey5qVumfIcDfiIYDRs118A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+oTm0h9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ecf3943040so2541770b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712559676; x=1713164476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iipQgF147rj4hVuYbg8MCyDIn3mxGhNULOVGWWVLgmo=;
        b=A+oTm0h9jfw2mRhEij9sXBBy+7+FuI5s/fyTQCc2hood9vCDHgpC1KxHbZzn3puzY0
         hpdCiKd6+3EL08an2IJeJqOXJajw1M7lQ4mX5NJj+BPlWQNnO3/bZYGIKYmqGtHMRwRo
         iXhW/VhFB9izH7EY7PcCuFI6uKF6eCeGFQO0VL51PX5QMZGgtvxOQAiNHADmudSut0fT
         uLtFPlTy47vYMKS81jk0g98N3RhRGqeCGu3UFzKiPMhuG7Oi5i/iI4x4ENRZIwdFavJV
         lme1g2HjbX/qyH7uDSgklMfobYFChs5GlKUZD42TGGdcAHXF9mifM6+8w1tiW1duDkVT
         HsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712559676; x=1713164476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iipQgF147rj4hVuYbg8MCyDIn3mxGhNULOVGWWVLgmo=;
        b=DGRTXAdoVz5DS5ekF6Pdeq0ek9T1P1Iq9ik7xoKioABanX4gtv11evykxUeKrouvj4
         rlCkOW5Ea8gDnxG6f/bi8l0hd3LPcbPdbZdC2Ud5F7U0u/V7+TygmUbBGLF9k4qes9ZZ
         vpIVrv/Wzr42o6DC/88mpRTBZfuqDxXsD0jAiWK22HSyWikU+0U96BQPLKPDWdo6SUnR
         /sIeZro28J6r99dc858Q0UQuN9iaBsRv+T4gP2HydChPrCYmRMNlQOdTrgw5LteT4o8J
         F31dZe5t+zDqbm97lXwti6/htBoNVRtIEJOnhAenjYQlmMzA6tYm7XHrDBCV1dPs2dmK
         9+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb5hgrwD22Ja0fpAHmbEuHBUgQpK3CcKvO5poBN/j8RMYqQZbje4BN0TgzO337LEdTHsKT228b/WlcIDq/6UeN601gdMEm5OldfZTj
X-Gm-Message-State: AOJu0YyuHOMo2c48uk+Km+gMzzjv3CjK20YPllzKGByd+6qB2w12YVoy
	oPaiDpKooMyrjCDGeKZmO5SycAXBtXhzxQVe98IKxtZ6hrnY5/1o
X-Google-Smtp-Source: AGHT+IGO0HzM4Lj/0joZG14MyEbYD3f6xfjrVq1lXZMVNVQsccyijl9qF9j2y8TKRBMLAcRrGkuTLw==
X-Received: by 2002:a05:6a00:c8b:b0:6ea:e2ed:497d with SMTP id a11-20020a056a000c8b00b006eae2ed497dmr7673437pfv.19.1712559675841;
        Mon, 08 Apr 2024 00:01:15 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id u16-20020a056a00099000b006ed06c4074bsm4736772pfg.85.2024.04.08.00.01.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:01:15 -0700 (PDT)
Message-ID: <f0ff6898-3704-4a46-8357-ce556037c1a9@gmail.com>
Date: Mon, 8 Apr 2024 15:01:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] mm/ksm: remove set_page_stable_node
To: David Hildenbrand <david@redhat.com>, alexs@kernel.org,
 Matthew Wilcox <willy@infradead.org>, Andrea Arcangeli
 <aarcange@redhat.com>, Izik Eidus <izik.eidus@ravellosystems.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ryncsn@gmail.com
Cc: Hugh Dickins <hughd@google.com>, Chris Wright <chrisw@sous-sol.org>
References: <20240325124904.398913-1-alexs@kernel.org>
 <20240325124904.398913-15-alexs@kernel.org>
 <43a5c133-b271-41b4-9b4f-a2de29b9f593@redhat.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <43a5c133-b271-41b4-9b4f-a2de29b9f593@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/5/24 5:07 PM, David Hildenbrand wrote:
> On 25.03.24 13:49, alexs@kernel.org wrote:
>> From: "Alex Shi (tencent)" <alexs@kernel.org>
>>
>> Remove the func since all caller are gone. Also remove the
>> VM_BUG_ON_PAGE() because it's not applicable for a folio.
>>
>> Signed-off-by: Alex Shi (tencent) <alexs@kernel.org>
>> To: linux-kernel@vger.kernel.org
>> To: linux-mm@kvack.org
>> To: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Izik Eidus <izik.eidus@ravellosystems.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Chris Wright <chrisw@sous-sol.org>
>> ---
> 
> Also, best to just squash this and #13.

Sure, it's better merge them.
> 

