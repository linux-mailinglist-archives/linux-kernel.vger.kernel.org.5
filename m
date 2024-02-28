Return-Path: <linux-kernel+bounces-85206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB786B240
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019CD1F267D5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0E015B100;
	Wed, 28 Feb 2024 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="u5dIV5Qw"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50445612FC
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131619; cv=none; b=ocp6FMUP/xWRfU4MWqx6taFljG2mXDF8V08wVQOgUoUbleLMmCxtpd+l0TC2wVlhYW4J/zpkkPf89lNm5zxR/EHVHgu9BAkfTSceCF8IeoQL1MFQ0RQO/X4ahX8b/mqlDnvmtPgKos7+9BU0ZJPyZIlu3sBtVtdArzoggY3J0Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131619; c=relaxed/simple;
	bh=HIHzjpOrKXqxWUafULLKuoxHLdhUSesh8dKt3u79tcI=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=FzCGDfYS5oFNM4tfAUBEx1Cdz2EyP/gM0B/tvmgj8AbhfRaW53MVbo1iepWfOZPIhw7wv1EGo7Ycn8FZJfLirxTCnxSTMw5XNMbA8CEQXFGmTH4gO2FZclsM9fM1zl7ZX9kHIHIZTWApKHGpPKFcib82ZHBcIB48YvJH7tQNGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=u5dIV5Qw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4419683a6bso63736666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1709131616; x=1709736416; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=8qxXismbJGcxxSTGQfo0P8Mi+M/PX5Dw7LvQPC3lxVI=;
        b=u5dIV5QwBYHZ3+rbhMuG78masI3SP+jfnoz2ntUIM3QT2VUKX2MPuLxd0jrIQ0srPG
         y94QpMB6EFeYkncliZnquGLLfkFe+XUR7cHfzIZmpStm+3GE07JFv00195r/K0v4l8wW
         3MXrdpMg06FdxDNhSQCmpW8fJOzKFjOhduRqCfjNSn4h/14DkTrY0xY6YpkJO9I7B+Of
         aQnRhHfeIbbZDQBwy/lrGFwf7iIFqkQo6PXR5N1s6pDS1RsZmdqmBTxwEEAcFPqyHiIr
         Cff9Q8HfJfAGVJvW3DfMCOgHDvLvePD5gIkK4befWH6GSJJoZ4p+TrMbcngXMVuT+2jw
         xrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131616; x=1709736416;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qxXismbJGcxxSTGQfo0P8Mi+M/PX5Dw7LvQPC3lxVI=;
        b=RTKG3PBHX/ZU8fD78ccuIiD+k3l3L1WcDPngsASwyauWtpqLgEknycqkIiS36Q2YKd
         Zr2/CvpeKDUI7jQQ6ET8o9P+/KLG9j24nfBz5ZM3jaJznUN5C3BUomDPcgZ5E4mBjeMk
         ehFEpl+mn469clqk3tKL7flK/DEi/RRD4Qs9nlL07WFKFHqcHggNvBkyZqh68tDfyDMm
         eXJcVYoRJ+HQaP3D+opjzczNCW56faMZi7VTfOCLdHPx0iaTf2BblPnlqF9lLkPDFasu
         1JpMWsJZSa0S88iMW+D3TVqWV6c5uoNsBozQHLB2yjG8giHj7gEmdOQyRvqj6Mnkr83A
         CL9A==
X-Forwarded-Encrypted: i=1; AJvYcCUB6aEpKceSKR7L0lCrZeumf+liW5Sf6Bca6GXJvrSMwvLvNfy6oer/mImuk4lnVJWpTXo6X3ULXx02p9cSX5HgAo4ZgSf8agw/CLFG
X-Gm-Message-State: AOJu0Yx37iH22gTb3wWkmSQUtxbcrBV2XGsOMmliMoFItfARenOlgeim
	CklB2Uk4TE8YmRRVQq5haH7LAMehY2RRXGEprl3XVewMzDGcCFfFDZfmy1HfPQU=
X-Google-Smtp-Source: AGHT+IEaCtfzpxkkLGZrLyaEquAtLxbLxoHoHkahKKccPYaAGg7T1KVamkQdgIwfHk8QmWSe6axdgA==
X-Received: by 2002:a17:906:c196:b0:a3e:8300:1af3 with SMTP id g22-20020a170906c19600b00a3e83001af3mr8976821ejz.30.1709131615583;
        Wed, 28 Feb 2024 06:46:55 -0800 (PST)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id dc6-20020a170906c7c600b00a441674cae4sm357911ejb.222.2024.02.28.06.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:46:55 -0800 (PST)
References: <20230503090708.2524310-1-nmi@metaspace.dk>
 <20230503090708.2524310-5-nmi@metaspace.dk>
 <-SiJ5paRDIUkH1WEWhGhEjhIgFbSo5PJAvac53bTnBZ5o41DR-kNWZEQBsnKeW1FRJh35siVFRrx54L0M6ebSzl0rzecgcDjqZFGRa9uypE=@proton.me>
 <87a5pcyqf8.fsf@metaspace.dk>
User-agent: mu4e 1.10.8; emacs 29.2
From: Andreas Hindborg <nmi@metaspace.dk>
To: Benno Lossin <benno.lossin@proton.me>
Cc: "Andreas Hindborg" <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith  Busch <kbusch@kernel.org>, Damien
 Le Moal <Damien.LeMoal@wdc.com>, Hannes  Reinecke <hare@suse.de>,
 lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, Matthew  Wilcox <willy@infradead.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson
 Almeida Filho <wedsonaf@gmail.com>, Boqun  Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 04/11] rust: block: introduce `kernel::block::bio`
 module
Date: Wed, 28 Feb 2024 15:31:04 +0100
In-reply-to: <87a5pcyqf8.fsf@metaspace.dk>
Message-ID: <878r34aboo.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Benno,

"Andreas Hindborg (Samsung)" <nmi@metaspace.dk> writes:

<cut>

>>> +);
>>> +
>>> +impl<'a> Bio<'a> {
>>> +    /// Returns an iterator over segments in this `Bio`. Does not consider
>>> +    /// segments of other bios in this bio chain.
>>> +    #[inline(always)]
>>
>> Why are these `inline(always)`? The compiler should inline them
>> automatically?
>
> No, the compiler would not inline into modules without them. I'll check
> again if that is still the case.

I just tested this again. If I remove the attribute, the compiler will
inline some of the functions but not others. I guess it depends on the
inlining heuristics of rustc. The majority of the attributes I have put
is not necessary, since the compiler will inline by default. But for
instance `<BioIterator as Iterator>::next` is not inlined by default and
it really should be inlined.

Since most of the attributes do not change compiler default behavior, I
would rather tag all functions that I want inlined than have to
disassemble build outputs to check which functions actually need the
attribute. With this approach, we are not affected by changes to
compiler heuristics either.

What do you think?

Best regards,
Andreas


