Return-Path: <linux-kernel+bounces-165414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F04F8B8C6E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D429B281AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B3E12F395;
	Wed,  1 May 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcTQiYsB"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887351F176;
	Wed,  1 May 2024 15:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575940; cv=none; b=vF9/Q/K03ctwr+IushcRcNR7XXChSogFfUJNMd/1CdyyUOc0bxk8lJ3Nu6HHavUCsN82WAO3QfKTO2H1uZ4SC3AvKqjuewGvFnkh82IeKaKCtawQn50vQZkQZbLC4J9BJJqrTbVmKTSdS6EF7efXktkJnJRT/AkeaWwHPNzHIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575940; c=relaxed/simple;
	bh=0LPuILgN9KKKyMPNBS/R68ZSvyUCbK7Kcxt+UvNyHdI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gZAlVq819M//30O6IILUZJDV+qUgbkqV1HXEkRku3TVLCBHmZ4qgbzJwL5Ofnp6nqcffzq8p62K+mPOr4ySG7L+rMPmO8SeRMW16/UZE6JMNAEfhTLBfcdj9dR23BtjG0ktlXaSqgIme4GSsYE87DweLhRrGDIEJ9m9TgKVn5dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcTQiYsB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ec85c2f469so6509935ad.1;
        Wed, 01 May 2024 08:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714575939; x=1715180739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWxWJX11eAg9FS+Ru9ofosdq7Fb8dSZZNmQLifgagrU=;
        b=OcTQiYsBfrB4oPFLjXpXaj+lUjnw5nGUBJ3y9vYCYPU+lO1KkYdJ9/QFtdN3910TMU
         G/S1mFsxvC45fb1okmsJCPnAegOs8b6ba9Y3gymgHC2JkZoCKSiU8EG5FLJnc/0WA2Va
         oggFr6l0ktS2sLMBkZ+Setz+3Ug+onZRSF7OwRwH6mf+cQwxIYErrk+NcBo42QdqZ6aI
         D1vSouSV46KvsGUtCVadGAd3oSyOGFGjavfFr2kj3SKpkehv4xUBiLPcOsO/coMEQzZl
         pawqeBBPRt0ynMfDadMcnAe4Qzyk2rNXBVrV8tcjGQvYNHxQZ5yjex5co2sdvnJHsovk
         xQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575939; x=1715180739;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hWxWJX11eAg9FS+Ru9ofosdq7Fb8dSZZNmQLifgagrU=;
        b=lYmWxgFXpQzfL4n0BxhflhYML3NgGJGuyapwlxdkDZck1NklGEkOQEST97C2+b7MuL
         Pvo7mVU8I+ZlAWzBTSnW9hUga8wxmnT+SvA8O0ZgaErdksTuWIQmFfP4tJFWbXtrNgY1
         XLB/y8SY8g7EsEie6ps3OaFE/zXIIwrsndxBY4ZkBUqafjBiaF1Gdbv5MPJaquIjl/E1
         oo1Daik9cfF/Y0uyx4A6TYDd9CtehwjkEK+I6K02SHkmsxf3wrTOiXHlMrI8B9IZuAvZ
         tq+6XiSpoHY4YcKXW+a4B3LXm2ituP5G3fl8hjQ2QlyYfu1bfGvXcrzveoC0tL4OlEae
         pE+A==
X-Forwarded-Encrypted: i=1; AJvYcCVGwelGh9TtSW/MzevQYZDG8OYkQvVHcMy+whb9typNBTEC/+FfXWrBgJYbTPInHlQPv0uIMw5JFLb79d7rT0c7LR1Dt7+VNi1wGDBz4HoAStytf/rV99DQVI9me3KCAjXXAA3RG111
X-Gm-Message-State: AOJu0YxHsaVJ+oixfCECTY50a4lppt59A/vOaBgRoUMchM974MZjQRiQ
	7WTU+4JBF87Ht+8YGt62URUk+bopqx3o/X/gN3rx6JfTu7cyvB5U1FWB/w==
X-Google-Smtp-Source: AGHT+IGWpLiQvGZoxuBecjJuBP5c3RgGQYZJf026nWtRi+DzyFuFThe7gftdlzDKssFXGP++NguF6g==
X-Received: by 2002:a17:902:dac3:b0:1e2:a61e:47fa with SMTP id q3-20020a170902dac300b001e2a61e47famr4798582plx.15.1714575938634;
        Wed, 01 May 2024 08:05:38 -0700 (PDT)
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902f68d00b001ebd7ef383fsm5776707plg.203.2024.05.01.08.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 08:05:38 -0700 (PDT)
Message-ID: <b9e4bedb-6678-42ed-9ac1-c10179be5b69@gmail.com>
Date: Thu, 2 May 2024 00:05:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: utripathi2002@gmail.com
Cc: jiangshanlai@gmail.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, tj@kernel.org,
 Akira Yokosawa <akiyks@gmail.com>
References: <20240501133240.6003-1-utripathi2002@gmail.com>
Subject: Re: [PATCH] Sphinx error fixed for inline literal end-string in
 include/linux/workqueue.h
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20240501133240.6003-1-utripathi2002@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On Wed,  1 May 2024 19:02:40 +0530, Utkarsh Tripathi wrote:
> Fixed Error in Workqueue Documentation in the kernel-doc comment 
> for alloc_workqueue function in include/linux/workqueue.h, 
> the error was "Inline literal start-string without end-string" 
> which was fixed by removing the inline literal.
> Kernel Version - 6.9.0-rc5
> 
> Signed-off-by: Utkarsh Tripathi <utripathi2002@gmail.com>

There was a slightly different patch submission on the same issue the
other day.  You might be interested in seeing my response to it [1].

[1]: https://lore.kernel.org/r/6875fb17-f781-4594-803a-c11969f36022@gmail.com/

Quoting below for your convenience:

> In my opinion, reST-specific clutters like these should be avoided in
> kernel-doc comments as far as possible.
> 
> Instead, I think you can educate kernel-doc (script) so that "*" is
> allowed in the %CONSTANT pattern, meaning %WQ_* can be converted
> to ``WQ_*`` in reST.
> 
> For similar changes made against the @param pattern, see commits
> 69fc23efc7e5 ("kernel-doc: Add unary operator * to $type_param_ref")
> and 8aaf297a0dd6 ("docs: scripts: kernel-doc: accept bitwise negation
> like ~@var").
> 
> I guess it is $type_constant2 that needs a tweak in this case.

Unfortunately, there's been no patch submission in this direction so far.
I'd be delighted if you can try this approach instead.

Thanks, Akira


