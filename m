Return-Path: <linux-kernel+bounces-83004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A389868CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E862854A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B321137C50;
	Tue, 27 Feb 2024 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="soi8/goX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oqhTd1iM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="soi8/goX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oqhTd1iM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D22137C2D;
	Tue, 27 Feb 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028332; cv=none; b=ScFa1hF1s7DwMmUxlPkR238mPep3x6nCsZ58mmqan5Wczj2ypYlb4wQWUpyXG+ckzy5DQFWiuPEAusrvu0YT82S/Bv7g1Dqu4woK+Db0T256QmixAXL/WY+OCr1JJfycXrVvv/tvywIyeLEBYx05aKcVhVmhOrRrq9FRqIJY2Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028332; c=relaxed/simple;
	bh=qTKCh/UYun8MIHt+3k9VcP0gbTE3xP+PfI30BTgmONg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzPKw0nKLDvS/hkVIoTW0KQoYzOBXSybv3oxrSzeuOZXYF9pbH9oKoyyBOw0AFest8oA8OMf1tOR+1BXOzSi5gmg6ysaqDxIQvZVmqXuH3JoIRcZSvdDmmLlU+iW8lyVx/7eCLdhVH5mHXZxD+ltKUVUE/hPj0lnvcOFpbGOyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=soi8/goX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oqhTd1iM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=soi8/goX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oqhTd1iM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2853E226E8;
	Tue, 27 Feb 2024 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709028329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XXrMIze6Y72f4u2ysv6nK5J2tUBv4eD6P0fxLLqnrU=;
	b=soi8/goXCUpmlv19LLto6jAlcz8JoEvm1nZpGgqTSTtPbqneegXav+HzwbxK++hleQ9qCj
	3k6rRD9ScpgXGEc76aF2PnpvxqqgNu3BOaYXNc7mqXUOKGqmHaQMHFCC9KBlog2uVCvWC3
	/QfGbsbvbpNxNVi4ztfU9W6hGk0OshM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709028329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XXrMIze6Y72f4u2ysv6nK5J2tUBv4eD6P0fxLLqnrU=;
	b=oqhTd1iMyjfXSwqjHSZv10e9xCjuScPkIxVR+BErjIYgTHsvgvdHni1yXcYrAS6McMvw+h
	JC4OhYkBuLdaFZAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709028329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XXrMIze6Y72f4u2ysv6nK5J2tUBv4eD6P0fxLLqnrU=;
	b=soi8/goXCUpmlv19LLto6jAlcz8JoEvm1nZpGgqTSTtPbqneegXav+HzwbxK++hleQ9qCj
	3k6rRD9ScpgXGEc76aF2PnpvxqqgNu3BOaYXNc7mqXUOKGqmHaQMHFCC9KBlog2uVCvWC3
	/QfGbsbvbpNxNVi4ztfU9W6hGk0OshM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709028329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3XXrMIze6Y72f4u2ysv6nK5J2tUBv4eD6P0fxLLqnrU=;
	b=oqhTd1iMyjfXSwqjHSZv10e9xCjuScPkIxVR+BErjIYgTHsvgvdHni1yXcYrAS6McMvw+h
	JC4OhYkBuLdaFZAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9943913216;
	Tue, 27 Feb 2024 10:05:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OsmhHeez3WWzOgAAn2gu4w
	(envelope-from <clopez@suse.de>); Tue, 27 Feb 2024 10:05:27 +0000
Message-ID: <a7f91ee5-ecd4-4446-9de7-3902763c0058@suse.de>
Date: Tue, 27 Feb 2024 11:05:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] rust: uaccess: add userspace pointers
Content-Language: en-US
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas
 <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook
 <keescook@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
 <20240208-alice-mm-v2-1-d821250204a6@google.com>
From: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
In-Reply-To: <20240208-alice-mm-v2-1-d821250204a6@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.29
X-Spamd-Result: default: False [-1.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLx931z8whuiu5x894fnbjwz7n)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-1.50)[91.72%];
	 RCPT_COUNT_TWELVE(0.00)[24];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[linuxfoundation.org,android.com,joelfernandes.org,google.com,arndb.de,kvack.org,vger.kernel.org,kernel.org,gmail.com,garyguo.net,protonmail.com,proton.me,samsung.com,chromium.org,zeniv.linux.org.uk,linux-foundation.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO


On 8/2/24 16:47, Alice Ryhl wrote:
> +    /// Create a reader that can access the same range of data.
> +    ///
> +    /// Reading from the clone does not advance the current reader.
> +    ///
> +    /// The caller should take care to not introduce TOCTOU issues, as described
> +    /// in the documentation for [`UserSlice`].
> +    pub fn clone_reader(&self) -> UserSliceReader {
> +        UserSliceReader {
> +            ptr: self.ptr,
> +            length: self.length,
> +        }
> +    }

Just out of curiosity, is there any reason why this is not implemented
in terms of the Clone trait?

-- 
Carlos López
Security Engineer
SUSE Software Solutions

