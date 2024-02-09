Return-Path: <linux-kernel+bounces-59879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C384FCD5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1FBB28B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4680128378;
	Fri,  9 Feb 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSNy5xom"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B063982D7D;
	Fri,  9 Feb 2024 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506866; cv=none; b=n6OGtqS5/17A+wDeS5BMxS4HxUcbir8nsdsKNV2auBYKhxCNpcvJ2Jr7QkOGH1jjtbACsDFnf3kb/WfXlMN3xRz7IImGNam8m/+dRB+iaDksh9qqjz/vsPwmECYT5KUVzBCkvNMfnni/mBL+MDToNyjhc9reHPMfwvp2SUyok/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506866; c=relaxed/simple;
	bh=jDbzF6VScX3QUjdWze8ERiOzUBhPy/DsoADy5/uvQtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKQE26dZV8nfWMOaOvWaFl6Xl9UKnry3OBN5x560F4NDcat6PDgLVewHq948+mU2/7YcLWDpVreP60kaqLqinffuVvJLw1gL/gX8uGzODimTAvA5f79oDQWU6w5ODEpPiZ80jAQfAOK7dtBcJD1cFuPyr+e3wIsuOfwCkmqWLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSNy5xom; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d934c8f8f7so11344185ad.2;
        Fri, 09 Feb 2024 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707506864; x=1708111664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=df/riqJTurTOuR2yinSUCFr965WEtGNwDF4ukmNTmMk=;
        b=iSNy5xomJSsvvzYgh/CXxJ0nNOhPGZsxON4bJiFmhs6XBzcJvwdX6zoDOONXdHvPaM
         k9RiBDe+xJEuP3lS68hWaz6sEbTc459nbT/ZXdKZcEnb2WgEdwPlRMeoirBE07LpJ1U1
         aEpOGjvNfUpQUuRJqJQdNy9VTUyYq1SltMBF0+i2WG6bPMsDBwJ6q6g0wqQ8gniU9jMo
         R2l1l0OelESiVfcGHrUJXK9u5Uia+wTdTB42cCjtl+hWfMaFfRlNUrUyGf7Q0+/cT0rX
         yvIf0W9tT8mZoTWxwLJK1zQ4n1xrSv5+ndXbjU3Mfev93hKQWfdseVi6pLWyOEMSJQiz
         auow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506864; x=1708111664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=df/riqJTurTOuR2yinSUCFr965WEtGNwDF4ukmNTmMk=;
        b=W6fIaFBbDN0yCREJFT4K2eVX+P2hoWRjKMih3wDVMqVFALV4SRYQaUBUYcnfwILwRp
         EFfMbutzliYr0HxqhXycP2bWEejllyncKTXAVpvGrFN+tXPQJO7TTwWYq8dGHE+sWFx6
         tRWjrbhGcK2fX18HKj1FzXgQ/lDERHH5Qch+DrPym8A7xyiVAtczS0tvJX2rg0z22PLc
         q7uBP5f48MlT2GgcLwsN2rleZsUDnWoCVcdh337HL8ivUAwhtPO8c1d4D4hXlLohBhQE
         hnl717pUnbD1ndgd+s2ZWT2fhaRyKrLh3fyF8GDEuPutXcc36APZgzuKpI/i5YlWd/Dl
         E1mw==
X-Gm-Message-State: AOJu0YyA93Tic3q9kI3+OBHc8UQKG3qfTJxorH0Zm/I0PCDXs4taLxFE
	QRB4R+VqX+6Icg0EdJD6NBMlnSwx7VTIDA3blsmU8/+Wih0ZZrI/2Xm2Ng7o
X-Google-Smtp-Source: AGHT+IHKo1JdiJyvK5M5ppYyDpZaWRQUWvwp3Fufr1nQ0FlyI+yVi2LRdYQCOqgQgn34mtIpveRN1A==
X-Received: by 2002:a17:902:e746:b0:1d9:4d3f:cbf8 with SMTP id p6-20020a170902e74600b001d94d3fcbf8mr203653plf.22.1707506863600;
        Fri, 09 Feb 2024 11:27:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqcRVFQEdvxv3X2dx8Uc/6n9SUnjIbHxIPCu2Pp22tL5YM1YE//Sxapr/FUXwJ/mpEw3GTwTOlYpN0VacpW1jwlEnrTaZITmynvoKDwgCyL6Aa3WWRh+6FrD7K3+F7LqtkIdxa9I8fUi80g3/4e+gio/6IUq9RJrLwAG2U4zQVPHmINcSmzm/wgLBmSsKRkpqhVtX30o+VT6H4vhk61AUYMyqjaIxpGXhtI0wGo4tY+bNGRi3tiFTMyNIH92sjd3q7Qy0t+ErhhNvnExp9cggbT4Axw+9PHyoYh9dU+6t0GCogpf7yVUwbNngukSFqh8Q7gexQFuGCtqu4zJMf/NSleMwovOiIVZKAMH7aNYf6Qew=
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id kz7-20020a170902f9c700b001d9557f6c04sm1843104plb.267.2024.02.09.11.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 11:27:43 -0800 (PST)
Message-ID: <45395395-9bbe-4ee8-9a4f-f1890cd85752@gmail.com>
Date: Fri, 9 Feb 2024 16:27:38 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: locks: Add `get_mut` method to `Lock`
To: Mathys Gasnier <mathys35.gasnier@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240209-rust-locks-get-mut-v1-1-ce351fc3de47@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/9/24 13:22, Mathys-Gasnier wrote:
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
> +    /// Gets the data contained in the lock

I wish that this doc comment mentioned what you've said about having a
mutable reference avoids locking, much like the documentation on
`std::sync::Mutex::get_mut`. If you do so then you can add my reviewed.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

> +    pub fn get_mut(&mut self) -> &mut T {
> +        self.data.get_mut()
> +    }
>   }
> [...]

