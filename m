Return-Path: <linux-kernel+bounces-145589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4AC8A5827
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9028E287E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E2982482;
	Mon, 15 Apr 2024 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=elkcl.ru header.i=@elkcl.ru header.b="x1hNRCz5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=elkcl.ru header.i=@elkcl.ru header.b="RfNT7Hox"
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE7824AE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199860; cv=none; b=sRN0RGmoAvmGJurgM5cVj5g8lVgHsLc+LPM46w4RYbSyk16akUfDQtyZ8ezCuxIWOG1OiHgSR4GfJWfz/FEftk7j58kDKRuHWZRpRgiHk6xOI2PG010n0KfW/UIclPtztHd+KyXIo3NF4o3+qY8axmzTp+b4+n0oGSVHC82qEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199860; c=relaxed/simple;
	bh=DN8I7aYLAe1BKjklfvsZ+vgINtbE+zdFo5Fjro1Pf80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1IA2ijmx7iy2Wa74DvH3e9GVqWegLmUhiGpj1bdFrhvxW+dxVENesvkbyvR8Ye7Q/9T2fY3t/a790IJ8mrQkgglRMvvIMUELVxRTWHIm3sQuFxUlaadziZ6yidtyMyuy9dLdWzNnDd7eZMHXBm0AqHNmdFoN7U+5RyCRZ3b9Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elkcl.ru; spf=pass smtp.mailfrom=elkcl.ru; dkim=pass (1024-bit key) header.d=elkcl.ru header.i=@elkcl.ru header.b=x1hNRCz5; dkim=pass (1024-bit key) header.d=elkcl.ru header.i=@elkcl.ru header.b=RfNT7Hox; arc=none smtp.client-ip=79.137.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=elkcl.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elkcl.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=elkcl.ru; s=mailru;
	h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=fU4Jb+HjcUIRnkvmA6oZd00NQJEftaoLs9sEK5mizZM=;
	t=1713199858;x=1713289858; 
	b=x1hNRCz5X7bUtiUbK8/kbAB43bBBE64rtM375csfRVvCAXpAWrEDDDWFUlcHwK7Fz3Gd6zVbImdHjAWAgYnzMzugtqc8pUQh3vt42OxDdB52MzBN+6fYId+JKuVME6XD1dxSUd+tbRpx8WaGH0VIVl3Mh9K2s7JYetyDa+EvYb0=;
Received: from [10.12.4.17] (port=48894 helo=smtp46.i.mail.ru)
	by fallback21.i.mail.ru with esmtp (envelope-from <pub@elkcl.ru>)
	id 1rwPXd-006Ps2-6y
	for linux-kernel@vger.kernel.org; Mon, 15 Apr 2024 19:50:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=elkcl.ru;
	s=mailru; h=Sender:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:To
	:Cc:Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
	List-Archive:X-Cloud-Ids:Disposition-Notification-To;
	bh=fU4Jb+HjcUIRnkvmA6oZd00NQJEftaoLs9sEK5mizZM=; t=1713199849; x=1713289849; 
	b=RfNT7Hox7Skrm4QhyQOviSuMn0UlVvhX9RQhe1zS5RKWeYRf8nBQ+fKFWrOpDtTTHkKykEQngq0
	BiMjwyu92VSTV/yrdWwEiAHrJYdwOT2VzZ/fC0PcedRqSVfuDe+vxXHqvZDJVqTcUqZ1Ey30OMWYa
	dM4W8z0yMEbNAZvtiRs=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <pub@elkcl.ru>)
	id 1rwPXH-00000000gYc-2w35; Mon, 15 Apr 2024 19:50:28 +0300
Message-ID: <74f2b16a-dd48-4306-b28b-ad5ba77d8bfe@elkcl.ru>
Date: Mon, 15 Apr 2024 19:50:23 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] jffs2: prevent xattr node from overflowing the eraseblock
To: Christian Brauner <brauner@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Richard Weinberger
 <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>,
 Fabian Frederick <fabf@skynet.be>, Nick Desaulniers
 <ndesaulniers@google.com>, Wedson Almeida Filho <walmeida@microsoft.com>,
 KaiGai Kohei <kaigai@ak.jp.nec.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240412155357.237803-1-dev@elkcl.ru>
 <20240415-anspielen-gelyncht-d2f0efd6569e@brauner>
From: Ilya Denisyev <dev@elkcl.ru>
Content-Language: en-US
In-Reply-To: <20240415-anspielen-gelyncht-d2f0efd6569e@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: pub@elkcl.ru
X-Mailru-Src: smtp
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D327C87852EB66D31116567C8E3CFDFF0E1C6585A2586D0D182A05F538085040B179075AD4DF425F3DE06ABAFEAF6705DB7E7932B9893A00AA6517558154513EABAB3F2802300857
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70A10A23A3B64B805EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637B24541F05F0BFC9F8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8E0CA407E709CDC0B2168C34F444F38000FFCE30886D58649CC7F00164DA146DAFE8445B8C89999728AA50765F7900637D0FEED2715E18529389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8062BEEFFB5F8EA3EF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C17119E5299B287EE03F1AB874ED890284AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3F841116EA1ACDE45BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE788761406820A3098731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5CF9135D71564AE835002B1117B3ED6968B55D18063B74FD2FB820E9FE7BD014C823CB91A9FED034534781492E4B8EEAD2609375A3A81E2DDBDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742424CF958EAFF5D571004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34C1E32F4AD4B2486BFADDC33E07DB661C86FD219ECB6969EA373161ADC8ED28D39A2BF46180FC39FC1D7E09C32AA3244CE12BF5A6A205140D77DD89D51EBB7742D02FDEF4547DCF12EA455F16B58544A20C45C0626CB26EE85DA084F8E80FEBD339673C7991D68BBF964550E41902C4E4
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojOezlh5vAwsobvGokhiVzuQ==
X-Mailru-Sender: 7971DA0162A9842A75A8A63AE98D4FF4B1116962D713EEE2F7A6B01B8567BB205D9139C693FB2D64A3EAC56F6A374A44CA0B8C118E355A7C54A42CAEBACFBF7EF55A8A299F926F354FD7C49A7833DCB4162D03413E14ADD05FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4DB7CCFC93CF1872E1F5AB46BAD9C4C2824EE53346298E5F768F3CF0E9FE49B69B93F16B0BC5AAA4D3F0385E0E8F24350CE799FB3747367313663FF99FD3DECAF
X-7FA49CB5: 0D63561A33F958A5E064310A5C150CE13A2144CCB36E24738FE85C49224433F58941B15DA834481FA18204E546F3947C1DAA61796BF5227BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F790063770DAEE4257ABEBB3389733CBF5DBD5E9B5C8C57E37DE458BD96E472CDF7238E0725E5C173C3A84C37795E77BD711CB3535872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojOezlh5vAwsoE9piz475brg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

On 15.04.2024 17:28, Christian Brauner wrote:
> Can this overflow? I.e. can c->sector_size be smaller than c->cleanmarker_size?

I'm pretty sure that it can't. As far as I know, c->sector_size is at 
least the MTD eraseblock size[1] or even bigger in the case of 
DataFlash[2]. The cleanmarker is either the size of the smallest JFFS2 
node[3] (currently 12 bytes), 0 bytes for certain flash types (like 
NAND, where it's stored out of band[4]) or apparently at most the MTD 
writesize (which, as far as I understand, is not larger than the 
erasesize) for Intel Sibley[5].

Considering that any JFFS2 node must fit inside one block and that the 
cleanmarker is the smallest node there is (if it's even a proper node), 
it shouldn't overflow, otherwise JFFS2 won't work in the first place.


[1] https://elixir.bootlin.com/linux/v6.9-rc4/source/fs/jffs2/fs.c#L539

[2] https://elixir.bootlin.com/linux/v6.9-rc4/source/fs/jffs2/wbuf.c#L1253

[3] https://elixir.bootlin.com/linux/v6.9-rc4/source/fs/jffs2/fs.c#L557

[4] https://elixir.bootlin.com/linux/v6.9-rc4/source/fs/jffs2/wbuf.c#L1190

[5] https://elixir.bootlin.com/linux/v6.9-rc4/source/fs/jffs2/wbuf.c#L1296


---

Best regards,

Ilya


