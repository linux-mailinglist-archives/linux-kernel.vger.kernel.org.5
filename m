Return-Path: <linux-kernel+bounces-50815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 298D5847E42
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62512855CE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBC7567F;
	Sat,  3 Feb 2024 01:50:22 +0000 (UTC)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091F6522C
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706925022; cv=none; b=IeXb3/7xKEY3zloanwrWOf7Nt2VgfOgm94shQBYNFeCNQ59SUd9gdZUtJk/adjMFW2L1dBEeRN0a2yLgeT/wOmOnU+Snwc4hVdVcDtq1b7iUriyLGnM4KE4QcMcHX1XDJKaZ6B54ipgC0SQwTqcjfqjVHCN1ss+zRG+x+q/YMU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706925022; c=relaxed/simple;
	bh=kNTGjZRtNZ0NlLaHhLPU3nbSRvbdYYClERTuNmpRcGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czcZ35izL6Oi0z1UMJPTQ7xcketnFDeu91aRNqA/hqp3jSqF/95m+xxauJtTnLhI76qXJ4IS0bxMxcmdUYLJ7MbrPZsal/wCfR9kEnVx69LpDd4LlaTmblVpNnd/VUhPvfr91q6ANuWKdKOSojdOUBkta4vEYJj3MITxzdnY5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7c0330fb868so73935339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 17:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706925020; x=1707529820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNTGjZRtNZ0NlLaHhLPU3nbSRvbdYYClERTuNmpRcGM=;
        b=vxSqGW9zEmQZ0aoyjZRZDkDSn6jOb7DBYyCq6HaNnNA3H/ih0bfzPlD3jYtKMdB6vY
         IPOjAGxqx/E06m0gVTOqjfYFArhLoR8xScYjS5t+1iW85MdU/33IQzZrA6QAnB3MkG+R
         aGmEo/jS1MYIHFwZRuIgsQgY6zNOYME6vNz4N/qzdsJ0CkbYeag5fi64ogcKXpbJrZzX
         nzwSmHUcMeMpbq6o0GVUJ3S0ObW/LUziJXKxRNMthBsl79DGA2c6vQEMnAbVRxA/mgle
         vpdtcWng2zPu4MNgN/+Bm4uCtLf2sLR0ErWOf7gGZMErWQ3wq5/BtPgXlWetYM60dA4b
         sCYg==
X-Gm-Message-State: AOJu0YwbkrRyAMzg0TItMXxGiLagpzJjENnDzcg9a1U0xylT4EJT8kRk
	VjhnzX0ctfzx0L6tHYclJQ6JpC0onmfnSApuJvkTc3TlL5Ksh9n/xoPnZ87k
X-Google-Smtp-Source: AGHT+IG0s2Wn8tys50u4CgZJ7hFQaezogQqXBkv6vQ/JsU34g+NohUOe+kXTQdnbcRsrSaqqw9jNhQ==
X-Received: by 2002:a92:c5d0:0:b0:363:a6f7:ee27 with SMTP id s16-20020a92c5d0000000b00363a6f7ee27mr3516828ilt.2.1706925020020;
        Fri, 02 Feb 2024 17:50:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXuW96+rICcGPl0QldKSUh8CUkfPSbc2mWoGV+QCZWJyEqHoPaTorHh05s4+u3g5WeSJQu/HMN9lkL00ctiGO6ZwAmdwQH+NxZkO/yfBv4dlH9Z8wAgFHdsQWvX/9YuPMUR9WT2jPFGSvhN5C7XDjWbRtYDVhhsoFL34h35FXtGg22NDaY7JFOhSUJ8trqirkHTD7xDAWiyuDTbsXrUlesCb/2WFWZglXEgEp5m6LU+JUMgIj02SV8OoRtsJElF0zGtx2BAqA+kvB94C0hjnSccM4xLuYFur4lv60duMzdWCgY26ykOPBzOBqgU8YQ87Q1I
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net. [73.231.117.72])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b005cee9115cb3sm2454753pgc.0.2024.02.02.17.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 17:50:19 -0800 (PST)
Message-ID: <3f32544d-d8ba-4849-93b5-ab23e9cc53e1@acm.org>
Date: Fri, 2 Feb 2024 17:50:16 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] lockdep: fix deadlock issue between lockdep and rcu
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc: cmllamas@google.com, linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
 ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1706861676-26574-1-git-send-email-zhiguo.niu@unisoc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1706861676-26574-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 00:14, Zhiguo Niu wrote:
 > [ ... ]

For future patch submissions, please put the names of the maintainers
in the To: list and the names of the reviewers in the Cc: list. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

