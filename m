Return-Path: <linux-kernel+bounces-10291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABC581D245
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 05:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236411C224C9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6328A4A15;
	Sat, 23 Dec 2023 04:59:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800246AD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 04:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C624168B05; Sat, 23 Dec 2023 05:59:12 +0100 (CET)
Date: Sat, 23 Dec 2023 05:59:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Maxim Kochetkov <fido_max@inbox.ru>, Conor Dooley <conor@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org, mpe@ellerman.id.au,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
Message-ID: <20231223045912.GA21836@lst.de>
References: <20231221185152.327231-1-fido_max@inbox.ru> <20231221-discount-decade-e306e5878c46@spud> <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com> <20231222041428.GA2803@lst.de> <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru> <20231222-outburst-spoiling-75082a7826dd@spud> <be10eb21-a0ef-416e-9c0c-d53326996fba@inbox.ru> <7bc138f7-d5e9-471a-ae82-d6c490645623@flygoat.com> <6fe34090-656d-491f-8173-217d20144166@inbox.ru> <a25d3736-f6ca-478d-8e58-69a7c0e529f7@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25d3736-f6ca-478d-8e58-69a7c0e529f7@flygoat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 22, 2023 at 04:01:43PM +0000, Jiaxun Yang wrote:
>>
>> But arch_setup_dma_ops() is called only from of_dma_configure_id() and 
>> acpi_dma_configure_id(). So it works only for DT and ACPI devices. What 
>> about platform_device?
>
> Ah I see, that's the problem, in MIPS's use case all DMA capable devices
> are following platform's default coherency. For RISC-V we assume all device 
> are enabled by ACPI or DT.
>
> Perhaps you can override it in driver, but that will make drivers platform 
> dependent.
>
> I'll leave this question to Christoph.

I've already said it.  You must not have DMA capable devices that aren't
declared in ACPI or OF, just like on any modern Linux platform.

What devices are you concerned about anyway Maxim?

