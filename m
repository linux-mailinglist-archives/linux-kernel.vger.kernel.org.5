Return-Path: <linux-kernel+bounces-17114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A97C824874
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C16B2B21019
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB7328E31;
	Thu,  4 Jan 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nERtoKPv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ED728E1C;
	Thu,  4 Jan 2024 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-781bbb1f61fso50840485a.3;
        Thu, 04 Jan 2024 10:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704394678; x=1704999478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os0Q/0d6OHlr8j+k0IDP+XVC9EPOxnxh9xNoVL0KlNA=;
        b=nERtoKPvOQ61y3PFH/xXlQoDdelJZLdG9/d+rCfidZBdInDIQyIJN9WHt5k4fPXKug
         239z/TVCTHx6U1ngHXEB5+NUbQTjWn5LWEn9fCzdmZvJ+gRss9AGjdD0bBKET9043Qs8
         GwCc7Hdwd3kQrCgSx8phBoBmpazXCwcX/iYbYSnWD3AYb2AszOairnBBu+CuFGcdyege
         8VK367ohP8TE9Trxc5pFN5UAGqeFdKFGXJDflWvymW+5QSfe8IjmijeSYHVA7u8o+fYs
         +8nGdzfXbTnLw1otEEkCdZPMojPa5hGmQlQs8DDHvoWNpfJshUHGdfnX7VnCvYcO5cl7
         zssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704394678; x=1704999478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os0Q/0d6OHlr8j+k0IDP+XVC9EPOxnxh9xNoVL0KlNA=;
        b=sWJh7L23uQtLGfxjwE2bmxI4PgwQaXzOZYmtGFHJ+Nw5tb5fmdmoD6QbjET2OY9oqj
         5odA7acmuU3VMWwpMA12PnNMJ+VNL0FRyEVG1rNuxQodBe8FocOIrpiAytMMDdAx+TiE
         T+/tRI6UC52/asrPJIfxzAy1oWwcbDdYz3fFpfW8EbMT76aS0C+37YbEQfuiL25KRsN6
         rwkwiMCAUIdOKGbhfkSRutrVfoX0oFAycvxiFuSLmckOyeeGMsLx3UzhFcvD80nS2ETg
         0DlXs7NGLWk+InM3HLRSseeYwyw/pKj3X5kzVuy5Mdua/Koyp039TT7TyW6Pa3hLUbA/
         MPTQ==
X-Gm-Message-State: AOJu0YxG9p+EBS+I3HHaXuGZo62xxtZjONBBfUKOyIPtimRT9YSXi7TU
	OmfbnQ0yqToQ88NNtMMKh9E=
X-Google-Smtp-Source: AGHT+IG3Jz7XP5tqSJlZd5J/1soCB5RuN3ECigH9ftKKw8A58MZkLBun3ccOrzg/W+xI1CQmHWW0WQ==
X-Received: by 2002:a05:620a:f0f:b0:781:5e6a:355a with SMTP id v15-20020a05620a0f0f00b007815e6a355amr1082524qkl.155.1704394677738;
        Thu, 04 Jan 2024 10:57:57 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id vq10-20020a05620a558a00b00781df19c062sm15990qkn.59.2024.01.04.10.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:57:57 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailauth.nyi.internal (Postfix) with ESMTP id BA7FB27C005A;
	Thu,  4 Jan 2024 13:57:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jan 2024 13:57:56 -0500
X-ME-Sender: <xms:s_-WZUQ3a99E-Jwuce37xzgVqXtjfBU-JGOZhjPyPZT4idfpFskjCA>
    <xme:s_-WZRy886ax7TnoE34U09hMari-SGlBPMjCdM1bn8eRjJY2Dd7yo-7eXdACXycKo
    9WMS5ir12fSbrn5Sw>
X-ME-Received: <xmr:s_-WZR2Y-Llr6-Tu5NtCriuuvjsP6gia6eXXNbpsIo9sRUpyKik3c_P_A1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:s_-WZYA-Ii3QicgGVI546f6coyNo5vbL2VSK3iaF_Lp5EVj3g5aT1g>
    <xmx:s_-WZdhg_9WsBTZvOkhG6_aYuqvv2GssNgw0g7EY4PwR03EXem39fQ>
    <xmx:s_-WZUroxKZjMdChDzY9HjjkV0vCmHcz6LzyBktDmKptNtc1zONoEg>
    <xmx:tP-WZcSjhowKUlxIbzAiRbvKAaSXSxpUeEi1vtQRf02jt0-IINgRGw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 13:57:55 -0500 (EST)
Date: Thu, 4 Jan 2024 10:56:47 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rust: sync: add `CondVar::notify_sync`
Message-ID: <ZZb_b-6f9Ib1NdOt@boqun-archlinux>
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
 <20240104-rb-new-condvar-methods-v3-1-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-rb-new-condvar-methods-v3-1-70b514fcbe52@google.com>

On Thu, Jan 04, 2024 at 02:02:41PM +0000, Alice Ryhl wrote:
> Wake up another thread synchronously.
> 
> This method behaves like `notify_one`, except that it hints to the
> scheduler that the current thread is about to go to sleep, so it should
> schedule the target thread on the same CPU.
> 
> This is used by Rust Binder as a performance optimization. When sending
> a transaction to a different process, we usually know which thread will
> handle it, so we can schedule that thread for execution next on this
> CPU for better cache locality.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/sync/condvar.rs | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> index f65e19d5a37c..1a3f7b8e03dc 100644
> --- a/rust/kernel/sync/condvar.rs
> +++ b/rust/kernel/sync/condvar.rs
> @@ -155,6 +155,12 @@ fn notify(&self, count: i32, flags: u32) {
>          };
>      }
>  
> +    /// Calls the kernel function to notify one thread synchronously.

I feel like "synchronously" needs some explanation here (e.g. using the
same description in the commit log), but let's see if other future users
really need this ;-)

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> +    pub fn notify_sync(&self) {
> +        // SAFETY: `wait_list` points to valid memory.
> +        unsafe { bindings::__wake_up_sync(self.wait_list.get(), bindings::TASK_NORMAL) };
> +    }
> +
>      /// Wakes a single waiter up, if any.
>      ///
>      /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> 
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

