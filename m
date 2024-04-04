Return-Path: <linux-kernel+bounces-130823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21931897D84
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB67E1F268DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B881865C;
	Thu,  4 Apr 2024 01:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="btSvpyF/"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE72318641;
	Thu,  4 Apr 2024 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712195438; cv=none; b=Ykez/mFnrt4nz5q9SN2sCzDgu76LU+GyoKAsGpqEVPTgvRd22WplTRwPXN1kZ3iUCQYImAUZ5dpjbUTHketZt+5+xiH62vgzfLpQJOQOe/i/ATwTirS9oeQUESeDsNUVG/631xajn7L9sUKmfEbwvz+1wezezPShG+eZaDOyh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712195438; c=relaxed/simple;
	bh=sMJgocwG0ejwyAHece1APU7sO/OMGd+TkWb7n4BBNGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EAxyqNv9PUmYpTxgJkzYJDNsDUfC+xI13YAhrIM/y04Hw1SWoRQBR3VOgqJ5m6+/sVtwLa/5SKba7leWA+u6Wtppyivut3+Z6gpNKHo2Nu+60pUj1URPAn6gOFEAg5J7dGs2ccOqcqcB57oEsI4yR9+miEzqKB32zBLfJcc3/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=btSvpyF/; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp118-210-182-70.adl-adc-lon-bras34.tpg.internode.on.net [118.210.182.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D9EC420172;
	Thu,  4 Apr 2024 09:50:32 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1712195434;
	bh=sMJgocwG0ejwyAHece1APU7sO/OMGd+TkWb7n4BBNGU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=btSvpyF/upHJlsVY8A2BssX/zqlj3zpfHSY1CIG5LVwOc0UpxoxWMkucfh2t3i+p8
	 E7CJivKe9hMaSPzA9E4bjWTAWDOYq+OGPU8LyUoHijDpFzfxA8P7Y7+CMRpMjF/GSx
	 N0LkeNhlDrCSC5QDz6xApCRiFWIxK7PVzLjGfqIASC56VWuxOc38lRvUfGe9wfqEeu
	 DSgVlNui06ZG43jhwOqBk39HlSEgT1rP77E6NCxV3EXvmFqgQgr3y2+oigk4Iph8vW
	 LDRZnm5zCU1GRNDVRL5hxFO9fQb1E34YVPVIHg2dhtCfhrJv0fO3dSVH2CJwlSjDoz
	 Ddefked6QnxEA==
Message-ID: <496c6b2bf10bd8a1313740cd4047a2a153c13da8.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 3/4] dt-bindings: watchdog: aspeed-wdt: Add aspeed,scu
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: PeterYin <peteryin.openbmc@gmail.com>, Rob Herring <robh@kernel.org>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter
 Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Apr 2024 12:20:32 +1030
In-Reply-To: <79b7e2ef-6f53-4642-ad3f-99b8ce780a7f@gmail.com>
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
	 <20240328022231.3649741-4-peteryin.openbmc@gmail.com>
	 <20240401135637.GA342928-robh@kernel.org>
	 <ab76b0549172cf3e33d6242fa9ea3e6a87b4a58e.camel@codeconstruct.com.au>
	 <79b7e2ef-6f53-4642-ad3f-99b8ce780a7f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-03 at 17:18 +0800, PeterYin wrote:
> Thanks, I can wait you update it and send a new version for wdt driver.

I've sent v2:


https://lore.kernel.org/linux-watchdog/20240403020439.418788-1-andrew@codec=
onstruct.com.au/

Rob's okay with it:

https://lore.kernel.org/linux-watchdog/20240403171321.GA3996007-robh@kernel=
org/

Feel free to address his comment there if you integrate it into your
series, though make sure to add his tag, keep my authorship, and append
your own S-o-b if you do.

Andrew


