Return-Path: <linux-kernel+bounces-28450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B602782FEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1F01F27885
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32375AD24;
	Wed, 17 Jan 2024 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOVat90V"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5713946C;
	Wed, 17 Jan 2024 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705456757; cv=none; b=tJXZgcTpJzJZgYzRJe6Vj7b0s8VFzJRSVwjn1ebWfYlXRAcG/LSG5So2uwizK+NTNKRNJSjWWwrbfe7NyhYJQ+5u1q86pASQi3OBywESw60rgi5hS55EcdjxMseAkgLfVUql88PWNEppEHGCJXnKvwVofzFwYrDYGlN8w1IV8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705456757; c=relaxed/simple;
	bh=E5ow6diaNQ48lD7Anp/oAQBB056Q8Gyv2r7qn2TTu+E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=NYmAmDmqvZN9Nj7z6K18Bng8VPuGGeO1Bad6iK4/OcIzph+siO6HQhlmOoC+maAVsiVzQSbEqN8NR9Pl2zk7HfGS5DoIDhj6a851W5yYDPJVVRSGj778eoTQyV661Tr6+GLPtxHJ04eKr41Tq47GMUiDRo+rl8VlzCz5oVRaYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOVat90V; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so7608344a12.1;
        Tue, 16 Jan 2024 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705456755; x=1706061555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6RtTfdNaQouSQ3pRDZPDIQJf3oZ3P1uDMrkg9TpWY0s=;
        b=VOVat90V0SgJoVKaRO6fvTYSnYjVTLIuE0jQgx30v4tj90lGDtzdrR9iFJmTD3XSDT
         OSxgGWhuePUKUqxIlHlKPX5u6lQzINn1uA/iVWBqhl4ot8usf5tYOdSRtGMpD+LjKE4M
         puITaJl69AYrEoq26dZO3guVg19/xSIYboDqD2K7cr9uF78saBYtFHQICpAH8E9LCAg5
         Mm9cYqE8Wb1/P+HgJKoE2Qm3q0fiMa/oXFf+RgvedhnPcb1a7JeU1wfLwil92VxtrfYh
         CwlBAexOzMAIpHO0qyx4Cdi1lPsu/fzfataMN9o0hZSLrBBmGXrr48sZE7VcpodHVeeL
         nvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705456755; x=1706061555;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6RtTfdNaQouSQ3pRDZPDIQJf3oZ3P1uDMrkg9TpWY0s=;
        b=Ji7egUKQtyRapGmD2+VV49unqgAVoryvW8wQtCouZ0AdTnRIDODzkKSe8YJs+mDCLs
         Kc0/hIZ2x2eTHX0fuFOljGowef5wxGLxrslnPGbv3dftxfVqHVdVaSwGjsBWOGB/RkxU
         OZoo4qrrij1sWUF8nTCDPjNrQmeE5Cm51zFIoD7/5ODMWjuLnBYLpQh57bi+7FgxyH9a
         0A1lklRjSB43p9dXTlRXxnQEY5IZDJAykU6PSUBUfbX+bUmeuaMUSbZ6paGonJxtCLPj
         zWZmOVwsGJBt6lC3wV0lg6BtdEjIoVTqXFhkDVTwvqKLBUhw5QAoq3x4kTWdLO+89pFo
         51MA==
X-Gm-Message-State: AOJu0Yzn6oQbaC8LztMcgR5ST2DVJv3P5H4FDdopltNeTmLyYukdnq6l
	U36/BmIF9NMQ6D3oDV2zgU4=
X-Google-Smtp-Source: AGHT+IFN8KqdmnpUYzYeF1EdLtwKlHcPIX+QQqdwNDeIb9Kp+UU5gb+ytl537LGBd83i8mJaAYXRIA==
X-Received: by 2002:a05:6a20:158d:b0:19a:2b15:2a2f with SMTP id h13-20020a056a20158d00b0019a2b152a2fmr147623pzj.28.1705456754982;
        Tue, 16 Jan 2024 17:59:14 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id e13-20020aa798cd000000b006da105deedesm237836pfm.197.2024.01.16.17.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 17:59:14 -0800 (PST)
Message-ID: <52792041-dae0-4c5f-9561-ace514950d9c@gmail.com>
Date: Tue, 16 Jan 2024 22:41:26 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] rust: kernel: documentation improvements
To: Valentin Obst <kernel@valentinobst.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240116160141.165951-1-kernel@valentinobst.de>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240116160141.165951-1-kernel@valentinobst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/24 13:01, Valentin Obst wrote:
> This patch set aims to make small improvements to the documentation of
> the kernel crate. It engages in a few different activities:
> - fixing trivial typos (commit #1)
> - updating code examples to better reflect an idiomatic coding style
>    (commits #2,6)
> - increasing the consistency within the crate's documentation as a whole
>    (commits #3,5,7,8,9,12,13)
> - adding more intra-doc links as well as srctree-relative links to C
>    header files (commits #4,10,11)
> 
> Valentin Obst (13):
>    rust: kernel: fix multiple typos in documentation
>    rust: error: move unsafe block into function call
>    rust: ioctl: end top level module docs with full stop
>    rust: kernel: add srctree-relative doclinks
>    rust: str: use `NUL` instead of 0 in doc comments
>    rust: str: move SAFETY comment in front of unsafe block
>    rust: kernel: unify spelling of refcount in docs
>    rust: kernel: mark code fragments in docs with backticks
>    rust: kernel: add blank lines in front of code blocks
>    rust: kernel: add doclinks
>    rust: kernel: add doclinks with html tags
>    rust: kernel: remove unneeded doclink targets
>    rust: locked_by: shorten doclink preview
> 
>   rust/kernel/allocator.rs          |  2 +-
>   rust/kernel/error.rs              |  7 +---
>   rust/kernel/init.rs               | 16 +++----
>   rust/kernel/ioctl.rs              |  6 +--
>   rust/kernel/lib.rs                |  2 +-
>   rust/kernel/str.rs                | 15 +++----
>   rust/kernel/sync/arc.rs           | 34 ++++++++-------
>   rust/kernel/sync/condvar.rs       |  2 +
>   rust/kernel/sync/lock.rs          | 13 ++++--
>   rust/kernel/sync/lock/spinlock.rs |  2 +-
>   rust/kernel/sync/locked_by.rs     |  5 ++-
>   rust/kernel/task.rs               |  6 +--
>   rust/kernel/types.rs              |  3 ++
>   rust/kernel/workqueue.rs          | 70 +++++++++++++++----------------
>   14 files changed, 98 insertions(+), 85 deletions(-)
> 

Add my `Reviewed-By` to all the patch series except [PATCH 11/13].

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

