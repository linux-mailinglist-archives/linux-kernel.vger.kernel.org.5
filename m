Return-Path: <linux-kernel+bounces-17302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EE6824B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EFA1C22A49
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2802D025;
	Thu,  4 Jan 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsTGqUy0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DD2C6B9;
	Thu,  4 Jan 2024 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7818ab57d7dso70371485a.2;
        Thu, 04 Jan 2024 14:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704408333; x=1705013133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SeB4ajz7ViEKbPrOyH94bEBl7Qai5rs8f9JUUiOHPqg=;
        b=JsTGqUy0UYP8yZSKrgi5JK06MEG9SIjNh3O8XHQOBPMsOtnnxyZsMgPqgxjcnMBQHS
         KbjQmBuAS4rNRH36D8ZlYVkNEs/jQS60pgj850WPk8m9NlshfbL8WsTKZPjtewVzOK0D
         omZhw6nAZuIQ8p2X1ZitZXvcN6PMm8jyRanrjkw2tHsm0yKqJD0zBejYLSUWlv0j1D9G
         6yBJzgc+xRLouC7mLnit2uaX2p+n7DWjxLfa5ByxQmKMIbrAbXqnbKEwjD0FjOlOx8S0
         8M1a/j35FyfPB3h4wEqEGqjPcvxlmlb3mLanmHCdl06f3KQnA4Vp2IzpPNm2qSI1RXMN
         SLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704408333; x=1705013133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SeB4ajz7ViEKbPrOyH94bEBl7Qai5rs8f9JUUiOHPqg=;
        b=qoBTUS8b/rGhoqf7htXxoYLLLoq/mreu343Zyl/9aHo659SvhMnNl9cD5JcGqtlLH8
         +eZYsPaGO7/doLbcils5qEhXDGeGnTY2oajqcWe54nxsSCZLjnrdfv5YPi6AI6+M91rq
         HiEPFJfio/5Ocz6NKDGFZJYtCqLNAtIajVfcxO2JuYEjRojImJx8IOf4EcvOIhsi99n6
         rGFb5TLdKHop5sL2yLpUPKTNVKBA7yukXIEvcnV7qJEhcHAAvjlhWgRYcIMVug3c9xo2
         cBy8ViLYCZnPi9Ov2a5OX6PwZrUVCxvENeoOGRDe2cu/vBH0yqtXPEXhC5JPZnoqh7U1
         Qfnw==
X-Gm-Message-State: AOJu0Yx4cPEaEIsAyONeLvY3CdgLfrcptECiUn63aVwDbVvt/Sgyygcd
	hDIwddHXK8MOhIN5jJPloBk=
X-Google-Smtp-Source: AGHT+IEkSfRFJYtHdahczAAKNlPFOE2vriKZn5YLfVdSWA5iboKWQspqvRQ7O5mnKMaAXeno6rMkxw==
X-Received: by 2002:a05:620a:90f:b0:781:7a9e:6a55 with SMTP id v15-20020a05620a090f00b007817a9e6a55mr1159549qkv.131.1704408332809;
        Thu, 04 Jan 2024 14:45:32 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id c22-20020a05620a11b600b00781e1c466e7sm141707qkk.24.2024.01.04.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 14:45:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0113527C005A;
	Thu,  4 Jan 2024 17:45:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 04 Jan 2024 17:45:30 -0500
X-ME-Sender: <xms:CDWXZR8ciP-YmughSHYIWkEVVs9KOfSmFpLtib51cd12hXYVJ1boHQ>
    <xme:CDWXZVvvwSzUnwIFDml24jFSqwDj8ly0RWdctQV-fVbzU-dxBge_GiEOXvpvmXjcN
    QtZcEB8v0PpdOU_Ow>
X-ME-Received: <xmr:CDWXZfAD49RFsQiFg8znmQAeDhTb-cMaq5uWyi9PzsZiVPICiYFppc3cxTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegkedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:CDWXZVe5VaDiwYAfGKo1bOgOubuS2yFwYOjTeiz6I5AuWXdCvt_RDg>
    <xmx:CDWXZWPYe9NoZ5-R5TZ-6iNIuHuOUtNnR5joNB--Z8ntu4oxfaGqmw>
    <xmx:CDWXZXmwTiaESwk2YFchNefwEELkfF25c_rQJqu-HJmxhaa9JDZZHA>
    <xmx:CTWXZbfJ9Nyf50VtNerqlM6mOp3a06roxJ1tRet8yZA9trYry5rhBw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 17:45:28 -0500 (EST)
Date: Thu, 4 Jan 2024 14:44:19 -0800
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
Subject: Re: [PATCH v3 3/4] rust: sync: add `CondVar::wait_timeout`
Message-ID: <ZZc0w9tr5NmPAcNP@boqun-archlinux>
References: <20240104-rb-new-condvar-methods-v3-0-70b514fcbe52@google.com>
 <20240104-rb-new-condvar-methods-v3-3-70b514fcbe52@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104-rb-new-condvar-methods-v3-3-70b514fcbe52@google.com>

On Thu, Jan 04, 2024 at 02:02:43PM +0000, Alice Ryhl wrote:
[...]
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index 9451932d5d86..ffb4a51eb898 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -7,6 +7,9 @@
>  use crate::{bindings, types::Opaque};
>  use core::{marker::PhantomData, ops::Deref, ptr};
>  

Missing: 

	use core::ffi::c_long;

here.

Regards,
Boqun

> +/// A sentinal value used for infinite timeouts.
> +pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
> +
>  /// Returns the currently running task.
>  #[macro_export]
>  macro_rules! current {
> 
> -- 
> 2.43.0.472.g3155946c3a-goog
> 

