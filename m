Return-Path: <linux-kernel+bounces-22798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644282A2FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 155A5B20E93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764854F21D;
	Wed, 10 Jan 2024 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0mXBE5nX"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4C4F1E7;
	Wed, 10 Jan 2024 21:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=di7m1jLz/5vQ02EHMgeqmF1nhJC17u16xhuut+uCxyo=; b=0mXBE5nXnZCwhjike7gAKQL0TI
	oaHvXQLxmDq77kj2uPTz2/AnCjBRJ9fctDW5jr2y5/XQjwnNHtvr6LrCwLLpiAJiUSpmap7Qm4OaZ
	0JqVXQyMrpAcEB8uYCg/oVAW6zhosWoWxj0I2L4/8botVWGlwQ7Xr2Pa2HarmslyIZFA0v0EH9n9z
	GBz5LtJc7/Q4+oSW5mKkAb6CY3MLQsNQi1M3RCjgvchNU0gXVXzp9lGA+3/9XLO6bgQSCa5LRYvbr
	D0RZRCqU2pnBFV+zYU56M6fRE6hFWljCZRYDo0Ijx4T+Hc0UbGNMMi+ObJnuRv4CKAP3+IBP2Zwdb
	Jp25zSpQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNfk3-00EAaX-1K;
	Wed, 10 Jan 2024 21:04:03 +0000
Message-ID: <9e3f8028-c799-43f2-9eca-492fbf8b1dee@infradead.org>
Date: Wed, 10 Jan 2024 13:04:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: fix max_segment_size malformed table
Content-Language: en-US
To: Sergei Shtylyov <sergei.shtylyov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20240110203558.2638-1-rdunlap@infradead.org>
 <9b22d817-c0d9-4e85-cda7-7843907a70a1@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <9b22d817-c0d9-4e85-cda7-7843907a70a1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/10/24 12:38, Sergei Shtylyov wrote:
> On 1/10/24 11:35 PM, Randy Dunlap wrote:
> 
>> Sphinx reports a malformed table due to the table begin/end line
>> segments being too short for the word "max_segment_size", so
>> extend them by one more '=' character to prevent to error.
> 
>    s/to error/the error/?

yes, thanks.

> 
>> Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
>> Text in column margin in table line 9.
>>
>> Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: linux-usb@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
> [...]
> 
> MBR, Sergey

-- 
#Randy

