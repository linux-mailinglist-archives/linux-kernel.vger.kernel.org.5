Return-Path: <linux-kernel+bounces-64629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA09854109
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F92D1C23CC8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50147465;
	Wed, 14 Feb 2024 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZNzEfxRA"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093F4688
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707873328; cv=none; b=cyxpxhOv7gTFg7SLlI1+AMwKcFtuBRL6ATxzOOsLAEcjsiQAwH6gYStj0/pzTtArv2+Cgot7nIdtX1Oar6pWoxhTEiDCG7urYJAx15J6tfLwRdOK0DgjnkxOF6ZaXWgRMEuf2Xk0L0NuLUT3vYut6tV29v9vpqAFvPDfsEutzgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707873328; c=relaxed/simple;
	bh=YISLmiOh8DsOjrNd3ZcUJWILLwR5pKA3Lktxbq7iP5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gT1N0QRKMFeHwBsHAfcexkC2PIrUiieTiMlqjUojUuCfCxG7R0X7Sw/9TrCP5Mf8c/W8BmU3vK0DTt3Rf/vMlJqnU6iaX3YyrZvR0eMd5qPwRKYYas1dE85sVNquG2sKR2L4/9dPkzU7whSWqT/raiFLKYt3yQ8UcdDMOWc4AVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZNzEfxRA; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6078c4cadd7so10968087b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707873323; x=1708478123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zeQlG5HaeE1tvyqjW/qsMJ6XFTd9Z0Jl0VtLgrNyeZE=;
        b=ZNzEfxRABtsKK4zgXO/Vt/Hkk9zeTsshLTecP4aL2dwgyzSZYJl1wMwoyeua+AM5r0
         znLvui5Mu1ABCgy5gSupnlzhEb6nj1VxbSF6n9cPNHu8pRhkhT+Zv6zVMV40KnZh6HGY
         mrXfJ2CCpSpu21pRAZtI5HdSysqfkc5vky5gGcjkWMpc1wSPBFWlEnjbAfZguWh55gZd
         5H7ODI5HJohOx1q6FnCRSup4vUpixU7pi6a8GO8LNqBjHdRIQgRrAndL44IJntUIBLFm
         +Q/xRr1jVwD5c1tzKWeQwIc9osFwCcIIzuUlxV7OYi6ZIFYORzuWfT87IFvcxUo5hgx3
         D+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707873323; x=1708478123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeQlG5HaeE1tvyqjW/qsMJ6XFTd9Z0Jl0VtLgrNyeZE=;
        b=bXYGmAo+9219gmlWbbA15C60SRfqRCPyDj5Nb5EDpgid+XilnihbfmjNrog665cetJ
         73hxyU/ZB8P6E2MvoxpLI/4ocjBoauADdbPfCM0EtzdEY8GzqJqn8ExWNgNYMYIbaeew
         8gvy/QK5XLl6/OKgqa2zp+LSQ3orhlvfX0XdfdoLJo8wGcuyJ3TdM/0TxUZwk5Y/ER4y
         x00YpwRVTjAhIP8HXxb6QCyi59WnHkjTAUOD9wKih/j2RmK8KBZRFcrtfiHb7DZwgaVf
         UZ4UuW7IWLCHyK35AXnCS152w6d+hEs1EmqwhNULSwzUAubXU5adLzerOfsano2O9oLx
         e2SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfzXJPTEI3NXRvvXcWE36zgxNbi7TeBwUOmp00ZdT+QY2jTYadLzEgdYg5Icr8oP4mH+n5jj7h1bEHiFHLBhFUSCQk0wdZ0aiOaGco
X-Gm-Message-State: AOJu0Ywc+XXEt9jHctZM9qlRJadLWiYo7jCRfOOwuDSX5pGThN1smsdP
	3qh/GncXvW0E26dQYU3PIfakFDOckNDiz5AKcP0b8ccWTJk8vX2qCkeR0J1KYgU=
X-Google-Smtp-Source: AGHT+IHSkAf8+b29Gi6SWsnVMCxhPMvWpr6CgdGwFGAnm9ZZy/aOSRMthPQFXowZ3VWL7G49+vZxCw==
X-Received: by 2002:a81:91c3:0:b0:607:78b8:2a57 with SMTP id i186-20020a8191c3000000b0060778b82a57mr1165550ywg.24.1707873321892;
        Tue, 13 Feb 2024 17:15:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpiS3CYGqaE5p19zqsKOGDDCuWOmpHiFlVht4NUnErZ/3SApPs7W7zub94Pv8tKe82D7fCtMgaaXSbkcDQNWsk2olljbYcyq95DWaOcKUD3vVwiYs0UFCEyLtkB7PcnZKc0c0jnI7OdI3C+iOz2Gx6krZad+C5e8iF2/CFxvw/MTYgYyHAq/4vTacHSU1jcNntMATpm8f5P9GgY+Biiu5kSAF8mfIJ
Received: from ghost ([50.146.0.2])
        by smtp.gmail.com with ESMTPSA id j75-20020a81924e000000b0060790d60113sm420404ywg.89.2024.02.13.17.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 17:15:21 -0800 (PST)
Date: Tue, 13 Feb 2024 20:15:19 -0500
From: Charlie Jenkins <charlie@rivosinc.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Helge Deller <deller@gmx.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] parisc: Fix csum_ipv6_magic on 32-bit systems
Message-ID: <ZcwUJzD9eGF+AIP0@ghost>
References: <20240210191556.3761064-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210191556.3761064-1-linux@roeck-us.net>

On Sat, Feb 10, 2024 at 11:15:56AM -0800, Guenter Roeck wrote:
> Calculating the IPv6 checksum on 32-bit systems missed overflows when
> adding the proto+len fields into the checksum. This results in the
> following unit test failure.
> 
>     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:506
>     Expected ( u64)csum_result == ( u64)expected, but
>         ( u64)csum_result == 46722 (0xb682)
>         ( u64)expected == 46721 (0xb681)
>     not ok 5 test_csum_ipv6_magic
> 
> This is probably rarely seen in the real world because proto+len are
> usually small values which will rarely result in overflows when calculating
> the checksum. However, the unit test code uses large values for the length
> field, causing the test to fail.
> 
> Fix the problem by adding the missing carry into the final checksum.
> 
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/parisc/include/asm/checksum.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
> index f705e5dd1074..e619e67440db 100644
> --- a/arch/parisc/include/asm/checksum.h
> +++ b/arch/parisc/include/asm/checksum.h
> @@ -163,7 +163,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>  "	ldw,ma		4(%2), %7\n"	/* 4th daddr */
>  "	addc		%6, %0, %0\n"
>  "	addc		%7, %0, %0\n"
> -"	addc		%3, %0, %0\n"	/* fold in proto+len, catch carry */
> +"	addc		%3, %0, %0\n"	/* fold in proto+len */
> +"	addc		0, %0, %0\n"	/* add carry */
>  
>  #endif
>  	: "=r" (sum), "=r" (saddr), "=r" (daddr), "=r" (len),
> -- 
> 2.39.2
> 

Looks good!

Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>


