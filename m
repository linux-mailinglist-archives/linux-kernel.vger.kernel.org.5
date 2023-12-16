Return-Path: <linux-kernel+bounces-2217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A769C8159BF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 15:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611F41F23994
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFBD2E3E5;
	Sat, 16 Dec 2023 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaHOdsZ9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4355F14005;
	Sat, 16 Dec 2023 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35f96476fb3so5872025ab.0;
        Sat, 16 Dec 2023 06:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702735780; x=1703340580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AWxttL3w0/BUKKedSQa6v4Mf5+rnOWsze5r0MNwR/mQ=;
        b=aaHOdsZ9zbGULCb6jVTApceqX86IVlktaTji/KmfvOliKbO8dQXBfw0LiK4DVpO28+
         j6bc79dMBebWJrcBdFKlZrbwDMaQg8Ly5k5YiPken4ykCuFud20Uh1n5hEAZFFkBOAGV
         76iErzK+5apZwfHGS2GRQaOeYqS3ta+FGwZXMf3dhQkIBjLCZ2A1Ejw89F/JkY/Qr+QV
         p56X8I0KAEtbCC1wJB3KIOnSjZYjLFp/DuuvTa/yxiRGe1YDy3X5yXCGPQZhDWSYYxP6
         ZC4p0NR+MHzykeApiikBJyAc2v5n0DrxDStW6WsB+seuhYocV3ETnC5LwFyhZlqKAdDh
         w0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702735780; x=1703340580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWxttL3w0/BUKKedSQa6v4Mf5+rnOWsze5r0MNwR/mQ=;
        b=rRRLKRBZ9OVAKQeraPx9AbH52+gZHjM44uYDxZtjaNkxr/Vxv+3WAuGwnJGLi6XL0W
         po2L2Y0Jv128GdbIgFW9+oP2R/yLpjUKCulUfaumntd57qyu/pO+bEkv/0WmstjPgg7Z
         wAOSmQNqd9GmDg8szVkApwpYsVpR0Iw43XS0kfrHg9DGQhUxzJcqy5ZADUzOREyiFb59
         LaS9/rRzfXQoUGGDjtvi9/YPSNZPCb8b90Dtvkn7cUovjofXjw+rZXnLMTsWRUQGqiv0
         q+wyqLdVPgRd/NX/BIrB689d3+6sNZ/yuBrd3L75HS7LAGDE9oauSEXw6/+RS4M0Y9ZX
         138Q==
X-Gm-Message-State: AOJu0YyjaegHQ+B4+MpyfoQMMziSgsFpZqzSW+wBefysObXdNwfceFpq
	4GhhiYrDqkKVyIDyruXdOHQ=
X-Google-Smtp-Source: AGHT+IFeBLk2FZQX9DUPjQzfjN61pyxGZipT0nvmy240d2g3WtOV2jjpS/Au/Vpt/8N2qJWWQOg7jQ==
X-Received: by 2002:a05:6e02:3206:b0:35f:8140:b208 with SMTP id cd6-20020a056e02320600b0035f8140b208mr6427900ilb.24.1702735780196;
        Sat, 16 Dec 2023 06:09:40 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id c7-20020a6566c7000000b005c215baacc1sm13102377pgw.70.2023.12.16.06.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 06:09:39 -0800 (PST)
Message-ID: <cec7bfd8-c83d-4e96-a64c-9caea7b02df0@gmail.com>
Date: Sat, 16 Dec 2023 11:09:34 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: rust: Disable entry padding with Rust
Content-Language: en-US
To: Matthew Maurer <mmaurer@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
References: <20231215194828.2611213-1-mmaurer@google.com>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231215194828.2611213-1-mmaurer@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 16:39, Matthew Maurer wrote:
> rustc-1.73.0 used by Linux does not support entry padding. Mark entry
> padding support as explicitly incompatible with Rust.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> [...]
Hope your changes to `rustc` land.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

