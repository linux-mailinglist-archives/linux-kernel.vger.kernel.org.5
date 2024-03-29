Return-Path: <linux-kernel+bounces-125292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E689239A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF332285F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7BA4AEDA;
	Fri, 29 Mar 2024 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cm/ZnJ42"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305F3B293
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 18:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738387; cv=none; b=el9sYXpQubtcCt/6G5RjEANV32izNmrxkJRfxKtdKk+vOu1V+3yw0RGB8XXVbW+4vw+itORNAwVM1oyBRbkJawMxXy3J0exedSmCv6ttl+lxuIRL6vr0dja/EGsdbgOrwofdLnFM++q6IPZMw36FPa1985v8IVVUOsRm9sYey0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738387; c=relaxed/simple;
	bh=FTeT8ULC1ExZMKUm41jU3/hSaj3inVSYADFFINc3td0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rkASTG+E0HVY+L9yqKKUzzdJPTu1miJ+n7KJQtVN8ljNY0tEfy9Rae9UZ788cdYNg08tr90RaU/h8nxEcN+vyOJLROHNJ/eVQyEbXxezYm3iHhX/CXqpaX/iQuAdx9aT0CcAkJWaG18QL0X1K13l/EwcUjXEko69W/tjqJMBu8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cm/ZnJ42; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=4ZC551KYY/VIbg9NK3ODQRo8+r60/N0IS6/gca/Yq8o=; b=Cm/ZnJ42BXrFBhh4bevYsajY5l
	/KqE1y6AGa3Us2+Me3qJMX37Z9p+X9ZMBufLtID2xZn8DcbXD9690/tGTZYV5gMEoIWRki6MIl/cz
	kEdssg77hEhgFGdv1VvY4VZod8LMbGkH1mk/YJ1yoE+sbj2o/1GCf2FDdzlP5expRtDCGYvBAYi7d
	8wORYkTEYhj7y+f6XD9D3lKml66k1M/qvbVjFGHE8FnhFriEMXj6XWRPhd3tML4WhSgvlVOtonunK
	tWRKXRLTnxJVeEhtwNmpM0mX9q3mAjH4jFLoFwnk4xxZDguRumA0Ll4hPZE4U3daVBXld71szy5Mg
	S4dUuZ/w==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHLZ-00000001ede-3UGF;
	Fri, 29 Mar 2024 18:53:02 +0000
Message-ID: <9d84481e-6a21-41fa-ae7c-1a9c52fc48ad@infradead.org>
Date: Fri, 29 Mar 2024 11:53:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: workqueue: name exceeds WQ_NAME_LEN. Truncating to:
 events_freezable_power_efficien
Content-Language: en-US
To: "Artem S. Tashkinov" <aros@gmx.com>, linux-kernel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>, Audra Mitchell <audra@redhat.com>
References: <cb894653-6e20-4759-8dd1-7b03ae8614cf@gmx.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <cb894653-6e20-4759-8dd1-7b03ae8614cf@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/27/24 03:37, Artem S. Tashkinov wrote:
> Hello,
> 
> There's a new warning message in kernel 6.8 which I guess shouldn't be
> there. Linux 6.7 did not have it.
> 
> No idea where it comes from:
> 
> workqueue: name exceeds WQ_NAME_LEN. Truncating to:
> events_freezable_power_efficien
> 
> A relevant bug report: https://bugzilla.kernel.org/show_bug.cgi?id=218649
> 
> Please fix.


Tejun, should 8318d6a6362f5 be backported to 6.8? or maybe it has been already?

Also, it look like Documentation/core-api/workqueue.rst needs to be updated
with the new workqueue name. Audra?

thanks.
-- 
#Randy

