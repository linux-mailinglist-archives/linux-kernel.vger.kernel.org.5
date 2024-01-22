Return-Path: <linux-kernel+bounces-32272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC0835947
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C281C2181B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB931EBB;
	Mon, 22 Jan 2024 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kx2mpDiZ"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1071A29;
	Mon, 22 Jan 2024 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889769; cv=none; b=S7sCA+LtfrhoZcoe49QzxJv8L5RlSHq+0AGm17eHEUIgOmeLGnF0oA30lkVnEv1fP/FhuuSaDbvZWw8Y+TC8qHhpK49l+GIqQBodQfArEMJotB+fGlZ5vQ64NOG/qUtrM+UeM73JSZJSsQ1TGz6q6pm/5HCFtyGCA+Cm0WKUutY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889769; c=relaxed/simple;
	bh=NlE0A3R+sz1AENbMqNSyBeWJtkZ6eYpNoQcZqQZYgSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5heVrw3R+xkXzOsaf0JcxZoXdKUaMFDQe7DZQpGOI0HdWoZr35gLs7mYpYFh0VzuJNBOIHbEmeyX6PU6drmXGgQ0jY8psF75ZDaY0cZde0893I5V1dZYwowKzNL71GtTOgG9+QIW8AxBPdeUeDBSVEEjFmxFA9CSWwSO5ODEQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=kx2mpDiZ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:ca4b:30a3:a7c4:4227] ([IPv6:2601:646:8002:4640:ca4b:30a3:a7c4:4227])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40M2FigV2293158
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 21 Jan 2024 18:15:45 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40M2FigV2293158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705889746;
	bh=jy1plg5e+XUmSLdqsgI3NMM7QyQk+y01Y5z5ug5i+Jk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kx2mpDiZXsFjyPz0GULGe/BaQJPLKkxNTSRtIPPY82/DQdULJFf6ya0n9SAURAWO/
	 86Oafx2FFRtNst6LQAkpCuXgnqb+xafWz+vuDEq+VBRAaJn0dXoljd+39twuUTLSWh
	 3xrEmjc7pmrHf/81TCfRSZtl/hy89m2zsPuk7E5qSBKNPqgU24yYAIew8JH001vidf
	 msA2LIKlYfU/sy3XB26sJh7awltViKYWCCsVSKcNkcQO849TPq9sNyxGnFKXx+ftrI
	 LKGM+nyKGjPYVisH8dpAeiiYSrkM9O+smlGosVjnDo2/qIUCsvrL0Ke/p4vrGH3o+r
	 YV7aU/cf1fCsA==
Message-ID: <020a1803-25c4-4365-8c53-291becd94632@zytor.com>
Date: Sun, 21 Jan 2024 18:15:39 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>,
        x86@kernel.org, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com, mhiramat@kernel.org
References: <20210312113253.305040674@infradead.org>
 <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
 <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
 <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com>
 <Pine.BSM.4.64L.2401212356390.999@herc.mirbsd.org>
 <20B57BDC-9A3F-4B02-9BA9-41477088A6CE@zytor.com>
 <20240121195649.7355e1d5@rorschach.local.home>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240121195649.7355e1d5@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/24 16:56, Steven Rostedt wrote:
>>
>> Yes, but it is a matter of where we optimize for performance as opposed to correctness.
> 
> There is no such thing as "optimize for correctness", it is either
> correct or it is not. Correctness should always come before performance
> (at least that is what Thomas has pounded into me ;-)
> 
> If a kernel use to work on a machine but a newer version no longer
> works, I call that a regression.
> 

There absolutely is such a thing as "optimize for correctness." It means 
to keep the code clean, easily testable, and with a minimal number of 
distinct code paths so that regressions and *especially* uncaught 
regressions get caught quickly.

	-hpa


