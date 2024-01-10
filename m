Return-Path: <linux-kernel+bounces-22391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3379829D13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735671F22F06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228464BA9A;
	Wed, 10 Jan 2024 15:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp/PzVKB"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72244BA85
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5585fe04266so705020a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898914; x=1705503714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xNnfYtoez95mBj0mKwxYIuhxLbBJzB+pETwkHdCL4j0=;
        b=Sp/PzVKBlZlBWjeOzrPAWhllyKo15qGbNHbif3D9IZxyo1NLgUbQqwYeabROxoOm7r
         xqds0B+4dmUWld5TjClPfYa52aiSclpZoCBfY1Nq27yds4qfXgUX1ZQR1uNaeunHYdh8
         vKbV8oqi4mt3lLb9TOjzl6Ud/oSB9uEB1kq+JppFDMpqasth6VtzqwWiXGSEiaYR0b5t
         3hNBMAeHuHcFWjNcVzTgTxDfw4pKlmgOV6UrLpRUyVUsoWPoV5KWXF2Jfc2BOEIRIFQS
         uVBWGpEnwhWd15MrgOKIQQ+Ck+mwiFP4gPnxXIuigZ7mpbK/eqiE0SlVcSIYjUVdcGTt
         X4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898914; x=1705503714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNnfYtoez95mBj0mKwxYIuhxLbBJzB+pETwkHdCL4j0=;
        b=o4aRbHs8vc7T6rmyYhsmyyIfd/gX6g+Bmf4xXRHcsC+joc+VotZ2cPMMSg83DWxSSO
         9Y78Vbdcua2eX9cwirdXATetPD56wPG+S9vbrLcmg2hXES4MDVTUdVnvWBjzT+DgZdw5
         pLxgoiwYKWoNGoJq3dhriPg+KYIZqCqPFo4orbo4wiODru18TknfSucBWtP3l6OPdYkc
         YLriuzyvnn869YErmkqcUMg2S+mlh+XL3oZEDCBjODMZI2jZLx0SAX1EsPU0osKL2vVX
         u3VzypuODlip+CXIhJ0ZJuqoeEuI+IeLChxjQjwDh7XAh4Bl8k5W7IGcGjmpVSgcJt/A
         pr4Q==
X-Gm-Message-State: AOJu0Yw1eAFBK2WBr/IJAkZ4XTm08lIYo3IcqUXmPpaAMaOf/TXthmLm
	oWRmDg8/kyYyCSD11FpX5d0=
X-Google-Smtp-Source: AGHT+IF4BcEkZvJNZq1ZIiLpL3FtlWFqiybdHK9d6DXNdDYwYnt5dAvPS+AJL305aP2NwwKCpOzI5g==
X-Received: by 2002:a50:d49e:0:b0:557:c91b:1ac8 with SMTP id s30-20020a50d49e000000b00557c91b1ac8mr573948edi.73.1704898913561;
        Wed, 10 Jan 2024 07:01:53 -0800 (PST)
Received: from [192.168.2.25] (129-188-177-143.ftth.glasoperator.nl. [143.177.188.129])
        by smtp.gmail.com with ESMTPSA id x17-20020aa7d391000000b00556cf695da0sm2049922edq.78.2024.01.10.07.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 07:01:53 -0800 (PST)
Message-ID: <b931d02e-a414-4f5c-acc8-160d7b5e016a@gmail.com>
Date: Wed, 10 Jan 2024 16:01:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
To: "H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org, pinskia@gmail.com
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
Content-Language: en-US
From: Michael de Lang <kingoipo@gmail.com>
In-Reply-To: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

While I have done no work on the linux kernel, I hope to add to this 
discussion anyway. Forgive me if I'm intruding.

The arguments in favour of C++ so far focus on the technical and current 
kernel developers aspects. An extra argument in favour of C++ is the 
same one that Linus Torvalds recently mentioned in the keynote "Linus 
Torvalds in Conversation With Dirk Hohndel" w.r.t. Rust's impact on the 
Linux Kernel. Namely, to prevent stagnation for the Kernel as well as 
continue to be interesting to new developers.

One of the things holding me back from developping things in the Kernel 
is that C is, to put it bluntly, old and not interesting for my resume. 
Now there is certainly an argument to be made for "don't fix what ain't 
broken", as evidenced by the Kernel being in widespread use. But most of 
the interesting programming language progress has happened in C++ and 
other languages, unlike C. The aforementioned metaprogramming is one 
such example, but things like RAII, smart pointers and things like 
gsl::not_null would reduce the changes on kernel bugs, especially memory 
safety related bugs that are known to be vulnerable to security issues.

On the other hand, the benefits I mention can also turn into downsides: 
if constructs like gsl::not_null are desired, does that mean that there 
will be a kernel-specific template library? A KTL instead of STL? That 
might be yet another thing that increases the steepness of the kernel 
development learning curve.

I also have a note on the following:

> However, Linux also does conversion of polymorphic objects from one 
> type to another -- that is for example how device nodes are 
> implemented. Using this with C++ polymorphism without RTTI does 
> require some compiler-specific hacks, unfortunately. 

Although compiler-specific, C++20 has enabled implementing RTTI without 
RTTI as well as (partial) reflection. Examples include the JSON library 
Glaze as well as my own Dependency Injection framework Ichor. See 
https://godbolt.org/z/vaWszr9WG. On top of increasing the binary size, 
this then becomes a discussion on what requirements the kernel puts on 
compilers, as I'm sure that the kernel needs to be compiled for 
architectures which have a less than stellar conformance to the C++ 
specification. Regardless, this is IMO good food for thought.

Cheers,
Michael de Lang


