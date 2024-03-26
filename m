Return-Path: <linux-kernel+bounces-119641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A882A88CB74
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A121C26076
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3FD8526B;
	Tue, 26 Mar 2024 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBKF62TL"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2312208A7;
	Tue, 26 Mar 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476092; cv=none; b=p8UHFL2Tr5WYv2Ym78CDE11/A1eBn/h0S8o/TvH9RBknf3rnDTQUbGs8bk7GPBjawu5ZSFWiiDj8YW5iQbNpP3rrculsGXMeb2uA5WTZ/57Bl27XfrAqXe8aDRXe7pVk3GKBSXM6hTNFELNV74aCUw5a8MXuXLF5JxVEcsrNlZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476092; c=relaxed/simple;
	bh=a3mtfSC9jF8u/tEtEzqSEIjsTQ+XBc8DW/4oluPcibI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTxAqWGCwwGC3gqJK01Z5WVJtoLzkQtys+kWvAWSZAM2Uc5RTxH/odhyPSyXeSaW47xYpE0pZj9vqP9gr9UFyGpV7nUudb1tSrDFnc6KGLRRWxZ506ZhIX1Wgif0BAY1d60NASOKOEezT7CZskrpsRXF/23qL5bO12FcN5ZCl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBKF62TL; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78a5f7269e3so5839485a.1;
        Tue, 26 Mar 2024 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476088; x=1712080888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6lW0gueo5dxaCOjmKynC7GoF7+rNyRSk1GMnrRg1Rc=;
        b=PBKF62TLMkkWPe6puq3TP2J2z9NseLOl1abHLfBu14F1QGBgKQANIPUW5AOpc34X9x
         DDx+pDj/IWob4D5qXNbf/TUnP8oDECCIjNcJ+9h8F3nq35x2FCRVtYphS5xi/9Bvx7xn
         sY3XV4zzI1pP+XPBxQmT9ASLi+ErSs+syOjqwLYrlAZqWQNZHVrOP8li8uWp22u/+VjS
         06DXZihnBvRiEYJNEWwimUYIIew/rgtrMHIj2dtEVsaf+LXqujwn+N7UykFmeQi1YYcx
         jP4ngYN3Af5NaYO9ylUV+Enua0oNU/G46X3mPzyRvyiWO2XNuInyaHbFsRztpKDl123M
         tzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476088; x=1712080888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6lW0gueo5dxaCOjmKynC7GoF7+rNyRSk1GMnrRg1Rc=;
        b=BB4lQ2DPpC0Ww/klLF2r3AfmeHb9PSSbX7XnCdP0B2wTbAKoJaPnxKfwEkQlXjywM7
         dl+W6NBflNK+8MgBpVs0tZipbZVqy6pnyn2S6gQpxCakuMBWjcLgwU6a6LkBeLT90CVk
         BLwnuvnuS4GTkl60nKNwNE+vu2W6s5ggNSP7G3gcXb6Ky1vkZSWIy6iZN+bc3jpHFKHT
         Vu6OI0RZz3NsP6x7KbLgn6Z+jDBKAsvezmYu3jp5Hxy8apBmTwlzRRV1/vJnpjnnw0tx
         HxVy6NlR3ebK2GjMybMkeyBSmfoelYgRHr+fhvVBXQAXH4ZM8m25Zl7Yr3jAcqc65GJU
         nK4A==
X-Forwarded-Encrypted: i=1; AJvYcCX0yxkaH+27zjTNRNPSRtwfaipU/3x+zpTIM6P+lQx6h6KWAt19a43XQo+4+0IWOswF6MUOcZRKpHvOYuXw5cwOSsoMdVKdvSmdk7B+
X-Gm-Message-State: AOJu0YzTuKSQuW2K4nLyz7BT+0FvpQqZ0Q56NAWhiXQy3W8xpCUaDVc/
	EaG0yw0CrxAHXwEz/AR9I+Qu+3PJ+y8HUwYFnNFBBqakwV2iqKEx
X-Google-Smtp-Source: AGHT+IHEe1q+Izvi91GCX8PyrLk7x62WBPdYVYj0vnNi3ps+9NHbs7T6e164fSh/WFv8m82LQU4D/A==
X-Received: by 2002:ae9:ea0a:0:b0:78a:29cc:69dc with SMTP id f10-20020ae9ea0a000000b0078a29cc69dcmr3040022qkg.23.1711476087719;
        Tue, 26 Mar 2024 11:01:27 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 2-20020a05620a04c200b0078874069a89sm3206269qks.9.2024.03.26.11.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:01:27 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8348B1200032;
	Tue, 26 Mar 2024 14:01:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 26 Mar 2024 14:01:26 -0400
X-ME-Sender: <xms:dg0DZkbIBn7BLF-ahR3TS3AfqRRaCoQPYleOvoCzGRVHf1S5xhfWaA>
    <xme:dg0DZvZFUF1PUkHodnO5fV7-DwsatZYPFM4h5R-UlV6uOWCZdcMUfZKyg8VKMfHtj
    K1YvUGnTdfs4A--6A>
X-ME-Received: <xmr:dg0DZu8lMaRqWgg-qX-W1TM03zD5eQLERUmffp2XP96apg8iDZ7ZYhv5kyU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepjeeludevuefhieffieegffeuffeghefhvddvueehgfevfffhvddvgfeh
    veekkeegnecuffhomhgrihhnpegvlhgrphhsvggurdhtohenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:dg0DZupMOZA1C47DzFKhtfpSYUFaHqhg6aN2eHefufk1W2sYllFjhg>
    <xmx:dg0DZvq_e_PU-__dmGYeNW_gxum672dhnppW7SGI9jC4CFf5nxGUXw>
    <xmx:dg0DZsT1iSHnLZ4Osby2SGI5TjtbQe_QYSANPsBOmqjJxUj5L0u70Q>
    <xmx:dg0DZvpN2TWMKtxF5J_nqiWDa_LqAF3ToP3eB-kSSjX35wSsqND3CA>
    <xmx:dg0DZm9QZrznjhJg5zLBNqJqhhwp7-K9WDH_Jm6KXV_louL3SfRa-eC39tI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 14:01:25 -0400 (EDT)
Date: Tue, 26 Mar 2024 11:00:52 -0700
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
Subject: Re: [PATCH 5/5] rust: time: Add Instant::elapsed() for monotonic
 clocks
Message-ID: <ZgMNVNOjoLH4S4Fb@boqun-archlinux>
References: <20240324223339.971934-1-boqun.feng@gmail.com>
 <20240324223339.971934-6-boqun.feng@gmail.com>
 <kZmwObXVcyEJFVR3I05Nab0WdjcccDVARoOm6U9EmXhd89fxYRjvNmEAUZsueWTUlBlHp8jpU3i2YfgN9aWCLZameta0tPT_OgQdBOWUIko=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kZmwObXVcyEJFVR3I05Nab0WdjcccDVARoOm6U9EmXhd89fxYRjvNmEAUZsueWTUlBlHp8jpU3i2YfgN9aWCLZameta0tPT_OgQdBOWUIko=@proton.me>

On Tue, Mar 26, 2024 at 05:13:38PM +0000, Benno Lossin wrote:
> On 24.03.24 23:33, Boqun Feng wrote:
> > This is a convenient way to do:
> > 
> > 	t1 = Clock::now();
> > 	...
> > 	delta =  Clock::now() - t1;
> > 
> > Hence add it.
> > 
> > Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > Signed-off-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
> > Co-developed-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  rust/kernel/time.rs | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> > index 5cd669cbea01..cd1e45169517 100644
> > --- a/rust/kernel/time.rs
> > +++ b/rust/kernel/time.rs
> > @@ -114,6 +114,31 @@ fn sub(self, other: Self) -> Self::Output {
> >      }
> >  }
> > 
> > +impl<T: Clock + Monotonic> Instant<T> {
> > +    /// Returns the time elapsed since this [`Instant`].
> > +    ///
> > +    /// This provides a convenient way to calculate time elapsed since a previous [`Clock::now`].
> > +    /// Note even though the function only exists for monotonic clocks, it could still return
> > +    /// negative [`Duration`] if the current time is earlier than the time of `&self`, and this
> > +    /// could happen if `&self` is a timestamp generated by a [`Instant`] + [`Duration`].
> 
> But there currently is no way to add an `Instant<T>` to a `Duration`.
> 

This is kinda the disadvantages of "upstreaming the bits you only need",
we know for sure there will be a way to generate an `Instant` with an
addition of a `Duration`. I can of course provide that function in this
series. But let's settle down on "negative durations" first.

> > +    ///
> > +    /// But for typical usages, it should always return non-negative [`Duration`]:
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// use kernel::time::{Clock, clock::KernelTime};
> > +    ///
> > +    /// let ts = KernelTime::now();
> > +    ///
> > +    /// // `KernelTime` is monotonic.
> > +    /// assert!(ts.elapsed().to_ns() >= 0);
> 
> Now that I thought a bit more about the design, I think allowing
> negative durations is a bad idea.
> Do you disagree?
> 

So yes, I don't think allowing negative duration is really good design.
But as I mentioned in the cover letter, I hope to support cases where:

	d = ts2 - ts1;
	ts = ts3 + d;

	(where ts1, ts2, ts3 is Instant, and d is of course Duration)

without any branch instruction in the asm code. It's useful in the case
where ts1 is a old time base, and ts3 is the new one, and you want to
"remain" the delta between ts2 and t1 and apply that on ts3. To me there
are three options to achieve that: 1) allow negative durations (this
also mirrors what `ktime_t` represents for timedelta AKAIU), 2) have
a timedelta type that differs from Duration, and it can be negative, 3)
provide a function to do the above calculation for `Instant`. I choose
the first one because it's quick and simple (also easy to map to
`ktime_t`). But I don't have my own preference on these three options.

Regards,
Boqun

> If there is a case where you have a non-monotonic clock, or you are not
> sure if two timestamps are in the correct relation, we could have a
> function that returns a `Option<Duration>` or `Result<Duration>`.
> 
> -- 
> Cheers,
> Benno
> 
> > +    /// ```
> > +    pub fn elapsed(&self) -> Duration {
> > +        T::now() - *self
> > +    }
> > +}
> > +
> >  /// Contains the various clock source types available to the kernel.
> >  pub mod clock {
> >      use super::*;
> > --
> > 2.44.0
> >

