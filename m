Return-Path: <linux-kernel+bounces-128095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0789560C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B3A1C2295F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6346385C7F;
	Tue,  2 Apr 2024 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="uwHSo1tf"
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B273E82893
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066546; cv=none; b=iiXrxkJr7ncOFghyoazX15/uA3mahfBPgguBC9wsTT9cwnxJyBVSj6KpSdwpXOzSjolWdHb7IvxygSZ9iqq4K/ItQ/y3udR20C9i7Oho+wjCC0Q1WdHT+veGszOQF7UAw+tzSOhrs+h14w3yqT0vVnLL5WCyMew22A+3UsD3FE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066546; c=relaxed/simple;
	bh=+KeKKu8j5PtDlcTYULHI2jYuASxxmJesbzSHT/V5rDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRWwxbBBx4jFrXqyNWmelcmVC6vhiw+4t6vWPJlnOj65b3BBzSOFVKmyQTTYGVlNDlYV6sjNwCLMCJ/ONv07Q17IWeecAkJUh/alQFqEGafPoYZ2Vc5H1tpgk1c81ye7joxsfzYBSQvE+nd+QDjQZ7ODJJko9IOF3zI/RvcDrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=uwHSo1tf; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <c5354ac2-5714-42ce-bf2f-9d022ddd2945@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1712066534;
	bh=+KeKKu8j5PtDlcTYULHI2jYuASxxmJesbzSHT/V5rDI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=uwHSo1tfz2wKMcCsEBf9bEAqr84kDSQ4hG6VxetzuNCQxCaRlZgUmTLH7lEiU8nPw
	 8rZ4gXr2y21VmkbxeAFdUbauLTt8MHFwqAqGVmpY9klkR8Sz3drGHT6Xzg9i9k0yag
	 5aDtHYeWQJY3rWD7enRekLfJNaBAyrbWWDLkBIA4=
Date: Tue, 2 Apr 2024 16:02:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Revert commit 27f58c04a8f438078583041468ec60597841284d]
 [linux-next] [6.9.0-rc1-next-20240328] WARNING: CPU: 9 PID: 209 at
 drivers/scsi/sg.c:2236 sg_remove_sfp_usercontext+0x270/0x280 [sg]
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, bvanassche@acm.org,
 martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: sfr@canb.auug.org.au, sachinp@linux.vnet.com, mpe@ellerman.id.au,
 abdhalee@linux.vnet.ibm.com, mputtash@linux.vnet.com
References: <62efbf21-fdb5-4c3b-a370-085b39672b72@linux.vnet.ibm.com>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <62efbf21-fdb5-4c3b-a370-085b39672b72@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.04.24 15:51, Venkat Rao Bagalkote wrote:
> Greetings!!
> 
> 
> Below warnings is observed with the commit 
> 27f58c04a8f438078583041468ec60597841284d.
> 
> 
> Once reverting the above commit id, issue is resloved.
> 
> 
> Please help in fixing this issue.

The fix for that is currently in review:
https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/

Sorry for that,

Alexander

