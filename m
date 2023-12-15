Return-Path: <linux-kernel+bounces-911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878FF8147E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B381C233FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB132DB7B;
	Fri, 15 Dec 2023 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmX9l7FB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC082DB7C;
	Fri, 15 Dec 2023 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c317723a8so6794825e9.3;
        Fri, 15 Dec 2023 04:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702642754; x=1703247554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41+GVLZsgV+iwi5QTOwkFDVHQDnIoq3Z4EC1ZUUFgoA=;
        b=DmX9l7FBqYIr1g/Sk3FVZB0rY35NvaI5zgwebMuUOQxdtXE1homqBRveMG8/ARQs2J
         rzRdgden3X+yjXRArRkT4s3Ghx9yAD+w/WRabL58v9ZnTlmOlmNcozOxROOdgnar91O+
         Af4nir0sHpwTpHV4C+LkdMKXepg4rKT2WML6QrnMdvUbM88u+OvtEkaL3LARuS+bxPKN
         kEmMCHXOIAQGaHaVG5UQTJROGycazCpALcBhPWD6DUNtWm+yGzj7BnB7dQrgz+BIudh5
         sC00fz/hsCd9F7d0B9EYpwOpPsE72T7NLPsHSvGdvM958lMWiVFP3A5xLCv4u0LUE58Q
         L8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702642754; x=1703247554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41+GVLZsgV+iwi5QTOwkFDVHQDnIoq3Z4EC1ZUUFgoA=;
        b=T7BkOW1iehHCOv+YzGxxiOihVcMOcu78p8Qu0RMsMdLyn9yPrgv9xV1NedcK2TZEYG
         Ux5qt8KRuu+Bu33sfst5NsalKwcrhd9qpxsFtTayR0bor/CQgFsBatgBX+ikkwNdKnz8
         Z1VBC0zN0Q8hZyH+I7y0xiv4SDDD6cjE6gPi+ODGXylIC9+TgboTycF62vu3iYUz+Chc
         xZSMe/zraW6Dt3NNpWy6uagWNQ1c5i2RFha4zpUYNnY2uad6NpHhAxGE11C4F+aKt8in
         9wBExB1dGi8IvL4eJYVX2SLNvK5uTlqK0EWC/tTu0EqmXT/m0JtZp/4QRzpz++y2H4Ff
         /8bQ==
X-Gm-Message-State: AOJu0YxIANzsDO99KpdvsWGDlfbHINr5glMhiZD4rIPAqvbiD7kAu6CL
	EfWSBlnPkdjNcsW8peFvHg==
X-Google-Smtp-Source: AGHT+IGI2dE69kkG258zfN51SRFpGuftFM9SNvx7L9cnUX/M8VwkIC8vuYnRhGinWblxWJOn6HrtGw==
X-Received: by 2002:a05:600c:4f02:b0:40b:5e59:c582 with SMTP id l2-20020a05600c4f0200b0040b5e59c582mr6071154wmq.172.1702642753726;
        Fri, 15 Dec 2023 04:19:13 -0800 (PST)
Received: from [192.168.1.148] (224.69.114.89.rev.vodafone.pt. [89.114.69.224])
        by smtp.googlemail.com with ESMTPSA id x15-20020adfec0f000000b00336468b986esm4555704wrn.96.2023.12.15.04.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 04:19:13 -0800 (PST)
Message-ID: <5f16fbbf-e14e-4c26-b2e0-d9cad559f828@gmail.com>
Date: Fri, 15 Dec 2023 12:19:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] docs: rust: Clarify that 'rustup override' applies to
 build directory
Content-Language: en-GB
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <e2b943eca92abebbf035447b3569f09a7176c770.1702366951.git.viresh.kumar@linaro.org>
 <1c03eb18-a6ac-45c8-8fea-46097bb4e132@gmail.com>
 <CANiq72=mvca8PXoxwzSao+QFbAHDCecSKCDtV+ffd+YgZNFaww@mail.gmail.com>
 <20231215064823.ltm55fk4zclsuuwq@vireshk-i7>
 <a2aca039-7360-476e-a1b1-e950698cd26b@gmail.com>
 <20231215112418.usky65sibhbiubyx@vireshk-i7>
From: Tiago Lam <tiagolam@gmail.com>
In-Reply-To: <20231215112418.usky65sibhbiubyx@vireshk-i7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/12/2023 11:24, Viresh Kumar wrote:

[...]

> Will this still work if we are in the build directory ?

I've tried it and it does work. The build directory that's set up with 
`O=` ends up with a Makefile with an `include` to the original Makefile 
in my main linux source:
	include $MY_WORKSPACE/linux/Makefile

(But see Miguel's reply about dropping the mention to "enter ..." 
altogether)

Tiago.

