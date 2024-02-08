Return-Path: <linux-kernel+bounces-58742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FF184EAEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44625B21951
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 21:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA04F5F3;
	Thu,  8 Feb 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="ZfWN5SAa"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2634F219;
	Thu,  8 Feb 2024 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707429264; cv=none; b=gh5zPf8u5p+O6n+QJheohe/U6sYyyC1r1sS3WrWSQDyGPIkUWyK0fBaVGuOU0/Du8aoDVNgzlQTaDbeuLgoJQJKUNmStUEQyOoAT8urLp5+4vEhatUFJfC8fomXXp3viNYOj07gYzzbwdviASdQghcL/vP6zxzDRIBcSkddd4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707429264; c=relaxed/simple;
	bh=78OlWKA8etugimLgU7LOFg8JohEzP01qVuc5Gal/3PE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ld8FZuNuRks/AAYjtYx+9epzCn6YjQpV1rE/Cu7ZFxrthKy0X1TV/YeZhuiAdO7HoqXUgwsgc3N4cTqC2/24puJbl9An4NGhFZV2TMWuYiCX7CHZaitV6pqFMVMLicQmX+zHVmSFLAhauRpQsgY192LbeP1YXJqJUiLjODuNntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ZfWN5SAa; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-175.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.175])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DA2DA200DB;
	Fri,  9 Feb 2024 05:48:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1707428937;
	bh=78OlWKA8etugimLgU7LOFg8JohEzP01qVuc5Gal/3PE=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=ZfWN5SAaLQLAwMnWoCYSgD6iqURUOgdTNIkdCkqNrx5U5B80lHFXAJIzRb+qn1jc7
	 K3rm2BEm1lTXvVe5zgsXUp3APyUZzLVm4dNJThFG2vOuksDysx5EhSIWcfZ0Ex3nTn
	 m+nm06OKO4Oa7LEInZDnLb0LT/DsdjWDQ+BzMUOsGLS7fKDk4Ps+37g2aQpNBQgD7d
	 RSiGYlsmA257KG7mh9H5TacHKhg3moWEwC/MT7Xwg7ynnMiQOrPxICLzFgXFZCC70s
	 v7kRnz+bQ1yx0A45B0n72yT2dPXPCsK5IsHdmDDciTD1+aSZDxUYLgEXUpkytrgTGK
	 btQfOFzoRcgLw==
Message-ID: <d5d488f2777b34d744d07fbd94f525ae381dca44.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/1] ARM:dts:aspeed: Initial device tree for AMD Onyx
 Platform
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Supreeth Venkatesh <supvenka@amd.com>, Supreeth Venkatesh
	 <supreeth.venkatesh@amd.com>, joel@jms.id.au, andrew@aj.id.au, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, robh+dt@kernel.org
Date: Fri, 09 Feb 2024 08:18:54 +1030
In-Reply-To: <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
References: <20240110033543.799919-1-supreeth.venkatesh@amd.com>
	 <d4fe8b55-a1ea-4ce7-89ac-ce17e8ff4e45@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 08:57 -0600, Supreeth Venkatesh wrote:
> This patch is pending for a month now.
>=20
> Can DT maintainers please help review this and provide feedback?

Joel's on leave and I'm having to manage some personal concerns as well
as other professional priorities.

I'm trying to find time to address the BMC patch backlog but it really
is a best-effort thing at the moment.

Andrew

