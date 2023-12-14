Return-Path: <linux-kernel+bounces-46-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD83813B26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2702848FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F526A022;
	Thu, 14 Dec 2023 19:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVs72TxT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642CC6A008;
	Thu, 14 Dec 2023 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-77f43042268so80927085a.1;
        Thu, 14 Dec 2023 11:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702583925; x=1703188725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1t6WW6PWMVyvCR814CfeWvXobbx/+dvid0mhpQK6M3k=;
        b=cVs72TxT0B/I3Evlyi2DnSId2EDSvCWk1rRxZmTW1oTEcJzgwpJgoyOWBuGgS5EoHS
         M1VjfFaSDu4ordfWLGwjH+ZSJb1BlWVUck13Si7mWj3fQcgV/zuhnU9iehAd76pFQz6f
         mjq6dVNucIw+Nz9X4yQdR2SGb0DAPhHzGExXu+5xgNH7J6nltbLwgqdog7lL1Gf4ufgk
         bF0e+1xVkzuVUYPWlZi1nhSQlv7/cKS99sebhNJMBgLzU9ToT2L+QwbcdqzBM/DkQgMu
         w5ZH2HDua+udLMsOSfMjRzkfSlN1Tujqy5N+hw3ZTFzGvyx2W0l6+MkkwzCZpNNmKmD+
         CWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702583925; x=1703188725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1t6WW6PWMVyvCR814CfeWvXobbx/+dvid0mhpQK6M3k=;
        b=LiT1ID+mIwSJ0oYvMSzvycYerHCWwW2ze6mXDtvGuL1uaYDLFyiVZ1dUFQUm+ZLjhH
         3RuIq6urpkw2uMz4CwnA94CvNgxWOk6fV60M67+WbAWPslT4aQkZXrkOR4g3UGYtdQyD
         c79MZLwXTuQ19ZQ8PFmeN3fPNXpUZlNJq1xGrXRygjM3Z/2y/4IjODKvz2tbNMtubDyc
         dD3QRBDQVoiIF1OQcabuSW5r0swp4pr7Ah2szPJZ7jCuYrc8hO5GhBqzLhfOdWQp2nXe
         bwtKFXAqQ5x/fQR5Gb5/Z5ZK5RTZD3k2XW/+gbnTQ34jlwNONmBHyHkBJCwaqzDVz8N1
         mi5g==
X-Gm-Message-State: AOJu0YweLuXDtdo+dYGh6pwQ9oFr/Z9wlJWtI5pIBC2VddgKpYqBByfK
	LwqWyCNvVzMo8UkmyrhTIOo=
X-Google-Smtp-Source: AGHT+IHK5Hav9qDBYMj0E6PWx/Gbo9fzYppeB1SPymcXaiXRC8NBhEw1U2kuCBOWMdAAAVkett9s2w==
X-Received: by 2002:a05:620a:2ed:b0:77f:8b0d:3b3f with SMTP id a13-20020a05620a02ed00b0077f8b0d3b3fmr6139187qko.42.1702583925179;
        Thu, 14 Dec 2023 11:58:45 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p27-20020a05620a057b00b0077a029b7bf1sm5539453qkp.28.2023.12.14.11.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:58:44 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 4BFDE27C0054;
	Thu, 14 Dec 2023 14:58:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 14 Dec 2023 14:58:44 -0500
X-ME-Sender: <xms:c157ZVuf0TwiLRO6GK_JgeyiAI3faQvbJ7GrUbdyBuomjjQIX1333w>
    <xme:c157Zee3RlSP9uQErgB7tm7NzO93sOfLvt4b_OpCfevl93TBd4EID_q3YhvoIUsoZ
    RDu23FWceEa_eklbA>
X-ME-Received: <xmr:c157ZYwvqj0FpNGDAdUZmCYEcxJKs8rU7AoohTMmVxKgpHufsLC7Xvh4cpo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:c157ZcNyIapo7mftG72Pm8SUQbsOSH1aNs_hS86dYlB2tFTUPUXIig>
    <xmx:c157ZV_TYJ-xM286AQ37pL_jehRH1Vtd2NRh_j_4k2BOg5tD0E7VVQ>
    <xmx:c157ZcX1m5hsS6pte8rlmutHiv0hnLyM_33_GosVdclWq682OIdhtw>
    <xmx:dF57ZZXI2ubr1HBoZKNgihy76LT_JM0gFbQ_5lcrYMfpRsmu_oV0Gg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Dec 2023 14:58:43 -0500 (EST)
Date: Thu, 14 Dec 2023 11:58:38 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tiago Lam <tiagolam@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: sync: add `CondVar::wait_timeout`
Message-ID: <ZXtebif2S1CyJRik@boqun-archlinux>
References: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
 <20231206-rb-new-condvar-methods-v1-2-33a4cab7fdaa@google.com>
 <1dd1a3e8-ef9a-4e89-891f-b49d82acc5f8@gmail.com>
 <CAH5fLgijsRK3funsGuG6nbK26C+s6m0nO0i83RYD2cO3z7L22Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLgijsRK3funsGuG6nbK26C+s6m0nO0i83RYD2cO3z7L22Q@mail.gmail.com>

On Fri, Dec 08, 2023 at 08:37:27AM +0100, Alice Ryhl wrote:
[...]
> > > +    /// Releases the lock and waits for a notification in interruptible mode.
> > > +    ///
> > > +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> > > +    /// thread to sleep. It wakes up when notified by [`CondVar::notify_one`] or
> > > +    /// [`CondVar::notify_all`], or when a timeout occurs, or when the thread receives a signal.
> > > +    ///
> > > +    /// Returns whether there is a signal pending.
> > > +    #[must_use = "wait_timeout returns if a signal is pending, so the caller must check the return value"]
> > > +    pub fn wait_timeout<T: ?Sized, B: Backend>(
> > > +        &self,
> > > +        guard: &mut Guard<'_, T, B>,
> > > +        jiffies: u64,
> > > +    ) -> CondVarTimeoutResult {
> >
> > Should this be called `wait_timeout_interruptable` instead, so that if
> > we need to add one using the `TASK_INTERRUPTIBLE` state later we don't
> > need to modfy it again? It also matches the
> > `schedule_timeout_interruptible` one in the kernel (although that's not
> > a reason to change it just in itself).
> 
> I don't mind changing the names, but in this patch I was just
> consistent with what was already there.
> 

Hmm.. so Rust's wait() is actually interruptible wait and we have
wait_uninterruptible(), while C API is wait_event() is uninterruptible,
and we have a wait_event_interruptible(), I think it makes sense we
follow what C API has. Will send a patch soon.

Regards,
Boqun

[...]

