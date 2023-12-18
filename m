Return-Path: <linux-kernel+bounces-4505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E967817E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1811C1F235DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A5C76902;
	Mon, 18 Dec 2023 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPK4AxGJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E1760B2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6da4893142aso3127240a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702943997; x=1703548797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Va09233MhPCImUf6PaapwK9ZhikG8ID1vHBVkhtiYxY=;
        b=YPK4AxGJhq8l6EAMteAu83bNQsRQ33x0xipwYqKkOBT0DpGol8pjAJRFef5aG9nj2P
         YaX0Kr4gx+IePW5VRD99tWltmrWsAs8X708QqlDYiRX9pADPlfZif1On8bG2TsfSx7Bp
         4lPI4zRQw2wuhAodfmaLZUjw0fgEs4LsEcQG3t0cIRhC5qnnPUbkRbc7ULdqNSDMmkol
         gKhAwS4iDvKQgpx1cHq6Arszm1mH+uuuLuF832PqINqclReE7BKJPiAu6vsZ8v/kBg13
         55Zcz92ZXU52Kh+Ca0hxfr3LOTMNdymdXpnkHFilF2t9BJYdpZwwTWJG+7PbDEybog/h
         oDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702943997; x=1703548797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va09233MhPCImUf6PaapwK9ZhikG8ID1vHBVkhtiYxY=;
        b=h8wPIzy4ENlz7gAHVfjVRgRcBjxPmuRhHA7iV5ui7Cynrb9SLK2zUfDAw/rk1QEaih
         sLj5/+3lFc04q+8DCbTsohrb4dDyAStVbPqbw0kFi0DsUxFu+w+W4PgI135+t5E5QJQ4
         petqUqzpWf19sZtZwJnrCYAiaw5KhJ0N8NhvMuy/02WV3AT5bB6qqff+EdkOznnOO4MU
         4R/XNRe8s3BoKvxMrXekxPapFm/UYLVD1ffQ6te29wG8o3MQn67p1Ym7QGxjIHWCTNMa
         +FPR20F8rOz4hmARJZDIJYbzSRn129gbQy0X6fxnBe+1srFHLFdi3Gy7/nzrDqkJcNcv
         YT6A==
X-Gm-Message-State: AOJu0Yzh/aKRPbx69z4sIp7LWkY24WZdnhZwY3uvVhCtXf1GUbI8x8IX
	gmIgI+RqQLyI37homV8xhBwwsA==
X-Google-Smtp-Source: AGHT+IHdBgIRP8cQKSRWmaCtU3tLrgkyvvJSDLWRHw2XoXNkW6VR/M6+H8U9andenIHPT8NXsyHjiQ==
X-Received: by 2002:a05:6808:320b:b0:3b9:fb3d:b14 with SMTP id cb11-20020a056808320b00b003b9fb3d0b14mr21557143oib.55.1702943996686;
        Mon, 18 Dec 2023 15:59:56 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id x16-20020aa784d0000000b006ce5bb61a60sm2038058pfn.35.2023.12.18.15.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 15:59:56 -0800 (PST)
Date: Mon, 18 Dec 2023 23:59:52 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Will Deacon <will@kernel.org>,
	John Stultz <jstultz@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: optionally use LLVM
 utilities
Message-ID: <ZYDc-DxqvnyDwkwi@google.com>
References: <20230929034836.403735-1-cmllamas@google.com>
 <d6f23512-cec4-4b82-aa6e-d3c98e86e29f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6f23512-cec4-4b82-aa6e-d3c98e86e29f@quicinc.com>

On Mon, Dec 18, 2023 at 12:08:14PM -0800, Elliot Berman wrote:
> 
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> 

Oh, thanks Elliot for having a look. I had forgotten about this patch.
I'll RESEND if this doesn't get picked up next week.

--
Carlos Llamas

