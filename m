Return-Path: <linux-kernel+bounces-37806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5BA83B5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B86351F24054
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13513666D;
	Wed, 24 Jan 2024 23:47:36 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4300131E42;
	Wed, 24 Jan 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706140056; cv=none; b=JIMPwQs8SQY1MSI8SE3K5+AY8q92V5N/DczN1Bk7T2jccb+7QEUP8ipjh0VK4svWXL9DPp1b33mjdNkU0OKUPfBw+aKx2SAi9iJ+/K0V5vCTNl0rL3DheNOjaSIeG1FR32seyEkUOTpUUdxQSyNxXuL3WEaV0IkUQM1r5FPNpaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706140056; c=relaxed/simple;
	bh=8BwFmfBkB9wXmUfLjqDQQMhqwqpvRuACnFB8ZYgyf7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUQZDu0vjnwX4zI2fl5ediUHq8ywk4ddJ7IdoteuP6B2TT6BkfAsRHI1vk9wd/QKnwe2JDVvEA21P+WP4PHkf6uSk4MFrmmiYm6Y/GeuyAH9/Vjo4ZqfVwiyKOpp3/LvBfWRfsLyaPnFpu7/6uBvbqAAa2reVyHG0M2C4ZA5j5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
Received: from localhost.localdomain ([217.249.70.154]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Ip5-1r87RC0iXf-00xKBP; Thu, 25 Jan 2024 00:47:01 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: a.hindborg@samsung.com,
	akpm@linux-foundation.org,
	alex.gaynor@gmail.com,
	arnd@arndb.de,
	arve@android.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	cmllamas@google.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joel@joelfernandes.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	maco@android.com,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	surenb@google.com,
	tkjos@android.com,
	viro@zeniv.linux.org.uk,
	wedsonaf@gmail.com,
	Valentin Obst <kernel@valentinobst.de>
Subject: Re: [PATCH 2/3] rust: add typed accessors for userspace pointers
Date: Thu, 25 Jan 2024 00:46:26 +0100
Message-ID: <20240124234626.6435-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
References: <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gd8dUn8DsdiwfILUeWWL1kxjPxPP600vXTnWpKQGJW/qHXjgV+z
 8+geoeA63GhPacHwaRfW5f5cYPK9k0eLyL4GsVfgq50Sg/prvcA2u4loKRolU58O3fB/iOo
 0lUXnI7FXu1dd8QCOAHYGK4qk3BdCTrdKSDgwjcuDmc5a73VEgPw4mW0NkLt3tP+K7bHWMu
 HLNLlk4KM0cJzgVzCb6yA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qOJAcrdou2M=;U0Dgh275qiGV8d0f5l3kP4AgC3N
 dpuFzkK8EeFuTRmZguWloob/taf4BCRg73JNxcTRGnFG4IsyfS2xM6mo3g7gdgC7KKmP8O7vr
 jkXsNC3KDKUVoi+h02BFDtui7JFfoKKI8YTrTTltKEhnbxAuQqgker5r+c3XCidZnBkDnlg7g
 yGvWvLR1L92GIQI/mN5/4B7cM3QnPcxtghCuk1hhlHOM3l20AkMLxDyV2CNwN7BakKqeXfCI2
 pozPiK26iUgGPoQROCqk/zvIHlOic2pHM2ZelDfp6vYu4EAdqtA5HmOcN0zKXdGe4+hL5uy+6
 oO5PAE2L2zsj4u6MzGJ6QByl/hvea+C168Xct0g7WK0PIOTAu7NKCdp3KirG6SD+zujeKfkNb
 D6Nzqiq/d5GqDI2daOc/OUEUt0WViyAj5j110/QW77PqQeqqMYWg58I0N1wKMEF5hFp2aa+Xo
 RhQkP0QNkb8wbF6JzGBBnh1lnnq4l3wsYSybG94o3SC6PnakBm8KVWQxUL1YPlxDERETNbzEx
 f3g5QoXIPUwG6sz2F7VcdXtY3MdpKmpfuOLNAEQ208HdNhm3yRboHUuJPNy22cCI9UQhRYgQs
 j1RTR4VTn6ycX/BIo12k7U00Jz1BvNx7Kk6TPd7i/tj3ebHKJiMLo6gPSxJqPpjwSB1QA9dLH
 vvH5TQPGeNFRtZuWDnUhhvl79CPGdoIK3oAOGWp7Y/vO3lgddnWEeMqluQZTOmIiE2agSM0U4
 W7/KPe4f1eEjCPwz1XubXQHBWhrzqPlO3liEQJG1Hyem6JdzypXgzVRxQr+W33bXzaJmir0hg
 uwg5F2ppVt3e+UCKmPyd+rpgXk/zgcA2E4LeIEb21ApdC8fY/lPnn/bBHQrt7f9Ah664pgfku
 ovzjl0zElPtdz8g==

> +/*

nit: this would be the first comment in the kernel crate to use this
style, not sure if there is a rule about that though. Maybe still
preferable to keep it consistent.

> + * These methods skip the `check_object_size` check that `copy_[to|from]_user`
> + * normally performs.

nit: They skip the (stronger, and also present without usercopy
hardening) `check_copy_size` wrapping that one.

>                        In C, these checks are skipped whenever the length is a
> + * compile-time constant, since when that is the case, the kernel pointer
> + * usually points at a local variable that is being initialized

Question: I thought that this exemption is about dynamic size
calculations being more susceptible to bugs than hard-coded ones. Does
someone recall the original rationale for that?

>                                                                  and the kernel
> + * pointer is trivially non-dangling.

As far as I know the hardened usercopy checks are not meant to catch
UAFs but rather about OOB accesses (and some info leaks). For example,
if the object is on the heap they check if the copy size exceeds the
allocation size, or, if the object is on the stack, they verify the copy
size does not leave the stack frame.

> + *
> + * These helpers serve the same purpose in Rust. Whenever the length is known at
> + * compile-time, we call this helper to skip the check.
> + */
> +unsigned long rust_helper_copy_from_user_unsafe_skip_check_object_size(void *to, const void __user *from, unsigned long n)
> +{
> +	unsigned long res;
> +
> +	might_fault();
> +	instrument_copy_from_user_before(to, from, n);
> +	if (should_fail_usercopy())
> +		return n;
> +	res = raw_copy_from_user(to, from, n);
> +	instrument_copy_from_user_after(to, from, n, res);
> +	return res;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_copy_from_user_unsafe_skip_check_object_size);
> +
> +unsigned long rust_helper_copy_to_user_unsafe_skip_check_object_size(void __user *to, const void *from, unsigned long n)
> +{
> +	might_fault();
> +	if (should_fail_usercopy())
> +		return n;
> +	instrument_copy_to_user(to, from, n);
> +	return raw_copy_to_user(to, from, n);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_copy_to_user_unsafe_skip_check_object_size);

Could those be wrapping `_copy_[to|from]_user` instead?

	- Valentin

