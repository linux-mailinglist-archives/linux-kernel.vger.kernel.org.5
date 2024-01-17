Return-Path: <linux-kernel+bounces-29400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3C3830DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01821C2410E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741FE24B2B;
	Wed, 17 Jan 2024 20:10:14 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13282249F3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522214; cv=none; b=R1q3xW6nseuDwEnjqtFPonDpK+LHFbMg0uidffocAwyBQJ8XDiOrskcGKTmyPcKVddVIbgMDBFNbZTT6h2Im8e9hNE/rnAZzNXEW6tcSSy86znCtXkNbpGCLkLXy0/InCmv/+/AksnkELVJFKOn97Gx2A2Qmwky1efiEkvzKTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522214; c=relaxed/simple;
	bh=COqnYiI1YAA/1zFmAU2jaAcYfOtFl0AciS/9ZE4Y8SE=;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type; b=OQuwOAOtt3fwKxVb74zJkjosug4XA5V5Jpd6rciLBw0uOYwB0zFZkCx+OCKUSnPycHWOPmR07VowE7jalyPy8IzrmsCLkIf4gsHNsGlnnOfdaoTn+z5mRZq9/FD5HpQ0SnyY9DtYQBYVV94VpUJlepfxabCzdJZLYgWuCuHSNw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id 5A05640A8B; Wed, 17 Jan 2024 11:59:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 596B040A85;
	Wed, 17 Jan 2024 11:59:53 -0800 (PST)
Date: Wed, 17 Jan 2024 11:59:53 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Eric Mackay <eric.mackay@oracle.com>
cc: mark.rutland@arm.com, Jonathan.Cameron@huawei.com, Matteo.Carlini@arm.com, 
    Valentin.Schneider@arm.com, akpm@linux-foundation.org, 
    anshuman.khandual@arm.com, catalin.marinas@arm.com, 
    dave.kleikamp@oracle.com, linux-arm-kernel@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux@armlinux.org.uk, 
    robin.murphy@arm.com, vanshikonda@os.amperecomputing.com, 
    yang@os.amperecomputing.com
Subject: Re: [PATCH] ARM64: Dynamically allocate cpumasks and increase
 supported CPUs to 512
In-Reply-To: <20240116210633.116278-1-eric.mackay@oracle.com>
Message-ID: <47461daf-3aa5-493f-7278-b0116ee2c724@linux.com>
References: <ZaZ_xK5QHVPSD7N6@FVFF77S0Q05N> <20240116210633.116278-1-eric.mackay@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 16 Jan 2024, Eric Mackay wrote:

>
> It seems > 256 was chosen as the cutoff simply because it preserves existing behavior.
> The patch description seems to imply there was pushback from distro maintainers on just increasing
> the default NR_CPUS.

Yup that was it.


