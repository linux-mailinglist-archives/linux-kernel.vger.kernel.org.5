Return-Path: <linux-kernel+bounces-24149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BF782B842
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3997A1C23FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CD35A0E4;
	Thu, 11 Jan 2024 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jX0aVYdQ"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB759B78;
	Thu, 11 Jan 2024 23:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=B1U+5UGfJnuJ9P3O3vWLOZDpxmlwPgtOLJCzUkhAXME=; b=jX0aVYdQQab25OPkHP26huQAbZ
	OC7BU3TpQ9VYOKkZFBEhucTVOMKYAaQ5Vz86GmaJPSOYCYpmoPhuWIGat5uZrZxx2a14UF7lUdyNL
	vrBGjjTC9xJkaGfAeKfHnV7tB6/hmzyIk8YwwA1Fk4ekZ0x5POA7A/ApAj/zYZZHR26UoD5NroPNB
	ju3UVk8bcGDUpxl6965CFWHKgvSqMBzxQgV+wnffGjwmb5jYJMPvlyVC5ngCZl5l44uq/RAOIBh7l
	MqiuBSYiFhaNmWZft/0TwoL8WNuEX0OKOkxOEWsH+oIPPx43bBSeVeR2+Q4RCRlXNLDTwVeSFfw2e
	AsTyRycg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rO4py-001UOI-1i;
	Thu, 11 Jan 2024 23:51:50 +0000
Message-ID: <74388269-0a03-4c10-8408-fc204c843fd7@infradead.org>
Date: Thu, 11 Jan 2024 15:51:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 11 (mm/vmalloc.c)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, urezki@gmail.com,
 Andrew Morton <akpm@linux-foundation.org>
References: <20240111144846.74e443a7@canb.auug.org.au>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240111144846.74e443a7@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/24 19:48, Stephen Rothwell wrote:
> Hi all,
> 
> News: the merge window has opened, so please do not add any material
> intended for v6.9 to your linux-next included branches until asfter
> v6.8-rc1 has been released.
> 
> Changes since 20240110:
> 

on riscv 64-bit, i386, and UML:

./mm/vmalloc.c: In function 'vmalloc_dump_obj':
./mm/vmalloc.c:4691:22: warning: 'addr' is used uninitialized [-Wuninitialized]
 4691 |                 va = __find_vmap_area(addr, &vn->busy.root);
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./mm/vmalloc.c:4684:23: note: 'addr' was declared here
 4684 |         unsigned long addr;
      |                       ^~~~


-- 
#Randy

