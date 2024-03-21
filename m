Return-Path: <linux-kernel+bounces-109856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C02885694
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7C3282BEC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52F53384;
	Thu, 21 Mar 2024 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Oc2UNrB6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C705579A;
	Thu, 21 Mar 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711013587; cv=none; b=mtxOuKzP0dl8u8GQ0/gTzB+bHJjmXZZDMFAJMfHeh+tlPLL2S1TnSIsfPuM19IKkoxSa3vSW0yLWfp8y5RkI+rLnZyG9BUYbOggc86zYl73s7EUkvMvsD9NdoH5V0P5cIAHqlBrmcXqmnoTTe3KuHp9OR9cpou3PfiZ9B0PqZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711013587; c=relaxed/simple;
	bh=XicOA/rd5rXSwjpSJrCdlLs6Mlqt1T3aAFaf41e77ks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDq/k2sMdK5GJtCrrkcFfc49inkcxmBXQEwqaHHfuWF73+bR9q2JGAf/D1T0QrAKYuKCDqNOJpTwnloV/tMj8jvlO5rT+ghCWA+Cvi5q9bVicrZ3GJzH0kFdKGXTusMhFtd8cumM2AlqP9KU0wvKVgJpGr6izypu1wuj3qCqMNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Oc2UNrB6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=webeErP71bGrCtrnKMl3CyhYpAF0y0SlAUiPvCaWPVw=; b=Oc2UNrB6E4lFSOnZpA7d1IatjG
	W6hsUIFRGF6ZFdsUcV+Adz6oXUqJdPj+7cEAaWcSBjDWNgoRuI2o27QS02PykktSaeAZdv749sCRa
	GdhddvtLxLuV4PC7ecOpTa1Y/35qamO+DvRbrZCenbBNBj3ZolBVbDPH/6oOyDG9UQpmYYsgMTitk
	keK7SpcRac5G2tKjYbEz4qh0FgAbUW/zsobZ/WBh/npQDKa63ho3GLNifaGtQM7cc1/VHRA70bpV0
	wrvzKP3/QqHx02S0Azo0b9GZC6bYxv2ww0qOEcALXPKWsZBEKrHBF6rbKfJCMZt3IeZ48LE5HcH0T
	OTZF9h8g==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnEmp-00000006Qam-3O3a;
	Thu, 21 Mar 2024 09:32:36 +0000
Message-ID: <ec1b6bdf-1676-48fb-99f0-a8cc2a99dd17@infradead.org>
Date: Thu, 21 Mar 2024 18:32:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: ps3: mark ps3_notification_device static for
 stack usage
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
 Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20240320180333.151043-1-arnd@kernel.org>
 <CAMuHMdW41e+DSBKBgugTkjoLy6bXfji-KWmB_d9EstEv01eC6w@mail.gmail.com>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <CAMuHMdW41e+DSBKBgugTkjoLy6bXfji-KWmB_d9EstEv01eC6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geert,

On 3/21/24 17:32, Geert Uytterhoeven wrote:
>>  static int ps3_probe_thread(void *data)
>>  {
>> -       struct ps3_notification_device dev;
>> +       static struct ps3_notification_device dev;
>>         int res;
>>         unsigned int irq;
>>         u64 lpar;
> 
> Making it static increases kernel size for everyone.  So I'd rather
> allocate it dynamically. The thread already allocates a buffer, which
> can be replaced at no cost by allocating a structure containing both
> the ps3_notification_device and the buffer.

This seems like a much better solution.

-Geoff



