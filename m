Return-Path: <linux-kernel+bounces-144778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F30F8A4A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D25DB25480
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0A3BBEB;
	Mon, 15 Apr 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dCoAEPLg"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CF43BBF8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170566; cv=none; b=RnN5j7P8xF24rcOSj7J6+KTKbdqkw+a1H80mypFn3OptzihqSznKM5CCLjfiaXehCAJCAlE11dUwqJAX9MWE5BsRfOyzDA0H86X+T+GsKBx5fxnKvKq7VavlfgY6zxrnMYcczENGld8v8YDrkqjD4an3aCDIgFSIPodGZDpb7jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170566; c=relaxed/simple;
	bh=lsNA25Hve1uKuZ0Fo31C4L3iCmQ0dq1xxEBRYOkQj3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qsqi99j6AmT86uPdyxLlYqESXKOg0TroaM6t9ZZZl/0MeQT/FKZaSePrhkEgjU368YwBCTfXHI1D+qRlyReouCLGljqOrtQxQV6M1sl3fcIJ9lG58ErHVIqJIVUgb1Ws+yT2C7zjharrIPZg0lbUC8NEE9hRmQXOkUe0vCPLNdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dCoAEPLg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a52aa665747so53325866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713170563; x=1713775363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k1cz5najN+xwuJfZkkj9Amv0HLnPLbSM95zuUMKQZGI=;
        b=dCoAEPLg0JhE8Azdmt9LMtQjIVhxTrTPz3JVVRT/khIuy7UUuHaqnUXfBBPBFwhyVx
         srsjGixNEXYnSWrAkXCgpJnlhxDc5ohO6MuMvdyuPljD/+VVQ/j/+BDVra0v7YZOYrRK
         NDhJrxMbpRI/0tm8hMxLxCxwy2VomqykCEAEkIBINqsTSj/R036vubI/AEGK+uIZPNBV
         aIfBbWPsXWdphm93aS1xkT3TgkGAc8h4TWQ6COreyDdt4mdL/T09KQO1TOwPFLJPKDSI
         +QtcUORC9Y9gk+S8H6QSg/kDZjF0Q35eiBhQUNXVxzIwSY5y7doiabVGLtQz9c6BV0YB
         orXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713170563; x=1713775363;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1cz5najN+xwuJfZkkj9Amv0HLnPLbSM95zuUMKQZGI=;
        b=RiqUhxccpy+LoKAQ3K3tKGqE+wGQhqOb4+96f9mukXqg17OO56YmejZTMJyk7pFLuK
         ZDQ+8PofdsokvVSIvpslUs1+LxLD9u23XQ9oEZgZWFQ4U7u88d2nlUTVMfLGsK/lE7Aj
         0NZ2klscHphPkt+C1IDLKmMJp80qmwIUAbWtdQ0xVYWoYBiyTe37ISYidJmh+voPt+HQ
         li93bc2UQZzgQcXziBW4HP+PmqtEJ4JsZp3qGEnjjdb1JEjDNgqu9slwEIBepC9dhOd/
         8Z6sxzZJRYTSIsV6V+OyOsWh+JT5jY3rCgSPYkfTi8KCSCCVhimZda1zjybXdwJnCZSS
         twCg==
X-Forwarded-Encrypted: i=1; AJvYcCV9YscF0csYdh/Dxbqe78lNOjwXv1quNphLHX0HyC4X5W4t4pbM0d+L24WG1ccgyR/K8fpsqf9sOlFer1ThSOJv4FmhwGiL/aEEL7NK
X-Gm-Message-State: AOJu0YyWJWTUwfRl3g5GVUSJXuqaRTzKozzb7K3vR/ALg9YRz5DVeAJR
	Bf2Ep7qxJg0LfHo2xKveFsKY0hqEYlVMG9cQHg7o7TNJFekHQuIFxXmEGRZYeeg=
X-Google-Smtp-Source: AGHT+IGxmdMCD68BdG5qehJC80yGzVw2DjtHoP/u2mDoWGEYMTcotqFXQdRUe34dZrNc2lZtBY5u4Q==
X-Received: by 2002:a17:906:3756:b0:a55:3240:ba3b with SMTP id e22-20020a170906375600b00a553240ba3bmr264616ejc.8.1713170563090;
        Mon, 15 Apr 2024 01:42:43 -0700 (PDT)
Received: from ?IPV6:2001:a61:1366:6801:d8:8490:cf1a:3274? ([2001:a61:1366:6801:d8:8490:cf1a:3274])
        by smtp.gmail.com with ESMTPSA id b24-20020a17090630d800b00a4e781bd30dsm5167412ejb.24.2024.04.15.01.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 01:42:42 -0700 (PDT)
Message-ID: <6133bcab-ae0f-48f2-b223-2b74082a0552@suse.com>
Date: Mon, 15 Apr 2024 10:42:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdc-wdm: close race between read and workqueue
To: Aleksander Morgado <aleksandermj@chromium.org>, oneukum@suse.com,
 bjorn@mork.no
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
 linux@roeck-us.net, linux-kernel@vger.kernel.org, ejcaruso@chromium.org
References: <20240314115132.3907-1-oneukum () suse ! com>
 <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <385a3519-b45d-48c5-a6fd-a3fdb6bec92f@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 15.04.24 07:42, Aleksander Morgado wrote:

Hi,

> We are not aware of all the details involved in this patch,

I had gotten bug reports about resubmitting an active URB.

> but we had to revert it in all the different ChromeOS kernel versions where we had it cherry-picked, because it broke the MBIM communication with the Intel XMM based Fibocomm L850 modem. > Other modems shipped in Chromebooks like the QC based Fibocomm FM101 don't seem to be affected.

That is odd.

> Attached is an example output of mbimcli talking directly to the cdc-wdm port (i.e. without ModemManager or the mbim-proxy).

Could you provide a working example, that is with another chipset? And, most important, dmesg for both cases with
the log level set to maximum?

> In the example, we are receiving a bunch of different messages from previous mbimcli runs. Looking at the timestamps, it looks as if we only receive a message right after we have sent one, e.g. after each "open request" we end up receiving responses for requests sent in earlier runs; or something along those lines.

It looks like you are hitting the race later than my bug reporters, which means
that the submission works and we do not overwrite the buffer.
  
> Is this bad behavior of this specific modem chipset, and if so, how can we workaround it? If you need any additional information or help to test new patches, let us know.

Generally losing data is bad, so I cannot readily tell.
Please provide data for the working case.

	Regards
		Oliver


