Return-Path: <linux-kernel+bounces-68978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 241C68582E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39E4284DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F8E130AF1;
	Fri, 16 Feb 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="V7TXH/54"
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57043687;
	Fri, 16 Feb 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101934; cv=none; b=OLsnIP/gnfq2Fo+zMHznEXMMGBGo9EYhNXWVqOESMq5fjyaPqhyp/2kknRJYASRAhsGIvdNAV6T3/bTk0iutyfiSnkUp/3A/OTvzR2bLmBOYz3NZWB4sREBW1ue/dE1GEBV3YRGnBI4Xit25eKTrDTJ+aX6B4kL4CN7eEAKNSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101934; c=relaxed/simple;
	bh=CsOn+DhgFeqCNSRreHl5oS9hryCOkL21maWnWfjiYWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA+Ic6gtaXvjkYgJVkTqxQMskUK40kGobERSkwbdLHyceb1CyWnZJp0dGBRnHB6I+/LU7SA7cZLtleIMQvPLkxmesRZgtCqiIX4jEi6aCGH7P3o+uTrwywQzzzp11g6R5m7PlpX2q3Wkaj+mairfuU6zHuWTcka0tTzy5hUVo58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=V7TXH/54; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4TbyV15ms2z681Y;
	Fri, 16 Feb 2024 17:45:29 +0100 (CET)
Received: from [10.10.15.23] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4TbyTv1h07z67p1;
	Fri, 16 Feb 2024 17:45:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1708101929;
	bh=Z0ojgdZAly+cJwqhDwzJMVcnx8Yr0Z18PaNMP45RmHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V7TXH/54ebxbS7izH3f/05iFUczZ7LrR4qYpAWGVhAnMGh1Amjz/ACzNf1j51kncU
	 qlMR1pUNoT67s3JVOHL6GAfNYA5Koz+IKQA+3lPHcsyZlaigz2IjIUpKUnLnwW8HvF
	 ZSOEKpQPJq9s9NJK5732Zs3gVNb+qVHqGesklTK8=
Message-ID: <bbab8a40-ba76-42f5-8f8f-2259ce70e14e@gaisler.com>
Date: Fri, 16 Feb 2024 17:45:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc: leon: grpci1: Use
 devm_platform_ioremap_resource() in grpci1_of_probe()
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, sparclinux@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4fc017e4-c695-40d3-aed4-cbf34d44e6fa@web.de>
 <e4585b03-3629-4bd7-a349-f5471ebd8685@web.de>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <e4585b03-3629-4bd7-a349-f5471ebd8685@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-02-06 16:40, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2024 16:30:15 +0100
> 
> A wrapper function is available since the commit 7945f929f1a77a1c8887a97ca07f87626858ff42

This line is needlessly long. Could you wrap it or shorten the SHA-1 ID?
You don't need more than the first 12 characters of the SHA-1 ID.

> ("drivers: provide devm_platform_ioremap_resource()").
> 
> * Thus reuse existing functionality instead of keeping duplicate source code.

The same goes for this one. Please keep the width of the commit
description within 75 characters.
 
> * Delete a local variable which became unnecessary with this refactoring.
> 
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Apart from that the patch looks good.

Thanks,
Andreas

