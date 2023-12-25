Return-Path: <linux-kernel+bounces-10912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C61D81DEAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12DFD281623
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 06:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341A81097D;
	Mon, 25 Dec 2023 06:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="TpPhxfy3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="W0T7ZSeZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fallback2.i.mail.ru (fallback2.i.mail.ru [79.137.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C938710967
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 06:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inbox.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inbox.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=ZVQuOYmwEHuM5XKAZpHVSjLI7J3iBPBYdoi//aGKLWo=;
	t=1703486867;x=1703576867; 
	b=TpPhxfy3sd6XS+K3S1SxYTjRjj5zc0H/QqVy2xJCNaTnR02wAwvKgAuFtQfDklOJI10G6KnxeLmq5ZvWMDCDwTc+/VAm17cytL5bR+N9beGh6UVOrl8774Fo4UGfzGtwD7wVG66CXT13fgKyQrzPiZsAPaxav6N3GI7flwol5VivBUTxthf6UJNwcj4RLAV/JhGiTCQ/W/CdtuUtffihoKx9u2nWv108O/veGMyuIqdePa9AIgE/C/9KEzc1Wj+TVX6nWvmi5ZBFOo39FHClSknKIbt1qkB8YojWgrXZjwAsUm1sVt+Ow9L5QUkR1UoqRdEt5fsQtYrGcdwdx2sWfA==;
Received: from [10.12.4.36] (port=58252 helo=smtp59.i.mail.ru)
	by fallback2.i.mail.ru with esmtp (envelope-from <fido_max@inbox.ru>)
	id 1rHekV-00BsYm-43
	for linux-kernel@vger.kernel.org; Mon, 25 Dec 2023 09:47:39 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru;
	s=mail4; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References
	:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To:Cc:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=ZVQuOYmwEHuM5XKAZpHVSjLI7J3iBPBYdoi//aGKLWo=; t=1703486859; x=1703576859; 
	b=W0T7ZSeZAId/R8Xc/oxGrhmrqQUhIQF9Ap59CIpyHJfb7eO6G2iIs60RJtfPQ79unGZIzkEs3MG
	7qOo7Et794PmGgKx1FqjU9pJowIKMRP2U4RLp+/wLiIYStzGnUhGMP1NIwR/Kh5Zz/t+GS9geAAdv
	HsPYyc5hmOKR++Tx7yLYlkOYw6PcMOQYu4DVrS6T5nRflF3sz7DzQaO7RdwiY+bRJ2Jsf2yFM+AGo
	RlYgwhmmYnGKQ3LfNVbOrJ9xSNZqNbb7byqyPV+iyK2iRIVXqw6jf/AanGby8C3qe42KIE6vYdslo
	w/08NcErteLfxnuNx9E4/RT0UAk8v7vpSvPw==;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
	id 1rHekE-009eYu-2z; Mon, 25 Dec 2023 09:47:23 +0300
Message-ID: <15b89089-3dcd-4668-8d8b-d12ff0684c29@inbox.ru>
Date: Mon, 25 Dec 2023 09:47:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: set ARCH_DMA_DEFAULT_COHERENT if
 RISCV_DMA_NONCOHERENT is not set
To: Christoph Hellwig <hch@lst.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
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
 <6fe34090-656d-491f-8173-217d20144166@inbox.ru>
 <a25d3736-f6ca-478d-8e58-69a7c0e529f7@flygoat.com>
 <20231223045912.GA21836@lst.de>
Content-Language: en-US
From: Maxim Kochetkov <fido_max@inbox.ru>
In-Reply-To: <20231223045912.GA21836@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9F008C97756F746CA9853402441EE20032119B858DB59C778182A05F538085040986FCBB8A925D5F475F0417F076C73185FB4EA8E402442D05768CE8C622266E2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE758E3775C3D7FDEE4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371D5B197C6EC5B4BE8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83AD0BF8CF0170FB76696B6922158C4156F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE722C7672CDBCC22789FA2833FD35BB23D9E625A9149C048EE1E561CDFBCA1751F6FD1C55BDD38FC3FD2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BECADA55FE5B58BB7A471835C12D1D977C4224003CC8364762BB6847A3DEAEFB0F43C7A68FF6260569E8FC8737B5C22494854413538E1713FE827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B613439FA09F3DCB32089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5A3C9806DACBCE033377567E5205B5A14023B1F181720444CF87CCE6106E1FC07E67D4AC08A07B9B064E7220B7C550592CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D349DAEDEF7DE8FDCFA67386229D68C71107CF6FECE50B47508A932DE05DA03714EE46E6BE8F284D2A41D7E09C32AA3244C150DE34F8A10177BC229AC083F2D827B8580396430872480AFF760E3CF2A505DB6C6411D86935C892AB2189BCAD71E73D640157F23F2FFE137E69C174A41D00C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojY17BwQnFUO9L+9ndg73XQQ==
X-Mailru-Sender: 689FA8AB762F7393590D8C940224AE3318CD48E73CD6507B274A3ACFCC61BC0F98CC072019C18A892CA7F8C7C9492E1F2F5E575105D0B01ADBE2EF17B331888EEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B46003E5D5A82ECDADC2F54683050715117C7E3A1CC045E01D049FFFDB7839CE9E7BC894BEB2453085CB38E92D8A66F72B8D3FCE4EDF381707843080BEDAD65BA5
X-7FA49CB5: 0D63561A33F958A5AE5ECAC58986C297D42C622E6F1CE65447305EDF7B1C5D6CCACD7DF95DA8FC8BD5E8D9A59859A8B64071617579528AACCC7F00164DA146DAFE8445B8C89999728AA50765F79006370A2DD59B67EFEE27389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8D56D36E97F3F038CF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE7EE061C4D93700B7A731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojY17BwQnFUO/HmosOzidvyQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok



On 23.12.2023 07:59, Christoph Hellwig wrote:
> On Fri, Dec 22, 2023 at 04:01:43PM +0000, Jiaxun Yang wrote:
>>>
>>> But arch_setup_dma_ops() is called only from of_dma_configure_id() and
>>> acpi_dma_configure_id(). So it works only for DT and ACPI devices. What
>>> about platform_device?
>>
>> Ah I see, that's the problem, in MIPS's use case all DMA capable devices
>> are following platform's default coherency. For RISC-V we assume all device
>> are enabled by ACPI or DT.
>>
>> Perhaps you can override it in driver, but that will make drivers platform
>> dependent.
>>
>> I'll leave this question to Christoph.
> 
> I've already said it.  You must not have DMA capable devices that aren't
> declared in ACPI or OF, just like on any modern Linux platform.

Ok. I've got the point. Thank you for clarification.

> 
> What devices are you concerned about anyway Maxim?

I have 3rd party external out of tree camera driver. csi, isp, dewarp 
components are OF, but common media device is created as 
platform_device. I will convert is to OF.



