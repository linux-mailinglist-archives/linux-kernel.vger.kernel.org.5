Return-Path: <linux-kernel+bounces-119797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C1688CD26
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25C00B29919
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3335A13D257;
	Tue, 26 Mar 2024 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtZiGz1r"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19333A8D0;
	Tue, 26 Mar 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480932; cv=none; b=M0GdFKScaiZu3BENFS+2o/eHJckpwYh7wx/f2Sjea1AUpcSSyHpC8TWxyca+CbBo6tIr/roaESGAqhS72CeYC64XQW+jI9ECS01Ac8Y8y+vy3yqy1PLW3XTPe+0r3Zwr+OBJiqIzRMeg+fj8ddWp6/ciqLlZ3A4fHvbdo87ulvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480932; c=relaxed/simple;
	bh=9A69lqNVbjewNLP/BP8WnbYpmKhO8CPeO89Rbk7DpmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6DqsQKxWlxWI1gmYbUgjojLiU8SbHZ9BTLolDm6+zEnvcWywtsNkZZn83aUigXaLdi/RwMPiMKdTwHB+TnZuLEMgs5upNT5D/v9neB8VrHnFJNBQ19PgyPcYokrCoVf7H1BWSTYLb4pl+QMZVQbIF/IxXWgA+hauw6TV9zykLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtZiGz1r; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c3bc867eaaso2529542b6e.1;
        Tue, 26 Mar 2024 12:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711480929; x=1712085729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV7TbUWdy1KyRCYO59YjywGKYmLdtGd+fKg5ys9yxzU=;
        b=ZtZiGz1rZB6o/UIFXVJy+0HVVtgkB4oMKjZoQbR7+St+0jEv04Z+YcQ/4VuMMmeOH9
         MhZ/Q6iqumLq/tW/lY/pIRY3rMpUHcKx+n8uokUM2OxEoO9Zb50wsimPvD8kAR0WtjSz
         Jok721igWGPz+ba7S5wVbK/GB+yHUMaJxviYtnN8ndRzB1M6uuRCG1QI6zEaaGy2gFHS
         SwbqPMOfg77KhaTu4/giydoIN1VwBxapTPH9+hscuw5bufpubuG0D0A/4olnm25eef9r
         i/PEkKOBSCyybzp2eZukL3k0Mur8oTIAIYsoW8qXtU7ldIzbJk48bYEVl2iaW9BmwXj8
         dg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480929; x=1712085729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV7TbUWdy1KyRCYO59YjywGKYmLdtGd+fKg5ys9yxzU=;
        b=gr3gALnooUacB3no8sfA3ZRC0K0zMOzYbe7iPdn+m3cSLppfY4kr0IfJ3yaxUxR+rX
         aVRQDz/deoqKdDHdTkg44oUHFHGVqnv2Ow/DV+XZfDRUAxl9HNhNLE7BV0MjEda1iXKu
         ew/0MqxD+PmZpUO/Yj42xFkFr9Fv4ekZeYDQ7KbHvVpdrVMAeYIYNd4wfyqZUJlsZT3m
         aEO17CRcaC8gMd048AKiWKL7cl9//vNeKJysyLwphw4cGOOWI6DttPzYz9+TSQvMWVc0
         23RhwnwBSY+OKBj9PYgxjWzFVy/RgysxfZCQPKGHX6XXIrvM6FikkXX/CA8x5O6M7IBu
         5oMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6VrRgwO3249dZDg3KE8Cn1bYfnFCCRGDnrLF62tu/36kMQTzz95obd1/MuXFbUwnQ0jFF3tB4mzJ0Xxw9W7Vuynfuftt6kgfGQKFE
X-Gm-Message-State: AOJu0Yx6ia6uXkE+KLbrhWU9Kjqt3fvcLI5tM/ee97O2FKE872h+LWUt
	FS1lHg50u4swqS8xyY+eD+foFCCUIqZkY5mMdUx2OflpDHn2ZHdY
X-Google-Smtp-Source: AGHT+IHC/whWIb5f7tECwf7A0UQMEXrKng+dG3uxqdzchxqqCcRP5dcgebE2tGuTG87EDbS/q34T2w==
X-Received: by 2002:a05:6808:90a:b0:3c3:af17:fa34 with SMTP id w10-20020a056808090a00b003c3af17fa34mr1890703oih.16.1711480929338;
        Tue, 26 Mar 2024 12:22:09 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id jm14-20020ad45ece000000b0068fb6fb217csm5513558qvb.122.2024.03.26.12.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:22:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 730FA1200066;
	Tue, 26 Mar 2024 15:22:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 26 Mar 2024 15:22:08 -0400
X-ME-Sender: <xms:YCADZuxfXiOUUajC6pJLwNx7RnLvrtC79zfHq81oKTLK60xE3ZJWOg>
    <xme:YCADZqT74jaPy27aqsbqmjcMgQQw9aEc8I4OokIOj3_o0xbmlMf2-IQxDdp5rXBbP
    SuSIGp0jhMOXf96KQ>
X-ME-Received: <xmr:YCADZgXVSncUsb00sNAmEH99PYOxW0lJAKkeTof22SE7X_saI-TjkECb1F-3fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfffhkeeuvdejtddukefgteffieffledujeeuudeffedtvdejfeekvdev
    heeugedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdprghnughrohhiugdrtghomh
    dprhhushhtqdhfohhrqdhlihhnuhigrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:YCADZkidvgFN9vD4hxnA0ME45IWja42S25rI1gPJIqjgvP9dvSDx9w>
    <xmx:YCADZgBsG6p7Ck_9vVvs3uDk3b6ZJk9zGQMNwYJvdaOXZwra-qpUsQ>
    <xmx:YCADZlKYmyEqbek7wuPOdgpuvWTi5wt9jwzte3O1sTDDYSMvJ0qaZw>
    <xmx:YCADZnAYTxSCT3ooTM6lKBfCRMyzdznQAKSdY2KmqfTTXtSSTzrGKg>
    <xmx:YCADZg3SGZzeKIi-qe-diykQmzAZkgNWf3kof8S24N9srX9M2q5Ig2MSZsA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 15:22:07 -0400 (EDT)
Date: Tue, 26 Mar 2024 12:21:34 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Valentin Obst <kernel@valentinobst.de>,
	Heghedus Razvan <heghedus.razvan@protonmail.com>,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 4/5] rust: time: Support reading CLOCK_MONOTONIC
Message-ID: <ZgMgPqrtc2FSkYZW@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
 <20240324223339.971934-5-boqun.feng@gmail.com>
 <4wFCQqSgpLIPmdFau6MTL1XLLB73d9Tuv5y-VFnXTDc1DFuTnmNV-GLtF582V5yz8s9ogWP_4U0NK3ei6sZlD1oLl929f8ADoT5K9bO6uKs=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4wFCQqSgpLIPmdFau6MTL1XLLB73d9Tuv5y-VFnXTDc1DFuTnmNV-GLtF582V5yz8s9ogWP_4U0NK3ei6sZlD1oLl929f8ADoT5K9bO6uKs=@proton.me>

On Tue, Mar 26, 2024 at 05:03:41PM +0000, Benno Lossin wrote:
> On 24.03.24 23:33, Boqun Feng wrote:
> > Rust Binder will need to read CLOCK_MONOTONIC to compute how many
> > milliseconds a transaction has been active for when dumping the current
> > state of the Binder driver. This replicates the logic in C Binder [1].
> > 
> > For a usage example in Rust Binder, see [2].
> > 
> > Hence add the support for CLOCK_MONOTONIC read.
> > 
> > The `ktime_get` method cannot be safely called in NMI context. This
> > requirement is not checked by these abstractions, but it is intended
> > that klint [3] or a similar tool will be used to check it in the future.
> > 
> > Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
> > Link: https://r.android.com/3004103 [2]
> > Link: https://rust-for-linux.com/klint [3]
> > Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> With the nit fixed:
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 

Thanks!

> > ---
> > @Alice, I still put the link to the usage of Android binder here, if you
> > want to remove that, please let me know.
> > 
> >  rust/kernel/time.rs | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index 0f9f5605ed48..5cd669cbea01 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -113,3 +113,22 @@ fn sub(self, other: Self) -> Self::Output {
> >          Duration::new(self.inner.wrapping_sub(other.inner))
> >      }
> >  }
> > +
> > +/// Contains the various clock source types available to the kernel.
> > +pub mod clock {
> > +    use super::*;
> > +
> > +    /// A clock representing the default kernel time source (`CLOCK_MONOTONIC`).
> > +    pub struct KernelTime;
> > +
> > +    /// `CLOCK_MONOTONIC` is monotonic.
> > +    impl Monotonic for KernelTime {}
> > +
> > +    impl Clock for KernelTime {
> > +        #[inline]
> > +        fn now() -> Instant<Self> {
> > +            // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
> > +            Instant::<Self>::new(unsafe { bindings::ktime_get() })
> 
> I don't think the turbofish syntax (the `::<Self>` part) is needed here.
> 

Fixed locally.

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> > +        }
> > +    }
> > +}
> > --
> > 2.44.0
> >

