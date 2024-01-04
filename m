Return-Path: <linux-kernel+bounces-16557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CE882402E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DED1F252F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D07210F3;
	Thu,  4 Jan 2024 11:02:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD286210F1;
	Thu,  4 Jan 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7888E240005;
	Thu,  4 Jan 2024 11:02:07 +0000 (UTC)
Message-ID: <b402da25-74a7-4e27-8e43-623ae1599d84@ghiti.fr>
Date: Thu, 4 Jan 2024 12:02:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 2 (riscv: exittext undef. references)
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>
References: <20240102165725.6d18cc50@canb.auug.org.au>
 <8693bf84-b3b5-407b-871f-4add127272ee@infradead.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <8693bf84-b3b5-407b-871f-4add127272ee@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Randy,

On 02/01/2024 18:15, Randy Dunlap wrote:
>
> On 1/1/24 21:57, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20231222:
>>
> on riscv 64-bit:
> (gcc 13.2.0)
>
> riscv64-linux-ld: arch/riscv/kernel/patch.o: in function `.L8':
> patch.c:(.text+0x17e): undefined reference to `__exittext_begin'
> riscv64-linux-ld: patch.c:(.text+0x19c): undefined reference to `__exittext_end'
> riscv64-linux-ld: arch/riscv/kernel/patch.o: in function `.L43':
> patch.c:(.text+0x40a): undefined reference to `__exittext_begin'
> riscv64-linux-ld: arch/riscv/kernel/patch.o: in function `.L0 ':
> patch.c:(.text+0x428): undefined reference to `__exittext_end'
> riscv64-linux-ld: patch.c:(.text+0xae8): undefined reference to `__exittext_begin'
> riscv64-linux-ld: arch/riscv/kernel/patch.o: in function `.L82':
> patch.c:(.text+0xb06): undefined reference to `__exittext_end'
> riscv64-linux-ld: arch/riscv/kernel/patch.o: in function `.L118':
> patch.c:(.text+0xd6e): undefined reference to `__exittext_begin'
> riscv64-linux-ld: patch.c:(.text+0xd8c): undefined reference to `__exittext_end'


This one is already fixed by this patch: 
https://lore.kernel.org/linux-riscv/20231214091926.203439-1-alexghiti@rivosinc.com/

Thanks for the report!

Alex


>
>
> Full randconfig file is attached.
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

