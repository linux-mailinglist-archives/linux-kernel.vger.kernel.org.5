Return-Path: <linux-kernel+bounces-29468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18910830EB9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A493E1F2465F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3102557F;
	Wed, 17 Jan 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1tWDVSX"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BD6250EB;
	Wed, 17 Jan 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527686; cv=none; b=Us32CCRq6JW4RFm9FqrUhlDj8Xw4CE2bNxXj67nPCtcWFPyQ7MVSmBHCFPr4S1AuZiFmpLZ/mLUkrsY3MipncSRO650h714TfPCTMM3rEM59VBo3SUsVS3ZQihYTA/zVQq88deKAmK8qcIoe5j5pHF17tRouLby8zZ/+aUoIOuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527686; c=relaxed/simple;
	bh=MK+o/hMICtzJdaDs1+iYtp7N1sbBz1ePSBR7U6NS04s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=jhQwvfXTpqqfm0+ZnGocPOVNCFwBVy4uhpUwhwM5lpxZZ2pIONnfx5+VVDzMhIzFKZwr7fiJTPU8qHS6F+F9vlsLYEs6i/os+2q5sDThvXo7JvdQ+21GIFpzm31/nQYG0tRFRw7M20u1DRFOfSZHLMgBKGo35fmP6TJ4VOfsIl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1tWDVSX; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bba50cd318so9770491b6e.0;
        Wed, 17 Jan 2024 13:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705527683; x=1706132483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tpvUYF3Y0yW+nqXQ1eP4lGxlK2nx+ZT20Fdgq/w3YI=;
        b=k1tWDVSXdNUQ/p8NEwsSlKEKSGi/Hg5LRnpxjXXBBsQt0SCdnboRBUAVZp3CQMLwPZ
         0dpUaMzouf7plQ1u4PJOYEsiuTCydDHI+aownfcIFuR3mwKrDd9XsxZN0jfDVwYmCIr9
         jZ5QKoqzOp/AqNCT262/A4+YRXhcW9JJHLcipgAkm2yemY01GI3z7eoQRMtWQ1xHezsI
         T5pFTUf+BZvsWUAO1ql2FS9mjfN9IOirT2Oo4/Q8Tfs+8AAp5yv/+cYp/0VxIW2Rpmtl
         QdFVejy2PnIRwwHzb/3szyL1YuokqEGDYRhqsjrbLZ67yhtbasGVEoLldc6WExwnJO+g
         6Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705527683; x=1706132483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tpvUYF3Y0yW+nqXQ1eP4lGxlK2nx+ZT20Fdgq/w3YI=;
        b=L9akKu0N7eqi7TzEjAvgq3EKKBZ81prBVunXOsLjYeFh0FsA7/F7+/WtsESo+6t4x5
         I2830W2rkc9/8Oyij5yVWrhfvHEeBsd1kLPh0J0v+t3s2VLgnJWFEHs075n+lVlDiB64
         En93oMEvL4CI2c2QcXwpQzp5wl9xnqTf+XmQDMA2GxTj631vaPUxeKWye+ZlIn2IYZiG
         199Ul3ggmQG0gt4fAB8Hjkp/NWQYV6tUbLSx46fWqyJwUg8dht80m8o1Bs3nG1izUt5h
         rrYZslHzYuDlPcNpSW6cx3DEHnOsF786fvxJZO86FFfHj4UU7JxbxZU3Jh8+HKdir3Kz
         CSeg==
X-Gm-Message-State: AOJu0YwKwviNYR0spgkcydcfZEIenXpfY0fLnrOzg023gt9Jsl29iYLn
	fPYCwf/Zd7uGA0X0eUbIsfw=
X-Google-Smtp-Source: AGHT+IFmPAj8FUKGwQBn1v9nRp4lIl0kMzco8AdzgaNDYbYosGV5yvU8/a/qjlGCoGDh086HtX0eng==
X-Received: by 2002:a05:6808:1786:b0:3bd:3ce8:2377 with SMTP id bg6-20020a056808178600b003bd3ce82377mr12483348oib.114.1705527683021;
        Wed, 17 Jan 2024 13:41:23 -0800 (PST)
Received: from [192.168.54.105] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id ks11-20020a056a004b8b00b006d6b91c6eb6sm1975830pfb.13.2024.01.17.13.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 13:41:22 -0800 (PST)
Message-ID: <48471adc-5155-482b-83db-f1c128fe8d69@gmail.com>
Date: Wed, 17 Jan 2024 18:41:18 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] rust: kernel: add doclinks with html tags
To: Valentin Obst <kernel@valentinobst.de>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a3856ffc-ddb9-4066-8e1d-999c8f7790e8@gmail.com>
 <20240117091029.182098-1-kernel@valentinobst.de>
Content-Language: en-US
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20240117091029.182098-1-kernel@valentinobst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/17/24 06:10, Valentin Obst wrote:
>>> [...]
>>> @@ -14,7 +14,8 @@
>>>      /// Byte string without UTF-8 validity guarantee.
>>>    ///
>>> -/// `BStr` is simply an alias to `[u8]`, but has a more evident semantical meaning.
>>> +/// `BStr` is simply an alias to <code>[[u8]]</code>, but has a more evident
>>> +/// semantical meaning.
> 
>> Isn't there a way to escape square brackets with backslashes with
>> mbBook? Like `\[qux\]` or something? I ask this because this affects the
>> readability of the doc comment so if that could be omitted it'll be
>> really good.
> 
> Here are the things that I tried that did not produce a link:
> [`[u8]`], `[[u8]]`, `[\[u8\]]`, `\[u8\]`, [`\[u8\]`], `[[u8](u8)]`,
> `[[u8][u8]]`,
> 
> This results in a link, but it includes the square brackets:
> [`[u8]`][u8], [`[u8]`](u8)
> 
> This results in a link that only includes the `u8`, but it is not
> formatted as code:
> [[u8]]
> 
> The only other examples of linked slices that I found are in the
> standard library [1].
> 
> My assuption is that crate documentation is much more often consumed in
> its rendered form, which is why I think the reduced readability is ok.
> However, if that is not the case this change might be a bad idea.
> 
> [1]: https://doc.rust-lang.org/src/alloc/ffi/c_str.rs.html#58

I have an idea, let's just omit links to sliced types if they already
have their underlying type linked nearby. As for `[u8]` I think that we
can omit it too since readers of the documentation should be
familiarized with slices.

