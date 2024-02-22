Return-Path: <linux-kernel+bounces-77039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EB860053
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360041C23B86
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400815699F;
	Thu, 22 Feb 2024 18:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7Xtgotd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7518657;
	Thu, 22 Feb 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708625083; cv=none; b=MvYDcMG7/kqMj6cONO0DAXTHVfMucMsB5O2bk4/sn9sMe0wnw7sZa4VOhjyPCBoLJuCRomq+ivMn9CnaTYrXZyNf9krSuBcobKwgsQKpabFdqswK0Vazey51X1s/vTjo9S6ahZe92OvMxsSSsGYowlPbK+vWnD37T1l/hMbcLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708625083; c=relaxed/simple;
	bh=w7ADH5y8zgSb1xrW/sQEcul2PvefBP44b2CSGrLnq6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAcnTr1EGFvseEQhYtc3BoeB1nZ0Om5sN2gMy4t/R6hAaVimymsSXJyVWHXnHWi9ZaLRf+aPjXE7NDJxPLeRh8C1A17TdlUH9bd1tYJqoRx7wLSYKGuhZK3jl2P4y3Px7F8NUNT/+zNpR20TBdS2v5Wi4KPYxqpaJEVNKgYJ4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7Xtgotd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dba177c596so671625ad.0;
        Thu, 22 Feb 2024 10:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708625082; x=1709229882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hp86Na/9poarVJBitbz3HV6CJi5eZ0YJWpiH725Tns=;
        b=X7Xtgotdf136nyDOHzBoVlIlsbAyUYoAy58mWhI04OerDejcILRJTiYPerMul+PTH5
         37fn8J+qyFJYEErK9Ssf5+2X+nTCiW3YK1KGlK1eGkr6RBSGZDnWpsEYmiM7hbsp9+dx
         5P/cQCKmcqVXZbg+IQQYzRL1ogZnrE6SvVCBV6jKDkNzoIyI4XC9WMe2sRnuEnb3KZQ1
         8tpmwCuTzNK1ZOTDHaeP6KAxnTadBM91nIDXfJ+nQeqGiZAKACVCyl+ef9Q9OgvYrBlv
         0k2T537zfFVOLEVesb+YIGrYs2f/uQUmKyZpT75zU62zlNmuMRYQh/2BHg2mzsHpz7Hs
         Bjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708625082; x=1709229882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hp86Na/9poarVJBitbz3HV6CJi5eZ0YJWpiH725Tns=;
        b=kgH7Y/HlUrxtU0Vt9oGbbALgfF2aMdn0+Yl2nKFvSMLjx2MPAPbkOrcckPPfkBCEjz
         /fn+aauzo/lKrB3UjKJfbeyAozyf9NY8RG/m2pyXJM/sLnFgNJAZDWeSRyDFlDRt/vI/
         ZW+SJbzo3mxAFkw6OLmDHqvp2YC2xxCp3KFhXc2jcEY+0GCc3PgUYe6nY3JmtOcwACm2
         mqeoSXQvfFi0/wVACb895pchXbpVkbIlUj7LQNjT0OFw8PptNqsz+FTtEHNcQMUqwPXF
         G0Tku7+0kDMpvdJNlYjei3xQ1cEcrTbyZ30uwzi8AWytVsia6XrVwqmV1eOPQd/D+QIy
         9twA==
X-Forwarded-Encrypted: i=1; AJvYcCWU2exjRNHKY/yfHPldzovQh5l3OH8h2FFOawcBgS2JJln/0SUzgZiHXYDwluV8mqWV+mePu6wHyyirVkTltiEmlqS5tVilFkwjWj4D
X-Gm-Message-State: AOJu0Yw3gYrucWpDGWbxFtbTCTXG79EKNiyce4JpvnMyhaWJOHakv5Fd
	4171tU51egMi2ppqMmKvaduVwkxYEammNwM5ZQuK1Yt8H+gxgSSP
X-Google-Smtp-Source: AGHT+IFVsMQUoRMF4y/UVf94fspiDFcjRwoOpU5HZnFUbEmNg7J9MPj6KtukntVHPgvuCe1Uf+rVmg==
X-Received: by 2002:a17:902:e548:b0:1db:fd93:8d4d with SMTP id n8-20020a170902e54800b001dbfd938d4dmr4949031plf.15.1708625081545;
        Thu, 22 Feb 2024 10:04:41 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902c9d200b001db90df1283sm10221542pld.4.2024.02.22.10.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 10:04:41 -0800 (PST)
Message-ID: <42d7d12b-bf5c-4bae-a48f-fa44acfa790e@gmail.com>
Date: Thu, 22 Feb 2024 15:04:36 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rust: locks: Add `get_mut` method to `Lock`
Content-Language: en-US
To: Mathys Gasnier <mathys35.gasnier@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240222-rust-locks-get-mut-v3-1-d38a6f4bde3d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/22/24 13:26, Mathys-Gasnier via B4 Relay wrote:
> From: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> 
> Having a mutable reference guarantees that no other threads have
> access to the lock, so we can take advantage of that to grant callers
> access to the protected data without the the cost of acquiring and
> releasing the locks. Since the lifetime of the data is tied to the
> mutable reference, the borrow checker guarantees that the usage is safe.
> 
> Signed-off-by: Mathys-Gasnier <mathys35.gasnier@gmail.com>
> ---
> [...]

This looks magnificent as is.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

