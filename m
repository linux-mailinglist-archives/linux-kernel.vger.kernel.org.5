Return-Path: <linux-kernel+bounces-163229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60288B6772
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 03:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3641C21AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 01:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D648F5C;
	Tue, 30 Apr 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="D0EyxTPc"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61348BF1;
	Tue, 30 Apr 2024 01:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440545; cv=none; b=Nx2vT6zzRQLUcXDyHqZfwtEkeJGOb5t30+hcqWvqzXjFWcv6uAByY4rG1rb8e4hQaZCIsw+uuGtJfNZdQxI+giC0k8ZfYdqirpQ1HgdzrsWV6R0NBBZpBHfR3SXRzHea8DyKYImNY1Y6VYXoYbbD/JRRR1VUxX+HidUZIb4gKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440545; c=relaxed/simple;
	bh=WSfmy11+lqUedQvW+3vlN6eQYVz87591hh4ZeujPvIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tv41A4uvxQbRj3MUokVU6dRdfxRnnS8e0nWIMmsT2CrAKX+IqPXoya0tliP6+2otkzW2n7grTGStxrbXJGen293gFByYcnlqtaBOSt57L+tT9cS5vAXWpMA22+aTJaYcPE5QrqMA8F7hGmjjx5XnswyCQxuK8b++e1kt1SusuxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=D0EyxTPc; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 51C2F200EF;
	Tue, 30 Apr 2024 09:28:58 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714440540;
	bh=Q6Ex8FW3hDftsHNtIMRsxpmNZfxAv4l73py6egD+IxQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D0EyxTPcMwYBqFmz2Na1yMb6CPy0gJyty1jVgNaxNK4sZYjbXYIlVZzUBvL0liit0
	 zHKQqPEpsninhnbtHGOQ8ETWfYMDC75bgdR4w6c/d40OZrE6FpqGENUvtXMGjDUI1Q
	 Rhut/Y4vLCCpN6TKeNxSbgGVKcTIxAlo+kw5H0imVDaZ1V0ymsXK83trB/o7A+glg7
	 EpYIt005boD7lD4PERpXCG5lkJ0K4uPTo8h0qZH5rqfinNS6Dnb3gEOBPVksPEtAq2
	 x5DRBmH2N0Pscp9pxblydCV8YTzXvRO7C1LhyqTkfrXUlHJWAluu8Hk1G3uItdcyAN
	 w65Ra0rzbQuSw==
Message-ID: <6b69a2bbfa713374e0bbd9f306ee554ee99f70d3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 openbmc@lists.ozlabs.org, kelly_hung@asus.com, Allenyy_Hsu@asus.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Rob Herring
 <robh@kernel.org>, Zev Weiss <zweiss@equinix.com>, Conor Dooley
 <conor.dooley@microchip.com>
Date: Tue, 30 Apr 2024 10:58:57 +0930
In-Reply-To: <20240326103549.2413515-2-Kelly_Hung@asus.com>
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
	 <20240326103549.2413515-2-Kelly_Hung@asus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-26 at 18:35 +0800, Kelly Hung wrote:
> Document the new compatibles used on ASUS X4TF.
>=20
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>

In addition to the concerns of others, your author email is not the
same as your SoB email. checkpatch warns:

```
WARNING: From:/Signed-off-by: email address mismatch: 'From: Kelly Hung
<ppighouse@gmail.com>' !=3D 'Signed-off-by: Kelly Hung
<Kelly_Hung@asus.com>'

total: 0 errors, 1 warnings, 7 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-
inplace.

Commit bb035db4c70a ("dt-bindings: arm: aspeed: add ASUS X4TF board")
has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.
```

Please fix this issue for both patches in the series and resend.

Thanks,

Andrew

