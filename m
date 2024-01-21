Return-Path: <linux-kernel+bounces-32222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F03058358B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79A0E1F21F2D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4BD38FB6;
	Sun, 21 Jan 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aSu/M7sg"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227C1374EA;
	Sun, 21 Jan 2024 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705879344; cv=none; b=dR3goUmPWs1gLOgzUBOFyDlDprbtFj0WDLRjC/i+YwbmUuUGdTrUkSsWLHImBFe2bURdtvmMwlRjqd7sPLEoSeKmeFzobpurSiVYF7rANT0OTAPGWVd5VY8Hki9aZ+qvM3fSIh/WkrEaMA/cQDX8RpB3fPIlLZc349GO1mNX4Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705879344; c=relaxed/simple;
	bh=ehzyAReg4rP5zjQpD9surDz/ySyHRo1OYyKiUS1UE9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLwkAq4FepRujxPuETrryKYAg+pFWcp9a21WXPE+PL3SKzaUCsQpazHs4mNW1q8Wz29Ciys1JWgoAu4eC5fFLngB4ecPHxgHqCsnEEd7H934jnXw/H71JF825tBfIt0/G9oV3Snc/2nEPnxSGLL8bOD0HGRsxxR5xQkoON0UIPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=aSu/M7sg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40LNLxok2231331
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 21 Jan 2024 15:21:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40LNLxok2231331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705879320;
	bh=7jya2C1Xke7uzPYQqHJezOQiLdM+ZpoPy0MqrYayi18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aSu/M7sgXqZkeJg8FkOBDCNK+chhfVXZv+vz7jdiy/CtoYCC4GSdLu1wn70BSw3qr
	 nnK9+hu1pw2e/gfFT6EkC3GfMzCRpo/63GdcIkAFe3wdbc/2LLByPBl3wCKhbPyzXI
	 HgGoa8ABZjALAIXZiPqGQduF+MhkzGf8I2wQiYE8CnWLDhPR8IZ8GVsCopKHbAveAH
	 oHX/t6noy00ScnBQuKPbNnI41aOHlKolCfkzxAl4gK2PJApx2GS5naCb7MCyEmohSm
	 QblLRLK4Sv0Lb1VWj2KIbe2lF98JnQwgKk6xKpnGtRmek2kk/9MFiw24yHGtku+B7D
	 fws/LV8NKECtQ==
Message-ID: <d23e1b70-7ac3-49cd-8d5f-1dedc0108603@zytor.com>
Date: Sun, 21 Jan 2024 15:21:54 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86: Remove dynamic NOP selection
To: Thorsten Glaser <tg@debian.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, rostedt@goodmis.org,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
References: <20210312113253.305040674@infradead.org>
 <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
 <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Pine.BSM.4.64L.2401201652490.29203@herc.mirbsd.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/20/24 08:53, Thorsten Glaser wrote:
> H. Peter Anvin dixit:
> 
>> %eiz was something that binutils used to put in when disassembling
>> certain redundant encodings with SIB at some point.
> 
> Ah, fair enough. Maybe this could be added as one more line in
> the comment or something.
> 

I think "proper" gas syntax would be 0(%esi,,1), although that doesn't 
assemble either (I don't believe there is a way to get gas to actually 
generate this sequence.)

But yes, with all even remotely recent CPUs all actually handling nopl 
properly, this isn't relevant anymore.

	-hpa


