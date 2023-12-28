Return-Path: <linux-kernel+bounces-12839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A2A81FACB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8611C2153C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8EF210787;
	Thu, 28 Dec 2023 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTVSYQiT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE302101EF;
	Thu, 28 Dec 2023 19:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-427fa9ecd60so4148721cf.2;
        Thu, 28 Dec 2023 11:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703792583; x=1704397383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zTgUJfJIqNmJzukT+nSgAgZaf503JH2MNH3MI61x1Y=;
        b=JTVSYQiTkf+8LV4cSzqFN66gZs2fcqS73BK18u4hYwnMuPDYEcVO/r33q7giam9wG9
         6F4wP7JsITTWkby3sWcTTwq7iFdxQURX1BfaesHiIQsoB9FLI9m1LT1DnL5YpgagXK0V
         rv9i5i8pqOzZQrfYlWuAqHIMkRqnCjh3M3VjSv1DcUxttxgJPeRF6zXs6QT5MG343Zla
         tGI0KZM8sUj0c30PPmLsyVK3BXmLrkTJvYwYUAhUFHr6VPo4SX6iyNh0HeLJPzZUKCjk
         QbfYrLhol18cc16j5xac0Y7LfTFPw/6LLORsvA4qCI5StQkAU5qyqlojDnmVjYBVlvfE
         5QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703792583; x=1704397383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zTgUJfJIqNmJzukT+nSgAgZaf503JH2MNH3MI61x1Y=;
        b=ACrLjXYXkht+W5JrYURwe+ma4TLJDujxVCrDpMdbXENRWT5ZGBvDuBczr+8191drTb
         DpKaWuyaGKeySfvGhb6QokR3Zy1gII51yoWVgfY9qHgztp8TUaimqsMM2/vqLcwTnWGC
         ICju9Ts0YqHWqX+LsPMj7K3NB95q19yN4n4YoGqZrG/4fthMcqctxyU6CewcqX/GOIBe
         K8sE2h/0bKQRww97vK3+UQPR+2e8ddi/gBMIuvfYNVO8sVNVuuvmoo+BsggefLm03pZx
         eovKYJMigKPO/kvNgoYM4uoAJVtUGbQ9MAacPfTXarJ3lj/eLs9DT1pME9uNxqm/rucP
         FX5g==
X-Gm-Message-State: AOJu0YxLqCaeUGeR/aaddu6kX/J7OBPKGVAy5Bn8VZnW21MXD3WYuriF
	4bB5oGSpzr5mVRMtRNGOLBM=
X-Google-Smtp-Source: AGHT+IGxOTxwgAz40c0YA6Bu6/T7sUpBSnJBsiff2q1myvGIgQ/KzGmg6oDaDqLDi8HB5BCf/FuvvQ==
X-Received: by 2002:ac8:5754:0:b0:427:892a:edfe with SMTP id 20-20020ac85754000000b00427892aedfemr17790770qtx.66.1703792583543;
        Thu, 28 Dec 2023 11:43:03 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ks22-20020ac86216000000b00423f2acc614sm8399072qtb.87.2023.12.28.11.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 11:43:03 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 90C7627C005A;
	Thu, 28 Dec 2023 14:43:02 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 28 Dec 2023 14:43:02 -0500
X-ME-Sender: <xms:xc-NZUXKy1ErXIJJTrfxCif2itc5hxSLUDkm8vbPYpaCoY0aeGBN5w>
    <xme:xc-NZYk5EYGLTb0vPu3yeZnE8m8YgJDfm2qBjrjr90A4mB3teUsV6vEtkFP4emFfA
    Se-UncdZuvdQKZw0Q>
X-ME-Received: <xmr:xc-NZYbtsj3BltQkFBlYatYUXmUtM9L40rK63AIzpwiLN-z0UlndhrfNunY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfedthfeuueeihfeihffhtdeluedtveffheeiuddtieehtdduiedvgfej
    ffeuueefnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprhgvlhgvrghsvghsrdhmug
    dprhhushhtqdhfohhrqdhlihhnuhigrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:xc-NZTXyAHdHhfoZRtfSNS-u-32HkHAxWl8sAgMASKstQknwod8bCQ>
    <xmx:xc-NZemCIgD_F8T3TmCU5f1nLgGl_F9WermBgWNf8iH-yM302H2u_Q>
    <xmx:xc-NZYevAU7SmQa0YnoQh_Ta1nVxkcYYCxwBnT7mlqc69ylYsgv5pA>
    <xmx:xs-NZXehw49VsnhL_4Mdid26m-v4L0zpffC8uy4rYU8TqQWMBSXr3A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 14:43:01 -0500 (EST)
Date: Thu, 28 Dec 2023 11:42:14 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: upgrade to Rust 1.75.0
Message-ID: <ZY3Plt92Jn5xSmXw@boqun-archlinux>
References: <20231224172128.271447-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231224172128.271447-1-ojeda@kernel.org>

On Sun, Dec 24, 2023 at 06:21:28PM +0100, Miguel Ojeda wrote:
> This is the next upgrade to the Rust toolchain, from 1.74.1 to 1.75.0
> (i.e. the latest) [1].
> 
[...]
> Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1750-2023-12-28 [1]
> Link: https://rust-for-linux.com/rust-version-policy [2]
> Link: https://github.com/rust-lang/rust/issues/91850 [3]
> Link: https://github.com/Rust-for-Linux/linux/issues/2 [4]
> Link: https://github.com/rust-lang/rust/issues/96283 [5]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> Please note that Rust 1.75.0 will actually be released next week -- this
> is based on linux-next since we will need to remove the `feature` line
> for the unstable feature used by the to-be-merged PHYLIB abstractions.

I have done some unit tests with this based on a merge point of today's
net-next and rust-next (along with some LGTM patches), all tests passed.

Tested-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

[...]

