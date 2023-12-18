Return-Path: <linux-kernel+bounces-4401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E5817C87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA181C22A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C2740A1;
	Mon, 18 Dec 2023 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asosZS70"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF957349F;
	Mon, 18 Dec 2023 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-203d93b660aso495450fac.2;
        Mon, 18 Dec 2023 13:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702934315; x=1703539115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOmrfIW5eJBghH2IGSILpqWH2xjKkYNm0aalCAYtY94=;
        b=asosZS70hzXzFnS8xH4XSBocBchbz1ZMJoSQJHxh4xWYGcwBmzk1JCiZGr0MoivoMm
         QK6t4N+ztuFyJPRgtqY04RPgl3qW9FQckl/62ytpD1Kq+xkUa3o70DoiEhLtVjGH7Yo2
         At2k+gCpSGODJ9MBW4pm/4zja0htETK0C9vY2bhHaec2FofEfI9crOzQjed4yJsGdn0a
         XB78qsY+l3rlUJJGp41cqNS5E4ZULUwKcQILBxTOUdE4xFIxQUzg7SR5KjWadJXlZFkG
         Jp/gaTcQJS8257fNhpOnx2kcoSSmskZffeWyWmgJ2niUZr/epQAAo9hwS6Rsn3QHFRzm
         PHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702934315; x=1703539115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOmrfIW5eJBghH2IGSILpqWH2xjKkYNm0aalCAYtY94=;
        b=T6wkA7KIJIRVQXbDLP4CBQx/xboj0O9AGFzQiA4CFNcMNNYUSGQpqkSJ+hAHQdB13g
         kauiGzaUd2YgLh+8LtS+4aA1r73XneEjNn0kW9A1musSTG1YLJ4joOQi6I9BF3sfKCH6
         u9BD9mZYdN/ox6NWKkUrke39HqvP3f8hZK4ldNuL9JTaTn1/OkTaiRuiXh4YnLI9kf1X
         g2A3+cJ+S6/cogLNI0KhVuC1RwbsNXmJTVcj1RPFtGLlbObQntMQlmE5b6TFlcx/nr+3
         io2gqWQ00xjQNzl7HhmAnqupOvDklEUit/xWU8iogUJwdSTuur8Vrw3TBmBix5i8dDAI
         C2hw==
X-Gm-Message-State: AOJu0YwZwXLkWvzLOErA8ti23q9TZX2DGQQDi8Mau/8+KwhvP0W9T09M
	2AsugBMTIkhGkDHGJUWj4FlId3Zd23w=
X-Google-Smtp-Source: AGHT+IHvIUeVpUtGvTKPYHto8r0dPkeMKthPz7UIXmh2sdRvbbYarC3PtvYt714IF00thQh6Tq4+tg==
X-Received: by 2002:a05:6870:1581:b0:203:eb9b:9929 with SMTP id j1-20020a056870158100b00203eb9b9929mr71891oab.56.1702934315176;
        Mon, 18 Dec 2023 13:18:35 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id rb3-20020a05620a8d0300b00774350813ccsm8608953qkn.118.2023.12.18.13.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 13:18:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 6577727C0061;
	Mon, 18 Dec 2023 16:18:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 18 Dec 2023 16:18:34 -0500
X-ME-Sender: <xms:KreAZZ0c43n58S4xMPrbfwbHnaPZHKoqANJfc48XbFS8oI36bolTvA>
    <xme:KreAZQFZGsA-Tc9aUZsx3No4_Zp4n3Xfk_6rS59NQAGOrrjJ0xCmj9wrCJ9OfQKtW
    UbCqkgaxvqE-HswVQ>
X-ME-Received: <xmr:KreAZZ4je1mEQjDA0RpFP6ircFKp0GkIxckch4WZ4NjpQRmg_ueuzVcQf3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:KreAZW2K-dlA2liv7XiiEDBgYSvljcb1gL0mCi_JqwIAcsNPe3VGOQ>
    <xmx:KreAZcGiXWCD61IbbiqBIO_HUOBXvdWc5a-s637xL_I69Emo3FNnuA>
    <xmx:KreAZX9O6hDXQaQ7xELRpRAEY2PTv51qdwzLaKUbUcI9A5f1tYlWUg>
    <xmx:KreAZSGEfNe2AifqIm6twrzLX38RoMY6ErTgZaBvm-GZjPihqdBtLQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Dec 2023 16:18:33 -0500 (EST)
Date: Mon, 18 Dec 2023 13:18:17 -0800
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
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] rust: sync: update integer types in CondVar
Message-ID: <ZYC3GR6LMEmRUQy0@boqun-archlinux>
References: <20231216-rb-new-condvar-methods-v2-0-b05ab61e6d5b@google.com>
 <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216-rb-new-condvar-methods-v2-4-b05ab61e6d5b@google.com>

On Sat, Dec 16, 2023 at 03:31:42PM +0000, Alice Ryhl wrote:
[...]
>  
> +const TASK_NORMAL: c_uint = bindings::TASK_NORMAL as c_uint;
> +const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
> +const TASK_UNINTERRUPTIBLE: c_int = bindings::TASK_UNINTERRUPTIBLE as c_int;
> +

Similarly, these definitions are better in rust/kernel/task.rs.

The rest looks fine to me.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

