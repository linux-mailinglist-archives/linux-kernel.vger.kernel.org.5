Return-Path: <linux-kernel+bounces-163824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB78B728E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97BC6B20E74
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BC512D20F;
	Tue, 30 Apr 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fp3WFAYI"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248112C46E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475371; cv=none; b=fOFDHH7WzhxYXJMXGaEW7yrT4VGOLJx6xs3Gq2L0OsnbRZh7itg4N8ar6vQWkxdF9kTg2ES0ZGQGN078Sn4jHhWZeabqJQe66wD1jmtsP4u1nirkb4dMEqX3uxfxJoidXvvkhuNagPdCBUyF30Fp2VuzPscW/r9RNBDYmZ20Xoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475371; c=relaxed/simple;
	bh=5C7WFXUnU2/7IaH9YHWdCtnfecFw80VZvXKGqyYQia0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g2UD+h32E0KjmSiJl7enDbKzQ7lHs0n4z9yvyTwCBH03n5vzBVG3YZM0Muqljy+qoTPo9nQWRldIX5h4ktwuTLo7WlYhthEga61RziMH5odWC/mNSGKwwvCjYg+U0kCPyYE+9VsImGa1OpQH6D34OSoMgW3wp5bpIo2W5p/96vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fp3WFAYI; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-516d2c322d5so5340004e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714475368; x=1715080168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iEYB9mDUejJc4/pGtI2YjsxtjTa/nIHaNe2DmniH/60=;
        b=Fp3WFAYIOM7uomyVeTcfyYCe5Aj1/fVo8gCQz1Rj1wXCnxmriJ4S05tM5289RndpCv
         ZQbtVtu5yEPqsp7UhoTqqRBZvOrY0nuPrmR0poqPCNvGJDkedueamyNir5Ow60C8p7WT
         IjWHJLzC3POA/eebzI7Jn/7SEI3l1XKU/IO+nhWTYBHHlzcfXpBdk7RQwTpRTh1J2Njk
         3k6o5Eq8QwTE54fahn5VOq/CYKuEfDIBSrjWa2SSwVdfQap66gtCbzvWdcIGl498Kw6p
         6MI1y12VmlMGVOX7y7ZqjrhoqzSsgRAFkQYyLv6BYLzVYWDo4Dw8frulIDtPmYjb3RPA
         9MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475368; x=1715080168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEYB9mDUejJc4/pGtI2YjsxtjTa/nIHaNe2DmniH/60=;
        b=EAyKHctCb0cQz4dEL3Cvehdg/8FQl12KIyedbYYpdGAdlTyQFI192wy6Q3AZOPP0wj
         3dYWasYEg5re/7EX4JqBUohYim7sLqojD2Pv505+b6ITDpnggFL5lJqzzmjo/HulVjCb
         enmsE/MZh1xL4hqlzbjn6TMM5FdE9KLrc7VeNZYdu2Zk6RfbRsc7OdOX4F6Ri0EiBTq5
         8xe7qBNIp4ys7eAVnctGbmrAV5Ab/M+R2nhw+be2i/W8jDFmdsu5odwgJAh4umu45ze5
         fw0doBb4uVVCWu/dfGTsPeWTkd6fRS+3rv8C71QYfNt++Z9AkLc8zUomTLQanNme6t6E
         5f9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfn00mTASAxoQ/WnusyuMnIr0uuKIfDUW6dhcXjfL/+7HxuVd9tsnUuBw0OgLo7+CCDolDiEAS/k2O/13vHw7jRWhBwG1Jn+okHKlq
X-Gm-Message-State: AOJu0YwXlclfkLTpBZ6EXRg40gvSUVAe/9upm8HFyofeUT/4QoZA3mNA
	5XuNRAoWcU+iBR+Dq+T0OsnY6bhYfPKgnKYCGniX3W9lALpxhVA7leIwlD7i4S6vxOML6jVR155
	QGhu4POvzkbxSzQ==
X-Google-Smtp-Source: AGHT+IEwO9Q5sZ30zpSvkC99WHH3eLdnH6j0MxCIGWpnoajIsyuoEBhv50j1r9BA61IMy/c54vMsTNsgaQ6JEU8=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:33c1:b0:51c:fb60:5e18 with SMTP
 id d1-20020a05651233c100b0051cfb605e18mr10061lfg.4.1714475367865; Tue, 30 Apr
 2024 04:09:27 -0700 (PDT)
Date: Tue, 30 Apr 2024 11:09:25 +0000
In-Reply-To: <20240409103120.GA22557@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409103120.GA22557@willie-the-truck>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430110925.1064685-1-aliceryhl@google.com>
Subject: Re: [PATCH v2] rust: add flags for shadow call stack sanitizer
From: Alice Ryhl <aliceryhl@google.com>
To: will@kernel.org
Cc: Jamie.Cunliffe@arm.com, a.hindborg@samsung.com, alex.gaynor@gmail.com, 
	aliceryhl@google.com, ardb@kernel.org, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, broonie@kernel.org, 
	catalin.marinas@arm.com, gary@garyguo.net, keescook@chromium.org, 
	kernel@valentinobst.de, linux-arm-kernel@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, masahiroy@kernel.org, maz@kernel.org, 
	miguel.ojeda.sandonis@gmail.com, nathan@kernel.org, ndesaulniers@google.com, 
	nicolas@fjasle.eu, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	samitolvanen@google.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"

Will Deacon <will@kernel.org> wrote:
> On Tue, Mar 05, 2024 at 01:14:19PM +0100, Miguel Ojeda wrote:
>> Otherwise partially reverting to the `target.json` approach sounds good too.
>> 
>> I added the `-Zuse-sync-unwind=n` to the list at
>> https://github.com/Rust-for-Linux/linux/issues/2. Given the default is
>> what we want, I have put it in the "Good to have" section.
> 
> I think we have time to do this properly, like we did for the clang
> enablement a few years ago. In hindsight, avoiding hacks for the early
> toolchains back then was a really good idea because it meant we could
> rely on a solid baseline set of compiler features from the start.
> 
> So, please can we fix this in rustc and just have SCS dependent on that?

Hi Will,

Just to keep you in the loop, I've posted a PR to make rustc recognize
the reserve-x18 target feature, so that the -Ctarget-feature=+reserve-x18
flag stops emitting a warning.

This should be sufficient for adding support for CONFIG_DYNAMIC_SCS.

You can find it here:
https://github.com/rust-lang/rust/pull/124323

As for non-dynamic SCS, I plan to tackle that after the PR is merged.
See the "Future possibilities" section in the linked PR for more info on
that.

Alice

