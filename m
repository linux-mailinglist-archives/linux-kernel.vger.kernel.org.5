Return-Path: <linux-kernel+bounces-9865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE8B81CC86
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F50C1F22D10
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345BF241F0;
	Fri, 22 Dec 2023 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="GGzjwU9+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="HJMPjCJM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fallback25.i.mail.ru (fallback25.i.mail.ru [79.137.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC92241E3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=85kafTY7KbT+5VtPN9qDg1qFgQrgka1v5iPEHrMhU2k=;
	t=1703261017;x=1703351017; 
	b=GGzjwU9+21hUw9+QqqokdzmVfkmz1BGx8ZjH3W7zjxVP5HoomgltT1hYV4lTXiGY+7D4v4zoaz5ffV8eoBR2i43XB0Be+YW5hnbpeqbCEmZLM9f+4DpA8JXqCGOjjg9qsgyq78bOASZ0KGmXUIL1dZL+4gFGmnhDJnFDENqi4W9tDFxjezWuLVTBqZADLHKXcA5zpp1rD67QFKk8Uu4tDL65xh4G1eAHdywrjNur1wy/208P/QsGWMwU1mT5nyqRnWKJ5bw2cNoeeK+Nvi8Gs4SxmvSAcTKC5P8RhvLRZgj80k1BX0LRSeGZaLnCOLldWH1MyJqolrvqDMYk3Jry/g==;
Received: from [10.12.4.7] (port=58376 helo=smtp33.i.mail.ru)
	by fallback25.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1rGhbh-00BF4X-8L
	for linux-kernel@vger.kernel.org; Fri, 22 Dec 2023 18:38:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=85kafTY7KbT+5VtPN9qDg1qFgQrgka1v5iPEHrMhU2k=; t=1703259517; x=1703349517; 
	b=HJMPjCJMa/Yx2kHaVKmJRktPjYsuhfcjjmZx4VTg42EPQEON2qd4XBwmr336HwZQl912Z0PKmbS
	lIPJxmo8PmZEPJ5DNZdJB4Z/KhBfclvW9HPu/xxIsR9DizI/KJJRu+AWzUeP+c4A+1rPVe/UlVIS1
	fbJ3KU0fVtcoFHHaoqRveB8Y86DISK3UPu65qMaL7fvZBGPRUZERvMZz8IdlM0ATlTXTl31wqzLg4
	XxMJ7gQKX/d+Cil316mFLdZWdnEc1wfiDnPF+FwNWiAdnAcrNtC/Ek+X/Y84JL0PkJ7hldNReysaG
	wlYrd4+nxPqv1HHxNp4n08plR27cNEj+RDOw==;
Received: by smtp33.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1rGhbT-009rUC-0p; Fri, 22 Dec 2023 18:38:23 +0300
Message-ID: <be10eb21-a0ef-416e-9c0c-d53326996fba@inbox.ru>
Date: Fri, 22 Dec 2023 18:38:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org, mpe@ellerman.id.au, aou@eecs.berkeley.edu,
 palmer@dabbelt.com, paul.walmsley@sifive.com
References: <20231221185152.327231-1-fido_max@inbox.ru>
 <20231221-discount-decade-e306e5878c46@spud>
 <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
 <20231222041428.GA2803@lst.de>
 <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru>
 <20231222-outburst-spoiling-75082a7826dd@spud>
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20231222-outburst-spoiling-75082a7826dd@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F008C97756F746CA9F9F626400B4C8CB441F7099A0113699182A05F538085040499B707A292F8483A881DDBE56C0008D58E5AB02939210A3DDD8407079B9EF40
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78044725E6B9C7F2CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372A1456D053D20C618638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B963F5DEC411EA029331EB5E595B99A36F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78C592797616C97AB9FA2833FD35BB23D9E625A9149C048EE26055571C92BF10FCB629EEF1311BF91D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BEA77C8EAE1CE44B0A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C2249957A4DEDD2346B42E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6A45692FFBBD75A6A089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5EA1E7903783D8CAAE0F401BAFC31E2719BBB080C10DF431BF87CCE6106E1FC07E67D4AC08A07B9B082B967D547A19D2FCB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34A533D6DF7731C664AC7F76B4FCEA1BEFB0990B5AFB0E23427C2B72958CCAC97D6633305872F7E7A11D7E09C32AA3244CCA61C7B5B7DB41DD740043EEAE3CB8628894E9C85370243EAFF760E3CF2A505DB6C6411D86935C892AB2189BCAD71E73D640157F23F2FFE137E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj2irTGYQEnL0dvgbPSlS3lw==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE333CD8B99EC2B6F0CA72009BD1587A63E198CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46003E5D5A82ECDADC2F54683050715117C7E3A1CC045E01D049FFFDB7839CE9E0BADB79DF678AC5C1E977A46F5380C9C4EA3B508303B054B3720AC98E96B10CA
X-7FA49CB5: 0D63561A33F958A5281C5200B020EB5A23422A90A022143D8149851BE6CE3271CACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637CBDA538BD653CEDD389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC84B6F6234D9065C97F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7CD707F342D9BDC98731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj2irTGYQEnL0dhe2jwtoofQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok



On 22.12.2023 17:54, Conor Dooley wrote:

>> etc..) do not have this feature. These devices will use value from
>> device_initialize(). And we have no possibility to change
>> dma_default_coherent value by disabling ARCH_DMA_DEFAULT_COHERENT.
>> Moreover, changing dma_default_coherent from false to true may cause
>> regression for other devices.
> 
> How can there be a regression when dma has been coherent by default for
> the RISC-V kernel from day 1?

Before ARCH_DMA_DEFAULT_COHERENT patch dma_default_coherent was used 
unassigned as "false" in device_initialize():
..........
#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
	dev->dma_coherent = dma_default_coherent;
#endif
..........
And now it becomes "true". It may change behavior of other non-DT drivers.

