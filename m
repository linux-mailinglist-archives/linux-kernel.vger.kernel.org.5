Return-Path: <linux-kernel+bounces-99766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1CC878CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3611CB218A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA0E6FB6;
	Tue, 12 Mar 2024 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRB0eJ3X"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1278811;
	Tue, 12 Mar 2024 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710210261; cv=none; b=GJJt1RXGbv6SNXBNlb5/6HIpib2y9Q6dxvuOEzLESD/9f1y9YvsBwFcAMjrQVAjlkVoXeGB7DHMMhT+AKBvekBA3KAPx0/zleOLC+PGIJW1A7/LXfaoktuHZUMJnF+JIwxAm3eJm5CMGoLgktXd10aVtM5qWHc85IuQjcD6mkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710210261; c=relaxed/simple;
	bh=fG56aufdfltkZYeNBOEgH9TwSlq3RcV6Utjd56I7WFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTEmiBcd+Q/grsh4iZv9SfJP2TRLUZMzoID3M4oYLXQ4CavNjm9vXwbH5t6lzCiGwCse5tUGlxKJgQG8Dh0X7zrRqJNYjPIvNkCmXhvO3pDTLZcodFVuX5LPxf5Wq5ZTUbnCR5Hsb7H7K2cOkX+uhoH9RGDtcde5HiCugMRNajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nRB0eJ3X; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9SbrPiGCdQrCt1N5ALQH0ssl1pc2Fp8ln+P1Az4BYwg=; b=nRB0eJ3XHAXgng9YKgOiAiJOkM
	rS9b+rDCpbQRp67REvX239+NvvQEykGjZeuFuYRSRmq2j6ancaHvad0xHtbI64xxWQ3uS+pk/9lIe
	vr7Z2RY8bXHkTbJFTz5NBzUO+t3a32gJW6o7+1RwR+qhh5RzS5Ed8UZ4SMo9AoMEOKRLb3e6iiGQ/
	NAvC+u6liyvX+KpK0ELcSuqjN1lYrpzIwMlpNJyQUaL4+hASVeeBBTlKfX/s0ZeOTBVRrtmJg5ZCn
	phzrMhLW4kjtGyVyoOzWckH6oxSuJDfvUvIZmVyPwrmXOtWYVfPs4PqyVXLQ/p/sbnX/XCXH3z2+m
	rDGf8VQQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjroP-00000003zcl-2wJh;
	Tue, 12 Mar 2024 02:24:17 +0000
Message-ID: <a4bdcf74-5c6f-4483-a4f0-8ad6558a3c8d@infradead.org>
Date: Mon, 11 Mar 2024 19:24:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] EDAC updates for v6.9
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Borislav Petkov <bp@alien8.de>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
 linux-edac <linux-edac@vger.kernel.org>
References: <20240311155651.GAZe8pw0urOnUZj1y_@fat_crate.local>
 <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHk-=whTBKoHrBpMxh7OHQ=pcdy6K2zqqsJOZeCC4xSqRXb5Bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/24 18:12, Linus Torvalds wrote:
> On Mon, 11 Mar 2024 at 08:57, Borislav Petkov <bp@alien8.de> wrote:
>>
>> -       return topology_die_id(err->cpu) % amd_get_nodes_per_socket();
>> +       return topology_amd_node_id(err->cpu) % topology_amd_nodes_per_pkg();
> 
> Ho humm. Lookie here:
> 
>     static inline unsigned int topology_amd_nodes_per_pkg(void)
>     { return 0; };
> 

and there's an extra/trailing ';'.

> that's the UP case.
> 
> Yeah, I'm assuming nobody tests this for UP, but it's clearly wrong to
> potentially do that modulus by zero.
> 
> So I made the merge also change that UP case of
> topology_amd_nodes_per_pkg() to return 1.
> 
> Because dammit, not only is a mod-by-zero wrong, a UP system most
> definitely has one node per package, not zero.
> 
>                Linus
> 

-- 
#Randy

