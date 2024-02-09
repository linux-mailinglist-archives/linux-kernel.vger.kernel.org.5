Return-Path: <linux-kernel+bounces-60143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0608500B0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C4B31C23D50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C93938DDD;
	Fri,  9 Feb 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM8FmB0C"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EED374F1;
	Fri,  9 Feb 2024 23:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520811; cv=none; b=P4qOLjbxUWGyfKcwmHlLzf35+LTw/zeDdCGAEEUB6v+R5FeRhKy90Jl4ruB87UTSMft1qUixil8vkCbpcVX1gGk6WCIrFxJClHbcRmhbtn/px1Tbq9FPO+VnwuVHgaTLgIqNJrnmlBuUB8cNsHnkHuJWWJ2vsdI4LcMVzqTVMaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520811; c=relaxed/simple;
	bh=s8+JThjOLWZYxS6Wz7yMLXJSk1mkS2CUnkq/spkXnAQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=CWnhS7relcy+2tyY9sk0h8HvLFGyA2ugyYL/7Rf2bAx7tnAD2QPeP7LWIR3g03B0VKeDqX2jn18tkx1owIVN9kTKV/DnUkX+HGjaTBqgL4d6nGPz+U/KrkD9Jae0VCsYyRcVMPIs6z8YHdmxyFe5g2lpT2O3OS6hA7bwIuBzPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM8FmB0C; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d932f6ccfaso11766265ad.1;
        Fri, 09 Feb 2024 15:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707520809; x=1708125609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ltg6lO1oS8AWhQ5+N+TRDT9oy9pLlputYPkulGsyy+U=;
        b=jM8FmB0CD/AmAkb/nDsf2VKNV8S2mFsJgeUX2Xi672zTHqVi6v12B1OCl+tMznKp76
         ThJnb0mi0m1Xh2NN4Sx54PGhyEuDMt8uXFoy5olS5pgnmmYxrRqKgXysZhYAnaz0w8Ob
         p25GsrV+lew6O5jO1r/FXaM7lyTSdtizNXYBhTRXaUvgfkijqsU4ZN4aR0fAo+LBfLm2
         faxe8qI8IyPbPrQnCwvJv7WB8gjf0+by3YTWDUA38EWjGH4OZ2LdyL1Y7WuJL9goVBeS
         oJtO85H4+2PsAbjGjMZsQ29DdLGB96lsHrBQTKwuyCYMuNXybAPSPZGmRBNM+SgFypB9
         JbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707520809; x=1708125609;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltg6lO1oS8AWhQ5+N+TRDT9oy9pLlputYPkulGsyy+U=;
        b=l3pWo09R1hWp95tYNFeFwAVBYcbnRddyRlUX+AKp2lOUh1/oBUqFx1Uusp/2UjBaDt
         OkxdnuXUefQL3FdFi8UX1ZeNM7CNoNz0VUI7GwVwPMWMdmQQRJML5gSRwtZUITbcuQYe
         5W9WiPK4K0iYXvBMLZE2DSlHiFjwXgjcRXbJ5eAEGkpa5tBckiOnNYFZ3HTQIBDwlr/B
         g6tM5VlQpCjtQ96wa8TSA8x0ynVBk3oibY1MeB254n9/xXT1Niw1z+a2nUtjbRDVM5VH
         OyvDSa4ZKCe3kDP6deudHJsQgb8ux/dkQwlTcGz6wTvx73ckufoGADhJGNsdQ2Dbi3YR
         lZPg==
X-Forwarded-Encrypted: i=1; AJvYcCXpri56G9B1Gw8ZYWt+Kxu7WNy4LuKWBNw8c5xYeS1B8NsmEaZXeCGqm7P6ivQMIJ63NBlbYrsaDMm5ccjJMkFmTWCIlrjo9oOnajtJXQqIEYYRmJVQT/T+/XfaEgm+7b7LzyOmbY0jBQ/eL91qMPMzamBlFj+bgjYzO0fhvraL
X-Gm-Message-State: AOJu0YwFArfr9IVCMRR2p6diEA4a34ebcCyhM9fptahmQfxueEjy6WRK
	bkWGMKmcFJFXV1QbIEP1N3ksHOVQoJvJ4+xUgzxS+DQMvizBgbSM
X-Google-Smtp-Source: AGHT+IHkO5tVoG4DnwrGnYtUtoX4VwHX7HlHF7glv0Pz+lcGgj7Lof5EGnid8D1aZ594vLVOLpZ3pA==
X-Received: by 2002:a17:903:184:b0:1d9:b8bc:fd7 with SMTP id z4-20020a170903018400b001d9b8bc0fd7mr604591plg.68.1707520809293;
        Fri, 09 Feb 2024 15:20:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9Ev0PJemXSnZvJeZYSgx8UAetmIwNOFiv8rzP7M2pekC90OonFsLNPsf3SRPDopd71LrrF0NNBi7vvZUuduGjZK85p+TDvk2nxOB4BFlVM4fCKV1B4ZRAOZa02xTfhgcGczjDvxlsjvNl1gcOCTVMcH79CEuolJfKse9vxx3IssaYFr9O1twrDYIGAk8D6aEPN8nPwl0FF1GQmt46IdKcgOWMHAVOHQzZzhjpk52XlwkXw1rjYWD4xFhbUMd3RhlS/zwlIXErHwddwDsFSUgutbknEk/gS8NiKSVY5baNMU4qbAgid10f+JNSX3vyrdw+0+hjF5gwEEqz9A8x
Received: from [10.0.2.15] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id li12-20020a170903294c00b001d9ef7f4bfdsm2020978plb.164.2024.02.09.15.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 15:20:09 -0800 (PST)
Message-ID: <d8bce254-74a8-4d4e-8739-2d96a697782d@gmail.com>
Date: Sat, 10 Feb 2024 08:20:07 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vegard.nossum@oracle.com
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
 jani.nikula@linux.intel.com, kuba@kernel.org, leitao@debian.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <2d3359b3-f124-4ddc-97e0-cd56d0e7b966@oracle.com>
Subject: Re: [PATCH v3] Documentation: Document each netlink family
Content-Language: en-US
From: Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <2d3359b3-f124-4ddc-97e0-cd56d0e7b966@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 9 Feb 2024 15:47:16 +0100, Vegard Nossum wrote:
> On 30/01/2024 17:23, Vegard Nossum wrote:
>> We should still fix the writing of .rst to $(srctree), though -- our
>> use of parse-headers.pl seems to sidestep this by writing the 
>> intermediate .rst output to Documentation/output/, I'll have to look
>> a bit more closely.
> 
> I have now spent quite a bit of time investigating this.
> 
> The main result is that Sphinx really does NOT like it when documents
> are located outside of the source root.

There is a hack extension named "kernel_include".
See Documentation/sphinx/kernel_include.py (no, I'm not saying
I understand it.)

The "kernel-include::" directive is exploited only in
Documentation/userspace-api/media/dvb/headers.rst.

I have no idea if Jon is happy to see another subsystem
to start exploiting this extension.

And you should be interested in seeing
Documentation/userspace-api/media/Makefile and how it is integrated
into Documentation/Makefile.

I think media people are doing similar things you'd like to do.

HTH, Akira

