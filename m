Return-Path: <linux-kernel+bounces-885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1273881477A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9627DB20944
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A45728E0D;
	Fri, 15 Dec 2023 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNdcbqvO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D15288B6;
	Fri, 15 Dec 2023 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3333b46f26aso409593f8f.1;
        Fri, 15 Dec 2023 03:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702641526; x=1703246326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOSoAzpa9vuWx+zR5R7BQ0XEtmn/eNdVlBchsDDSQ90=;
        b=gNdcbqvOA3bUNKEFNHsCTwYI6WG1E57YeLE0TwLBZrtHIaP/aG1nqADl0/4106KbyY
         RuWBN0x7XyRM0QLAKEI74Wn9uEM7/L+ic5zVBhEaUfTcA4arxKz+TR4RpBLfodwbKRtQ
         aEtdzpkQpa5htzK4hNkLbipxte7axDSZQCTDo5srLtGWAfEjsXles6mgPuu1z9ieEUS5
         fdQUZUo13ls68sCHaonskPNACDLJ3VLDyaN2RL1EFm+LUX5CaEqXMGjeItWcL0bzo2kO
         OpanbFe7ZpkT+dcU4nUYA2gMsVVA+lDCAiXFV6oWri6K832bU+im6h1nkqltoiwZ2Gkw
         Qpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702641526; x=1703246326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOSoAzpa9vuWx+zR5R7BQ0XEtmn/eNdVlBchsDDSQ90=;
        b=ud8DX6KFpDDknmJfvIt84iNlSOGJWfS55P1CpiT9+2eGCL0mMtwHa6bbWijdg1X2ZZ
         5wtMWaSfZBf+Bql6jCTUT/HKbLJJlkwDOEOecvLW1jN051shZrYe/0Ywcp2U1AnuBOcY
         VLrzh8s8p4pcZL0NMm81snt7uTQAqwQVSMn9Mof5mlT6WKSIdPJTBHqONjzSLTOKqIxO
         5aqN5LPSUm4PUNtSiBwmLadT8ZnGSX3bqX5Uca7zxK6uHxAzh2CDvsD7z0B/M6C3KxD6
         KjFf+NMTVPK7YE77YHSk9ayDaB8G3+uzNhJmASc2MX/JvPo6SbjBP6aWDSl7a1CBmw5Z
         x1QQ==
X-Gm-Message-State: AOJu0YyZdF6W0WcpbCzmkr8xCXc1mBicLTWApEEGGyPvAPh4z/PPEFWl
	rK4jx+b7uJPp8oORWEUkLQ==
X-Google-Smtp-Source: AGHT+IFtyUgvvKCCK9/JOMSLBmQVceF3HuZU3hfDP7d7IEqdLuhx12woeZ8z5ATTiPmrG7VHrcKrew==
X-Received: by 2002:a05:6000:147:b0:333:38bb:f8bc with SMTP id r7-20020a056000014700b0033338bbf8bcmr5920121wrx.102.1702641526238;
        Fri, 15 Dec 2023 03:58:46 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id y8-20020adfee08000000b00336490c7433sm4081992wrn.31.2023.12.15.03.58.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 03:58:45 -0800 (PST)
Message-ID: <9095d5cd-5b92-4baa-b7a3-0a84bc1a8a36@gmail.com>
Date: Fri, 15 Dec 2023 11:58:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: sync: Makes `CondVar::wait()` an uninterruptible
 wait
Content-Language: en-GB
To: Boqun Feng <boqun.feng@gmail.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
References: <ZXtebif2S1CyJRik@boqun-archlinux>
 <20231214200421.690629-1-boqun.feng@gmail.com>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231214200421.690629-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/12/2023 20:04, Boqun Feng wrote:
> Currently, `CondVar::wait()` is an interruptible wait, and this is
> different than `wait_event()` in include/linux/wait.h (which is an
> uninterruptible wait). To avoid confusion between different APIs on the
> interruptible/uninterruptible, make `CondVar::wait()` an uninterruptible
> wait same as `wait_event()`, also rename the old `wait()` to
> `CondVar::wait_interruptible()`.
> 
> Spotted-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Thanks, that's clearer.

Reviewed-by: Tiago Lam <tiagolam@gmail.com>

