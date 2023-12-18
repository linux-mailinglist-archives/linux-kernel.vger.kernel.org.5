Return-Path: <linux-kernel+bounces-4378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8830F817C43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E4A1F24682
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8AF72057;
	Mon, 18 Dec 2023 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWgmzcL+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633377346D;
	Mon, 18 Dec 2023 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d532e4f6d6so929895b3a.2;
        Mon, 18 Dec 2023 12:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702932591; x=1703537391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iGdqyDSPuIrJYr5+tHr9TPege3arG1eE7qeP30XHv7c=;
        b=ZWgmzcL+wFyeP//0EzN1bPBGEyoASI9LmS4i2W5exBTKY5twj0tcNlyglIbdmhcQq/
         fPbIsyiZl/y8gDFjaD3haj8Jqb01YyOhjpyla3uZw1aWbhuSZZl9ArSmSxPruwqn28db
         ZMmZj2ooej0jTrYbuT4aybEYS6gmMRFe3WIND7hIZHCt9B+jBitG7xCYaDyiF4wzIT9s
         t2IkO+a/NxFzm4Lr+iOcmX9Mft3R3cX3Fhd+mgfAdnjYePIxuxaSrsVwrl+Ax0aPoU2Y
         kq7eUTk2pm96Mx65nK8UrYCsFoEk1rBRI/6PaDUGQpt+KqNtUCxqp3BV76wri5VPmNHD
         GPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702932591; x=1703537391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGdqyDSPuIrJYr5+tHr9TPege3arG1eE7qeP30XHv7c=;
        b=Q3LFLUGDaUjN74xP/+dn/M8+drsQbgzY1VuR0kiDgellN0VUJz5bUyFQ2Xtgc6KWLm
         WfrWdPehOT1MnKtuDel+/rWWTWuGVmstxrG7qRmBWZuxDaLI3tiOHEUTpUg92JO3oVzQ
         bkwhkyzpCNZNmsn5E+24u4jffiIwtMl8DmRQtokBDgb3i5FGvg6dBlJCfrwxEM0RFxoA
         qT3M5EXWJu4JTL4enQyf4FuXFfD8tbNw36OkFOdi0Br+OAkvzsVKcXHfGkDvRHGGH+h8
         ceRzRghtbVu5Za1IkM2ibpfDeoLxT/6Koiql9GRwi1ijRJuU5TPQfwZPHUJStgLUN7Tn
         Ug8w==
X-Gm-Message-State: AOJu0Yyutg9QzgZBuUg8i6gyv6Yo0FNPFKifs1gPv7Rn1o1gkLxSZh3Z
	8fcdIHWLjRo1OLUvGbXNiCo=
X-Google-Smtp-Source: AGHT+IEElwHc8LPvrAxrY/WpQcMhO6krulaVorXxQhWQT6H8+tC7M6ej7a391UGbTfTwEGYBIsYXng==
X-Received: by 2002:a05:6a20:ce93:b0:18f:97c:4f64 with SMTP id if19-20020a056a20ce9300b0018f097c4f64mr7041929pzb.112.1702932590646;
        Mon, 18 Dec 2023 12:49:50 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id si11-20020a17090b528b00b0028ae3b5dde9sm11077937pjb.12.2023.12.18.12.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 12:49:50 -0800 (PST)
Message-ID: <e1bebeca-858c-4fd5-addd-be55421935ee@gmail.com>
Date: Mon, 18 Dec 2023 17:49:45 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rust: workqueue: add `#[pin_data]` to `Work`
Content-Language: en-US
To: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Tejun Heo <tj@kernel.org>
Cc: Wedson Almeida Filho <walmeida@microsoft.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213220447.3613500-1-benno.lossin@proton.me>
 <20231213220447.3613500-3-benno.lossin@proton.me>
 <05fa58f3-f351-4119-9c07-1f5bb04503d2@gmail.com>
 <cf36ec44-466a-4c00-afd6-8387dd1ed1f2@proton.me>
From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <cf36ec44-466a-4c00-afd6-8387dd1ed1f2@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 14:47, Benno Lossin wrote:
> On 12/14/23 04:13, Martin Rodriguez Reboredo wrote:
>> On 12/13/23 19:09, Benno Lossin wrote:
>>> The previous two patches made it possible to add `#[pin_data]` on
>>> structs with default generic parameter values.
>>> This patch makes `Work` use `#[pin_data]` and removes an invocation of
>>> `pin_init_from_closure`. This function is intended as a low level manual
>>> escape hatch, so it is better to rely on the safe `pin_init!` macro.
>>>
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>> ---
>>> [...]
> 
> Did you mean to add your reviewed by? Because I received only
> the quote.
> 

Thunderbird is a disaster for plain-text emails.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

