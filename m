Return-Path: <linux-kernel+bounces-163121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C168B65FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46E8283235
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038143B7A0;
	Mon, 29 Apr 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QF9tFeQI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6103F1E886;
	Mon, 29 Apr 2024 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714431696; cv=none; b=gVR3/rO39JC4cMWGTKKdN9wKw8GwWXUh9NS+a+wBjV8RrE9z0ZRlW2vWlaZWdVfYQw+dYXRsSr5DKby/k03KZK/wlc32F1lPI6zqxJgXmSkwvfxTKM47tjfbgb1wzjfOAQ0pl1924MOKlNBpEvoISOlQ0skaqxZVSDlj4rjqSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714431696; c=relaxed/simple;
	bh=nsjxaFuxMzUZpme5wqvDJk29ZIf8QmaTt4cx1sRWges=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9w9XynwWOIeXiGpp4PqAUpwBdE6RNS9ONdorPOzP2Sa7U2JPoV+eDmY+0aik9Y8CVuKN00xBCa/abZlpm7K43E06rGIUEz8hrmqL1JabsN1cT78QHvD10f8nhxwVZBkwO6s6+r388honA5p+vm3Mwb1JKc9f5c0LfyN243kizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QF9tFeQI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VjGI2wMBLLQcSw1TgdTzwgQ4UqWyJhAoo5rH7mq4GL0=; b=QF9tFeQIrSxMoG9JchVudwXdaB
	CL14F0Kf/litjiMo406FTYvhM2IaffhJBBMhzSpWQfYT1MmmYNPQMHA0TNxoqsrKWtxaIg4rskd6n
	JUfXbrEVCEOhjo7XU3yEvLrgN2PrzemKsbTawatxSqQqhK2wajOcjif08UwcQmpp0tqfI8bgRrpz4
	uyKS6oSm8UPak1qTKkUGf/+porKJp20ucXuKgy/4o2bbT9LvQ+kiQvyw72/iV/uSelIBlWFeau2O7
	Yb077pOUKm3udLX97UTWUDT1Qs9OlWnuKJJ0PlKlfnBmCRPc+YG+HwUIIlEST+XVs4z/FTASSJxaT
	WPs1xQ4A==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1a03-00000004QP1-37eM;
	Mon, 29 Apr 2024 23:01:31 +0000
Message-ID: <fe76279f-b0d5-486f-9a4e-7bf9d1fca37c@infradead.org>
Date: Mon, 29 Apr 2024 16:01:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Docs: typos/spelling
To: Remington Brasga <rbrasga@uci.edu>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240429225527.2329-1-rbrasga@uci.edu>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240429225527.2329-1-rbrasga@uci.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/24 3:55 PM, Remington Brasga wrote:
> Fix spelling and grammar in Docs descriptions
> 
> Signed-off-by: Remington Brasga <rbrasga@uci.edu>
> ---
>  Documentation/admin-guide/hw-vuln/srso.rst                    | 2 +-
>  Documentation/admin-guide/kernel-parameters.txt               | 2 +-
>  Documentation/admin-guide/mm/ksm.rst                          | 2 +-
>  Documentation/arch/m68k/buddha-driver.rst                     | 2 +-
>  Documentation/arch/sparc/oradax/dax-hv-api.txt                | 2 +-
>  Documentation/arch/x86/xstate.rst                             | 2 +-
>  Documentation/core-api/entry.rst                              | 2 +-
>  Documentation/driver-api/mtd/nand_ecc.rst                     | 2 +-
>  Documentation/driver-api/scsi.rst                             | 2 +-
>  Documentation/driver-api/usb/usb.rst                          | 2 +-
>  Documentation/driver-api/wbrf.rst                             | 2 +-
>  Documentation/filesystems/directory-locking.rst               | 4 ++--
>  Documentation/filesystems/porting.rst                         | 4 ++--
>  Documentation/mm/slub.rst                                     | 2 +-
>  Documentation/security/SCTP.rst                               | 2 +-
>  Documentation/translations/zh_TW/process/submit-checklist.rst | 2 +-
>  16 files changed, 18 insertions(+), 18 deletions(-)
> 

Looks good. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

