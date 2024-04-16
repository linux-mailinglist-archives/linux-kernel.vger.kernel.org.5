Return-Path: <linux-kernel+bounces-147355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5C38A72DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1E41F228EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D8134CD4;
	Tue, 16 Apr 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d4oHhak1"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2B13343F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291135; cv=none; b=A6v+2MRmMo4MDpF6C259u4b6MC7KHVZQWItb4mBHb6/8FS7cWSNIbKL2ILh0NxqZz3d/+dSO1Hgn75q1dvVSxndYlDuEMO4q9YB5PBBgEiFMef84LYKYq4ZtLG7Rk0amn5IHu+SkjB9uVQEUwUmIeczqjen6ViNr94YqpE6j71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291135; c=relaxed/simple;
	bh=TnlZvVJj+tUuYBS/gyNODwaQ8kYkGHafqDe7bPx4asg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJJRSzFlVuUEm49ZBIb1iXLvmVL8/Q+hmD4QuC6ARqcCkrOAf6YEhgWPgfpX2bocc5CCipBeYhsaUO9AQTiqwmdXz6Xw/ocHfyPwTwWYo9PSLpPXhdVxWBbO6kBIXGIQ79BwgGfbeJkCVQab9PJO2Y64HOKtyGJrAGCMlxmcy38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=d4oHhak1; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43GIBnVQ3336923
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 16 Apr 2024 11:11:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43GIBnVQ3336923
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713291110;
	bh=oSoc3fRQu2SYnHBcMoGn1X200+uujndTDonzbZqfy7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d4oHhak1j4CdsVq4b/eqx91gPiRgCEyAvxYUi2O9Xv1lnPCkYDAlJS9gG40LHBoRr
	 LD2iPWy10h2O7IK65NWx29CW4iyT8FUBBw6M39odyXHdzXVdrHAUDi6d4EhdLb7Mia
	 euUmsN1hFGTJi/+03RFKFyjpIcXfrY2uxI46gqC4430YcMG4frKhjrws4JR8htVXEp
	 TOrvK5w+j96HydCGa9Lcb/DPCQY0Ui5SosaBGjyxVCQ/4mg51sjC/5gcS79t7Ly10k
	 Wp+QIo5sQsUQtiCMttwdPo7Z3YaElqREXcpK7ustcX0l+a8ZP/IQ7CR9hk4Qov/Pp4
	 +rvyrEJnLvA5A==
Message-ID: <e3fbd500-f6b8-49ea-addb-bbc4803709ce@zytor.com>
Date: Tue, 16 Apr 2024 11:11:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240412234058.1106744-1-xin@zytor.com>
 <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
 <1AE9FA53-A130-4F95-8408-C1990DD031AA@zytor.com>
 <20240416180746.GFZh6-cmZqCF6KX5tt@fat_crate.local>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240416180746.GFZh6-cmZqCF6KX5tt@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 11:07, Borislav Petkov wrote:
> On Tue, Apr 16, 2024 at 11:05:09AM -0700, H. Peter Anvin wrote:
>> The question was if you wanted a quick fix for x86/urgent. It's pretty
>> obvious that a FRED fork of the int80 code is called for.
> 
> Yeah, I'm thinking the FRED fork would be even easier to send to Linus
> now since no existing hw will break.

Looking at the resulting code (Xin's v2 path), I would agree with you. 
The code is downright trivial.

> Btw, I presume that patch needs to have
> 
> Fixes: 55617fb991df ("x86/entry: Do not allow external 0x80 interrupts")
> 

Yes. My fault, I gave Xin incorrect information w.r.t. Fixes: tags.

	-hpa


