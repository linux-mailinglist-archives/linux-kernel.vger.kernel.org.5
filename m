Return-Path: <linux-kernel+bounces-161678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE648B4F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897B51C20B63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24EEC3;
	Mon, 29 Apr 2024 02:12:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D237EB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 02:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714356741; cv=none; b=G3WG+ro+dxuZh3V+AjVVbbatj5yYn1T1J7tP0gK52KnRKuBTQ8LIsX6uHM4xp4pZhn+pmVDOrX7vmEAt/Tc2Hy3OBh4a26sRdkigLBIvvh8GLVxZ+wdXnUSEqSR62WDNILaDazP92lDO/LiTzW2sHR6ByVd/J0k0EJp3MfSMSF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714356741; c=relaxed/simple;
	bh=TjzGRrlLJm+93DR1oj1ImEevOHZ4wp09edRjCQW9RBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hrazjq8rv2nVdyTQ0LTuQG+bIgI00vpYIS9DHN4+k5Rz0oPAhtN7nFvU2+mpxha0iKC6XPOPA9TwvzSkuWtsXnu2PZmDaFq055W7vTbNE6cQEEmiGDiKkycMKTZ9uhYYuSdA6brAjxXqPcf09FK0CDrgeIpY+4i7W32i463+Spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85EE22F4;
	Sun, 28 Apr 2024 19:04:37 -0700 (PDT)
Received: from [10.162.42.72] (a077893.blr.arm.com [10.162.42.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C04213F73F;
	Sun, 28 Apr 2024 19:04:08 -0700 (PDT)
Message-ID: <7abe77fa-e9bb-4f50-86a8-5bae530bf068@arm.com>
Date: Mon, 29 Apr 2024 07:34:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/sysreg: Update ID_AA64MMFR2_EL1 register
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org
References: <20240419021325.2880384-1-anshuman.khandual@arm.com>
 <20240419134623.GE3148@willie-the-truck>
 <49365864-0080-4ddd-b0cb-eef41c88b6a9@arm.com>
 <20240422171613.GC6223@willie-the-truck>
 <ZidEalY_V3bXhJrJ@finisterre.sirena.org.uk>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZidEalY_V3bXhJrJ@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/24 10:47, Mark Brown wrote:
> On Mon, Apr 22, 2024 at 06:16:13PM +0100, Will Deacon wrote:
>> On Mon, Apr 22, 2024 at 08:38:40AM +0530, Anshuman Khandual wrote:
> 
>>> This is not being used currently but will be required for upcoming
>>> features. I was under the impression that register fields (atleast
>>> for the ID registers) should be kept updated, with latest released
>>> spec ? Besides lately arch/arm64/tools/sysreg serves as very good
>>> reference for all necessary register fields.
> 
>> Why? The linux headers aren't documenting the architecture.
> 
> I don't know that it's something that we should be doing apropos of
> nothing but if people have done updates and they're not unreasonbly
> complicated to review it does seem useful to integrate them to avoid
> duplicated work.  There have been some issues with that around the ID
> registers (which are going to be on the places most prone to this I
> guess).

The other problem is by not updating the individual register fields with
the latest spec, it also gives an wrong impression about that field, and
also might create confusion.

