Return-Path: <linux-kernel+bounces-46117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A43A6843AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05EF4B2A193
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05877AE78;
	Wed, 31 Jan 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b="lEQNI/0C"
Received: from mailgate.ics.forth.gr (mailgate.ics.forth.gr [139.91.1.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B237AE6E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.91.1.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692405; cv=none; b=HRbLJq7O5GDkUeww3dK0I8q1PXNNRWux5VbetVCNGyW7PAyh/IDOttoan1tcK6xF/lcLGmvR/3cb09n5h303/Nzy2vqJYrCyENivxGMsKHVjtl6L0Ucoa/TFpBtx/390IJqslPJ/+VP/OiuqFJtJMRotQUbeWSa/X06wblEaEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692405; c=relaxed/simple;
	bh=IYBTdJHKQ0RVYWFXR/QOfnk02aGGwsRpeoUxX3/R4y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4aW/XQXTh78FLcoVdzQFkAqH9p8TFjhmC791kOlmsD31/nNmK2FAzHjrwU8tvwCFmSAPElP9cQS2sppBeddv8+0oJZbpimfiROblKvnw/AWmS9IMY7bVNrJ+qUOcs7mPGzluvxuFvB6dSfC4QW+6i3Iik9DGYCq+CZWzDRzHF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr; spf=pass smtp.mailfrom=ics.forth.gr; dkim=pass (2048-bit key) header.d=ics.forth.gr header.i=@ics.forth.gr header.b=lEQNI/0C; arc=none smtp.client-ip=139.91.1.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ics.forth.gr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ics.forth.gr
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
	by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 40V9DIPG038023
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:13:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
	q=dns/txt; i=@ics.forth.gr; t=1706692393; x=1709284393;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IYBTdJHKQ0RVYWFXR/QOfnk02aGGwsRpeoUxX3/R4y0=;
	b=lEQNI/0CXmtnIz2NGH/I5yO76PaRxkPFR6Ka1hgItKC9NSsc6jE1z/SfGA9hRKe+
	sxIfhFTunHRgGHci7LCfoc/I7089WqQieB7034iqvirwnJ5ouVAm2NFNvuSNYaXa
	QP9qOT1GzyuJC3GhkO1NvF/7/w70XDW16/idaguVVOx11+aIYiicZ1A6SpTauYsf
	YdWYQR7BEsDK4JDAXqSbype2IeuadZEKkhc+d/Ufnr62lxwf81NlUQex+UyFcksJ
	2lM5d2FhUd7+G/f6zCXbI/nKA7XtR3RUNJ0zGgNUA6QW5jeDx466iTfCmyb+1F4P
	RCZjTbXL5KF0FzSsBe9GcA==;
X-AuditID: 8b5b014d-a23ec70000002178-e3-65ba0f2980c1
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
	by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id E3.0B.08568.92F0AB56; Wed, 31 Jan 2024 11:13:13 +0200 (EET)
X-ICS-AUTH-INFO: Authenticated user: mick at ics.forth.gr
Message-ID: <ee1c316d-5bfd-4a5f-8e44-04a7c6f31b81@ics.forth.gr>
Date: Wed, 31 Jan 2024 11:13:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] riscv: optimized memmove
Content-Language: el-GR, en-US
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matteo Croce <mcroce@microsoft.com>, kernel test robot <lkp@intel.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
 <fa36b871-43d7-413c-82a2-0ecc0ebce9b4@ics.forth.gr>
 <Zbj1o6VAsk8Tn2ab@xhacker>
 <c6066469-7bc9-4232-b600-0b167193f13f@ics.forth.gr>
 <ZbnZthTjiUArHIvq@xhacker>
From: Nick Kossifidis <mick@ics.forth.gr>
In-Reply-To: <ZbnZthTjiUArHIvq@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsXSHT1dWVeTf1eqwdceToutv2exWzQfW89m
	cXnXHDaLbZ9b2CxeNT9is/j76z+rxcvLPcwWbbP4HTg83rx8yeJxuOMLu8fiPS+ZPDat6mTz
	2Lyk3qN1x192j0vN19k9Pm+SC+CI4rJJSc3JLEst0rdL4Mr49uwDc8F53oqe3RfYGhjbuLsY
	OTkkBEwkTj9pZ+pi5OIQEjjCKHHl4A4WiISlxOZPL4FsDg5eAXuJlqYSkDCLgKrEnh2H2UBs
	XgFBiZMzn4CViwrIS9y/NYMdpFxYwFBi9+1KkDCzgJzE+2fbWUFsEQE1iV/7HoOtYhaYxiSx
	/U4T1N5OJok9C7cyglSxCWhKzL90EGwvp4C6xJb1jhCDzCS6tnYxQtjyEtvfzmGewCgwC8kZ
	s5Dsm4WkZRaSlgWMLKsYBRLLjPUyk4v10vKLSjL00os2MYKjgtF3B+PtzW/1DjEycTAeYpTg
	YFYS4V0ptzNViDclsbIqtSg/vqg0J7X4EKM0B4uSOO8J2wXJQgLpiSWp2ampBalFMFkmDk6p
	Bqa2R4WLL4vtfKhg/HW5/JRZs2r5n4XPrbs/6+iiZRmZGi78wm+numxcFnXGwNThI2sox4Vj
	xxbvsHM2+C/25ajMwy1daese3OmaM/mRssql4+6zXh7+qnFKxO4997yuJY66YSayTDfXd/lx
	PpsRkaM7Y1Gny71/oX47ji6KDJ9+bv6jxYoq1+1u7Hj4MEvy2ESBmCtHaldlVpZN0Gfu0NV+
	/fSz+iK7QPM/TPO35rUnW7keWyJvuO5LsdTSuZoX5/7hMa5d7Fmu88D6kn8/bz6PebeQ8I1Y
	4ccSFmfzZlh6Lw7RubVUrjni/Ybn76/KB3++rHCKZWmr6La428+ONp3JCHmRssjC627W0fu3
	Nv6/r8RSnJFoqMVcVJwIACQyWkH5AgAA

On 1/31/24 07:25, Jisheng Zhang wrote:
> 
> I didn't have c99 spec in hand, but I found gcc explanations about
> restrict keyword from [1]:
> 
> "the restrict declaration promises that the code will not access that
> object in any other way--only through p."
> 
> So if there's overlap in memcpy, then it contradicts the restrict
> implication.
> 
> [1] https://www.gnu.org/software/c-intro-and-ref/manual/html_node/restrict-Pointers.html
> 
The union used in the code also contradicts this. BTW the restrict 
qualifier isn't used in kernel's lib/string.c nor in the current 
implementation 
(https://elixir.bootlin.com/linux/latest/source/arch/riscv/include/asm/string.h#L16).

> And from the manual, if the memcpy users must ensure "The memory areas
> must not overlap." So I think all linux kernel's memcpy implementations(only copy
> fw and don't take overlap into consideration) are right.
> 
> I did see the alias-memcpy-as-memmove in some libc implementations, but
> this is not the style in current kernel's implementations.
> 
> Given current riscv asm implementation also doesn't do the alias and
> copy-fw only, and this series improves performance and doesn't introduce the
> Is it better to divide this into two steps: Firstly, merge this series
> if there's no obvious bug; secondly, do the alias as you suggested,
> since you have a basic implementation, you could even submit your patch
> ;) What do you think about this two steps solution?
> 

I still don't understand why you prefer undefined behavior over just 
aliasing memcpy to memmove. Anyway, do as you wish, I don't have time to 
work on this unfortunately. Feel free to use the code I shared for bw 
copy etc.

Regards,
Nick


