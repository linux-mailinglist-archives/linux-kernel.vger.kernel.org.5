Return-Path: <linux-kernel+bounces-136412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D589D3C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F71C224B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B9B7E59A;
	Tue,  9 Apr 2024 08:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2fkzI7y"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF857E112
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712649952; cv=none; b=a8EpOgHTzTBlk+tyJ8xyXR8tDisdo1OOTy0DNcbL4Mrxt9ufRRDU8VT/vDw7a7qTuK1MUCZR7f8E78dKpcDOnnC5+eVA6ZjPEUtUOjnVqafsA8UDFzFh6VjHzZHhFpa+zILjM2HB3ppG5XtzwZ/2YmrGAqnb96Vj+tQwEL7s9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712649952; c=relaxed/simple;
	bh=kO1tNZxP0wkRZvHmrwV5luGXqWpuyvapnuwxjqt7xgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVk7lkjQC9KcS/HZzoUd+AVodevR6Ldo5VtnA+VasqNTd/rAm2vpJStwgEnEvmywGqmGEfkkR5+zoxh0ZUP9cLDAwYnWNxnGQiiWLZBS55FB1qAgZS+gDTXzfTIVpfbd8DRF6gK7P24PsjYeUnSZLxLwdFhbE8Bel78hEqP7bDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2fkzI7y; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so2070317a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712649949; x=1713254749; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53D6mYwekcZo+rbQ++8tdmxbDB0J/LHg13ve9dwFXD8=;
        b=H2fkzI7yaY3WlRrY9vNqrfW+NKjugbFDXUN+gmF9oR44pnBlvKYuOQ5H7BWgV2b4vD
         4cYuIP6jdyf+iwETNEw+YBe7IGMad+3EyNFsovk70/tPK16m9f4xeu7P52idM21IgHSO
         IZrIrydHS1rRrMPWjiNkXNx5CmSTOW5cQXYXLQRPkncb8rtJomDrne1MjSlX3Bu3xiH4
         9FSV1QA99Z6CWbLO3SbOCc76VaP22TBgycF5nKbJivc6XloTVZmiEE+r4Q+1vIAlylaZ
         aCSxN29XOmGjqih5Zdgf3eMLBkMugrxLjyMIOWFin4SIM/ydsX2NRWg+rQIAWfi2slep
         rZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712649949; x=1713254749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=53D6mYwekcZo+rbQ++8tdmxbDB0J/LHg13ve9dwFXD8=;
        b=VPp+GCtzgEX027wZlsZCYYZ9E3YLya+4bkZ0JDV0BGV69SYPxhn187jflnswarWnAT
         CALfWRvh9SVnhW52Komfya3PxRI0drRuOTZ88E6jTZWq/JNekaAgUdg9fM78OSu2YikI
         i1sTpOnYCMHlAZkjWHzSzhMF1wOrbXUrgNq64xpmOnnDGyrg0zDRAcgxT+/0dYrUEQu2
         6aL0QDulPraWrWMba5yFdYCHtL+dUJQaJac9NXC9LzjuXN9MxLVx5tMNBTuTkPHHNhdj
         LCG5Uc/8dyHLN4maWUZDmzY3b3GFCqsTwBCC0fDeYA3l4fyvzG3FjqcEMaLwVXXJYSHB
         RKPw==
X-Forwarded-Encrypted: i=1; AJvYcCXTIb8VdbejzLIRY844sFHEwMU8hVxV8USMeMn7fgExFzRCJ0hXcMe1VD7u+zDIc3ek7tAn/sAmXMAsSsuuJS+59WTofRGNH+8p9aKs
X-Gm-Message-State: AOJu0YwS6D0MlqgryVBtCWH1YYQDsdbkFi6TL/Q9FZ3xhqSrzxWe8IlK
	6afYbyaRJLEo/Dh15Pqaim43KlB+UbNOAfTNjXJF/dAeiWarSif7
X-Google-Smtp-Source: AGHT+IESh4hc+E/nydRuDLNH7lDRaToGZpJKCxrfUmU90dnoQWKx7L0rZDDtcs7NFk1TQoNCjifmnQ==
X-Received: by 2002:a17:906:f58d:b0:a51:9f5b:b659 with SMTP id cm13-20020a170906f58d00b00a519f5bb659mr8794849ejd.34.1712649948802;
        Tue, 09 Apr 2024 01:05:48 -0700 (PDT)
Received: from gmail.com (1F2EF1A5.nat.pool.telekom.hu. [31.46.241.165])
        by smtp.gmail.com with ESMTPSA id jl26-20020a17090775da00b00a51a93e909esm5073629ejc.135.2024.04.09.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:05:48 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 9 Apr 2024 10:05:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Lei Chen <lei.chen@smartx.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86/tsc: print some log if calibrated tsc freq
 deviates from original too much
Message-ID: <ZhT22tl/Iho5M+1x@gmail.com>
References: <20240408100607.1732600-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408100607.1732600-1-lei.chen@smartx.com>


* Lei Chen <lei.chen@smartx.com> wrote:

> In most cases, tsc_khz is refined by hpet on boot. But in a few
> production-level nodes, the refinement fails because calibrated
> freq diviates from origin tsc freq more than 1%. Printing some
> logs will help get this info.
> 
> Signed-off-by: Lei Chen <lei.chen@smartx.com>
> ---
>  arch/x86/kernel/tsc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 15f97c0abc9d..a68b16e72df1 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1435,8 +1435,15 @@ static void tsc_refine_calibration_work(struct work_struct *work)
>  	}
>  
>  	/* Make sure we're within 1% */
> -	if (abs(tsc_khz - freq) > tsc_khz/100)
> +	if (abs(tsc_khz - freq) > tsc_khz/100) {
> +		pr_warn("Warning: TSC freq calibrated by [%s]: %lu.%03lu MHz deviates too much from original freq: %lu.%03lu MHz\n",

Yeah, so it wouldn't cost us anything to more precisely define 'too much':

 s/deviates too much from
  /deviates by more than 1% from

Right?

> +			hpet ? "HPET" : "PM_TIMER",
> +			(unsigned long)freq / 1000,
> +			(unsigned long)freq % 1000,
> +			(unsigned long)tsc_khz / 1000,
> +			(unsigned long)tsc_khz % 1000);
>  		goto out;
> +	}

The warning makes sense I suppose, if it's one per system and once per 
bootup [right?], but I think pr_info() would be plenty enough priority for 
this condition - especially as we didn't have the warning before and don't 
know how frequent it is?

Thanks,

	Ingo

