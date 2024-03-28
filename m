Return-Path: <linux-kernel+bounces-123761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25857890D6E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA420B2389A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA813DDDA;
	Thu, 28 Mar 2024 22:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NbJm49eL"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C87E13B795;
	Thu, 28 Mar 2024 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663875; cv=none; b=gYDnPeRwWDAiw010+aaNRme+hUw9d48G4cccWYVNA0UN2lk8KNw/J606svMds958LXcCelqUTE0TID9y/T53FrllDTumrisQFY2YjRFl1iNUNK7nkdtDTFGxzHjNe6Vqdwbgj+q9kUQNyouB+1wUYuyvBXLZzuJFU3m+B+u4pQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663875; c=relaxed/simple;
	bh=JVuXWZU7ypGWL4ciDE6dFgx2siJQMrXVakqC0WXbnd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjeDCmuy1zQEgYuBc0cmLt/E+KI2gpzycBQwmosnnTAi1GhqDTKRxyMBaBVgIdj5LgyPaMP4UK4C2itEHA0ipl6v8GxdaIBpg23DCtvsyP8WeEGWkGgoV7m+6ziOAZVXgdApHJGz+vp7swO6jKbWcA/5IzPtklv4RE9Ral8R39o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NbJm49eL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=HnoWopqeEhgUSDrAxtnUhuDZR8QdjUiaKbpLIYgV22M=; b=NbJm49eLsaBJIDmaaGUPIwTP6s
	RdCdHdp9gJrWgLOyWIaGiU2iEa3h0mDLeFNu8MpWBCcjIt+F1mBI8g082Y+IpFySLM/hEsNJi6SK1
	JBk39TG18J9OCNVQporM5qOQ71kG0TDUjkZcnc4dAvsUfuM70hJvQAllMyhnggYK0MKVKGnTD8s/J
	pwz0gob9RjN5DyrV1KCIE79TcNpQT0Fn18OWvlWWNJjye4FkmJFqE0E/qDklUsVta8jWE3bO374Mz
	wFZ7SPWQCxzZ1K0xUYogPf2vhybumDglajK78Iq4x/BmSLLRdWq0eNniSqEvN8UThtFfomA7d21P3
	PMZSsxhQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxxf-0000000Fs9X-3pVK;
	Thu, 28 Mar 2024 22:11:04 +0000
Message-ID: <cde3dc6e-ca77-445e-a4b7-fc21a934999a@infradead.org>
Date: Thu, 28 Mar 2024 15:11:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/20] security: add ipe lsm
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, Fan Wu <wufan@linux.microsoft.com>,
 corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
 tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com,
 snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Deven Bowers <deven.desai@linux.microsoft.com>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <1711657047-10526-2-git-send-email-wufan@linux.microsoft.com>
 <D05ODONHFJ9O.3VG0HLFPA1OB0@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <D05ODONHFJ9O.3VG0HLFPA1OB0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/28/24 13:45, Jarkko Sakkinen wrote:
>> +/**
>> + * ipe_init - Entry point of IPE.
>> + *
>> + * This is called at LSM init, which happens occurs early during kernel
>> + * start up. During this phase, IPE registers its hooks and loads the
>> + * builtin boot policy.
>> + * Return:
>> + * * 0		- OK
>> + * * -ENOMEM	- Out of memory
> Just a suggestion:
> 
> * 0:		OK
> * -ENOMEM:	Out of memory (OOM)
> 
> Rationale being more readable (less convoluted).
> 
> And also sort of symmetrical how parameters are formatted in kdoc.

It needs the " * *" to make a formatted list in the generated output.
Otherwise the use of '- or ':' as a separator doesn't matter AFAIK.

-- 
#Randy

