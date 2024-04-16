Return-Path: <linux-kernel+bounces-147364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E30568A72F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F281F21A43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C05134429;
	Tue, 16 Apr 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y0DnyJjw"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17910A14
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713291581; cv=none; b=m7PIm9upfcvglrQ5r1DVZB8kBkzrDXG8dVjiKg2ARgXLX8fyS8gvS5uBid/90V+luBPtO6qVRKoC4R6XyPembTntYqviGj9TDRHvcD+1IinEdoJ0vOYJPh1HKpoyhfZJn9HwNgkjgO8xke+ccDOXMw7e8M/2ye+4FyitXKPMlMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713291581; c=relaxed/simple;
	bh=pdMYA1qgMqeg2Z30/WKPlgmKP3HdGpBWUAWiuurb0jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jah4C/GNwuTQzErvRISQkD728GUFiAU6uw44vkfE4OSNOdlWWM66B+iLImjTST5rnHvhnM0hrXxsCJQa9rivhJoQSZgaSkkqtTwC2PTqdrKbl6i5tk170XVeLz27J3UwJwG3J4vsb2NReEVfV+EnhKH3MBQy7tYsrYAd3ql0yfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Y0DnyJjw; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4640:7285:c2ff:fefb:fd4] ([IPv6:2601:646:8002:4640:7285:c2ff:fefb:fd4])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43GIJFtJ3341088
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 16 Apr 2024 11:19:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43GIJFtJ3341088
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1713291556;
	bh=VUhXyDSmrVQnu2Omvf8ZUtwCfdQo/hg/0UaaoVCYfig=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y0DnyJjw2G6xRVTnkpZRLtb/zcajHg63c43CmRX0fiqZswz8Gc2p4HAb2igCrBI++
	 sYkCBCor1OyGTobzUqW+klgBikSXyL071fvsbYsV8uAc7ZsvkWhIMSt3y23FFJ8MvW
	 v0NBV2CakiHh0GL+8inJWTcE56RrKv67UiYYAS9Whmvbk56Du1YO77eF7Ebr3T6USv
	 4j87c26mS+UFNhUG+cpvKFbKdxJwkHS0b393bdBzKcjQ8/4hKp6cEs3XaSQl+/pbvm
	 m3oTppqecqMZK5TogHpwcRulCnGfTUZLLwxOh02OrYfa8IrxQg7WMp9iYijIaa53Hg
	 NKJYUFlVWtz5A==
Message-ID: <deeeb592-fc64-4a82-bcee-15f293c078bf@zytor.com>
Date: Tue, 16 Apr 2024 11:19:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] x86/fred: Fix int80 emulation for FRED
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org
References: <20240412234058.1106744-1-xin@zytor.com>
 <20240416101147.GDZh5O473e4X_ZG1lZ@fat_crate.local>
 <1AE9FA53-A130-4F95-8408-C1990DD031AA@zytor.com>
 <20240416180746.GFZh6-cmZqCF6KX5tt@fat_crate.local>
 <e3fbd500-f6b8-49ea-addb-bbc4803709ce@zytor.com>
 <20240416181807.GGZh7A30Gtnixbs3M5@fat_crate.local>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20240416181807.GGZh7A30Gtnixbs3M5@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/24 11:18, Borislav Petkov wrote:
> On Tue, Apr 16, 2024 at 11:11:44AM -0700, H. Peter Anvin wrote:
>> Yes. My fault, I gave Xin incorrect information w.r.t. Fixes: tags.
> 
> No worries, I'll fix that up before applying.

Let me submit my comments (about comments) first :)

	-hpa


