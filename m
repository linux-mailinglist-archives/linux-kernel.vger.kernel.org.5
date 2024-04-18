Return-Path: <linux-kernel+bounces-150211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3FE8A9BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA48EB240BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21491635C5;
	Thu, 18 Apr 2024 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="uCvMHtqw";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="uCvMHtqw"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188B15AAA4;
	Thu, 18 Apr 2024 13:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448485; cv=none; b=hphZctdtUlPPotSqJYxUCjn1VknNG120tPNILaX9d9tYYUGyTT03N/sUBzMTi0DqotvOE6OcmXSq3lGy3hEpyyaYst9FGS1iN5HfVjPwrJu8ze3/5ah2NWOQJOxszQkDLDL/k82O8PZgkK9gMPFmsKeDG2W3n4UYonuV6+fLU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448485; c=relaxed/simple;
	bh=d4qDJxtj0TKPWtUGjhTmuDRXiwM9jmNP0Ljg54XpF3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sr9xqKv8E1+RQps1boxweYPqNB9SjOhrZF7n7szPejLhM5/QwpV10wYxKwkkZ5tLpM6tr1BMPnPTnhlpT0uqr2kL2OdGbNSvNYdrNQQi26nrR7m1QmTYiixiHhuOEf8x3CuL5LXHcWAKkkY8nR1TMNrBxdm5AA1MYdtnXCrsHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=uCvMHtqw; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=uCvMHtqw; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1713448026; bh=d4qDJxtj0TKPWtUGjhTmuDRXiwM9jmNP0Ljg54XpF3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uCvMHtqwEOf8PCo2M08gknm7c5L8y8eo9UzDePHvd/Rt1vR1zjUDSpGfQj8S2proF
	 JOOHDuwjGUlf+otQ3hsiw2lRRPb+Z2vpqpQSHDcZsX2lgf8LhpF2tqpyeW02wgr/Hd
	 zggQgDgnU6uw9dUFHGsCezaWXxTtzw+XLxtAcTIgj8f+l0taPw5+xgqnHBuGngCg73
	 uttu9dP4Xx0j2nYuk5slhze8++ZcIBPw+HadMrH8FtdqFflqpj6UlON7Ykk0NPRiPO
	 RAL6jfhm3KP55CXAqpPLwm6/k9W1Yps1CX+4mmE7fi7hqGOBEM2UlPbYqRaEp9r/FV
	 /exwmV9lPQBww==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 937EA4677E3;
	Thu, 18 Apr 2024 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1713448026; bh=d4qDJxtj0TKPWtUGjhTmuDRXiwM9jmNP0Ljg54XpF3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uCvMHtqwEOf8PCo2M08gknm7c5L8y8eo9UzDePHvd/Rt1vR1zjUDSpGfQj8S2proF
	 JOOHDuwjGUlf+otQ3hsiw2lRRPb+Z2vpqpQSHDcZsX2lgf8LhpF2tqpyeW02wgr/Hd
	 zggQgDgnU6uw9dUFHGsCezaWXxTtzw+XLxtAcTIgj8f+l0taPw5+xgqnHBuGngCg73
	 uttu9dP4Xx0j2nYuk5slhze8++ZcIBPw+HadMrH8FtdqFflqpj6UlON7Ykk0NPRiPO
	 RAL6jfhm3KP55CXAqpPLwm6/k9W1Yps1CX+4mmE7fi7hqGOBEM2UlPbYqRaEp9r/FV
	 /exwmV9lPQBww==
Message-ID: <ca1e249b-2f2b-4936-8c88-935c3112356e@mleia.com>
Date: Thu, 18 Apr 2024 16:47:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] serial: sc16is7xx: Add bindings documentation for
 EXAR XR20M1172 UART
Content-Language: en-US
To: Konstantin <rilian.la.te@ya.ru>
Cc: Konstantin <ria.freelander@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Lech Perczak <lech.perczak@camlingroup.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org
References: <20240418132508.3447800-1-rilian.la.te@ya.ru>
 <20240418132508.3447800-3-rilian.la.te@ya.ru>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20240418132508.3447800-3-rilian.la.te@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20240418_134706_631872_0B25327F 
X-CRM114-Status: UNSURE (   8.06  )
X-CRM114-Notice: Please train this message. 

Hi Konstantin,

On 4/18/24 16:25, Konstantin wrote:
> From: Konstantin <ria.freelander@gmail.com>

please use a full name, which points to the author of the change, thank you!

> This patch adds the devicetree documentation for the XR20M1172 UART.
> 
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>

Other than that the change is good from my point of view.

Please make the requested update, add my tag below and resubmit v2 of the change.

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir

