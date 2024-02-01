Return-Path: <linux-kernel+bounces-47617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40EC845048
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B9F1F2604C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7193BB3A;
	Thu,  1 Feb 2024 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="J/VWbizQ"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703293B190;
	Thu,  1 Feb 2024 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761715; cv=none; b=W/xRT1vhFDjHSoCRAZSslC1SQ9kMwA4Fx27dudbGhc8W2hW5ZMMUoX5HOdyWLbghCkqyFLQos6tp+EHM9OwvKvQ3AvOhv9ufYRGtAUBltCB6RzmIOwCDhNG4IO9zCawMammOhwwgwGahDEzxmuNS7tXzGX/RT1tDjgJNv+II34c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761715; c=relaxed/simple;
	bh=0FtIyzuK90LrHgDNTnAzwgtYKH/Q96kOk6DoBZOomJI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXUp3GoU9e0sL55/Jw2JMbJJfD+to+fVrvqPW8IKdO3LEn++1tBuh9/TNxM6+osro60gfVYRxt+xuFS7QhLhYV5bCrhzPtSrjRqR4oBhE5dAnXbIzBwVl3FwbpRGUfEuyeaFDzYtPloZPi93+YOyYxOKWqnX4BFquWt9jBUjueY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=J/VWbizQ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C432E200EF;
	Thu,  1 Feb 2024 12:28:31 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706761712;
	bh=0FtIyzuK90LrHgDNTnAzwgtYKH/Q96kOk6DoBZOomJI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J/VWbizQVnvJo4YKBAP6C4YAE3lC5Tc7CqbQEaSpR2T3UuFsMKi+og2dyDM474ud4
	 GU7rztivD3/UdK1MocdzRivYUObg4+eNcm2dmtmU8hNXBIlNi0zX1fbzFxl1Sj/5k8
	 Age2WwPKvA07a3wmXpOumrhGvboQ1Rbz9VfK6FjzkfV3rMxLoX+Qj1qoAy0NmwKGI7
	 jbbSgy9n2qhEukQGy+0C6eqSTeVvkfrMsbPm4HBkIoKpdwWl6h1DE0kY3Lo3OYGXAJ
	 2CNFv1iTJ9dYNjgDuTPsnilA+NnM/81pR2yb+9Zi3w6SsZvah37NXMVxIVg66abquw
	 nYdkDJwGi+FUg==
Message-ID: <bee075bccd2b956f4f10e52b92e16b31e1fc00e0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 08/21] ARM: dts: aspeed: yosemite4: Remove space for
 adm1272 compatible
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 14:58:31 +1030
In-Reply-To: <20240131084134.328307-9-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-9-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Remove space for adm1272 compatible
>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>

Slightly surprised the original submission didn't trigger a report from
the build bots.

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

