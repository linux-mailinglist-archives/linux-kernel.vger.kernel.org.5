Return-Path: <linux-kernel+bounces-156357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB68B01BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692B71F2393A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF0156C67;
	Wed, 24 Apr 2024 06:25:17 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C0915687B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713939917; cv=none; b=ajGUKqM1swaDfClI7NqL4ZDmRjGhsCbb8coDsEJgiG6aXsgb1nDoQnn3ACQjerHoDOc/s5SM2qUNdzVqAFFPA/UwTfhhj1Cf2egOYJGO6YAJ/nJIiTXr3UAY8yDxtC9tT1ubu5ZtqFwmx9TMSlhCz0QpigqZNqosu20y3YXQAlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713939917; c=relaxed/simple;
	bh=MDMRDBW6c2XypsN+s5d2zMVMNmcHH26pmVwz4/eEfJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awlvfuz7Y//hlo1Rs6kNRoiLRgEnwW7hOp6w//cks14CyF8P3YnNE9OqXDwzBwGXnUur0QZfHJ7RTQEt2/6EI5H4ZJyOSrkyFfKTEss8w2I5teUHpY6IDw+ynr69lKwbZZG2kCwxUTu6nhFy12dhvyRvQTlc1JWwBVYZzOiDqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so49347245e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713939914; x=1714544714;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2PhdlnmC9Zy4rOoZCKKOdA4TCGP5dLB3XWSdFLT4Yc=;
        b=Embjj7rJp/C2LmAK4OQByKYKY0qYiHv8vXCM9BRDdt4aN6Bp6Rq9RCEPCD2Q3cLFZa
         /AbyQ2hXNVzU5qWPgpmjKjwWWDeKEJ5sIstfCGX1d1H04Udpc8YNJZXO5vB0Hf4rGZXo
         UVs48CiLzkwf5J0s4CkSwOVgrZN4ZO98jWBMaggxkGQMnrqKIgznkaxk9pqWhXfZkgbS
         WG3+xpbmcYQn7Z4N1vkbzSTB36Vfx0/2oU8YetIHlwiJFqERgRi0Mdt2NkWaVS4BVtY1
         eDOH1YOraapFTr7bo6/PYsNNdSJZeQ00LBt763JNgEn8WYIgETYnB+3tDyrkgWlJSgYG
         Xc3A==
X-Gm-Message-State: AOJu0Yz5HMwu6+RJ1bKBmUdebYVgpFKTJaR5GBEQ9zCJte9JbsAyH37T
	vbWy2a1XrLHNE4fFaWYxnms6MPrgm1yogodmBIZYSsyUa8kGbBh5
X-Google-Smtp-Source: AGHT+IGHFpqlp5yLBvhjX8cs0aCtd9b3nJEBRSIqACaZALA5Zc7CQ7OpN8ZCd45fcjvv6tHa2QYimw==
X-Received: by 2002:a05:600c:19ce:b0:417:fbc2:caf8 with SMTP id u14-20020a05600c19ce00b00417fbc2caf8mr1053619wmq.23.1713939913729;
        Tue, 23 Apr 2024 23:25:13 -0700 (PDT)
Received: from [172.16.1.217] ([80.95.105.245])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c154700b004190d7126c0sm18039309wmg.38.2024.04.23.23.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:25:13 -0700 (PDT)
Message-ID: <b914dbad-858c-42eb-80be-337e69f189e4@kernel.org>
Date: Wed, 24 Apr 2024 08:25:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: add the option to have a tty reject a new ldisc
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Starke <daniel.starke@siemens.com>,
 syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>
References: <20240423163339.59780-1-torvalds@linux-foundation.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240423163339.59780-1-torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23. 04. 24, 18:33, Linus Torvalds wrote:
> ... and use it to limit the virtual terminals to just N_TTY.  They are
> kind of special, and in particular, the "con_write()" routine violates
> the "writes cannot sleep" rule that some ldiscs rely on.
> 
> This avoids the
> 
>     BUG: sleeping function called from invalid context at kernel/printk/printk.c:2659
> 
> when N_GSM has been attached to a virtual console, and gsmld_write()
> calls con_write() while holding a spinlock, and con_write() then tries
> to get the console lock.
..> --- a/drivers/tty/tty_ldisc.c
> +++ b/drivers/tty/tty_ldisc.c
> @@ -545,6 +545,12 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
>   		goto out;
>   	}
>   
> +	if (tty->ops->ldisc_ok) {




> +		retval = tty->ops->ldisc_ok(tty, disc);
> +		if (retval)
> +			goto out;

This caught my eye as it looks like:
if (ldisc_ok)
   die;

Perhaps dub it ldisc_check()? Alternatively, make it return a bool and 
invert the logic here? That would make the ugly ternary in 
con_ldisc_ok() go away too.

But whatever, it finally evades that group of bugs.

Now, I am not sure what the problem with attaching some weird ldisc to a 
pty was. I will take a look next week (I am unavailable ATM).

thanks,
-- 
js
suse labs


