Return-Path: <linux-kernel+bounces-9875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C481CCA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 17:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD521F21144
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69CA24202;
	Fri, 22 Dec 2023 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="wI5IBZ8q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="ogZnb0/x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B824B3D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=tFX7RIj6C4VOXEVclZN5OjxZXLaRdz1+7SGbge9WIxs=;
	t=1703261894;x=1703351894; 
	b=wI5IBZ8qI73eWxO8Rukjh2mI9mufiGcdEtwsWalAfyh2PpOVN9rCUSa80TnuLUggppioQQ6vVPznmhytf/eyfTKCB83wBTY8PBPI3pL2qXBQ1n4IanRLh2Ofu4+P5LFkQvAjVg8C40f4sguGgVbUqKp/zNGQAY50f3JFPWUR/kOeh2rqnRFQ0TxJuPtUHdSYe7UTtA3bEjWvlJVFcOhQ3Oz74RTuB62nHx8l5S6JyC7Cthp5SETLvHzL9Ytw3fE4YGzAB3R57ZYrT1zzUiWJ9rszkAJaZHiezn/HhACY36F8GU98gw9XiKH+PDzOfl6DtEDR+fuGq2TP//9OGDfAHA==;
Received: from [10.12.4.21] (port=52596 helo=smtp42.i.mail.ru)
	by fallback17.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1rGhpv-00FFLQ-63
	for linux-kernel@vger.kernel.org; Fri, 22 Dec 2023 18:53:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=tFX7RIj6C4VOXEVclZN5OjxZXLaRdz1+7SGbge9WIxs=; t=1703260399; x=1703350399; 
	b=ogZnb0/xHvzaQE75GbxHmpzAx6t+XiY4+odaxklkb2laoD5i7gNxVkYhArRjuz+zimsJAqP/qdb
	+t54uhxRXh4EKNAv34r8ufSjfDEOJC+QJenjmbpBYJl1t/GEUki5MbNn1spD4yGZnyndwJi/KIEvV
	k51Gw/PuK6m5ZdqVhXuBm/bdw4SuhS7fKPSvEERFqA07hotUbqFWvPUaYODsp5RyaGhPA0ku7T2lE
	C7JBBO5CmH2kclKrTdmLQm6DAahzy5Lktv7Af99c0qGhaOdMDubLzJukLMnHDEpZ5xlCVm58iaoh3
	g4etdAzIqtRKYtA3uM3IHC2NoFGsS1AvX+Uw==;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1rGhpg-00796u-0F; Fri, 22 Dec 2023 18:53:04 +0300
Message-ID: <6fe34090-656d-491f-8173-217d20144166@inbox.ru>
Date: Fri, 22 Dec 2023 18:53:03 +0300
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
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, Conor Dooley <conor@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, mpe@ellerman.id.au,
 aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com
References: <20231221185152.327231-1-fido_max@inbox.ru>
 <20231221-discount-decade-e306e5878c46@spud>
 <f31d929c-fa0a-4046-be05-38e92afa5d92@flygoat.com>
 <20231222041428.GA2803@lst.de>
 <c53c22dd-c482-4808-bdd7-e81c01c04f9e@inbox.ru>
 <20231222-outburst-spoiling-75082a7826dd@spud>
 <be10eb21-a0ef-416e-9c0c-d53326996fba@inbox.ru>
 <7bc138f7-d5e9-471a-ae82-d6c490645623@flygoat.com>
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <7bc138f7-d5e9-471a-ae82-d6c490645623@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9F008C97756F746CA109546F350B61F5EDC408D7902253DD5182A05F5380850408BBE584FEAE74C4539FF6257257E6F732B69E9FC229A0382F9F108893D24C065
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7D3DF794D859AA4BFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063745476ED688D943148638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8C6DD7975580F9310C78194386F3CEFB36F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78C592797616C97AB9FA2833FD35BB23D9E625A9149C048EE26055571C92BF10FF04B652EEC242312D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BE2CCD8F0CAA010FB389733CBF5DBD5E9B5C8C57E37DE458B9E9CE733340B9D5F3BBE47FD9DD3FB595F5C1EE8F4F765FC8C7ADC89C2F0B2A5E2021AF6380DFAD18AA50765F790063735872C767BF85DA227C277FBC8AE2E8BDCE939D40DBB93CA75ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A5A9DDD64047EE0ECD726471AB7954A9BFC5C376C41ADB842DF87CCE6106E1FC07E67D4AC08A07B9B0735DFC8FA7AC1207CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34D041FB2E16F174C4814B294BBADEE008254CAADB2070B4D94B27FDBDE07EC7DA9DFAD9A56969026F1D7E09C32AA3244C5A6F8828DC41BDF772EC9D558279C71A35DA7DC5AF9B58C0AFF760E3CF2A505DB6C6411D86935C892AB2189BCAD71E73D640157F23F2FFE137E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj2irTGYQEnL3NODs1OB0pRw==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE33BFF2CCA92290786441A33AD183A5E18A98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46003E5D5A82ECDADC2F5468305071511C06403940444F9E8049FFFDB7839CE9E0BADB79DF678AC5C7542F321C104C84D7141874FD8F9EA385E883CF4852BFECB
X-7FA49CB5: 0D63561A33F958A546C116D757D560B50E904A40390BE319D5DDF046E9BEDDEBCACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F7900637006720155ACF5028389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC86FF1B927F95F3316F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE78DD9044B304389D4731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2bioj2irTGYQEnL3RnJf2YMVcBQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok



On 22.12.2023 18:45, Jiaxun Yang wrote:
> 
> 
> 在 2023/12/22 15:38, Maxim Kochetkov 写道:
>>
>>
>> On 22.12.2023 17:54, Conor Dooley wrote:
>>
>>>> etc..) do not have this feature. These devices will use value from
>>>> device_initialize(). And we have no possibility to change
>>>> dma_default_coherent value by disabling ARCH_DMA_DEFAULT_COHERENT.
>>>> Moreover, changing dma_default_coherent from false to true may cause
>>>> regression for other devices.
>>>
>>> How can there be a regression when dma has been coherent by default for
>>> the RISC-V kernel from day 1?
>>
>> Before ARCH_DMA_DEFAULT_COHERENT patch dma_default_coherent was used 
>> unassigned as "false" in device_initialize():
>> ..........
>> #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>>     defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
>>     dev->dma_coherent = dma_default_coherent;
>> #endif
>> ..........
>> And now it becomes "true". It may change behavior of other non-DT 
>> drivers.
> I don't see any problem here, default is default.
> Actually leaving those device with  dev->dma_coherent = false is risky, 
> because
> we can't guarantee underlying cache flush functions are here.
> 
> If a non-dt device do need to override it, it should be done in 
> arch_setup_dma_ops.

But arch_setup_dma_ops() is called only from of_dma_configure_id() and 
acpi_dma_configure_id(). So it works only for DT and ACPI devices. What 
about platform_device?

