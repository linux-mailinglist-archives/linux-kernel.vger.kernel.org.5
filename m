Return-Path: <linux-kernel+bounces-158734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BF88B2448
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B19A31C21BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1AD14A4F0;
	Thu, 25 Apr 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZVr6q96"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B87149DF0;
	Thu, 25 Apr 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714056310; cv=none; b=Vapxh/PXifGthPugD2ucHDm+S3F/LQjzZTh4N9fjrMQGFn99LYpEdzYE0Qm4m2B/kgKZ4kW4nj2SeevxM9yS4Myn9Amz5AZXbcNAiqWmn4YeY9qr2+4iGbz2FVysN5o7Yz24U0L15rD1lQe6Fw3AA4GCmVaOBDyPGA+O8aBQEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714056310; c=relaxed/simple;
	bh=N6WuAyUeHOd60Ro3ryy3jwj2TJsSygMiE0gODyrLFFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FODroE0eViEHQ7nmarekukPyNVsJBHwU7PzFikUyeVf7U+/jixOLgXaAWFZLZi8Ezs1MefP7bOshrxrbWh1avrTmxb5G9BZQ2sCEzC+U3/bh1mHi9IdHtgmAjBAwJJszJ8Y0u3ZlZBalsIQDnmIz59WRZIZbADoHZMMatUUPhng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZVr6q96; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36b33fc543dso4405585ab.0;
        Thu, 25 Apr 2024 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714056308; x=1714661108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpyDdDyNeo9GDwhpLa3GfM3X8krxOHdTcoDv2LlufnQ=;
        b=TZVr6q96mrWlllJQn6NU+yTjADgDlPsdK854ll47sCxzqCVmau+LeTnyUDibu0qJpL
         TFTu/j25/ufC32X4C68Rpc5LvGNrZwzeNrTlwSnUhQKa7+AgmvDzDr1LTy3CuKl6r9s0
         GqfRP7TuBEjXUacsVEJugAcVNy6w5ZZK5QbpPCRK3r2zQIRtWZoNwJGwDC2TYSSbtZGQ
         rPqd135ZvnHx07zTPRFqdBoBx9xFWYWUMeaxoCYiexcndCrrtLVGBenTgamw+pkPSGTt
         ddnX3t5YvP+Rd7ciE4uJVCj69uyKWnz63BQoRQcFc5TB1H3evNL8ZeC9vzY7sod6Nk4x
         454A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714056308; x=1714661108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpyDdDyNeo9GDwhpLa3GfM3X8krxOHdTcoDv2LlufnQ=;
        b=tPul55xYUNbfN1uROZ3EVT3Hsqjjq3MngiMKlzQn60kYlVn5LuhbslhCiSjXnUH8lk
         8Nb9ow2WrNC8uCUZfs/XC6awHA4w1pb+qVfpgrPJuC/2140C2gl3+tm4euPhmutoiDz2
         lw1v9z/VSzIZ3GZ6A4owVyyKSPPHKbTxiuwQfp+jyDqSONQbdaoNvgaNjPbSFEStjjTw
         1AszUEHpe7GD6g4eiI3mge98Xs5cEYdr1jnLUTgFmOyaHumX3ZecH8btI5rPHXw1E2fJ
         h5KbKuTjJcbY72EJ75pOjLfa6Zd5K/epXStzWdsxKRHnD44omFvCE0F+WCv7mTOjr1tt
         ZFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwxUqMz2C9RsseC5Xydr4YiVmX8hykc5Ge2r8aoOGY6HumvTuYC91uE5B8SxDCjyFl9cUaC9jK0ts4xrY47cj0evERSJQjxhwjKS0/pcMKhPU4R9OKodSYsz2Fd25qOrZupF5kkadx
X-Gm-Message-State: AOJu0YyWvvDURBfJbK33nSCWcmdWK6aBuGU60hjtDKLf8kwTq+n1dqyN
	I6wTAiAHGXsj9njVMUc6RTVtu6+gQBwBQsav75pNeX/uHUs4e5Jf
X-Google-Smtp-Source: AGHT+IFad49HRQV/3CI5hlWBtMYrZ8owN5H5mDwmVsghU85TRVif51fGB+HTLOXxtsob+nCTGakKlA==
X-Received: by 2002:a05:6e02:20e1:b0:36c:bb8:9eef with SMTP id q1-20020a056e0220e100b0036c0bb89eefmr6921925ilv.24.1714056308598;
        Thu, 25 Apr 2024 07:45:08 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:40b8:b3c3:122c:f3d3? ([2402:e280:214c:86:40b8:b3c3:122c:f3d3])
        by smtp.gmail.com with ESMTPSA id z23-20020a656657000000b005f8072699e1sm9143981pgv.45.2024.04.25.07.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 07:45:08 -0700 (PDT)
Message-ID: <5326cb96-e736-4455-abcf-921576b15be7@gmail.com>
Date: Thu, 25 Apr 2024 20:15:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 linux-next] usb:typec:mux: remove indentation for
 common path
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: gregkh@linuxfoundation.org, neil.armstrong@linaro.org,
 dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de,
 christophe.jaillet@wanadoo.fr, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240424172716.3407-1-prosunofficial@gmail.com>
 <ZiosKjYjMG3my5FY@kuha.fi.intel.com>
Content-Language: en-US
From: sundar <prosunofficial@gmail.com>
In-Reply-To: <ZiosKjYjMG3my5FY@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/04/24 15:40, Heikki Krogerus wrote:
> On Wed, Apr 24, 2024 at 10:57:16PM +0530, sundar wrote:
>> Nitpick, Mostly common path will not be indented.  so rewritten this
>> function to check device_node pointer is null and removed common path
>> indentation.
>>
>> Signed-off-by: sundar <prosunofficial@gmail.com>
> 
> I don't think that is your full name, or is it?
> 
> thanks,
> 
Hi Heikki,

Sundar is my full name.
Previously, I wrote my name in caps.after changing to small,  conflict 
arises.now I fixed it.

Thanks,
Sundar

