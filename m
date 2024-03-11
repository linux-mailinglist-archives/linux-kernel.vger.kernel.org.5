Return-Path: <linux-kernel+bounces-98639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4E8877D16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10901F239D4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4E118B15;
	Mon, 11 Mar 2024 09:39:19 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5407012B7F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710149959; cv=none; b=eB/YRhSr+h76Qf+h3mLVKmg3Uudggoc+GiB3vb5i0/NNpsKK2/ceuUVntxTaIOm3F89GysOzvKapHzRZ2ohTazi04HKoJyb352/CO4hpTrpYOJDUBdqA0FZFyMulmqEHIicvz+1wkjwb+6WJCanhFOYNFPtKgZrYC1h5ZbVw6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710149959; c=relaxed/simple;
	bh=MYutdIjb/N7Yx3CRS+y5HbEnA1UZT5yZzKO7IjnGQik=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GqF6PQ/Qdc4L1zwx+eHT3rzTpv3ABuB4Fyj7B0YIZoM8JNErHY8btx2VduIh/Au7h+wslOILAQuXDGKMqa6swzXYGI4zUe0irNo/JGFaQt8sn3jHYb2ZaO/IgS8CfW+bWCUp2Ku5UuvAo+BxDCqEucedN5Zo/Es1OfCF+RESrmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TtWrM5qnXzwPQM;
	Mon, 11 Mar 2024 17:36:51 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id AC1AC14044F;
	Mon, 11 Mar 2024 17:39:14 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 11 Mar 2024 17:39:14 +0800
Message-ID: <79b87ef0-77c4-45a9-aae2-1754f1b407fe@huawei.com>
Date: Mon, 11 Mar 2024 17:39:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v2] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Arnd Bergmann <arnd@arndb.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Fangrui
 Song <maskray@google.com>, Russell King <linux@armlinux.org.uk>, Andrew Davis
	<afd@ti.com>, Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Jonathan Corbet <corbet@lwn.net>, Mike Rapoport
	<rppt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Walleij <linus.walleij@linaro.org>,
	<llvm@lists.linux.dev>
References: <20240307151231.654025-1-liuyuntao12@huawei.com>
 <58cc1053-7208-4b22-99cb-210fdf700569@app.fastmail.com>
 <42892794-7668-4eb0-8d2f-c78ca0daf370@huawei.com>
 <2a90581c-f1df-4d6b-8f0b-8e7cbf150ed9@app.fastmail.com>
 <346e15e5-49e9-4a7f-b163-c3316225baab@huawei.com>
 <CAMuHMdXKk9S9voKVPvO+xvn1zFW3FnKyVHQGDkC7b9Ynkcnvmw@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CAMuHMdXKk9S9voKVPvO+xvn1zFW3FnKyVHQGDkC7b9Ynkcnvmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/3/11 17:14, Geert Uytterhoeven wrote:
> Hi Yuntao,
> 
> On Sat, Mar 9, 2024 at 2:24 PM liuyuntao (F) <liuyuntao12@huawei.com> wrote:
>> On 2024/3/9 16:20, Arnd Bergmann wrote:
>>> On Sat, Mar 9, 2024, at 07:14, liuyuntao (F) wrote:
>>>> On 2024/3/8 21:15, Arnd Bergmann wrote:
>>>>> On Thu, Mar 7, 2024, at 16:12, Yuntao Liu wrote:
>>>>
>>>> Thanks for the tests, CONFIG_LD_DEAD_CODE_DATA_ELIMINATION and
>>>> CONFIG_TRIM_UNUSED_KSYMS do indeed result in a significant improvement.
>>>> I found that arm32 still doesn't support CONFIG_LTO_CLANG. I've done
>>>> some work on it, but without success. I'd like to learn more about the
>>>> CONFIG_LTO_CLANG patch. Do you have any relevant links?
>>>
>>> I did not try to get it to boot and gave up when I did not see
>>> any size improvement. I think there were previous attempts to
>>> do it elsewhere, which I did not try to find.
>>>
>>
>> I tested this patch, the size improvement was only about one
>> ten-thousandth, and the compilation time had increased by about a quarter,
>> and the kernel did not boot.
>>
>> Strangely, LTO has actually increased the compilation time
>> significantly, which seems contrary to its purpose.
> 
> The purpose of LTO is to reduce code size. Doing so requires more
> processing, hence the total build time increases.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

Thanks, Geert, I got it.

