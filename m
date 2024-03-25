Return-Path: <linux-kernel+bounces-117954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F8888B1C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9974632348A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E342959B52;
	Mon, 25 Mar 2024 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bvwN+wT9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wqgZ83aW"
Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC564524B4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399268; cv=none; b=g62tJGDZJsQ3I9jrsUUmP58Lp25mrthTvjOzhv7NLoAZ1CNzWAHbAj/UW4NlHk1iFvUQ0IOTZXDy0pWOVfix92pXtTJyBj/dtVYyvbFr8l3cqJXSpKgFB8mQ8z3HH91MYCNov52Uq7/EHAMDOjsSdjIlZW5+hXnF/l1G3+Ppz3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399268; c=relaxed/simple;
	bh=TISnD2Sz6h06YodRH0dcBihqS+tmwi7dCNb4AfyBevs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=VzU0goYK3XonQPHD//w/gNK18kZDGbUpkanNgy6hqy9i4ZQyV1a1AW0GQ3Z04DY43FPEa90wAUYenRrAWgyGYUrA/4aRw0xn584OmmNTBt7Xd5Jcwz022vzqclVuHJVgpBFJ6AO29i1FacJ7Y8+LjdpGP+Y4YM+A82rDleI7oQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bvwN+wT9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wqgZ83aW; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 97DA51C000D0;
	Mon, 25 Mar 2024 16:41:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 16:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711399262; x=1711485662; bh=lC0QogFDJs
	dPPHPVxEtk7oE0Tzlwl0ZdsUXHw0ePYwM=; b=bvwN+wT98TadP1KmewjIVddLCI
	iUNQb5KjKmtYbcUmymAdSGVXcrq0cnuImEWElkUv8aQiFjIaqbruybE15UCMyyug
	9GwAxVztn5vvIWoFl4hcyJ72HxzwEfJif16dMv+UdUpcAHn2Sl823mcNzFnPLCqb
	W6pBXwWCwmhBnhdtvou8R8IkHvT7aLLuCOXYMJKpMfe0T7hPQrzYK2TaKsFk/OVm
	IPkwrdhgrMBn+urySP2jZ694YjgOMBqcC8zf2zU46M2eLTnYnsPuL+3dLepsBNwR
	7p0ecAvjpu8l+3nD4bMcMJ9CAlHAj638U2nyx249rWSFiyfG+xCKtj/e5pfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711399262; x=1711485662; bh=lC0QogFDJsdPPHPVxEtk7oE0Tzlw
	l0ZdsUXHw0ePYwM=; b=wqgZ83aWPxyDI+wzSX9U0KrHrNq97/i29O1o9sx1Jful
	1WwnQDRqrmejTxMpPI/nBoKTimsqS0+Ylkzr0OWPOmM+kr4XSFmZzsBYYzB0wlYP
	gjyRYxnNTSwE5rmegRcU2ECy0PE7fSDdX4HIFckt1HtNR+EiH6B9AfBnkxb+NOGX
	8bPfYyBKC4ZcfzpuGBx2QWNzEo+THzMlGdiIGKztniiPqf1SzJkU63+6lLtMjPSd
	P0ed2ok+4DLA34Dl9jhf5MDPd+MIIGxih8KNmkyaUaxFrlPORy6FyaPyXTOAZe6q
	8fV9ewX2gIfPQ8Hy2kNKNj1kfVaiewsio75arZVSEg==
X-ME-Sender: <xms:XeEBZuk0FbuOuEgUxW_YjyrU17uFvKErVp89hBe9sRc8mRHIftPqZg>
    <xme:XeEBZl35UtIqfkL5SAKWoIBR11qY1LWkz9aU8UAQJo6bS33vbpmr-occllOXI9mLF
    PSfgcEDOd-Q2Mvf7u8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduuddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:XeEBZsoSepjqWDjtz1VlgKWds71Vt3tlS0onZRRpXpPZBFIhF19-GA>
    <xmx:XeEBZino9lvW5VrJOZzEQyZEfd8iDoLaNvzUTctG34SQnUHyQX0a7A>
    <xmx:XeEBZs1zxcx6zOlPx0-u3KV5mix1Ez459hBbfTik2wGebf1NYFzmcw>
    <xmx:XeEBZpsY_52Jij5-YJBOXi3MLHhw-hwI9xdVFdyWi930Koi2Fisrtw>
    <xmx:XuEBZlFUpfLIDx9JBCRRg_11ANdKVJO8vHi9OXf1t_wwjjV4Tl9aGTtsH9A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8D90DB6008D; Mon, 25 Mar 2024 16:41:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3ac65601-7102-4ad1-ad89-157f7d9cef87@app.fastmail.com>
In-Reply-To: <20240313180010.295747-1-samuel.holland@sifive.com>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
Date: Mon, 25 Mar 2024 21:40:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Samuel Holland" <samuel.holland@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Charlie Jenkins" <charlie@rivosinc.com>, guoren <guoren@kernel.org>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Kemeng Shi" <shikemeng@huaweicloud.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>, "Yangyu Chen" <cyy@cyyself.name>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Type: text/plain

On Wed, Mar 13, 2024, at 18:59, Samuel Holland wrote:
> TASK_SIZE_MAX should be set to the largest userspace address under any
> runtime configuration. This optimizes the check in __access_ok(), which
> no longer needs to compute the current value of TASK_SIZE. It is still
> safe because addresses between TASK_SIZE and TASK_SIZE_MAX are invalid
> at the hardware level.
>
> This removes about half of the references to pgtable_l[45]_enabled.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
>  #define TASK_SIZE_MIN	(PGDIR_SIZE_L3 * PTRS_PER_PGD / 2)
> +#define TASK_SIZE_MAX	(PGDIR_SIZE_L5 * PTRS_PER_PGD / 2)

I see that TASK_SIZE_MIN is unused since 085e2ff9aeb0 ("efi:
libstub: Drop randomization of runtime memory map") and could
be dropped now, but it doesn't really hurt either.

     Arnd

